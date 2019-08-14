#include "compiler.hpp"
#include <vector>
#include "eval.hpp"
#include "engine.hpp"
#include "llvm/ADT/APFloat.h"
#include "llvm/ADT/STLExtras.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Type.h"
#include "llvm/IR/Verifier.h"
#include "llvm/Support/TargetSelect.h"
#include <string>
#include <map>

namespace minou {

class LLVMCompiler
{
public:
    LLVMCompiler() : builder(context) {
        module = llvm::make_unique<llvm::Module>("my thing", context);
    }

    ~LLVMCompiler() {
        module.reset();
    }

    llvm::Function* top_compile(Atom a) {
        std::vector<llvm::Type*> args;
        auto ft = llvm::FunctionType::get(llvm::Type::getInt64Ty(context), args, false);

        auto f = llvm::Function::Create(ft, llvm::Function::ExternalLinkage, "main", module.get());

        auto bb = llvm::BasicBlock::Create(context, "entry", f);
        builder.SetInsertPoint(bb);

        auto v = compile(a);
        if(! v) {
            return nullptr;
        }

        builder.CreateRet(v);

        if(llvm::verifyFunction(*f, &llvm::errs())) {
            fmt::print("failed verification\n");
        }

        return f;
    }

    std::unique_ptr<llvm::Module> get_module() {
        return std::move(module);
    }

    llvm::Value* compile(Atom a) {
        fmt::print("compiling: {}\n", a);
        switch( a.get_type() ) {
        case AtomType::Cons:
            if( !a.cons() ) {
                fmt::print("invalid list application\n");
                return nullptr;
            }
            if( a.cons()->car.get_type() == AtomType::Symbol) {
                auto sym = a.cons()->car.symbol();

                if( sym == "if") {
                    auto pred = compile(a.cons()->cdr->car);
                    if(!pred) {
                        return nullptr;
                    }
                    auto is_boolean = builder.CreateICmpNE(pred, llvm::ConstantInt::get(context, llvm::APInt(64, Atom(Boolean(false)).value)), "ifcond");

                    auto theFunc = builder.GetInsertBlock()->getParent();
                    auto thenBB = llvm::BasicBlock::Create(context, "then", theFunc);

                    auto elseBB = llvm::BasicBlock::Create(context, "else");
                    auto mergeBB = llvm::BasicBlock::Create(context, "ifcont");

                    builder.CreateCondBr(is_boolean, thenBB, elseBB);

                    builder.SetInsertPoint(thenBB);

                    auto then = compile(a.cons()->cdr->cdr->car);
                    if(!then) {
                        return nullptr;
                    }

                    builder.CreateBr(mergeBB);

                    thenBB = builder.GetInsertBlock();

                    theFunc->getBasicBlockList().push_back(elseBB);
                    builder.SetInsertPoint(elseBB);

                    auto elseV = compile(a.cons()->cdr->cdr->cdr->car);
                    if(!elseV) {
                        return nullptr;
                    }

                    builder.CreateBr(mergeBB);
                    elseBB = builder.GetInsertBlock();

                    theFunc->getBasicBlockList().push_back(mergeBB);
                    builder.SetInsertPoint(mergeBB);

                    auto pn = builder.CreatePHI(llvm::Type::getInt64Ty(context), 2, "iftmp");

                    pn->addIncoming(then, thenBB);
                    pn->addIncoming(elseV, elseBB);

                    return pn;
                }
            }
            break;
        default:
            return llvm::ConstantInt::get(context, llvm::APInt(64, a.value));
        }
        return nullptr;
    }
private:
    std::unique_ptr<llvm::Module> module;
    llvm::IRBuilder<> builder;
    llvm::LLVMContext context;
    std::map<std::string, llvm::Value*> named_values;
};

    void compile_llvm(Atom a)
    {
        llvm::InitializeNativeTarget();
        llvm::InitializeNativeTargetAsmPrinter();
        llvm::InitializeNativeTargetAsmParser();

        LLVMCompiler c;

        auto v = c.top_compile(a);

        v->print(llvm::errs());
        // v->removeFromParent();
        auto m = c.get_module();
        // delete v;
    }

    llvm::Value* logErrorV(const char *s)
    {
        return nullptr;
    }



#define TRY(x,y) auto x = y; if(is_error(x)) { return x; }

Result<std::vector<uint8_t>> apply_tailcalls(std::vector<uint8_t> &inst) {
    std::vector<uint8_t> out;
    out.reserve(inst.size());

    int pos = 0;
    for (;;) {
        auto opcode = static_cast<OpCode>(inst[pos]);
        auto opcode_len = opcode_length(opcode);

        bool copy = true;
        switch (opcode) {
        case OpCode::INVOKE: {
            auto next = static_cast<OpCode>(inst[pos+opcode_len+1]);

            if( next == OpCode::RET) {
                out.push_back(static_cast<uint8_t>(OpCode::TAILCALL));
                out.push_back(inst[pos+opcode_len]);
                pos += 1 + opcode_len;
                copy = false;
            } else if(next == OpCode::JUMP || next == OpCode::JUMP_IFNOT) {
                auto jump_pos = *(intptr_t *)&inst[pos + 1 + opcode_len + 1];
                bool still_jumping = true;
                while(still_jumping) {
                    auto cur_pos = pos+1+opcode_len+1+jump_pos - sizeof(intptr_t);
                    auto o = static_cast<OpCode>(inst[cur_pos]);
                    switch(o) {
                    case OpCode::RET:
                        out.push_back((uint8_t)OpCode::TAILCALL);
                        out.push_back(inst[pos + opcode_len]);
                        pos += 1 + opcode_len;
                        copy = false;
                        still_jumping = false;
                        break;
                    case OpCode::JUMP:
                    case OpCode::JUMP_IFNOT:
                        jump_pos = *(intptr_t*)&inst[cur_pos+1];
                        cur_pos += sizeof(intptr_t);
                        cur_pos += jump_pos;
                        break;
                    default:
                        still_jumping = false;
                    }
                }
            }
        }break;
        default:
            break;
        }
        if (copy) {
            out.push_back((uint8_t)opcode);
            for (int i = 0; i < opcode_len; ++i) {
                out.push_back(inst[pos + i + 1]);
            }

            pos += 1 + opcode_len;
        }
        if(pos >= inst.size() ) {
            break;
        }
    }

    return out;
}

struct Compiler {
    std::vector<uint8_t> buffer;

    void push_opcode(OpCode op) {
        buffer.push_back(static_cast<uint8_t>(op));
    }

    Result<std::monostate> compile(Engine *engine, Atom a, Env *env) {
        // fmt::print("compiling: {}\n", a);
        switch (a.get_type()) {
        case AtomType::Cons:
            if (!a.cons()) {
                return "invalid list application";
            }
            if (a.cons()->car.get_type() == AtomType::Symbol) {
                auto sym = a.cons()->car.symbol();

                if (sym == "if") {
                    auto len = a.cons()->cdr->length();
                    auto c = a.cons()->cdr;

                    auto p = compile(engine, car(c), env);
                    if (is_error(p)) {
                        return p;
                    }
                    push_opcode(OpCode::JUMP_IFNOT);
                    auto ejp = buffer.size();
                    push_value(0);

                    auto e = compile(engine, cadr(c), env);
                    if (is_error(e)) {
                        return e;
                    }

                    switch (len) {
                    case 2: {
                        set_value(ejp, buffer.size() - ejp);
                    } break; // no else
                    case 3: {
                        push_opcode(OpCode::JUMP);
                        auto out_jmp = buffer.size();
                        push_value(0);

                        set_value(ejp, buffer.size() - ejp);

                        auto t = compile(engine, caddr(c), env);
                        if(is_error(t)) {
                            return t;
                        }
                        set_value(out_jmp, buffer.size() - out_jmp);
                    } break; // if / else
                    default:
                        return "invalid arity for if";
                    }
                } else if(sym == "lambda") {
                    Compiler c;

                    Cons *body = engine->get_memory().alloc_cons(Symbol("begin"), a.cons()->cdr->cdr);

                    auto e = c.compile(engine, body, env);
                    if( is_error(e)) {
                        return e;
                    }
                    c.push_opcode(OpCode::RET);

                    auto buff = apply_tailcalls(c.buffer);
                    if( is_error(buff)) {
                        return get_error(buff);
                    }
                    auto bb = std::get<std::vector<uint8_t>>(buff);

                    auto l = engine->get_memory().alloc<Lambda>(a.cons()->cdr->car.cons(), body, env, std::move(bb));
                    push_value(l);

                } else if(sym == "begin") {
                    for( Cons *c = a.cons()->cdr ; c ; c = c->cdr ) {
                        auto e = compile(engine, c->car, env);
                        if( is_error(e)) {
                            return e;
                        }
                        if( c->cdr ) {
                            push_opcode(OpCode::POP);
                        }
                    }
                }
                else if(sym == "define") {
                    auto sym = a.cons()->cdr->car;
                    auto body = a.cons()->cdr->cdr->car;

                    if( sym.get_type() != AtomType::Symbol) {
                        return "must be a symbol";
                    }

                    push_value(sym);

                    auto e = compile(engine, body, env);
                    if( is_error(e)) {
                        return e;
                    }
                    push_opcode(OpCode::SET);
                }
                else {
                    std::vector<Atom> arg_list;
                    for (auto c : *a.cons()->cdr) {
                        arg_list.push_back(car(c));
                    }

                    if (arg_list.size() > 255) {
                        return "too many arguments";
                    }

                    for (auto i = arg_list.rbegin(); i != arg_list.rend();
                         ++i) {
                        auto e = compile(engine, *i, env);
                        if( is_error(e)) {
                            return e;
                        }
                    }

                    auto e = compile(engine, a.cons()->car, env);
                    if( is_error(e)) {
                        return e;
                    }

                    push_opcode(OpCode::INVOKE);
                    buffer.push_back(a.cons()->length()-1);

                }
            } else {
                std::vector<Atom> arg_list;
                for (auto c : *a.cons()->cdr) {
                    arg_list.push_back(c->car)
                    ;
                }

                for (auto i = arg_list.rbegin(); i != arg_list.rend(); ++i) {
                    auto e = compile(engine, *i, env);
                    if (is_error(e)) {
                        return e;
                    }
                }
                auto e = compile(engine, a.cons()->car, env);
                if (is_error(e)) {
                    return e;
                }

                push_opcode(OpCode::INVOKE);
                buffer.push_back(a.cons()->length() - 1);

                if (arg_list.size() > 255) {
                    return "too many arguments";
                }
            }
            break;
        case AtomType::Symbol: {
            push_value(a);
            push_opcode(OpCode::LOAD);
        } break;
        default:
            push_value(a);
        }

        return {};
    }

    void set_value(int pos, intptr_t value) {
        *((intptr_t *) (&buffer[pos])) = value;
    }

    void push_value(intptr_t i) {
        for(int i = 0 ; i < 8 ; ++i) {
            buffer.push_back(0);
        }
        *((intptr_t *)(&buffer[buffer.size() -8])) = i;
    }

    void push_value(Atom a) {
        push_opcode(OpCode::PUSH);
        auto i = buffer.size();
        for( auto i = 0 ; i < 8 ; ++i ) {
            buffer.push_back(0);
        }
        set_value( i, a.value);
    }
};

Result<std::vector<uint8_t>> compile(Engine *engine, Atom a, Env *env)
{
    Compiler c;

    fmt::print("LLVM->\n");
    compile_llvm(a);
    fmt::print("\nEND LLVM\n");

    auto e = c.compile(engine, a, env);
    if (is_error(e)) {
        return get_error(e);
    }

    return apply_tailcalls(c.buffer);
}

} // namespace minou

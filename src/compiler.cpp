#include "compiler.hpp"
#include <llvm/IRReader/IRReader.h>
#include <vector>
#include "eval.hpp"
#include "engine.hpp"
#include "kaleidoscope.h"
#include "llvm/ADT/APInt.h"
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
#include "llvm/Target/TargetMachine.h"
#include "llvm/Transforms/InstCombine/InstCombine.h"
#include "llvm/Transforms/IPO.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"
#include "llvm/Transforms/Scalar.h"
#include "llvm/Transforms/Utils.h"
#include "llvm/Transforms/Scalar/GVN.h"
#include <string>
#include <string>
#include <map>

namespace minou {

#define API __attribute__((visibility("default")))
extern "C" {
    API int64_t lambda_get_function_pointer(int64_t x)
    {
        auto y =  (int64_t)((Lambda*)x)->get_function_pointer();
        fmt::print("function pointer of {:x}: {:x}\n", (intptr_t)x, y);
        assert(y);
        return y;
    }

    API int64_t env_set(Env* env, Atom sym, Atom value) {
        env->set(sym.symbol(), value);
        fmt::print("setting {} to {:x}\n", sym, value.value);
        return sym.value;
    }

    API int64_t env_get(Env *env, Atom sym) {
        auto x = env->lookup(sym.symbol());
        if( x.has_value()) {
            fmt::print("env_get: {} = {:x}, type: {}\n", sym, x.value().value, (int)x.value().get_type());
            return x.value().value;
        }
        assert(false);
        return Atom().value;
    }

    API int64_t lambda_get_env_pointer(int64_t t) {
        auto x =  (int64_t)((Lambda*)t)->get_env();
        fmt::print("get_env_ptr = 0x{:x}\n", x);
        return x;
    }
}

static int lambdaCounter = 0;

class CompilerContext
{
public:
    CompilerContext(llvm::LLVMContext& ctx, llvm::IRBuilder<>& builder, llvm::Module*module, Engine *engine, Env *env) : builder(builder), context(ctx), module(module), engine(engine), env(env) {}

    llvm::Function* getFunction(const std::string& name) {
        return module->getFunction(name);
    }

    Result<llvm::Value*> compile(Atom a) {
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
                    if(is_error(pred)) {
                        return pred;
                    }
                    auto is_boolean = builder.CreateICmpNE(get_value(pred), constant_atom(Boolean(false)), "ifcond");

                    auto theFunc = builder.GetInsertBlock()->getParent();
                    auto thenBB = llvm::BasicBlock::Create(context, "then", theFunc);

                    auto elseBB = llvm::BasicBlock::Create(context, "else");
                    auto mergeBB = llvm::BasicBlock::Create(context, "ifcont");
                    builder.CreateCondBr(is_boolean, thenBB, elseBB);

                    builder.SetInsertPoint(thenBB);

                    auto then = compile(a.cons()->cdr->cdr->car);
                    if(is_error(then)) {
                        return then;
                    }

                    builder.CreateBr(mergeBB);

                    thenBB = builder.GetInsertBlock();

                    theFunc->getBasicBlockList().push_back(elseBB);
                    builder.SetInsertPoint(elseBB);

                    auto elseV = compile(a.cons()->cdr->cdr->cdr->car);
                    if(is_error(elseV)) {
                        return elseV;
                    }

                    builder.CreateBr(mergeBB);
                    elseBB = builder.GetInsertBlock();

                    theFunc->getBasicBlockList().push_back(mergeBB);
                    builder.SetInsertPoint(mergeBB);

                    auto pn = builder.CreatePHI(atom_type(), 2, "iftmp");

                    pn->addIncoming(get_value(then), thenBB);
                    pn->addIncoming(get_value(elseV), elseBB);

                    return pn;
                } else if(sym == "=") {
                    auto x = compile(a.cons()->cdr->car);
                    auto y = compile(a.cons()->cdr->cdr->car);
                    if( is_error(x)) {
                        return x;
                    }
                    if( is_error(y)) {
                        return y;
                    }

                    auto v = builder.CreateICmpEQ(get_value(x), get_value(y), "=");

                    auto theFunc = builder.GetInsertBlock()->getParent();
                    auto thenBB = llvm::BasicBlock::Create(context, "then", theFunc);

                    auto elseBB = llvm::BasicBlock::Create(context, "else");
                    auto mergeBB = llvm::BasicBlock::Create(context, "ifcont");

                    builder.CreateCondBr(v, thenBB, elseBB);

                    builder.SetInsertPoint(thenBB);

                    auto then = constant_atom(Boolean(true));
                    if(!then) {
                        return nullptr;
                    }

                    builder.CreateBr(mergeBB);

                    thenBB = builder.GetInsertBlock();

                    theFunc->getBasicBlockList().push_back(elseBB);
                    builder.SetInsertPoint(elseBB);

                    auto elseV = constant_atom(Boolean(false));
                    if(!elseV) {
                        return nullptr;
                    }

                    builder.CreateBr(mergeBB);
                    elseBB = builder.GetInsertBlock();

                    theFunc->getBasicBlockList().push_back(mergeBB);
                    builder.SetInsertPoint(mergeBB);

                    auto pn = builder.CreatePHI(atom_type(), 2, "iftmp");

                    pn->addIncoming(then, thenBB);
                    pn->addIncoming(elseV, elseBB);

                    return pn;
                }
                else if(sym == "+") {
                    auto x = compile(a.cons()->cdr->car);
                    auto y = compile(a.cons()->cdr->cdr->car);
                    if( is_error(x)) return x;
                    if( is_error(y)) return y;

                    auto f = getFunction("atom_to_integer");
                    if(!f) {
                        return "can't find atom_to_integer";
                    }

                    auto xx = builder.CreateCall(f, get_value(x));
                    auto yy = builder.CreateCall(f, get_value(y));

                    auto v = builder.CreateAdd(xx, yy);
                    auto vv = builder.CreateShl(v, llvm::ConstantInt::get(context, llvm::APInt( 64, 3)));
                    auto vvv = builder.CreateOr( vv, llvm::ConstantInt::get(context, llvm::APInt(64, INTEGER)));

                    return vvv;
                }
                else if( sym == "define") {
                    auto sym = a.cons()->cdr->car;

                    auto value = compile(a.cons()->cdr->cdr->car);
                    if( is_error(value)) return value;

                    auto f = module->getFunction("env_set");

                    return builder.CreateCall(f, {get_env(), constant_atom(sym), get_value(value)});
                }
                else if(sym == "begin") {
                    for( auto c : *a.cons()->cdr) {
                        auto v = compile(c->car);
                        if(is_error(v)) return v;
                        if(!c->cdr) {
                            return v;
                        }
                    }
                }
                else if(sym == "lambda") {
                    auto name = fmt::format("lambda_{}", lambdaCounter++);
                    {
                        std::vector<llvm::Type *> args(a.cons()->cdr->car.cons()->length(),
                                                       llvm::Type::getInt64Ty(context));
                        args.push_back(atom_type());

                        auto ft = llvm::FunctionType::get(
                            llvm::Type::getInt64Ty(context), args, false);
                        auto f = llvm::Function::Create(
                            ft, llvm::Function::ExternalLinkage, name, module);

                        auto bb = llvm::BasicBlock::Create(context, "entry", f);
                        llvm::IRBuilder<> cbuilder(context);

                        cbuilder.SetInsertPoint(bb);

                        Cons *c = a.cons()->cdr->car.cons();
                        std::vector<llvm::Argument*> envArgs;

                        auto it = f->args().begin();
                        it->setName("env");

                        auto envValue = it;
                        it++;

                        for (; it != f->args().end() ; ++it) {
                            it->setName(c->car.symbol().string());
                            cbuilder.CreateCall(module->getFunction("env_set"), {envValue, constant_atom(c->car), it});
                            envArgs.push_back(it);
                            c = c->cdr;
                        }
                        auto e = new Env(env);

                        fmt::print("lambda() new env is: 0x{:x}\n", (intptr_t)e);

                        CompilerContext compiler(context, cbuilder, module,
                                                 engine, e);

                        Cons* body = engine->get_memory().alloc_cons(Symbol("begin"), a.cons()->cdr->cdr);

                        auto v = compiler.compile(body);
                        if( is_error(v)) return v;
                        cbuilder.CreateRet(get_value(v));

                        if( llvm::verifyFunction(*f, &llvm::errs()) ) {
                            return "error in lambda verify";
                        }

                        auto l = engine->get_memory().alloc<Lambda>(a.cons()->cdr, a.cons()->cdr->cdr, e);
                        l->set_native_name(name);

                        fmt::print("alloacted lambda is: {:x}\n", (intptr_t)l);
                        for( auto [key, value] : compiler.get_lambdas()) {
                            lambdas[key] = value;
                        }

                        lambdas[name] = l;

                        return llvm::ConstantInt::get(context, llvm::APInt(64, Atom(l).value));
                    }

                }
                else {
                    return compile_application(a);
                }
            } else {
                return compile_application(a);
            }
            break;
        default:
            if( a.get_type() == AtomType::Symbol) {
                auto f = builder.GetInsertBlock()->getParent();

                auto lookupFunc = module->getFunction("env_get");
                if(! lookupFunc) {
                    return "can't find env_get";
                }
                return builder.CreateCall( lookupFunc, {
                        &*f->args().begin(), constant_atom(a)});
            }
            return constant_atom(a);
        }
        return "shouldn't get here";
    }

    Result<llvm::Value*> compile_application(Atom a) {
        std::vector<llvm::Value*> args;
        std::vector<llvm::Type*> funcArgs;

        auto l = compile(a.cons()->car);
        if (is_error(l))
            return l;

        auto f = module->getFunction("lambda_get_function_pointer");
        auto fp = builder.CreateCall(f, get_value(l));

        auto ep = module->getFunction("lambda_get_env_pointer");
        auto fenv = builder.CreateCall(ep, get_value(l));

        args.push_back(fenv);
        funcArgs.push_back(atom_type());

        for( auto c : *a.cons()->cdr) {
            auto v = compile(c->car);
            if( is_error(v)) {
                return v;
            }
            args.push_back(get_value(v));
            funcArgs.push_back(llvm::Type::getInt64Ty(context));
        }


        auto ll = builder.CreateIntToPtr(fp, llvm::FunctionType::get( llvm::Type::getInt64Ty(context), funcArgs, false)->getPointerTo());
        auto v = builder.CreateCall(ll, args);

        return v;
    }
    llvm::Value* get_env() {
        return builder.GetInsertBlock()->getParent()->args().begin();
    }

    llvm::Type* atom_type() {
        return llvm::Type::getInt64Ty(context);
    }

    llvm::Value* constant_atom(Atom a) {
        return llvm::ConstantInt::get(context, llvm::APInt(64, a.value));
    }

    std::map<std::string, Lambda*>& get_lambdas() { return lambdas; }
private:
  Env *env;
  Engine *engine;
  llvm::IRBuilder<> &builder;
  llvm::LLVMContext &context;
  llvm::Module *module;
  std::map<std::string, Lambda*> lambdas;
  std::map<std::string, llvm::Value *> named_values;
};

class NativeEngine
{
    llvm::LLVMContext                           context;
    std::unique_ptr<llvm::orc::KaleidoscopeJIT> jit;
    Engine *engine;
    Env * env;

    llvm::Function* get_function_pointer(llvm::Module *m) {
        auto ft =
            llvm::FunctionType::get(llvm::Type::getInt64Ty(context),
                                    llvm::Type::getInt64Ty(context), false);

        auto f = llvm::Function::Create(ft, llvm::Function::ExternalLinkage,
                                        "lambda_get_function_pointer", m);

        return f;
    }

    llvm::Function *lambda_get_env_pointer(llvm::Module *m) {
        auto ft = llvm::FunctionType::get(llvm::Type::getInt64Ty(context), 
            llvm::Type::getInt64Ty(context)
            , false);

        auto f = llvm::Function::Create(ft, llvm::Function::ExternalLinkage,
                                        "lambda_get_env_pointer", m);

        return f;
    }

    llvm::Function *env_get(llvm::Module *m) {
        auto ft = llvm::FunctionType::get(
            llvm::Type::getInt64Ty(context),
            {llvm::Type::getInt64Ty(context), llvm::Type::getInt64Ty(context)},
            false);

        auto f = llvm::Function::Create(ft, llvm::Function::ExternalLinkage,
                                        "env_get", m);

        return f;
    }

    llvm::Function *env_set(llvm::Module *m) {
        auto ft = llvm::FunctionType::get(llvm::Type::getInt64Ty(context), {
            llvm::Type::getInt64Ty(context), llvm::Type::getInt64Ty(context),
                llvm::Type::getInt64Ty(context)
            }, false);

        auto f = llvm::Function::Create(ft, llvm::Function::ExternalLinkage,
                                        "env_set", m);

        return f;
    }
    llvm::Function* atom_to_type(llvm::Module *m) {
        auto ft = llvm::FunctionType::get(llvm::Type::getInt8Ty(context), { llvm::Type::getInt64Ty(context)}, false);

        auto f = llvm::Function::Create(ft, llvm::Function::PrivateLinkage, "atom_to_type", m);

        auto bb = llvm::BasicBlock::Create(context, "entry", f);

        llvm::IRBuilder<> builder(context);
        builder.SetInsertPoint(bb);
        llvm::Value *arg = &*f->args().begin();

        auto masked = builder.CreateAnd(arg, llvm::ConstantInt::get(context, llvm::APInt(64, 3)));

        auto defCase = llvm::BasicBlock::Create(context, "default", f);
        builder.SetInsertPoint(defCase);

        // point to the heapnode start
        auto pHn = builder.CreateSub(arg, llvm::ConstantInt::get(context, llvm::APInt(64, offsetof(HeapNode, buff))), "-> heap node address");
        auto pType = builder.CreateIntToPtr(pHn, llvm::Type::getInt64Ty(context)->getPointerTo(), "(HeapNode*)");
        auto hn = builder.CreateLoad(pType, "heap node load");
        auto tt = builder.CreateAnd(hn, llvm::ConstantInt::get(context, llvm::APInt(64, 255)), "and for the type");
        auto casted = builder.CreateIntCast( tt, llvm::Type::getInt8Ty(context), false, "casted type");
        builder.CreateRet(casted) ;

        builder.SetInsertPoint(bb);
        auto sw = builder.CreateSwitch( masked, defCase);

        auto intBB = llvm::BasicBlock::Create(context, "int", f);
        builder.SetInsertPoint(intBB);
        builder.CreateRet(llvm::ConstantInt::get(context, llvm::APInt(8, (int)AtomType::Number)));

        auto boolBB = llvm::BasicBlock::Create(context, "boolean", f);
        builder.SetInsertPoint(boolBB);
        builder.CreateRet(llvm::ConstantInt::get(context, llvm::APInt(8, (int)AtomType::Boolean)));

        auto nilBB = llvm::BasicBlock::Create(context, "nil", f);
        builder.SetInsertPoint(nilBB);
        builder.CreateRet(llvm::ConstantInt::get(context, llvm::APInt(8, (int)AtomType::Nil)));

        auto symBB = llvm::BasicBlock::Create(context, "symbol", f);
        builder.SetInsertPoint(symBB);
        builder.CreateRet(llvm::ConstantInt::get(context, llvm::APInt(8, (int)AtomType::Symbol)));

        sw->addCase(llvm::ConstantInt::get(context, llvm::APInt(64, INTEGER)), intBB);
        sw->addCase(llvm::ConstantInt::get(context, llvm::APInt(64, BOOL)), boolBB);
        sw->addCase(llvm::ConstantInt::get(context, llvm::APInt(64, NIL)), nilBB);
        sw->addCase(llvm::ConstantInt::get(context, llvm::APInt(64, SYMBOL)), symBB);

        return f;
    }

    llvm::Function* atom_to_integer(llvm::Module*module) {
        auto ft = llvm::FunctionType::get(llvm::Type::getInt64Ty(context),
                                          llvm::Type::getInt64Ty(context) , false);

        auto f = llvm::Function::Create(ft, llvm::Function::PrivateLinkage, "atom_to_integer", module);
        auto bb = llvm::BasicBlock::Create(context, "entry", f);

        llvm::IRBuilder<> builder(context);
        builder.SetInsertPoint(bb) ;

        llvm::Value* out = &*f->args().begin();
        builder.CreateRet(builder.CreateLShr(out, llvm::ConstantInt::get(context, llvm::APInt(64, 3))));

        return f;
    }
public:
    Result<Atom> execute(Atom a) {
        auto module = std::make_unique<llvm::Module>("anon", context);
        module->setDataLayout(jit->getTargetMachine().createDataLayout());
        module->setTargetTriple(jit->getTargetMachine().getTargetTriple().str());

        // llvm::ModulePassManager mpm;
        llvm::legacy::PassManager mpm;
        llvm::PassManagerBuilder pmBuilder;
        pmBuilder.Inliner = llvm::createFunctionInliningPass();
        pmBuilder.OptLevel = 2;
        pmBuilder.populateModulePassManager(mpm);

        auto fpm =
            std::make_unique<llvm::legacy::FunctionPassManager>(module.get());
        fpm->add(llvm::createPromoteMemoryToRegisterPass());
        fpm->add(llvm::createInstructionCombiningPass());
        fpm->add(llvm::createReassociatePass());
        fpm->add(llvm::createGVNPass());
        fpm->add(llvm::createCFGSimplificationPass());
        fpm->doInitialization();

        std::vector<llvm::Function*> builtins;
        builtins.push_back(atom_to_integer(module.get()));
        builtins.push_back(atom_to_type(module.get()));
        builtins.push_back(get_function_pointer(module.get()));
        builtins.push_back(env_set(module.get()));
        builtins.push_back(env_get(module.get()));
        builtins.push_back(lambda_get_env_pointer(module.get()));

        for( auto f : builtins) {
            if (llvm::verifyFunction(*f, &llvm::errs())) {
                assert(false);
            }
        }

        auto ft = llvm::FunctionType::get(llvm::Type::getInt64Ty(context), {llvm::Type::getInt64Ty(context)}, false);
        auto f = llvm::Function::Create(ft, llvm::Function::ExternalLinkage, "expression", module.get());
        auto bb = llvm::BasicBlock::Create(context, "entry", f);

        llvm::IRBuilder<> builder(context);
        builder.SetInsertPoint(bb) ;

        fmt::print("main env is 0x{:x}\n", (intptr_t)env);
        CompilerContext compiler(context, builder, module.get(), engine, env);
        auto v = compiler.compile(a);
        if( is_error(v)) {
            return std::get<const Error>(v);
        }
        builder.CreateRet(get_value(v));

        fpm->run(*f);

        for( auto &F : *module.get()) {
            fpm->run(F);
        }

        mpm.run(*module.get());

        for (auto &F : *module.get()) {
            F.print(llvm::errs());
        }

        fpm->doFinalization();

        if( llvm::verifyFunction(*f, &llvm::errs()) ) {
            return "function didn't pass verify";
        }

        if( llvm::verifyModule(*module.get(), &llvm::errs()) ) {
            return "module didn't pass verification";
        }

        auto H = jit->addModule(std::move(module));

        auto s = jit->findSymbol("expression");
        auto addr = jit->findSymbol("expression").getAddress();

        if( auto err = addr.takeError()) {
            llvm::logAllUnhandledErrors(std::move(err), llvm::errs(), "error");
            return "error finding expression symbol";
        }
        for( auto& [key,value] : compiler.get_lambdas()) {
            auto x = jit->findSymbol(value->get_native_name());
            fmt::print("trying to find: {}\n", value->get_native_name());
            if( auto err = x.getAddress().takeError()) {
                return "error in finding symbol";
            }
            value->set_function_pointer((void*)(*x.getAddress()));
        }
        fmt::print("expression address: {}\n", *addr);

        Atom (*FP)(Env*) = (Atom (*)(Env*))(intptr_t)*addr;
        env->for_each([](auto key, auto value) -> void {
                          fmt::print("ENV {} = {:x}\n", key, value.value);
                      });

        auto x = FP(env);

        fmt::print("AFTER ()\n");
        env->for_each([](auto key, auto value) -> void {
                          fmt::print("ENV {} = {:x}\n", key, value.value);
                      });
        return x;
    }
    NativeEngine(Engine *engine, Env *env) : engine(engine), env(env) {
        llvm::InitializeNativeTarget();
        llvm::InitializeNativeTargetAsmPrinter();
        llvm::InitializeNativeTargetAsmParser();
        jit = std::make_unique<llvm::orc::KaleidoscopeJIT>();
    }
};


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

    NativeEngine ne(engine, env);
    auto x = ne.execute(a);
    if(is_error(x)) {
        fmt::print("ERROR: {}\n", get_error(x));
    }
    fmt::print("OK: {}\n", get_value(x));

    fmt::print("\nEND LLVM\n");

    // auto e = c.compile(engine, a, env);
    // if (is_error(e)) {
    //     return get_error(e);
    // }

    // return apply_tailcalls(c.buffer);
    return "whoops";
}

} // namespace minou

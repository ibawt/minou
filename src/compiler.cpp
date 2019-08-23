#include "compiler.hpp"
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
#include "llvm/Support/SourceMgr.h"
#include "llvm/Support/TargetSelect.h"
#include "llvm/Target/TargetMachine.h"
#include "llvm/Transforms/IPO.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"
#include "llvm/Transforms/InstCombine/InstCombine.h"
#include "llvm/Transforms/Scalar.h"
#include "llvm/Transforms/Scalar/GVN.h"
#include "llvm/Transforms/Utils.h"
#include <llvm/IRReader/IRReader.h>
#include <string>
#include <vector>
#include <map>

namespace minou {

#define API __attribute__((visibility("default")))
extern "C" {
API int64_t env_set(Env *env, Atom sym, Atom value) {
    env->set(sym.symbol(), value);
    return sym.value;
}

API int64_t env_get(Env *env, Atom sym) {
    auto x = env->lookup(sym.symbol());
    if (x.has_value()) {
        return x.value().value;
    }
    return make_nil().value;
}
}

static int lambdaCounter = 0;

class CompilerContext {
  public:
    CompilerContext(llvm::LLVMContext &ctx, llvm::IRBuilder<> &builder,
                    llvm::Module *module, Engine *engine, Env *env)
        : builder(builder), context(ctx), module(module), engine(engine),
          env(env) {}

    llvm::Function *getFunction(const std::string &name) {
        return module->getFunction(name);
    }

    Result<llvm::Value *> compile_if(Atom a) {
        auto pred = compile(a.cons()->cdr->car);
        if (is_error(pred)) {
            return pred;
        }
        auto is_boolean = builder.CreateICmpNE(
            get_value(pred), constant_atom(make_boolean(false)), "ifcond");

        auto theFunc = builder.GetInsertBlock()->getParent();
        auto thenBB = llvm::BasicBlock::Create(context, "then", theFunc);

        auto elseBB = llvm::BasicBlock::Create(context, "else");
        auto mergeBB = llvm::BasicBlock::Create(context, "ifcont");
        builder.CreateCondBr(is_boolean, thenBB, elseBB);

        builder.SetInsertPoint(thenBB);

        auto then = compile(a.cons()->cdr->cdr->car);
        if (is_error(then)) {
            return then;
        }

        builder.CreateBr(mergeBB);

        thenBB = builder.GetInsertBlock();

        theFunc->getBasicBlockList().push_back(elseBB);
        builder.SetInsertPoint(elseBB);

        auto elseV = compile(a.cons()->cdr->cdr->cdr->car);
        if (is_error(elseV)) {
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
    }

    Result<llvm::Value *> compile(Atom a) {
        fmt::print("compiling: {}\n", a);
        switch (a.get_type()) {
        case AtomType::Cons:
            if (!a.cons()) {
                return ("invalid list application\n");
            }
            if (a.cons()->car.get_type() == AtomType::Symbol) {
                auto sym = a.cons()->car.symbol();

                if (sym == "if") {
                    return compile_if(a);
                } else if (sym == "=") {
                    auto x = compile(a.cons()->cdr->car);
                    auto y = compile(a.cons()->cdr->cdr->car);
                    if (is_error(x)) {
                        return x;
                    }
                    if (is_error(y)) {
                        return y;
                    }

                    auto v =
                        builder.CreateICmpEQ(get_value(x), get_value(y), "=");

                    auto theFunc = builder.GetInsertBlock()->getParent();
                    auto thenBB =
                        llvm::BasicBlock::Create(context, "then", theFunc);

                    auto elseBB = llvm::BasicBlock::Create(context, "else");
                    auto mergeBB = llvm::BasicBlock::Create(context, "ifcont");

                    builder.CreateCondBr(v, thenBB, elseBB);

                    builder.SetInsertPoint(thenBB);

                    auto then = constant_atom(make_boolean(true));
                    builder.CreateBr(mergeBB);

                    thenBB = builder.GetInsertBlock();

                    theFunc->getBasicBlockList().push_back(elseBB);
                    builder.SetInsertPoint(elseBB);

                    auto elseV = constant_atom(make_boolean(false));

                    builder.CreateBr(mergeBB);
                    elseBB = builder.GetInsertBlock();

                    theFunc->getBasicBlockList().push_back(mergeBB);
                    builder.SetInsertPoint(mergeBB);

                    auto pn = builder.CreatePHI(atom_type(), 2, "iftmp");

                    pn->addIncoming(then, thenBB);
                    pn->addIncoming(elseV, elseBB);

                    return pn;
                } else if (sym == "+") {
                    auto x = compile(a.cons()->cdr->car);
                    auto y = compile(a.cons()->cdr->cdr->car);
                    if (is_error(x))
                        return x;
                    if (is_error(y))
                        return y;

                    auto f = getFunction("atom_to_integer");
                    if (!f) {
                        return "can't find atom_to_integer";
                    }

                    auto xx = builder.CreateCall(f, get_value(x));
                    auto yy = builder.CreateCall(f, get_value(y));

                    auto v = builder.CreateAdd(xx, yy);
                    auto vv = builder.CreateShl(
                        v, llvm::ConstantInt::get(context, llvm::APInt(64, 3)));
                    auto vvv = builder.CreateOr(
                        vv, llvm::ConstantInt::get(context,
                                                   llvm::APInt(64, INTEGER)));

                    return vvv;
                } else if (sym == "-") {
                    if (a.cons()->cdr->length() == 1) {
                        auto x = compile(a.cons()->cdr->car);
                        if (is_error(x)) {
                            return x;
                        }

                        auto f = getFunction("atom_to_integer");
                        auto xx = builder.CreateCall(f, get_value(x));
                        auto v = builder.CreateNeg(xx);
                        auto vv = builder.CreateShl(
                            v, llvm::ConstantInt::get(context,
                                                      llvm::APInt(64, 3)));
                        auto vvv = builder.CreateOr(
                            vv, llvm::ConstantInt::get(
                                    context, llvm::APInt(64, INTEGER)));
                        return vvv;
                    } else {
                        auto x = compile(a.cons()->cdr->car);
                        auto y = compile(a.cons()->cdr->cdr->car);
                        if (is_error(x))
                            return x;
                        if (is_error(y))
                            return y;

                        auto f = getFunction("atom_to_integer");
                        if (!f) {
                            return "can't find atom_to_integer";
                        }

                        auto xx = builder.CreateCall(f, get_value(x));
                        auto yy = builder.CreateCall(f, get_value(y));

                        auto v = builder.CreateSub(xx, yy);
                        auto vv = builder.CreateShl(
                            v, llvm::ConstantInt::get(context,
                                                      llvm::APInt(64, 3)));
                        auto vvv = builder.CreateOr(
                            vv, llvm::ConstantInt::get(
                                    context, llvm::APInt(64, INTEGER)));

                        return vvv;
                    }
                } else if (sym == "quote") {
                    if (a.cons()->length() != 2) {
                        return "invalid quote length";
                    }
                    return constant_atom(a.cons()->cdr->car);
                } else if (sym == "define" || sym == "set!") {
                    auto sym = a.cons()->cdr->car;

                    auto value = compile(a.cons()->cdr->cdr->car);
                    if (is_error(value))
                        return value;

                    auto f = module->getFunction("env_set");

                    return builder.CreateCall(
                        f, {get_env(), constant_atom(sym), get_value(value)});
                } else if (sym == "begin") {
                    for (auto c : *a.cons()->cdr) {
                        auto v = compile(c->car);
                        if (is_error(v))
                            return v;
                        if (!c->cdr) {
                            return v;
                        }
                    }
                    return constant_atom(make_nil());
                } else if (sym == "lambda") {
                    return compile_lambda(a);
                } else {
                    return compile_application(a);
                }
            } else {
                return compile_application(a);
            }
            break;
        default:
            if (a.get_type() == AtomType::Symbol) {
                bool is_closure = true;

                auto f = builder.GetInsertBlock()->getParent();
                if( lambda ) {
                    for( auto & arg : *lambda->arguments) {
                        if( arg.symbol == a.symbol() )  {
                            is_closure = arg.is_closed_over;
                            break;
                        }
                    }
                }

                if( is_closure ) {
                    auto lookupFunc = module->getFunction("env_get");
                    if (!lookupFunc) {
                        return "can't find env_get";
                    }
                    return builder.CreateCall(
                        lookupFunc, {f->args().begin(), constant_atom(a)});
                } else {
                    for( auto& arg : f->args()) {
                        if(arg.getName() == a.symbol().string()) {
                            return &arg;
                        }
                    }
                    return "can't find the function argument :(";
                }
            }
            return constant_atom(a);
        }
        return "shouldn't get here";
    }

    Result<llvm::Value *> compile_lambda(Atom a) {
        auto name = fmt::format("lambda_{}", lambdaCounter++);
        std::vector<llvm::Type *> args(a.cons()->cdr->car.cons()->length(),
                                       llvm::Type::getInt64Ty(context));
        args.push_back(atom_type());

        auto ft = llvm::FunctionType::get(llvm::Type::getInt64Ty(context), args,
                                          false);
        auto f = llvm::Function::Create(ft, llvm::Function::ExternalLinkage,
                                        name, module);

        f->setCallingConv(llvm::CallingConv::Fast);

        auto bb = llvm::BasicBlock::Create(context, "entry", f);
        llvm::IRBuilder<> cbuilder(context);

        cbuilder.SetInsertPoint(bb);

        auto e = engine->get_memory().alloc_env(env);

        auto l = engine->get_memory().alloc_lambda(a.cons()->cdr->car.cons(),
                                                   a.cons()->cdr->cdr, e);
        l->native_name = new std::string(name);

        CompilerContext compiler(context, cbuilder, module, engine, e);
        compiler.lambda = l;

        Cons *body = engine->get_memory().alloc_cons(
            make_symbol(Symbol::from("begin")), a.cons()->cdr->cdr);

        auto syms = extract_symbols(make_cons(body), *l->arguments);
        for (auto s : syms) {
            for (auto &a : *l->arguments) {
                if (a.symbol == s) {
                    a.is_closed_over = true;
                    break;
                }
            }
        }
        Cons *c = a.cons()->cdr->car.cons();

        auto it = f->args().begin();
        it->setName("env");

        auto envValue = it++;


        for (; it != f->args().end(); ++it) {
            it->setName(c->car.symbol().string());
            for( auto& arg : *l->arguments ) {
                if( arg.symbol == c->car.symbol() && arg.is_closed_over) {
                    cbuilder.CreateCall(module->getFunction("env_set"),
                                        {envValue, constant_atom(c->car), it});
                }
            }
            c = c->cdr;
        }

        auto v = compiler.compile(make_cons(body));
        if (is_error(v))
            return v;
        cbuilder.CreateRet(get_value(v));

        if (llvm::verifyFunction(*f, &llvm::errs())) {
            return "error in lambda verify";
        }

        for (auto [key, value] : compiler.get_lambdas()) {
            lambdas[key] = value;
        }

        lambdas[name] = l;

        return constant_atom(make_lambda(l));
    }

    // TODO: optimize this >.>
    std::vector<Symbol> extract_symbols(Atom a, std::vector<Argument>& args) {
        std::vector<Symbol> syms;

        switch (a.get_type()) {
        case AtomType::Cons:
            if( a.cons()->length() == 0) {
                return syms;
            }

            if( a.cons()->car == make_symbol(Symbol::from("lambda"))) {
                auto newArgs = make_arguments(a.cons()->cdr->car.cons());

                auto e = extract_symbols(make_cons(a.cons()->cdr->cdr), *newArgs);
                for (auto x : e) {
                    syms.push_back(x);
                }
                delete newArgs;
            } else {
                for (auto c : *a.cons()) {
                    auto e = extract_symbols(c->car, args);
                    for (auto x : e) {
                        syms.push_back(x);
                    }
                }
            }
            break;
        case AtomType::Symbol: {
            bool found = false;
            for( auto& arg : args ) {
                if( arg.symbol ==  a.symbol()) {
                    found = true;
                    break;
                }
            }
            if(!found)
                syms.push_back(a.symbol());
        } break;
        default:
            break;
        }
        return syms;
    }

    Result<llvm::Value *> compile_application(Atom a) {
        std::vector<llvm::Value *> args;
        std::vector<llvm::Type *> funcArgs;

        auto l = compile(a.cons()->car);
        if (is_error(l))
            return l;

        auto f = module->getFunction("lambda_get_function_pointer");
        auto fp = builder.CreateCall(f, get_value(l));

        auto ep = module->getFunction("lambda_get_env_pointer");
        auto fenv = builder.CreateCall(ep, get_value(l));

        args.push_back(fenv);
        funcArgs.push_back(atom_type());

        for (auto c : *a.cons()->cdr) {
            auto v = compile(c->car);
            if (is_error(v)) {
                return v;
            }
            args.push_back(get_value(v));
            funcArgs.push_back(llvm::Type::getInt64Ty(context));
        }

        auto ll = builder.CreateIntToPtr(
            fp, llvm::FunctionType::get(llvm::Type::getInt64Ty(context),
                                        funcArgs, false)
                    ->getPointerTo());
        auto v = builder.CreateCall(ll, args);
        v->setCallingConv(llvm::CallingConv::Fast);

        return v;
    }

    llvm::Value *get_env() {
        return builder.GetInsertBlock()->getParent()->args().begin();
    }

    llvm::Type *atom_type() { return llvm::Type::getInt64Ty(context); }

    llvm::Value *constant_atom(Atom a) {
        return llvm::ConstantInt::get(context, llvm::APInt(64, a.value));
    }

    std::map<std::string, Lambda *> &get_lambdas() { return lambdas; }

  private:
    Lambda *lambda = nullptr;
    CompilerContext *parent;
    Env *env;
    Engine *engine;
    llvm::IRBuilder<> &builder;
    llvm::LLVMContext &context;
    llvm::Module *module;
    std::map<std::string, Lambda *> lambdas;
    std::map<std::string, llvm::Value *> named_values;
};

static llvm::Function *get_function_pointer(llvm::Module *m) {
    auto ft =
        llvm::FunctionType::get(llvm::Type::getInt64Ty(m->getContext()),
                                llvm::Type::getInt64Ty(m->getContext()), false);

    auto f = llvm::Function::Create(ft, llvm::Function::ExternalLinkage,
                                    "lambda_get_function_pointer", m);

    llvm::IRBuilder<> builder(m->getContext());
    auto bb = llvm::BasicBlock::Create(m->getContext(), "entry", f);
    builder.SetInsertPoint(bb);

    auto i = builder.CreateAdd(
        f->args().begin(),
        llvm::ConstantInt::get(
            m->getContext(),
            llvm::APInt(64, offsetof(Lambda, function_pointer))));

    auto ii =
        builder.CreateIntToPtr(i, llvm::Type::getInt64PtrTy(m->getContext()));

    auto iii = builder.CreateLoad(ii);

    builder.CreateRet(iii);

    return f;
}

static llvm::Function *lambda_get_env_pointer(llvm::Module *m) {
    auto ft =
        llvm::FunctionType::get(llvm::Type::getInt64Ty(m->getContext()),
                                llvm::Type::getInt64Ty(m->getContext()), false);

    auto f = llvm::Function::Create(ft, llvm::Function::ExternalLinkage,
                                    "lambda_get_env_pointer", m);

    // f->setCallingConv(llvm::CallingConv::Fast);
    llvm::IRBuilder<> builder(m->getContext());
    auto bb = llvm::BasicBlock::Create(m->getContext(), "entry", f);
    builder.SetInsertPoint(bb);

    auto i = builder.CreateAdd(
        f->args().begin(),
        llvm::ConstantInt::get(m->getContext(),
                               llvm::APInt(64, offsetof(Lambda, env))));

    auto ii =
        builder.CreateIntToPtr(i, llvm::Type::getInt64PtrTy(m->getContext()));

    auto iii = builder.CreateLoad(ii);

    builder.CreateRet(iii);

    return f;
}

static llvm::Function *env_get(llvm::Module *m) {
    auto &context = m->getContext();
    auto ft = llvm::FunctionType::get(
        llvm::Type::getInt64Ty(context),
        {llvm::Type::getInt64Ty(context), llvm::Type::getInt64Ty(context)},
        false);

    auto f = llvm::Function::Create(ft, llvm::Function::ExternalLinkage,
                                    "env_get", m);

    return f;
}

static llvm::Function *env_set(llvm::Module *m) {
    auto &context = m->getContext();
    auto ft = llvm::FunctionType::get(llvm::Type::getInt64Ty(context),
                                      {llvm::Type::getInt64Ty(context),
                                       llvm::Type::getInt64Ty(context),
                                       llvm::Type::getInt64Ty(context)},
                                      false);

    auto f = llvm::Function::Create(ft, llvm::Function::ExternalLinkage,
                                    "env_set", m);

    return f;
}
static llvm::Function *atom_to_type(llvm::Module *m) {
    auto &context = m->getContext();
    auto ft = llvm::FunctionType::get(llvm::Type::getInt8Ty(context),
                                      {llvm::Type::getInt64Ty(context)}, false);

    auto f = llvm::Function::Create(ft, llvm::Function::PrivateLinkage,
                                    "atom_to_type", m);

    // f->setCallingConv(llvm::CallingConv::Fast);
    auto bb = llvm::BasicBlock::Create(context, "entry", f);

    llvm::IRBuilder<> builder(context);
    builder.SetInsertPoint(bb);
    llvm::Value *arg = &*f->args().begin();

    auto masked = builder.CreateAnd(
        arg, llvm::ConstantInt::get(context, llvm::APInt(64, 3)));

    auto defCase = llvm::BasicBlock::Create(context, "default", f);
    builder.SetInsertPoint(defCase);

    // point to the heapnode start
    auto pHn = builder.CreateSub(
        arg,
        llvm::ConstantInt::get(context,
                               llvm::APInt(64, offsetof(HeapNode, buff))),
        "-> heap node address");
    auto pType = builder.CreateIntToPtr(
        pHn, llvm::Type::getInt64Ty(context)->getPointerTo(), "(HeapNode*)");
    auto hn = builder.CreateLoad(pType, "heap node load");
    auto tt = builder.CreateAnd(
        hn, llvm::ConstantInt::get(context, llvm::APInt(64, 255)),
        "and for the type");
    auto casted = builder.CreateIntCast(tt, llvm::Type::getInt8Ty(context),
                                        false, "casted type");
    builder.CreateRet(casted);

    builder.SetInsertPoint(bb);
    auto sw = builder.CreateSwitch(masked, defCase);

    auto intBB = llvm::BasicBlock::Create(context, "int", f);
    builder.SetInsertPoint(intBB);
    builder.CreateRet(
        llvm::ConstantInt::get(context, llvm::APInt(8, (int)AtomType::Number)));

    auto boolBB = llvm::BasicBlock::Create(context, "boolean", f);
    builder.SetInsertPoint(boolBB);
    builder.CreateRet(llvm::ConstantInt::get(
        context, llvm::APInt(8, (int)AtomType::Boolean)));

    auto nilBB = llvm::BasicBlock::Create(context, "nil", f);
    builder.SetInsertPoint(nilBB);
    builder.CreateRet(
        llvm::ConstantInt::get(context, llvm::APInt(8, (int)AtomType::Nil)));

    auto symBB = llvm::BasicBlock::Create(context, "symbol", f);
    builder.SetInsertPoint(symBB);
    builder.CreateRet(
        llvm::ConstantInt::get(context, llvm::APInt(8, (int)AtomType::Symbol)));

    sw->addCase(llvm::ConstantInt::get(context, llvm::APInt(64, INTEGER)),
                intBB);
    sw->addCase(llvm::ConstantInt::get(context, llvm::APInt(64, BOOL)), boolBB);
    sw->addCase(llvm::ConstantInt::get(context, llvm::APInt(64, NIL)), nilBB);
    sw->addCase(llvm::ConstantInt::get(context, llvm::APInt(64, SYMBOL)),
                symBB);

    return f;
}

static llvm::Function *atom_to_integer(llvm::Module *module) {
    auto &context = module->getContext();
    auto ft = llvm::FunctionType::get(llvm::Type::getInt64Ty(context),
                                      llvm::Type::getInt64Ty(context), false);

    auto f = llvm::Function::Create(ft, llvm::Function::PrivateLinkage,
                                    "atom_to_integer", module);
    auto bb = llvm::BasicBlock::Create(context, "entry", f);

    // f->setCallingConv(llvm::CallingConv::Fast);

    llvm::IRBuilder<> builder(context);
    builder.SetInsertPoint(bb);

    llvm::Value *out = f->args().begin();
    builder.CreateRet(builder.CreateLShr(
        out, llvm::ConstantInt::get(context, llvm::APInt(64, 3))));

    return f;
}

Result<Atom> NativeEngine::execute(Atom a) {
    auto module = std::make_unique<llvm::Module>("anon", context);
    module->setDataLayout(jit->getTargetMachine().createDataLayout());
    module->setTargetTriple(jit->getTargetMachine().getTargetTriple().str());

    llvm::legacy::PassManager mpm;
    llvm::PassManagerBuilder pmBuilder;
    pmBuilder.Inliner = llvm::createFunctionInliningPass();
    pmBuilder.OptLevel = 2;
    pmBuilder.populateModulePassManager(mpm);

    auto fpm =
        std::make_unique<llvm::legacy::FunctionPassManager>(module.get());
    fpm->add(llvm::createTailCallEliminationPass());
    fpm->add(llvm::createPromoteMemoryToRegisterPass());
    fpm->add(llvm::createInstructionCombiningPass());
    fpm->add(llvm::createReassociatePass());
    fpm->add(llvm::createGVNPass());
    fpm->add(llvm::createCFGSimplificationPass());
    fpm->doInitialization();

    std::vector<llvm::Function *> builtins;
    builtins.push_back(atom_to_integer(module.get()));
    builtins.push_back(atom_to_type(module.get()));
    builtins.push_back(get_function_pointer(module.get()));
    builtins.push_back(env_set(module.get()));
    builtins.push_back(env_get(module.get()));
    builtins.push_back(lambda_get_env_pointer(module.get()));

    for (auto f : builtins) {
        if (llvm::verifyFunction(*f, &llvm::errs())) {
            assert(false);
        }
    }

    auto ft = llvm::FunctionType::get(llvm::Type::getInt64Ty(context),
                                      {llvm::Type::getInt64Ty(context)}, false);
    auto f = llvm::Function::Create(ft, llvm::Function::ExternalLinkage,
                                    "expression", module.get());
    auto bb = llvm::BasicBlock::Create(context, "entry", f);

    llvm::IRBuilder<> builder(context);
    builder.SetInsertPoint(bb);

    CompilerContext compiler(context, builder, module.get(), engine, env);
    auto v = compiler.compile(a);
    if (is_error(v)) {
        return get_error(v);
    }
    builder.CreateRet(get_value(v));

    fpm->run(*f);

    for (auto &F : *module.get()) {
        fpm->run(F);
    }

    mpm.run(*module.get());

    // for (auto &F : *module.get()) {
    //     F.print(llvm::errs());
    // }

    fpm->doFinalization();

    if (llvm::verifyFunction(*f, &llvm::errs())) {
        return "function didn't pass verify";
    }

    if (llvm::verifyModule(*module.get(), &llvm::errs())) {
        return "module didn't pass verification";
    }

    auto H = jit->addModule(std::move(module));

    auto s = jit->findSymbol("expression");
    auto addr = jit->findSymbol("expression").getAddress();

    if (auto err = addr.takeError()) {
        llvm::logAllUnhandledErrors(std::move(err), llvm::errs(), "error");
        return "error finding expression symbol";
    }
    for (auto &[key, value] : compiler.get_lambdas()) {
        auto x = jit->findSymbol(*value->native_name);
        if (auto err = x.getAddress().takeError()) {
            return "error in finding symbol";
        }
        value->function_pointer = reinterpret_cast<void *>(*x.getAddress());
    }

    Atom (*FP)(Env *) = (Atom(*)(Env *))(intptr_t)*addr;

    auto x = FP(env);

    return x;
}

} // namespace minou

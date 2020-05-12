#ifndef COMPILER_H_
#define COMPILER_H_

#include "types.hpp"
#include "env.hpp"
#include "llvm/Support/TargetSelect.h"
#include "jit.h"

namespace minou {

class Engine;

class NativeEngine
{
    std::unique_ptr<llvm::orc::KaleidoscopeJIT2> jit;
    Engine *engine;
    Env    *env;
    llvm::LLVMContext& getContext() { return jit->getContext(); }

    llvm::GlobalVariable *my_exception = nullptr;

public:
    NativeEngine(Engine *engine, Env* env) : engine(engine), env(env) {
        llvm::InitializeNativeTarget();
        llvm::InitializeNativeTargetAsmPrinter();
        llvm::InitializeNativeTargetAsmParser();
        jit = cantFail(llvm::orc::KaleidoscopeJIT2::Create()) ;
    }
    Result<Atom> execute(Atom);

};
}

#endif

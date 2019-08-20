#ifndef COMPILER_H_
#define COMPILER_H_

#include "base.hpp"
#include "types.hpp"
#include "env.hpp"
#include "kaleidoscope.h"
#include "llvm/Support/TargetSelect.h"

namespace minou {

class NativeEngine
{
    llvm::LLVMContext                           context;
    std::unique_ptr<llvm::orc::KaleidoscopeJIT> jit;
    Engine *engine;
    Env * env;

public:
    NativeEngine(Engine *engine, Env* env) : engine(engine), env(env) {
        llvm::InitializeNativeTarget();
        llvm::InitializeNativeTargetAsmPrinter();
        llvm::InitializeNativeTargetAsmParser();
        jit = std::make_unique<llvm::orc::KaleidoscopeJIT>();
    }
    Result<Atom> execute(Atom);

};
}

#endif

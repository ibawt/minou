#ifndef JIT_H_
#define JIT_H_

#include "llvm/ADT/StringRef.h"

#include "llvm/ExecutionEngine/JITSymbol.h"
#include "llvm/ExecutionEngine/Orc/CompileOnDemandLayer.h"
#include "llvm/ExecutionEngine/Orc/CompileUtils.h"
#include "llvm/ExecutionEngine/Orc/Core.h"
#include "llvm/ExecutionEngine/Orc/ExecutionUtils.h"
#include "llvm/ExecutionEngine/Orc/IRCompileLayer.h"
#include "llvm/ExecutionEngine/Orc/IRTransformLayer.h"
#include "llvm/ExecutionEngine/Orc/IndirectionUtils.h"
#include "llvm/ExecutionEngine/Orc/JITTargetMachineBuilder.h"
#include "llvm/ExecutionEngine/Orc/LazyReexports.h"
#include "llvm/ExecutionEngine/Orc/RTDyldObjectLinkingLayer.h"


#include "llvm/ExecutionEngine/SectionMemoryManager.h"
#include "llvm/IR/DataLayout.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Transforms/InstCombine/InstCombine.h"
#include "llvm/Transforms/Scalar.h"
#include "llvm/Transforms/Scalar/GVN.h"
#include <memory>

namespace llvm {
namespace orc {
class KaleidoscopeJIT2 {
private:
  ExecutionSession ES;
  std::unique_ptr<LazyCallThroughManager> LCTM;
  RTDyldObjectLinkingLayer ObjectLayer;
  IRCompileLayer CompileLayer;
  IRTransformLayer OptimizeIRLayer;
  CompileOnDemandLayer CODLayer;
  DataLayout DL;
  MangleAndInterner Mangle;
  ThreadSafeContext Ctx;

public:
  KaleidoscopeJIT2(JITTargetMachineBuilder JTMB, DataLayout DL, Triple T)
      : LCTM(cantFail(createLocalLazyCallThroughManager(JTMB.getTargetTriple(),
                                                        this->ES, 0))),
        ObjectLayer(ES,
                    []() { return std::make_unique<SectionMemoryManager>(); }),
        CompileLayer(ES, ObjectLayer, std::make_unique<ConcurrentIRCompiler>(std::move(JTMB))),
        OptimizeIRLayer(ES,CompileLayer,optimizeModule),
        CODLayer(this->ES, OptimizeIRLayer, *LCTM,
                 createLocalIndirectStubsManagerBuilder(T)),
        DL(std::move(DL)), Mangle(ES, this->DL),
        Ctx(std::make_unique<LLVMContext>()) {
      ES.createJITDylib("main.lib").addGenerator(
          cantFail(DynamicLibrarySearchGenerator::GetForCurrentProcess(
              DL.getGlobalPrefix())));
  }

  static Expected<std::unique_ptr<KaleidoscopeJIT2>> Create() {
    auto JTMB = JITTargetMachineBuilder::detectHost();

    if (!JTMB)
      return JTMB.takeError();

    auto DL = JTMB->getDefaultDataLayoutForTarget();
    if (!DL)
      return DL.takeError();

    auto T = JTMB->getTargetTriple();
    return std::make_unique<KaleidoscopeJIT2>(std::move(*JTMB), std::move(*DL),
                                              std::move(T));
  }

  const DataLayout &getDataLayout() const { return DL; }

  LLVMContext &getContext() { return *Ctx.getContext(); }

  Error addModule(std::unique_ptr<Module> M) {
      auto m = ES.getJITDylibByName("main.lib");
      return CODLayer.add(*m,
                        ThreadSafeModule(std::move(M), Ctx));
  }

  Expected<JITEvaluatedSymbol> lookup(StringRef Name) {
      auto m = ES.getJITDylibByName("main.lib");
      return ES.lookup({m}, Mangle(Name.str()));
  }

  void dumpState() { ES.dump(llvm::errs()); }

  private:
    static Expected<ThreadSafeModule>
    optimizeModule(ThreadSafeModule TSM,
                   const MaterializationResponsibility &R) {
        // Create a Legacy function pass manager.
        TSM.withModuleDo([&](Module& m) {
            auto FPM =
                std::make_unique<legacy::FunctionPassManager>(&m);

            // Add some optimizations.
            FPM->add(createInstructionCombiningPass());
            FPM->add(createCFGSimplificationPass());
            FPM->doInitialization();

            // Run the optimizations over functions that are packed up by COD
            // and added to OptimizeIRLayer
            for (auto &F : m)
                FPM->run(F);
            llvm::errs() << m;
        });
        return std::move(TSM);
    }
};
} // namespace orc
} // namespace llvm

#endif

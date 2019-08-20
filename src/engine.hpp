#ifndef ENGINE_H_
#define ENGINE_H_

#include "env.hpp"
#include "eval.hpp"
#include "compiler.hpp"
#include "symbol_intern.hpp"
#include "memory.hpp"
#include <string>

namespace minou {

class Engine {
  public:
    Engine() : nativeEngine(this, global.get()) {}
    ~Engine() {
        global->clear();
        memory.mark_and_sweep(global.get());
    }
    Result<Atom> eval(const std::string_view &s);
    Result<Atom> eval(const char *s) { return eval(std::string_view(s)); }
    Result<Atom> parse(const std::string_view&s);

    // const SymbolInterner &get_interner() const { return syms; }
    SymbolInterner &get_interner() { return syms; }

    void gc() { memory.mark_and_sweep(global.get()); }
    Memory &get_memory() { return memory; }

    Env* get_env() {
        return global.get();
    }

  private:
    SymbolInterner syms;
    Memory memory;
    std::unique_ptr<Env> global = std::make_unique<Env>(this);

    NativeEngine nativeEngine;
};

} // namespace minou

#endif

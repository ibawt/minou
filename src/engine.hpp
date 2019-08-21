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
    Engine() : global(this), nativeEngine(this, &global) {}
    ~Engine() {
        memory.mark_and_sweep(&global);
    }
    Result<Atom> eval(const std::string_view &s);
    Result<Atom> eval(const char *s) { return eval(std::string_view(s)); }
    Result<Atom> parse(const std::string_view&s);

    // const SymbolInterner &get_interner() const { return syms; }
    SymbolInterner &get_interner() { return syms; }

    void gc() { memory.mark_and_sweep(&global); }
    Memory &get_memory() { return memory; }

    Env* get_env() {
        return &global;
    }

  private:
    SymbolInterner syms;
    Memory memory;
    Env global;

    NativeEngine nativeEngine;
};

} // namespace minou

#endif

#ifndef ENGINE_H_
#define ENGINE_H_

#include "compiler.hpp"
#include "env.hpp"
#include "memory.hpp"
#include "symbol_intern.hpp"
#include <string>

namespace minou {

class Engine {
  public:
    Engine() : native_engine(this, &global) {}
    ~Engine() { memory.mark_and_sweep(&global); }
    Result<Atom> eval(const std::string_view &s);
    Result<Atom> eval(const char *s) { return eval(std::string_view(s)); }
    Result<Atom> parse(const std::string_view &s);

    // const SymbolInterner &get_interner() const { return syms; }
    SymbolInterner &get_interner() { return syms; }

    void gc() { memory.mark_and_sweep(&global); }
    Memory &get_memory() { return memory; }

    Env *get_env() { return &global; }

  private:
    SymbolInterner syms;
    Memory memory;
    Env global;

    NativeEngine native_engine;
};

} // namespace minou

#endif

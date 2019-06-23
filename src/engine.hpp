#ifndef ENGINE_H_
#define ENGINE_H_

#include "env.hpp"
#include "eval.hpp"
#include "symbol_intern.hpp"
#include "memory.hpp"
#include <string>

namespace minou {

class Engine {
  public:
    Engine() { global = std::make_unique<Env>(this); }
    ~Engine() {
        global->clear();
        memory.mark_and_sweep(global.get());
    }
    EvalResult eval(const std::string_view &s);
    EvalResult eval(const char *s) { return eval(std::string_view(s)); }

    // const SymbolInterner &get_interner() const { return syms; }
    SymbolInterner &get_interner() { return syms; }

    void gc() { memory.mark_and_sweep(global.get()); }
    Memory &get_memory() { return memory; }

  private:
    SymbolInterner syms;
    Memory memory;
    std::unique_ptr<Env> global;
};

} // namespace minou

#endif

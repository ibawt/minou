#ifndef ENGINE_H_
#define ENGINE_H_

#include "env.hpp"
#include "memory.hpp"
#include "eval.hpp"

namespace minou {

class Engine
{
public:
    Engine() : global(std::make_shared<Env>()) {}
    ~Engine() {
        global->clear();
        memory.mark_and_sweep(global);
    }
    EvalResult eval(const std::string_view& s);
    EvalResult eval(const char *s) { return eval(std::string_view(s)); }

    void gc() { memory.mark_and_sweep(global); }
    Memory& get_memory() { return memory; }
private:
    Memory  memory;
    std::shared_ptr<Env>     global;
};

}

#endif


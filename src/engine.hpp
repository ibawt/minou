#ifndef ENGINE_H_
#define ENGINE_H_

#include "env.hpp"
#include "memory.hpp"
#include "eval.hpp"

namespace minou {

class Engine
{
public:
    EvalResult eval(const std::string& s);
    EvalResult eval(const char *s) { return eval(std::string(s)); }

    Memory& get_memory() { return memory; }
private:
    Memory  memory;
    Env     global;
};

}

#endif


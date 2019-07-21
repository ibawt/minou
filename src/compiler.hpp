#include <vector>
#ifndef COMPILER_H_
#define COMPILER_H_

#include "base.hpp"
#include "types.hpp"
#include "bytecode.hpp"
#include "env.hpp"

namespace minou {

Result<std::vector<uint8_t>> compile(Engine *engine, Atom a, Env *env);

Atom pop(const uint8_t *s);
void push(Atom a, uint8_t*);
}

#endif

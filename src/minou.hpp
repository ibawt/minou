#ifndef MINOU_H_
#define MINOU_H_

#include <cassert>

#include "base.hpp"
#include "engine.hpp"
#include "env.hpp"
#include "eval.hpp"
#include "types.hpp"

namespace minou {

inline Atom make_nil() { return Atom(); }

inline Atom car(const Atom &a) {
    assert(a.is_list());
    return a.cons->car;
}

inline Atom cdr(const Atom &a) {
    assert(a.is_list());
    return a.cons->cdr;
}
} // namespace minou

#include "parser.hpp"
#endif

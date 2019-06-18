#ifndef MINOU_H_
#define MINOU_H_

#include <cassert>

#include "base.hpp"
#include "types.hpp"
#include "eval.hpp"
#include "env.hpp"
#include "engine.hpp"

namespace minou {

inline Atom make_nil()
{
    return Atom();
}

inline Atom car(const Atom& a)
{
    assert(a.is_list());
    return a.cons->car;
}

inline Atom cdr(const Atom& a)
{
    assert(a.is_list());
    return a.cons->cdr;
}
}

#include "parser.hpp"
#endif

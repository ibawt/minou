#ifndef MINOU_H_
#define MINOU_H_

#include "types.hpp"

namespace minou {

inline Atom car(const Atom &a) {
    return a.cons()->car;
}

inline Atom cdr(const Atom &a) {
    return make_cons(a.cons()->cdr);
}
} // namespace minou

#endif

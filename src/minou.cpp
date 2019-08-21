#include "minou.hpp"
#include <assert.h>

namespace minou {


bool equalsp(const Atom a, const Atom b) {
    if (a.get_type() != b.get_type()) {
        return false;
    }
    if (!a.is_list()) {
        return false;
    }

    Cons *ca = a.cons();
    Cons *cb = b.cons();

    for (;;) {
        if (!ca && !cb) {
            break;
        }
        if (!ca || !cb) {
            // length mismatch
            return false;
        }

        if (ca->car.is_list() && cb->car.is_list()) {
            // recurse
            if (!equalsp(ca->car, cb->car)) {
                return false;
            }
        } else if (!(ca->car == cb->car)) {
            return false;
        }
        ca = ca->cdr;
        cb = cb->cdr;
    }
    return true;
}

} // namespace minou

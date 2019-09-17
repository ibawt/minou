#include "minou.hpp"
#include <assert.h>

namespace minou {


bool equalsp(const Atom a, const Atom b) {
    if (a.get_type() != b.get_type()) {
        fmt::print("wrong type");
        return false;
    }

    if (!a.is_list()) {
        fmt::print("a is not a list");
        return a == b;
    }

    Cons *ca = a.cons();
    Cons *cb = b.cons();

    for (;;) {
        if (!ca && !cb) {
            fmt::print("end of list\n");
            break;
        }
        if (!ca || !cb) {
            // length mismatch
            fmt::print("length mismatch\n");
            return false;
        }

        if (ca->car.is_list() && cb->car.is_list()) {
            // recurse
            if (!equalsp(ca->car, cb->car)) {
                return false;
            }
        } else if (!(ca->car == cb->car)) {
            fmt::print("cars are not equal\n");
            return false;
        }
        ca = ca->cdr;
        cb = cb->cdr;
    }
    return true;
}

} // namespace minou

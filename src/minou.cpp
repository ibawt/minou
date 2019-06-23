#include "minou.hpp"
#include <assert.h>
#include <sstream>
#include <string>
#include <iostream>

namespace minou {
using std::cout;
using std::endl;

static void print_list(std::stringstream &s, const Atom &a) {
    assert(a.get_type() == AtomType::Cons);
    if(a.is_nil())
        return;
    const Cons *cur = a.cons();
    if (!cur) {
        return;
    }

    for (;;) {
        assert(cur);

        s << cur->car.to_string();

        if (!cur->cdr) {
            return;
        } else {
            s << " ";
        }
        cur = cur->cdr;
    }
}

std::ostream &operator<<(std::ostream &os, const Atom &a) {
    os << a.to_string();
    return os;
}

bool equalsp(const Atom &a, const Atom &b) {
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

std::string Atom::to_string() const {
    std::stringstream s;

    switch (get_type()) {
    case AtomType::Number:
        s << integer();
        break;
    case AtomType::Cons:
        s << "(";
        print_list(s, *this);
        s << ")";
        break;
    case AtomType::Symbol:
        s << symbol();
        break;
    case AtomType::String:
        assert(string());
        s << "\"" << *string() << "\"";
        break;
    case AtomType::Lambda:
        s << "lambda()";
        break;
    case AtomType::Primitive:
        s << "primitive()";
        break;
    case AtomType::Nil:
        s << "nil";
        break;
    case AtomType::Boolean:
        s << (boolean() ? "#t" : "#f");
    case AtomType::Continuation:
        s << "continuation()";
    }
    return s.str();
}

} // namespace minou

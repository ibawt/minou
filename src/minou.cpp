#include "minou.hpp"
#include <assert.h>
#include <sstream>
#include <string>
#include <vector>

namespace minou {

static void print_list(std::vector<char> out, const Atom &a) {
    assert(a.get_type() == AtomType::Cons);
    auto it = std::back_inserter(out);
    if(a.is_nil())
        return;
    const Cons *cur = a.cons();
    if (!cur) {
        return;
    }

    for (;;) {
        assert(cur);

        fmt::format_to(it, "{}", cur->car.to_string());

        if (!cur->cdr) {
            return;
        } else {
            fmt::format_to(it, " ");
        }
        cur = cur->cdr;
    }
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
    std::vector<char> out;
    auto it = std::back_inserter(out);
    std::stringstream s;

    switch (get_type()) {
    case AtomType::Number:
        fmt::format_to(it, "{}", integer());
        break;
    case AtomType::Cons:
        fmt::format_to(it, "(");
        print_list(out, *this);
        fmt::format_to(it, ")");
        break;
    case AtomType::Symbol:
        fmt::format_to(it, "{}", symbol().string());
        break;
    case AtomType::String:
        assert(string());
        fmt::format_to(it, "\"{}\"", *string());
        break;
    case AtomType::Lambda:
        fmt::format_to(it, "lambda()");
        break;
    case AtomType::Primitive:
        fmt::format_to(it, "primitive");
        break;
    case AtomType::Nil:
        fmt::format_to(it, "nil");
        break;
    case AtomType::Boolean:
        fmt::format_to(it, "{}", (boolean() ? "#t" : "#f"));
        break;
    case AtomType::Continuation:
        fmt::format_to(it, "continuation");
        break;
    }
    return std::string(out.data(), out.size());
}

} // namespace minou

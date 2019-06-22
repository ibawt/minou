#include "memory.hpp"
#include "env.hpp"
#include "eval.hpp"
#include <cstdlib>
#include <iostream>
#include <string>

namespace minou {

using std::cout;
using std::endl;

void Memory::free_all() {
    for (auto h : allocations) {
        free(h);
    }
    allocations.clear();
}

void mark_atom(Atom a) {
    switch (a.get_type()) {
    case AtomType::String:
        visit((char *)a.value);
        break;
    case AtomType::Symbol:
        visit((char *)a.value);
        break;
    case AtomType::Cons:
        for (auto c = a.cons(); c; c = c->cdr) {
            if (!has_visited((char *)c)) {
                visit((char *)c);
                mark_atom(c->car);
            }
        }
        break;
    case AtomType::Primitive:
        a.primitive()->visit();
        break;
    case AtomType::Lambda:
        if (!has_visited((char *)a.value))
            a.lambda()->visit();
        break;
    case AtomType::Continuation:
        if(!has_visited((char *)a.value)) {
            a.continuation()->visit();
        }
    default:
        break;
    }
}

void mark(EnvPtr env) {
    env->for_each(
        [](const std::string &key UNUSED, Atom value) { mark_atom(value); });
}

void Memory::sweep() {
    for (auto it = allocations.begin(); it != allocations.end();) {
        auto h = *it;
        if (h->collectable()) {
            switch (h->type()) {
            case AtomType::String: {
                auto a = (String *)h->buff;
                a->~String();
            } break;
            case AtomType::Symbol: {
                auto a = (Symbol *)h->buff;
                a->~Symbol();
            } break;
            case AtomType::Lambda: {
                auto a = (Lambda *)h->buff;
                a->~Lambda();
                break;
            }
            case AtomType::Continuation: {
                auto a = (Continuation *)h->buff;
                a->~Continuation();
                break;
            }
            default:
                break;
            }
            free(h);
            it = allocations.erase(it);
        } else {
            ++it;
            h->clear_flag(USED);
        }
    }
} // namespace minou

void Memory::mark_and_sweep(EnvPtr root) {
    assert(root);
    mark(root);
    sweep();
}

} // namespace minou

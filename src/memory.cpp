#include "memory.hpp"
#include "env.hpp"
#include "eval.hpp"
#include <cstdlib>
#include <string>

namespace minou {

void Memory::free_all() {
    for (auto h : allocations) {
        free_node(h);
    }
    allocations.clear();
}

void mark_atom(Atom a) {
    switch (a.get_type()) {
    case AtomType::String:
        visit((char *)a.value);
        break;
    case AtomType::Cons:
        for (auto c : *a.cons()) {
            if (!has_visited((char *)c)) {
                visit((char *)c);
                mark_atom(c->car);
            }
        }
        break;
    case AtomType::Lambda:
        if (!has_visited((char *)a.value))
            a.lambda()->visit();
        break;
    default:
        break;
    }
}

void mark(EnvPtr env) {
    env->for_each(
        [](const std::string_view key UNUSED, Atom value) { mark_atom(value); });
}

void Lambda::visit()
{
    minou::visit(reinterpret_cast<const char *>(this));
    mark(env);
}

void Memory::free_node(HeapNode *h)
{
    assert(is_heap_type(h->type()));
    switch (h->type()) {
    case AtomType::String: {
        auto a = (String *)h->buff;
        a->~String();
    } break;
    case AtomType::Lambda: {
        auto a = (Lambda *)h->buff;
        delete a->native_name;
        a->native_name = nullptr;
        delete a->env;
        a->env = nullptr;
        break;
    }
    case AtomType::Cons: {
        auto a = (Cons*)h->buff;
        a->~Cons();
        consSlab.free((char *)h);
        return;
    }
    default:
        break;
    }
    free(h);
}


void Memory::sweep() {
    for (auto it = allocations.begin(); it != allocations.end();) {
        auto h = *it;
        if (h->collectable()) {
            free_node(h);
            it = allocations.erase(it);
        } else {
            h->clear_flag(USED);
            ++it;
        }
    }
} // namespace minou

void Memory::mark_and_sweep(Env* root) {
    assert(root);
    mark(root);
    sweep();
}

} // namespace minou

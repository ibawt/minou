#include "memory.hpp"
#include "env.hpp"
#include <cstdlib>

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
        visit(reinterpret_cast<char *>(a.value));
        break;
    case AtomType::Cons:
        for (auto c : *a.cons()) {
            auto p = reinterpret_cast<char *>(c);
            if (!has_visited(p)) {
                visit(p);
                mark_atom(c->car);
            }
        }
        break;
    case AtomType::Lambda:
        if (!has_visited(reinterpret_cast<char *>(a.value)))
            a.lambda()->visit();
        break;
    default:
        break;
    }
}

void Lambda::visit()
{
    minou::visit(reinterpret_cast<char *>(this));
    mark_atom(make_cons(body));
    env->visit();
}

void Memory::free_node(HeapNode *h)
{
    fmt::print("heapnode type: {}\n", h->type());
    assert(is_heap_type(h->type()));
    switch (h->type()) {
    case AtomType::String: {
        auto a = reinterpret_cast<String *>(h->buff);
        a->~String();
    } break;
    case AtomType::Lambda: {
        auto a = reinterpret_cast<Lambda *>(h->buff);
        delete a->native_name;
        delete a->arguments;
        a->native_name = nullptr;
        break;
    }
    case AtomType::Cons: {
        auto a = (Cons*)h->buff;
        a->~Cons();
        // consSlab.free(reinterpret_cast<char *>(h));
        // return;
    } break;
    case AtomType::Env: {
        auto e = reinterpret_cast<Env*>(h->buff);
        e->~Env();
        break;
    }break;
    default:
        break;
    }
    free(h);
}


void Memory::sweep() {
    for (auto it = allocations.begin(); it != allocations.end();) {
        auto h = *it;
        if (h->collectable()) {
            fmt::print("h collectible: {}\n", (uintptr_t)h->buff);
            free_node(h);
            it = allocations.erase(it);
        } else {
            fmt::print("h not collectible: {}\n", (uintptr_t)h->buff);
            h->clear_flag(USED);
            ++it;
        }
    }
} // namespace minou

void Memory::mark_and_sweep(Env* root) {
    assert(root);
    root->visit();
    sweep();
}

} // namespace minou

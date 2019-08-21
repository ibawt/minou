#ifndef MEMORY_H_
#define MEMORY_H_

#include "env.hpp"
#include "eval.hpp"
#include "types.hpp"
#include <assert.h>
#include <list>
#include <memory>
#include <stddef.h>
#include <string.h>
#include <vector>
#include "slab.hpp"
#include <string>
#include <cstring>

namespace minou {

class Lambda;
class Env;

template <typename T> AtomType type(T);
template <> constexpr inline AtomType type(String *) {
    return AtomType::String;
}
template <> constexpr inline AtomType type(Symbol *) {
    return AtomType::Symbol;
}
template <> constexpr inline AtomType type(Cons *) { return AtomType::Cons; }
template <> constexpr inline AtomType type(Lambda *) {
    return AtomType::Lambda;
}
void mark_atom(Atom);
void mark(EnvPtr env);

inline void visit(const char *address) {
    assert(address);
    auto p = (HeapNode *)(address - offsetof(HeapNode, buff));
    p->set_flag(USED);
}

inline bool has_visited(const char *address) {
    assert(address);
    auto p = (HeapNode *)(address - offsetof(HeapNode, buff));
    return p->has_visited();
}

inline void lock_object(const char *address) {
    auto p = (HeapNode *)(address - offsetof(HeapNode, buff));
    p->set_flag(LOCKED);
}

inline void unlock_object(const char *address) {
    auto p = (HeapNode *)(address - offsetof(HeapNode, buff));
    p->clear_flag(LOCKED);
}

class LockedObject
{
    const char *address;
public:
    LockedObject(const char *address) : address(address) {
        lock_object(address);
    }
    ~LockedObject() {
        unlock_object(address);
    }
};

class Memory {
  public:
    ~Memory() { free_all(); }

    Cons *make_list(const std::vector<Atom> &list) {
        Cons *c = nullptr;
        Cons *head = nullptr;

        for (const auto a : list) {
            auto nc = alloc_cons(a, nullptr);

            if (!c) {
                c = nc;
                head = c;
            } else {
                c->cdr = nc;
                c = nc;
            }
        }
        return head;
    }

    void mark_and_sweep(EnvPtr root);

    // template <typename T, typename... Args> T *alloc(Args &&... args) {
    //     int len = sizeof(T);
    //     auto block = malloc(sizeof(HeapNode) + len);
    //     memset(block, 0, sizeof(HeapNode) + len);
    //     auto hn = (HeapNode*)block;
    //     hn->set_size(len);

    //     allocations.push_front(hn);
    //     auto t = new ((char *)block + offsetof(HeapNode, buff))
    //         T(std::forward<Args>(args)...);

    //     Atom a(t);
    //     ++total_allocations;
    //     assert( ((intptr_t)t & TAG_MASK) == 0 );
    //     return (T*)a.value;
    // }

    String* alloc_string(char *b, int len) {
        auto block = (HeapNode*)malloc(sizeof(HeapNode) + sizeof(String));
        memset(block, 0, sizeof(HeapNode) + sizeof(String));
        block->set_size(sizeof(String));
        allocations.push_front(block);

        auto t = new ((block->buff)) String(b, len);
        block->set_type(AtomType::String);
        return t;
    }

    Lambda* alloc_lambda( Cons* args, Cons* body, Env* env) {
        auto block = (HeapNode*)malloc(sizeof(HeapNode) + sizeof(Lambda));
        memset(block, 0, sizeof(HeapNode) + sizeof(Lambda));
        block->set_size(sizeof(Lambda));
        allocations.push_front(block);

        auto t = reinterpret_cast<Lambda*>(block->buff);
        block->set_type(AtomType::Lambda);
        t->arguments = args;
        t->body = body;
        t->env = env;
        t->native_name = nullptr;
        t->function_pointer = nullptr;

        return t;
    }

    Cons* alloc_cons(Atom a, Cons* next) {
        auto block = consSlab.get();
        int len = sizeof(HeapNode) + sizeof(Cons);
        // memset(block, 0, len);
        // auto hn = new (block) HeapNode(len);
        auto hn = (HeapNode*)block;
        hn->set_size(len);

        Cons *c = new (hn->buff) Cons(a, next);
        assert( (((intptr_t)c) & TAG_MASK) == 0 );
        hn->set_type(AtomType::Cons);
        ++total_allocations;
        allocations.push_front(hn);
        return c;
    }

    int get_total_allocations() const {
        return total_allocations;
    }

  private:
    void free_node(HeapNode *);
    Slab consSlab = Slab(sizeof(HeapNode) + sizeof(Cons), 1024 * 1024);

    void free_all();

    int total_allocations = 0;
    int total_frees = 0;

    void sweep();

    std::list<HeapNode *> allocations;
};

} // namespace minou

#endif

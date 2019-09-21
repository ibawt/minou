#ifndef MEMORY_H_
#define MEMORY_H_

#include "env.hpp"
#include "types.hpp"
#include <list>
#include <memory>
#include <cstddef>
#include <cstring>
#include <vector>
#include "slab.hpp"
#include <string>
#include <mutex>

namespace minou {

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

inline void visit(char *address) {
    assert(address);
    auto p = reinterpret_cast<HeapNode *>(address - offsetof(HeapNode, buff));
    p->set_flag(USED);
}

inline bool has_visited(char *address) {
    assert(address);
    auto p = reinterpret_cast<HeapNode *>(address - offsetof(HeapNode, buff));
    return p->has_visited();
}

inline void lock_object(char *address) {
    auto p = reinterpret_cast<HeapNode *>(address - offsetof(HeapNode, buff));
    p->set_flag(LOCKED);
}

inline void unlock_object(char *address) {
    auto p = reinterpret_cast<HeapNode *>(address - offsetof(HeapNode, buff));
    p->clear_flag(LOCKED);
}

class LockedObject
{
    char *address;
public:
    LockedObject(char *address) : address(address) {
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

    void mark_and_sweep(Env* root);

    String* alloc_string(const char *b, int len) {
        auto block = alloc<String>();
        auto t = new ((block->buff)) String(b, len);
        block->set_type(AtomType::String);
        return t;
    }

    String* alloc_string(const char *b) {
        return alloc_string(b, strlen(b));
    }

    Lambda* alloc_lambda( Cons* args, Cons* body, Env* env) {
        auto block = alloc<Lambda>();
        auto t = reinterpret_cast<Lambda*>(block->buff);
        block->set_type(AtomType::Lambda);
        t->arguments = make_arguments(args);
        t->body = body;
        t->env = env;
        t->native_name = nullptr;
        t->function_pointer = nullptr;

        return t;
    }

    Env* alloc_env(Env* parent = nullptr) {
        auto block = alloc<Env>();
        auto e = new (block->buff) Env(parent);
        block->set_type(AtomType::Env);
        return e;
    }

    Cons* alloc_cons(Atom a, Cons* next) {
        auto hn = alloc<Cons>();
        Cons *c = reinterpret_cast<Cons*>(hn->buff);
        c->car = a;
        c->cdr = next;

        hn->set_type(AtomType::Cons);
        return c;
    }

    int get_total_allocations() const {
        return total_allocations;
    }

  private:
    template<typename T>
    HeapNode* alloc() {
        auto hn = reinterpret_cast<HeapNode*>(malloc (sizeof(HeapNode) + sizeof(T)));
        assert( (reinterpret_cast<uintptr_t>(hn->buff) & TAG_MASK) == 0 );
        memset(hn, 0, sizeof(HeapNode) + sizeof(T));
        hn->set_size(sizeof(T));

        add_to_free_list(hn);
        return hn;
    }

    void add_to_free_list(HeapNode*hn) {
        std::scoped_lock guard(lock);
        allocations.push_front(hn);
        total_allocations++;
    }

    void free_node(HeapNode *);
    // Slab consSlab = Slab(sizeof(HeapNode) + sizeof(Cons), 1024 * 1024);

    void free_all();

    int total_allocations = 0;
    int total_frees = 0;

    void sweep();

    std::list<HeapNode *> allocations;

    std::mutex lock;
};

} // namespace minou

#endif

#ifndef MEMORY_H_
#define MEMORY_H_

#include <vector>
#include <cassert>
#include <memory>
#include <string.h>
#include <stddef.h>
#include <list>
#include "types.hpp"
#include "env.hpp"

namespace minou {


class Lambda;
class Env;

template<typename T> AtomType type(T);
template<> inline AtomType type(String*) { return AtomType::String; }
template<> inline AtomType type(Symbol*) { return AtomType::Symbol; }
template<> inline AtomType type(Cons*) { return AtomType::Cons; }
template<> inline AtomType type(Lambda*) { return AtomType::Lambda; }
template<> inline AtomType type(Primitive*) { return AtomType::Primitive; }

void mark_atom(Atom);
void mark(EnvPtr env);

typedef enum {
   USED   = 1,
   LOCKED = 2,
} object_flags;

struct HeapNode {
    HeapNode(int size) : size(size) {}
    AtomType type;
    int  size;
    int used = 0;
    // HeapNode *next;
    char buff[];

    bool is_locked() {
        return used & LOCKED;
    }
    bool has_visited() {
        return used & USED;
    }
};

inline void visit(const char* address)
{
    assert(address);
    auto p = (HeapNode *)(address - offsetof(HeapNode, buff));
    p->used |= USED;
}

inline bool has_visited(const char * address)
{
    assert(address);
    auto p = (HeapNode *)(address - offsetof(HeapNode, buff));
    return p->used & USED;
}

inline void lock_object(const char * address)
{
    auto p = (HeapNode *)(address - offsetof(HeapNode, buff));
    p->used |= LOCKED;
}

class Memory
{
public:
    ~Memory() {
        free_all();
    }

    Cons* make_list(const std::vector<Atom>& list) {
        Cons *c = nullptr;
        Cons *head = nullptr;

        for(const auto& a : list) {
            auto nc = alloc<Cons>(a, nullptr);

            if(! c ) {
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

    template<typename T, typename... Args>
    T* alloc(Args&& ...args) {
        int len = sizeof(T);
        auto block = malloc(sizeof(HeapNode) + len);
        memset(block, 0, sizeof(HeapNode) + len);
        auto hn =  new(block) HeapNode(len);
        allocations.push_front(hn);

        auto t = new((char*)block + offsetof(HeapNode, buff)) T(std::forward<Args>(args)...);
        hn->type = type(t);
        assert((int)hn->type != 0);
        return t;
    }
private:
    void free_all();


    void sweep();

    std::list<HeapNode*> allocations;
};


}


#endif

#ifndef MEMORY_H_
#define MEMORY_H_

#include <vector>
#include <cassert>
#include <memory>
#include <string.h>

#include "types.hpp"

namespace minou {


class Lambda;
class Env;

template<typename T> AtomType type(T);
template<> inline AtomType type(String*) { return AtomType::String; }
template<> inline AtomType type(Symbol*) { return AtomType::Symbol; }
template<> inline AtomType type(Cons*) { return AtomType::Cons; }
template<> inline AtomType type(Procedure*) { return AtomType::Procedure; }
template<> inline AtomType type(Lambda*) { return AtomType::Procedure; }

void mark_atom(Atom);
void mark(std::shared_ptr<Env>& env);

struct HeapNode {
    HeapNode(int size, HeapNode* next = nullptr) : size(size), next(next) {}
    AtomType type;
    int  size;
    bool used = false;
    HeapNode *next;
    char buff[];

    void visit() {
        used = true;
    }
};

inline void visit(const char* address)
{
    assert(address);
    auto p = (HeapNode *)(address - sizeof(HeapNode) + sizeof(void*));
    p->visit();
}

inline bool has_visited(const char * address)
{
    assert(address);
    auto p = (HeapNode *)(address - sizeof(HeapNode) + sizeof(void*));
    return p->used;
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

    void mark_and_sweep(std::shared_ptr<Env>& root);

    template<typename T, typename... Args>
    T* alloc(Args&& ...args) {
        int len = sizeof(T);
        auto block = malloc(sizeof(HeapNode) + len);
        memset(block, 0, sizeof(HeapNode) + len);
        head = new(block) HeapNode(len, head);
        auto t = new(head->buff) T(std::forward<Args>(args)...);
        head->type = type(t);
        printf("allocing %d@%p\n", (int)head->type, block);
        assert((int)head->type != 0);
        return t;
    }
private:
    void free_all();


    void sweep();

    HeapNode *head = nullptr;
};


}


#endif

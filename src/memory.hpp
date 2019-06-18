#ifndef MEMORY_H_
#define MEMORY_H_

#include <vector>

#include "types.hpp"

namespace minou {

class Lambda;
class Env;

template<typename T>
constexpr AtomType type(Symbol*) {
    return AtomType::Symbol;
}

constexpr AtomType type(String*) {
    return AtomType::String;
}

constexpr AtomType type(Lambda *) {
    return AtomType::Procedure;
}

constexpr AtomType type(Cons*) {
    return AtomType::Cons;
}

struct HeapNode {
    HeapNode(int size, HeapNode* next = nullptr) : size(size), next(next) {}
    AtomType type;
    int  size;
    bool used = 0;
    HeapNode *next;
    char buff[];
};

class Memory
{
public:
    ~Memory() {
        free_all();
    }

    Symbol* alloc_symbol(const std::string &s) {
        return alloc<Symbol>(s);
    }

    String* alloc_string(const std::string &s) {
        return alloc<String>(s);
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

    void mark_and_sweep(Env* root);

    template<typename T, typename... Args>
    T* alloc(Args&& ...args) {
        int len = sizeof(T);
        auto block = malloc(sizeof(HeapNode) + len);
        head = new(block) HeapNode(len, head);
        auto t = new(head->buff) T(std::forward<Args>(args)...);
        return t;
    }

    void free_all();
    void mark(Env* env);
    void sweep();

    HeapNode *head = nullptr;
};


}


#endif

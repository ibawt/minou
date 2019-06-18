#ifndef MEMORY_H_
#define MEMORY_H_

#include "minou.hpp"
#include "eval.hpp"

namespace minou {

struct HeapNode {
    HeapNode(int size, HeapNode* next = nullptr) : size(size), next(next) {}
    AtomType type;
    int size;
    int used = 0;
    HeapNode *next;
    char buff[];
};

class GC
{
public:
    template<typename T, typename... Args>
    HeapNode* alloc(Args&& ...args) {
        int len = sizeof(T);
        auto block = malloc(sizeof(HeapNode) + len);
        head = new(block) HeapNode(len, head);
        auto t = new(head->buff) T(std::forward<Args>(args)...);
        head->type = t->type;
        return (HeapNode*)block;
    }

    void mark_and_sweep(Env* root);
private:
    void mark(Env* env);
    void sweep();

    HeapNode *head = nullptr;
};


}


#endif

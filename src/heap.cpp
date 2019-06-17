#include "minou.hpp"

#include <string>

// Ian's experiments in GC
namespace minou {
struct HeapNode {
    HeapNode(int size, HeapNode* next = nullptr) : size(size), next(next) {}
    int size;
    int used;
    HeapNode *next;
    char buff[];
};

struct Heap
{
    HeapNode *head;
};

static HeapNode *heap = nullptr;

    void clear_used()
    {
        auto h = heap;

        for(;;) {
            if( !h) {
                break;
            }
            h->used = 0;
            h = h->next;
        }
    }

    void visit(char* address)
    {
        auto p = (HeapNode *)(address - sizeof(HeapNode) + sizeof(char*));

        p->used = 1;
    }

    void sweep()
    {
        auto h = heap;
        auto head = h;

        for(;;) {
            if(!h) {
                break;
            }
            if(!h->used) {
                auto t = h;
                h = t->next;
                if( t == head) {
                    head = h;
                }
                free(t);
            } else {
                h = h->next;
            }

        }
    }

Cons* alloc_cons(Atom a, Cons *next = nullptr)
{
    auto block = malloc(sizeof(HeapNode) + sizeof(minou::Cons));

    heap = new(block) HeapNode(sizeof(minou::Cons), heap);

    return new(heap->buff) minou::Cons(a, next);
}

}

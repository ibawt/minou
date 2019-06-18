#include "minou.hpp"
#include "eval.hpp"
#include "memory.hpp"

#include <string>

// Ian's experiments in GC
namespace minou {

static GC gc;


void print_heap_node(HeapNode* h)
{
    printf("HeapNode[%p] type: %d, size: %d, used: %d, buff:%p\n", h, h->type, h->size, h->used, h->buff);
}

void visit_atom(Atom& a) {
    switch(a.type) {
    case AtomType::String:
        visit((char *)a.string);
        break;
    case AtomType::Symbol:
        visit((char *)a.symbol);
        break;
    case AtomType::Cons:
    {
        if(!a.cons) {
            return;
        }

        for (auto c = a.cons ;c; c = c->cdr) {
            printf("touching %s\n", c->car.to_string().c_str());
            visit((char *)c);
            visit_atom(c->car);
        }
    }
    break;
    case AtomType::Procedure:
        a.procedure->visit();
        break;
    default:
        break;
    }
}

static HeapNode *heap = nullptr;

void walk_env(Env *e) {
    for(;;) {
        for( auto& i : e->map) {
            printf("walk_env [%s] = %s\n", i.first.c_str(), i.second.to_string().c_str());
            visit_atom(i.second);
        }

        if(e->parent.has_value()) {
            e = e->parent.value();
        } else {
            break;
        }
    }
}

void clear_used()
{
    auto h = heap;

    for(;;) {
        if(!h) {
            break;
        }
        h->used = 0;
        h = h->next;
    }
}

void visit(char* address)
{
    assert(address);
    auto p = (HeapNode *)(address - sizeof(HeapNode) + sizeof(char*));
    printf("setting %p to used\n", p);

    p->used = 1;
}

void sweep()
{
    auto h = heap;
    auto head = h;

    printf("head = %p\n", head);
    for(;;) {
        if(!h) {
            break;
        }
        print_heap_node(h);
        if(!h->used) {
            auto t = h;
            printf("freeing a %d@%p\n", t->type, h );
            h = t->next;

            if(t == head) {
                printf("replacing head\n");
                head = h;
            }

            switch(t->type) {
            case AtomType::String:
            {
                auto a = (Symbol*)t->buff;
                a->~String();
            }
            break;
            case AtomType::Symbol:
            {
                auto a = (String*)t->buff;
                printf("destruct: %s@%p\n", a->c_str(), a);
                a->~Symbol();
            }
            break;
            default:
                break;
            }
            free(t);
        } else {
            h = h->next;
        }
    }
    heap = head;
}

// I think I can use a template here
Cons* alloc_cons(Atom a, Cons *next = nullptr)
{
    auto block = malloc(sizeof(HeapNode) + sizeof(Cons));
    printf("allocing cons: %p = %s\n", block, a.to_string().c_str());

    heap = new(block) HeapNode(sizeof(minou::Cons), heap);
    heap->type = AtomType::Cons;

    return new(heap->buff) Cons(a, next);
}

    template<typename T>
    constexpr AtomType type(Symbol* s) {
        return AtomType::Symbol;
    }

    constexpr AtomType type(String* s) {
        return AtomType::String;
    }

    constexpr AtomType type(Lambda *l) {
        return AtomType::Procedure;
    }

    constexpr AtomType type(Cons* s) {
        return AtomType::Cons;
    }

template<typename T, typename... Args>
HeapNode* alloc(Args&& ...args) {
    int len = sizeof(T);
    auto block = malloc(sizeof(HeapNode) + len);
    heap = new(block) HeapNode(len, heap);
    auto t = new(heap->buff) T(std::forward<Args>(args)...);
    heap->type = type(t);
    return (HeapNode*)block;
}

Symbol *alloc_symbol(const char *s)
{
    auto sym = alloc<Symbol>(s);
    // sym->type = AtomType::Symbol;
    return (Symbol*)sym->buff;
}

String *alloc_string(const char *s)
{
    auto string = alloc<String>(s);
    // string->type = AtomType::String;
    return (String*)string->buff;
}

Lambda* alloc_lambda(Cons *v, Cons *body, Env *env)
{
    auto l = alloc<Lambda>(v, body, env);
    // l->type = AtomType::Procedure;
    return (Lambda*)l->buff;
}

}

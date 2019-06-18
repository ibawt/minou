#include <cassert>

#include "memory.hpp"
#include "eval.hpp"
#include "env.hpp"

namespace minou {

void Memory::free_all()
{
    for( auto h = head ; h ;) {
        auto t = h;
        h = h->next;
        free(t);
    }
    head = nullptr;
}


void mark_atom(Atom a)
{
    switch(a.type) {
    case AtomType::String:
        visit((char*)a.string);
        break;
    case AtomType::Symbol:
        visit((char *)a.symbol);
        break;
    case AtomType::Cons:
        a.cons->for_each([](Cons *c){
                             visit((char *)c);
                             mark_atom(c->car);
                         });
        break;
    case AtomType::Procedure:
        a.procedure->visit();
        break;
    default:
        break;
    }
}

void mark(std::shared_ptr<Env>& env)
{
    env->for_each([](const Symbol& key UNUSED, Atom value) {
                      mark_atom(value);
                  });
}

void Memory::sweep()
{
    auto h = head;
    auto head = h;

    for(;;) {
        if(!h) {
            break;
        }
        if(!h->used) {
            auto t = h;
            h = t->next;

            if(t == head) {
                head = h;
            }

            switch(t->type) {
            case AtomType::String:
            {
                auto a = (String*)t->buff;
                assert(a);
                a->~String();
            }
            break;
            case AtomType::Symbol:
            {
                auto a = (Symbol*)t->buff;
                assert(a);
                a->~Symbol();
            }
            break;
            default:
                break;
            }
            assert(t);
            free(t);
        } else {
            h->used = false;
            h = h->next;
        }
    }
    this->head = head;
}

void Memory::mark_and_sweep(std::shared_ptr<Env>& root)
{
    mark(root);
    sweep();
}


}


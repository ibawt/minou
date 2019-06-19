#include <cassert>

#include "memory.hpp"
#include "eval.hpp"
#include "env.hpp"

namespace minou {
using std::cout;
using std::endl;

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
    cout << "mark_atom: " << a << endl;
    switch(a.type) {
    case AtomType::String:
        cout << "marking a string " << a << endl;
        visit((char*)a.string);
        break;
    case AtomType::Symbol:
        cout << "marking a symbol " << a << endl;
        visit((char *)a.symbol);
        break;
    case AtomType::Cons:
        if(!a.cons) return;
        if(has_visited((char*)a.cons)) {
            return;
        }

        cout << "marking a car of " << a.cons->car << endl;
        {
            auto c = a.cons;
            for(;;) {
                if(!c)
                    return;

                visit((char*)c);
                mark_atom(c->car);
                c = c->cdr;
            }
        }
        // a.cons->for_each([](Cons *c){
        //                      visit((char *)c);
        //                      mark_atom(c->car);
        //                  });
        break;
    case AtomType::Procedure:
        cout << "marking a procedure" << endl;
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

            printf("freeing: %d@%p\n", t->type, t);
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
    assert(root);
    mark(root);
    sweep();
}


}


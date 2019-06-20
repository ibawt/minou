#include "memory.hpp"
#include "eval.hpp"
#include "env.hpp"
#include <string>
#include <iostream>
#include <cstdlib>
#include <cstdio>

namespace minou {

using std::cout;
using std::endl;

void Memory::free_all()
{
    for( auto h : allocations) {
        free(h);
    }
    allocations.clear();
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
        for(auto c = a.cons; c ; c = c->cdr) {
            if(!has_visited((char *)c)) {
                visit((char*)c);
                mark_atom(c->car);
            }
        }
        break;
    case AtomType::Lambda:
        if(!has_visited((char*)a.lambda))
            a.lambda->visit();
        break;
    default:
        break;
    }
}

void mark(EnvPtr env)
{
  env->for_each([](const std::string& key UNUSED, Atom value) {
                  mark_atom(value);
                });
}

void Memory::sweep()
{
    for( auto it = allocations.begin() ; it != allocations.end() ; ) {
        auto h = *it;
        if( (h->used & (LOCKED|USED)) == USED ) {
            switch(h->type) {
            case AtomType::String:
            {
                auto a = (String*)h->buff;
                assert(a);
                a->~String();
            }
            break;
            case AtomType::Symbol:
            {
                auto a = (Symbol*)h->buff;
                assert(a);
                a->~Symbol();
            }
            break;
            case AtomType::Lambda:
            {
                auto a = (Lambda*)h->buff;
                assert(a);
                a->~Lambda();
                break;
            }
            default:
                break;
            }
            assert(h);
            free(h);
            it = allocations.erase(it);
        } else {
            ++it;
            h->used &= ~USED;
        }
    }
}

void Memory::mark_and_sweep(EnvPtr& root)
{
    assert(root);
    mark(root);
    sweep();
}


}


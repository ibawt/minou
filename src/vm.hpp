#ifndef VM_H_
#define VM_H_

#include "eval.hpp"
#include "engine.hpp"
#include "bytecode.hpp"
#include "compiler.hpp"
#include <vector>
#include <string>

namespace minou {

using word = uintptr_t;

class VM {
public:
    VM() : env(nullptr) {
        env = engine.get_env();
    }
    Result<Atom> run();

    Result<Atom> run(std::string_view s);

    Memory& get_memory() { return engine.get_memory(); }
private:
    word pop() {
        auto i = stack.back();
        stack.pop_back();
        // fmt::print("pop: 0x{:x}\n", i);
        return i;
    }

    Atom pop_atom() {
        auto l = pop();

        return *(reinterpret_cast<Atom*>(&l));
    }

    void push_atom(Atom a) {
        stack.push_back( *(reinterpret_cast<word*>(&a)));
    }

    void pop(int n) {
        for( ; n > 0 ; n--) {
            stack.pop_back();
        }
    }

    word stack_at(int offset) {
        assert( offset < stack.size());
        return stack[ stack.size() - offset ];
    }

    void push(word i) {
        // fmt::print("push: 0x{:x}\n", i);
        stack.push_back(i);
    }

    template<typename T>
    T read_instruction() {
        auto i = *(reinterpret_cast<T*>(inst));
        inst += sizeof(T);
        return i;
    }

    uint8_t  *inst = nullptr;
    std::vector<word> stack;
    Engine            engine;
    Env *env;
    Continuation *k = nullptr;
};

}

#endif

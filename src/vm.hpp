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
    VM() : env(engine.get_env()) {}
    Result<Atom> run();

    Result<Atom> run(std::string_view s);

    template <typename T> T pop() {
        static_assert(sizeof(T) == sizeof(word));
        auto i = stack.back();
        stack.pop_back();
        return *reinterpret_cast<T *>(&i);
    }

    template <typename T> void push(T t) {
        static_assert(sizeof(T) == sizeof(word));
        stack.push_back(*(reinterpret_cast<word *>(&t)));
    }

    Memory& get_memory() { return engine.get_memory(); }
private:
    std::vector<Env*> env_cache;

    Env* new_env(Env* parent) {
        if(env_cache.empty()) {
            Env* e = new Env(parent);
            return e;
        }
        Env* e = env_cache.back();
        env_cache.pop_back();
        e->set_parent(parent);
        return e;
    }

    void free_env(Env* e) {
        e->clear();
        env_cache.push_back(e);
    }

    word stack_at(int offset) {
        assert( offset < stack.size());
        return stack[ stack.size() - offset ];
    }


    template<typename T>
    T read_instruction() {
        auto i = *(reinterpret_cast<const T*>(inst));
        inst += sizeof(T);
        return i;
    }

    const uint8_t    *inst = nullptr;
    std::vector<word> stack;
    Engine            engine;
    Env              *env;
};

}

#endif


#include "env.hpp"
#include "engine.hpp"
#include "eval.hpp"
#include "types.hpp"
#include "vm.hpp"
#include <string>

namespace minou {

static EvalResult add(Engine *engine, Cons *args, EnvPtr env, Continuation *k) {
    assert(env);
    assert(k);

    int64_t sum = 0;
    for (auto i : *args) {
        if (i->car.get_type() != AtomType::Number) {
            return std::string("invalid type for add");
        }
        sum += i->car.integer();
    }

    return k->resume(engine, sum);
}

static Result<Atom> vm_add(VM* vm, int num_args) {
    int64_t sum = 0;
    for( int i = 0 ; i < num_args ; ++i) {
        auto v = vm->pop<Atom>();
        if( v.get_type() != AtomType::Number) {
            return "invalid type for add";
        }

        sum += v.integer();
    }
    return Atom(sum);
}


static EvalResult subtraction(Engine *engine, Cons *args, EnvPtr env,
                              Continuation *k) {
    assert(env);
    assert(k);

    if (!args) {
        return std::string("invalid arity");
    }

    if (args->car.get_type() != AtomType::Number) {
        return std::string("invalid type");
    }

    int64_t i = args->car.integer();

    if (!args->cdr) {
        return -i;
    }
    args = args->cdr;


    for (; args; args = args->cdr) {
        if (args->car.get_type() != AtomType::Number) {
            return std::string("invalid type");
        }
        i -= args->car.integer();
    }

    fmt::print("i = {}\n", i);

    return k->resume(engine, i);
}

static Result<Atom> vm_subtract(VM* vm, int num_args)
{
    if( num_args <= 0 ) {
        return "invalid arity";
    }

    auto v = vm->pop<Atom>();
    if( v.get_type() != AtomType::Number) {
        return "wrong type";
    }
    auto value = v.integer();

    if( num_args == 1) {
        return -value;
    }

    for( int i = 1 ; i < num_args ; ++i) {
        auto v = vm->pop<Atom>();
        if( v.get_type() != AtomType::Number) {
            return "wrong type" ;
        }
        value -= v.integer();
    }
    return value;
}

static EvalResult equals(Engine *engine, Cons *args, EnvPtr env,
                              Continuation *k) {
    assert(env);
    assert(k);

    if (!args) {
        return std::string("invalid arity");
    }

    intptr_t i = args->car.value;

    if (!args->cdr) {
        return k->resume(engine, Atom(Boolean(true)));
    }
    args = args->cdr;

    for (; args; args = args->cdr) {
        if( i != args->car.value) {
            return k->resume(engine, Atom(Boolean(false)));
        }
    }
    return k->resume(engine, Atom(Boolean(true)));
}

static Result<Atom> vm_equals(VM* vm, int num_args)
{
    if( num_args == 0 ) {
        return "invalid arity";
    }

    auto v = vm->pop<Atom>();
    for( int i = 1 ; i < num_args ; ++i) {
        auto vv = vm->pop<Atom>();
        if( v.value != vv.value) {
            return Boolean(false);
        }
    }
    return Boolean(true);
}

// TODO: this kind of works but not really
static Result<Atom> call_cc(Engine *engine, Cons *args, Env *env,
                            Continuation *k) {
    if (args->car.get_type() != AtomType::Lambda) {
        return "invalid type";
    }
    if (!has_only_n(args, 1)) {
        return "call/cc invalid arity";
    }

    auto x = engine->get_memory().alloc_cons(k, nullptr);

    return args->car.lambda()->invoke(engine, x, env, k);
}

static Result<Atom> vm_call_cc(VM* vm, int num_args)
{
    return "not implemented";
}

void Env::default_env(Engine *engine) {
    map[Symbol("+").interned_value] = engine->get_memory().alloc<Primitive>(add, vm_add);
    map[Symbol("=").interned_value] = engine->get_memory().alloc<Primitive>(equals, vm_equals);
    map[Symbol("-").interned_value] = engine->get_memory().alloc<Primitive>(subtraction, vm_subtract);
    map[Symbol("call/cc").interned_value] = engine->get_memory().alloc<Primitive>(call_cc, vm_call_cc);
}

} // namespace minou

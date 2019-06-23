
#include "env.hpp"
#include "engine.hpp"
#include "eval.hpp"
#include "types.hpp"
#include <string>

namespace minou {

static EvalResult add(Engine *engine, Cons *args, EnvPtr env, Continuation *k) {
    assert(env);
    assert(k);

    int64_t sum = 0;
    for (; args; args = args->cdr) {
        if (args->car.get_type() != AtomType::Number) {
            return std::string("invalid type for add");
        }
        sum += args->car.integer();
    }

    return k->resume(engine, sum);
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
    return k->resume(engine, i);
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

void Env::default_env(Engine *engine) {
    map["+"] = engine->get_memory().alloc<Primitive>(add);
    map["-"] = engine->get_memory().alloc<Primitive>(subtraction);
    map["call/cc"] = engine->get_memory().alloc<Primitive>(call_cc);
}

} // namespace minou

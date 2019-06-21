
#include "env.hpp"
#include "engine.hpp"
#include "eval.hpp"
#include "types.hpp"
#include <map>
#include <string>

namespace minou {

static EvalResult add(Engine *engine, Cons *args, EnvPtr env, Continuation *k) {
    assert(env);
    assert(k);

    int64_t sum = 0;
    for (; args; args = args->cdr) {
        if (args->car.type != AtomType::Number) {
            return std::string("invalid type for add");
        }
        sum += args->car.integer.value;
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

    if (args->car.type != AtomType::Number) {
        return std::string("invalid type");
    }

    int64_t i = args->car.integer.value;

    if (!args->cdr) {
        return -i;
    }
    args = args->cdr;

    for (; args; args = args->cdr) {
        if (args->car.type != AtomType::Number) {
            return std::string("invalid type");
        }
        i -= args->car.integer.value;
    }
    return k->resume(engine, i);
}

bool has_only_n(Cons *c, int n) {
    int i = 0;
    for (; c; c = c->cdr) {
        if (i > n) {
            return false;
        }
    }
    return i == n;
}
static Result<Atom> call_cc(Engine *engine, Cons *args, Env *env,
                            Continuation *k) {
    if (args->car.type != AtomType::Lambda) {
        return "invalid type";
    }
    if (!has_only_n(args, 1)) {
        return "invalid arity";
    }

    auto x = engine->get_memory().alloc<Cons>(k, nullptr);

    return args->car.lambda->invoke(engine, x, env, k);
}

static std::map<std::string, Primitive> primitives = {
    {"+", Primitive(add)},
    {"-", Primitive(subtraction)},
    {"call/cc", Primitive(call_cc)},
};

void Env::default_env() {
    for (auto &[name, prim] : primitives) {
        set(name, &prim);
    }
}

} // namespace minou

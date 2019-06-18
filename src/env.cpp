#include <cassert>

#include "env.hpp"
#include "types.hpp"
#include "eval.hpp"


namespace minou {

static EvalResult add(Engine *engine, Cons *args, std::shared_ptr<Env>& env, Continuation *k) {
    assert(env);
    assert(k);

    int64_t sum = 0;
    for(;args; args = args->cdr) {
        if( args->car.type != AtomType::Number) {
            return std::string("invalid type for add");
        }
        sum += args->car.integer.value;
    }

    return k->resume(engine, sum);
}
static EvalResult subtraction(Engine* engine, Cons *args, std::shared_ptr<Env> env, Continuation *k)
{
    assert(env);
    assert(k);

    if(!args) {
        return std::string("invalid arity");
    }

    if( args->car.type  != AtomType::Number) {
        return std::string("invalid type");
    }

    int64_t i = args->car.integer.value;

    if( !args->cdr ) {
        return -i;
    }
    args = args->cdr;

    for (; args ; args = args->cdr) {
        if(args->car.type != AtomType::Number) {
            return std::string("invalid type");
        }
        i -= args->car.integer.value;
    }
    return k->resume(engine, i);
}

static std::map<std::string, Primitive> primitives =
  { { "+", Primitive(add) },
    { "-", Primitive(subtraction)},
  };

void Env::default_env()
{
  for(auto& [name, prim] : primitives) {
    set(name, &prim);
  }
}

}

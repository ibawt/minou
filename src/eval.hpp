#ifndef EVAL_H_
#define EVAL_H_

#include <functional>
#include <memory>
#include <optional>
#include <variant>

#include "base.hpp"
#include "env.hpp"
#include "memory.hpp"
#include "types.hpp"

namespace minou {

class Engine;

using EvalResult = Result<Atom>;

inline Atom get_atom(const EvalResult &er) { return std::get<Atom>(er); }

class Continuation {
  public:
    virtual ~Continuation() {}
    virtual EvalResult resume(Engine *, Atom) = 0;

    Result<Atom> invoke(Engine *engine, Cons *args, Env *env, Continuation *k) {
        if (!has_only_n(args, 1)) {
            return "invalid arity";
        }

        return k->resume(engine, args->car);
    }
};

class BottomCont : public Continuation {
  public:
    EvalResult resume(Engine *, Atom a) override { return a; }
};

class Env;

class Procedure {
  public:
    virtual ~Procedure() {}
    virtual Result<Atom> invoke(Engine *, Cons *args, EnvPtr env,
                                Continuation *k) = 0;
    virtual void visit() {}
};

class Lambda : public Procedure {
  public:
    Lambda(Cons *variables, Cons *body, EnvPtr env)
        : variables(variables), body(body), env(env) {}

    EvalResult invoke(Engine *, Cons *args, EnvPtr env,
                      Continuation *k) override;

    void visit() override {
        minou::visit((char *)this);
        mark_atom(variables);
        mark_atom(body);
        mark(env);
    }

  private:
    Cons *variables;
    Cons *body;
    EnvPtr env;
};

using Applicative = EvalResult(Engine *, Cons *args, EnvPtr &env,
                               Continuation *k);

class Primitive : public Procedure {
  public:
    Primitive(std::function<Applicative> x) : op(x) {}
    EvalResult invoke(Engine *eng, Cons *args, EnvPtr env,
                      Continuation *k) override {
        return op(eng, args, env, k);
    }

    void visit() override {
        minou::visit((char *) this);
    }
  private:
    std::function<Applicative> op;
};

EvalResult eval(Engine *, Atom a, EnvPtr, Continuation *);
} // namespace minou

#endif

#include <iostream>
#include <cassert>
#include <optional>
#include "base.hpp"
#include "eval.hpp"
#include "env.hpp"
#include "engine.hpp"

namespace minou {

using str = std::string;
using std::cout;
using std::endl;

EvalResult eval_args(Engine *engine, Atom e, Env *env, Continuation *k);
EvalResult eval_begin(Engine *engine, Atom a, Env *env, Continuation *k);

EvalResult Lambda::invoke(Engine *engine, Cons *args, Env *env UNUSED, Continuation *k)
{
    auto e = this->env->extend(variables, args);

    if(std::holds_alternative<std::string>(e)) {
        return std::get<std::string>(e);
    }
    return eval_begin(engine, body, std::get<Env*>(e), k);
}

class BeginCont : public Continuation
{
public:
  BeginCont(Continuation *k, Atom e, Env *env) :
    k(k), e(e), env(env) {}

    EvalResult resume(Engine *engine, Atom a UNUSED) override {
        return eval_begin(engine, e, env, k);
  }
private:
  Continuation *k;
  Atom e;
  Env *env;
};

EvalResult eval_begin(Engine *engine, Atom a, Env *env, Continuation *k)
{
  if(!a.is_list()) {
    return str("invalid begin structure");
  }

  if( !a.cons ) {
      return k->resume(engine, Atom());
  }

  if( !a.cons->cdr) {
      return eval(engine, a.cons->car, env, k);
  }

  BeginCont bc(k, a.cons->cdr, env);
  return eval(engine, a.cons->car, env, &bc);
}

class IfCont : public Continuation
{
public:
  IfCont(Continuation *k, Atom t, Atom f, Env *env) :
    true_value(t), false_value(f), k(k), env(env) {}

    EvalResult resume(Engine* engine, Atom a) override {
    if(a.type == AtomType::Boolean && !a.boolean) {
      //only #f is false
        return eval(engine, false_value, env, k);
    }
    return eval(engine, true_value, env, k);
  }
private:
  Atom true_value;
  Atom false_value;
  Continuation* k;
  Env *env;
};

class ApplyCont : public Continuation
{
public:
  ApplyCont(Continuation *k, Atom f, Env *env) : f(f), env(env), k(k) {}

    EvalResult resume(Engine *engine, Atom a) override {
    if(!a.is_list()) {
      return str("invalid argument");
    }
    if(f.type !=  AtomType::Procedure) {
        return str("invalid type for apply: " + f.to_string());
    }

    assert(f.procedure);
    return f.procedure->invoke(engine, a.cons, env, k);
  }
private:
  Atom f;
  Env *env;
  Continuation *k;
};

class GatherCont : public Continuation
{
public:
  GatherCont(Continuation *k, Atom v) : k(k), v(v) {}
    EvalResult resume(Engine* engine, Atom a) override {
    if(a.type == AtomType::Cons) {
        return k->resume( engine, engine->get_memory().alloc<Cons>(v, a.cons));
    }
    return std::string("gather invalid structure");
  }
private:
  Continuation *k;
  Atom v;
};

class ArgumentCont : public Continuation
{
public:
  ArgumentCont(Continuation *k, Atom e, Env *env) : k(k), e(e), env(env) {}

    EvalResult resume(Engine *engine, Atom a) override {
    if(e.is_pair()) {
      GatherCont gc(k, a);
      return eval_args(engine, e.cons->cdr, env, &gc);
    }
    return str("arg invalid structure: " + e.to_string());
  }
private:
  Continuation *k;
  Atom e;
  Env *env;
};

EvalResult eval_args(Engine *engine, Atom e, Env *env, Continuation *k)
{
  if(! e.is_list()) {
    return str("must be a list");
  }
  if(!e.cons) {
    // empty list
      return k->resume(engine, e);
  }
  ArgumentCont ac(k, e, env);
  return eval(engine, e.cons->car, env, &ac);
}

class EvFunCont : public Continuation
{
public:
  EvFunCont(Continuation *k, Atom e, Env *env) : e(e), env(env), k(k) {}

    EvalResult resume(Engine* engine, Atom a) override {
    ApplyCont ac(k, a, env);
    return eval_args(engine, e, env, &ac);
  }

private:
  Atom e;
  Env *env;
  Continuation *k;
};

EvalResult eval_quote(Engine *engine, Atom a, Continuation *k)
{
    return k->resume(engine, a);
}

bool has_at_least_n(Cons *cons, int desired)
{
  int i = 0;
  for(;;) {
    if(!cons) {
      return desired == i;
    }

    if(i >= desired) {
      return true;
    }
    cons = cons->cdr;
    i++;
  }
}

Atom car (Cons *cons) {
  return cons->car;
}

Atom cadr (Cons *cons) {
  return cons->cdr->car;
}

Atom caddr(Cons *cons) {
  return cons->cdr->cdr->car;
}

Atom cadddr(Cons *cons) {
  return cons->cdr->cdr->cdr->car;
}

EvalResult eval_application(Engine* engine, Atom e, Atom ee, Env *env, Continuation *k)
{
  // cout << "eval_applicaton: e:" << e << " ee: " << ee << endl;
  EvFunCont cont(k, ee, env);
  return eval(engine, e, env, &cont);
}

EvalResult eval_variable(Engine* engine, const Symbol& s, Env *env, Continuation *k)
{
  auto v = env->lookup(s);
  if (v.has_value()) {
      return k->resume(engine, v.value());
  }
  return str("not found!");
}


EvalResult eval(Engine *engine, Atom a, Env* env, Continuation* k)
{
  switch(a.type) {
  case AtomType::Cons:
    if(!a.cons) {
        return std::string("invalid list application");
    }

    if(a.cons->car.type == AtomType::Symbol) {

      assert(a.cons->car.symbol);
      const auto& sym = *a.cons->car.symbol;

      // IF
      if( sym == "if" ) {
        if(!has_at_least_n(a.cons, 3)) {
          return std::string("invalid list structure for if");
        }
        IfCont ifCont(k, caddr(a.cons), cadddr(a.cons), env);

        return eval(engine, a.cons->cdr->car, env, &ifCont);
      }
      // QUOTE
      else if (sym == "quote") {
        if(!a.cons->cdr) {
          return std::string("invalid quote call");
        }
        return eval_quote(engine, a.cons->cdr->car, k);
      }
      // BEGIN
      else if( sym == "begin") {
          return eval_begin(engine, a.cons->cdr, env, k);
      }
      // LAMBDA
      else if( sym == "lambda") {
          auto l = engine->get_memory().alloc<Lambda>(a.cons->cdr->car.cons, a.cons->cdr->cdr, env);
          return k->resume(engine, l);
      }
      // EVAL
      else {
          return eval_application(engine, a.cons->car, a.cons->cdr, env, k);
      }
    } else {
        return eval_application(engine, a.cons->car, a.cons->cdr,  env, k);
    }
    break;
  case AtomType::Symbol:
      return eval_variable(engine, *a.symbol, env, k);
    break;
  default:
      return eval_quote(engine, a, k);
  }

  return std::string("shouldn't get here");
}

}

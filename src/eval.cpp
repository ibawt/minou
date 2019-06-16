#include "minou.hpp"
#include "eval.hpp"
#include <cstdio>
#include <stdarg.h>
#include <iostream>
#include <cassert>
#include <optional>
#include <functional>
#include <mutex>

namespace minou {

using str = std::string;
using std::cout;
using std::endl;

  void log(int level, const char *fmt, ...)
  {
    va_list args;
    va_start (args, fmt);

    vprintf(fmt, args);
    printf("\n");
  }

EvalResult eval_args(Atom e, Env *env, Continuation *k);
EvalResult eval_begin(Atom a, Env *env, Continuation *k);

class Procedure {
public:
  virtual EvalResult invoke(Cons* args, Env *env, Continuation *k) = 0;
};

using Applicative = EvalResult(Cons *args, Env *env, Continuation *k);

class Primitive : public Procedure
{
public:
  Primitive(std::function<Applicative> x) : op(x) {}
  EvalResult invoke(Cons *args, Env *env, Continuation *k) override {
    return op(args, env, k);
  }
private:
  std::function<Applicative> op;
};

class Lambda : public Procedure
{
public:
  Lambda(Cons *variables, Cons* body, Env *env) :
    variables(variables), body(body), env(env) {}

  EvalResult invoke(Cons *args, Env *env, Continuation *k) override
  {
    auto e = this->env->extend(variables, args);

    if(std::holds_alternative<std::string>(e)) {
      return std::get<std::string>(e);
    }
    return eval_begin( body, std::get<Env*>(e), k);
  }
private:
  Cons *variables;
  Cons *body;
  Env  *env;
};



EvalResult eval_begin(Atom a, Env *env, Continuation *k);

class BeginCont : public Continuation
{
public:
  BeginCont(Continuation *k, Atom e, Env *env) :
    k(k), e(e), env(env) {}

  EvalResult resume(Atom a) override {
    return eval_begin(a, env, k);
  }
private:
  Continuation *k;
  Atom e;
  Env *env;
};

EvalResult eval_begin(Atom a, Env *env, Continuation *k)
{
  if(a.type != AtomType::Cons) {
    return str("invalid begin structure");
  }
  if( !a.cons ) {
    return k->resume(Atom(false));
  }
  if( !a.cons->cdr) {
    return eval(a.cons->car, env, k);
  }
  BeginCont bc(k, a.cons->cdr, env);
  return eval(a.cons->car, env, k);
}

class IfCont : public Continuation
{
public:
  IfCont(Continuation *k, Atom t, Atom f, Env *env) :
    true_value(t), false_value(f), k(k), env(env) {}

  EvalResult resume(Atom a) override {
    if(a.type == AtomType::Boolean && !a.boolean) {
      //only #f is false
      return eval(false_value, env, k);
    }
    return eval(true_value, env, k);
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

  EvalResult resume(Atom a) override {
    if(!a.is_pair()) {
      return str("invalid argument");
    }
    switch(f.type) {
    case AtomType::Procedure:
      assert( a.procedure);
      return f.procedure->invoke(a.cons, env, k);
    default:
      return str("invalid type for apply");
    }
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

  EvalResult resume(Atom a) override {
    if(a.type == AtomType::Cons) {
      return k->resume( cons(v, a.cons));
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

  EvalResult resume(Atom a) override {
    if(e.is_pair()) {
      GatherCont gc(k, a);
      return eval_args(e.cons->cdr, env, &gc);
    }
    return str("arg invalid structure: " + e.to_string());
  }
private:
  Continuation *k;
  Atom e;
  Env *env;
};

EvalResult eval_args(Atom e, Env *env, Continuation *k)
{
  if(! e.is_list()) {
    return str("must be a list");
  }
  if(!e.cons) {
    // empty list
    return k->resume(e);
  }
  ArgumentCont ac(k, e, env);
  return eval(e.cons->car, env, &ac);
}

class EvFunCont : public Continuation
{
public:
  EvFunCont(Continuation *k, Atom e, Env *env) : e(e), env(env), k(k) {}

  EvalResult resume(Atom a) override {
    ApplyCont ac(k, a, env);
    return eval_args(e, env, &ac);
  }

private:
  Atom e;
  Env *env;
  Continuation *k;
};

EvalResult eval_quote(Atom a, Env *env, Continuation *k)
{
  return k->resume(a);
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

EvalResult eval_application(Atom e, Atom ee, Env *env, Continuation *k)
{
  // cout << "eval_applicaton: e:" << e << " ee: " << ee << endl;
  EvFunCont cont(k, ee, env);
  return eval(e, env, &cont);
}

EvalResult eval_variable(const std::string& n, Env *env, Continuation *k)
{
  auto v = env->lookup(n);
  if (v.has_value()) {
    return k->resume(v.value());
  }
  return str("not found!");
}

EvalResult eval(Atom a, Env* env, Continuation* k)
{
  // std::cout << "eval: " << a << std::endl; 
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

        return eval(a.cons->cdr->car, env, &ifCont);
      }
      // QUOTE
      else if (sym == "quote") {
        if(!a.cons->cdr) {
          return std::string("invalid quote call");
        }
        return eval_quote(a.cons->cdr->car, env, k);
      }
      // BEGIN
      else if( sym == "begin") {
        return eval_begin(a.cons->cdr, env, k);
      }
      // LAMBDA
      else if( sym == "lambda") {
        Lambda l(a.cons->cdr->car.cons, a.cons->cdr->cdr, env);
        return k->resume(&l);
      }
      // EVAL
      else {
        return eval_application(a.cons->car, a.cons->cdr, env, k);
      }
    } else {
      return eval_application(a.cons->car, a.cons->cdr,  env, k);
    }
    break;
  case AtomType::Symbol:
    return eval_variable(*a.symbol, env, k);
    break;
  default:
    return eval_quote(a, env, k);
  }

  return std::string("shouldn't get here");
}

EvalResult add(Cons *args, Env *env, Continuation *k) {
  assert(env);
  assert(k);

  int64_t sum = 0;
  for(;args; args = args->cdr) {
    if( args->car.type != AtomType::Number) {
      return str("invalid type for add");
    }
    sum += args->car.integer.value;
  }

  return k->resume(sum);
}

Env default_env()
{
  Env env;

  env.set("+", new Primitive(add));
  env.set("-", new Primitive([](Cons *args, Env *env, Continuation *k) -> EvalResult {
                               assert(env);
                               assert(k);

                               if(!args) {
                                 return str("invalid arity");
                               }

                               if( args->car.type  != AtomType::Number) {
                                 return str("invalid type");
                               }

                               int64_t i = args->car.integer.value;

                               if( !args->cdr ) {
                                 return -i;
                               }
                               args = args->cdr;

                               for (; args ; args = args->cdr) {
                                 if(args->car.type != AtomType::Number) {
                                   return str("invalid type");
                                 }
                                 i -= args->car.integer.value;
                               }
                               return i;
                             }));
  return env;
}

}

#ifndef EVAL_H_
#define EVAL_H_

#include <iostream>
#include <map>
#include <variant>
#include <optional>
#include <functional>

#include "types.hpp"

namespace minou {

class Engine;

using EvalResult = std::variant<Atom, std::string>;

template<typename T>
inline bool is_error(const T& er) {
    return std::holds_alternative<std::string>(er);
}

inline Atom get_atom(const EvalResult& er)
{
    return std::get<Atom>(er);
}

inline std::string get_error(const EvalResult& er)
{
  return std::get<std::string>(er);
}

class Continuation
{
public:
    virtual EvalResult resume(Engine*, Atom) = 0;
};

class BottomCont : public Continuation
{
public:
    EvalResult resume(Engine *, Atom a) override {
    return a;
  }
};

class Env;

class Procedure {
public:
    virtual EvalResult invoke(Engine*, Cons* args, Env *env, Continuation *k) = 0;
    virtual void visit() {}
};

class Lambda : public Procedure
{
public:
    Lambda(Cons *variables, Cons* body, Env *env) :
        variables(variables), body(body), env(env) {}
    EvalResult invoke(Engine* ,Cons *args, Env *env, Continuation *k) override;
private:
    Cons *variables;
    Cons *body;
    Env  *env;
};

using Applicative = EvalResult(Engine *, Cons *args, Env *env, Continuation *k);

class Primitive : public Procedure
{
public:
    Primitive(std::function<Applicative> x) : op(x) {}
    EvalResult invoke(Engine* eng, Cons *args, Env *env, Continuation *k) override {
        return op(eng, args, env, k);
    }
private:
    std::function<Applicative> op;
};

EvalResult eval(Engine*, Atom a, Env*, Continuation*);
}


#endif

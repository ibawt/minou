#ifndef EVAL_H_
#define EVAL_H_

#include <iostream>
#include <map>
#include <variant>
#include <optional>
#include "minou.hpp"

namespace minou {

typedef std::variant<Atom, std::string> EvalResult;

inline bool is_error(const EvalResult& er) {
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

class Env
{
public:
  Env(Env* parent) : parent(parent) {}
  Env() : parent({}) {}

  std::optional<Atom> lookup(const Symbol& key) {
    auto f = map.find(key);

    if(f == map.end()) {
      if( parent.has_value() ) {
        return parent.value()->lookup(key);
      }
      return {};
    }
    return f->second;
  }

  void set(const Symbol& key, Atom value) {
      map[key] = value;
  }

    std::variant<Env*, std::string> extend(Cons *args, Cons* vars) {
        Env *e = nullptr;

        for(;;) {
            if ((args && !vars) ||  (!args && vars)) {
                return std::string("wrong arity");
            }
            if(!(args && vars)) {
                break;
            }

            auto k = args->car;
            auto v = vars->car;

            if(!k.cons && !v.cons) {
                break;
            }

            if( k.type != AtomType::Symbol) {
                return std::string("invalid argument type:" + k.cons->car.to_string()) ;
            }

            if(!e) {
                e = new Env();
            }
            e->set(*k.symbol, v);

            args = args->cdr;
            vars = vars->cdr;
        }
        return e;
    }
private:
  std::map<const Symbol, Atom> map;
  std::optional<Env*> parent;
};

class Continuation
{
public:
  virtual EvalResult resume(Atom) = 0;
};

class BottomCont : public Continuation
{
public:
  EvalResult resume(Atom a) override {
    return a;
  }
};
EvalResult eval(Atom a, Env*, Continuation*);
Env default_env();
}


#endif

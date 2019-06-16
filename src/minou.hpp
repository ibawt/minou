#ifndef MINOU_H_
#define MINOU_H_

#include <string>
#include <cassert>

namespace minou
{
  enum class AtomType {
    Number,
    Cons,
    Symbol,
    String,
    Nil,
    Boolean,
    Procedure
  };

  using String = std::string;
  using Symbol = std::string;

  struct Number {
    Number(int64_t i) : value(i) {}
    union {
      int64_t value;
      double  real;
    };
  };

  struct Cons;
  class Procedure;

  struct Atom
  {
    Atom() : type(AtomType::Nil), cons(nullptr) {}
    Atom(int64_t i) : type(AtomType::Number), integer(i) {}
    Atom(const char *foo) : type(AtomType::String), string(new String(foo)) {}
    Atom(const std::string& s): type(AtomType::String), string(new String(s)) {}
    Atom(Cons *cons) : type(AtomType::Cons), cons(cons) {}
    Atom(bool b) : type(AtomType::Boolean), boolean(b) {}
    Atom(Procedure *p) : type(AtomType::Procedure), procedure(p) {}

    bool is_list() const {
      return type == AtomType::Cons;
    }

    bool is_pair() const {
      return type == AtomType::Cons && cons;
    }

    AtomType type;
    union {
      Number integer;
      Cons   *cons;
      Symbol *symbol;
      String *string;
      bool    boolean;
      Procedure *procedure;
    };

    std::string to_string() const;
  };

std::ostream& operator<<(std::ostream&os, const Atom& a);

  struct Cons {
    Cons(Atom car, Cons *cdr = nullptr) : car(car), cdr(cdr) {}
    Atom  car;
    Cons *cdr;
  };

  inline Atom car(Atom& a)
  {
    assert(a.is_list());
    return a.cons->car;
  }

  inline Atom cdr(Atom& a)
  {
    assert(a.is_list());
    return a.cons->cdr;
  }

  inline Atom cons(Atom item, Cons* list) {
    return Atom(new Cons(item, list));
  }

inline Atom make_nil()
{
  return Atom();
}




}

#include "parser.hpp"
#endif

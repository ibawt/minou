#ifndef MINOU_H_
#define MINOU_H_

#include <string>
#include <cassert>
#include <vector>

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

    bool operator==(const Number& n) const {
      return value == n.value;
    }
  };

  struct Cons;
  class Procedure;

  struct Atom
  {
    Atom() : type(AtomType::Nil), cons(nullptr) {}
    Atom(int64_t i) : type(AtomType::Number), integer(i) {}
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

    bool operator==(const Atom& other) const {
      if( type != other.type) {
        return false;
      }

      switch(type) {
      case AtomType::Number:
        return integer == other.integer;
      case AtomType::Cons:
        return cons == other.cons;
      case AtomType::Symbol:
        return *symbol == *other.symbol;
      case AtomType::String:
        return *string == *other.string;
      case AtomType::Nil:
        return true;
      case AtomType::Boolean:
        return boolean == other.boolean;
      case AtomType::Procedure:
        return procedure == other.procedure;
      }
      return false;
    }
    std::string to_string() const;
  };

  inline Atom make_symbol(const std::string& s)
  {
    Atom a;
    a.type = AtomType::Symbol;
    a.symbol = new Symbol(s);

    return a;
  }

  inline Atom make_string(const std::string& s)
  {
    Atom a;
    a.type = AtomType::String;
    a.string = new String(s);
    return a;
  }

  struct Cons {
    Cons(Atom car, Cons *cdr = nullptr) : car(car), cdr(cdr) {}
    Atom  car;
    Cons *cdr;
  };

  bool equalsp(const Atom& a, const Atom& b);

  inline Atom make_list(const std::vector<Atom>& list)
  {
    Cons *c = nullptr;
    Cons *head = nullptr;
    for(unsigned i = 0 ; i < list.size() ; ++i) {
      Cons *nc = new Cons(list[i], nullptr);

      if(! c ) {
        c = nc;
        head = c;
      } else {
        c->cdr = nc;
        c = nc;
      }
    }
    return head;
  }

  inline Atom make_nil()
  {
    return Atom();
  }

std::ostream& operator<<(std::ostream&os, const Atom& a);

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





}

#include "parser.hpp"
#endif

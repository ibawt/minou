#ifndef MINOU_H_
#define MINOU_H_

#include <iostream>
#include <string>
#include <cassert>
#include <vector>
#include <string.h>
#include <stdlib.h>

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

  // struct StringBuffer {
  //   StringBuffer(const char *src) {
  //     strcpy(value, src);
  //   }
  //   // StringBuffer(const StringBuffer& other) : value(strdup(other.value)) {}
  //   // StringBuffer(const std::string& s) : value(strdup(s.c_str())) {}
  //   // StringBuffer(const char *s) : value(strdup(s)) {}

  //   bool operator==(const StringBuffer& other) const {
  //     return strcmp( value, other.value) == 0;
  //   }
  //   bool operator==(const char *other) const {
  //     return strcmp(value, other) == 0;
  //   }
  //   bool operator<(const StringBuffer& other) const {
  //     return strcmp(value, other.value) < 0;
  //   }
  //   char value[];
  // };

  // inline std::ostream& operator<<(std::ostream& os, const StringBuffer& s)
  // {
  //   os << s.value;
  //   return os;
  // }

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
      Number     integer;
      Cons      *cons;
      Symbol    *symbol;
      String    *string;
      bool       boolean;
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

  Cons* alloc_cons(Atom a, Cons *next);


  String *alloc_string(const char *s);
  Symbol *alloc_symbol(const char *s);
  inline Atom make_symbol(const std::string& s)
  {
    Atom a;
    a.type = AtomType::Symbol;
    a.symbol = alloc_symbol(s.c_str());

    printf("a.symbol = %p\n", a.symbol);
    return a;
  }

  inline Atom make_string(const std::string& s)
  {
    Atom a;
    a.type = AtomType::String;
    a.string = alloc_string(s.c_str());
    printf("a.string = %p\n", a.string);
    return a;
  }

  struct Cons {
    Cons(Atom car, Cons *cdr = nullptr) : car(car), cdr(cdr) {}
    Atom  car;
    Cons *cdr;
  };

  bool equalsp(const Atom& a, const Atom& b);

  inline Cons* make_cons(Atom a, Cons* next = nullptr) {
    auto c = alloc_cons(a, next);

    return c;
  }

  inline Atom make_list(const std::vector<Atom>& list)
  {
    Cons *c = nullptr;
    Cons *head = nullptr;

    for(const auto&a : list) {
      Cons *nc = make_cons(a);

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

inline Atom car(const Atom& a)
{
  assert(a.is_list());
  return a.cons->car;
}

inline Atom cdr(const Atom& a)
{
  assert(a.is_list());
  return a.cons->cdr;
}

inline Atom cons(const Atom item, Cons* list) {
  return make_cons(item, list);
}

  void clear_used();
  void visit(char *address);
  void sweep();


}

#include "memory.hpp"
#include "eval.hpp"

namespace minou {
  class Engine
  {
  public:
    virtual ~Engine() {
      gc.mark_and_sweep(&global);
    }
    EvalResult eval(const char *);
  private:
    GC  gc;
    Env global = default_env();
  };

}

#include "parser.hpp"
#endif

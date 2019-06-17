#include "minou.hpp"
#include <iostream>
#include <sstream>
#include <assert.h>

namespace minou {

  static void print_list(std::stringstream& s,const Atom& a)
  {
    assert(a.type == AtomType::Cons);
    const Cons *cur = a.cons;
    if(!cur) {
      s << ")";
      return ;
    }

    for(;;) {
      s << cur->car.to_string();


      if( cur->cdr == nullptr ) {
        return;
      } else {
        s << " ";
      }
      cur = cur->cdr;
    }
  }

  std::ostream& operator<<(std::ostream&os, const Atom& a)
  {
    os << a.to_string();
    return os;
  }

  bool equalsp(const Atom& a, const Atom& b)
  {
    if( a.type != b.type) {
      return false;
    }
    if(!a.is_list()) {
      return false;
    }

    Cons *ca = a.cons;
    Cons *cb = b.cons;

    for(;;) {
      if( !ca && !cb) {
        break;
      }
      if(!ca || !cb) {
        // length mismatch
        return false;
      }

      if(ca->car.is_list() && cb->car.is_list()) {
        // recurse
        if(!equalsp(ca->car, cb->car )) {
          return false;
        }
      } else if(!(ca->car == cb->car)) {
        return false;
      }
      ca = ca->cdr;
      cb = cb->cdr;
    }
    return true;
  }

  std::string Atom::to_string() const
  {
    std::stringstream s;

    switch(type) {
    case AtomType::Number:
      s << integer.value;
      break;
    case AtomType::Cons:
      s << "(";
      print_list(s, *this);
      s << ")";
      break;
    case AtomType::Symbol:
      assert(symbol);
      s << *symbol;
      break;
    case AtomType::String:
      assert(string);
      s << "\"" << *string << "\"";
      break;
    case AtomType::Procedure:
      s << "lambda()";
      break;
    case AtomType::Nil:
      s << "nil";
      break;
    case AtomType::Boolean:
      s << (boolean ? "#t" : "#f");
    }
    return s.str();
  }

}

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
      s << "proc @(" << (void *)procedure << ")";
      break;
    case AtomType::Nil:
      s << "nil";
      break;
    case AtomType::Boolean:
      s << (boolean ? "#t" : "#f");
      break;
    }
    return s.str();
  }

}

#ifndef TYPES_H_
#define TYPES_H_

#include <string>
#include <variant>


namespace minou {

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

class Symbol {
public:
    Symbol(const char *s) : string(s) {}
    Symbol(const std::string& s): string(s) {}

    bool operator==(const Symbol& other) const {
        return this->string == other.string;
    }
    bool operator<(const Symbol& other) const {
        return this->string < other.string;
    }
    std::string string;
};

inline std::ostream& operator<<(std::ostream&os, const Symbol& a) {
    os << a.string;
    return os;
}
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
    Atom(Symbol *s) : type(AtomType::Symbol), symbol(s) {}
    Atom(String *s) : type(AtomType::String), string(s) {}

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

std::ostream& operator<<(std::ostream&os, const Atom& a);

struct Cons {
    Cons(Atom car, Cons *cdr = nullptr) : car(car), cdr(cdr) {}
    Atom  car;
    Cons *cdr;
};

bool equalsp(const Atom& a, const Atom& b);
}

#endif

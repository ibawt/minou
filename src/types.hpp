#ifndef TYPES_H_
#define TYPES_H_

#include <functional>
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
    Lambda,
    Primitive,
    Continuation
};

constexpr inline bool is_heap_type(const AtomType a) {
    switch (a) {
    case AtomType::Number:
    case AtomType::Nil:
    case AtomType::Boolean:
        return false;
    default:
        return true;
    }
}

struct Boolean {
    Boolean(bool b) : b(b) {}
    bool b;

    bool operator()() const { return b; }

    bool operator==(const Boolean &other) const { return b == other.b; }
};

using String = std::string;

class Symbol {
  public:
    Symbol(const char *s) : string(s) {}
    Symbol(const std::string &s) : string(s) {}

    bool operator==(const Symbol &other) const {
        return this->string == other.string;
    }
    bool operator<(const Symbol &other) const {
        return this->string < other.string;
    }
    std::string string;
};

inline std::ostream &operator<<(std::ostream &os, const Symbol &a) {
    os << a.string;
    return os;
}

struct Number {
    Number(int64_t i) : value(i) {}
    union {
        int64_t value;
        double real;
    };

    bool operator==(const Number &n) const { return value == n.value; }
};

struct Cons;
class Lambda;
class Primitive;
class Continuation;

struct Atom {
    Atom() : type(AtomType::Nil), cons(nullptr) {}
    Atom(int64_t i) : type(AtomType::Number), integer(i) {}
    Atom(Cons *cons) : type(AtomType::Cons), cons(cons) {}
    Atom(Boolean b) : type(AtomType::Boolean), boolean(b) {}
    Atom(Primitive *p) : type(AtomType::Primitive), primitive(p) {}
    Atom(Lambda *p) : type(AtomType::Lambda), lambda(p) {}
    Atom(Symbol *s) : type(AtomType::Symbol), symbol(s) {}
    Atom(String *s) : type(AtomType::String), string(s) {}
    Atom(Continuation *c) : type(AtomType::Continuation), continuation(c) {}

    AtomType type;
    union {
        Number integer;
        Boolean boolean;
        Cons *cons;
        Symbol *symbol;
        String *string;
        Primitive *primitive;
        Lambda *lambda;
        Continuation *continuation;
    };

    bool operator==(const Atom &other) const {
        if (type != other.type) {
            return false;
        }

        switch (type) {
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
        case AtomType::Primitive:
            return primitive == other.primitive;
        case AtomType::Lambda:
            return lambda == other.lambda;
        case AtomType::Continuation:
            return continuation == other.continuation;
        }
        return false;
    }
    std::string to_string() const;

    bool is_list() const { return type == AtomType::Cons; }

    bool is_pair() const { return type == AtomType::Cons && cons; }
};

std::ostream &operator<<(std::ostream &os, const Atom &a);

struct Cons {
    Cons(Atom car, Cons *cdr = nullptr) : car(car), cdr(cdr) {}
    Atom car;
    Cons *cdr;

    void for_each(std::function<void(Cons *)> f) {
        Cons *c = cdr;
        for (;;) {
            if (!c)
                return;
            f(c);
            c = c->cdr;
        }
    }
};

bool equalsp(const Atom &a, const Atom &b);

inline bool has_only_n(const Cons *c, const int n) {
    int i = 0;
    for (; c; c = c->cdr, ++i) {
        if (i > n) {
            return false;
        }
    }
    return i == n;
}
} // namespace minou

#endif

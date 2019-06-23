#ifndef TYPES_H_
#define TYPES_H_

#include <assert.h>
#include <functional>
#include <string>
#include <variant>

#include "symbol_intern.hpp"

namespace minou {

inline constexpr int bit_mask(int num_bits) {
    return (1 << num_bits) - 1;
}

enum class AtomType {
    Number = 0,
    Cons,
    Symbol,
    String,
    Nil,
    Boolean,
    Lambda,
    Primitive,
    Continuation
};

inline const std::string atom_type_string(const AtomType a) {
    switch(a) {
    case AtomType::Number:
        return "number";
    case AtomType::Cons:
        return "cons";
    case AtomType::Symbol:
        return "symbol";
    case AtomType::String:
        return "string";
    case AtomType::Nil:
        return "nil";
    case AtomType::Boolean:
        return "boolean";
    case AtomType::Lambda:
        return "lambda";
    case AtomType::Primitive:
        return "primitive";
    case AtomType::Continuation:
        return "continuation";
    }
}

inline std::ostream &operator<<(std::ostream &os, const AtomType a) {
    os << atom_type_string(a);
    return os;
}

constexpr inline bool is_heap_type(const AtomType a) {
    switch (a) {
    case AtomType::Number:
    case AtomType::Nil:
    case AtomType::Boolean:
    case AtomType::Symbol:
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
    Symbol(const char *s) : interned_value(intern(s)) {}
    Symbol(const std::string &s) : interned_value(intern(s)) {}
    Symbol(int i) : interned_value(i) {}

    bool operator==(const Symbol &other) const {
        return interned_value == other.interned_value;
    }
    bool operator<(const Symbol &other) const {
        return string() < other.string() ;
    }

    const std::string& string() const {
        return symbol_to_string(interned_value);
    }

    const int interned_value;
};

inline std::ostream &operator<<(std::ostream &os, const Symbol &a) {
    os << a.string();
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

inline const int USED   = 1;
inline const int LOCKED = 2;

struct HeapNode {
    HeapNode(int size) : header(size << 16) { }
    // 0-7 AtomType
    // 8-15 flags
    // 16-63 size
    uint64_t header;
    // the actual thing
    char     buff[];

    AtomType type() const {
        return AtomType(header & 0xff);
    }

    void set_type(AtomType t) {
        header &= ~0xff;
        header |= (int)t;
    }

    int flags() const {
        return (header >> 8) & 0xff;
    }

    void set_flag(int flag) {
        header |= flag << 8;
    }

    void clear_flag(int flag) {
        header &= ~(flag << 8);
    }

    size_t size() const {
        return header >> 16;
    }

    bool collectable() const {
        return flags() == 0;
    }

    bool is_locked() { return flags() & LOCKED; }
    bool has_visited() { return flags() & USED; }
};

// atom tagging
inline const int INTEGER = 1;
inline const int BOOL    = 2;
inline const int NIL     = 3;
inline const int SYMBOL  = 4;

inline const int TAG_BITS  = 3;
inline const int TAG_MASK  = bit_mask(3);

struct Atom {
    Atom() : value(NIL) {}
    Atom(int64_t i) : value(INTEGER | (i << TAG_BITS)) {}
    Atom(Boolean b) : value(BOOL | (b() << TAG_BITS)) {}
    Atom(Cons *cons) : value((intptr_t)cons) {
        if (cons) {
            set_type(AtomType::Cons);
        } else {
            value = NIL;
        }
    }
    Atom(Symbol s) : value(s.interned_value << TAG_BITS) { set_type(AtomType::Symbol); }
    Atom(Primitive *p) : value((intptr_t)p) { set_type(AtomType::Primitive); }
    Atom(Lambda *p) : value((intptr_t)p) { set_type(AtomType::Lambda); }
    Atom(String *s) : value((intptr_t)s) { set_type(AtomType::String); }
    Atom(Continuation *c) : value((intptr_t)c) {
        set_type(AtomType::Continuation);
    }

    uintptr_t value;

    void set_tag(int tag) {
        value = (value & ~TAG_MASK) | tag;
    }

    void set_type(AtomType t) {
        switch (t) {
        case AtomType::Number:
            set_tag(INTEGER);
            break;
        case AtomType::Boolean:
            set_tag(BOOL);
            break;
        case AtomType::Nil:
            set_tag(NIL);
            break;
        case AtomType::Symbol:
            set_tag(SYMBOL);
            break;
        default:
            ((HeapNode *)(value - offsetof(HeapNode, buff)))->set_type(t);
        }
    }

    AtomType get_type() const {
        switch (value & TAG_MASK) {
        case INTEGER:
            return AtomType::Number;
        case BOOL:
            return AtomType::Boolean;
        case NIL:
            return AtomType::Nil;
        case SYMBOL:
            return AtomType::Symbol;
        default:
            return ((HeapNode *)(value - offsetof(HeapNode, buff)))->type();
        }
    }

    int64_t integer() const { return value >> TAG_BITS; }

    Cons *cons() const {
        if(get_type() == AtomType::Nil) {
            return nullptr;
        }
        assert(get_type() == AtomType::Cons);
        return (Cons *)value;
    }
    bool boolean() const {
        assert(get_type() == AtomType::Boolean);
        return value >> TAG_BITS;
    }
    Primitive *primitive() const {
        assert(get_type() == AtomType::Primitive);
        return (Primitive *)value;
    }
    Lambda *lambda() const {
        assert(get_type() == AtomType::Lambda);
        return (Lambda *)value;
    }
    Continuation *continuation() {
        assert(get_type() == AtomType::Continuation);
        return (Continuation *)value;
    }
    Symbol symbol() const {
        assert(get_type() == AtomType::Symbol);
        return Symbol(value >> TAG_BITS);
    }
    String *string() const {
        assert(get_type() == AtomType::String);
        return (String *)value;
    }

    bool operator==(const Atom &other) const {
        if (get_type() != other.get_type()) {
            return false;
        }

        switch (get_type()) {
        case AtomType::Symbol:
            return symbol() == other.symbol();
        case AtomType::String:
            return *string() == *other.string();
        default:
            return value == other.value;
        }
    }

    std::string to_string() const;
    bool is_nil() const { return get_type() == AtomType::Nil; }
    bool is_list() const { return get_type() == AtomType::Cons || get_type() == AtomType::Nil; }
    bool is_pair() const { return get_type() == AtomType::Cons && value != 0; }
};

static_assert(sizeof(Atom)== 8);

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

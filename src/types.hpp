#ifndef TYPES_H_
#define TYPES_H_

#include <assert.h>
#include <functional>
#include <string>
#include <variant>

namespace minou {

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

inline const int USED   = 1;
inline const int LOCKED = 2;

struct HeapNode {
    HeapNode(int size) : header(size << 16) { }
    // 0-7 AtomType
    // 8-15 flags
    // 16-63 size
    uint64_t header;
    char buff[];

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

inline const int INTEGER = 1;
inline const int BOOL    = 2;
inline const int NIL     = 3;

inline const int TAG_BITS  = 3;
inline const int TAG_MASK  = ((1 << TAG_BITS) - 1);

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
    Atom(Primitive *p) : value((intptr_t)p) { set_type(AtomType::Primitive); }
    Atom(Lambda *p) : value((intptr_t)p) { set_type(AtomType::Lambda); }
    Atom(Symbol *s) : value((intptr_t)s) { set_type(AtomType::Symbol); }
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
        default:
            ((HeapNode *)(value - offsetof(HeapNode, buff)))->set_type(t);
        }
    }

    inline AtomType get_type() const {
        switch (value & TAG_MASK) {
        case INTEGER:
            return AtomType::Number;
        case BOOL:
            return AtomType::Boolean;
        case NIL:
            return AtomType::Nil;
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
    Symbol *symbol() const {
        assert(get_type() == AtomType::Symbol);
        return (Symbol *)value;
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
            return *symbol() == *other.symbol();
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

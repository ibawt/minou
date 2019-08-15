#ifndef TYPES_H_
#define TYPES_H_

#include <assert.h>
#include <functional>
#include <string>
#include <variant>

#include "symbol_intern.hpp"
#include "fmt/format.h"

namespace minou {

inline constexpr int bit_mask(int num_bits) {
    return (1 << num_bits) - 1;
}

enum class AtomType : uint8_t {
    Number = 0,
    Cons,
    Symbol,
    String,
    Nil,
    Boolean,
    Lambda, // in ast form
    Primitive, // for native implemention
    Continuation, // eventual call/cc
    Function, // compiled function
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
    case AtomType::Function:
        return "function";
    }
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
class Function;

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

class Procedure;

struct Atom {
    Atom() : value(NIL) {}
    Atom(int i) : value(INTEGER | ( i << TAG_BITS)) {}
    Atom(long i) : value(INTEGER | (i << TAG_BITS)) {}
    #ifdef __APPLE__
    Atom(int64_t i) : value(INTEGER | (i << TAG_BITS)) {}
    #endif
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
    Atom(Function *f) : value((intptr_t)f) { set_type(AtomType::Function); }

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

    Procedure* procedure() const {
        assert( get_type() == AtomType::Primitive || get_type() == AtomType::Lambda);
        return (Procedure*)value;
    }

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

    bool is_false() const { return get_type() == AtomType::Boolean && !boolean();}
    bool is_nil() const { return get_type() == AtomType::Nil; }
    bool is_list() const { return get_type() == AtomType::Cons || get_type() == AtomType::Nil; }
    bool is_pair() const { return get_type() == AtomType::Cons && value != 0; }
};

static_assert(sizeof(Atom)== 8);

struct Cons {
    Cons(Atom car, Cons *cdr = nullptr) : car(car), cdr(cdr) {}
    Atom car;
    Cons *cdr;

    class iterator {
        Cons *node;
    public:
        iterator(Cons* c) : node(c) {}

        using difference_type = ptrdiff_t;
        using value_type = Cons*;
        using pointer = const Cons**;
        using reference = const Cons*&;
        using iterator_category = std::forward_iterator_tag;

        iterator& operator++() {
            node = node->cdr;
            return *this;
        }
        iterator operator++(int) {
            auto r = *this;
            ++(*this);
            return r;
        }

        bool operator==(iterator other) const {
            return node == other.node;
        }

        bool operator!=(iterator other) const {
            return node != other.node;
        }

        Cons* operator*() { return node; }
        Cons* operator->() { return node; }
    };

    class const_iterator {
        const Cons* node;
    public:
        const_iterator(const Cons* c) : node(c) {}

        using difference_type = ptrdiff_t;
        using value_type = const Cons *;
        using pointer = const Cons **;
        using reference = const Cons *&;
        using iterator_category = std::forward_iterator_tag;

        const_iterator &operator++() {
            node = node->cdr;
            return *this;
        }
        const_iterator operator++(int) {
            auto r = *this;
            ++(*this);
            return r;
        }

        bool operator==(const_iterator other) const { return node == other.node; }

        bool operator!=(const_iterator other) const { return node != other.node; }

        const Cons *operator*() { return node; }
        const Cons *operator->() { return node; }
    };

    const_iterator begin() const {
        return const_iterator(this);
    }

    const_iterator end() const {
        return const_iterator(nullptr);
    }

    iterator begin() {
        return iterator(this);
    }

    iterator end() {
        return iterator(nullptr);
    }

    bool is_end() const {
        return cdr;
    }

    // O(n)
    int length() const {
        int sum = 0;
        for(auto i : *this) { ++sum; }
        return sum;
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

inline bool has_at_least_n(Cons *cons, int desired) {
    for (int i = 0;; ++i) {
        if (!cons) {
            return i >= desired;
        }
        if (i >= desired) {
            return true;
        }
        cons = cons->cdr;
        ++i;
    }
}

inline Atom car(Cons *cons) { return cons->car; }

inline Atom cadr(Cons *cons) { return cons->cdr->car; }

inline Atom caddr(Cons *cons) { return cons->cdr->cdr->car; }

inline Atom cadddr(Cons *cons) { return cons->cdr->cdr->cdr->car; }

} // namespace minou

namespace fmt {
template <> struct formatter<minou::Atom> {
    template <typename ParseContext> constexpr auto parse(ParseContext &ctx) {
        return ctx.begin();
    }

    template <typename FormatContext>
    auto format(const minou::Atom &a, FormatContext &ctx) {
           switch (a.get_type()) {
           case minou::AtomType::Number:
               return format_to(ctx.begin(), "{}", a.integer());
               break;
           case minou::AtomType::Cons: {
               auto it = ctx.out();
               it = fmt::format_to(it, "(");
               for( auto c : *a.cons()) {
                   it = fmt::format_to(it, "{}", c->car);
                   if( c->cdr ) {
                       it = fmt::format_to(it, " ");
                   }
               }
               return format_to(it, ")");
           } break;
           case minou::AtomType::Symbol:
               return format_to(ctx.begin(), a.symbol().string());
               break;
           case minou::AtomType::String:
               return format_to(ctx.begin(), *a.string());
               break;
           case minou::AtomType::Lambda: {
               return format_to(ctx.begin(), "{}", *a.lambda());
           }
           case minou::AtomType::Primitive:
               return format_to(ctx.begin(), "primitive");
           case minou::AtomType::Nil:
               return format_to(ctx.begin(), "nil");
               break;
           case minou::AtomType::Boolean:
               return format_to(ctx.begin(), (a.boolean() ? "#t" : "#f"));
           case minou::AtomType::Continuation:
               return format_to(ctx.begin(), "continuation");
           case minou::AtomType::Function:
               return format_to(ctx.begin(), "function");
           }

           return format_to(ctx.begin(), "invalid type");
    }
};

template <> struct formatter<minou::Cons*> {
    template <typename ParseContext> constexpr auto parse(ParseContext &ctx) {
        return ctx.begin();
    }

    template <typename FormatContext>
    auto format(const minou::Cons *c, FormatContext &ctx) {
        return format_to(ctx.begin(), "{}", minou::Atom(c));

    }
};
} // namespace fmt

#endif

#ifndef TYPES_H_
#define TYPES_H_

#include <functional>
#include <string>
#include <type_traits>
#include <variant>

#include "fmt/format.h"
#include "symbol_intern.hpp"
#include <cstring>
#include <vector>

namespace minou {

inline constexpr int bit_mask(int num_bits) { return (1 << num_bits) - 1; }

enum class AtomType : uint8_t {
    Number = 0,
    Cons,
    Symbol,
    String,
    Nil,
    Boolean,
    Lambda,
    Env
};

static_assert(std::is_pod<AtomType>());

inline const std::string_view atom_type_string(const AtomType a) {
    switch (a) {
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
    case AtomType::Env:
        return "env";
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
    static Boolean of(bool b) { return Boolean{b}; }

    bool b;

    bool operator()() const { return b; }

    bool operator==(const Boolean &other) const { return b == other.b; }
};

static_assert(std::is_pod<Boolean>());

using String = std::string;

struct Symbol {
    static Symbol from(const char *s) { return Symbol{intern(s)}; }
    static Symbol from(const std::string &s) { return Symbol{intern(s)}; }

    static Symbol from(int i) { return Symbol{i}; }

    bool operator==(const Symbol &other) const {
        return interned_value == other.interned_value;
    }
    bool operator<(const Symbol &other) const {
        return string() < other.string();
    }

    bool operator==(const char *s) const {
        return strcmp(s, symbol_to_string(interned_value).c_str()) == 0;
    }

    const std::string &string() const {
        return symbol_to_string(interned_value);
    }

    const int interned_value;
};

static_assert(std::is_pod<Symbol>());

struct Number {
    static Number from(int64_t i) { return Number{i}; }

    union {
        int64_t value;
        double real;
    };

    bool operator==(const Number &n) const { return value == n.value; }
};

static_assert(std::is_pod<Number>());

struct Cons;
struct Lambda;

inline const int USED = 1;
inline const int LOCKED = 2;

struct HeapNode {
    // 0-7 AtomType
    // 8-15 flags
    // 16-63 size
    uint64_t header;
    // the actual thing
    char buff[];

    AtomType type() const { return AtomType(header & 0xff); }

    void set_type(AtomType t) {
        header &= ~0xff;
        header |= (int)t;
    }

    void set_size(int size) {
        header = (header & 0xffff) | size << 16;
    }

    int flags() const { return (header >> 8) & 0xff; }

    void set_flag(int flag) { header |= flag << 8; }

    void clear_flag(int flag) { header &= ~(flag << 8); }

    size_t size() const { return header >> 16; }

    bool collectable() const { return flags() == 0; }

    bool is_locked() { return flags() & LOCKED; }
    bool has_visited() { return flags() & USED; }
};

static_assert(std::is_pod<HeapNode>());

// atom tagging
inline const int INTEGER = 1;
inline const int BOOL = 2;
inline const int NIL = 3;
inline const int SYMBOL = 4;

inline const int TAG_BITS = 3;
inline const int TAG_MASK = bit_mask(3);

class Env;

struct Atom {
    uintptr_t value;

    void set_tag(int tag) { value = (value & ~TAG_MASK) | tag; }

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
            return (reinterpret_cast<HeapNode *>(value - offsetof(HeapNode, buff)))->type();
        }
    }

    int64_t integer() const { return value >> TAG_BITS; }

    Env* env() const {
        assert(get_type() == AtomType::Env);
        return reinterpret_cast<Env*>(value);
    }

    Cons *cons() const {
        if (get_type() == AtomType::Nil) {
            return nullptr;
        }
        assert(get_type() == AtomType::Cons);
        return reinterpret_cast<Cons *>(value);
    }

    bool boolean() const {
        assert(get_type() == AtomType::Boolean);
        return value >> TAG_BITS;
    }
    Lambda *lambda() const {
        assert(get_type() == AtomType::Lambda);
        return reinterpret_cast<Lambda *>(value);
    }
    Symbol symbol() const {
        assert(get_type() == AtomType::Symbol);
        return Symbol::from(value >> TAG_BITS);
    }
    String *string() const {
        assert(get_type() == AtomType::String);
        return reinterpret_cast<String *>(value);
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

    bool is_false() const {
        return get_type() == AtomType::Boolean && !boolean();
    }
    bool is_nil() const { return get_type() == AtomType::Nil; }
    bool is_list() const {
        return get_type() == AtomType::Cons || get_type() == AtomType::Nil;
    }
    bool is_pair() const { return get_type() == AtomType::Cons && value != 0; }
};

inline Atom make_env(const Env* e) {
    return Atom{ reinterpret_cast<uintptr_t>(e) };
}

inline Atom make_boolean(const bool b) {
    return Atom{BOOL | (static_cast<uintptr_t>(b) << TAG_BITS)};
}

inline Atom make_nil() { return Atom{NIL}; }

inline Atom make_integer(const int64_t i) {
    return Atom{INTEGER | (static_cast<uint64_t>(i) << TAG_BITS)};
}

inline Atom make_cons(const Cons *c) {
    if (!c) {
        return make_nil();
    }
    return Atom{reinterpret_cast<uintptr_t>(c)};
}

inline Atom make_symbol(const Symbol s) {
    return Atom{SYMBOL |
                (static_cast<uintptr_t>(s.interned_value) << TAG_BITS)};
}

inline Atom symbol(const std::string& s) {
    return make_symbol(Symbol::from(s));
}

inline Atom make_lambda(const Lambda *l) {
    return Atom{reinterpret_cast<uintptr_t>(l)};
}

inline Atom make_string(const String *s) {
    return Atom{reinterpret_cast<uintptr_t>(s)};
}

static_assert(sizeof(Atom) == 8);
static_assert(std::is_pod<Atom>());

struct Cons {
    Atom  car;
    Cons *cdr;

    static Cons from(Atom car, Cons *cdr = nullptr) { return Cons{car, cdr}; }

    Cons* tail() {
        for(auto c : *this) {
            if(!c->cdr) {
                return c;
            }
        }
        return this;
    }

    class iterator {
        Cons *node;

      public:
        iterator(Cons *c) : node(c) {}

        using difference_type = ptrdiff_t;
        using value_type = Cons *;
        using pointer = const Cons **;
        using reference = const Cons *&;
        using iterator_category = std::forward_iterator_tag;

        iterator &operator++() {
            node = node->cdr;
            return *this;
        }
        iterator operator++(int) {
            auto r = *this;
            ++(*this);
            return r;
        }

        bool operator==(iterator other) const { return node == other.node; }

        bool operator!=(iterator other) const { return node != other.node; }

        Cons *operator*() { return node; }
        Cons *operator->() { return node; }
    };

    class const_iterator {
        const Cons *node;

      public:
        const_iterator(const Cons *c) : node(c) {}

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

        bool operator==(const_iterator other) const {
            return node == other.node;
        }

        bool operator!=(const_iterator other) const {
            return node != other.node;
        }

        const Cons *operator*() { return node; }
        const Cons *operator->() { return node; }
    };

    const_iterator begin() const { return const_iterator(this); }

    const_iterator end() const { return const_iterator(nullptr); }

    iterator begin() { return iterator(this); }

    iterator end() { return iterator(nullptr); }

    bool is_end() const { return cdr; }

    // O(n)
    int length() const {
        int sum = 0;
        for (auto i : *this) {
            ++sum;
        }
        return sum;
    }
};

static_assert(std::is_pod<Cons>());

bool equalsp(const Atom a, const Atom b);

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

class Env;

struct Argument {
    Symbol symbol;
    bool   is_closed_over;

};

inline std::vector<Argument>* make_arguments(Cons *args) {
    auto out = new std::vector<Argument>();
    out->reserve(args->length());

    for( auto i : *args) {
        out->push_back(Argument{ .symbol = i->car.symbol(), .is_closed_over = false } );
    }
    out->shrink_to_fit();
    return out;
}

struct Lambda {
    Cons *body;
    Env  *env;

    std::vector<Argument> *arguments;
    std::string           *native_name;
    void                  *function_pointer;
    bool                   is_macro;

    void visit();
};

static_assert(std::is_pod<Lambda>());

} // namespace minou

namespace fmt {

template<> struct formatter<minou::Argument> {
    template <typename ParseContext> constexpr auto parse(ParseContext &ctx) {
        return ctx.begin();
    }

    template <typename FormatContext>
    auto format(const minou::Argument &a, FormatContext &ctx) {
        return format_to(ctx.begin(), "[{} closed_over: {}]", a.symbol.string(), a.is_closed_over);
    }
};

template<> struct formatter<std::vector<minou::Argument>> {
    template <typename ParseContext> constexpr auto parse(ParseContext &ctx) {
        return ctx.begin();
    }

    template <typename FormatContext>
    auto format(const std::vector<minou::Argument> &v, FormatContext &ctx) {
        // return format_to(ctx.begin(), "[{} closed_over: {}]", a.symbol.string(), a.is_closed_over);
        auto it = format_to(ctx.begin(), "(");
        for( auto i = v.begin() ; i != v.end() ; ) {
            it = format_to(it, "{}", *i);
            if( ++i != v.end()) {
                it = format_to(it, " ");
            }
        }
        return format_to(it, ")");
    }
};


template <> struct formatter<minou::Lambda> {
    template <typename ParseContext> constexpr auto parse(ParseContext &ctx) {
        return ctx.begin();
    }

    template <typename FormatContext>
    auto format(const minou::Lambda &a, FormatContext &ctx) {
        return format_to(ctx.begin(), "(lambda {} {})", *a.arguments,
                         minou::make_cons(a.body));
    }
};
} // namespace fmt

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
        case minou::AtomType::Cons: {
            auto it = ctx.out();
            it = fmt::format_to(it, "(");
            for (auto c : *a.cons()) {
                it = fmt::format_to(it, "{}", c->car);
                if (c->cdr) {
                    it = fmt::format_to(it, " ");
                }
            }
            return format_to(it, ")");
        }
        case minou::AtomType::Symbol:
            return format_to(ctx.begin(), a.symbol().string());
        case minou::AtomType::String:
            return format_to(ctx.begin(), "\"{}\"", *a.string());
        case minou::AtomType::Lambda: {
            return format_to(ctx.begin(), "{}", *a.lambda());
        }
        case minou::AtomType::Nil:
            return format_to(ctx.begin(), "nil");
        case minou::AtomType::Env:
            return format_to(ctx.begin(), "env");
        case minou::AtomType::Boolean:
            return format_to(ctx.begin(), (a.boolean() ? "#t" : "#f"));
        }

        return format_to(ctx.begin(), "invalid type");
    }
};

template <> struct formatter<minou::AtomType> {
    template <typename ParseContext> constexpr auto parse(ParseContext &ctx) {
        return ctx.begin();
    }

    template <typename FormatContext>
    auto format(const minou::AtomType a, FormatContext &ctx) {
        return format_to(ctx.begin(), "{}", minou::atom_type_string(a));
    }
};

template <> struct formatter<minou::Cons> {
    template <typename ParseContext> constexpr auto parse(ParseContext &ctx) {
        return ctx.begin();
    }

    template <typename FormatContext>
    auto format(const minou::Cons &c, FormatContext &ctx) {
        return format_to(ctx.begin(), "{}", minou::make_cons(&c));
    }
};
} // namespace fmt

#endif

#include "parser.hpp"
#include <cerrno>
#include <cstdlib>
#include <string>
#include <vector>

namespace minou {

static std::optional<int64_t> parse_integer(const std::string &s) {
    char *end;

    errno = 0;
    int64_t i = strtol(s.c_str(), &end, 10);
    if (errno != 0) {
        return {};
    }

    if (end != s.c_str() + s.size()) {
        return {};
    }

    if (end == s.c_str()) {
        return {};
    }

    return i;
}

class Buffer {
  public:
    Buffer(const std::string_view &s) : buffer(s) {}

    void read_to_new_line() {
        for (;;) {
            int c = next();
            if (c == '\n' || c == EOF) {
                return;
            }
        }
    }

    int peek() const {
        if (position >= buffer.size()) {
            return EOF;
        }
        return buffer[position];
    }

    int next() {
        if (position >= buffer.size()) {
            return EOF;
        }
        return buffer[position++];
    }

  private:
    const std::string_view buffer;
    size_t position = 0;
};

static Result<Atom> error(const char *s) { return std::string(s); }

static Atom get_parse_atom(const Result<Atom> &p) { return std::get<Atom>(p); }

struct Parser {
    Buffer buff;
    Memory &memory;

    Result<Atom> quote_atom(Atom a) {
        std::vector<Atom> lis{make_symbol(Symbol::from("quote")), a};
        return make_cons(memory.make_list(lis));
    }

    std::optional<std::string> read_value() {
        std::vector<char> out;

        for (;;) {
            int c = buff.peek();

            switch (c) {
            case EOF:
                if (out.size() > 0) {
                    return std::string(out.data(), out.size());
                }
                return {};
            default:
                if (!isspace(c) && c != ')') {
                    buff.next();
                    out.push_back(c);
                } else {
                    return std::string(out.data(), out.size());
                }
            }
        }
    }

    Result<Atom> parse_list() {
        std::vector<Atom> list;

        for (;;) {
            int c = buff.peek();
            if (c == ')') {
                buff.next();
                break;
            } else if (c == EOF) {
                return error("eof while reading list");
            } else {
                if (isspace(c)) {
                    buff.next();
                } else {
                    auto atom = parse_atom();
                    if (is_error(atom)) {
                        return atom;
                    }
                    list.push_back(get_parse_atom(atom));
                }
            }
        }
        return make_cons(memory.make_list(list));
    }

    Result<Atom> read_string() {
        std::vector<char> out;

        for (;;) {
            int c = buff.peek();

            switch (c) {
            case '\\': {
                buff.next();
                int c = buff.peek();
                switch (c) {
                case EOF:
                    return "eof";
                case 'n':
                    out.push_back('\n');
                    break;
                case 't':
                    out.push_back('\t');
                    break;
                case 'r':
                    out.push_back('\r');
                    break;
                case '0':
                    out.push_back(0);
                    break;
                case 'a':
                    out.push_back('\a');
                    break;
                case 'e':
                    out.push_back('\e');
                    break;
                default:
                    out.push_back(c);
                }
                buff.next();
            } break;
            case '"':
                buff.next();
                return make_string(memory.alloc_string(out.data(), out.size()));
            case EOF:
                return error("eof");
            default:
                out.push_back(buff.next());
            }
        }
    }

    Result<Atom> parse_atom() {
        for (;;) {
            int c = buff.peek();
            switch (c) {
            case EOF:
                return error("eof");
            case '\'': {
                buff.next();
                auto result = parse_atom();
                if (is_error(result)) {
                    return result;
                }
                return quote_atom(get_parse_atom(result));
            } break;
            case '(':
                buff.next();
                return parse_list();
            case ';':
                buff.next();
                buff.read_to_new_line();
                break;
            case ',': {
                buff.next();
                if( buff.peek() == '@') {
                    buff.next();
                    auto a = parse_atom();
                    if(is_error(a))
                        return a;
                    return make_cons(memory.make_list( { symbol("splice"), get_value(a)}));
                } else {
                    auto a = parse_atom();
                    if(is_error(a))
                        return a;
                    return make_cons(memory.make_list( { symbol("unquote"), get_value(a)}));
                }
            } break;
            case '`': {
                buff.next();
                auto a = parse_atom();
                if(is_error(a))
                    return a;
                return expand_quasiquote(get_value(a));
            } break;
            default:
                if (isspace(c)) {
                    buff.next();
                } else {
                    return read_atom();
                }
            }
        }
        throw std::runtime_error("invalid parse");
    }

    Result<Atom> expand_quasiquote(Atom a) {
        if(!a.is_pair()) {
            return make_cons(memory.make_list({ symbol("quote"), a}));
        }

        auto list = a.cons();

        if(list->car == symbol("unquote")) {
            return list->cdr->car;
        } else if(list->car == symbol("quasiquote")) {
            auto qq = expand_quasiquote(list->cdr->car);
            if(is_error(qq)) return qq;

            return expand_quasiquote(get_value(qq));
        }else if(list->car.is_list()) {
            if(list->car.cons()->car == symbol("splice")) {
                auto qq = expand_quasiquote(make_cons(list->cdr));
                if( is_error(qq)) return qq;

                return make_cons(memory.make_list({
                            symbol("append"),
                            list->car.cons()->cdr->car,
                            get_value(qq)}));
            } else {
                auto c = expand_quasiquote(list->car);
                if( is_error(c)) return c;
                auto cc = expand_quasiquote(make_cons(list->cdr));
                if( is_error(cc)) return cc;
                return make_cons(memory.make_list({
                            symbol("cons"),
                            get_value(c),
                            get_value(cc
                            )
                        }));
            }
        } else {
            auto c = expand_quasiquote(list->car);
            if (is_error(c))
                return c;
            auto cc = expand_quasiquote(make_cons(list->cdr));
            if (is_error(cc))
                return cc;
            return make_cons(memory.make_list(
                {symbol("cons"), get_value(c), get_value(cc)}));
        }
    }

    Result<Atom> read_atom() {
        if (buff.peek() == '"') {
            buff.next();
            return read_string();
        }
        auto result = read_value();
        if (!result.has_value()) {
            return error("EOF");
        }

        auto v = result.value();

        if (v == "nil") {
            return make_nil();
        } else if (v == "#t") {
            return make_boolean(true);
        } else if (v == "#f") {
            return make_boolean(false);
        }

        if (v.size() == 0) {
            return error("invalid atom size");
        }

        if (isdigit(v[0]) || v[0] == '-') {
            auto r = parse_integer(v);
            if (r.has_value()) {
                return make_integer(r.value());
            }
        }
        return make_symbol(Symbol::from(v));
    }
};

Result<Atom> parse(Memory &mem, const std::string_view &s) {
    Parser p{s, mem};
    return p.parse_atom();
}

} // namespace minou

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

static ParseResult error(const char *s) { return std::string(s); }

static Atom get_parse_atom(const ParseResult &p) { return std::get<Atom>(p); }

struct Parser {
    Buffer buff;
    Memory &memory;

    ParseResult quote_atom(Atom a) {
        std::vector<Atom> lis{Symbol("quote"), a};
        return memory.make_list(lis);
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

    ParseResult parse_list() {
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
        return memory.make_list(list);
    }

    ParseResult read_string() {
        std::vector<char> out;

        for (;;) {
            int c = buff.peek();

            switch (c) {
            case '\\': {
                buff.next();
                int c = buff.peek();
                switch (c) {
                case EOF:
                    return error("eof");
                default:
                    out.push_back(c);
                }
            } break;
            case '"':
                buff.next();
                return memory.alloc<String>(
                    std::string(out.data(), out.size()));
            case EOF:
                return error("eof");
            default:
                out.push_back(buff.next());
            }
        }
    }

    ParseResult parse_atom() {
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
            }
            case '(':
                buff.next();
                return parse_list();
            case ';':
                buff.next();
                buff.read_to_new_line();
                break;
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

    ParseResult read_atom() {
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
            return Atom(Boolean(true));
        } else if (v == "#f") {
            return Atom(Boolean(false));
        }

        if (v.size() == 0) {
            return error("invalid atom size");
        }

        if (isdigit(v[0]) || v[0] == '-') {
            auto r = parse_integer(v);
            if (r.has_value()) {
                return Atom(r.value());
            }
        }
        return Symbol(v);
    }
};

ParseResult parse(Memory &mem, const std::string_view &s) {
    Parser p{Buffer(s), mem};
    return p.parse_atom();
}

} // namespace minou

#ifndef PARSER_H_
#define PARSER_H_

#include "base.hpp"
#include "memory.hpp"
#include <ios>
#include <string>
#include <fstream>

namespace minou {

class Buffer {
  public:
    void read_to_new_line() {
        for (;;) {
            int c = next();
            if (c == '\n' || c == EOF) {
                return;
            }
        }
    }

    virtual int peek() const = 0;
    virtual int next() = 0;
};

class StreamBuffer : public Buffer {
    std::istream &in;

  public:
    StreamBuffer(std::istream &in) : in(in) {}

    int peek() const {
        if (in.eof()) {
            return EOF;
        }
        return in.peek();
    }

    int next() {
        if (in.eof()) {
            return EOF;
        }
        return in.get();
    }
};

class FileBuffer : public StreamBuffer {
    std::ifstream in;
public:
  FileBuffer(const std::string &s) : in(s), StreamBuffer(in) {}
};

class StringBuffer : public Buffer {
  public:
    StringBuffer(const std::string_view s) : buffer(s) {}

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

Result<Atom> parse(Memory &, Buffer &b);

inline Result<Atom> parse(Memory &m, const std::string_view s) {
    StringBuffer sb(s);
    return parse(m, sb);
}

static Result<Atom> error(const char *s) { return std::string(s); }

} // namespace minou

#endif

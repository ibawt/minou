#include <cstdio>
#include <stdexcept>
#include <vector>
#include "parser.hpp"

namespace minou {
class Buffer
{
public:
  Buffer(const char *buffer, const size_t len) : buffer(buffer), len(len) {}

  int peek() const {
    if (position >= len) {
      return EOF;
    }
    return buffer[position];
  }

  int next() {
    if(position >= len) {
      return EOF;
    }
    return buffer[position++];
  }
private:
  const char  *buffer;
  const size_t len;
  size_t       position = 0;
};

static void read_to_new_line(Buffer& buff)
{
  for(;;) {
    int c = buff.next();
    if ( c == '\n' || c == EOF) {
      return;
    }
  }
}

static Atom parse_atom(Buffer& buff);

static Atom parse_list(Buffer& buff)
{
  std::vector<Atom> list;

  for(;;) {
    int c = buff.peek();
    if(c ==  ')') {
      buff.next();
      break;
    } else if(c == EOF) {
      throw ParseException("eof while reading list");
    } else {
      if( isspace(c)) {
        buff.next();
      } else {
        auto atom = parse_atom(buff);
        list.push_back(atom);
      }
    }
  }
  return make_list(list);
}


static Atom quote_atom(Atom a)
{
  auto l = make_list({make_symbol("quote"), a});
  printf("l = %s\n", l.to_string().c_str());
  return l;
}

static std::string read_value(Buffer& buff)
{
  std::vector<char> out;

  for(;;) {
    int c = buff.peek();

    switch(c) {
    case EOF:
      if(out.size() > 0) {
        return std::string(out.data(), out.size());
      }
      throw ParseException("value eof");
    default:
      if(!isspace(c) && c != ')') {
        buff.next();
        out.push_back(c);
      } else {
        return std::string(out.data(), out.size());
      }
    }
  }
}

static Atom read_string(Buffer& buff)
{
  std::vector<char> out;

  for (;;) {
    int c = buff.peek();

    switch(c) {
    case '\\':
      {
        buff.next();
        int c = buff.peek();
        switch(c) {
        case EOF:
          throw ParseException("eof");
        default:
          out.push_back(c);
        }
      }
      break;
    case '"':
      buff.next();
      return make_string(std::string(out.data(), out.size()));
    case EOF:
      throw ParseException("eof");
    default:
      out.push_back(buff.next());
    }
  }
}

static bool parse_integer(const std::string& s, int64_t *i)
{
  errno = 0;
  char *end;

  *i = strtol(s.c_str(), &end, 10);
  if (errno != 0 ) {
    return false;
  }

  if (end != s.c_str() + s.size()) {
    return false;
  }

  if( end == s.c_str() ) {
    return false;
  }

  return true;
}

static Atom read_atom(Buffer& buff)
{
  if(buff.peek() == '"') {
    buff.next();
    return read_string(buff);
  }
  auto v = read_value(buff);

  if(v == "nil") {
    return make_nil();
  } else if(v == "#t") {
    return Atom(true);
  }
  else if( v == "#f") {
    return Atom(false);
  }

  if (v.size() == 0 ) {
    throw ParseException("I think this invalid");
  }

  if (isdigit(v[0]) || v[0] == '-') {
    int64_t i;
    if(parse_integer(v, &i)) {
      return Atom(i);
    }
  }

  return make_symbol(v);
}

static Atom parse_atom(Buffer& buff) {
  for (;;) {
    int c = buff.peek();
    switch( c ) {
    case EOF:
      throw ParseException("eof in parse_atom");
    case '\'':
      {
        buff.next();
        return quote_atom(parse_atom(buff));
      }
    case '(':
      buff.next();
      return parse_list(buff);
    case ';':
      buff.next();
      read_to_new_line(buff);
      break;
    default:
      if (isspace(c)) {
        buff.next();
      } else {
        return read_atom(buff);
      }
    }
  }
  throw std::runtime_error("invalid parse");
}


Atom parse(const char* buffer,const size_t len)
{
  Buffer buff(buffer,len);

  return parse_atom(buff);
}
}

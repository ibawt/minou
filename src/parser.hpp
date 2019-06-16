#pragma once

#include <stdexcept>
#include <variant>
#include "minou.hpp"


namespace minou {

class ParseException : public std::runtime_error
{
public:
  ParseException(const char *s) : std::runtime_error(s) {}
};

Atom parse(const char*, size_t);
}

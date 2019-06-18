#ifndef PARSER_H_
#define PARSER_H_

#include <stdexcept>
#include <variant>

#include "minou.hpp"
#include "memory.hpp"

namespace minou {

using ParseResult = std::variant<Atom, std::string>;
ParseResult parse(Memory&, const std::string&);

}

#endif

#ifndef PARSER_H_
#define PARSER_H_

#include <stdexcept>
#include <variant>
#include "memory.hpp"
#include "minou.hpp"
#include <string>

namespace minou {

using ParseResult = Result<Atom>;

ParseResult parse(Memory &, const std::string_view &);

} // namespace minou

#endif

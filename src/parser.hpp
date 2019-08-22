#ifndef PARSER_H_
#define PARSER_H_

#include "memory.hpp"
#include "base.hpp"
#include <string>

namespace minou {

Result<Atom> parse(Memory &, const std::string_view &);

} // namespace minou

#endif

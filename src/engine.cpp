#include "engine.hpp"
#include "parser.hpp"
#include <string>
#include <sstream>
#include <fstream>

namespace minou {

Result<Atom> Engine::parse(const std::string_view &s) {
    return ::minou::parse(memory, s);
}

Result<Atom> Engine::eval_file(const std::string& s) {
    std::ifstream input(s.c_str());
    std::stringstream buff;

    buff << input.rdbuf();

    return eval(buff.str());
}

Result<Atom> Engine::eval(const std::string_view &s) {
    memory.mark_and_sweep(global);

    auto atom = ::minou::parse(memory, s);
    if (is_error(atom)) {
        return atom;
    }

    return native_engine.execute(get_value(atom));
}

} // namespace minou

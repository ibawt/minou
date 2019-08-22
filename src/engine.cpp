#include "engine.hpp"
#include "parser.hpp"
#include <string>

namespace minou {

Result<Atom> Engine::parse(const std::string_view &s) {
    return ::minou::parse(memory, s);
}

Result<Atom> Engine::eval(const std::string_view &s) {
    memory.mark_and_sweep(&global);

    auto atom = ::minou::parse(memory, s);
    if (is_error(atom)) {
        return atom;
    }

    return nativeEngine.execute(get_value(atom));
}

} // namespace minou

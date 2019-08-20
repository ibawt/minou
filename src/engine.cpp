#include "engine.hpp"
#include "eval.hpp"
#include "parser.hpp"
#include <string>

namespace minou {

Result<Atom> Engine::parse(const std::string_view &s) {
    return ::minou::parse(memory, s);
}

Result<Atom> Engine::eval(const std::string_view &s) {
    memory.mark_and_sweep(global.get());

    auto atom = ::minou::parse(memory, s);

    if (is_error(atom)) {
        return atom;
    }

    return nativeEngine.execute(get_value(atom));
    // BottomCont cont;

    // return minou::eval(this, get_atom(atom), global.get(), &cont);
}

} // namespace minou

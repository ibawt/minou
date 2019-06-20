#include "engine.hpp"
#include "eval.hpp"
#include "parser.hpp"
#include <string>

namespace minou {

EvalResult Engine::eval(const std::string_view &s) {
    memory.mark_and_sweep(&global);

    auto atom = parse(memory, s);

    if (is_error(atom)) {
        return atom;
    }

    BottomCont cont;

    return minou::eval(this, get_atom(atom), &global, &cont);
}

} // namespace minou

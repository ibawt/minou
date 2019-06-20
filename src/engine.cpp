#include "engine.hpp"
#include "parser.hpp"
#include "eval.hpp"

namespace minou {

EvalResult Engine::eval(const std::string_view& s)
{
    memory.mark_and_sweep(&global);

    auto atom = parse(memory, s);

    if (is_error(atom)) {
        return atom;
    }

    BottomCont cont;

    return minou::eval(this, get_atom(atom), &global, &cont); 
}

}

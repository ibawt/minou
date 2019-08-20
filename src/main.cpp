                                                \
#include <readline/readline.h>

#include "base.hpp"
#include "eval.hpp"
#include "main.hpp"
#include "minou.hpp"
#include "parser.hpp"
#include <cstdlib>
#include "engine.hpp"
#include "compiler.hpp"

using namespace minou;

int main() {
    Engine engine;

    for (;;) {
        auto line = readline(">");

        if (!line) {
            break;
        }

        auto result = engine.eval(line);

        if (!is_error(result)) {
            fmt::print("-> {}\n", get_value(result));
        } else {
            fmt::print("ERR: {}\n", get_error(result));
        }

        free(line);
    }

    fmt::print("Bye!\n");

    return 0;
}

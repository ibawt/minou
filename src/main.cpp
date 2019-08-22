#include "engine.hpp"
#include <cstdlib>
#include <readline/readline.h>

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

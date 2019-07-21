                                                \
#include <readline/readline.h>

#include "base.hpp"
#include "eval.hpp"
#include "main.hpp"
#include "minou.hpp"
#include "parser.hpp"
#include <string>
#include <cstdlib>
#include "vm.hpp"
#include "compiler.hpp"

using namespace minou;

int main() {
    VM vm;

    for (;;) {
        auto line = readline(">");

        if (!line) {
            break;
        }

        auto result = vm.run(line);

        if (!is_error(result)) {
            fmt::print("-> {}\n", get_value(result).to_string());
        } else {
            fmt::print("ERR: {}\n", get_error(result));
        }

        free(line);
    }

    fmt::print("Bye!\n");

    return 0;
}

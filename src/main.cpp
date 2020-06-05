#include "engine.hpp"
#include <cstdlib>
#include <getopt.h>
#include <readline/readline.h>

using namespace minou;

extern int CompilerVerbosity;

int main(int argc, char **argv) {
    Engine engine;

    int script_mode = 0;
    struct option long_options[] = {
        {"script", no_argument, &script_mode, 1},
        {"verbosity", required_argument, 0, 'v'},
        {0, 0, 0, 0}};

    int option_index = 0;
    for (;;) {
        int c = getopt_long(argc, argv, "sv:", long_options, &option_index);
        if (c == -1) {
            break;
        }
        switch (c) {
        case 0:
            break;
        case 'v':
            CompilerVerbosity = atoi(optarg);
            break;
        }
    }

    if (optind < argc) {
        try {
            auto x = engine.eval_file(argv[optind]);
            if (is_error(x)) {
                fmt::print("LOAD: {}\n", get_error(x));
                return 1;
            }
            if (script_mode) {
                return get_value(x).is_false() ? 1 : 0;
            }
        } catch (...) {
            fmt::print("ERROR: catch all\n");
            if (script_mode) {
                return 1;
            }
        }
    }

    if (script_mode) {
        return 0;
    }

    for (;;) {
        auto line = readline(">");

        if (!line) {
            break;
        }

        try {
            auto result = engine.eval(line);

            if (!is_error(result)) {
                fmt::print("-> {}\n", get_value(result));
            } else {
                fmt::print("ERR: {}\n", get_error(result));
            }
        } catch (...) {
            fmt::print("catchall caluse in main!:\n");
        }

        free(line);
    }

    fmt::print("\nBye!\n");

    return 0;
}

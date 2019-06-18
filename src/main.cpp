#include <readline/readline.h>
#include <iostream>


#include "base.hpp"
#include "main.hpp"
#include "minou.hpp"
#include "parser.hpp"
#include "eval.hpp"

using namespace minou;
using std::cout;
using std::endl;

int main()
{
    Engine engine;

    for(;;) {
        auto line = readline(">");

        if(!line) {
            break;
        }

        auto result = engine.eval(line);

        if (!is_error(result)) {
            cout << get_value(result).to_string() << endl;
        } else {
            cout << "ERR: " <<  get_error(result) << endl;
        }

        free(line);
    }

    cout << "Bye!" << endl;

    return 0;
}

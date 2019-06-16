#include <readline/readline.h>
#include <iostream>


#include "main.hpp"
#include "minou.hpp"
#include "parser.hpp"
#include "eval.hpp"

using namespace minou;
using std::cout;
using std::endl;

int main()
{
  auto e = default_env();
  BottomCont cont;

  for(;;) {
    auto line = readline(">");

    if(!line) {
      break;
    }

    try {
      auto a = parse(line, strlen(line));

      auto result = eval(a, &e, &cont);

      if (!is_error(result)) {
        cout << std::get<Atom>(result).to_string() << endl;
      } else {
        cout << "ERR: " <<  std::get<std::string>(result) << endl;
      }

    } catch(const ParseException& e) {
      std::cout << "ERROR: " << e.what() << std::endl;
    }
  }

  cout << "Bye!" << endl;

  return 0;
}

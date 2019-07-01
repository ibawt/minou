#include "symbol_intern.hpp"
#include <thread>
#include <string>

namespace minou {

static SymbolInterner sym_interner;

const std::string& symbol_to_string(int sym) {
    return sym_interner.get_string(sym) ;
}

int intern(const std::string& s) {
    return sym_interner.intern(s);
}

}

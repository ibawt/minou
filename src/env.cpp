#include "env.hpp"
#include "memory.hpp"

namespace minou {

void Env::visit() {
    minou::visit(reinterpret_cast<const char*>(this));
    for( auto& [key, value] : map ) {
        mark_atom(value);
    }
    if(parent) {
        parent->visit();
    }
}

} // namespace minou

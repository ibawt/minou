#include "memory.hpp"

namespace minou {

void Memory::free_all()
{
    for( auto h = head ; h ;) {
        auto t = h;
        h = h->next;
        free(t);
    }
}
}

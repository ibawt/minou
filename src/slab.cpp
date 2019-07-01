#include "slab.hpp"

namespace minou {
char *Slab::get() {
    if(!free_list.empty()) {
        auto h = free_list.back();
        h->set_used();
        free_list.pop_back();
        return h->buffer;
    }

    SlabNode *h = index ? index : (SlabNode *)buffer;
    for (;;) {
        if (h->is_free()) {
            h->set_used();
            return h->buffer;
        }
        if ((char *)h > buffer + buffer_len) {
            assert(false);
        }
        h = (SlabNode *)((char *)h + (sizeof(SlabNode) + element_size));
    }
    assert(false);
    return nullptr;
}
} // namespace minou

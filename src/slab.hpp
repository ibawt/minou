#ifndef SLAB_H_
#define SLAB_H_

#include <stddef.h>
#include <memory>
#include <assert.h>
#include <string.h>
#include <cstring>
#include <cstdlib>
#include <list>

namespace minou {

class Slab {
public:
    Slab(size_t element_size, size_t num) : element_size(element_size), max_elements(num) {
        buffer_len = (sizeof(SlabNode) + element_size) * num;
        buffer = (char *)malloc(buffer_len);
        memset(buffer, 0, buffer_len);
    }
    ~Slab() {
        ::free(buffer);
    }

    char* get();
    void free(char *address) {
        SlabNode *h = (SlabNode*) (address - offsetof(SlabNode, buffer));
        h->set_free();
        free_list.push_front(h);
    }
private:
  struct SlabNode {
      inline static const int FREE = 0;
      inline static const int USED = 1;

      int64_t flags;
      char buffer[];

      void set_free() {
          flags = FREE;
      }

      void set_used() {
          flags = USED;
      }

      bool is_used() const {
          return flags == USED;
      }

      bool is_free() const {
          return flags == FREE;
      }
  };


  SlabNode *index = nullptr;
  std::list<SlabNode*> free_list;
  size_t buffer_len;
  size_t element_size;
  size_t max_elements;
  char *buffer;
};


}

#endif

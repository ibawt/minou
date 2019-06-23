#ifndef SYMBOL_INTERN_H_
#define SYMBOL_INTERN_H_

#include <assert.h>
#include <vector>
#include <unordered_map>
#include <string>

namespace minou {

class SymbolInterner {
    std::vector<std::string> table;
    std::unordered_map<std::string, int> string_index_map;
  public:
    const std::string_view get_string(int id) const {
        assert(id >= 0 && id < table.size());
        return table[id];
    }

    int intern(const std::string& s) {
        auto sym = string_index_map.find(s);

        if( sym == string_index_map.end()) {
            table.push_back(s);

            string_index_map[s] = table.size() -1;
            return table.size() -1;
        } else {
            return sym->second;
        }
    }
};
} // namespace minou

#endif

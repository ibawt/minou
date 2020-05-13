#include "engine.hpp"
#include "parser.hpp"
#include <string>
#include <sstream>
#include <fstream>

namespace minou {

Result<Atom> Engine::parse(const std::string_view &s) {
    StringBuffer buf(s);
    return ::minou::parse(memory, buf);
}

Result<Atom> Engine::eval_file(const std::string& s) {
    try {
        FileBuffer buf(s);
        Atom last_val;
        std::vector<Atom> vals{symbol("begin")};
        for(;;) {
            auto atom = ::minou::parse(memory, buf);
            if (is_error(atom)) {
                if (buf.peek() == EOF) {
                    break;
                }
                return atom;
            }

            vals.push_back(get_value(atom));
        }
        if(vals.size() < 2) {
            return "file not found or no atoms within";
        }
        auto e = make_cons(memory.make_list(vals));

       return native_engine.execute(e);
    } catch(std::ifstream::failure e) {
        return e.what();
    }
}

Result<Atom> Engine::eval(const std::string_view &s) {
    // TODO: we need to mark stack entries, gcstate or w/e
    // memory.mark_and_sweep(global);
    auto atom = ::minou::parse(memory, s);
    if (is_error(atom)) {
        return atom;
    }

    return native_engine.execute(get_value(atom));
}

} // namespace minou

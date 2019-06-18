#ifndef ENV_H_
#define ENV_H_

#include <optional>
#include <map>
#include <functional>
#include <memory>

#include "base.hpp"
#include "types.hpp"

namespace minou {

class Env
{
public:
    Env(std::shared_ptr<Env> p) : parent(p) {}
    Env() {
        default_env();
    }

    std::optional<Atom> lookup(const Symbol& key) {
        auto f = map.find(key);

        if(f == map.end()) {
            if( parent.has_value() ) {
                return parent.value()->lookup(key);
            }
            return {};
        }
        return f->second;
    }

    void for_each(std::function<void(const Symbol&, Atom)> f) {
        for(auto [key, value] : map) {
            f(key, value);
        }
    }

    void set(const Symbol& key, Atom value) {
        map[key] = value;
    }

    Result<bool> extend(Cons *args, Cons* vars) {
        for(;;) {
            if ((args && !vars) ||  (!args && vars)) {
                return "wrong arity";
            }
            if(!(args && vars)) {
                break;
            }

            auto k = args->car;
            auto v = vars->car;

            if(!k.cons && !v.cons) {
                break;
            }

            if( k.type != AtomType::Symbol) {
                return "invalid argument type:" + k.cons->car.to_string();
            }

            set(*k.symbol, v);

            args = args->cdr;
            vars = vars->cdr;
        }
        return true;
    }
private:
    void default_env();

    std::map<const Symbol, Atom> map;
    std::optional<std::shared_ptr<Env>> parent;
};


}

#endif

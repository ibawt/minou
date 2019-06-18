#ifndef ENV_H_
#define ENV_H_

#include <optional>
#include <map>
#include <functional>

#include "base.hpp"
#include "types.hpp"

namespace minou {

class Env
{
public:
    Env(Env* parent) : parent(parent) {}
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

    std::variant<Env*, std::string> extend(Cons *args, Cons* vars) {
        Env *e = nullptr;

        for(;;) {
            if ((args && !vars) ||  (!args && vars)) {
                return std::string("wrong arity");
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
                return std::string("invalid argument type:" + k.cons->car.to_string()) ;
            }

            if(!e) {
                e = new Env();
            }
            e->set(*k.symbol, v);

            args = args->cdr;
            vars = vars->cdr;
        }
        return e;
    }
private:
    void default_env();

    std::map<const Symbol, Atom> map;
    std::optional<Env*> parent;
};


}

#endif

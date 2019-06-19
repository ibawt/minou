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
        auto f = map.find(key.string);

        if(f == map.end()) {
            if( parent.has_value() ) {
                return parent.value()->lookup(key);
            }
            return {};
        }
        return f->second;
    }

    bool update(const Symbol& key, Atom value) {
      auto t = this;

      for (;;) {
        auto f = t->map.find(key.string);

        if( f != t->map.end()) {
          f->second = value;
          return true;
        }

        if(parent.has_value()) {
          t = parent.value().get();
        } else {
          return false;
        }
      }
    }

    void for_each(std::function<void(const std::string&, Atom)> f) {
        for(auto [key, value] : map) {
            f(key, value);
        }
    }

    void set(const Symbol& key, Atom value) {
        map[key.string] = value;
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

    std::map<const std::string, Atom> map;
    std::optional<std::shared_ptr<Env>> parent;
};


}

#endif

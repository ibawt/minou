#ifndef ENV_H_
#define ENV_H_

#include <functional>
#include <map>
#include <memory>
#include <optional>

#include "base.hpp"
#include "types.hpp"
#include <string>

namespace minou {

class Env {
  public:
    std::optional<Atom> lookup(const Symbol &key) {
        auto f = map.find(key.interned_value);

        if (f == map.end()) {
            if (parent) {
                return parent->lookup(key);
            }
            return {};
        }
        return f->second;
    }

    void clear() {
        map.clear();
    }

    Env* get_parent() { return parent; }

    bool update(const Symbol &key, Atom value) {
        auto t = this;

        for (;;) {
            auto f = t->map.find(key.interned_value);

            if (f != t->map.end()) {
                f->second = value;
                return true;
            }

            if (parent) {
                t = parent;
            } else {
                return false;
            }
        }
    }

    void for_each(std::function<void(const std::string_view, Atom)> f) {
        for (auto [key, value] : map) {
            f(Symbol::from(key).string(), value);
        }
    }

    void set(const Symbol &key, Atom value) {
        map[key.interned_value] = value;
    }

    Result<std::monostate> extend(Cons *args, Cons *vars) {
        for (;;) {
            if ((args && !vars) || (!args && vars)) {
                return "wrong arity";
            }
            if (!(args && vars)) {
                break;
            }

            auto k = args->car;
            auto v = vars->car;

            if (k.is_nil() && v.is_nil()) {
                break;
            }

            if (k.get_type() != AtomType::Symbol) {
                return fmt::format("invalid argument type: {}", k.cons()->car);
            }

            set(k.symbol(), v);

            args = args->cdr;
            vars = vars->cdr;
        }
        return {};
    }
    void visit();

  private:
    Env(Env* p = nullptr) : parent(p) {}
    friend class Memory;

    std::map<int, Atom> map;
    Env                *parent;
};

} // namespace minou

#endif

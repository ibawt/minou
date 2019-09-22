#include "engine.hpp"
#include <vector>

#define API __attribute__((visibility("default")))
namespace minou {
extern "C" {
API int64_t env_set(Env *env, Atom sym, Atom value) {
    env->set(sym.symbol(), value);
    return sym.value;
}

API int64_t env_get(Env *env, Atom sym) {
    auto x = env->lookup(sym.symbol());
    if (x.has_value()) {
        return x.value().value;
    }
    return make_nil().value;
}

API int64_t make_list(Engine *e, int64_t count, ...)
{
    //TODO: if we compile this in reverse order we can avoid
    // the temporary list
    va_list args;
    va_start(args, count);

    std::vector<Atom> list;

    for(int i = 0 ; i < count; ++i) {
        Atom a = va_arg(args, Atom);
        list.push_back(a);
    }
    va_end(args);

    return make_cons(e->get_memory().make_list(list)).value;
}

API int64_t equalsp_ex(int count, ...) {
    va_list args;
    va_start(args, count);

    if(count <= 0 ) {
        return make_boolean(false).value;
    }

    auto a = va_arg(args, Atom);

    for( int i = 1 ; i < count ; ++i) {
        auto b = va_arg(args, Atom);
        if(!equalsp(a, b)) {
            return make_boolean(false).value;
        }
    }
    return make_boolean(true).value;
}

API int64_t builtin_cons(Engine *e, Atom value,  Atom list)
{
    return make_cons(e->get_memory().alloc_cons(value, list.cons())).value;
}

API int64_t builtin_append(int count, ...)
{
    va_list args;
    va_start(args, count);

    assert(count > 1);

    Cons *initial = va_arg(args, Cons*);
    Cons *tail = initial->tail();
    for (int i = 1; i < count; ++i) {
        auto a = va_arg(args, Atom);
        tail->cdr = a.cons();
        if (a.is_nil())
            break;
        tail = a.cons()->tail();
    }

    return (int64_t)initial;
}
}
} // namespace minou

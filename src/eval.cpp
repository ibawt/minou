#include "eval.hpp"
#include "base.hpp"
#include "engine.hpp"
#include "env.hpp"
#include <iostream>
#include <optional>
#include <string>
#include <sstream>

namespace minou {

std::string type_error(AtomType type, Atom value) {
    std::stringstream s;
    s << "type mismatch, expected: " << type;
    s << " got: " << value.get_type();

    return s.str();
}

#define CHECK_TYPE(type, value)                                                \
    if ((value).get_type() != type) {                                          \
        return type_error(type, value);                                        \
    }

using str = std::string;
using std::cout;
using std::endl;

EvalResult eval_args(Engine *engine, Atom e, EnvPtr, Continuation *k);
EvalResult eval_begin(Engine *engine, Atom a, EnvPtr, Continuation *k);

class SetCont : public Continuation {
  public:
    SetCont(Continuation *k, Atom n, EnvPtr env) : n(n), env(env), k(k) {}

    EvalResult resume(Engine *engine, Atom a) override {
        CHECK_TYPE(AtomType::Symbol, n);
        env->update(*n.symbol(), a);
        return k->resume(engine, a);
    }

  private:
    Atom n;
    EnvPtr env;
    Continuation *k;
};

class DefineCont : public Continuation {
  public:
    DefineCont(Continuation *k, Atom n, EnvPtr env) : n(n), env(env), k(k) {}

    EvalResult resume(Engine *engine, Atom a) override {
        CHECK_TYPE(AtomType::Symbol, n);
        env->set(*n.symbol(), a);
        return k->resume(engine, a);
    }

  private:
    Atom n;
    EnvPtr env;
    Continuation *k;
};

EvalResult Lambda::invoke(Engine *engine, Cons *args, EnvPtr env UNUSED,
                          Continuation *k) {
    Env e(this->env);
    auto r = e.extend(variables, args);

    if (is_error(r)) {
        return get_error(r).get_message();
    }

    auto result = eval_begin(engine, body, &e, k);
    return result;
}

class BeginCont : public Continuation {
  public:
    BeginCont(Continuation *k, Atom e, EnvPtr env) : k(k), e(e), env(env) {}

    EvalResult resume(Engine *engine, Atom a UNUSED) override {
        return eval_begin(engine, e, env, k);
    }

  private:
    Continuation *k;
    Atom e;
    EnvPtr env;
};

EvalResult eval_begin(Engine *engine, Atom a, EnvPtr env, Continuation *k) {
    if (!a.is_list()) {
        return str("invalid begin structure");
    }

    if (a.is_nil()) {
        return k->resume(engine, Atom());
    }

    if (!a.cons()->cdr) {
        return eval(engine, a.cons()->car, env, k);
    }

    BeginCont bc(k, a.cons()->cdr, env);
    return eval(engine, a.cons()->car, env, &bc);
}

class IfCont : public Continuation {
  public:
    IfCont(Continuation *k, Atom t, Atom f, EnvPtr env)
        : true_value(t), false_value(f), k(k), env(env) {}

    EvalResult resume(Engine *engine, Atom a) override {
        if (a.get_type() == AtomType::Boolean && !a.boolean()) {
            // only #f is false
            return eval(engine, false_value, env, k);
        }
        return eval(engine, true_value, env, k);
    }

  private:
    Atom true_value;
    Atom false_value;
    Continuation *k;
    EnvPtr env;
};

class ApplyCont : public Continuation {
  public:
    ApplyCont(Continuation *k, Atom f, EnvPtr env) : f(f), env(env), k(k) {}

    EvalResult resume(Engine *engine, Atom a) override {
        if (!a.is_list()) {
            return str("invalid argument");
        }

        switch (f.get_type()) {
        case AtomType::Primitive:
            return f.primitive()->invoke(engine, a.cons(), env, k);
        case AtomType::Lambda:
            return f.lambda()->invoke(engine, a.cons(), env, k);
        case AtomType::Continuation:
            return f.continuation()->invoke(engine, a.cons(), env, k);
        default:
            return str("invalid type for apply: " + f.to_string());
        }
    }

  private:
    Atom f;
    EnvPtr env;
    Continuation *k;
};

class GatherCont : public Continuation {
  public:
    GatherCont(Continuation *k, Atom v) : k(k), v(v) {}
    EvalResult resume(Engine *engine, Atom a) override {
        if (a.is_list()) {
            return k->resume(engine, engine->get_memory().alloc_cons(v, a.cons()));
        }
        return std::string("gather invalid structure");
    }

  private:
    Continuation *k;
    Atom v;
};

class ArgumentCont : public Continuation {
  public:
    ArgumentCont(Continuation *k, Atom e, EnvPtr env) : k(k), e(e), env(env) {}

    EvalResult resume(Engine *engine, Atom a) override {
        if (e.is_pair()) {
            GatherCont gc(k, a);
            return eval_args(engine, e.cons()->cdr, env, &gc);
        }
        return str("arg invalid structure: " + e.to_string());
    }

  private:
    Continuation *k;
    Atom e;
    EnvPtr env;
};

EvalResult eval_args(Engine *engine, Atom e, EnvPtr env, Continuation *k) {
    if (!e.is_list()) {
        return str("must be a list");
    }
    if (e.get_type() == AtomType::Nil) {
        // empty list
        return k->resume(engine, e);
    }
    auto ac = engine->get_memory().alloc<ArgumentCont>(k, e, env);
    // ArgumentCont ac(k, e, env);
    return eval(engine, e.cons()->car, env, ac);
}

class EvFunCont : public Continuation {
  public:
    EvFunCont(Continuation *k, Atom e, EnvPtr env) : e(e), env(env), k(k) {}

    EvalResult resume(Engine *engine, Atom a) override {
        ApplyCont ac(k, a, env);
        return eval_args(engine, e, env, &ac);
    }

  private:
    Atom e;
    EnvPtr env;
    Continuation *k;
};

class Catch : public Continuation {
    Continuation *k;
    Atom body;
    Env *env;

  public:
    Catch(Continuation *k, Atom body, Env *env) : k(k), body(body), env(env) {}

    Result<Atom> resume(Engine *engine, Atom a) override {
        return "not implemented";
    }
};

class LabeledCont : public Continuation {
    Continuation *k;
};

class Unwind {
  public:
    virtual Result<Atom> unwind(Engine *engine, Continuation *k, Atom a,
                                Env *env) = 0;
};

class BlockCont : public Continuation {
    Continuation *k;
    Atom label;

  public:
    BlockCont(Continuation *k, Atom label) : k(k), label(label) {}

    Result<Atom> resume(Engine *engine, Atom a) override {
        return "unimplemented";
    }
};

class ProtectReturn : public Continuation {
    Continuation *k;
    Atom value;

  public:
    ProtectReturn(Continuation *k, Atom a) : k(k), value(a) {}

    Result<Atom> resume(Engine *engine, Atom a) override {
        return k->resume(engine, value);
    }
};

class UnwindProtect : public Continuation {
    Continuation *k;
    Atom cleanup;
    Env *env;

  public:
    UnwindProtect(Continuation *k, Atom cleanup, Env *env)
        : k(k), cleanup(cleanup), env(env) {}

    Result<Atom> resume(Engine *engine, Atom a) override {
        ProtectReturn pr(k, a);

        return eval_begin(engine, cleanup, env, &pr);
    }
};

EvalResult eval_quote(Engine *engine, Atom a, Continuation *k) {
    return k->resume(engine, a);
}

bool has_at_least_n(Cons *cons, int desired) {
    for (int i = 0;; ++i) {
        if (!cons) {
            return i >= desired;
        }
        if (i >= desired) {
            return true;
        }
        cons = cons->cdr;
        ++i;
    }
}

Atom car(Cons *cons) { return cons->car; }

Atom cadr(Cons *cons) { return cons->cdr->car; }

Atom caddr(Cons *cons) { return cons->cdr->cdr->car; }

Atom cadddr(Cons *cons) { return cons->cdr->cdr->cdr->car; }

EvalResult eval_application(Engine *engine, Atom e, Atom ee, EnvPtr env,
                            Continuation *k) {
    EvFunCont cont(k, ee, env);
    return eval(engine, e, env, &cont);
}

EvalResult eval_variable(Engine *engine, const Symbol &s, EnvPtr &env,
                         Continuation *k) {
    auto v = env->lookup(s);
    if (v.has_value()) {
        return k->resume(engine, v.value());
    }
    return str("not found!");
}

Result<Atom> eval(Engine *engine, Atom a, EnvPtr env, Continuation *k) {
    switch (a.get_type()) {
    case AtomType::Cons:
        if (!a.cons()) {
            return "invalid list application";
        }

        if (a.cons()->car.get_type() == AtomType::Symbol) {

            assert(a.cons()->car.symbol());
            const auto &sym = *a.cons()->car.symbol();

            // IF
            if (sym == "if") {
                if (!has_at_least_n(a.cons(), 3)) {
                    return std::string("invalid list structure for if");
                }
                IfCont ifCont(k, caddr(a.cons()), cadddr(a.cons()), env);
                return eval(engine, a.cons()->cdr->car, env, &ifCont);
            } else if (sym == "define") {
                DefineCont sc(k, a.cons()->cdr->car, env);
                return eval(engine, a.cons()->cdr->cdr->car, env, &sc);
            } else if (sym == "set!") {
                SetCont sc(k, a.cons()->cdr->car, env);

                return eval(engine, a.cons()->cdr->cdr->car, env, &sc);
            }
            // QUOTE
            else if (sym == "quote") {
                if (!a.cons()->cdr) {
                    return std::string("invalid quote call");
                }
                return eval_quote(engine, a.cons()->cdr->car, k);
            }
            // BEGIN
            else if (sym == "begin") {
                return eval_begin(engine, a.cons()->cdr, env, k);
            }
            // LAMBDA
            else if (sym == "lambda") {
                if (!has_at_least_n(a.cons(), 3)) {
                    return std::string("invalid arity");
                }
                auto l = engine->get_memory().alloc<Lambda>(
                    a.cons()->cdr->car.cons(), a.cons()->cdr->cdr, env);
                return k->resume(engine, l);
            }
            // EVAL
            else {
                return eval_application(engine, a.cons()->car, a.cons()->cdr,
                                        env, k);
            }
        } else {
            return eval_application(engine, a.cons()->car, a.cons()->cdr, env,
                                    k);
        }
        break;
    case AtomType::Symbol:
        return eval_variable(engine, *a.symbol(), env, k);
        break;
    default:
        return eval_quote(engine, a, k);
    }

    return std::string("shouldn't get here");
}

} // namespace minou

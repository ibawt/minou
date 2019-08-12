#ifndef EVAL_H_
#define EVAL_H_

#include <functional>
#include <memory>
#include <optional>
#include <variant>

#include "base.hpp"
#include "env.hpp"
#include "memory.hpp"
#include "types.hpp"
#include <vector>

namespace minou {

class Engine;

using EvalResult = Result<Atom>;

inline Atom get_atom(const EvalResult &er) { return std::get<Atom>(er); }

class Continuation {
  public:
    virtual ~Continuation() {}
    virtual EvalResult resume(Engine *, Atom) = 0;

    Result<Atom> invoke(Engine *engine, Cons *args, Env *env, Continuation *k) {
        if (!has_only_n(args, 1)) {
            return "invalid arity";
        }

        return k->resume(engine, args->car);
    }

    virtual void visit() {
        ::minou::visit((char*)this);
    }
};

class BottomCont : public Continuation {
  public:
    EvalResult resume(Engine *, Atom a) override { return a; }

    void visit() override {}
};

class Env;
class VM;

class Procedure {
  public:
    virtual ~Procedure() {}
    virtual Result<Atom> invoke(Engine *, Cons *args, EnvPtr env,
                                Continuation *k) = 0;
    virtual Result<Atom> vm_call(VM*, int num_args) = 0;

    virtual void visit() {}
};

class Lambda : public Procedure {
  public:
    Lambda(Cons *variables, Cons *body, EnvPtr env)
        : variables(variables), body(body), env(env) {}

    Lambda(Cons *variables, Cons *body, EnvPtr env, std::vector<uint8_t> compiled_body)
        : variables(variables), body(body), env(env) , compiled_body(compiled_body) {}

    EvalResult invoke(Engine *, Cons *args, EnvPtr env,
                      Continuation *k) override;

    Result<Atom> vm_call(VM*, int num_args) override {
        return "not used";
    }

    void visit() override {
        minou::visit((char *)this);
        mark_atom(variables);
        mark_atom(body);
        mark(env);
    }

    Cons* get_arguments() const {
        return variables;
    }

    Cons* get_body() const { return body; }

    const std::vector<uint8_t>& get_compiled_body() const {  return compiled_body; }

    Env* get_env() const { return env; }

  private:
    std::vector<uint8_t> compiled_body;
    Cons *variables;
    Cons *body;
    EnvPtr env;
};

class VM;
using Applicative = EvalResult(Engine *, Cons *args, EnvPtr &env,
                               Continuation *k);
using VMCall = Result<Atom>(VM*, int);

class Primitive : public Procedure {
  public:
    Primitive(std::function<Applicative> x, std::function<VMCall> vm) : op(x), vm(vm) {}
    EvalResult invoke(Engine *eng, Cons *args, EnvPtr env,
                      Continuation *k) override {
        return op(eng, args, env, k);
    }

    Result<Atom> vm_call(VM* vm, int num_args) override {
        return this->vm(vm, num_args);
    }


    void visit() override {
        minou::visit((char *) this);
    }
  private:
    std::function<VMCall> vm;
    std::function<Applicative> op;
};

EvalResult eval(Engine *, Atom a, EnvPtr, Continuation *);
} // namespace minou

namespace fmt {
template <> struct formatter<minou::Lambda> {
    template <typename ParseContext> constexpr auto parse(ParseContext &ctx) {
        return ctx.begin();
    }

    template <typename FormatContext>
    auto format(const minou::Lambda &a, FormatContext &ctx) {
        return format_to(ctx.begin(), "(lambda {} {})", minou::Atom(a.get_arguments()),
                         minou::Atom(a.get_body()));
    }
};
} // namespace fmt

#endif

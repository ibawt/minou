#include "compiler.hpp"
#include <vector>
#include "eval.hpp"
#include "engine.hpp"

namespace minou {

#define TRY(x,y) auto x = y; if(is_error(x)) { return x; }

struct Compiler {
    std::vector<uint8_t> buffer;

    void push_opcode(OpCode op) {
        buffer.push_back(static_cast<uint8_t>(op));
    }

    Result<std::monostate> compile(Engine *engine, Atom a, Env *env) {
        // fmt::print("compiling: {}\n", a);
        switch (a.get_type()) {
        case AtomType::Cons:
            if (!a.cons()) {
                return "invalid list application";
            }
            if (a.cons()->car.get_type() == AtomType::Symbol) {
                auto sym = a.cons()->car.symbol();

                if (sym == "if") {
                    auto len = a.cons()->cdr->length();
                    auto c = a.cons()->cdr;

                    auto p = compile(engine, car(c), env);
                    if (is_error(p)) {
                        return p;
                    }
                    push_opcode(OpCode::JUMP_IFNOT);
                    push_value(0);
                    auto ejp = buffer.size() - 8;

                    auto e = compile(engine, cadr(c), env);
                    if (is_error(e)) {
                        return e;
                    }

                    switch (len) {
                    case 2: {
                        set_value(ejp, buffer.size());
                    } break; // no else
                    case 3: {
                        push_opcode(OpCode::JUMP);
                        push_value(0);
                        auto out_jmp = buffer.size() - 8;

                        set_value(ejp, buffer.size());

                        auto t = compile(engine, caddr(c), env);
                        if(is_error(t)) {
                            return t;
                        }
                        set_value(out_jmp, buffer.size());
                    } break; // if / else
                    default:
                        return "invalid arity for if";
                    }
                } else if(sym == "lambda") {
                    Compiler c;

                    Cons *body = engine->get_memory().alloc_cons(Symbol("begin"), a.cons()->cdr->cdr);

                    auto e = c.compile(engine, body, env);
                    if( is_error(e)) {
                        return e;
                    }
                    c.push_opcode(OpCode::RET);

                    auto l = engine->get_memory().alloc<Lambda>(a.cons()->cdr->car.cons(), body, env, std::move(c.buffer));
                    push_value(l);

                } else if(sym == "begin") {
                    for( Cons *c = a.cons()->cdr ; c ; c = c->cdr ) {
                        auto e = compile(engine, c->car, env);
                        if( is_error(e)) {
                            return e;
                        }
                        if( c->cdr ) {
                            buffer.push_back((uint8_t)OpCode::POP);
                        }
                    }
                }
                else {
                    int i = 0;
                    for (auto c : *a.cons()->cdr) {
                        auto e = compile(engine, car(c), env);
                        if(is_error(e)) {
                            return e ;
                        }
                        ++i;
                    }

                    auto e = compile(engine, a.cons()->car, env);
                    if( is_error(e)) {
                        return e;
                    }

                    buffer.push_back((uint8_t)OpCode::INVOKE);
                    buffer.push_back(a.cons()->length()-1);

                    if (i > 255) {
                        return "too many arguments";
                    }
                }
            } else {
                int i = 0;
                for (auto c : *a.cons()->cdr) {
                    auto e = compile(engine, car(c), env);
                    if (is_error(e)) {
                        return e;
                    }
                    ++i;
                }
                auto e = compile(engine, a.cons()->car, env);
                if (is_error(e)) {
                    return e;
                }

                push_opcode(OpCode::INVOKE);
                buffer.push_back(a.cons()->length() - 1);

                if (i > 255) {
                    return "too many arguments";
                }
            }
            break;
        case AtomType::Symbol: {
            push_value(a);
            push_opcode(OpCode::LOAD);
        } break;
        default:
            push_value(a);
        }

        return {};
    }

    void set_value(int pos, intptr_t value) {
        *((intptr_t *) (&buffer[pos])) = value;
    }

    void push_value(intptr_t i) {
        for(int i = 0 ; i < 8 ; ++i) {
            buffer.push_back(0);
        }
        *((intptr_t *)(&buffer[buffer.size() -8])) = i;
    }

    void push_value(Atom a) {
        push_opcode(OpCode::PUSH);
        auto i = buffer.size();
        for( auto i = 0 ; i < 8 ; ++i ) {
            buffer.push_back(0);
        }
        set_value( i, a.value);
    }
};

Result<std::vector<uint8_t>> compile(Engine *engine, Atom a, Env *env)
{
    Compiler c;
    auto e = c.compile(engine, a, env);
    if( is_error(e)) {
        return get_error(e);
    }
    return c.buffer;
}

}

#include "compiler.hpp"
#include <vector>
#include "eval.hpp"
#include "engine.hpp"

namespace minou {

#define TRY(x,y) auto x = y; if(is_error(x)) { return x; }

Atom pop(const uint8_t *s) {
    Atom a;

    a.value = s[0] | (s[1] << 8) | (s[2] << 16) |
        (s[3] << 24) |  ((intptr_t)s[4] << 32) | ((intptr_t)s[5] << 40)
        | ((intptr_t)s[6] << 48) || ((intptr_t)s[7] << 56);

    return a;
}

void push(Atom a, uint8_t *buffer) {
    buffer[0] = a.value & 0xff;
    buffer[1] = (a.value >> 8) & 0xff;
    buffer[2] = (a.value >> 16) & 0xff;
    buffer[3] = (a.value >> 24) & 0xff;
    buffer[4] = (a.value >> 32) & 0xff;
    buffer[5] = (a.value >> 40) & 0xff;
    buffer[6] = (a.value >> 48) & 0xff;
    buffer[7] = (a.value >> 56) & 0xff;
}


struct Compiler {
    std::vector<uint8_t> buffer;

    Result<std::monostate> compile(Engine *engine, Atom a, Env *env) {
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
                    buffer.push_back((uint8_t)OpCode::JUMP_IFNOT);
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
                        buffer.push_back((uint8_t)OpCode::JUMP);
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
                    auto e = c.compile(engine, a.cons()->cdr->cdr, env);
                    if( is_error(e)) {
                        return e;
                    }
                    c.buffer.push_back((uint8_t)OpCode::RET);

                    auto l = engine->get_memory().alloc<Lambda>(a.cons()->cdr, a.cons()->cdr->cdr, env, c.buffer);
                    push_value(l);
                } else {
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

                buffer.push_back((uint8_t)OpCode::INVOKE);
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

    void push_opcode(OpCode o) {
        buffer.push_back((uint8_t)o);
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
        push(a, &buffer[i]);
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

#include "compiler.hpp"
#include <vector>
#include "eval.hpp"
#include "engine.hpp"

namespace minou {

#define TRY(x,y) auto x = y; if(is_error(x)) { return x; }

Result<std::vector<uint8_t>> apply_tailcalls(std::vector<uint8_t> &inst) {
    std::vector<uint8_t> out;
    out.reserve(inst.size());

    int pos = 0;
    for (;;) {
        auto opcode = static_cast<OpCode>(inst[pos]);
        auto opcode_len = opcode_length(opcode);

        bool copy = true;
        switch (opcode) {
        case OpCode::INVOKE: {
            auto next = static_cast<OpCode>(inst[pos+opcode_len+1]);

            if( next == OpCode::RET) {
                out.push_back((uint8_t)OpCode::TAILCALL);
                out.push_back(inst[pos+opcode_len]);
                pos += 1 + opcode_len;
                copy = false;
            } else if(next == OpCode::JUMP || next == OpCode::JUMP_IFNOT) {
                auto jump_pos = *(intptr_t *)&inst[pos + 1 + opcode_len + 1];
                bool still_jumping = true;
                for (;still_jumping;) {
                    auto cur_pos = pos+1+opcode_len+1+jump_pos - sizeof(intptr_t)
                    ;
                    auto o = (OpCode)inst[cur_pos];
                    switch(o) {
                    case OpCode::RET:
                        out.push_back((uint8_t)OpCode::TAILCALL);
                        out.push_back(inst[pos + opcode_len]);
                        pos += 1 + opcode_len;
                        copy = false;
                        still_jumping = false;
                        break;
                    case OpCode::JUMP:
                    case OpCode::JUMP_IFNOT:
                        jump_pos = *(intptr_t*)&inst[cur_pos+1];
                        cur_pos += sizeof(intptr_t);
                        cur_pos += jump_pos;
                        break;
                    default:
                        still_jumping = false;
                    }
                }
            }
        }break;
        default:
            break;
        }
        if (copy) {
            out.push_back((uint8_t)opcode);
            for (int i = 0; i < opcode_len; ++i) {
                out.push_back(inst[pos + i + 1]);
            }

            pos += 1 + opcode_len;
        }
        if(pos >= inst.size() ) {
            break;
        }
    }

    return out;
}

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
                    auto ejp = buffer.size();
                    push_value(0);

                    auto e = compile(engine, cadr(c), env);
                    if (is_error(e)) {
                        return e;
                    }

                    switch (len) {
                    case 2: {
                        set_value(ejp, buffer.size() - ejp);
                    } break; // no else
                    case 3: {
                        push_opcode(OpCode::JUMP);
                        auto out_jmp = buffer.size();
                        push_value(0);

                        set_value(ejp, buffer.size() - ejp);

                        auto t = compile(engine, caddr(c), env);
                        if(is_error(t)) {
                            return t;
                        }
                        set_value(out_jmp, buffer.size() - out_jmp);
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

                    auto buff = apply_tailcalls(c.buffer);
                    if( is_error(buff)) {
                        return get_error(buff);
                    }
                    auto bb = std::get<std::vector<uint8_t>>(buff);

                    auto l = engine->get_memory().alloc<Lambda>(a.cons()->cdr->car.cons(), body, env, std::move(bb));
                    push_value(l);

                } else if(sym == "begin") {
                    for( Cons *c = a.cons()->cdr ; c ; c = c->cdr ) {
                        auto e = compile(engine, c->car, env);
                        if( is_error(e)) {
                            return e;
                        }
                        if( c->cdr ) {
                            push_opcode(OpCode::POP);
                        }
                    }
                }
                else if(sym == "define") {
                    auto sym = a.cons()->cdr->car;
                    auto body = a.cons()->cdr->cdr->car;

                    if( sym.get_type() != AtomType::Symbol) {
                        return "must be a symbol";
                    }

                    push_value(sym);

                    auto e = compile(engine, body, env);
                    if( is_error(e)) {
                        return e;
                    }
                    push_opcode(OpCode::SET);
                }
                else {
                    std::vector<Atom> arg_list;
                    for (auto c : *a.cons()->cdr) {
                        arg_list.push_back(car(c));
                    }

                    if (arg_list.size() > 255) {
                        return "too many arguments";
                    }

                    for (auto i = arg_list.rbegin(); i != arg_list.rend();
                         ++i) {
                        auto e = compile(engine, *i, env);
                        if( is_error(e)) {
                            return e;
                        }
                    }

                    auto e = compile(engine, a.cons()->car, env);
                    if( is_error(e)) {
                        return e;
                    }

                    push_opcode(OpCode::INVOKE);
                    buffer.push_back(a.cons()->length()-1);

                }
            } else {
                std::vector<Atom> arg_list;
                for (auto c : *a.cons()->cdr) {
                    arg_list.push_back(c->car)
                    ;
                }

                for (auto i = arg_list.rbegin(); i != arg_list.rend(); ++i) {
                    auto e = compile(engine, *i, env);
                    if (is_error(e)) {
                        return e;
                    }
                }
                auto e = compile(engine, a.cons()->car, env);
                if (is_error(e)) {
                    return e;
                }

                push_opcode(OpCode::INVOKE);
                buffer.push_back(a.cons()->length() - 1);

                if (arg_list.size() > 255) {
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
    if (is_error(e)) {
        return get_error(e);
    }

    return apply_tailcalls(c.buffer);
}

} // namespace minou

#include "vm.hpp"
#include "bytecode.hpp"
#include "compiler.hpp"
#include <string>
#include <vector>
#include <cstdarg>
#include "fmt/format.h"

namespace minou {

std::string instruction_to_string(uint8_t *s) {
    std::vector<char> out;

    auto it = std::back_inserter(out);

    auto opcode = static_cast<OpCode>(*s);

    auto len = opcode_length(opcode);

    fmt::format_to(it, "{}", opcode);

    if (len == 8) {
        auto arg = *(reinterpret_cast<word *>(s + 1));

        switch (opcode) {
        case OpCode::PUSH: {
            Atom a = *((Atom *)&arg);
            fmt::format_to(it, "({})", a);
        } break;
        default:
            fmt::format_to(it, "({})", arg);
        }
    } else if (len == 1) {
        fmt::format_to(it, "({})", (int)s[1]);
    }

    return std::string(out.data(), out.size());
}

void print_instruction_stream(uint8_t *s, int len) {
    for (int i = 0; i < len;) {
        auto opcode = static_cast<OpCode>(s[i]);

        auto len = opcode_length(opcode);

        fmt::print("[{}] {} ", i, opcode);

        if (len == 8) {
            auto arg = *(reinterpret_cast<word *>(s + i + 1));

            switch (opcode) {
            case OpCode::PUSH: {
                Atom a = *((Atom *)&arg);
                fmt::print("({})", a);
            } break;
            default:
                fmt::print("({})", arg);
            }
        } else if (len == 1) {
            fmt::print("({})", (int)s[i+1]);
        }

        fmt::print("\n");
        i += 1 + len;
    }
}

Result<Atom> VM::run(std::string_view s) {
    auto a = engine.parse(s);
    if (is_error(a)) {
        return a;
    }

    auto inst = compile(&engine, get_atom(a), env);

    if (is_error(inst)) {
        return get_error(inst);
    }

    auto i = std::get<std::vector<uint8_t>>(inst);
    i.push_back(static_cast<uint8_t>(OpCode::EXIT));

    // fmt::print("----[INSTRUCTION STREAM]-----\n");
    // print_instruction_stream(i.data(), i.size());
    // fmt::print("-----[INSTRUCTION STREAM END]------\n");

    this->inst = i.data();
    return run();
}

Result<Atom> VM::run() {
    for (;;) {
        // fmt::print("[{}]\n", instruction_to_string(inst));
        auto opcode = read_instruction<OpCode>();

        switch (opcode) {
        case OpCode::PUSH: {
            push(read_instruction<word>());
        } break;
        case OpCode::JUMP: {
            auto p = read_instruction<word>();
            inst += p - sizeof(word);
        } break;
        case OpCode::JUMP_IFNOT: {
            auto pred = pop<Atom>();
            auto pos = read_instruction<word>();
            if (pred.is_false()) {
                inst += pos - sizeof(word);
            }
        } break;
        case OpCode::INVOKE: {
            auto num_args = read_instruction<uint8_t>();
            auto a = pop<Atom>();

            if (a.get_type() == AtomType::Primitive) {
                auto p = a.primitive();

                auto r = p->vm_call(this, num_args);
                if (is_error(r)) {
                    return r;
                }

                push(get_atom(r));
            } else {
                auto l = a.lambda();
                auto newEnv = new_env(l->get_env());
                auto vars = l->get_arguments();
                for (int i = 0; i < num_args; ++i) {
                    newEnv->set(vars->car.symbol(), pop<Atom>());
                    vars = vars->cdr;
                }
                push(inst);
                push(env);

                inst = l->get_compiled_body().data();

                env = newEnv;
            }
        } break;
        case OpCode::TAILCALL: {
            auto num_args = read_instruction<uint8_t>();
            auto a = pop<Atom>();

            if (a.get_type() == AtomType::Primitive) {
                auto p = a.primitive();

                auto r = p->vm_call(this, num_args);
                if (is_error(r)) {
                    return r;
                }

                push(get_atom(r));
            } else {
                auto l = a.lambda();
                auto c = l->get_arguments();
                auto vars = l->get_arguments();
                for (int i = 0; i < num_args; ++i) {
                    auto arg_value = pop<Atom>();
                    env->set(vars->car.symbol(), arg_value);
                    vars = vars->cdr;
                }
                inst = l->get_compiled_body().data();
            }
        }break;
        case OpCode::SET: {
            auto value = pop<Atom>();
            auto sym = pop<Atom>();

            // fmt::print("SET {} = {}\n", sym, value);
            env->set(sym.symbol(), value);
            push(sym);
        } break;
        case OpCode::POP:
            if( stack.empty()) {
                return "stack underrun";
            }
            stack.pop_back();
            break;
        case OpCode::LOAD: {
            auto sym = pop<Atom>();
            // fmt::print("LOAD -> {}\n", sym);

            auto v = env->lookup(sym.symbol());
            if (v.has_value()) {
                push(v.value());
            }
        } break;
        case OpCode::RET: {
            auto return_value = pop<Atom>();
            // fmt::print("RET: {}\n", return_value);
            free_env(env);
            env = pop<Env*>();
            inst = pop<uint8_t*>();

            push(return_value.value);
        } break;
        case OpCode::EXIT:
            if (stack.size() == 0) {
                return Atom();
            }
            return pop<Atom>();
        default:
            break;
        }
    }
    return "idk";
}

} // namespace minou

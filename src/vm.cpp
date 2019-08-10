#include "vm.hpp"
#include "bytecode.hpp"
#include "compiler.hpp"
#include <string>
#include <vector>
#include <cmath>
#include <cstdio>
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

void log(const char* fmt, ...)
{
    va_list args;

    va_start(args, fmt);

    vprintf(fmt, args);

    printf("\n");

    va_end(args);
}

void print_instruction_stream(uint8_t *s, int len) {
    for (int i = 0; i < len;) {
        auto opcode = static_cast<OpCode>(s[i]);

        auto len = opcode_length(opcode);

        fmt::print("[{}] ", opcode);

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
    i.push_back((uint8_t)OpCode::EXIT);

    fmt::print("START\n");
    print_instruction_stream(i.data(), i.size());
    fmt::print("END\n");

    this->inst = i.data();
    pc = 0;

    return run();
}

Result<Atom> VM::run() {
    for (;;) {
        fmt::print("[{}] {}\n", pc, instruction_to_string(inst+pc));
        auto opcode = (OpCode)read_instruction<uint8_t>();

        switch (opcode) {
        case OpCode::PUSH: {
            push(read_instruction<word>());
        } break;
        case OpCode::JUMP:
            pc = read_instruction<word>();
            continue;
        case OpCode::JUMP_IFNOT: {
            auto pred = pop_atom();
            auto pos = read_instruction<word>();
            if (pred.is_false()) {
                pc = pos;
                continue;
            }
        } break;
        case OpCode::INVOKE: {
            auto num_args = read_instruction<uint8_t>();
            auto a = pop_atom();

            if (a.get_type() == AtomType::Primitive) {
                auto p = a.primitive();
                BottomCont bc;
                Cons *c = nullptr;
                for (int i = 0; i < num_args; ++i) {
                    c = engine.get_memory().alloc_cons(pop_atom(), c);
                }

                auto r = p->invoke(&engine, c, env, &bc);
                if (is_error(r)) {
                    return r;
                }
                push_atom(get_atom(r));

            } else {
                auto l = a.lambda();
                auto c = l->get_arguments();
                Env *newEnv = new Env(l->get_env());
                auto vars = l->get_arguments();
                for (int i = 0; i < num_args; ++i) {
                    auto arg_value = pop_atom();
                    newEnv->set(vars->car.symbol(), arg_value);
                    vars = vars->cdr;
                }
                push((word)inst);
                push(pc);
                push((word)env);

                inst = (uint8_t *)l->get_compiled_body().data();
                pc = 0;
                env = newEnv;

                continue;
            }
        } break;
        case OpCode::POP:
            if( stack.empty()) {
                return "stack underrun";
            }
            stack.pop_back();
            break;
        case OpCode::LOAD: {
            auto sym = pop_atom();
            fmt::print("LOAD -> {}\n", sym);

            auto v = env->lookup(sym.symbol());
            if (v.has_value()) {
                push_atom(v.value());
            }
        } break;
        case OpCode::RET: {
            auto return_value = pop_atom();
            fmt::print("RET: {}\n", return_value);

            delete env;
            env = (Env *)pop();
            pc = pop();
            inst = (uint8_t *)pop();

            push(return_value.value);
        } break;
        case OpCode::EXIT:
            if (stack.size() == 0) {
                return Atom();
            }
            return pop_atom();
        default:
            break;
        }
    }
    return "idk";
}

} // namespace minou

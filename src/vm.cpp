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

        fmt::format("[{}] ", opcode);

        if (len == 8) {
            auto arg = *(reinterpret_cast<word *>(s + i + 1));

            switch (opcode) {
            case OpCode::PUSH: {
                Atom a = *((Atom *)&arg);
                fmt::format("({})", a);
            } break;
            default:
                fmt::format("({})", arg);
            }
        } else if (len == 1) {
            fmt::format("({})", (int)s[i+1]);
        }

        fmt::format("\n");
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

    print_instruction_stream(i.data(), i.size());

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
            // if boolean and is #f
            if (pred.get_type() == AtomType::Boolean && !pred.boolean()) {
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

                for (int i = 0; i < num_args; ++i) {
                    auto arg_value = pop_atom();
                }

                push((word)inst);
                push(pc + opcode_length(opcode));
                push((word)env);

                inst = (uint8_t *)l->get_compiled_body().data();
                pc = 0;
                continue;
            }
        } break;
        case OpCode::LOAD: {
            auto sym = pop_atom();

            auto v = env->lookup(sym.symbol());
            if (v.has_value()) {
                push_atom(v.value());
            }
        } break;
        case OpCode::RET: {
            auto return_value = pop_atom();

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

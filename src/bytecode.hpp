#ifndef BYTECODE_H_
#define BYTECODE_H_

#include <cstdint>
#include <ostream>
#include <string>

namespace minou {

enum class OpCode : uint8_t {
    PUSH = 0,
    LOAD,
    SET,
    POP,
    STORE,
    JUMP_IFNOT,
    JUMP,
    RET,
    INVOKE,
    RESUME,
    ALLOC,
    TAILCALL,
    EXIT
};

constexpr inline const std::string_view opcode_string(const OpCode o)
{
    switch(o)
    {
    case OpCode::PUSH:
        return "PUSH";
    case OpCode::LOAD:
        return "LOAD";
    case OpCode::SET:
        return "SET";
    case OpCode::POP:
        return "POP";
    case OpCode::STORE:
        return "STORE";
    case OpCode::JUMP_IFNOT:
        return "JUMP_IF_NOT";
    case OpCode::JUMP:
        return "JUMP";
    case OpCode::RET:
        return "RET";
    case OpCode::INVOKE:
        return "INVOKE";
    case OpCode::RESUME:
        return "RESUME";
    case OpCode::ALLOC:
        return "ALLOC";
    case OpCode::EXIT:
        return "EXIT";
    case OpCode::TAILCALL:
        return "TAILCALL";
    }
}

inline int opcode_length(OpCode o) {
    switch (o) {
    case OpCode::PUSH:
    case OpCode::JUMP:
    case OpCode::JUMP_IFNOT:
        return 8;
    case OpCode::INVOKE:
    case OpCode::TAILCALL:
        return 1;
    default:
        return 0;
    }
}

} // namespace minou

namespace fmt {
template <> struct formatter<minou::OpCode> {
    template <typename ParseContext> constexpr auto parse(ParseContext &ctx) {
        return ctx.begin();
    }

    template <typename FormatContext>
    auto format(const minou::OpCode &a, FormatContext &ctx) {
        return format_to(ctx.begin(), "{}", minou::opcode_string(a));
    }
};

} // namespace fmt

#endif

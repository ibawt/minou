#ifndef BASE_H_
#define BASE_H_

#include "fmt/format.h"

#include <string>
#include <variant>

#define UNUSED __attribute__((unused))

namespace minou {

class Error {
  public:
    Error(const std::string &s) : message(s) {}
    Error(const char *s) : message(s) {}

    const std::string &get_message() const { return message; }

  private:
    const std::string message;
};


template <typename T> inline bool is_error(std::variant<T, const Error> v) {
    return std::holds_alternative<const Error>(v);
}
template <typename T> using Result = std::variant<T, const Error>;

// TODO: figure out why this doesn't work on OSX
// template<typename T>
// inline std::ostream& operator<<(std::ostream& os, const Result<T>& r)
// {
//     if (is_error(r)) {
//         os << "ERROR: " << get_error(r);
//     } else {
//         os << get_value(r);
//     }
//     return os;
// }

template <typename T> const Error get_error(Result<T> result) {
    return std::get<const Error>(result);
}

template <typename T> T get_value(Result<T> result) {
    return std::get<T>(result);
}

} // namespace minou

namespace fmt {
template <> struct formatter<minou::Error> {
    template <typename ParseContext> constexpr auto parse(ParseContext &ctx) {
        return ctx.begin();
    }

    template <typename FormatContext>
    auto format(const minou::Error &a, FormatContext &ctx) {
        return format_to(ctx.begin(), "{}", a.get_message());
    }
};

}

#endif


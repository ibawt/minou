#ifndef BASE_H_
#define BASE_H_

#include <string>
#include <variant>
#include <iostream>

#define UNUSED  __attribute__((unused))

namespace minou {

class Error {
public:
    Error(const std::string& s) : message(s) {}
    Error(const char *s) : message(s) {}

    const std::string& get_message() const {
        return message;
    }
private:
    const std::string message;
};

inline std::ostream& operator<<(std::ostream& os, const Error& e)
{
    os << e.get_message();
    return os;
}

template<typename T>
inline bool is_error(std::variant<T, const Error> v)
{
    return std::holds_alternative<const Error>(v);
}
template<typename T>
using Result = std::variant<T, const Error>;

template<typename T>
inline std::ostream& operator<<(std::ostream& os, const Result<T>& r)
{
    if (is_error(r)) {
        os << "ERROR: " << get_error(r);
    } else {
        os << get_value(r);
    }
    return os;
}


template<typename T>
const Error get_error(Result<T> result)
{
    return std::get<const Error>(result);
}

template<typename T>
T get_value(Result<T> result)
{
    return std::get<T>(result);
}

}

#endif

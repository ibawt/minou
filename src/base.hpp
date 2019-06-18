#ifndef BASE_H_
#define BASE_H_

#include <string>
#include <variant>

#define UNUSED  __attribute__((unused))

namespace minou {

class Error {
    Error(const std::string& s) : message(s) {}
    Error(const char *s) : message(s) {}

    const std::string& get_message() const {
        return message;
    }
private:
    const std::string message;
};

template <typename T>
std::variant<T, std::string> error(const std::string& s)
{
    return s;
}

}

#endif

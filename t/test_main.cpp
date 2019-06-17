#include "gtest/gtest.h"
#include "minou.hpp"

using namespace minou;

TEST(Helpers, EqualsP) {
    ASSERT_TRUE( equalsp(make_list({1L, 2L}), make_list({1L, 2L})));
    ASSERT_FALSE( equalsp(make_list({1L}), make_list({1L, 2L})));
}

TEST(Parsing, AllTheThings) {
    struct {
        std::string input;
        Atom output;
    } tests[] = {
        { "5", Atom(5L) },
        { "-1", Atom(-1L) },
        { "nil", Atom() },
        { "foo", make_symbol("foo") },
        { "\"stuff\"", make_string("stuff")},
    };

    for( const auto& test : tests ) {
        EXPECT_EQ(parse(test.input), test.output);
    }

    auto l = parse("(1 2)");
    ASSERT_TRUE( equalsp(l, make_list({1L, 2L})));
    ASSERT_TRUE( equalsp(parse("(foo (bar))"), make_list({make_symbol("foo"), make_list({make_symbol("bar")})})));
}

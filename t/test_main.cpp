#include "gtest/gtest.h"
#include "minou.hpp"
#include "eval.hpp"

using namespace minou;

TEST(Helpers, EqualsP) {
    ASSERT_TRUE( equalsp(make_list({1L, 2L}), make_list({1L, 2L})));
    ASSERT_FALSE( equalsp(make_list({1L}), make_list({1L, 2L})));
    ASSERT_TRUE( equalsp(make_list({}), make_list({})));
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
        { "#t", Atom(true)},
        { "#f", Atom(false)},
    };

    for( const auto& test : tests ) {
        EXPECT_EQ(parse(test.input), test.output);
    }

    auto l = parse("(1 2)");
    ASSERT_TRUE( equalsp(l, make_list({1L, 2L})));
    ASSERT_TRUE( equalsp(parse("(foo (bar))"), make_list({make_symbol("foo"), make_list({make_symbol("bar")})})));
    ASSERT_TRUE(equalsp(parse("'foo"), make_list({make_symbol("quote"), make_symbol("foo")})));
    ASSERT_TRUE( equalsp(parse("()"), make_list({})) );
}

TEST(Parsing, InvalidThings) {
    const std::string tests[] = {
        "(", "(()", "(foo",
    };
    for(const auto &t : tests ) {
        auto b = true;
        try {
            parse(t);
            b = false;
        } catch(const ParseException& e) {
        }
        ASSERT_TRUE(b) << t;
    }
}


struct testcase {
    std::string input;
    Atom expected;
};

class EvalTest : public ::testing::Test {
protected:
    void SetUp() override {
        e = default_env();
    }

    void run(const std::vector<testcase>& tests) {
        for(const auto& t : tests) {
            const auto a = parse(t.input);
            const auto result = eval(a, &e, &cont);

            ASSERT_FALSE(is_error(result)) << a << get_error(result);
            if(! is_error(result)) {
                const auto aa = std::get<Atom>(result);
                ASSERT_EQ(aa, t.expected) << t.input;
            }
        }
    }

    Env e;
    BottomCont cont;
};


TEST_F(EvalTest, SimpleCases) {
    run({
        { "5", Atom(5L)},
        { "(+ 1 2)", Atom(3L)},
        { "'foo", make_symbol("foo")},
        });
}

TEST_F(EvalTest, Begin) {
    run({
        { "(begin 5)", Atom(5L)},
        { "(begin 5 4)", Atom(4L)},
        { "(begin)", Atom()}
        });
}

TEST_F(EvalTest, Lambda) {
    run({
            {"((lambda () 1))", Atom(1L)},
            {"((lambda (a) a) 1)", Atom(1L)}
        });
}

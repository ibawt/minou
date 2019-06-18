#include "gtest/gtest.h"
#include "minou.hpp"
#include "eval.hpp"

using namespace minou;

TEST(Memory, CheckIfTypeIsSet) {
    Memory m;

    struct {
        Atom a;
        AtomType expected;
    } tests[] = {
        { m.alloc<Symbol>(""), AtomType::Symbol },
        { m.alloc<String>(""), AtomType::String },
        { m.alloc<Cons>(Atom()), AtomType::Cons },
        { m.alloc<Lambda>(nullptr, nullptr, nullptr), AtomType::Procedure},
    };

    for( const auto& t : tests ) {
        EXPECT_EQ(t.a.type, t.expected);
    }
}

TEST(Helpers, EqualsP) {
    Memory m;
    ASSERT_TRUE( equalsp(m.make_list({1L, 2L}), m.make_list({1L, 2L})));
    ASSERT_FALSE( equalsp(m.make_list({1L}), m.make_list({1L, 2L})));
    ASSERT_TRUE( equalsp(m.make_list({}), m.make_list({})));
}

TEST(Parsing, AllTheThings) {
    Memory m;
    struct {
        std::string input;
        Atom output;
    } tests[] = {
        { "5", Atom(5L) },
        { "-1", Atom(-1L) },
        { "nil", Atom() },
        { "foo", m.alloc<Symbol>("foo") },
        { "\"stuff\"", m.alloc<Symbol>("stuff")},
        { "#t", Atom(true)},
        { "#f", Atom(false)},
    };

    for( const auto& test : tests ) {
        auto a = parse(m, test.input);
        ASSERT_TRUE(std::holds_alternative<Atom>(a));
        EXPECT_EQ(get_atom(a), test.output);
    }

    auto l = parse(m, "(1 2)");
    ASSERT_TRUE( equalsp(get_atom(l), m.make_list({1L, 2L})));
    ASSERT_TRUE( equalsp(get_atom(parse(m, "(foo (bar))")), m.make_list({m.alloc<Symbol>("foo"), m.make_list({m.alloc<Symbol>("bar")})})));
    ASSERT_TRUE(equalsp(get_atom(parse(m, "'foo")), m.make_list({m.alloc<Symbol>("quote"), m.alloc<Symbol>("foo")})));
    ASSERT_TRUE( equalsp(get_atom(parse(m, "()")), m.make_list({})) );
}

TEST(Parsing, InvalidThings) {
    const std::string tests[] = {
        "(", "(()", "(foo",
    };
    Memory m;
    for(const auto &t : tests ) {
        auto a = parse(m, t);
        EXPECT_TRUE(std::holds_alternative<std::string>(a));
    }
}


struct testcase {
    std::string input;
    Atom expected;
};

class EvalTest : public ::testing::Test {
protected:
    void run(const std::vector<testcase>& tests) {
        for(const auto& t : tests) {
            const auto result = engine.eval(t.input);

            ASSERT_FALSE(is_error(result)) << get_error(result);
            const auto aa = std::get<Atom>(result);
            EXPECT_EQ(aa, t.expected) << t.input;
        }
    }
    Engine engine;
};


TEST_F(EvalTest, SimpleCases) {
    run({
        { "5", Atom(5L)},
        { "(+ 1 2)", Atom(3L)},
        { "'foo", engine.get_memory().alloc<Symbol>("foo")},
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

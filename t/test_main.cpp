#include "eval.hpp"
#include "minou.hpp"
#include "gtest/gtest.h"
#include <memory>
#include <string>
#include <vector>

using namespace minou;

TEST(Memory, CheckIfTypeIsSet) {
    Memory m;

    struct {
        Atom a;
        AtomType expected;
    } tests[] = {
        {m.alloc<Symbol>(""), AtomType::Symbol},
        {m.alloc<String>(""), AtomType::String},
        {m.alloc<Cons>(Atom()), AtomType::Cons},
        {m.alloc<Lambda>(nullptr, nullptr, nullptr), AtomType::Lambda},
    };

    for (const auto &t : tests) {
        EXPECT_EQ(t.a.type, t.expected);
    }
}

TEST(Helpers, EqualsP) {
    Memory m;
    ASSERT_TRUE(equalsp(m.make_list({1L, 2L}), m.make_list({1L, 2L})));
    ASSERT_FALSE(equalsp(m.make_list({1L}), m.make_list({1L, 2L})));
    ASSERT_TRUE(equalsp(m.make_list({}), m.make_list({})));
}

TEST(Parsing, AllTheThings) {
    Memory m;
    struct {
        std::string input;
        Atom output;
    } tests[] = {
        {"5", Atom(5L)},
        {"-1", Atom(-1L)},
        {"nil", Atom()},
        {"foo", m.alloc<Symbol>("foo")},
        {"\"stuff\"", m.alloc<String>("stuff")},
        {"#t", Boolean(true)},
        {"#f", Atom(Boolean(false))},
    };

    for (const auto &test : tests) {
        auto a = parse(m, test.input);
        ASSERT_TRUE(std::holds_alternative<Atom>(a));
        EXPECT_EQ(get_atom(a), test.output);
    }

    auto l = parse(m, "(1 2)");
    ASSERT_TRUE(equalsp(get_atom(l), m.make_list({1L, 2L})));
    ASSERT_TRUE(equalsp(get_atom(parse(m, "(foo (bar))")),
                        m.make_list({m.alloc<Symbol>("foo"),
                                     m.make_list({m.alloc<Symbol>("bar")})})));
    ASSERT_TRUE(equalsp(
        get_atom(parse(m, "'foo")),
        m.make_list({m.alloc<Symbol>("quote"), m.alloc<Symbol>("foo")})));
    ASSERT_TRUE(equalsp(get_atom(parse(m, "()")), m.make_list({})));
}

TEST(Parsing, InvalidThings) {
    const std::string tests[] = {
        "(",
        "(()",
        "(foo",
    };
    Memory m;
    for (const auto &t : tests) {
        auto a = parse(m, t);
        EXPECT_TRUE(is_error(a));
    }
}

struct testcase {
    std::string input;
    Atom expected;
};

class EvalTest : public ::testing::Test {
  protected:
    void SetUp() override { engine = std::make_unique<Engine>(); }
    void run(const std::vector<testcase> &tests) {
        for (const auto &t : tests) {
            const auto result = engine->eval(t.input);

            ASSERT_FALSE(is_error(result)) << get_error(result);
            const auto aa = std::get<Atom>(result);
            EXPECT_EQ(aa, t.expected) << t.input;
        }
        engine->gc();
    }
    std::unique_ptr<Engine> engine;
};

TEST_F(EvalTest, Define) {
    run({{"(begin (define foo 1) foo)", Atom(1L)},
         {"(begin (define foo (lambda () (+ 1 2))) (foo))", Atom(3L)}});
}

TEST_F(EvalTest, Closure) {
    run({{"(begin (define foo (lambda (a) (lambda (b) (+ a b)))) ((foo 1) 2))",
          Atom(3L)}});
}

TEST_F(EvalTest, Set) {
    run({{"(begin (define foo 1) (set! foo 2) 2)", Atom(2L)}});
}

TEST_F(EvalTest, SimpleCases) {
    Symbol foo("foo");
    run({{"5", Atom(5L)}, {"(+ 1 2)", Atom(3L)}, {"'foo", &foo}});
}

TEST_F(EvalTest, Begin) {
    run({{"(begin 5)", Atom(5L)},
         {"(begin 5 4)", Atom(4L)},
         {"(begin)", Atom()}});
}

TEST_F(EvalTest, Lambda) {
    run({{"((lambda () 1))", Atom(1L)}, {"((lambda (a) a) 1)", Atom(1L)}});
}

TEST_F(EvalTest, If) {
    run({{"(if #t 1 0)", Atom(1L)},
         {"(if #f 0 1)", Atom(1L)},
         {"(if 5 1 0)", Atom(1L)}});
}

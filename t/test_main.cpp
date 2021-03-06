#include "engine.hpp"
#include "minou.hpp"
#include "parser.hpp"
#include "gtest/gtest.h"
#include <dirent.h>
#include <memory>
#include <string>
#include <vector>

using namespace minou;

TEST(Cons, Iterator) {
    Memory m;

    auto l = m.make_list({make_integer(0L), make_integer(1)});

    std::vector<Cons*> list;
    for(const auto x : *l) {
        list.push_back(x);
    }

    EXPECT_EQ(2, list.size());
    EXPECT_EQ(make_integer(0L), list[0]->car);
    EXPECT_EQ(make_integer(1L), list[1]->car);
    EXPECT_EQ(2, l->length());
}

TEST(HeapNode, Headers) {
    HeapNode n{ 5<< 16 };
    n.set_type(AtomType::Cons);
    EXPECT_EQ(n.size(), 5);
    EXPECT_FALSE(n.has_visited());
    EXPECT_FALSE(n.is_locked());
    EXPECT_EQ(n.type(), AtomType::Cons);
    EXPECT_TRUE(n.collectable());
    n.set_flag(USED);
    EXPECT_FALSE(n.collectable());
    EXPECT_TRUE(n.has_visited());

    n.clear_flag(USED);
    EXPECT_TRUE(n.collectable());
    EXPECT_FALSE(n.has_visited());

    n.set_flag(LOCKED);
    EXPECT_FALSE(n.collectable());
    EXPECT_TRUE(n.is_locked());

    n.clear_flag(LOCKED);
    EXPECT_FALSE(n.is_locked());

    n.set_flag(LOCKED);
    n.clear_flag(USED);
    EXPECT_FALSE(n.collectable());
}

TEST(Memory, CheckIfTypeIsSet) {
    Memory m;

    struct {
        Atom a;
        AtomType expected;
    } tests[] = {
        {make_symbol(Symbol::from("")), AtomType::Symbol},
        {make_string(m.alloc_string("", 0)), AtomType::String},
        {make_nil(), AtomType::Nil},
        {make_cons(m.make_list({make_integer(1L)})), AtomType::Cons},
        {make_lambda(m.alloc_lambda(nullptr, nullptr, nullptr)), AtomType::Lambda},
    };

    for (const auto &t : tests) {
        EXPECT_EQ(t.a.get_type(), t.expected);
    }
}

TEST(Helpers, EqualsP) {
    Memory m;

    ASSERT_TRUE(equalsp(make_cons(m.make_list({make_integer(1L), make_integer(2L)})), make_cons(m.make_list({make_integer(1L), make_integer(2L)}))));
    ASSERT_FALSE(equalsp(make_cons(m.make_list({make_integer(1L)})), make_cons(m.make_list({make_integer(1L), make_integer(2L)}))));
    auto a = make_cons(m.make_list({}));
    auto b = make_cons(m.make_list({}));

    ASSERT_TRUE(equalsp(a, b));
}

TEST(Parsing, AllTheThings) {
    Memory m;
    struct {
        std::string input;
        Atom output;
    } tests[] = {
        {"5", make_integer(5L)},
        {"-1", make_integer(-1L)},
        {"nil", make_nil()},
        {"foo", make_symbol(Symbol::from("foo"))},
        {"\"stuff\"", make_string(m.alloc_string("stuff"))},
        {"#t", make_boolean(true)},
        {"#f", make_boolean(false)},
        {"\"\n\"", make_string(m.alloc_string("\n"))},
        {"\"\t\"", make_string(m.alloc_string("\t"))},
        {"\"\r\"", make_string(m.alloc_string("\r"))},
        {"\"\e\"", make_string(m.alloc_string("\e"))},
    };

    for (const auto &test : tests) {
        auto a = parse(m, test.input);
        ASSERT_TRUE(std::holds_alternative<Atom>(a)) << fmt::format("error: {}, expected: {}", get_error(a), test.input);
        EXPECT_EQ(get_value(a), test.output);
    }

    auto l = parse(m, "(1 2)");
    ASSERT_TRUE(equalsp(get_value(l), make_cons(m.make_list({make_integer(1L), make_integer(2L)}))));
    ASSERT_TRUE(
        equalsp(get_value(parse(m, "(foo (bar))")),
                make_cons(m.make_list({make_symbol(Symbol::from("foo")), make_cons(m.make_list({make_symbol(Symbol::from("bar"))}))}))));
    ASSERT_TRUE(equalsp(
        get_value(parse(m, "'foo")),
        make_cons(m.make_list({make_symbol(Symbol::from("quote")), make_symbol(Symbol::from("foo"))}))));
    ASSERT_TRUE(equalsp(get_value(parse(m, "()")), make_cons(m.make_list({}))));
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

            ASSERT_FALSE(is_error(result));
            const auto aa = std::get<Atom>(result);
            EXPECT_EQ(aa, t.expected) << t.input;
        }
        engine->gc();
    }
    std::unique_ptr<Engine> engine;
};
bool has_ending(std::string_view const fullString, std::string_view const ending) {
    if (fullString.length() >= ending.length()) {
        return (0 == fullString.compare(fullString.length() - ending.length(),
                                        ending.length(), ending));
    } else {
        return false;
    }
}
Result<std::vector<std::string>> test_files()
{
    auto dir = opendir("../t");
    if (!dir ){
        return "error opening dir";
    }

    dirent *entry;
    std::vector<std::string> files;

    while((entry = readdir(dir))) {
        if(entry->d_type == DT_REG && has_ending(entry->d_name, "_test.ss")) {
            files.push_back("../t/" + std::string(entry->d_name));
        }
    }
    closedir(dir);

    return files;
}

TEST_F(EvalTest, Units) {
    auto files = test_files();
    ASSERT_FALSE(is_error(files));

    for (auto &file : get_value(files)) {
        auto v = engine->eval_file(file);
        ASSERT_FALSE(is_error(v)) << get_error(v).get_message();
        EXPECT_EQ( get_value(v), make_boolean(true));
    }
}

TEST_F(EvalTest, TailCall) {
    run({{"(begin (define foo (lambda (n acc) (if (= 0 n) acc (foo (- n 1) (+ "
          "acc 2))))) (foo 5 0))", make_integer(10L)},
         {"(begin (define iter (lambda (a b count) (if (= 0 count) "
                      "a (iter b (+ a b) (- count 1))))) (iter 0 1 90))",
          make_integer(2880067194370816120L)}});
}
TEST_F(EvalTest, Define) {
    run({{"(begin (define foo 1) foo)", make_integer(1L)},
         {"(begin (define foo (lambda () (+ 1 2))) (foo))", make_integer(3L)}});
}

TEST_F(EvalTest, Closure) {
    run({{"(begin (define foo (lambda (a) (lambda (b) (+ a b)))) ((foo 1) 2))",
          make_integer(3L)}});
}

TEST_F(EvalTest, Set) {
    run({{"(begin (define foo 1) (set! foo 2) 2)", make_integer(2L)}});
}

TEST_F(EvalTest, SimpleCases) {
    run({{"5", make_integer(5L)}, {"(+ 1 2)", make_integer(3L)}, {"'foo", make_symbol(Symbol::from("foo"))}});
}

TEST_F(EvalTest, Begin) {
    run({{"(begin 5)", make_integer(5L)},
         {"(begin 5 4)", make_integer(4L)},
         {"(begin)", make_nil()}});
}

TEST_F(EvalTest, Lambda) {
    run({{"((lambda () 1))", make_integer(1L)}, {"((lambda (a) a) 1)", make_integer(1L)}});
}

TEST_F(EvalTest, If) {
    run({{"(if #t 1 0)", make_integer(1L)},
         {"(if #f 0 1)", make_integer(1L)},
         {"(if 5 1 0)", make_integer(1L)}});
}

TEST_F(EvalTest, Equals) {
    run({{"(equals 1 1)", make_boolean(true)},
         {"(equals '(1 2) '(1 2))", make_boolean(true)},
         {"(equals 1 '())", make_boolean(false)},
         {"(equals '(1 2) '(3 4))", make_boolean(false)}
        });
}

TEST_F(EvalTest, Cons) {
    run({{"(equals '(1 2) (cons 1 '(2)))", make_boolean(true)}});
}

TEST_F(EvalTest, Append) {
    run({{"(equals '(1 2 3 4) (append '(1 2) '(3 4)))", make_boolean(true)}});
}

TEST_F(EvalTest, Quasi) {
    engine->get_env()->set(symbol("a").symbol(), make_integer(5));
    run({
         {"(equals `(1 2) '(1 2))", make_boolean(true)},
         {"(equals `1 1)", make_boolean(true)},
         {"(equals `(a 5) '(a 5))", make_boolean(true)},
         {"(begin (define a 5) (equals `(,a 5) '(5 5)))", make_boolean(true)},
        });
}

TEST_F(EvalTest, Splice) {
    run({{"(equals `(1 2 ,@'(3 4)) '(1 2 3 4))",make_boolean(true)},
         {"(equals `(1 ,@'(2 3) 4) '(1 2 3 4))", make_boolean(true)}
        }
        );
}

TEST_F(EvalTest, Pair) {
    run({
            { "(pair? 1)", make_boolean(false)},
            { "(pair? '())", make_boolean(false)},
            { "(pair? '(1))", make_boolean(true)}
        });
}

TEST_F(EvalTest, Not) {
    run({
            { "(not #f)", make_boolean(true)},
            { "(not #t)", make_boolean(false)},
            { "(not '())", make_boolean(false)},
        });
}

TEST_F(EvalTest, Car) {
    run({
            { "(equals (car '(1)) 1)", make_boolean(true)},
            { "(equals (car '((1)) '(1)))", make_boolean(true)},
        });
}

TEST_F(EvalTest, Cdr) {
    run({
            {"(equals (cdr '(1) '()))", make_boolean(true)},
            {"(equals (cdr '(1 2) '(2)))", make_boolean(true)},
        });
}

TEST_F(EvalTest, ExceptionOnNotLambda) {
    EXPECT_ANY_THROW(engine->eval("(1)"));
}


// TEST_F(EvalTest, CallCC) {
//     run({
//         {"(call/cc (lambda (k) (k 1)))", Atom(1L)},
//     });
// }

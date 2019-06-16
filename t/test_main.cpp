#include "gtest/gtest.h"
#include "minou.hpp"

using namespace minou;

TEST(Parsing, AllTheThings) {
    Atom a = parse("5");

    EXPECT_EQ(a.integer.value, 5);
}

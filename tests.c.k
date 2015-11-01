/* This module is in the public domain.  No warranties. */

#include <stdio.h>
#include "app-aware-display.h"

struct test_input:
    const char *input
    const int expected

test_input test_cases[] = {
    {"0",         0},
    {"1",         1},
    {"009",       9},
    {"42",       42},
    {"9991",   9991},

    {"fx-JP900", -1},
    {"j123456",  -1},

    {"123bailu", -1},
    {"1048576k", -1},

    {"6to4",     -1},
    {"985, 211", -1},
    {"3.14159",  -1},

    {"Anything", -1}
}


int assert(const char *str, int expected):
    int result = strtoi(str)
    if result == expected:
        return 0
    else:
        printf("Test failed: %s => %d when %d is expected\n", str, result, expected)
        return 1


int main(void):
    for int i = 0; i < sizeof(test_cases) / sizeof(*test_cases); i++:
        assert(test_cases[i].input, test_cases[i].expected)

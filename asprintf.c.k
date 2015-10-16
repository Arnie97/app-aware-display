#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include "asprintf.h"


int asprintf(char **sptr, char *fmt, ...):
    va_list argv
    va_start(argv, fmt)
    int ret = vasprintf(sptr, fmt, argv)
    va_end(argv)
    return ret


int vasprintf(char **sptr, const char *fmt, va_list argv):
    int bytes = vsnprintf(*sptr = NULL, 0, fmt, argv)
    if bytes > 0 && (*sptr = calloc(bytes + 1, sizeof(char))):
        return vsprintf(*sptr, fmt, argv)
    else:
        return -1

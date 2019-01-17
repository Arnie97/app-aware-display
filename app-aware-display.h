#ifndef APP_AWARE_DISPLAY_INCLUDED
#define APP_AWARE_DISPLAY_INCLUDED

// Milky workaround
typedef struct option option;

// The global variables __argc and __argv provided by MSVCRT
#define argc __argc
#define argv __argv

// Parses command line options and saves to the given DEVMODE structure.
// The number of parsed options is returned.
int parse_options(DEVMODE *dev, int *style);

// Interprets a string and returns its content as an integral number.
// If any characters rather than digits is captured, returns -1.
int strtoi(const char *s);

// Popup an help message and exit the program with specified code.
void show_help(int exit_code, char *msg);


#endif /* APP_AWARE_DISPLAY_INCLUDED */

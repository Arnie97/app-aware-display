#ifndef APP_AWARE_DISPLAY_INCLUDED
#define APP_AWARE_DISPLAY_INCLUDED

typedef struct option option;

// Parses command line options and saves to the given DEVMODE structure.
// The number of parsed options is returned.
int parse_options(int argc, char *argv[], DEVMODE *dev);

// Interprets a string and returns its content as an integral number.
// If any characters rather than digits is captured, returns -1.
int strtoi(char *s);

// Popup an help message and exit the program with specified code.
void show_help(int exit_code, char *msg);


#endif /* APP_AWARE_DISPLAY_INCLUDED */

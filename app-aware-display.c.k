/* This module is in the public domain.  No warranties. */

#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <getopt.h>
#include <windows.h>
#include "app-aware-display.h"


int APIENTRY WinMain(HINSTANCE hCurr, HINSTANCE hPrev, char *lpCmdLine, int nCmdShow):
    /* Generate an ANSI-compliant argument list */
    int argc, style
    char *argv[] = CommandLineToArgv(lpCmdLine, &argc)

    /* Get the original display settings */
    DEVMODE original_settings, updated_settings
    EnumDisplaySettings(NULL, ENUM_CURRENT_SETTINGS, &original_settings)
    updated_settings = original_settings

    /* Parse command line options into the DEVMODE structure */
    if parse_options(argc, argv, &updated_settings) == 0:
        show_help(EXIT_SUCCESS, NULL)

    /* If how the window is to be shown is specified, */
    if updated_settings.dmReserved1:
        /* Then a program command line must be given at the same time. */
        if optind >= argc:
            show_help(EXIT_FAILURE, "command line is required to be given with '--style'")
        else:
            /* Ready to use the specified window style */
            style = updated_settings.dmReserved1
            /* This field should always be zero */
            updated_settings.dmReserved1 = 0

    /* Otherwise, use inherited options. */
    else:
        style = nCmdShow

    ChangeDisplaySettings(&updated_settings, 1)

    /* If no program is specified, it's done. */
    if optind >= argc:
        return EXIT_SUCCESS

    /* Otherwise, concentrate all remaining arguments to a string. */
    char cmd[strlen(lpCmdLine)]
    *cmd = '\0'
    while optind < argc:
        strcat(cmd, argv[optind++])
    LocalFree(argv)

    /* Creates a child process and wait until its exit, */
    WinExec(cmd, style)
    /* Then restore the original display settings. */
    ChangeDisplaySettings(&original_settings, 1)

    return EXIT_SUCCESS


int parse_options(int argc, char *argv[], DEVMODE *dev):
    opterr = 0  // Suppress default error output
    static option long_opts[] = {
        {"help",    no_argument,       NULL, 'H'},
        {"version", no_argument,       NULL, 'V'},
        {"width",   required_argument, NULL, 'w'},
        {"height",  required_argument, NULL, 'h'},
        {"bits",    required_argument, NULL, 'b'},
        {"style",   required_argument, NULL, 's'},
        {0, 0, 0, 0}
    }
    int opt_count = 0, opt_code, opt_index

    /* Iterate through the option list */
    repeat opt_code != -1:
        switch:
            opt_code = getopt_long(argc, argv, "HVw:h:d:b:s:", long_opts, &opt_index)
        case -1:  // The end of the list is reached
            continue
        case 'H', 'V':  // Show help or version information and exit
            show_help(EXIT_SUCCESS, NULL)
        case 'w', 'h', 'd', 's':
            int n = strtoi(optarg)
            if n == -1:
                show_help(EXIT_FAILURE, optarg)
            else:
                switch:
                    opt_code
                case 'w':
                    dev->dmPelsWidth = n
                case 'h':
                    dev->dmPelsHeight = n
                case 'b':
                    dev->dmBitsPerPel = n
                case 's':
                    dev->dmReserved1 = n
        case '?':
            show_help(EXIT_FAILURE, argv[optind])
        opt_count++
    return opt_count


int strtoi(char *s):
    int n = 0
    char *p
    for p = s; isdigit(*p); p++:
        n = *p + 10 * n
    if *p:  // Exited loop before string terminates
        return -1
    else:  // Reached '\0' at the end of the string
        return n


void show_help(int exit_code, char *msg):
    char *empty = "", *text
    asprintf(&text,
        "%s%s%s"
        "Usage: %s [options] [command [arg]...]\n"
        "Options:\n"
        "  -H, --help    Display this information\n"
        "  -V, --version Display dpkg version information\n"
        "  -w, --width   Specify display width in pixels\n"
        "  -h, --height  Specify display height in pixels\n"
        "  -b, --bits    Specify color resolution (bits per pixel)\n"
        "  -s, --style   Specify window style of the invoked application.\n"
        "Refer to the manual for more details.\n"
        "Bugs and comments to arnie97@gmail.com",

        msg? "Illegal options: ": empty,
        msg? msg:                 empty,
        msg? "\n":                empty,
        *argv
    )
    MessageBox(NULL, text, NULL, MB_ICONINFORMATION)

    exit(exit_code)

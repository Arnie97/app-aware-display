#include <windows.h>
#include "shell.h"


HANDLE shell(char *cmd, int style):
    STARTUPINFO si = {0}
    PROCESS_INFORMATION pi = {0}
    si.dwFlags = STARTF_USESHOWWINDOW
    si.wShowWindow = style
    si.cb = sizeof(si)

    if CreateProcess(
        NULL,     // No module name (uses command line)
        cmd,      // Command line
        NULL,     // Process handle not inheritable
        NULL,     // Thread handle not inheritable
        FALSE,    // Handle inheritance
        0,        // No creation flags (process priority)
        NULL,     // Use parent's environment block
        NULL,     // Use parent's starting directory
        &si,      // Pointer to STARTUPINFO structure
        &pi       // Pointer to PROCESS_INFORMATION structure
    ):
        /* Close the unused thread handle. */
        CloseHandle(pi.hThread)
        return pi.hProcess
    else:
        return NULL

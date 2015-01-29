Concept
-------
In modern versions of Windows, you can easily run a program in VGA display mode or in 256 colors with compatibility settings. However, some programs may depend on other display modes. This tool helps to adjust display mode for miscellaneous legacy applications on Windows platform.

Command-line Arguments
----------------------
`$ app-aware-display [width] [height] [color-depth] program [arguments]`

Changes display mode with the given parameters, then invokes the program. Waits until the program exits, and adjusts the display mode back to the original. Omitted properties will be kept untouched, but if all arguments for display mode were omitted, the display resolution will be adjusted to VGA (640x480), and color depth will not be touched.

`$ app-aware-display width height [color-depth]`

Just adjust the display mode with the given parameters. Omitted properties will be left untouched.
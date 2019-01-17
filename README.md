Concept
-------
In modern versions of Windows, you can easily run a program in VGA display mode or in 256 colors with compatibility settings. However, some programs may depend on other display modes. This tool helps to adjust display mode for miscellaneous legacy applications on Windows platform.

Usage
-----
`$ app-aware-display [options] [command [arguments]]`

Changes the display mode to match specified options.
If a program command is present, then invokes it with given arguments, waits until it exits, and adjusts the display mode back to the original.

See the available options [here](app-aware-display.c.k#L127-L133), and arguments for the `--style` option [here](https://msdn.microsoft.com/EN-US/library/office/gg278437.aspx).

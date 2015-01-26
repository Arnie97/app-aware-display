Attribute VB_Name = "mdlMain"
'This module is in the public domain.  No warranties.

Option Explicit

Private Sub Main()
    Static OriginalWidth, OriginalHeight
    OriginalWidth = Screen.Width / Screen.TwipsPerPixelX
    OriginalHeight = Screen.Height / Screen.TwipsPerPixelY
    MsgBox "Screen Resolution: " & OriginalWidth & "x" & OriginalHeight
    SetDisplayMode 1024, 768, 32
    MsgBox "Screen Resolution: " & (Screen.Width / Screen.TwipsPerPixelX) & "x" & (Screen.Height / Screen.TwipsPerPixelY)
    SetDisplayMode OriginalWidth, OriginalHeight
End Sub


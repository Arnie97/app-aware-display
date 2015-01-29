Attribute VB_Name = "mdlMain"
'This module is in the public domain.  No warranties.

Option Explicit

Private Sub Main()
    Dim temp_v As Integer, argv(2) As Integer, argv_pos As Integer
    Dim temp_s As String, args() As String, args_pos As Integer, args_count As Integer
    Dim original_width As Integer, original_height As Integer
    argv_pos = 0
    args_pos = 0
    argv(0) = 640: argv(1) = 480
    args = Split(Command, " ")
    args_count = UBound(args) + 1
    If args_count = 0 Then
        ShowUsage "Command line parameters not given."
        Exit Sub
    End If
    Do
        temp_s = args(args_pos)
        temp_v = Val(temp_s)
        If temp_v Then
            argv(argv_pos) = temp_v
            args(args_pos) = vbNullString
            argv_pos = argv_pos + 1
        ElseIf Len(temp_s) Then
            Exit Do
        End If
        args_pos = args_pos + 1
    Loop While (argv_pos < 3) And (args_pos < args_count)
    temp_s = Trim(Join(args, " "))
    
    original_width = Screen.Width / Screen.TwipsPerPixelX
    original_height = Screen.Height / Screen.TwipsPerPixelY
    SetDisplayMode argv(0), argv(1), argv(2)
    If Len(temp_s) Then
        Call ShellWait(temp_s, vbMaximizedFocus)
        SetDisplayMode original_width, original_height
    End If
End Sub

Private Sub ShowUsage(Optional Message As String)
    If Len(Message) Then
        Message = Message & vbCrLf
    End If
    MsgBox (Message & "Usage: " & vbCrLf & _
        App.EXEName & " [width] [height] [color-depth] program [arguments]" & vbCrLf & _
        App.EXEName & " width height [color-depth]" & vbCrLf & _
        "Bugs and comments to arnie97@gmail.com"), vbInformation
End Sub

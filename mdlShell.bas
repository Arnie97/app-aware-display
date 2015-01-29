Attribute VB_Name = "mdlShell"
'This module is in the public domain.  No warranties.

Option Explicit

Const SYNCHRONIZE = &H100000
Private Declare Function OpenProcess Lib "kernel32" _
    (ByVal dwDesiredAccess As Long, ByVal bInheritHandle As Long, ByVal dwProcessId As Long) As Long

Const INFINITE = &HFFFFFFFF
Private Declare Function WaitForSingleObject Lib "kernel32" _
    (ByVal hHandle As Long, ByVal dwMilliseconds As Long) As Long

Private Declare Function CloseHandle Lib "kernel32" _
    (ByVal hObject As Long) As Long


Public Function ShellWait _
(PathName As String, WindowStyle As VbAppWinStyle, Optional Timeout As Long) As Long
    Dim pid As Long, process_handle As Long
    If Timeout = 0 Then Timeout = INFINITE
    pid = Shell(PathName, WindowStyle)
    process_handle = OpenProcess(SYNCHRONIZE, 0, pid)
    If process_handle Then
        Call WaitForSingleObject(process_handle, Timeout)
        Call CloseHandle(pid)
    End If
    ShellWait = process_handle
End Function

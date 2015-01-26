Attribute VB_Name = "mdlDisplaySettings"
'This module is in the public domain.  No warranties.

Option Explicit

Private Declare Function lstrcpy Lib "kernel32" Alias "lstrcpyA" _
    (lpString1 As Any, lpString2 As Any) As Long

Const CCHDEVICENAME = 32
Const CCHFORMNAME = 32
Private Type DEVMODE
    dmDeviceName As String * CCHDEVICENAME
    dmSpecVersion As Integer
    dmDriverVersion As Integer
    dmSize As Integer
    dmDriverExtra As Integer
    dmFields As Long
    dmOrientation As Integer
    dmPaperSize As Integer
    dmPaperLength As Integer
    dmPaperWidth As Integer
    dmScale As Integer
    dmCopies As Integer
    dmDefaultSource As Integer
    dmPrintQuality As Integer
    dmColor As Integer
    dmDuplex As Integer
    dmYResolution As Integer
    dmTTOption As Integer
    dmCollate As Integer
    dmFormName As String * CCHFORMNAME
    dmUnusedPadding As Integer
    dmBitsPerPel As Long
    dmPelsWidth As Long
    dmPelsHeight As Long
    dmDisplayFlags As Long
    dmDisplayFrequency As Long
End Type
Const DM_PELSWIDTH = &H80000
Const DM_PELSHEIGHT = &H100000
Const DM_BITSPERPEL = &H40000
Const DM_DISPLAYFLAGS = &H200000
Private Declare Function ChangeDisplaySettingsA Lib "user32" _
(ByVal lpDevMode As Long, ByVal dwflags As Long) As Long

Const ENUM_CURRENT_SETTINGS = 1
Private Declare Function EnumDisplaySettingsA Lib "user32" _
(ByVal lpszDeviceName As String, ByVal iModeNum As Long, lpDevMode As Any) As Long

Const SM_CXSCREEN = 0
Const SM_CYSCREEN = 1
Private Declare Function GetSystemMetrics Lib "user32" _
(ByVal nIndex As Long) As Long


Public Function SetDisplayMode _
(Optional ByVal Width As Integer, Optional ByVal Height As Integer, Optional ByVal Color As Integer) As Long
    Dim pNewMode As DEVMODE, pOldMode As Long
    With pNewMode
        .dmSize = Len(pNewMode)
        If Width Then
            .dmPelsWidth = Width
            .dmFields = .dmFields Or DM_PELSWIDTH
        End If
        If Height Then
            .dmPelsHeight = Height
            .dmFields = .dmFields Or DM_PELSHEIGHT
        End If
        If Color Then
            .dmBitsPerPel = Color
            .dmFields = .dmFields Or DM_BITSPERPEL
        End If
    End With
    pOldMode = lstrcpy(pNewMode, pNewMode)
    SetDisplayMode = ChangeDisplaySettingsA(pOldMode, 1)
End Function

Attribute VB_Name = "CommonTkCanvas"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'canvas system access routines
Option Explicit

Declare Function CNVInit Lib "actkrt3.dll" () As Long

Declare Function CNVShutdown Lib "actkrt3.dll" () As Long

Declare Function CNVCreate Lib "actkrt3.dll" (ByVal hdcCompatable As Long, ByVal width As Long, ByVal height As Long, Optional ByVal useDX As Long = 1) As Long

Declare Function CNVDestroy Lib "actkrt3.dll" (ByVal handle As Long) As Long

Declare Function CNVOpenHDC Lib "actkrt3.dll" (ByVal handle As Long) As Long

Declare Function CNVCloseHDC Lib "actkrt3.dll" (ByVal handle As Long, ByVal hdc As Long) As Long

Declare Function CNVLock Lib "actkrt3.dll" (ByVal handle As Long) As Long

Declare Function CNVUnlock Lib "actkrt3.dll" (ByVal handle As Long) As Long

Declare Function CNVGetWidth Lib "actkrt3.dll" (ByVal handle As Long) As Long

Declare Function CNVGetHeight Lib "actkrt3.dll" (ByVal handle As Long) As Long

Declare Function CNVGetPixel Lib "actkrt3.dll" (ByVal handle As Long, ByVal x As Long, ByVal y As Long) As Long

Declare Function CNVSetPixel Lib "actkrt3.dll" (ByVal handle As Long, ByVal x As Long, ByVal y As Long, ByVal crColor As Long) As Long

Declare Function CNVExists Lib "actkrt3.dll" (ByVal handle As Long) As Long

Declare Function CNVBltCanvas Lib "actkrt3.dll" (ByVal sourceHandle As Long, ByVal targetHandle As Long, ByVal x As Long, ByVal y As Long, Optional ByVal rasterOp As Long = SRCCOPY) As Long

Declare Function CNVBltCanvasTransparent Lib "actkrt3.dll" (ByVal sourceHandle As Long, ByVal targetHandle As Long, ByVal x As Long, ByVal y As Long, Optional ByVal crColor As Long) As Long

Declare Function CNVBltCanvasTranslucent Lib "actkrt3.dll" (ByVal sourceHandle As Long, ByVal targetHandle As Long, ByVal x As Long, ByVal y As Long, Optional ByVal dIntensity As Double = 0.5, Optional ByVal crUnaffectedColor As Long = -1, Optional ByVal crTransparentColor As Long = -1) As Long

Declare Function CNVGetRGBColor Lib "actkrt3.dll" (ByVal handle As Long, ByVal crColor As Long) As Long

Declare Function CNVResize Lib "actkrt3.dll" (ByVal handle As Long, ByVal hdcCompatible As Long, ByVal width As Long, ByVal height As Long) As Long

Declare Function CNVShiftLeft Lib "actkrt3.dll" (ByVal handle As Long, ByVal pixels As Long) As Long

Declare Function CNVShiftRight Lib "actkrt3.dll" (ByVal handle As Long, ByVal pixels As Long) As Long

Declare Function CNVShiftUp Lib "actkrt3.dll" (ByVal handle As Long, ByVal pixels As Long) As Long

Declare Function CNVShiftDown Lib "actkrt3.dll" (ByVal handle As Long, ByVal pixels As Long) As Long

Declare Function CNVBltPartCanvas Lib "actkrt3.dll" (ByVal sourceHandle As Long, ByVal targetHandle As Long, ByVal x As Long, ByVal y As Long, ByVal xsrc As Long, ByVal ysrc As Long, ByVal nWidth As Long, ByVal nHeight As Long, Optional ByVal rasterOp As Long = SRCCOPY) As Long

Declare Function CNVBltTransparentPartCanvas Lib "actkrt3.dll" (ByVal sourceHandle As Long, ByVal targetHandle As Long, ByVal x As Long, ByVal y As Long, ByVal xsrc As Long, ByVal ysrc As Long, ByVal nWidth As Long, ByVal nHeight As Long, Optional ByVal crColor As Long) As Long

Function CanvasOccupied(ByVal handle As Long) As Boolean
    'determine if a canvas exists
    On Error Resume Next
    Dim a As Long
    a = CNVExists(handle)
    If a = 0 Then
        CanvasOccupied = False
    Else
        CanvasOccupied = True
    End If
End Function



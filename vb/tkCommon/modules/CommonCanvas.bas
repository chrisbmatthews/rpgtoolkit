Attribute VB_Name = "CommonCanvas"
'=========================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=========================================================================

'=========================================================================
' Canvas (backbuffer) engine
'=========================================================================

Option Explicit

'=========================================================================
' FreeImage image manipulation
'=========================================================================
Private Declare Function IMGBlt Lib "actkrt3.dll" (ByVal nFreeImagePtr As Long, ByVal x As Long, ByVal y As Long, ByVal hdc As Long) As Long
Private Declare Function IMGGetWidth Lib "actkrt3.dll" (ByVal nFreeImagePtr As Long) As Long
Private Declare Function IMGGetHeight Lib "actkrt3.dll" (ByVal nFreeImagePtr As Long) As Long
Private Declare Function IMGLoad Lib "actkrt3.dll" (ByVal fileName As String) As Long

'=========================================================================
' Canvas manipulation
'=========================================================================
Private Declare Function CNVInit Lib "actkrt3.dll" () As Long
Private Declare Function CNVShutdown Lib "actkrt3.dll" () As Long
Private Declare Function CNVCreate Lib "actkrt3.dll" (ByVal hdcCompatable As Long, ByVal width As Long, ByVal height As Long, Optional ByVal useDX As Long = 1) As Long
Private Declare Function CNVDestroy Lib "actkrt3.dll" (ByVal handle As Long) As Long
Private Declare Function CNVOpenHDC Lib "actkrt3.dll" (ByVal handle As Long) As Long
Private Declare Function CNVCloseHDC Lib "actkrt3.dll" (ByVal handle As Long, ByVal hdc As Long) As Long
Private Declare Function CNVLock Lib "actkrt3.dll" (ByVal handle As Long) As Long
Private Declare Function CNVUnlock Lib "actkrt3.dll" (ByVal handle As Long) As Long
Private Declare Function CNVGetWidth Lib "actkrt3.dll" (ByVal handle As Long) As Long
Private Declare Function CNVGetHeight Lib "actkrt3.dll" (ByVal handle As Long) As Long
Private Declare Function CNVGetPixel Lib "actkrt3.dll" (ByVal handle As Long, ByVal x As Long, ByVal y As Long) As Long
Private Declare Function CNVSetPixel Lib "actkrt3.dll" (ByVal handle As Long, ByVal x As Long, ByVal y As Long, ByVal crColor As Long) As Long
Private Declare Function CNVExists Lib "actkrt3.dll" (ByVal handle As Long) As Long
Private Declare Function CNVBltCanvas Lib "actkrt3.dll" (ByVal sourceHandle As Long, ByVal targetHandle As Long, ByVal x As Long, ByVal y As Long, Optional ByVal rasterOp As Long = SRCCOPY) As Long
Private Declare Function CNVBltCanvasTransparent Lib "actkrt3.dll" (ByVal sourceHandle As Long, ByVal targetHandle As Long, ByVal x As Long, ByVal y As Long, Optional ByVal crColor As Long) As Long
Private Declare Function CNVBltCanvasTranslucent Lib "actkrt3.dll" (ByVal sourceHandle As Long, ByVal targetHandle As Long, ByVal x As Long, ByVal y As Long, Optional ByVal dIntensity As Double = 0.5, Optional ByVal crUnaffectedColor As Long = -1, Optional ByVal crTransparentColor As Long = -1) As Long
Private Declare Function CNVGetRGBColor Lib "actkrt3.dll" (ByVal handle As Long, ByVal crColor As Long) As Long
Private Declare Function CNVResize Lib "actkrt3.dll" (ByVal handle As Long, ByVal hdcCompatible As Long, ByVal width As Long, ByVal height As Long) As Long
Private Declare Function CNVShiftLeft Lib "actkrt3.dll" (ByVal handle As Long, ByVal pixels As Long) As Long
Private Declare Function CNVShiftRight Lib "actkrt3.dll" (ByVal handle As Long, ByVal pixels As Long) As Long
Private Declare Function CNVShiftUp Lib "actkrt3.dll" (ByVal handle As Long, ByVal pixels As Long) As Long
Private Declare Function CNVShiftDown Lib "actkrt3.dll" (ByVal handle As Long, ByVal pixels As Long) As Long
Private Declare Function CNVBltPartCanvas Lib "actkrt3.dll" (ByVal sourceHandle As Long, ByVal targetHandle As Long, ByVal x As Long, ByVal y As Long, ByVal xsrc As Long, ByVal ysrc As Long, ByVal nWidth As Long, ByVal nHeight As Long, Optional ByVal rasterOp As Long = SRCCOPY) As Long
Private Declare Function CNVBltTransparentPartCanvas Lib "actkrt3.dll" (ByVal sourceHandle As Long, ByVal targetHandle As Long, ByVal x As Long, ByVal y As Long, ByVal xsrc As Long, ByVal ysrc As Long, ByVal nWidth As Long, ByVal nHeight As Long, Optional ByVal crColor As Long) As Long
Private Declare Function CNVCreateCanvasHost Lib "actkrt3.dll" (ByVal hInstance As Long) As Long
Private Declare Sub CNVKillCanvasHost Lib "actkrt3.dll" (ByVal hInstance As Long, ByVal hCanvasHostDC As Long)

'=========================================================================
' Member variables
'=========================================================================
Private canvasHost As Long      'This variable contains a handle to a device
                                'context (created in initCanvasEngine) which
                                'all other canvas' dc's are based upon.

'=========================================================================
' Draw a background onto a canvas
'=========================================================================
Public Sub CanvasDrawBackground(ByVal canvasID As Long, ByVal bkgFile As String, ByVal x As Long, ByVal y As Long, ByVal width As Long, ByVal height As Long)
    On Error Resume Next
    If CanvasOccupied(canvasID) Then
        Dim bkg As TKBackground
        Call openBackground(bkgFile, bkg)
        Dim hdc As Long
        hdc = CanvasOpenHDC(canvasID)
        Call DrawBackground(bkg, x, y, width, height, hdc)
        Call CanvasCloseHDC(canvasID, hdc)
    End If
End Sub

'=========================================================================
' Blt a canvas onto a picture box (SRCAND)
'=========================================================================
Public Function CanvasBltAnd(ByVal canvasID As Long, ByVal destX As Long, ByVal destY As Long, ByVal destPicHdc As Long) As Long
    On Error Resume Next
    If CanvasOccupied(canvasID) Then
        Dim hdc As Long
        hdc = CanvasOpenHDC(canvasID)
        CanvasBltAnd = BitBlt(destPicHdc, _
                           destX, _
                           destY, _
                           GetCanvasWidth(canvasID), _
                           GetCanvasHeight(canvasID), _
                           hdc, 0, 0, SRCAND)
        Call CanvasCloseHDC(canvasID, hdc)
    Else
        CanvasBltAnd = -1
    End If
End Function

'=========================================================================
' Copy one canvas to another
'=========================================================================
Public Function Canvas2CanvasBlt(ByVal canvasSource As Long, ByVal canvasDest As Long, ByVal destX As Long, ByVal destY As Long, Optional ByVal rasterOp As Long = SRCCOPY) As Long
    On Error Resume Next
    If CanvasOccupied(canvasSource) And CanvasOccupied(canvasDest) Then
        Canvas2CanvasBlt = CNVBltCanvas(canvasSource, canvasDest, destX, destY, rasterOp)
    Else
        Canvas2CanvasBlt = -1
    End If
End Function

'=========================================================================
' Draw a hand on a canvas
'=========================================================================
#If isToolkit = 0 Then
Public Sub CanvasDrawHand(ByVal canvasID As Long, ByVal pointx As Long, ByVal pointy As Long)
    On Error Resume Next
    If CanvasOccupied(canvasID) Then
        Dim cnv As Long, hdc As Long
        cnv = CreateCanvas(32, 32)
        hdc = CanvasOpenHDC(cnv)
        Call BitBlt(hdc, 0, 0, 32, 32, handHDC, 0, 0, SRCCOPY)
        Call CanvasCloseHDC(cnv, hdc)
        Call Canvas2CanvasBltTransparent(cnv, canvasID, pointx - 32, pointy - 10, RGB(255, 0, 0))
        Call DestroyCanvas(cnv)
    End If
End Sub
#End If

'=========================================================================
' Draw text onto a canvas
'=========================================================================
Public Sub CanvasDrawText(ByVal canvasID As Long, ByVal Text As String, ByVal font As String, ByVal size As Long, ByVal x As Double, ByVal y As Double, ByVal crColor As Long, Optional ByVal Bold As Boolean = False, Optional ByVal Italics As Boolean = False, Optional ByVal Underline As Boolean = False, Optional ByVal centred As Boolean = False, Optional ByVal outlined As Boolean = False)
    On Error Resume Next
    If CanvasOccupied(canvasID) Then
        Dim hdc As Long
        hdc = CanvasOpenHDC(canvasID)
        Call drawGDIText(Text, x, y, crColor, size, size, font, Bold, Italics, Underline, hdc, centred, outlined)
        Call CanvasCloseHDC(canvasID, hdc)
    End If
End Sub

'=========================================================================
' Copy the screen onto a canvas
'=========================================================================
Public Function CanvasGetScreen(ByVal canvasID As Long) As Long
    On Error Resume Next
    If CanvasOccupied(canvasID) Then
        CanvasGetScreen = DXCopyScreenToCanvas(canvasID)
    Else
        CanvasGetScreen = -1
    End If
End Function

'=========================================================================
' Partially copy one canvas onto another one
'=========================================================================
Public Function Canvas2CanvasBltPartial(ByVal canvasSource As Long, ByVal canvasDest As Long, ByVal destX As Long, ByVal destY As Long, ByVal srcX As Long, ByVal srcY As Long, ByVal width As Long, ByVal height As Long, Optional ByVal rasterOp As Long = SRCCOPY) As Long
    On Error Resume Next
    If CanvasOccupied(canvasSource) And CanvasOccupied(canvasDest) Then
        Canvas2CanvasBltPartial = CNVBltPartCanvas(canvasSource, canvasDest, destX, destY, srcX, srcY, width, height, rasterOp)
    Else
        Canvas2CanvasBltPartial = -1
    End If
End Function

'=========================================================================
' Transparently copy part of a canvas onto another one
'=========================================================================
Public Function Canvas2CanvasBltTransparentPartial(ByVal canvasSource As Long, ByVal canvasDest As Long, ByVal destX As Long, ByVal destY As Long, ByVal srcX As Long, ByVal srcY As Long, ByVal width As Long, ByVal height As Long, Optional ByVal crColor As Long) As Long
    On Error Resume Next
    If CanvasOccupied(canvasSource) And CanvasOccupied(canvasDest) Then
        Canvas2CanvasBltTransparentPartial = CNVBltTransparentPartCanvas(canvasSource, canvasDest, destX, destY, srcX, srcY, width, height, crColor)
    Else
        Canvas2CanvasBltTransparentPartial = -1
    End If
End Function

'=========================================================================
' Transparenly copy a canvas to another one
'=========================================================================
Public Function Canvas2CanvasBltTransparent(ByVal canvasSource As Long, ByVal canvasDest As Long, ByVal destX As Long, ByVal destY As Long, Optional ByVal crColor As Long) As Long
    On Error Resume Next
    If CanvasOccupied(canvasSource) And CanvasOccupied(canvasDest) Then
        Canvas2CanvasBltTransparent = CNVBltCanvasTransparent(canvasSource, canvasDest, destX, destY, crColor)
    Else
        Canvas2CanvasBltTransparent = -1
    End If
End Function

'=========================================================================
' Translucently copy a canvas to another one
'=========================================================================
Public Function Canvas2CanvasBltTranslucent(ByVal canvasSource As Long, ByVal canvasDest As Long, ByVal destX As Long, ByVal destY As Long, Optional ByVal dIntensity As Double = 0.5, Optional ByVal crUnaffectedColor As Long = -1, Optional ByVal crTransparentColor As Long = -1) As Long
    On Error Resume Next
    If CanvasOccupied(canvasSource) And CanvasOccupied(canvasDest) Then
        Call CNVBltCanvasTranslucent(canvasSource, canvasDest, destX, destY, dIntensity, crUnaffectedColor, crTransparentColor)
        Canvas2CanvasBltTranslucent = DXDrawCanvasTranslucent(canvasSource, _
         destX, destY, dIntensity, crUnaffectedColor, crTransparentColor)
    Else
        Canvas2CanvasBltTranslucent = -1
    End If
End Function

'=========================================================================
' Draw a box on a canvas
'=========================================================================
Public Sub CanvasBox(ByVal canvasID As Long, ByVal x1 As Long, ByVal y1 As Long, ByVal x2 As Long, ByVal y2 As Long, ByVal crColor As Long)
    On Error Resume Next
    If CanvasOccupied(canvasID) Then
    Dim rgn As Long, brush As Long, hdc As Long
        rgn = CreateRectRgn(x1, y1, x2 + 1, y2 + 1)
        brush = CreateSolidBrush(crColor)
        hdc = CanvasOpenHDC(canvasID)
        Call FrameRgn(hdc, rgn, brush, 1, 1)
        Call CanvasCloseHDC(canvasID, hdc)
        Call DeleteObject(rgn)
        Call DeleteObject(brush)
    End If
End Sub

'=========================================================================
' Draw a filled ellipse on a canvas
'=========================================================================
Public Sub CanvasDrawFilledEllipse(ByVal canvasID As Long, ByVal x1 As Long, ByVal y1 As Long, ByVal x2 As Long, ByVal y2 As Long, ByVal crColor As Long)
    On Error Resume Next
    Dim hdc As Long, pen As Long, l As Long, brush As Long, m As Long
    hdc = CanvasOpenHDC(canvasID)
    pen = CreatePen(0, 1, crColor)
    l = SelectObject(hdc, pen)
    brush = CreateSolidBrush(crColor)
    m = SelectObject(hdc, brush)
    Call Ellipse(hdc, x1, y1, x2, y2)
    Call SelectObject(hdc, m)
    Call SelectObject(hdc, l)
    Call DeleteObject(brush)
    Call DeleteObject(pen)
    Call CanvasCloseHDC(canvasID, hdc)
End Sub

'=========================================================================
' Draw an ellipse on a canvas
'=========================================================================
Public Sub CanvasDrawEllipse(ByVal canvasID As Long, ByVal x1 As Long, ByVal y1 As Long, ByVal x2 As Long, ByVal y2 As Long, ByVal crColor As Long)
    On Error Resume Next
    If CanvasOccupied(canvasID) Then
        Dim rgn As Long, brush As Long, hdc As Long
        rgn = CreateEllipticRgn(x1, y1, x2 + 1, y2 + 1)
        brush = CreateSolidBrush(crColor)
        hdc = CanvasOpenHDC(canvasID)
        Call FrameRgn(hdc, rgn, brush, 1, 1)
        Call CanvasCloseHDC(canvasID, hdc)
        Call DeleteObject(rgn)
        Call DeleteObject(brush)
    End If
End Sub

'=========================================================================
' Stretch a mask over a canvas
'=========================================================================
Public Function CanvasMaskBltStretch(ByVal canvasIDSource As Long, ByVal canvasIDMask As Long, ByVal destX As Long, ByVal destY As Long, ByVal newWidth As Long, ByVal newHeight As Long, ByVal destPicHdc As Long) As Long
    On Error Resume Next
    If CanvasOccupied(canvasIDSource) Then
        Dim W As Long, h As Long, hdcMask As Long, hdcSource As Long
        W = GetCanvasWidth(canvasIDSource)
        h = GetCanvasHeight(canvasIDSource)
        hdcMask = CanvasOpenHDC(canvasIDMask)
        hdcSource = CanvasOpenHDC(canvasIDSource)
        CanvasMaskBltStretch = StretchBlt(destPicHdc, _
                           destX, _
                           destY, _
                           newWidth, _
                           newHeight, _
                           hdcMask, _
                           0, 0, _
                           W, _
                           h, _
                           SRCAND)
        CanvasMaskBltStretch = StretchBlt(destPicHdc, _
                           destX, _
                           destY, _
                           newWidth, _
                           newHeight, _
                           hdcSource, _
                           0, 0, _
                           W, _
                           h, _
                           SRCPAINT)
        Call CanvasCloseHDC(canvasIDMask, hdcMask)
        Call CanvasCloseHDC(canvasIDSource, hdcSource)
    Else
        CanvasMaskBltStretch = -1
    End If
End Function

'=========================================================================
' Draw a line on a canvas
'=========================================================================
Public Sub CanvasDrawLine(ByVal canvasID As Long, ByVal x1 As Long, ByVal y1 As Long, ByVal x2 As Long, ByVal y2 As Long, ByVal crColor As Long)
    On Error Resume Next
    If CanvasOccupied(canvasID) Then
        Dim hdc As Long, brush As Long, point As POINTAPI, m As Long
        hdc = CanvasOpenHDC(canvasID)
        brush = CreatePen(0, 1, crColor)
        m = SelectObject(hdc, brush)
        Call MoveToEx(hdc, x1, y1, point)
        Call LineTo(hdc, x2, y2)
        Call SelectObject(hdc, m)
        Call DeleteObject(brush)
        Call CanvasCloseHDC(canvasID, hdc)
    End If
End Sub

'=========================================================================
' Load a picture onto a canvas and resize *the canvas*
'=========================================================================
Public Sub CanvasLoadFullPicture(ByVal canvasID As Long, ByVal file As String, ByVal minX As Long, ByVal minY As Long)
    On Error Resume Next
    If CanvasOccupied(canvasID) And fileExists(file) Then
        Dim img As Long, sizex As Long, sizey As Long
        img = IMGLoad(file)
        If (img <> 0) Then
            sizex = IMGGetWidth(img)
            sizey = IMGGetHeight(img)
            
            If minX = -1 Then
                Call SetCanvasSize(canvasID, sizex, sizey)
            Else
                Dim tW As Long, tH As Long
                tW = sizex
                tH = sizey
                If sizex < minX Then
                    tW = minX
                End If
                If sizey < minY Then
                    tH = minY
                End If
                Call SetCanvasSize(canvasID, tW, tH)
            End If
            Dim hdc As Long
            hdc = CanvasOpenHDC(canvasID)
            Call IMGBlt(img, 0, 0, hdc)
            Call CanvasCloseHDC(canvasID, hdc)
        End If
    End If
End Sub

'=========================================================================
' Fill a box on a canvas
'=========================================================================
Public Sub CanvasFillBox(ByVal canvasID As Long, ByVal x1 As Long, ByVal y1 As Long, ByVal x2 As Long, ByVal y2 As Long, ByVal crColor As Long)
    On Error Resume Next
    If CanvasOccupied(canvasID) Then
        Dim hdc As Long, pen As Long, l As Long, brush As Long, m As Long
        hdc = CanvasOpenHDC(canvasID)
        pen = CreatePen(0, 1, crColor)
        l = SelectObject(hdc, pen)
        brush = CreateSolidBrush(crColor)
        m = SelectObject(hdc, brush)
        Dim theRegion As RECT
        With theRegion
            .Bottom = y2 + 1
            .Right = x2 + 1
            .Left = x1
            .Top = y1
        End With
        Call FillRect(hdc, theRegion, brush)
        Call SelectObject(hdc, m)
        Call SelectObject(hdc, l)
        Call DeleteObject(brush)
        Call DeleteObject(pen)
        Call CanvasCloseHDC(canvasID, hdc)
    End If
End Sub

'=========================================================================
' Blt a mask over a canvas
'=========================================================================
Public Function CanvasMaskBlt(ByVal canvasIDSource As Long, ByVal canvasIDMask As Long, ByVal destX As Long, ByVal destY As Long, ByVal destPicHdc As Long) As Long
    On Error Resume Next
    If CanvasOccupied(canvasIDSource) Then
        Dim hdcMask As Long, hdcSource As Long
        hdcMask = CanvasOpenHDC(canvasIDMask)
        hdcSource = CanvasOpenHDC(canvasIDSource)
        CanvasMaskBlt = BitBlt(destPicHdc, _
                           destX, _
                           destY, _
                           GetCanvasWidth(canvasIDMask), _
                           GetCanvasHeight(canvasIDMask), _
                           hdcMask, 0, 0, SRCAND)
        CanvasMaskBlt = BitBlt(destPicHdc, _
                           destX, _
                           destY, _
                           GetCanvasWidth(canvasIDSource), _
                           GetCanvasHeight(canvasIDSource), _
                           hdcSource, 0, 0, SRCPAINT)
        Call CanvasCloseHDC(canvasIDMask, hdcMask)
        Call CanvasCloseHDC(canvasIDSource, hdcSource)
    Else
        CanvasMaskBlt = -1
    End If
End Function

'=========================================================================
' Fill a canvas with a color
'=========================================================================
Public Sub CanvasFill(ByVal canvasID As Long, ByVal crColor As Long)
    On Error Resume Next
    Call CanvasFillBox(canvasID, 0, 0, GetCanvasWidth(canvasID), GetCanvasHeight(canvasID), crColor)
End Sub

'=========================================================================
' Get a pixel on a canvas
'=========================================================================
Public Function CanvasGetPixel(ByVal canvasID As Long, ByVal x As Long, ByVal y As Long) As Long
    On Error Resume Next
    If CanvasOccupied(canvasID) Then
        CanvasGetPixel = CNVGetPixel(canvasID, x, y)
    Else
        CanvasGetPixel = -1
    End If
End Function

'=========================================================================
' Load a picture onto a canvas
'=========================================================================
Public Function CanvasLoadPicture(ByVal canvasID As Long, ByVal fileName As String) As Long
    On Error Resume Next
    If CanvasOccupied(canvasID) And fileExists(fileName) Then
        Call drawImageCNV(fileName, 0, 0, canvasID)
        CanvasLoadPicture = 0
    Else
        CanvasLoadPicture = -1
    End If
End Function

'=========================================================================
' Load a picture onto a canvas and resize *the picture*
'=========================================================================
Public Sub CanvasLoadSizedPicture(ByVal canvasID As Long, ByVal file As String)
    On Error Resume Next
    If CanvasOccupied(canvasID) And fileExists(file) Then
        Dim hdc As Long
        hdc = CanvasOpenHDC(canvasID)
        Call DrawSizedImage(file, 0, 0, GetCanvasWidth(canvasID), GetCanvasHeight(canvasID), hdc)
        Call CanvasCloseHDC(canvasID, hdc)
    End If
End Sub

'=========================================================================
' Set a pixel on a canvas
'=========================================================================
Public Function CanvasSetPixel(ByVal canvasID As Long, ByVal x As Long, ByVal y As Long, ByVal crColor As Long) As Long
    On Error Resume Next
    If CanvasOccupied(canvasID) Then
        CanvasSetPixel = CNVSetPixel(canvasID, x, y, crColor)
    Else
        CanvasSetPixel = -1
    End If
End Function

'=========================================================================
' Transparently blt a picture box into a canvas
'=========================================================================
Public Function CanvasTransBltInto(ByVal canvasID As Long, ByVal canvasDestX As Long, ByVal canvasDestY As Long, ByVal newWidth As Long, ByVal newHeight As Long, ByVal sourceX As Long, ByVal sourceY As Long, ByVal sourceWidth As Long, ByVal sourceHeight As Long, ByVal sourceHDC As Long, ByVal crTranscolor As Long) As Long
    On Error Resume Next
    If CanvasOccupied(canvasID) Then
        Dim cHdc As Long
        cHdc = CanvasOpenHDC(canvasID)
        CanvasTransBltInto = GFXBitBltTransparent(cHdc, _
                                canvasDestX, _
                                canvasDestY, _
                                sourceWidth, _
                                sourceHeight, _
                                sourceHDC, _
                                sourceX, _
                                sourceY, _
                                red(crTranscolor), _
                                green(crTranscolor), _
                                blue(crTranscolor))
        Call CanvasCloseHDC(canvasID, cHdc)
    Else
        CanvasTransBltInto = -1
    End If
End Function

'=========================================================================
' Blt a resized picture box into a canvas
'=========================================================================
Public Function CanvasStretchBltInto(ByVal canvasID As Long, ByVal canvasDestX As Long, ByVal canvasDestY As Long, ByVal newWidth As Long, ByVal newHeight As Long, ByVal sourceX As Long, ByVal sourceY As Long, ByVal sourceWidth As Long, ByVal sourceHeight As Long, ByVal sourceHDC As Long) As Long
    On Error Resume Next
    If CanvasOccupied(canvasID) Then
        Dim hdc As Long
        hdc = CanvasOpenHDC(canvasID)
        CanvasStretchBltInto = StretchBlt(hdc, _
                                     canvasDestX, canvasDestY, _
                                     newWidth, newHeight, _
                                     sourceHDC, _
                                     sourceX, sourceY, _
                                     sourceWidth, sourceHeight, _
                                     SRCCOPY)
        Call CanvasCloseHDC(canvasID, hdc)
    Else
        CanvasStretchBltInto = -1
    End If
End Function

'=========================================================================
' Blt a picture box into a canvas
'=========================================================================
Public Function CanvasBltInto(ByVal canvasID As Long, ByVal canvasDestX As Long, ByVal canvasDestY As Long, ByVal sourceX As Long, ByVal sourceY As Long, ByVal sourceWidth As Long, ByVal sourceHeight As Long, ByVal sourceHDC As Long) As Long
    On Error Resume Next
    If CanvasOccupied(canvasID) Then
        Dim hdc As Long
        hdc = CanvasOpenHDC(canvasID)
        CanvasBltInto = BitBlt(hdc, _
                           canvasDestX, _
                           canvasDestY, _
                           sourceWidth, _
                           sourceHeight, _
                           sourceHDC, _
                           sourceX, sourceY, _
                           SRCCOPY)
        Call CanvasCloseHDC(canvasID, hdc)
    Else
        CanvasBltInto = -1
    End If
End Function

'=========================================================================
' Blt a canvas onto a picture box transparently
'=========================================================================
Public Function CanvasTransBlt2(ByVal canvasID As Long, ByVal newWidth As Long, ByVal newHeight As Long, ByVal destX As Long, ByVal destY As Long, ByVal sourceX As Long, ByVal sourceY As Long, ByVal sourceWidth As Long, ByVal sourceHeight As Long, ByVal destPicHdc As Long, ByVal crTranscolor As Long) As Long
    On Error Resume Next
    If CanvasOccupied(canvasID) Then
        Dim cHdc As Long
        cHdc = CanvasOpenHDC(canvasID)
        CanvasTransBlt2 = GFXBitBltTransparent(destPicHdc, destX, destY, newWidth, newHeight, cHdc, sourceX, sourceY, red(crTranscolor), green(crTranscolor), blue(crTranscolor))
        Call CanvasCloseHDC(canvasID, cHdc)
    Else
        CanvasTransBlt2 = -1
    End If
End Function

'=========================================================================
' Blt a canvas (resized) onto a picture box
'=========================================================================
Public Function CanvasStretchBlt2(ByVal canvasID As Long, ByVal newWidth As Long, ByVal newHeight As Long, ByVal destX As Long, ByVal destY As Long, ByVal sourceX As Long, ByVal sourceY As Long, ByVal sourceWidth As Long, ByVal sourceHeight As Long, ByVal destPicHdc As Long) As Long
    On Error Resume Next
    If CanvasOccupied(canvasID) Then
        Dim hdc As Long
        hdc = CanvasOpenHDC(canvasID)
        CanvasStretchBlt2 = StretchBlt(destPicHdc, _
                                     destX, destY, _
                                     newWidth, newHeight, _
                                     hdc, _
                                     sourceX, sourceY, _
                                     sourceWidth, sourceHeight, _
                                     SRCCOPY)
        Call CanvasCloseHDC(canvasID, hdc)
    Else
        CanvasStretchBlt2 = -1
    End If
End Function

'=========================================================================
' Blt a canvas onto a picture box
'=========================================================================
Public Function CanvasBlt2(ByVal canvasID As Long, ByVal destX As Long, ByVal destY As Long, ByVal sourceX As Long, ByVal sourceY As Long, ByVal width As Long, ByVal height As Long, ByVal destPicHdc As Long) As Long
    On Error Resume Next
    If CanvasOccupied(canvasID) Then
        Dim hdc As Long
        hdc = CanvasOpenHDC(canvasID)
        CanvasBlt2 = BitBlt(destPicHdc, _
                           destX, _
                           destY, _
                           width, _
                           height, _
                           hdc, _
                           sourceX, sourceY, _
                           SRCCOPY)
        Call CanvasCloseHDC(canvasID, hdc)
    Else
        CanvasBlt2 = -1
    End If
End Function

'=========================================================================
' Transparently render a canvas onto a picture box
'=========================================================================
Public Function CanvasTransBlt(ByVal canvasID As Long, ByVal destX As Long, ByVal destY As Long, ByVal destPicHdc As Long, ByVal crTranscolor As Long) As Long
    On Error Resume Next
    If CanvasOccupied(canvasID) Then
        Dim cHdc As Long, W As Long, h As Long
        W = GetCanvasWidth(canvasID)
        h = GetCanvasHeight(canvasID)
        cHdc = CanvasOpenHDC(canvasID)
        CanvasTransBlt = GFXBitBltTransparent(destPicHdc, destX, destY, W, h, cHdc, 0, 0, red(crTranscolor), green(crTranscolor), blue(crTranscolor))
        Call CanvasCloseHDC(canvasID, cHdc)
    Else
        CanvasTransBlt = -1
    End If
End Function

'=========================================================================
' Reder a canvas (resized) onto a picture box
'=========================================================================
Public Function CanvasStretchBlt(ByVal canvasID As Long, ByVal newWidth As Long, ByVal newHeight As Long, ByVal destX As Long, ByVal destY As Long, ByVal destPicHdc As Long) As Long
    On Error Resume Next
    If CanvasOccupied(canvasID) Then
        Dim hdc As Long
        hdc = CanvasOpenHDC(canvasID)
        CanvasStretchBlt = StretchBlt(destPicHdc, _
                                     destX, destY, _
                                     newWidth, newHeight, _
                                     hdc, _
                                     0, 0, _
                                     GetCanvasWidth(canvasID), GetCanvasHeight(canvasID), _
                                     SRCCOPY)
        Call CanvasCloseHDC(canvasID, hdc)
    Else
        CanvasStretchBlt = -1
    End If
End Function

'=========================================================================
' Get height of a canavs
'=========================================================================
Public Function GetCanvasHeight(ByVal canvasID As Long) As Long
    On Error Resume Next
    If CanvasOccupied(canvasID) Then
        GetCanvasHeight = CNVGetHeight(canvasID)
    End If
End Function

'=========================================================================
' Render a canvas onto a picture box
'=========================================================================
Public Function CanvasBlt(ByVal canvasID As Long, ByVal destX As Long, ByVal destY As Long, ByVal destPicHdc As Long) As Long
    On Error Resume Next
    If CanvasOccupied(canvasID) Then
        Dim hdc As Long
        hdc = CanvasOpenHDC(canvasID)
        CanvasBlt = BitBlt(destPicHdc, _
                           destX, _
                           destY, _
                           GetCanvasWidth(canvasID), _
                           GetCanvasHeight(canvasID), _
                           hdc, 0, 0, SRCCOPY)
        Call CanvasCloseHDC(canvasID, hdc)
    Else
        CanvasBlt = -1
    End If
End Function

'=========================================================================
' Get a canvas' HDC
'=========================================================================
Public Function CanvasOpenHDC(ByVal canvasID As Long) As Long
    On Error Resume Next
    If CanvasOccupied(canvasID) Then
        CanvasOpenHDC = CNVOpenHDC(canvasID)
    Else
        CanvasOpenHDC = -1
    End If
End Function

'=========================================================================
' Lock a canavs (disable rendering, but draw fast)
'=========================================================================
Public Function CanvasLock(ByVal canvasID As Long) As Long
    On Error Resume Next
    If CanvasOccupied(canvasID) Then
        CanvasLock = CNVLock(canvasID)
    Else
        CanvasLock = -1
    End If
End Function

'=========================================================================
' Unlock a canvas (enables rendering, but is slower)
'=========================================================================
Public Function CanvasUnlock(ByVal canvasID As Long) As Long
    On Error Resume Next
    If CanvasOccupied(canvasID) Then
        CanvasUnlock = CNVUnlock(canvasID)
    Else
        CanvasUnlock = -1
    End If
End Function

'=========================================================================
' Close a canvas' HDC (saving the changes)
'=========================================================================
Public Function CanvasCloseHDC(ByVal canvasID As Long, ByVal hdc As Long) As Long
    On Error Resume Next
    If CanvasOccupied(canvasID) Then
        CanvasCloseHDC = CNVCloseHDC(canvasID, hdc)
    Else
        CanvasCloseHDC = -1
    End If
End Function

'=========================================================================
' Get width of a canvas
'=========================================================================
Function GetCanvasWidth(ByVal canvasID As Long) As Long
    On Error Resume Next
    If CanvasOccupied(canvasID) Then
        GetCanvasWidth = CNVGetWidth(canvasID)
    End If
End Function

'=========================================================================
' Shut down the canvas engine
'=========================================================================
Public Sub CloseCanvasEngine()

    On Error Resume Next

    'Kill the canvas host (new sub by KSNiloc!)
    Call CNVKillCanvasHost(App.hInstance, canvasHost)

    'Shutdown the canvas engine
    Call CNVShutdown

    'Shutdown the FreeImage library
    Call CloseImage

End Sub

'=========================================================================
' Create a canvas
'=========================================================================
Public Function CreateCanvas(ByVal width As Long, ByVal height As Long, Optional ByVal bUseDX As Boolean = True) As Long
    On Error Resume Next
    If width <> 0 And height <> 0 Then
        CreateCanvas = CNVCreate(canvasHost, width, height, 1)
    Else
        CreateCanvas = -1
    End If
End Function

'=========================================================================
' Destroy a canvas
'=========================================================================
Public Sub DestroyCanvas(ByVal canvasID As Long)
    On Error Resume Next
    If CanvasOccupied(canvasID) Then
        Call CNVDestroy(canvasID)
    End If
End Sub

'=========================================================================
' Initiate the canvas engine
'=========================================================================
Public Sub initCanvasEngine()

    On Error Resume Next

    'Create an hdc for the canvases to be based upon (new function by KSNiloc!)
    canvasHost = CNVCreateCanvasHost(App.hInstance)

    'Check if we were successful
    If (canvasHost = 0) Then
        Call MsgBox("Failed to initiate the canvas engine! " & _
                    "Make sure you are using the latest actkrt3.dll file! " & _
                    "(September 8th, 2004)")
        'We can't proceed without the canvasHost, so just end
        End
    End If

    'Init the canvas engine
    Call CNVInit

    'Init the FreeImage library
    Call InitImage

End Sub

'=========================================================================
' Resize a canvas
'=========================================================================
Public Sub SetCanvasSize(ByVal canvasID As Long, ByVal newWidth As Long, ByVal newHeight As Long)
    On Error Resume Next
    If CanvasOccupied(canvasID) Then
        Call CNVResize(canvasID, canvasHost, newWidth, newHeight)
    End If
End Sub

'=========================================================================
' Draw an image onto a canvas
'=========================================================================
Public Sub drawImageCNV( _
                           ByVal fileName As String, _
                           ByVal x As Long, _
                           ByVal y As Long, _
                           ByVal cnv As Long _
                                               )

    On Error Resume Next

    'Get the canvas' HDC
    Dim hdc As Long
    hdc = CanvasOpenHDC(cnv)

    'Draw the image onto the canvas
    Call drawImage(fileName, x, y, hdc)

    'Close the canvas' HDC
    Call CanvasCloseHDC(cnv, hdc)

End Sub

'=========================================================================
' Determine if a canvas exists
'=========================================================================
Public Property Get CanvasOccupied(ByVal handle As Long) As Boolean
    On Error Resume Next
    If Not (CNVExists(handle) = 0) Then
        CanvasOccupied = True
    End If
    #If isToolkit = 0 Then
        Call processEvent
    #Else
        DoEvents
    #End If
End Property

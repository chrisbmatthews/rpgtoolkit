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
' Declarations
'=========================================================================
Private Declare Function IMGBlt Lib "actkrt3.dll" (ByVal nFreeImagePtr As Long, ByVal x As Long, ByVal y As Long, ByVal hdc As Long) As Long
Private Declare Function IMGGetWidth Lib "actkrt3.dll" (ByVal nFreeImagePtr As Long) As Long
Private Declare Function IMGGetHeight Lib "actkrt3.dll" (ByVal nFreeImagePtr As Long) As Long
Private Declare Function IMGLoad Lib "actkrt3.dll" (ByVal filename As String) As Long
Private Declare Function IMGFree Lib "actkrt3.dll" (ByVal nFreeImagePtr As Long) As Long
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
Private Declare Function CNVBltPartCanvas Lib "actkrt3.dll" (ByVal sourceHandle As Long, ByVal targetHandle As Long, ByVal x As Long, ByVal y As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal nWidth As Long, ByVal nHeight As Long, Optional ByVal rasterOp As Long = SRCCOPY) As Long
Private Declare Function CNVBltTransparentPartCanvas Lib "actkrt3.dll" (ByVal sourceHandle As Long, ByVal targetHandle As Long, ByVal x As Long, ByVal y As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal nWidth As Long, ByVal nHeight As Long, Optional ByVal crColor As Long) As Long
Private Declare Function CNVCreateCanvasHost Lib "actkrt3.dll" (ByVal hInstance As Long) As Long
Private Declare Function CNVBltCanvasTranslucentPart Lib "actkrt3.dll" (ByVal cnvSource As Long, ByVal cnvTarget As Long, ByVal x As Long, ByVal y As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal width As Long, ByVal height As Long, ByVal dIntensity As Double, ByVal crUnaffectedColor As Long, ByVal crTransparentColor As Long) As Long
Private Declare Sub CNVKillCanvasHost Lib "actkrt3.dll" (ByVal hInstance As Long, ByVal hCanvasHostDC As Long)

'=========================================================================
' Member variables
'=========================================================================
Private canvasHost As Long      ' This variable contains a handle to a device
                                ' context (created in initCanvasEngine) which
                                ' all other canvas' dc's are based upon.

'=========================================================================
' Draw a background onto a canvas
'=========================================================================
Public Sub canvasDrawBackground(ByVal canvasID As Long, ByVal bkgFile As String, ByVal x As Long, ByVal y As Long, ByVal width As Long, ByVal height As Long)
    On Error Resume Next
    If canvasOccupied(canvasID) Then
        Dim bkg As TKBackground
        Call openBackground(bkgFile, bkg)
        Dim hdc As Long
        hdc = canvasOpenHDC(canvasID)
        Call DrawBackground(bkg, x, y, width, height, hdc)
        Call canvasCloseHDC(canvasID, hdc)
    End If
End Sub

'=========================================================================
' Blt a canvas onto a picture box (SRCAND)
'=========================================================================
Public Function canvasBltAnd(ByVal canvasID As Long, ByVal destX As Long, ByVal destY As Long, ByVal destPicHdc As Long) As Long
    On Error Resume Next
    If canvasOccupied(canvasID) Then
        Dim hdc As Long
        hdc = canvasOpenHDC(canvasID)
        canvasBltAnd = BitBlt(destPicHdc, _
                           destX, _
                           destY, _
                           getCanvasWidth(canvasID), _
                           getCanvasHeight(canvasID), _
                           hdc, 0, 0, SRCAND)
        Call canvasCloseHDC(canvasID, hdc)
    Else
        canvasBltAnd = -1
    End If
End Function

'=========================================================================
' Copy one canvas to another
'=========================================================================
Public Function canvas2CanvasBlt(ByVal canvasSource As Long, ByVal canvasDest As Long, ByVal destX As Long, ByVal destY As Long, Optional ByVal rasterOp As Long = SRCCOPY) As Long
    On Error Resume Next
    If canvasOccupied(canvasSource) And canvasOccupied(canvasDest) Then
        canvas2CanvasBlt = CNVBltCanvas(canvasSource, canvasDest, destX, destY, rasterOp)
    Else
        canvas2CanvasBlt = -1
    End If
End Function

'=========================================================================
' Draw a hand on a canvas
'=========================================================================
#If isToolkit = 0 Then
Public Sub canvasDrawHand(ByVal canvasID As Long, ByVal pointx As Long, ByVal pointy As Long)
    On Error Resume Next
    If canvasOccupied(canvasID) Then
        Dim cnv As Long, hdc As Long
        cnv = createCanvas(32, 32)
        hdc = canvasOpenHDC(cnv)
        Call BitBlt(hdc, 0, 0, 32, 32, handHDC, 0, 0, SRCCOPY)
        Call canvasCloseHDC(cnv, hdc)
        Call canvas2CanvasBltTransparent(cnv, canvasID, pointx - 32, pointy - 10, RGB(255, 0, 0))
        Call destroyCanvas(cnv)
    End If
End Sub
#End If

'=========================================================================
' Draw text onto a canvas
'=========================================================================
Public Sub canvasDrawText(ByVal canvasID As Long, ByVal Text As String, ByVal font As String, ByVal size As Long, ByVal x As Double, ByVal y As Double, ByVal crColor As Long, Optional ByVal Bold As Boolean = False, Optional ByVal Italics As Boolean = False, Optional ByVal Underline As Boolean = False, Optional ByVal centred As Boolean = False, Optional ByVal outlined As Boolean = False)
    On Error Resume Next
    If canvasOccupied(canvasID) Then
        Dim hdc As Long
        hdc = canvasOpenHDC(canvasID)
        Call drawGDIText(Text, x, y, crColor, size, size, font, Bold, Italics, Underline, hdc, centred, outlined)
        Call canvasCloseHDC(canvasID, hdc)
    End If
End Sub

'=========================================================================
' Partially blt one canvas to another, using translucency
'=========================================================================
Public Function canvas2canvasBltTranslucentPartial(ByVal cnvSource As Long, ByVal cnvTarget As Long, ByVal x As Long, ByVal y As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal width As Long, ByVal height As Long, ByVal dIntensity As Double, ByVal crUnaffectedColor As Long, ByVal crTransparentColor As Long) As Long

    ' If both canvases exist
    If ((canvasOccupied(cnvSource)) And (canvasOccupied(cnvTarget))) Then

        ' Execute the blt
        canvas2canvasBltTranslucentPartial = CNVBltCanvasTranslucentPart( _
            cnvSource, cnvTarget, _
            x, y, xSrc, ySrc, _
            width, height, _
            dIntensity, crUnaffectedColor, crTransparentColor _
        )

    End If

End Function

'=========================================================================
' Copy the screen onto a canvas
'=========================================================================
Public Function canvasGetScreen(ByVal canvasID As Long) As Long
    On Error Resume Next
    If canvasOccupied(canvasID) Then
#If (isToolkit = 0) Then
        canvasGetScreen = DXCopyScreenToCanvas(canvasID)
#End If
    Else
        canvasGetScreen = -1
    End If
End Function

'=========================================================================
' Partially copy one canvas onto another one
'=========================================================================
Public Function canvas2CanvasBltPartial(ByVal canvasSource As Long, ByVal canvasDest As Long, ByVal destX As Long, ByVal destY As Long, ByVal srcX As Long, ByVal srcY As Long, ByVal width As Long, ByVal height As Long, Optional ByVal rasterOp As Long = SRCCOPY) As Long
    On Error Resume Next
    If canvasOccupied(canvasSource) And canvasOccupied(canvasDest) Then
        canvas2CanvasBltPartial = CNVBltPartCanvas(canvasSource, canvasDest, destX, destY, srcX, srcY, width, height, rasterOp)
    Else
        canvas2CanvasBltPartial = -1
    End If
End Function

'=========================================================================
' Transparently copy part of a canvas onto another one
'=========================================================================
Public Function canvas2CanvasBltTransparentPartial(ByVal canvasSource As Long, ByVal canvasDest As Long, ByVal destX As Long, ByVal destY As Long, ByVal srcX As Long, ByVal srcY As Long, ByVal width As Long, ByVal height As Long, Optional ByVal crColor As Long) As Long
    On Error Resume Next
    If canvasOccupied(canvasSource) And canvasOccupied(canvasDest) Then
        canvas2CanvasBltTransparentPartial = CNVBltTransparentPartCanvas(canvasSource, canvasDest, destX, destY, srcX, srcY, width, height, crColor)
    Else
        canvas2CanvasBltTransparentPartial = -1
    End If
End Function

'=========================================================================
' Transparently copy a canvas to another one
'=========================================================================
Public Function canvas2CanvasBltTransparent(ByVal canvasSource As Long, ByVal canvasDest As Long, ByVal destX As Long, ByVal destY As Long, Optional ByVal crColor As Long) As Long
    On Error Resume Next
    If canvasOccupied(canvasSource) And canvasOccupied(canvasDest) Then
        canvas2CanvasBltTransparent = CNVBltCanvasTransparent(canvasSource, canvasDest, destX, destY, crColor)
    Else
        canvas2CanvasBltTransparent = -1
    End If
End Function

'=========================================================================
' Translucently copy a canvas to another one
'=========================================================================
Public Function canvas2CanvasBltTranslucent(ByVal canvasSource As Long, ByVal canvasDest As Long, ByVal destX As Long, ByVal destY As Long, Optional ByVal dIntensity As Double = 0.5, Optional ByVal crUnaffectedColor As Long = -1, Optional ByVal crTransparentColor As Long = -1) As Long
    On Error Resume Next
    If canvasOccupied(canvasSource) And canvasOccupied(canvasDest) Then
        Call CNVBltCanvasTranslucent(canvasSource, canvasDest, destX, destY, dIntensity, crUnaffectedColor, crTransparentColor)
    Else
        canvas2CanvasBltTranslucent = -1
    End If
End Function

'=========================================================================
' Draw a box on a canvas
'=========================================================================
Public Sub canvasBox(ByVal canvasID As Long, ByVal x1 As Long, ByVal y1 As Long, ByVal x2 As Long, ByVal y2 As Long, ByVal crColor As Long)
    On Error Resume Next
    If canvasOccupied(canvasID) Then
        Dim rgn As Long, brush As Long, hdc As Long
        rgn = CreateRectRgn(x1, y1, x2 + 1, y2 + 1)
        brush = CreateSolidBrush(crColor)
        hdc = canvasOpenHDC(canvasID)
        Call FrameRgn(hdc, rgn, brush, 1, 1)
        Call canvasCloseHDC(canvasID, hdc)
        Call DeleteObject(rgn)
        Call DeleteObject(brush)
    End If
End Sub

'=========================================================================
' Draw a filled ellipse on a canvas
'=========================================================================
Public Sub canvasDrawFilledEllipse(ByVal canvasID As Long, ByVal x1 As Long, ByVal y1 As Long, ByVal x2 As Long, ByVal y2 As Long, ByVal crColor As Long)
    On Error Resume Next
    Dim hdc As Long, pen As Long, l As Long, brush As Long, m As Long
    hdc = canvasOpenHDC(canvasID)
    pen = CreatePen(0, 1, crColor)
    l = SelectObject(hdc, pen)
    brush = CreateSolidBrush(crColor)
    m = SelectObject(hdc, brush)
    Call Ellipse(hdc, x1, y1, x2, y2)
    Call SelectObject(hdc, m)
    Call SelectObject(hdc, l)
    Call DeleteObject(brush)
    Call DeleteObject(pen)
    Call canvasCloseHDC(canvasID, hdc)
End Sub

'=========================================================================
' Draw an ellipse on a canvas
'=========================================================================
Public Sub canvasDrawEllipse(ByVal canvasID As Long, ByVal x1 As Long, ByVal y1 As Long, ByVal x2 As Long, ByVal y2 As Long, ByVal crColor As Long)
    On Error Resume Next
    If canvasOccupied(canvasID) Then
        Dim rgn As Long, brush As Long, hdc As Long
        rgn = CreateEllipticRgn(x1, y1, x2 + 1, y2 + 1)
        brush = CreateSolidBrush(crColor)
        hdc = canvasOpenHDC(canvasID)
        Call FrameRgn(hdc, rgn, brush, 1, 1)
        Call canvasCloseHDC(canvasID, hdc)
        Call DeleteObject(rgn)
        Call DeleteObject(brush)
    End If
End Sub

'=========================================================================
' Stretch a mask over a canvas
' Called by drawSizedImage [tbm only], drawSizedImageCNV [tbm only]
'           drawSizedTileBitmap
'=========================================================================
Public Function canvasMaskBltStretch(ByVal canvasIDSource As Long, ByVal canvasIDMask As Long, ByVal destX As Long, ByVal destY As Long, ByVal newWidth As Long, ByVal newHeight As Long, ByVal destPicHdc As Long) As Long
    On Error Resume Next
    If canvasOccupied(canvasIDSource) Then
        Dim w As Long, h As Long, hdcMask As Long, hdcSource As Long
        w = getCanvasWidth(canvasIDSource)
        h = getCanvasHeight(canvasIDSource)
        hdcMask = canvasOpenHDC(canvasIDMask)
        hdcSource = canvasOpenHDC(canvasIDSource)
        canvasMaskBltStretch = StretchBlt(destPicHdc, _
                           destX, _
                           destY, _
                           newWidth, _
                           newHeight, _
                           hdcMask, _
                           0, 0, _
                           w, _
                           h, _
                           SRCAND)
        canvasMaskBltStretch = StretchBlt(destPicHdc, _
                           destX, _
                           destY, _
                           newWidth, _
                           newHeight, _
                           hdcSource, _
                           0, 0, _
                           w, _
                           h, _
                           SRCPAINT)
        Call canvasCloseHDC(canvasIDMask, hdcMask)
        Call canvasCloseHDC(canvasIDSource, hdcSource)
    Else
        canvasMaskBltStretch = -1
    End If
End Function

'=========================================================================
' Transparently stretch a mask over a canvas
' Called by RenderAnimationFrame only.
'=========================================================================
Public Function canvasMaskBltStretchTransparent(ByVal cnvSource As Long, _
                                                ByVal cnvMask As Long, _
                                                ByVal destX As Long, _
                                                ByVal destY As Long, _
                                                ByVal newWidth As Long, _
                                                ByVal newHeight As Long, _
                                                ByVal cnvTarget As Long, _
                                                ByVal crTranspColor As Long) As Long
    
    On Error Resume Next
    
    If canvasOccupied(cnvSource) Then
    
        Dim w As Long, h As Long, hdcMask As Long, hdcSource As Long
        Dim hdcInt As Long, cnvInt As Long
        
        w = getCanvasWidth(cnvSource)
        h = getCanvasHeight(cnvSource)
        
        'Create an intermediate canvas.
        cnvInt = createCanvas(newWidth, newHeight)
        Call canvasFill(cnvInt, crTranspColor)
        
        hdcInt = canvasOpenHDC(cnvInt)
        
        'Stretch the mask onto the intermediate canvas.
        hdcMask = canvasOpenHDC(cnvMask)
        canvasMaskBltStretchTransparent = StretchBlt(hdcInt, _
                           0, 0, _
                           newWidth, _
                           newHeight, _
                           hdcMask, _
                           0, 0, _
                           w, h, _
                           SRCAND)
        Call canvasCloseHDC(cnvMask, hdcMask)
                           
        'Stretch the image onto the intermediate canvas.
        hdcSource = canvasOpenHDC(cnvSource)
        canvasMaskBltStretchTransparent = StretchBlt(hdcInt, _
                           0, 0, _
                           newWidth, _
                           newHeight, _
                           hdcSource, _
                           0, 0, _
                           w, h, _
                           SRCPAINT)
        Call canvasCloseHDC(cnvSource, hdcSource)
        
        Call canvasCloseHDC(cnvInt, hdcInt)
        
        'Blt the intermediate canvas to the target canvas.
        Call canvas2CanvasBltTransparent(cnvInt, cnvTarget, destX, destY, crTranspColor)
        
        'Destroy the intermediate canvas.
        Call destroyCanvas(cnvInt)
        
    Else
        canvasMaskBltStretchTransparent = -1
    End If
    
End Function

'=========================================================================
' Draw a line on a canvas
'=========================================================================
Public Sub canvasDrawLine(ByVal canvasID As Long, ByVal x1 As Long, ByVal y1 As Long, ByVal x2 As Long, ByVal y2 As Long, ByVal crColor As Long)
    On Error Resume Next
    If canvasOccupied(canvasID) Then
        Dim hdc As Long, brush As Long, point As POINTAPI, m As Long
        hdc = canvasOpenHDC(canvasID)
        brush = CreatePen(0, 1, crColor)
        m = SelectObject(hdc, brush)
        Call MoveToEx(hdc, x1, y1, point)
        Call LineTo(hdc, x2, y2)
        Call SelectObject(hdc, m)
        Call DeleteObject(brush)
        Call canvasCloseHDC(canvasID, hdc)
    End If
End Sub

'=========================================================================
' Load a picture onto a canvas and resize *the canvas*
'=========================================================================
Public Sub canvasLoadFullPicture(ByVal canvasID As Long, ByVal file As String, ByVal minX As Long, ByVal minY As Long)
    
    On Error Resume Next
    Dim hdc As Long, img As Long, sizex As Long, sizey As Long
    
    If canvasOccupied(canvasID) And fileExists(file) Then
        'If canvas and file exist.
        
        img = IMGLoad(file)
        If (img) Then
        
            sizex = IMGGetWidth(img)
            sizey = IMGGetHeight(img)
            
            'Size the canvas.
            If minX = -1 Then
                'Set it to the size of image.
                Call setCanvasSize(canvasID, sizex, sizey)
            Else
                'Size a larger canvas if one is requested.
                If sizex < minX Then sizex = minX
                If sizey < minY Then sizey = minY
                Call setCanvasSize(canvasID, sizex, sizey)
            End If
            
            'Blt the image to the canvas.
            hdc = canvasOpenHDC(canvasID)
            Call IMGBlt(img, 0, 0, hdc)
            Call canvasCloseHDC(canvasID, hdc)
            
            'Unload the IMG.
            Call IMGFree(img)
        End If
    End If
End Sub

'=========================================================================
' Fill a box on a canvas
'=========================================================================
Public Sub canvasFillBox(ByVal canvasID As Long, ByVal x1 As Long, ByVal y1 As Long, ByVal x2 As Long, ByVal y2 As Long, ByVal crColor As Long)
    On Error Resume Next
    If canvasOccupied(canvasID) Then
        Dim hdc As Long, pen As Long, l As Long, brush As Long, m As Long
        hdc = canvasOpenHDC(canvasID)
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
        Call canvasCloseHDC(canvasID, hdc)
    End If
End Sub

'=========================================================================
' Blt a mask over a canvas
'=========================================================================
Public Function canvasMaskBlt(ByVal canvasIDSource As Long, ByVal canvasIDMask As Long, ByVal destX As Long, ByVal destY As Long, ByVal destPicHdc As Long) As Long
    On Error Resume Next
    If canvasOccupied(canvasIDSource) Then
        Dim hdcMask As Long, hdcSource As Long
        hdcMask = canvasOpenHDC(canvasIDMask)
        hdcSource = canvasOpenHDC(canvasIDSource)
        canvasMaskBlt = BitBlt(destPicHdc, _
                           destX, _
                           destY, _
                           getCanvasWidth(canvasIDMask), _
                           getCanvasHeight(canvasIDMask), _
                           hdcMask, 0, 0, SRCAND)
        canvasMaskBlt = BitBlt(destPicHdc, _
                           destX, _
                           destY, _
                           getCanvasWidth(canvasIDSource), _
                           getCanvasHeight(canvasIDSource), _
                           hdcSource, 0, 0, SRCPAINT)
        Call canvasCloseHDC(canvasIDMask, hdcMask)
        Call canvasCloseHDC(canvasIDSource, hdcSource)
    Else
        canvasMaskBlt = -1
    End If
End Function

'=========================================================================
' Fill a canvas with a color
'=========================================================================
Public Sub canvasFill(ByVal canvasID As Long, ByVal crColor As Long)
    On Error Resume Next
    Call canvasFillBox(canvasID, 0, 0, getCanvasWidth(canvasID), getCanvasHeight(canvasID), crColor)
End Sub

'=========================================================================
' Get a pixel on a canvas
'=========================================================================
Public Function canvasGetPixel(ByVal canvasID As Long, ByVal x As Long, ByVal y As Long) As Long
    On Error Resume Next
    If canvasOccupied(canvasID) Then
        canvasGetPixel = CNVGetPixel(canvasID, x, y)
    Else
        canvasGetPixel = -1
    End If
End Function

'=========================================================================
' Load a picture onto a canvas
'=========================================================================
Public Function canvasLoadPicture(ByVal canvasID As Long, ByVal filename As String) As Long
    On Error Resume Next
    If canvasOccupied(canvasID) And fileExists(filename) Then
        Call drawImageCNV(filename, 0, 0, canvasID)
        canvasLoadPicture = 0
    Else
        canvasLoadPicture = -1
    End If
End Function

'=========================================================================
' Load a picture onto a canvas and resize *the picture*
'=========================================================================
Public Sub canvasLoadSizedPicture(ByVal canvasID As Long, ByVal file As String)
    On Error Resume Next
    If canvasOccupied(canvasID) And fileExists(file) Then
        Dim hdc As Long
        hdc = canvasOpenHDC(canvasID)
        Call DrawSizedImage(file, 0, 0, getCanvasWidth(canvasID), getCanvasHeight(canvasID), hdc)
        Call canvasCloseHDC(canvasID, hdc)
    End If
End Sub

'=========================================================================
' Set a pixel on a canvas
'=========================================================================
Public Function canvasSetPixel(ByVal canvasID As Long, ByVal x As Long, ByVal y As Long, ByVal crColor As Long) As Long
    On Error Resume Next
    If canvasOccupied(canvasID) Then
        canvasSetPixel = CNVSetPixel(canvasID, x, y, crColor)
    Else
        canvasSetPixel = -1
    End If
End Function

'=========================================================================
' Transparently blt a picture box into a canvas
' Not called in trans3 or toolkit3.
'=========================================================================
Public Function canvasTransBltInto(ByVal canvasID As Long, ByVal canvasDestX As Long, ByVal canvasDestY As Long, ByVal newWidth As Long, ByVal newHeight As Long, ByVal sourceX As Long, ByVal sourceY As Long, ByVal sourceWidth As Long, ByVal sourceHeight As Long, ByVal sourceHDC As Long, ByVal crTranscolor As Long) As Long
    On Error Resume Next
    If canvasOccupied(canvasID) Then
        Dim cHdc As Long
        cHdc = canvasOpenHDC(canvasID)
        canvasTransBltInto = GFXBitBltTransparent(cHdc, _
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
        Call canvasCloseHDC(canvasID, cHdc)
    Else
        canvasTransBltInto = -1
    End If
End Function

'=========================================================================
' Blt a resized picture box into a canvas
' Not called in trans3 or toolkit3.
'=========================================================================
Public Function canvasStretchBltInto(ByVal canvasID As Long, ByVal canvasDestX As Long, ByVal canvasDestY As Long, ByVal newWidth As Long, ByVal newHeight As Long, ByVal sourceX As Long, ByVal sourceY As Long, ByVal sourceWidth As Long, ByVal sourceHeight As Long, ByVal sourceHDC As Long) As Long
    On Error Resume Next
    If canvasOccupied(canvasID) Then
        Dim hdc As Long
        hdc = canvasOpenHDC(canvasID)
        canvasStretchBltInto = StretchBlt(hdc, _
                                     canvasDestX, canvasDestY, _
                                     newWidth, newHeight, _
                                     sourceHDC, _
                                     sourceX, sourceY, _
                                     sourceWidth, sourceHeight, _
                                     SRCCOPY)
        Call canvasCloseHDC(canvasID, hdc)
    Else
        canvasStretchBltInto = -1
    End If
End Function

'=========================================================================
' Blt a picture box into a canvas
' Not called in trans3 or toolkit3.
'=========================================================================
Public Function canvasBltInto(ByVal canvasID As Long, ByVal canvasDestX As Long, ByVal canvasDestY As Long, ByVal sourceX As Long, ByVal sourceY As Long, ByVal sourceWidth As Long, ByVal sourceHeight As Long, ByVal sourceHDC As Long) As Long
    On Error Resume Next
    If canvasOccupied(canvasID) Then
        Dim hdc As Long
        hdc = canvasOpenHDC(canvasID)
        canvasBltInto = BitBlt(hdc, _
                           canvasDestX, _
                           canvasDestY, _
                           sourceWidth, _
                           sourceHeight, _
                           sourceHDC, _
                           sourceX, sourceY, _
                           SRCCOPY)
        Call canvasCloseHDC(canvasID, hdc)
    Else
        canvasBltInto = -1
    End If
End Function

'=========================================================================
' Blt a canvas onto a picture box transparently
' Not called in trans3 or toolkit3.
'=========================================================================
Public Function canvasTransBlt2(ByVal canvasID As Long, ByVal newWidth As Long, ByVal newHeight As Long, ByVal destX As Long, ByVal destY As Long, ByVal sourceX As Long, ByVal sourceY As Long, ByVal sourceWidth As Long, ByVal sourceHeight As Long, ByVal destPicHdc As Long, ByVal crTranscolor As Long) As Long
    On Error Resume Next
    If canvasOccupied(canvasID) Then
        Dim cHdc As Long
        cHdc = canvasOpenHDC(canvasID)
        canvasTransBlt2 = GFXBitBltTransparent(destPicHdc, destX, destY, newWidth, newHeight, cHdc, sourceX, sourceY, red(crTranscolor), green(crTranscolor), blue(crTranscolor))
        Call canvasCloseHDC(canvasID, cHdc)
    Else
        canvasTransBlt2 = -1
    End If
End Function

'=========================================================================
' Blt a canvas (resized) onto a picture box
' Not called in trans3 or toolkit3.
'=========================================================================
Public Function canvasStretchBlt2(ByVal canvasID As Long, ByVal newWidth As Long, ByVal newHeight As Long, ByVal destX As Long, ByVal destY As Long, ByVal sourceX As Long, ByVal sourceY As Long, ByVal sourceWidth As Long, ByVal sourceHeight As Long, ByVal destPicHdc As Long) As Long
    On Error Resume Next
    If canvasOccupied(canvasID) Then
        Dim hdc As Long
        hdc = canvasOpenHDC(canvasID)
        canvasStretchBlt2 = StretchBlt(destPicHdc, _
                                     destX, destY, _
                                     newWidth, newHeight, _
                                     hdc, _
                                     sourceX, sourceY, _
                                     sourceWidth, sourceHeight, _
                                     SRCCOPY)
        Call canvasCloseHDC(canvasID, hdc)
    Else
        canvasStretchBlt2 = -1
    End If
End Function

'=========================================================================
' Blt a canvas onto a picture box
' Not called in trans3 or toolkit3.
'=========================================================================
Public Function canvasBlt2(ByVal canvasID As Long, ByVal destX As Long, ByVal destY As Long, ByVal sourceX As Long, ByVal sourceY As Long, ByVal width As Long, ByVal height As Long, ByVal destPicHdc As Long) As Long
    On Error Resume Next
    If canvasOccupied(canvasID) Then
        Dim hdc As Long
        hdc = canvasOpenHDC(canvasID)
        canvasBlt2 = BitBlt(destPicHdc, _
                           destX, _
                           destY, _
                           width, _
                           height, _
                           hdc, _
                           sourceX, sourceY, _
                           SRCCOPY)
        Call canvasCloseHDC(canvasID, hdc)
    Else
        canvasBlt2 = -1
    End If
End Function

'=========================================================================
' Transparently render a canvas onto a picture box
' Not called in trans3 or toolkit3.
'=========================================================================
Public Function canvasTransBlt(ByVal canvasID As Long, ByVal destX As Long, ByVal destY As Long, ByVal destPicHdc As Long, ByVal crTranscolor As Long) As Long
    On Error Resume Next
    If canvasOccupied(canvasID) Then
        Dim cHdc As Long, w As Long, h As Long
        w = getCanvasWidth(canvasID)
        h = getCanvasHeight(canvasID)
        cHdc = canvasOpenHDC(canvasID)
        canvasTransBlt = GFXBitBltTransparent(destPicHdc, destX, destY, w, h, cHdc, 0, 0, red(crTranscolor), green(crTranscolor), blue(crTranscolor))
        Call canvasCloseHDC(canvasID, cHdc)
    Else
        canvasTransBlt = -1
    End If
End Function

'=========================================================================
' Reder a canvas (resized) onto a picture box
' Called by DrawCanvasRPG, DrawCanvasTransparentRPG.
'=========================================================================
Public Function canvasStretchBlt(ByVal canvasID As Long, ByVal newWidth As Long, ByVal newHeight As Long, ByVal destX As Long, ByVal destY As Long, ByVal destPicHdc As Long) As Long
    On Error Resume Next
    If canvasOccupied(canvasID) Then
        Dim hdc As Long
        hdc = canvasOpenHDC(canvasID)
        canvasStretchBlt = StretchBlt(destPicHdc, _
                                     destX, destY, _
                                     newWidth, newHeight, _
                                     hdc, _
                                     0, 0, _
                                     getCanvasWidth(canvasID), getCanvasHeight(canvasID), _
                                     SRCCOPY)
        Call canvasCloseHDC(canvasID, hdc)
    Else
        canvasStretchBlt = -1
    End If
End Function

'=========================================================================
' Get height of a canavs
'=========================================================================
Public Function getCanvasHeight(ByVal canvasID As Long) As Long
    On Error Resume Next
    If canvasOccupied(canvasID) Then
        getCanvasHeight = CNVGetHeight(canvasID)
    End If
End Function

'=========================================================================
' Render a canvas onto a picture box
'=========================================================================
Public Function canvasBlt(ByVal canvasID As Long, ByVal destX As Long, ByVal destY As Long, ByVal destPicHdc As Long) As Long
    On Error Resume Next
    If canvasOccupied(canvasID) Then
        Dim hdc As Long
        hdc = canvasOpenHDC(canvasID)
        canvasBlt = BitBlt(destPicHdc, _
                           destX, _
                           destY, _
                           getCanvasWidth(canvasID), _
                           getCanvasHeight(canvasID), _
                           hdc, 0, 0, SRCCOPY)
        Call canvasCloseHDC(canvasID, hdc)
    Else
        canvasBlt = -1
    End If
End Function

'=========================================================================
' Get a canvas' HDC
'=========================================================================
Public Function canvasOpenHDC(ByVal canvasID As Long) As Long
    On Error Resume Next
    If canvasOccupied(canvasID) Then
        canvasOpenHDC = CNVOpenHDC(canvasID)
    Else
        canvasOpenHDC = -1
    End If
End Function

'=========================================================================
' Lock a canavs (disable rendering, but draw fast)
'=========================================================================
Public Function canvasLock(ByVal canvasID As Long) As Long
    On Error Resume Next
    If canvasOccupied(canvasID) Then
        canvasLock = CNVLock(canvasID)
    Else
        canvasLock = -1
    End If
End Function

'=========================================================================
' Unlock a canvas (enables rendering, but is slower)
'=========================================================================
Public Function canvasUnlock(ByVal canvasID As Long) As Long
    On Error Resume Next
    If canvasOccupied(canvasID) Then
        canvasUnlock = CNVUnlock(canvasID)
    Else
        canvasUnlock = -1
    End If
End Function

'=========================================================================
' Close a canvas' HDC (saving the changes)
'=========================================================================
Public Function canvasCloseHDC(ByVal canvasID As Long, ByVal hdc As Long) As Long
    On Error Resume Next
    If canvasOccupied(canvasID) Then
        canvasCloseHDC = CNVCloseHDC(canvasID, hdc)
    Else
        canvasCloseHDC = -1
    End If
End Function

'=========================================================================
' Get width of a canvas
'=========================================================================
Function getCanvasWidth(ByVal canvasID As Long) As Long
    On Error Resume Next
    If canvasOccupied(canvasID) Then
        getCanvasWidth = CNVGetWidth(canvasID)
    End If
End Function

'=========================================================================
' Shut down the canvas engine
'=========================================================================
Public Sub closeCanvasEngine()

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
Public Function createCanvas(ByVal width As Long, ByVal height As Long, Optional ByVal bUseDX As Boolean = True) As Long
    On Error Resume Next
    If ((width <> 0) And (height <> 0)) Then
        createCanvas = CNVCreate(canvasHost, width, height, 1)
    Else
        createCanvas = -1
    End If
End Function

'=========================================================================
' Destroy a canvas
'=========================================================================
Public Sub destroyCanvas(ByVal canvasID As Long)
    On Error Resume Next
    If canvasOccupied(canvasID) Then
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
Public Sub setCanvasSize(ByVal canvasID As Long, ByVal newWidth As Long, ByVal newHeight As Long)
    On Error Resume Next
    If canvasOccupied(canvasID) Then
        Call CNVResize(canvasID, canvasHost, newWidth, newHeight)
    End If
End Sub

'=========================================================================
' Determine if a canvas exists
'=========================================================================
Public Property Get canvasOccupied(ByVal handle As Long) As Boolean
    canvasOccupied = (CNVExists(handle))
End Property

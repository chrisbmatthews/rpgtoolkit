Attribute VB_Name = "CommonCanvas"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'toolkit graphics engine
'DEPENDS: CommonImage => FreeImage library
' CommonVB6Compat.bas
' CommonTkCanvas.bas
Option Explicit

Sub CanvasDrawBackground(ByVal canvasID As Long, ByVal bkgFile As String, ByVal X As Long, ByVal Y As Long, ByVal Width As Long, ByVal height As Long)
    'load background, sized
    On Error Resume Next
    If CanvasOccupied(canvasID) Then
        Dim bkg As TKBackground
        Call openBackground(bkgFile, bkg)
        Dim hdc As Long
        hdc = CanvasOpenHDC(canvasID)
        Call DrawBackground(bkg, X, Y, Width, height, hdc)
        Call CanvasCloseHDC(canvasID, hdc)
    End If
End Sub

Function CanvasBltAnd(ByVal canvasID As Long, ByVal destX As Long, ByVal destY As Long, ByVal destPicHdc As Long) As Long
    'blt the contents of a canvas onto a picturebox (SRCAND)
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

Function Canvas2CanvasBlt(ByVal canvasSource As Long, ByVal canvasDest As Long, ByVal destX As Long, ByVal destY As Long, Optional ByVal rasterOp As Long = SRCCOPY) As Long
    'blt the contents of a canvas onto another canvas
    On Error Resume Next
    If CanvasOccupied(canvasSource) And CanvasOccupied(canvasDest) Then
        Canvas2CanvasBlt = CNVBltCanvas(canvasSource, canvasDest, destX, destY, rasterOp)
    Else
        Canvas2CanvasBlt = -1
    End If
End Function

Sub CanvasDrawHand(ByVal canvasID As Long, ByVal pointx As Long, ByVal pointy As Long)
    'draw a hand cursor pointing to ointx, pointy
    On Error Resume Next
    If CanvasOccupied(canvasID) Then
        Dim c As Long
        c = CreateCanvas(32, 32)
        
        'get hand graphoc...
        Dim hdc2 As Long
        hdc2 = CanvasOpenHDC(c)
        Call BitBlt(hdc2, 0, 0, 32, 32, vbPicHDC(canvas_host.hand), 0, 0, SRCCOPY)
        Call CanvasCloseHDC(c, hdc2)
        
        'now copy it...
        Call Canvas2CanvasBltTransparent(c, canvasID, pointx - 32, pointy - 10, RGB(255, 0, 0))
               
        Call DestroyCanvas(c)
    End If
End Sub

Sub CanvasDrawText(ByVal canvasID As Long, ByVal Text As String, ByVal font As String, ByVal size As Long, ByVal X As Double, ByVal Y As Double, ByVal crColor As Long, Optional ByVal Bold As Boolean = False, Optional ByVal Italics As Boolean = False, Optional ByVal Underline As Boolean = False, Optional ByVal centred As Boolean = False, Optional ByVal outlined As Boolean = False)
    'draw text to a canvas...
    On Error Resume Next
    
    If CanvasOccupied(canvasID) Then
        Dim hdc As Long
        hdc = CanvasOpenHDC(canvasID)
                
        Call drawGDIText(Text, X, Y, crColor, size, size, font, Bold, Italics, Underline, hdc, centred, outlined)
                
        Call CanvasCloseHDC(canvasID, hdc)
    End If
    
End Sub

Function CanvasGetScreen(ByVal canvasID As Long) As Long
    'copy screen into canvas
    On Error Resume Next
    If CanvasOccupied(canvasID) Then
        CanvasGetScreen = DXCopyScreenToCanvas(canvasID)
    Else
        CanvasGetScreen = -1
    End If
End Function

Function Canvas2CanvasBltPartial(ByVal canvasSource As Long, ByVal canvasDest As Long, ByVal destX As Long, ByVal destY As Long, ByVal srcX As Long, ByVal srcY As Long, ByVal Width As Long, ByVal height As Long, Optional ByVal rasterOp As Long = SRCCOPY) As Long
    'blt the contents of a canvas onto another canvas
    On Error Resume Next
    If CanvasOccupied(canvasSource) And CanvasOccupied(canvasDest) Then
        Canvas2CanvasBltPartial = CNVBltPartCanvas(canvasSource, canvasDest, destX, destY, srcX, srcY, Width, height, rasterOp)
    Else
        Canvas2CanvasBltPartial = -1
    End If
End Function

Function Canvas2CanvasBltTransparentPartial(ByVal canvasSource As Long, ByVal canvasDest As Long, ByVal destX As Long, ByVal destY As Long, ByVal srcX As Long, ByVal srcY As Long, ByVal Width As Long, ByVal height As Long, Optional ByVal crColor As Long) As Long
    'blt the contents of a canvas onto another canvas
    On Error Resume Next
    If CanvasOccupied(canvasSource) And CanvasOccupied(canvasDest) Then
        Canvas2CanvasBltTransparentPartial = CNVBltTransparentPartCanvas(canvasSource, canvasDest, destX, destY, srcX, srcY, Width, height, crColor)
    Else
        Canvas2CanvasBltTransparentPartial = -1
    End If
End Function

Function Canvas2CanvasBltTransparent(ByVal canvasSource As Long, ByVal canvasDest As Long, ByVal destX As Long, ByVal destY As Long, Optional ByVal crColor As Long) As Long
    'blt the contents of a canvas onto another canvas
    On Error Resume Next
    If CanvasOccupied(canvasSource) And CanvasOccupied(canvasDest) Then
        Canvas2CanvasBltTransparent = CNVBltCanvasTransparent(canvasSource, canvasDest, destX, destY, crColor)
    Else
        Canvas2CanvasBltTransparent = -1
    End If
End Function

Function Canvas2CanvasBltTranslucent(ByVal canvasSource As Long, ByVal canvasDest As Long, ByVal destX As Long, ByVal destY As Long, Optional ByVal dIntensity As Double = 0.5, Optional ByVal crUnaffectedColor As Long = -1, Optional ByVal crTransparentColor As Long = -1) As Long
    'blt the contents of a canvas onto another canvas
    On Error Resume Next
    If CanvasOccupied(canvasSource) And CanvasOccupied(canvasDest) Then
        Call CNVBltCanvasTranslucent(canvasSource, canvasDest, destX, destY, dIntensity, crUnaffectedColor, crTransparentColor)
        Canvas2CanvasBltTranslucent = DXDrawCanvasTranslucent(canvasSource, _
         destX, destY, dIntensity, crUnaffectedColor, crTransparentColor)
    Else
        Canvas2CanvasBltTranslucent = -1
    End If
End Function

Sub CanvasSetPicture(ByVal canvasID As Long, picclp As PictureClip)
    'set the pixxlp picture into the canvas...
    On Error Resume Next
End Sub

Sub CanvasBox(ByVal canvasID As Long, ByVal x1 As Long, ByVal y1 As Long, ByVal x2 As Long, ByVal y2 As Long, ByVal crColor As Long)
    'fill a box on the canvas with a color.
    On Error Resume Next
    If CanvasOccupied(canvasID) Then
    Dim rgn As Long, brush As Long, hdc As Long, a As Long
        rgn = CreateRectRgn(x1, y1, x2 + 1, y2 + 1)
        brush = CreateSolidBrush(crColor)
        
        hdc = CanvasOpenHDC(canvasID)
        a = FrameRgn(hdc, rgn, brush, 1, 1)
        Call CanvasCloseHDC(canvasID, hdc)
        
        Call DeleteObject(rgn)
        Call DeleteObject(brush)
    End If
End Sub

Sub CanvasDrawFilledEllipse(ByVal canvasID As Long, ByVal x1 As Long, ByVal y1 As Long, ByVal x2 As Long, ByVal y2 As Long, ByVal crColor As Long)
    'draw an ellipse inside the rectangle defined.
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

Sub CanvasDrawEllipse(ByVal canvasID As Long, ByVal x1 As Long, ByVal y1 As Long, ByVal x2 As Long, ByVal y2 As Long, ByVal crColor As Long)
    'draw an ellipse inside the rectangle defined.
    On Error Resume Next
    If CanvasOccupied(canvasID) Then
        Dim rgn As Long, brush As Long, hdc As Long, a As Long
        rgn = CreateEllipticRgn(x1, y1, x2 + 1, y2 + 1)
        brush = CreateSolidBrush(crColor)
        hdc = CanvasOpenHDC(canvasID)
        a = FrameRgn(hdc, rgn, brush, 1, 1)
        Call CanvasCloseHDC(canvasID, hdc)
        Call DeleteObject(rgn)
        Call DeleteObject(brush)
    End If
End Sub

Function CanvasMaskBltStretch(ByVal canvasIDSource As Long, ByVal canvasIDMask As Long, ByVal destX As Long, ByVal destY As Long, ByVal newWidth As Long, ByVal newHeight As Long, ByVal destPicHdc As Long) As Long
    'blt the contents of a canvas onto a picturebox (SRCCOPY)
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

Sub CanvasDrawLine(ByVal canvasID As Long, ByVal x1 As Long, ByVal y1 As Long, ByVal x2 As Long, ByVal y2 As Long, ByVal crColor As Long)
    'fill a box on the canvas with a color.
    On Error Resume Next
    
    If CanvasOccupied(canvasID) Then
        Dim hdc As Long, brush As Long, m As Long
        hdc = CanvasOpenHDC(canvasID)
        Dim point As POINTAPI
        brush = CreatePen(0, 1, crColor)
        m = SelectObject(hdc, brush)
        Call MoveToEx(hdc, x1, y1, point)
        Call LineTo(hdc, x2, y2)
        Call SelectObject(hdc, m)
        Call DeleteObject(brush)
        Call CanvasCloseHDC(canvasID, hdc)
    End If
End Sub

Sub CanvasLoadFullPicture(ByVal canvasID As Long, ByVal file As String, ByVal minX As Long, ByVal minY As Long)
    'load a picture, resize the canvas to fit the picture
    'minX and minY are the MINIMUM dimensions to use.
    'if both are set to -1, then it will just resize regardless.
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

Sub CanvasFillBox(ByVal canvasID As Long, ByVal x1 As Long, ByVal y1 As Long, ByVal x2 As Long, ByVal y2 As Long, ByVal crColor As Long)
    'fill a box on the canvas with a color.
    On Error Resume Next
    If CanvasOccupied(canvasID) Then
        Dim hdc As Long, pen As Long, l As Long, brush As Long, m As Long
        hdc = CanvasOpenHDC(canvasID)
        pen = CreatePen(0, 1, crColor)
        l = SelectObject(hdc, pen)
        brush = CreateSolidBrush(crColor)
        m = SelectObject(hdc, brush)
        
        Dim r As RECT
        r.Bottom = y2 + 1
        r.Right = x2 + 1
        r.Left = x1
        r.Top = y1
        Call FillRect(hdc, r, brush)
        
        Call SelectObject(hdc, m)
        Call SelectObject(hdc, l)
        Call DeleteObject(brush)
        Call DeleteObject(pen)
        
        Call CanvasCloseHDC(canvasID, hdc)
    End If
End Sub

Function CanvasMaskBlt(ByVal canvasIDSource As Long, ByVal canvasIDMask As Long, ByVal destX As Long, ByVal destY As Long, ByVal destPicHdc As Long) As Long
    'blt the contents of a canvas onto a picturebox (SRCCOPY)
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

Sub CanvasFill(ByVal canvasID As Long, ByVal crColor As Long)
    'fill the cavas with a color.
    On Error Resume Next
    
    Call CanvasFillBox(canvasID, 0, 0, GetCanvasWidth(canvasID), GetCanvasHeight(canvasID), crColor)
End Sub

Function CanvasGetPixel(ByVal canvasID As Long, ByVal X As Long, ByVal Y As Long) As Long
    'get pixel on the canvas.
    On Error Resume Next
    
    If CanvasOccupied(canvasID) Then
        CanvasGetPixel = CNVGetPixel(canvasID, X, Y)
    Else
        CanvasGetPixel = -1
    End If
End Function

Function CanvasLoadPicture(ByVal canvasID As Long, ByVal filename As String) As Long
    'load a picture
    On Error Resume Next
    If CanvasOccupied(canvasID) And fileExists(filename) Then
        'tempCanvas = CNVCreate(vbFrmHDC(canvas_host), GetCanvasWidth(canvasID), GetCanvasHeight(canvasID), 1)
        'hdc = CanvasOpenHDC(tempCanvas)
        'Call DrawImage(filename, 0, 0, hdc)
        'a = IMGDraw(filename, 0, 0, hdc)
        'Call CanvasCloseHDC(tempCanvas, hdc)
        'Call Canvas2CanvasBlt(tempCanvas, canvasID, 0, 0)
        'Call DestroyCanvas(tempCanvas)
        
        Dim hdc As Long
        Call drawImageCNV(filename, 0, 0, canvasID)
        CanvasLoadPicture = 0
    Else
        CanvasLoadPicture = -1
    End If
End Function

Sub CanvasLoadSizedPicture(ByVal canvasID As Long, ByVal file As String)
    'load a sized picture (fit into canvas)
    On Error Resume Next
    If CanvasOccupied(canvasID) And fileExists(file) Then
        Dim hdc As Long
        hdc = CanvasOpenHDC(canvasID)
        Call DrawSizedImage(file, 0, 0, GetCanvasWidth(canvasID), GetCanvasHeight(canvasID), hdc)
        Call CanvasCloseHDC(canvasID, hdc)
    End If
End Sub

Sub CanvasRefresh(ByVal canvasID As Long)
    'refresh canvas
    On Error Resume Next
    'If CANVAS_USE_GDI = 0 Then
    '    If CanvasOccupied(canvasID) Then
    '        'hostForms(canvasID).Line (0, 0)-(100, 100), RGB(255, 0, 0)
    '        Call vbFrmRefresh(hostForms(canvasID))
    '    End If
    'End If
End Sub

Function CanvasSetPixel(ByVal canvasID As Long, ByVal X As Long, ByVal Y As Long, ByVal crColor As Long) As Long
    'set pixel into the canvas.
    On Error Resume Next
    If CanvasOccupied(canvasID) Then
        'CanvasSetPixel = SetPixelV(CanvasHDC(canvasID), x, y, crColor)
        CanvasSetPixel = CNVSetPixel(canvasID, X, Y, crColor)
    Else
        CanvasSetPixel = -1
    End If
End Function

Sub CanvasShow(ByVal canvasID As Long)
    On Error Resume Next
    If CanvasOccupied(canvasID) Then
        canvas_host.Show
        canvas_host.Width = GetCanvasWidth(canvasID) * Screen.TwipsPerPixelX
        canvas_host.height = GetCanvasHeight(canvasID) * Screen.TwipsPerPixelY
        Call vbFrmAutoRedraw(canvas_host, False)
        canvas_host.Top = 0
        canvas_host.Left = 0
        Call CanvasBlt(canvasID, 0, 0, vbFrmHDC(canvas_host))
    End If
End Sub

Function CanvasTransBltInto(ByVal canvasID As Long, ByVal canvasDestX As Long, ByVal canvasDestY As Long, ByVal newWidth As Long, ByVal newHeight As Long, ByVal sourceX As Long, ByVal sourceY As Long, ByVal sourceWidth As Long, ByVal sourceHeight As Long, ByVal sourceHDC As Long, ByVal crTranscolor As Long) As Long
    'blt a picture into the canvas...
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

Function CanvasStretchBltInto(ByVal canvasID As Long, ByVal canvasDestX As Long, ByVal canvasDestY As Long, ByVal newWidth As Long, ByVal newHeight As Long, ByVal sourceX As Long, ByVal sourceY As Long, ByVal sourceWidth As Long, ByVal sourceHeight As Long, ByVal sourceHDC As Long) As Long
    'blt a picture into the canvas...
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

Function CanvasBltInto(ByVal canvasID As Long, ByVal canvasDestX As Long, ByVal canvasDestY As Long, ByVal sourceX As Long, ByVal sourceY As Long, ByVal sourceWidth As Long, ByVal sourceHeight As Long, ByVal sourceHDC As Long) As Long
    'blt a picture into the canvas...
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


Function CanvasTransBlt2(ByVal canvasID As Long, ByVal newWidth As Long, ByVal newHeight As Long, ByVal destX As Long, ByVal destY As Long, ByVal sourceX As Long, ByVal sourceY As Long, ByVal sourceWidth As Long, ByVal sourceHeight As Long, ByVal destPicHdc As Long, ByVal crTranscolor As Long) As Long
    'blt the contents of a canvas onto a picturebox using transparency
    On Error Resume Next
    If CanvasOccupied(canvasID) Then
        Dim cHdc As Long
        cHdc = CanvasOpenHDC(canvasID)
        'CanvasTransBlt2 = TransparentBlt(destPicHdc, _
                                        destX, destY, _
                                        newWidth, newHeight, _
                                        chdc, _
                                        sourceX, sourceY, _
                                        sourceWidth, sourceHeight, _
                                        crTranscolor)
        'If CanvasTransBlt = 0 Then
            CanvasTransBlt2 = GFXBitBltTransparent(destPicHdc, destX, destY, newWidth, newHeight, cHdc, sourceX, sourceY, red(crTranscolor), green(crTranscolor), blue(crTranscolor))
        'End If
        Call CanvasCloseHDC(canvasID, cHdc)
    Else
        CanvasTransBlt2 = -1
    End If
End Function

Function CanvasStretchBlt2(ByVal canvasID As Long, ByVal newWidth As Long, ByVal newHeight As Long, ByVal destX As Long, ByVal destY As Long, ByVal sourceX As Long, ByVal sourceY As Long, ByVal sourceWidth As Long, ByVal sourceHeight As Long, ByVal destPicHdc As Long) As Long
    'blt the contents of a canvas onto a picturebox (SRCCOPY)
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

Function CanvasBlt2(ByVal canvasID As Long, ByVal destX As Long, ByVal destY As Long, ByVal sourceX As Long, ByVal sourceY As Long, ByVal Width As Long, ByVal height As Long, ByVal destPicHdc As Long) As Long
    'blt the contents of a canvas onto a picturebox (SRCCOPY)
    On Error Resume Next
    
    If CanvasOccupied(canvasID) Then
        Dim hdc As Long
        hdc = CanvasOpenHDC(canvasID)
        CanvasBlt2 = BitBlt(destPicHdc, _
                           destX, _
                           destY, _
                           Width, _
                           height, _
                           hdc, _
                           sourceX, sourceY, _
                           SRCCOPY)
        Call CanvasCloseHDC(canvasID, hdc)
    Else
        CanvasBlt2 = -1
    End If
End Function

Function CanvasTransBlt(ByVal canvasID As Long, ByVal destX As Long, ByVal destY As Long, ByVal destPicHdc As Long, ByVal crTranscolor As Long) As Long
    'blt the contents of a canvas onto a picturebox using transparency
    On Error Resume Next
    If CanvasOccupied(canvasID) Then
        Dim cHdc As Long, W As Long, h As Long
        W = GetCanvasWidth(canvasID)
        h = GetCanvasHeight(canvasID)
        cHdc = CanvasOpenHDC(canvasID)
        'If CanvasTransBlt = 0 Then
            CanvasTransBlt = GFXBitBltTransparent(destPicHdc, destX, destY, W, h, cHdc, 0, 0, red(crTranscolor), green(crTranscolor), blue(crTranscolor))
        'End If
        Call CanvasCloseHDC(canvasID, cHdc)
    Else
        CanvasTransBlt = -1
    End If
End Function

Function CanvasStretchBlt(ByVal canvasID As Long, ByVal newWidth As Long, ByVal newHeight As Long, ByVal destX As Long, ByVal destY As Long, ByVal destPicHdc As Long) As Long
    'blt the contents of a canvas onto a picturebox (SRCCOPY)
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

Function GetCanvas(canvasID As Long) As Form
    'obtain the canvas object
    On Error Resume Next
    
End Function

Function GetCanvasHeight(ByVal canvasID As Long) As Long
    'obtain canvas heigth, in pixels
    On Error Resume Next
    
    If CanvasOccupied(canvasID) Then
        GetCanvasHeight = CNVGetHeight(canvasID)
    End If
End Function

Function CanvasBlt(ByVal canvasID As Long, ByVal destX As Long, ByVal destY As Long, ByVal destPicHdc As Long) As Long
    'blt the contents of a canvas onto a picturebox (SRCCOPY)
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


Function CanvasOpenHDC(ByVal canvasID As Long) As Long
    'return the hDC of a canvas
    '-1 if canvas does not exist
    On Error Resume Next
    
    If CanvasOccupied(canvasID) Then
        CanvasOpenHDC = CNVOpenHDC(canvasID)
    Else
        CanvasOpenHDC = -1
    End If
End Function

Function CanvasLock(ByVal canvasID As Long) As Long
    'lock the canvas so getting the hdc is quick
    'MUST unlock after done!
    '-1 if canvas does not exist
    On Error Resume Next
    
    If CanvasOccupied(canvasID) Then
        CanvasLock = CNVLock(canvasID)
    Else
        CanvasLock = -1
    End If
End Function


Function CanvasUnlock(ByVal canvasID As Long) As Long
    'unlock the canvas so getting the hdc is quick
    'MUST unlock after done!
    '-1 if canvas does not exist
    On Error Resume Next
    
    If CanvasOccupied(canvasID) Then
        CanvasUnlock = CNVUnlock(canvasID)
    Else
        CanvasUnlock = -1
    End If
End Function

Function CanvasCloseHDC(ByVal canvasID As Long, ByVal hdc As Long) As Long
    'return the hDC of a canvas
    '-1 if canvas does not exist
    On Error Resume Next
    
    If CanvasOccupied(canvasID) Then
        CanvasCloseHDC = CNVCloseHDC(canvasID, hdc)
    Else
        CanvasCloseHDC = -1
    End If
End Function

Function GetCanvasWidth(ByVal canvasID As Long) As Long
    'obtain canvas width, in pixels
    On Error Resume Next
    
    If CanvasOccupied(canvasID) Then
        GetCanvasWidth = CNVGetWidth(canvasID)
    End If
End Function

Sub CloseCanvasEngine()
    'destroy graphics engine
    On Error Resume Next
    
    Call CNVShutdown
    
    'close freeimage lib
    Call CloseImage
End Sub

Function CreateCanvas(ByVal Width As Long, ByVal height As Long, Optional ByVal bUseDX As Boolean = True) As Long
    'create a new off-screen canvas.
    'width, height- specify size, in pixels.
    'returns the ID of the off-screen canvas
    'or -1 if it cannot create it.
    On Error Resume Next

    'Added by KSNiloc...
    bUseDX = True
    
    Dim dx As Long
    If bUseDX Then
        dx = 1
    Else
        dx = 0
    End If
    
    If Width <> 0 And height <> 0 Then
        CreateCanvas = CNVCreate(vbFrmHDC(canvas_host), Width, height, dx)
    Else
        CreateCanvas = -1
    End If
End Function

Sub DestroyCanvas(ByVal canvasID As Long)
    'destroy a canvas...
    On Error Resume Next
    
    If CanvasOccupied(canvasID) Then
        Call CNVDestroy(canvasID)
    End If
End Sub

Sub InitCanvasEngine(Optional ByVal bUseGdi As Boolean = False)
    'init graphics engine
    'specify if we should use pure gdi routines
    '(not everything is implemented with pure gdi)
    
    On Error Resume Next
    
    Call CNVInit
            
    'init freeimage library
    Call InitImage
End Sub

Sub SetCanvasSize(ByVal canvasID As Long, ByVal newWidth As Long, ByVal newHeight As Long)
    'resize the canvas.
    On Error Resume Next
    
    If CanvasOccupied(canvasID) Then
        Call CNVResize(canvasID, vbFrmHDC(canvas_host), newWidth, newHeight)
    End If
End Sub

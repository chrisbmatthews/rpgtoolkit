Attribute VB_Name = "CommonImage"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'image loading functions
'depends on freeimage.dll
'depends on canvas_host.frm (depends on picclip)
'depends on image_host.frm

Option Explicit

Declare Function IMGInit Lib "actkrt3.dll" () As Long
Declare Function IMGClose Lib "actkrt3.dll" () As Long
Declare Function IMGDraw Lib "actkrt3.dll" (ByVal filename As String, ByVal x As Long, ByVal y As Long, ByVal hdc As Long) As Long
Declare Function IMGDrawSized Lib "actkrt3.dll" (ByVal filename As String, ByVal x As Long, ByVal y As Long, ByVal sizex As Long, ByVal sizey As Long, ByVal hdc As Long) As Long
Declare Function IMGLoad Lib "actkrt3.dll" (ByVal filename As String) As Long
Declare Function IMGFree Lib "actkrt3.dll" (ByVal nFreeImagePtr As Long) As Long
Declare Function IMGGetWidth Lib "actkrt3.dll" (ByVal nFreeImagePtr As Long) As Long
Declare Function IMGGetHeight Lib "actkrt3.dll" (ByVal nFreeImagePtr As Long) As Long
Declare Function IMGGetDIB Lib "actkrt3.dll" (ByVal nFreeImagePtr As Long) As Long
Declare Function IMGGetBitmapInfo Lib "actkrt3.dll" (ByVal nFreeImagePtr As Long) As Long
Declare Function IMGBlt Lib "actkrt3.dll" (ByVal nFreeImagePtr As Long, ByVal x As Long, ByVal y As Long, ByVal hdc As Long) As Long
Declare Function IMGStretchBlt Lib "actkrt3.dll" (ByVal nFreeImagePtr As Long, ByVal x As Long, ByVal y As Long, ByVal sizex As Long, ByVal sizey As Long, ByVal hdc As Long) As Long

Public bImageLibraryLoaded As Boolean

Public Const strFileDialogFilterGfx = "Supported Files|*.tbm;*.bmp;*.ico;*.jpg;*.jpeg;*.gif;*.koa;*.koala;*.lbm;*.mng;*.jng;*.png;*.pcd;*.pcx;*.ppm;*.pgm;*.pbm;*.ras;*.tga;*.tif;*.tiff;*.wbmp;*.wap;*.wmf|Tile Bitmap (*.tbm)|*.tbm|Windows Bitmap (*.bmp)|*.bmp|GIF Compressed (*.gif)|*.gif|JPEG Compressed (*.jpg)|*.jpg;*.jpeg|PNG Portable Network Graphics (*.png)|*.png|MNG Multi Network Graphics (*.mng, *.jng)|*.mng;*.jng|PCX Bitmap (*.pcx)|*.pcx|TIFF Bitmap (*.tif)|*.tif;*.tiff|Kodak Photo CD (*.pcd)|*.pcd|PNM Bitmap (*.ppm, *.pgm, *.pbm)|*.ppm;*.pgm;*.pbm|Sun Raster (*.ras)|*.ras|TARGA (*.tga)|*.tga|WBitmap (*.wbmp)|*.wbmp;*.wap|Deluxe Paint (*.lbm)|*.lbm|Commodore 64 KOALA (*.koa)|*.koa;*.koala|Windows Icon (*.ico)|*.ico|Windows MetaFile (*.wmf)|*.wmf|All files(*.*)|*.*"
Public Const strFileDialogFilterWithTiles = "Supported Files|*.tst;*.tbm;*.gph;*.bmp;*.ico;*.jpg;*.jpeg;*.gif;*.koa;*.koala;*.lbm;*.mng;*.jng;*.png;*.pcd;*.pcx;*.ppm;*.pgm;*.pbm;*.ras;*.tga;*.tif;*.tiff;*.wbmp;*.wap;*.wmf|Tile Bitmap(*.tbm)|*.tbm|RPG Toolkit Tileset (*.tst)|*.tst|RPG Toolkit GPH (*.gph)|*.gph|Windows Bitmap (*.bmp)|*.bmp|GIF Compressed (*.gif)|*.gif|JPEG Compressed (*.jpg)|*.jpg;*.jpeg|PNG Portable Network Graphics (*.png)|*.png|MNG Multi Network Graphics (*.mng, *.jng)|*.mng;*.jng|PCX Bitmap (*.pcx)|*.pcx|TIFF Bitmap (*.tif)|*.tif;*.tiff|Kodak Photo CD (*.pcd)|*.pcd|PNM Bitmap (*.ppm, *.pgm, *.pbm)|*.ppm;*.pgm;*.pbm|Sun Raster (*.ras)|*.ras|TARGA (*.tga)|*.tga|WBitmap (*.wbmp)|*.wbmp;*.wap|Deluxe Paint (*.lbm)|*.lbm|Commodore 64 KOALA (*.koa)|*.koa;*.koala|Windows Icon (*.ico)|*.ico|Windows MetaFile (*.wmf)|*.wmf|All files(*.*)|*.*"

Public Sub DrawSizedImage(ByVal filename As String, ByVal x As Long, ByVal y As Long, ByVal sizex As Long, ByVal sizey As Long, ByVal hdc As Long)
    'load and draw an image
    On Error Resume Next
    
    If screenWidth = 0 Then screenWidth = 4000 * Screen.TwipsPerPixelX
    If screenHeight = 0 Then screenHeight = 4000 * Screen.TwipsPerPixelY
    
    Dim ext As String
    Dim frm As New canvas_host
    Dim imgfrm As New image_host
    Dim a As Long

    ext = UCase(GetExt(filename))
    'If ext = "JPG" Or ext = "JPEG" Or ext = "BMP" Or ext = "GIF" Then
    If ext = "GIF" Then
        'use internal routines if we can...
        Call vbFrmAutoRedraw(frm, True)
        With imgfrm.PicClip
            .Picture = LoadPicture(filename)
            'check if it's too big...
            If .Width * Screen.TwipsPerPixelX > screenWidth Or _
                .height * Screen.TwipsPerPixelY > screenHeight And ext <> "GIF" Then
                Call IMGDrawSized(filename, x, y, sizex, sizey, hdc)
            Else
                .ClipX = 0
                .ClipY = 0
                .ClipHeight = imgfrm.PicClip.height
                .ClipWidth = imgfrm.PicClip.Width
                .StretchX = sizex
                .StretchY = sizey
                With frm
                    .Width = sizex * Screen.TwipsPerPixelX
                    .height = sizey * Screen.TwipsPerPixelY
                    .BackColor = 0
                End With
                Set frm.Picture = .Clip
                Call BitBlt(hdc, x, y, sizex, sizey, vbFrmHDC(frm), 0, 0, SRCCOPY)
            End If
        End With
        Unload frm
        Set frm = Nothing
        Unload imgfrm
        Set imgfrm = Nothing
    Else
        If ext = "TBM" Then
            'also draws tilebitmaps!
            Dim tbm As TKTileBitmap
            Call OpenTileBitmap(filename, tbm)
            
            Dim cnv As Long, cnvHdc As Long
            Dim cnvMask As Long, cnvmaskHdc As Long
            Dim ww As Long
            
            cnv = CreateCanvas(tbm.sizex * 32, tbm.sizey * 32)
            cnvMask = CreateCanvas(tbm.sizex * 32, tbm.sizey * 32)
            
            Call DrawTileBitmapCNV(cnv, cnvMask, 0, 0, tbm)
            
            ww = GetCanvasWidth(cnv)
            Call CanvasMaskBltStretch(cnv, cnvMask, x, y, sizex, sizey, hdc)
            Call DestroyCanvas(cnv)
            Call DestroyCanvas(cnvMask)
        Else
            a = IMGDrawSized(filename, x, y, sizex, sizey, hdc)
            If a = 0 Then
                'problem loading the image-- try using loadpicture...
                Call vbFrmAutoRedraw(frm, True)
                With imgfrm.PicClip
                    .Picture = LoadPicture(filename)
                    .ClipX = 0
                    .ClipY = 0
                    .ClipHeight = imgfrm.PicClip.height
                    .ClipWidth = imgfrm.PicClip.Width
                    .StretchX = sizex
                    .StretchY = sizey
                End With
                With frm
                    .Width = sizex * Screen.TwipsPerPixelX
                    .height = sizey * Screen.TwipsPerPixelY
                    .BackColor = 0
                End With
                Set frm.Picture = imgfrm.PicClip.Clip
                Call BitBlt(hdc, x, y, sizex, sizey, vbFrmHDC(frm), 0, 0, SRCCOPY)
                Unload frm
                Set frm = Nothing
                Unload imgfrm
                Set imgfrm = Nothing
            End If
        End If
    End If
End Sub

Public Sub CloseImage()
    'shut down image system
    On Error Resume Next
    Call IMGClose
End Sub

Public Sub DrawImage(ByVal filename As String, ByVal x As Long, ByVal y As Long, ByVal hdc As Long)
    'load and draw an image
    On Error Resume Next
    Dim ext As String
    Dim frm As New canvas_host
    Dim imgfrm As New image_host
    Dim a As Long
    
    If screenWidth = 0 Then screenWidth = 4000 * Screen.TwipsPerPixelX
    If screenHeight = 0 Then screenHeight = 4000 * Screen.TwipsPerPixelY
    
    ext = UCase$(GetExt(filename))
    'If ext = "JPG" Or ext = "JPEG" Or ext = "BMP" Or ext = "GIF" Then
    If ext = "GIF" Then
        'use internal routines if we can...
        Call vbFrmAutoRedraw(frm, True)
        imgfrm.PicClip.Picture = LoadPicture(filename)
        'check if it's too big...
        If imgfrm.PicClip.Width * Screen.TwipsPerPixelX > screenWidth Or _
           imgfrm.PicClip.height * Screen.TwipsPerPixelY > screenHeight And ext <> "GIF" Then
            a = IMGDraw(filename, x, y, hdc)
        Else
            frm.Width = imgfrm.PicClip.Width * Screen.TwipsPerPixelX
            frm.height = imgfrm.PicClip.height * Screen.TwipsPerPixelY
            frm.BackColor = 0
            Set frm.Picture = imgfrm.PicClip.Picture
            a = BitBlt(hdc, x, y, frm.Width / Screen.TwipsPerPixelX, frm.height / Screen.TwipsPerPixelY, vbFrmHDC(frm), 0, 0, SRCCOPY)
        End If
        Unload frm
        Set frm = Nothing
        Unload imgfrm
        Set imgfrm = Nothing
    Else
        If ext = "TBM" Then
            'also draws tilebitmaps!
            Dim tbm As TKTileBitmap
            Call OpenTileBitmap(filename, tbm)
            Call DrawTileBitmap(hdc, -1, x, y, tbm)
        Else
            a = IMGDraw(filename, x, y, hdc)
            If a = 0 Then
                'problem loading the image-- try using loadpicture...
                Call vbFrmAutoRedraw(frm, True)
                imgfrm.PicClip.Picture = LoadPicture(filename)
                frm.Width = imgfrm.PicClip.Width * Screen.TwipsPerPixelX
                frm.height = imgfrm.PicClip.height * Screen.TwipsPerPixelY
                frm.BackColor = 0
                Set frm.Picture = imgfrm.PicClip.Picture
                a = BitBlt(hdc, x, y, frm.Width / Screen.TwipsPerPixelX, frm.height / Screen.TwipsPerPixelY, vbFrmHDC(frm), 0, 0, SRCCOPY)
                Unload frm
                Set frm = Nothing
                Unload imgfrm
                Set imgfrm = Nothing
            End If
        End If
    End If
End Sub

Public Sub drawImageCNV(ByVal filename As String, ByVal x As Long, ByVal y As Long, ByVal cnv As Long)
    'load and draw an image
    On Error Resume Next
    Dim ext As String
    Dim frm As New canvas_host
    Dim imgfrm As New image_host
    Dim a As Long
    Dim hdc As Long
    
    If screenWidth = 0 Then screenWidth = 4000 * Screen.TwipsPerPixelX
    If screenHeight = 0 Then screenHeight = 4000 * Screen.TwipsPerPixelY
    
    ext = UCase$(GetExt(filename))
    'If ext = "JPG" Or ext = "JPEG" Or ext = "BMP" Or ext = "GIF" Then
    If ext = "GIF" Then
        'use internal routines if we can...
        Call vbFrmAutoRedraw(frm, True)
        imgfrm.PicClip.Picture = LoadPicture(filename)
        'check if it's too big...
        If imgfrm.PicClip.Width * Screen.TwipsPerPixelX > screenWidth Or _
           imgfrm.PicClip.height * Screen.TwipsPerPixelY > screenHeight And ext <> "GIF" Then
            hdc = CanvasOpenHDC(cnv)
            a = IMGDraw(filename, x, y, hdc)
            Call CanvasCloseHDC(cnv, hdc)
        Else
            frm.Width = imgfrm.PicClip.Width * Screen.TwipsPerPixelX
            frm.height = imgfrm.PicClip.height * Screen.TwipsPerPixelY
            frm.BackColor = 0
            Set frm.Picture = imgfrm.PicClip.Picture
            hdc = CanvasOpenHDC(cnv)
            a = BitBlt(hdc, x, y, frm.Width / Screen.TwipsPerPixelX, frm.height / Screen.TwipsPerPixelY, vbFrmHDC(frm), 0, 0, SRCCOPY)
            Call CanvasCloseHDC(cnv, hdc)
        End If
        Unload frm
        Set frm = Nothing
        Unload imgfrm
        Set imgfrm = Nothing
    Else
        If ext = "TBM" Then
            'also draws tilebitmaps!
            Dim tbm As TKTileBitmap
            Call OpenTileBitmap(filename, tbm)
            Call DrawTileBitmapCNV(cnv, -1, x, y, tbm)
        Else
            hdc = CanvasOpenHDC(cnv)
            a = IMGDraw(filename, x, y, hdc)
            Call CanvasCloseHDC(cnv, hdc)
            If a = 0 Then
                'problem loading the image-- try using loadpicture...
                Call vbFrmAutoRedraw(frm, True)
                imgfrm.PicClip.Picture = LoadPicture(filename)
                frm.Width = imgfrm.PicClip.Width * Screen.TwipsPerPixelX
                frm.height = imgfrm.PicClip.height * Screen.TwipsPerPixelY
                frm.BackColor = 0
                Set frm.Picture = imgfrm.PicClip.Picture
                Call CanvasCloseHDC(cnv, hdc)
                a = BitBlt(hdc, x, y, frm.Width / Screen.TwipsPerPixelX, frm.height / Screen.TwipsPerPixelY, vbFrmHDC(frm), 0, 0, SRCCOPY)
                Call CanvasCloseHDC(cnv, hdc)
                Unload frm
                Set frm = Nothing
                Unload imgfrm
                Set imgfrm = Nothing
            End If
        End If
    End If
End Sub

Public Function InitImage() As Boolean
    'init image library
    On Error GoTo imgerror
    
    InitImage = True
    Call IMGInit
    bImageLibraryLoaded = InitImage
    
    Exit Function
imgerror:
    InitImage = False
End Function

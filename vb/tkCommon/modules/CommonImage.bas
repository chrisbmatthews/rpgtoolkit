Attribute VB_Name = "CommonImage"
'=========================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=========================================================================

'=========================================================================
' Interface with actkrt3.dll :: FreeImage (image loading)
'=========================================================================

'=========================================================================
'EDITED [KSNiloc] [Augest 31, 2004]
'----------------------------------
' + Remove dependencies on forms
' + Combined common code
' + Privatized some things
'=========================================================================

Option Explicit

'=========================================================================
' FreeImage declarations
'=========================================================================
Private Declare Function IMGInit Lib "actkrt3.dll" () As Long
Private Declare Function IMGClose Lib "actkrt3.dll" () As Long
Private Declare Function IMGDraw Lib "actkrt3.dll" (ByVal filename As String, ByVal x As Long, ByVal y As Long, ByVal hdc As Long) As Long
Private Declare Function IMGDrawSized Lib "actkrt3.dll" (ByVal filename As String, ByVal x As Long, ByVal y As Long, ByVal sizex As Long, ByVal sizey As Long, ByVal hdc As Long) As Long
Private Declare Function IMGFree Lib "actkrt3.dll" (ByVal nFreeImagePtr As Long) As Long
Private Declare Function IMGGetDIB Lib "actkrt3.dll" (ByVal nFreeImagePtr As Long) As Long
Private Declare Function IMGGetBitmapInfo Lib "actkrt3.dll" (ByVal nFreeImagePtr As Long) As Long
Private Declare Function IMGStretchBlt Lib "actkrt3.dll" (ByVal nFreeImagePtr As Long, ByVal x As Long, ByVal y As Long, ByVal sizex As Long, ByVal sizey As Long, ByVal hdc As Long) As Long

'=========================================================================
' Dialog flags
'=========================================================================
Public Const strFileDialogFilterGfx = "Supported Files|*.tbm;*.bmp;*.ico;*.jpg;*.jpeg;*.gif;*.koa;*.koala;*.lbm;*.mng;*.jng;*.png;*.pcd;*.pcx;*.ppm;*.pgm;*.pbm;*.ras;*.tga;*.tif;*.tiff;*.wbmp;*.wap;*.wmf|Tile Bitmap (*.tbm)|*.tbm|Windows Bitmap (*.bmp)|*.bmp|GIF Compressed (*.gif)|*.gif|JPEG Compressed (*.jpg)|*.jpg;*.jpeg|PNG Portable Network Graphics (*.png)|*.png|MNG Multi Network Graphics (*.mng, *.jng)|*.mng;*.jng|PCX Bitmap (*.pcx)|*.pcx|TIFF Bitmap (*.tif)|*.tif;*.tiff|Kodak Photo CD (*.pcd)|*.pcd|PNM Bitmap (*.ppm, *.pgm, *.pbm)|*.ppm;*.pgm;*.pbm|Sun Raster (*.ras)|*.ras|TARGA (*.tga)|*.tga|WBitmap (*.wbmp)|*.wbmp;*.wap|Deluxe Paint (*.lbm)|*.lbm|Commodore 64 KOALA (*.koa)|*.koa;*.koala|Windows Icon (*.ico)|*.ico|Windows MetaFile (*.wmf)|*.wmf|All files(*.*)|*.*"
Public Const strFileDialogFilterWithTiles = "Supported Files|*.tst;*.tbm;*.gph;*.bmp;*.ico;*.jpg;*.jpeg;*.gif;*.koa;*.koala;*.lbm;*.mng;*.jng;*.png;*.pcd;*.pcx;*.ppm;*.pgm;*.pbm;*.ras;*.tga;*.tif;*.tiff;*.wbmp;*.wap;*.wmf|Tile Bitmap(*.tbm)|*.tbm|RPG Toolkit Tileset (*.tst)|*.tst|RPG Toolkit GPH (*.gph)|*.gph|Windows Bitmap (*.bmp)|*.bmp|GIF Compressed (*.gif)|*.gif|JPEG Compressed (*.jpg)|*.jpg;*.jpeg|PNG Portable Network Graphics (*.png)|*.png|MNG Multi Network Graphics (*.mng, *.jng)|*.mng;*.jng|PCX Bitmap (*.pcx)|*.pcx|TIFF Bitmap (*.tif)|*.tif;*.tiff|Kodak Photo CD (*.pcd)|*.pcd|PNM Bitmap (*.ppm, *.pgm, *.pbm)|*.ppm;*.pgm;*.pbm|Sun Raster (*.ras)|*.ras|TARGA (*.tga)|*.tga|WBitmap (*.wbmp)|*.wbmp;*.wap|Deluxe Paint (*.lbm)|*.lbm|Commodore 64 KOALA (*.koa)|*.koa;*.koala|Windows Icon (*.ico)|*.ico|Windows MetaFile (*.wmf)|*.wmf|All files(*.*)|*.*"

'=========================================================================
' Draw a sized image onto an hdc
'=========================================================================
Public Sub DrawSizedImage( _
                             ByVal filename As String, _
                             ByVal x As Long, _
                             ByVal y As Long, _
                             ByVal sizex As Long, _
                             ByVal sizey As Long, _
                             ByVal hdc As Long _
                                                 )

    On Error Resume Next

    If UCase$(commonRoutines.extention(filename)) = "TBM" Then
        'Tile bitmap
        Dim tbm As TKTileBitmap
        Call OpenTileBitmap(filename, tbm)
        Dim cnv As Long
        Dim cnvMask As Long
        cnv = CreateCanvas(tbm.sizex * 32, tbm.sizey * 32)
        cnvMask = CreateCanvas(tbm.sizex * 32, tbm.sizey * 32)
        Call DrawTileBitmapCNV(cnv, cnvMask, 0, 0, tbm)
        Call CanvasMaskBltStretch(cnv, cnvMask, x, y, sizex, sizey, hdc)
        Call DestroyCanvas(cnv)
        Call DestroyCanvas(cnvMask)
    Else
        'Real image
        Call IMGDrawSized(filename, x, y, sizex, sizey, hdc)
    End If

End Sub

'=========================================================================
' Draw an image at actual size on a device context
'=========================================================================
Public Sub drawImage( _
                        ByVal filename As String, _
                        ByVal x As Long, _
                        ByVal y As Long, _
                        ByVal hdc As Long _
                                            )

    On Error Resume Next

    If UCase$(GetExt(filename)) = "TBM" Then
        'Tile bitmap
        Dim tbm As TKTileBitmap
        Call OpenTileBitmap(filename, tbm)
        Call DrawTileBitmap(hdc, -1, x, y, tbm)
    Else
        'Real image
        Call IMGDraw(filename, x, y, hdc)
    End If

End Sub

'=========================================================================
' Initiate the FreeImage library
'=========================================================================
Public Function InitImage() As Boolean
    On Error Resume Next
    InitImage = (IMGInit = 1)
End Function

'=========================================================================
' Shut down FreeImage
'=========================================================================
Public Sub CloseImage()
    On Error Resume Next
    Call IMGClose
End Sub

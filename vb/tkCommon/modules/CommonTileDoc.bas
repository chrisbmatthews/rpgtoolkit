Attribute VB_Name = "CommonTileDoc"
'=======================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=======================================================================

'===============================================
'Alterations for new isometric tilesets, .iso
'Edited by Woozy and Delano for 3.0.4
'
' Altered subs: drawTileIso
' New subs: createIsoMask, tstToIsometric
' New global variables created, tileDoc altered.
'===============================================

'definition of a tile editor document
Option Explicit

Public Type tileDoc
    tileName As String            'filename
    tileneedupdate As Boolean
    tilemode As Integer  'current drawing mode in tile editor (0-draw, 1-capture color, 2-fill)
    transparentLayer As Integer     'is layering done transparently
    angle As Integer
    lightLength As Integer   'publictile.angle of light source
    grabx1 As Integer
    graby1 As Integer
    grabx2 As Integer
    graby2 As Integer
    currentColor As Long         'currently selected tile color
    oldDetail As Integer            'detail before color conversion
    grid As Integer                 'publictile.grid on off (tile)
    
    '!NEW! More undo's
    Undotile(32, 32) As Long     'Tile undo 1 (was already here)
    Undotile1(32, 32) As Long    'Tile undo 2
    Undotile2(32, 32) As Long    'Tile undo 3
    Undotile3(32, 32) As Long    'Tile undo 4
    Undotile4(32, 32) As Long    'Tile undo 5
    Undotile5(32, 32) As Long    'Tile undo 6
    Undotile6(32, 32) As Long    'Tile undo 7
    Undotile7(32, 32) As Long    'Tile undo 8
    
    'Added for 3.0.4
    isometric As Boolean
    
    captureColor As Long         'capture color on.off
    transpcolor As Long          'transparent color in tile grabber
    getTransp As Long            'get tranp on.off (grabber)
    bAllowExtraTst As Boolean       'allow selecting one past the end in tileset editor? y/n
    changeColor As Long
    
    'data
    detail As Byte  'detail level of tile

    tilemem(64, 32) As Long         '!Alteration for .iso. Increasing tilemem to 64x32.
End Type

Public publicTile As tileDoc

Public detail As Byte  'detail level of tile

Public tilemem(64, 32) As Long  '!Aleration for .iso. Increasing tilemem to 64x32.


'=======================================
'Variables added by Woozy for 3.0.4
'!NEW! Used for some effects
Public tilepreview(32, 32) As Long

'!NEW! Used to see what current undo we're on
Public currentundo As Long

'!NEW! Used for the effects
Public SaveChanges As Boolean


'=======================================
'Variables added by Delano for 3.0.4

'Public isoTileMem(64, 32) As Long   'New isometric tile matrix. Temporary!
Global isoMaskBmp(64, 32) As Long   'Isomask loaded from Form1
Global isIsoTile As Boolean         'If tile we're working on is a new isometric.



Public Sub tileDrawIso(ByRef pic As PictureBox, ByVal xLoc As Long, ByVal yLoc As Long, Optional ByVal quality As Integer = 0)
'=====================================================================
'draw a tile isometrically
'quality 0 = low (no blending)
' 1= medium (blending on the size-up)
' 2= high (blending on the size-up and size down)
' 3= very high (blending on size up and extreme blending on size-down)
' ISODETAIL = draw new .iso tiletype. Added for 3.0.4!
'=====================================================================
'Edited Delano for 3.0.4
'Additions for the new isometric tile system.
'Placed rotation code in it's own sub.
    
'Called by: tileedit    tileredraw [isomirror]
'           boardedit   changeselectedtile [currentisotile]
'                       boardselecttile [currentisotile]
'           tilesetadd
    
    On Error Resume Next
    
    Dim xCount As Integer, yCount As Integer
    Dim x As Long, y As Long
    
    If quality = ISODETAIL Then
        'Tile doesn't need rotating or deforming. Can draw it straight off.

        'Set up the count for tilemem.
        xCount = 1: yCount = 1

        'We loop over isoMaskBmp on each pixel - if the pixel is
        'unmasked we draw the *next* entry in tilemem (NOT the corresponding
        'x, y entry!!). If the pixel is masked, we don't draw it.
        
        'The isoMaskBmp is created by the function below and loaded in tkMain Form_load so as
        'to be available to all editors.

        For x = 1 To 64
            For y = 1 To 32
                If isoMaskBmp(x, y) = RGB(0, 0, 0) Then
                    'Unmasked pixel - use the next pixel in tilemem.
                    'Set it to the (x - 1)'th and (y -1)'th pixels!!
                    Call vbPicPSet(pic, x - 1 + xLoc, y - 1 + yLoc, tilemem(xCount, yCount))

                    'Increment the tilemem entry.
                    yCount = yCount + 1
                    If yCount > 32 Then
                        xCount = xCount + 1
                        yCount = 1
                    End If

                'Else This is a masked pixel: Do nothing!
                End If
            Next y
        Next x

        Exit Sub

    End If 'quality = ISODETAIL
    
    'Else, we call tst -> iso and draw
    
    Call tstToIsometric(quality)
    
    For x = 0 To 64
        For y = 0 To 32
            If buftile(x, y) <> -1 Then
                Call vbPicPSet(pic, x + xLoc, y + yLoc, buftile(x, y))
            End If
        Next y
    Next x
    
End Sub




Function getIsoX(ByVal x As Long, ByVal y As Long) As Long
    'convert a 2d x coord to the corresponding isometric coord in a tile
    'starts from 0
    
    On Error Resume Next
    Dim toRet As Long
    toRet = 0
    
    Dim tX As Long, tY As Long, xx As Long, yy As Long
    tX = x
    tY = y
    
    xx = 62 + (tX) * 2 - (tY) * 2
    yy = (tX) + (tY)
                        
    toRet = (xx) / 2
    getIsoX = toRet
End Function


Function getIsoY(ByVal x As Long, ByVal y As Long) As Long
    'convert a 2d y coord to the corresponding isometric coord in a tile
    'starts from 0
    
    On Error Resume Next
    Dim toRet As Long, tX As Long, tY As Long, xx As Long, yy As Long
    toRet = 0
    
    tX = x
    tY = y
    
    xx = 62 + (tX) * 2 - (tY) * 2
    yy = (tX) + (tY)
                        
    toRet = yy / 2
    getIsoY = toRet
End Function


Public Sub createIsoMask(): On Error Resume Next
'================================================
'New function: Added for 3.0.4 by Delano
'Creates the isoMaskBmp mask from the rotation code.
'Called in tkMainForm Form_Load only!
'Only needs to be called once!
'================================================
    
    'First, we make tilemem a black tile:
    Dim x As Long, y As Long
    
    For x = 0 To 64
        For y = 0 To 32
            tilemem(x, y) = RGB(0, 0, 0)
            isoMaskBmp(x, y) = RGB(255, 255, 255)   'Initialize the mask.
        Next y
    Next x
    
    'Now, pass it through the tst to iso conversion - this operates on tilemem and
    'creates an isometric tile in the buffer tile.
    
    Call tstToIsometric
    
    'Now we create the mask from the tile. The tile is offset and is slightly too wide
    'so we copy in halves. And erase tilemem while we're at it.
    
    For x = 0 To 32
        For y = 0 To 32
            isoMaskBmp(x + 1, y + 1) = buftile(x, y)
            tilemem(x, y) = -1
        Next y
    Next x
    
    '2nd half. Note x-index!
    
    For x = 33 To 64
        For y = 0 To 32
            'Insert into x, not x + 1!
            isoMaskBmp(x, y + 1) = buftile(x, y)
            tilemem(x, y) = -1
        Next y
    Next x
    
End Sub

Public Sub tstToIsometric(Optional ByVal quality As Integer = 3): On Error Resume Next
'====================================================
'Takes a 32x32 tilemem, runs it through the rotation
'code and returns a 64x32 (62x32) tilemem.
'Unchanged rotation code moved from drawIsoTile.
'====================================================

    quality = 3
    ReDim isotile(128, 64) As Long
    Dim x As Long, y As Long, tX As Long, tY As Long
    Dim crColor As Long, crColor2 As Long, col As Long
    Dim r1 As Long, g1 As Long, b1 As Long
    Dim r2 As Long, g2 As Long, b2 As Long
    Dim ra As Long, ga As Long, ba As Long
    Dim tempx As Long, tempy As Long
    
    For x = 0 To 128
        For y = 0 To 64
            isotile(x, y) = -1
        Next y
    Next x
    
    'texture map into 128x64 isometric tile...
    For tX = 0 To 31 Step 1
        For tY = 0 To 31 Step 1
            crColor = tilemem(tX + 1, tY + 1)
            x = 62 + (tX) * 2 - (tY) * 2
            y = (tX) + (tY)
        
            crColor = tilemem(tX + 1, tY + 1)
            crColor2 = tilemem(tX + 2, tY + 1)
            If crColor <> -1 And crColor2 <> -1 And (quality = 1 Or quality = 2 Or quality = 3) Then
                r1 = red(crColor)
                g1 = green(crColor)
                b1 = blue(crColor)
            
                r2 = red(crColor2)
                g2 = green(crColor2)
                b2 = blue(crColor2)
                
                ra = (r2 - r1) / 4
                ga = (g2 - g1) / 4
                ba = (b2 - b1) / 4
            
                For tempx = x To x + 4
                    col = RGB(r1, g1, b1)
                    
                    isotile(tempx, y) = col
                    r1 = r1 + ra
                    g1 = g1 + ga
                    b1 = b1 + ba
                Next tempx
            Else
                For tempx = x To x + 4
                    isotile(tempx, y) = crColor
                Next tempx
            End If
        Next tY
    Next tX
    
    
    'now scale down to 64x32 tile...
    Dim c1 As Long, c2 As Long, rr As Long, gg As Long, bb As Long
    
    ReDim smalltile(64, 32) As Long
    If quality = 3 Then
        'first shrink on x...
        ReDim medTile(64, 64) As Long
        
        Dim xx As Long, yy As Long
        xx = 0: yy = 0
        For x = 0 To 128 Step 2
            For y = 0 To 64
                c1 = isotile(x, y)
                c2 = isotile(x + 1, y)
                
                If c1 <> -1 And c2 <> -1 Then
                    r1 = red(c1): g1 = green(c1): b1 = blue(c1)
                    r2 = red(c2): g2 = green(c2): b2 = blue(c2)
                    rr = (r1 + r2) / 2
                    gg = (g1 + g2) / 2
                    bb = (b1 + b2) / 2
                    medTile(xx, yy) = RGB(rr, gg, bb)
                Else
                    medTile(xx, yy) = c1
                End If
                yy = yy + 1
            Next y
            xx = xx + 1
            yy = 0
        Next x
        
        'now shrink on y...
        xx = 0: yy = 0
        For x = 0 To 64
            For y = 0 To 64 Step 2
                c1 = medTile(x, y)
                c2 = medTile(x, y + 1)
                
                If c1 <> -1 And c2 <> -1 Then
                    r1 = red(c1): g1 = green(c1): b1 = blue(c1)
                    r2 = red(c2): g2 = green(c2): b2 = blue(c2)
                    rr = (r1 + r2) / 2
                    gg = (g1 + g2) / 2
                    bb = (b1 + b2) / 2
                    smalltile(xx, yy) = RGB(rr, gg, bb)
                Else
                    smalltile(xx, yy) = c1
                End If
                yy = yy + 1
            Next y
            xx = xx + 1
            yy = 0
        Next x
    Else
        xx = 0: yy = 0
        For x = 0 To 128 Step 2
            For y = 0 To 64 Step 2
                c1 = isotile(x, y)
                c2 = isotile(x + 1, y)
                
                If c1 <> -1 And c2 <> -1 And (quality = 2) Then
                    r1 = red(c1): g1 = green(c1): b1 = blue(c1)
                    r2 = red(c2): g2 = green(c2): b2 = blue(c2)
                    rr = (r1 + r2) / 2
                    gg = (g1 + g2) / 2
                    bb = (b1 + b2) / 2
                    smalltile(xx, yy) = RGB(rr, gg, bb)
                Else
                    smalltile(xx, yy) = c1
                End If
                yy = yy + 1
            Next y
            xx = xx + 1
            yy = 0
        Next x
    End If
    
    'Store it in the buffer.
    For x = 0 To 64
        For y = 0 To 32
            buftile(x, y) = smalltile(x, y)
        Next y
    Next x

    'We now have a 63x32 isometric tile, buftile, which we can either draw or use for the
    'mask.


End Sub

Attribute VB_Name = "CommonTileDoc"
'=======================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=======================================================================

Option Explicit

#If isToolkit = 1 Then

    '========================================================================
    ' Definition of a tile editor document
    '========================================================================
    Public Type tileDoc
        tileName As String              'Filename
        tileNeedUpdate As Boolean       'Needs to be updated?
        tileMode As Integer             'Current drawing mode in tile editor
        transparentLayer As Integer     'Is layering done transparently
        angle As Integer                'The angle in the "light" form
        lightLength As Integer
        grabx1 As Integer
        graby1 As Integer
        grabx2 As Integer
        graby2 As Integer
        currentColor As Long            'Currently selected tile color
        oldDetail As Integer            'Detail before color conversion
        grid As Integer                 'Grid on/off (tile)
        undoTile() As Long              'Tile undo
        captureColor As Long            'Capture color on/off
        transpcolor As Long             'Transparent color in tile grabber
        getTransp As Long               'GetTranp on/off (grabber)
        bAllowExtraTst As Boolean       'Allow selecting one past the end in tileset editor? Y/N
        changeColor As Long             'Used for changecolor function
        detail As Byte                  'Detail level of tile
        tileMem(64, 32) As Long         'The tile
        isometric As Boolean            'Isometric?
    End Type

    Public openTileEditors() As tileedit
    Public openTileEditorDocs() As tileDoc

#Else

    Public publicTile As Object

#End If

'========================================================================
' Other variables
'========================================================================
Public tilePreview(64, 32) As Long      'Used for some effects
Public saveChanges As Boolean           'Used for the effects
Public isoMaskBmp(64, 32) As Long       'Isomask loaded from frmMain
Public xRange As Integer                '= 32 OR 64 depending on tiletype. This way we don't
                                        'need to make new tileMem.

#If isToolkit = 1 Then

    '========================================================================
    'Toolkit MDI procedures
    '========================================================================

    Public Function newTileEditIndice() As Long
        '========================================================================
        'Returns a free tile editor indice
        '========================================================================

        On Error GoTo newArray

        Dim a As Long
        For a = 0 To UBound(openTileEditors)
            If openTileEditors(a) Is Nothing Then
                'Free spot
                newTileEditIndice = a
                Exit Function
            End If
        Next a

        'If we made it here then we need to enlarge the array
        ReDim Preserve openTileEditors(UBound(openTileEditors) + 1)
        ReDim Preserve openTileEditorDocs(UBound(openTileEditors))
        newTileEditIndice = UBound(openTileEditors)

        Exit Function

newArray:
        ReDim openTileEditors(0)
        ReDim openTileEditorDocs(0)

    End Function
    
    Public Sub clearTileDoc(ByRef theTileDoc As tileDoc)

        '========================================================================
        'Clear a tile doc
        '========================================================================

        On Error Resume Next
        
        With theTileDoc
            .angle = 0
            .bAllowExtraTst = False
            .captureColor = 0
            .changeColor = 0
            .currentColor = 0
            .detail = 1
            .getTransp = 0
            .grabx1 = 0
            .grabx2 = 0
            .graby1 = 0
            .graby2 = 0
            .grid = False
            .isometric = False
            .lightLength = 0
            .oldDetail = 0
            .tileMode = 0
            .tileName = ""
            .tileNeedUpdate = False
            .transparentLayer = 0
            .transpcolor = 0
            ReDim undoTile(0)
        End With

    End Sub

    '========================================================================
    'Redraw all open tiles
    '========================================================================
    Public Sub redrawAllTiles()
        Dim a As Long, currenttile As tileedit
        Set currenttile = activeTile
        For a = 0 To UBound(openTileEditors)
            If Not openTileEditors(a) Is Nothing Then
                Set activeTile = openTileEditors(a)
                Call activeTile.tileRedraw
            End If
        Next a
        Set activeTile = currenttile
    End Sub

    '========================================================================
    'Tile memory array
    '========================================================================
    Public Property Get tileMem(ByVal x As Long, ByVal y As Long) As Long
        On Error Resume Next
        If activeTile Is Nothing Then
            Set activeTile = New tileedit
        End If
        tileMem = openTileEditorDocs(activeTile.indice).tileMem(x, y)
    End Property
    Public Property Let tileMem(ByVal x As Long, ByVal y As Long, ByVal newVal As Long)
        On Error Resume Next
        If activeTile Is Nothing Then
            Set activeTile = New tileedit
        End If
        openTileEditorDocs(activeTile.indice).tileMem(x, y) = newVal
    End Property

    '========================================================================
    'Detail variable
    '========================================================================
    Public Property Get detail() As Byte
        On Error Resume Next
        If activeTile Is Nothing Then
            Set activeTile = New tileedit
        End If
        detail = openTileEditorDocs(activeTile.indice).detail
    End Property
    Public Property Let detail(ByVal newValue As Byte)
        On Error Resume Next
        If activeTile Is Nothing Then
            Set activeTile = New tileedit
        End If
        openTileEditorDocs(activeTile.indice).detail = newValue
    End Property

#Else

    Public detail As Byte
    Public tileMem(64, 32) As Long

#End If

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
                    Call vbPicPSet(pic, x - 1 + xLoc, y - 1 + yLoc, tileMem(xCount, yCount))

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
            If bufTile(x, y) <> -1 Then
                Call vbPicPSet(pic, x + xLoc, y + yLoc, bufTile(x, y))
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

#If isToolkit = 1 Then
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
                tileMem(x, y) = RGB(0, 0, 0)
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
                isoMaskBmp(x + 1, y + 1) = bufTile(x, y)
                tileMem(x, y) = -1
            Next y
        Next x
    
        '2nd half. Note x-index!
    
        For x = 33 To 64
            For y = 0 To 32
                'Insert into x, not x + 1!
                isoMaskBmp(x, y + 1) = bufTile(x, y)
                tileMem(x, y) = -1
            Next y
        Next x
    
    End Sub
#End If

Public Sub tstToIsometric(Optional ByVal quality As Integer = 3): On Error Resume Next
'====================================================
'Takes a 32x32 tilemem, runs it through the rotation
'code and returns a 64x32 (62x32) tilemem.
'Unchanged rotation code moved from drawIsoTile.
'====================================================

    quality = 3
    ReDim IsoTile(128, 64) As Long
    Dim x As Long, y As Long, tX As Long, tY As Long
    Dim crColor As Long, crColor2 As Long, col As Long
    Dim r1 As Long, g1 As Long, b1 As Long
    Dim r2 As Long, g2 As Long, b2 As Long
    Dim ra As Long, ga As Long, ba As Long
    Dim tempx As Long, tempy As Long
    
    For x = 0 To 128
        For y = 0 To 64
            IsoTile(x, y) = -1
        Next y
    Next x
    
    'texture map into 128x64 isometric tile...
    For tX = 0 To 31 Step 1
        For tY = 0 To 31 Step 1
            crColor = tileMem(tX + 1, tY + 1)
            x = 62 + (tX) * 2 - (tY) * 2
            y = (tX) + (tY)
        
            crColor = tileMem(tX + 1, tY + 1)
            crColor2 = tileMem(tX + 2, tY + 1)
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
                    
                    IsoTile(tempx, y) = col
                    r1 = r1 + ra
                    g1 = g1 + ga
                    b1 = b1 + ba
                Next tempx
            Else
                For tempx = x To x + 4
                    IsoTile(tempx, y) = crColor
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
                c1 = IsoTile(x, y)
                c2 = IsoTile(x + 1, y)
                
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
                c1 = IsoTile(x, y)
                c2 = IsoTile(x + 1, y)
                
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
            bufTile(x, y) = smalltile(x, y)
        Next y
    Next x

    'We now have a 63x32 isometric tile, buftile, which we can either draw or use for the
    'mask.

End Sub

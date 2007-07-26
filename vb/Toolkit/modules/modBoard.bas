Attribute VB_Name = "modBoard"
'========================================================================
' The RPG Toolkit, Version 3
' This file copyright (C) 2006  Jonathan D. Hughes
'========================================================================
'
' This program is free software; you can redistribute it and/or
' modify it under the terms of the GNU General Public License
' as published by the Free Software Foundation; either version 2
' of the License, or (at your option) any later version.
'
' This program is distributed in the hope that it will be useful,
' but WITHOUT ANY WARRANTY; without even the implied warranty of
' MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
' GNU General Public License for more details.
'
'========================================================================

Option Explicit

Private Declare Function BRDPixelToTile Lib "actkrt3.dll" (ByRef x As Long, ByRef y As Long, ByVal coordType As Integer, ByVal bRemoveBasePoint As Boolean, ByVal brdSizeX As Integer) As Long
Private Declare Function BRDTileToPixel Lib "actkrt3.dll" (ByRef x As Long, ByRef y As Long, ByVal coordType As Integer, ByVal bAddBasePoint As Boolean, ByVal brdSizeX As Integer) As Long
Private Declare Function BRDVectorize Lib "actkrt3.dll" (ByVal pCBoard As Long, ByVal pData As Long, ByRef vectors() As TKConvertedVector) As Long
Private Declare Function BRDTileToVector Lib "actkrt3.dll" (ByVal pVector As Long, ByVal x As Long, ByVal y As Long, ByVal coordType As Integer) As Long
Private Declare Function IMGFree Lib "actkrt3.dll" (ByVal nFreeImagePtr As Long) As Long
Private Declare Function IMGGetTransparentColor Lib "actkrt3.dll" (ByVal nFreeImagePtr As Long) As Long
Private Declare Function IMGLoad Lib "actkrt3.dll" (ByVal filename As String) As Long

'=========================================================================
' A globally unique identifier
'=========================================================================
Private Type GUID
    Data1 As Long
    Data2 As Integer
    Data3 As Integer
    Data4(7) As Byte
End Type

Private Declare Function CoCreateGuid Lib "OLE32.DLL" (pGuid As GUID) As Long

'=========================================================================
' A board-set image [tagVBBoardImage]
'=========================================================================
Public Type TKBoardImage
    drawType As Long                    'Drawing option (see BI_ENUM enumeration).
    layer As Long
    bounds As RECT                      'RECT of board pixel coordinates.
    transpcolor As Long                 'Transparent colour on the image.
    pCnv As Long                        'Pointer to the canvas.
    scrollX As Double                   'Scrolling factors (x,y).
    scrollY As Double
    filename As String
End Type

Public Enum eBoardImage
    BI_NULL = -1                        'VB only.
    BI_NORMAL                           'See BI_ENUM enumeration, CBoard.h
    BI_PARALLAX
    BI_STRETCH
End Enum

'=========================================================================
' Tiletype/vector defines
'=========================================================================
Public Enum eTileType
    TT_NULL = -1                        'To denote empty slot in editor.
    TT_NORMAL = 0                       'See TILE_TYPE enumeration, board conversion.h
    TT_SOLID = 1
    TT_UNDER = 2
    TT_UNIDIRECTIONAL = 4               'Incomplete  / unnecessary.
    TT_STAIRS = 8
    TT_WAYPOINT = 16
End Enum

'Under vector attributes. See board.h
Public Const TA_BRD_BACKGROUND = 1            'Under vector uses background image.
Public Const TA_ALL_LAYERS_BELOW = 2          'Under vector applies to all layers below.
Public Const TA_FRAME_INTERSECT = 4           'Under vector activated by bounding rect intersection.

'=========================================================================
' Board program defines
'=========================================================================
Public Const PRG_STEP = 0                 'Triggers once until player leaves area.
Public Const PRG_KEYPRESS = 1             'Player must hit activation key.
Public Const PRG_REPEAT = 2               'Triggers repeatedly after a certain distance or
                                          'can only be triggered after a certain distance.
Public Const PRG_STOPS_MOVEMENT = 4       'Running the program clears the movement queue.

Public Const PRG_ACTIVE = 0               'Program is always active.
Public Const PRG_CONDITIONAL = 1          'Program's running depends on RPGCode variables.

'=========================================================================
' A board sprite [tagVBBoardSprite]
'=========================================================================
Public Type TKBoardSprite
    'Editor data - use a TKBoardImage.
    'transpcolor As Long                   'Transparent colour on the image.
    'pCnv As Long                          'Pointer to the canvas.
    'bounds As RECT                        'Image bounds (for hit test).
    'displayImage As String                'Filename of image to display on board (rest graphic).
    
    'Board data
    filename As String                    'Sprite filename (inc. path from project path).
    x As Long                             'Location.
    y As Long
    layer As Long
    activate As Long                      'SPR_ACTIVE - always active.
                                          'SPR_CONDITIONAL - conditional activation.
    initialVar As String                  'Activation variable.
    finalVar As String                    'Activation variable at end of activation prg.
    initialValue As String                'Initial value of activation variable.
    finalValue As String                  'Value of variable after activation prg runs.
    activationType As Long                'Activation type: SPR_STEP
                                          '                 SPR_KEYPRESS
    prgActivate As String                 'Program to run when sprite is activated.
    prgMultitask As String                'Multitask program for sprite.

    'boardPath As CVector                 'Path from the board that the sprite is moving along.
                                          '(see SPR_BRDPATH, trans3)
End Type

Public Const SPR_STEP = 0                 'Triggers once until player leaves area.
Public Const SPR_KEYPRESS = 1             'Player must hit activation key.

Public Const SPR_ACTIVE = 0               'Sprite is always active.
Public Const SPR_CONDITIONAL = 1          'Sprite running depends on RPGCode variables.

'=========================================================================
' Board tile and layer shading
'=========================================================================
Public Type TKTileShade
    r As Integer
    b As Integer
    g As Integer
End Type

Public Enum eBoardLight
    BL_ELLIPSE
    BL_GRADIENT
    BL_GRADIENT_CLIPPED
End Enum

Public Type TKLayerShade
    values() As TKTileShade
    layer As Long
End Type

'=========================================================================
' An RPGToolkit board
'=========================================================================
Public Type TKBoard

    ' 3.1.0 Following block ordered for actkrt (see CBoard.h)
    sizex As Integer                      'board size x
    sizey As Integer                      'board size y
    sizeL As Integer                      'board size layer
    coordType As Integer
    
    tileIndex() As String                 'lookup table for tiles
    board() As Integer                    'board tiles -- codes indicating where the tiles are on the board
    
    tiletype() As Byte                    'tile types (backwards compatbility)
    
    tileShading() As TKLayerShade         'Tile shading array (old ambientRed, -Green, -Blue arrays)
    lights() As CBoardLight               'Lighting objects (spotlight, gradient)
        
    Images() As TKBoardImage
    spriteImages() As TKBoardImage        'Image data for board sprites
    bkgImage As TKBoardImage              'background image
    bkgColor As Long                      'board color
    
    'Unordered
    vectors() As CVector
    prgs() As CBoardProgram
    sprites() As CBoardSprite
    Threads() As String                   'filenames of threads on board
    constants() As String                 'Board Constants
    layerTitles() As String               'Layer titles
    directionalLinks() As String          'Direction links 0: N, 1: S, 2: E, 3: W
    
    bkgMusic As String                    'Background music file
    enterPrg As String                    'Program to run on entrance
    battleBackground As String            'Battle background
    battleSkill As Integer                'Random enemy skill level
    bAllowBattles As Boolean              'Allow random battles on board?
    bDisableSaving As Boolean             'Is saving disabled on board?
    ambientEffect As TKTileShade          'Ambient effect applied to the board
    startX As Integer                     'Player start pixel coordinates
    startY As Integer
    startL As Integer
    
    'Volatile data (trans3 only)
    'animatedTile() As TKBoardAnimTile     'animated tiles associated with this board
    'strFileName As String                 'filename of the board

End Type

'=========================================================================
' An animated tile (trans3 only)
'=========================================================================
'Private Type TKBoardAnimTile
'    theTile As TKTileAnm
'    x As Long
'    y As Long
'    layer As Long
'End Type

'=========================================================================
'Editing option buttons on the lefthand toolbar.
'=========================================================================
Public Enum eBrdSetting
    BS_SCROLL
    BS_ZOOM
    BS_TILE
    BS_VECTOR
    BS_PROGRAM
    BS_SPRITE
    BS_IMAGE
    BS_SHADING                            'Tile shading
    BS_LIGHTING                           'Lighting: spotlight, gradient etc.
End Enum
Public Enum eBrdTool
    BT_DRAW
    BT_SELECT
    BT_FLOOD
    BT_ERASE
    BT_RECT
    BT_DROPPER
    BT_IMG_TRANSP                         'Getting the transparent colour for an image.
    BT_SET_PSTART                         'Setting the player start location.
End Enum
Public Enum eBrdSelectStatus
    SS_NONE
    SS_DRAWING
    SS_FINISHED
    SS_MOVING
    SS_PASTING
End Enum
Public Enum eBoardTabs
    BTAB_VECTOR
    BTAB_PROGRAM
    BTAB_SPRITE
    BTAB_IMAGE
    BTAB_LIGHTING
End Enum

'=========================================================================
' A board editor document
'=========================================================================
Public Type TKBoardEditorData
    '3.1.0
    ' Following block ordered for actkrt
    pCBoard As Long                       'pointer to associated CBoard in actkrt
    optSetting As eBrdSetting
    bLayerOccupied() As Boolean           'layer contains tiles
    bLayerVisible() As Boolean            'layer visibility in the editor
    bDrawObjects() As Boolean
        
    ' Unordered
    
    board() As TKBoard                     'actual contents of board (dimmed to MAX_UNDO)
    bUndoData() As Boolean                 'do the board() entries hold undo data?
    
    'Data that are required for classes.
    pCEd As New CBoardEditor
    
    undoIndex As Long                     'index to current .board
    optTool As eBrdTool
    selectedTile As String                'Selected tile
    bGrid As Boolean
    bAutotiler As Boolean
    currentLayer As Integer               'Current board layer
    bHideAllLayers As Boolean
    bShowAllLayers As Boolean
    bUnsavedData As Boolean
    boardName As String                   'Filename
    
    currentVectorSet() As CVector         'References to vectors of current optSetting
    
    effectiveBoardX As Long               'Board data matrix dimensions
    effectiveBoardY As Long               '(different from sizeX/Y for ISO_ROTATED)
    
    currentObject(BTAB_LIGHTING) As Long  'Selected object indices
    
    currentShade As TKTileShade           'Current lighting pen
    
End Type

'=========================================================================
' Board clipboard
'=========================================================================
Public Type TKBoardClipboardTile
    file As String
    shade As TKTileShade
    brdCoord As POINTAPI
End Type

Public Type TKBoardClipboard
    tiles() As TKBoardClipboardTile     'BS_TILE, BS_SHADING
    origin As POINTAPI
    obj As Object                       'BS_VECTOR, BS_PROGRAM, BS_SPRITE
    img As TKBoardImage
End Type

'=========================================================================
' Converted vector from actkrt3
'=========================================================================
Public Type TKConvertedVector
    pts() As POINTAPI
    type As Long
    layer As Long
    attributes As Long
    closed As Boolean
End Type

'=========================================================================
' Coordinate type enumeration
'=========================================================================
Public Const TILE_NORMAL = 0
Public Const ISO_STACKED = 1              ' (Old) staggered column method.
Public Const ISO_ROTATED = 2              ' x-y axes rotated by 60 / 30 degrees.
Public Const PX_ABSOLUTE = 4              ' Absolute co-ordinates (iso and 2D).

'=========================================================================
' Board editor globals (common to all board editors)
'=========================================================================
Public g_tabMap(BS_LIGHTING) As Long            'Map eBrdSettings to eBoardTabs
Public g_boardClipboard As TKBoardClipboard     'One clip for all boards.
Public g_CBoardPreferences As CBoardPreferences

Public Const BRD_VECTOR_HANDLE = "<vector handle>"

'=========================================================================
' Absolute board pixel dimensions
'=========================================================================
Public Property Get absWidth(ByVal sizex As Integer, ByVal coordType As Integer) As Integer ': On Error Resume Next
    If (coordType And ISO_STACKED) Then
        absWidth = sizex * 64 - 32
    ElseIf (coordType And ISO_ROTATED) Then
        absWidth = sizex * 64 - 32
    Else
        absWidth = sizex * 32
    End If
End Property
Public Property Get absHeight(ByVal sizey As Integer, ByVal coordType As Integer) As Integer ': On Error Resume Next
    If (coordType And ISO_STACKED) Then
        absHeight = sizey * 16 - 16
    ElseIf (coordType And ISO_ROTATED) Then
        absHeight = sizey * 32
    Else
        absHeight = sizey * 32
    End If
End Property

'=========================================================================
' Board pixel dimensions relative to zoom
'=========================================================================
Public Property Get relWidth(ByRef ed As TKBoardEditorData) As Integer ': On Error Resume Next
    relWidth = absWidth(ed.board(ed.undoIndex).sizex, ed.board(ed.undoIndex).coordType) * ed.pCEd.zoom
End Property
Public Property Get relHeight(ByRef ed As TKBoardEditorData) As Integer ': On Error Resume Next
    relHeight = absHeight(ed.board(ed.undoIndex).sizey, ed.board(ed.undoIndex).coordType) * ed.pCEd.zoom
End Property

'=========================================================================
' Conversion routines
'=========================================================================
Public Function screenToBoardPixel(ByVal x As Long, ByVal y As Long, ByRef pCEd As CBoardEditor) As POINTAPI
    Call pCEd.screenToBoardPixel(x, y)
    screenToBoardPixel.x = x
    screenToBoardPixel.y = y
End Function
Public Function boardPixelToScreen(ByVal x As Long, ByVal y As Long, ByRef pCEd As CBoardEditor) As POINTAPI
    Call pCEd.boardPixelToScreen(x, y)
    boardPixelToScreen.x = x
    boardPixelToScreen.y = y
End Function
Public Function boardPixelToTile(ByVal x As Long, ByVal y As Long, ByVal coordType As Long, ByVal bRemoveBasePoint As Boolean, ByVal brdSizeX As Long) As POINTAPI
    ' Remove any PX_ABSOLUTE flag since we specifically want tile values when using this in the editor.
    Call BRDPixelToTile(x, y, coordType And (Not PX_ABSOLUTE), bRemoveBasePoint, brdSizeX)
    boardPixelToTile.x = x
    boardPixelToTile.y = y
End Function
Public Function tileToBoardPixel(ByVal x As Long, ByVal y As Long, ByVal coordType As Long, ByVal bAddBasePoint As Boolean, ByVal brdSizeX As Long, Optional ByVal bIsoRenderPoint As Boolean = False) As POINTAPI
    Call BRDTileToPixel(x, y, coordType And (Not PX_ABSOLUTE), bAddBasePoint, brdSizeX)
    tileToBoardPixel.x = x
    tileToBoardPixel.y = y
    If isIsometric(coordType) And bIsoRenderPoint Then
        'BRDTileToPixel() returns the centre of isometric tiles.
        'In rendering instances, the top-left corner of the tile (i.e., the centre of the NW tile) is required.
        tileToBoardPixel.x = x - 32
        tileToBoardPixel.y = y - 16
    End If
End Function

'=========================================================================
' Tile pixel dimensions relative to zoom
'=========================================================================
Public Function tileWidth(ByRef ed As TKBoardEditorData) As Integer ': On Error Resume Next
    tileWidth = IIf(isIsometric(ed.board(ed.undoIndex).coordType), 64, 32) * ed.pCEd.zoom
End Function
Public Function tileHeight(ByRef ed As TKBoardEditorData) As Integer ': On Error Resume Next
    tileHeight = IIf(isIsometric(ed.board(ed.undoIndex).coordType), 32, 32) * ed.pCEd.zoom
End Function
Public Function scrollUnitWidth(ByRef ed As TKBoardEditorData) As Integer ': On Error Resume Next
    scrollUnitWidth = IIf(isIsometric(ed.board(ed.undoIndex).coordType), 32, 32) * ed.pCEd.zoom
End Function
Public Function scrollUnitHeight(ByRef ed As TKBoardEditorData) As Integer ': On Error Resume Next
    'ISO_ROTATED board height is (currently) a multiple of 32.
    scrollUnitHeight = IIf(ed.board(ed.undoIndex).coordType And ISO_STACKED, 16, 32) * ed.pCEd.zoom
End Function

Public Function isIsometric(ByVal coordType As Long) As Boolean ': On Error Resume Next
    isIsometric = (coordType And (ISO_ROTATED Or ISO_STACKED))
End Function

'=========================================================================
'=========================================================================
Public Function vectorCreate(ByRef optSetting As eBrdSetting, ByRef board As TKBoard, ByVal layer As Long) As CVector       ':on error resume next

    Dim i As Integer, bFound As Boolean
    
    Select Case optSetting
        Case BS_VECTOR
            '.vectors is always dimensioned.
            For i = 0 To UBound(board.vectors)
                If board.vectors(i) Is Nothing Then
                    Set board.vectors(i) = New CVector
                End If
                If board.vectors(i).tiletype = TT_NULL Then
                    bFound = True
                    Exit For
                End If
            Next i
            If Not bFound Then
                ReDim Preserve board.vectors(i)
                Set board.vectors(i) = New CVector
            End If
            
            'Assign current vector.
            Call activeBoard.toolbarPopulateVectors            'Add the combo entry.
            board.vectors(i).layer = layer
            Call activeBoard.toolbarChange(i, BS_VECTOR)
            Set vectorCreate = board.vectors(i)
            
        Case BS_PROGRAM
            '.prgs is always dimensioned.
            For i = 0 To UBound(board.prgs)
                If board.prgs(i) Is Nothing Then
                    Set board.prgs(i) = New CBoardProgram
                End If
                If board.prgs(i).vBase.tiletype = TT_NULL Then
                    bFound = True
                    Exit For
                End If
            Next i
            If Not bFound Then
                ReDim Preserve board.prgs(i)
                Set board.prgs(i) = New CBoardProgram
            End If
            Call activeBoard.toolbarPopulatePrgs            'Add the combo entry.
            board.prgs(i).layer = layer
            Call activeBoard.toolbarChange(i, BS_PROGRAM)
            Set vectorCreate = board.prgs(i).vBase
            
    End Select
    
End Function
Public Sub vectorize(ByRef ed As TKBoardEditorData) ': On Error Resume Next

    Dim vects() As TKConvertedVector, i As Long, j As Long, vector As CVector
    ReDim vects(0)
    
    Call BRDVectorize(ed.pCBoard, VarPtr(ed.board(ed.undoIndex)), vects())
    
    For i = 0 To UBound(vects)
        Set vector = vectorCreate(BS_VECTOR, ed.board(ed.undoIndex), vects(i).layer)
        For j = 0 To UBound(vects(i).pts)
            Call vector.addPoint(vects(i).pts(j).x, vects(i).pts(j).y)
        Next j
        vector.tiletype = vects(i).type
        Call vector.closeVector(Not vects(i).closed, vects(i).layer)
        vector.attributes = vects(i).attributes
    Next i
End Sub
Public Sub upgradeProgram(ByRef prg As CBoardProgram, ByVal x As Long, ByVal y As Long, ByVal coordType As Long) ':on error resume next
    
    Dim vect As TKConvertedVector, i As Long
    Call BRDTileToVector(VarPtr(vect), x, y, coordType)
    
    For i = 0 To UBound(vect.pts)
        Call prg.vBase.addPoint(vect.pts(i).x, vect.pts(i).y)
    Next i
    prg.vBase.tiletype = vect.type
    Call prg.vBase.closeVector(0, prg.layer)
End Sub

'=========================================================================
'=========================================================================
Public Sub vectorLvColumn(ByRef lv As ListView, ByRef x As Single): On Error Resume Next
    'Determine the column clicked.
    Dim i As Long, w As Long
    For i = 1 To 3
        w = w + lv.ColumnHeaders(i).width
        If x < w Then Exit For
    Next i
    'Store the subitem column in the tag (first subitem column is the second column).
    lv.Tag = i - 1
End Sub
Public Function vectorLvKeyDown(ByRef lv As ListView, ByVal keyCode As Integer) As Boolean ':on error resume next
    
    Const vbKeyDash = 189
    Dim i As Long
    i = val(lv.Tag)
    If i = 0 And keyCode = vbKeyDelete Then
        'Whole row selected - delete the point.
        lv.ListItems.Remove lv.SelectedItem.Index
        vectorLvKeyDown = True
    End If
    If i <> 1 And i <> 2 Then Exit Function
        
    Select Case keyCode
        Case vbKeyBack, vbKeyDelete
            lv.SelectedItem.SubItems(i) = vbNullString
        Case vbKeyReturn
            vectorLvKeyDown = True
        Case vbKey0 To vbKey9
            lv.SelectedItem.SubItems(i) = lv.SelectedItem.SubItems(i) & chr(keyCode)
        Case vbKeyNumpad0 To vbKeyNumpad9
            keyCode = keyCode - (vbKeyNumpad0 - vbKey0)
            lv.SelectedItem.SubItems(i) = lv.SelectedItem.SubItems(i) & chr(keyCode)
        Case vbKeyAdd
            lv.SelectedItem.SubItems(i) = str(val(lv.SelectedItem.SubItems(i)) + 32)
             vectorLvKeyDown = True
       Case vbKeySubtract
            lv.SelectedItem.SubItems(i) = str(val(lv.SelectedItem.SubItems(i)) - 32)
            vectorLvKeyDown = True
       Case vbKeyDash
            lv.SelectedItem.SubItems(i) = lv.SelectedItem.SubItems(i) & "-"
       Case vbKeyRight
            'Switch columns.
            If i = 1 Then lv.Tag = "2": vectorLvKeyDown = True
       Case vbKeyLeft
            If i = 2 Then lv.Tag = "1": vectorLvKeyDown = True
    End Select
End Function

'=========================================================================
' Copy a board - have to copy objects explicitly
'=========================================================================
Public Sub boardCopy(ByRef Source As TKBoard, ByRef dest As TKBoard) ': on error resume next
    Dim i As Long
    
    'Copy non-object data.
    dest = Source
    
    ReDim dest.vectors(UBound(Source.vectors))
    For i = 0 To UBound(Source.vectors)
        If Not Source.vectors(i) Is Nothing Then
            Set dest.vectors(i) = New CVector
            Call Source.vectors(i).copy(dest.vectors(i))
        End If
    Next i
    ReDim dest.prgs(UBound(Source.prgs))
    For i = 0 To UBound(Source.prgs)
        If Not Source.prgs(i) Is Nothing Then
            Set dest.prgs(i) = New CBoardProgram
            Call Source.prgs(i).copy(dest.prgs(i))
        End If
    Next i
    ReDim dest.sprites(UBound(Source.sprites))
    For i = 0 To UBound(Source.sprites)
        If Not Source.sprites(i) Is Nothing Then
            Set dest.sprites(i) = New CBoardSprite
            Call Source.sprites(i).copy(dest.sprites(i))
        End If
    Next i
    ReDim dest.lights(UBound(Source.lights))
    For i = 0 To UBound(Source.lights)
        If Not Source.lights(i) Is Nothing Then
            Set dest.lights(i) = New CBoardLight
            Call Source.lights(i).copy(dest.lights(i))
        End If
    Next i
    
End Sub

'=========================================================================
' Extract a rest graphic (or other) to display an item on the board
'=========================================================================
Public Sub spriteGetDisplayImage(ByVal filename As String, ByRef image As String, ByRef transpcolor As Long) ':on error resume next
    If Not fileExists(projectPath & itmPath & filename) Then Exit Sub
    If UCase$(commonRoutines.extention(filename)) = "ITM" Then
        Call itemGetDisplayImage(filename, image, transpcolor)
    Else
        'Player support...
    End If
End Sub
Private Sub itemGetDisplayImage(ByVal filename As String, ByRef image As String, ByRef transpcolor As Long) ':on error resume next
    Dim anm As TKAnimation, Item As TKItem, i As Long, str As String, pfbmp As Long
    
    'Check standing and walking graphics.
    Item = CommonItem.openItem(projectPath & itmPath & filename)
    For i = 0 To UBound(Item.standingGfx)
        If LenB(Item.standingGfx(i)) Then Exit For
    Next i
    If i > UBound(Item.standingGfx) Then
        For i = 0 To UBound(Item.gfx)
            If LenB(Item.gfx(i)) Then Exit For
        Next i
        'None found.
        If i > UBound(Item.gfx) Then Exit Sub
        str = Item.gfx(i)
    Else
        str = Item.standingGfx(i)
    End If
    
    If LCase$(GetExt(str)) = "anm" Then
        'Take the first frame of the animation.
        Call CommonAnimation.openAnimation(projectPath & miscPath & str, anm)
        For i = 0 To UBound(anm.animFrame)
            If LenB(anm.animFrame(i)) Then
                image = anm.animFrame(i)
                transpcolor = anm.animTransp(i)
                Exit Sub
            End If
        Next i
    Else
        'gif animation, etc.
        transpcolor = 0
        image = str
        pfbmp = IMGLoad(projectPath & miscPath & str)
        If pfbmp Then
            transpcolor = IMGGetTransparentColor(pfbmp)
            Call IMGFree(pfbmp)
        End If
    End If
End Sub

'=========================================================================
' Given the left and right pixel points of an isometric projection
' of a rectangle, calculate the top and bottom points
'=========================================================================
Public Function rectProjectIsometric(ByRef sel As CBoardSelection) As POINTAPI() ': on error resume next
    Dim dx As Long, dy As Long, sgnDy As Long, pts(3) As POINTAPI
   
    dx = sel.x2 - sel.x1
    dy = sel.y2 - sel.y1
    sgnDy = IIf(dy = 0, 1, Sgn(dy))
    
    'Either tedious maths or lots of coordinate transforms.
    pts(0).x = sel.x1
    pts(0).y = sel.y1
    pts(1).x = sel.x1 + (dx / 2 + Abs(dy))
    pts(1).y = sel.y1 + sgnDy * (dx / 2 + Abs(dy)) / 2
    pts(2).x = sel.x2
    pts(2).y = sel.y2
    pts(3).x = sel.x1 + (sel.x2 - pts(1).x)
    pts(3).y = sel.y1 - sgnDy * (sel.x2 - pts(1).x) / 2
    
    rectProjectIsometric = pts
End Function

'========================================================================
' Draw a tile grid onto a picturebox
'========================================================================
Public Sub gridDraw( _
    ByRef pic As PictureBox, _
    ByRef pCEd As CBoardEditor, _
    ByVal isometric As Boolean, _
    ByVal tileWidth As Long, _
    ByVal tileHeight As Long) ': On Error Resume Next
    
    Dim color As Long, offsetY As Long, x As Long, y As Long, oldMode As Long, intHeight As Long
    
    oldMode = pic.DrawMode
    pic.DrawMode = vbInvert
        
    If isometric Then
        offsetY = IIf((pCEd.topY Mod tileHeight = 0) = (pCEd.topX Mod tileWidth = 0), 0, 16 * pCEd.zoom)
        
        ' Top right to bottom left.
        Do While y < pic.ScaleWidth / 2 + pic.ScaleHeight
            pic.Line (0, y + offsetY)-(x + offsetY * 2, 0), color
            x = x + tileWidth: y = y + tileHeight
        Loop

        ' Top left to bottom right.
        x = 0
        intHeight = pic.ScaleHeight + (pic.ScaleHeight Mod tileHeight)
        y = intHeight
        Do While y > -pic.ScaleWidth / 2
            pic.Line (0, y + offsetY)-(x, intHeight + offsetY), color
            x = x + tileWidth:  y = y - tileHeight
        Loop
    Else
        Do While x < pic.ScaleWidth
            pic.Line (x, 0)-(x, pic.ScaleHeight), color
            x = x + tileWidth
        Loop
        Do While y < pic.ScaleHeight
            pic.Line (0, y)-(pic.ScaleWidth, y), color
            y = y + tileHeight
        Loop
    End If 'isometric
    
    pic.DrawMode = oldMode
End Sub

'========================================================================
' Create a "unique" variable name from a Guid
' From Microsoft support article 176790 (c) 2000 Gus Molina
'========================================================================
Public Function createGuid() As String: On Error Resume Next
    Dim id As GUID
    If (CoCreateGuid(id) = 0) Then
        createGuid = _
            String(8 - Len(Hex$(id.Data1)), "0") & Hex$(id.Data1) & _
            String(4 - Len(Hex$(id.Data2)), "0") & Hex$(id.Data2) & _
            String(4 - Len(Hex$(id.Data3)), "0") & Hex$(id.Data3) & _
            IIf((id.Data4(0) < &H10), "0", "") & Hex$(id.Data4(0)) & _
            IIf((id.Data4(1) < &H10), "0", "") & Hex$(id.Data4(1)) & _
            IIf((id.Data4(2) < &H10), "0", "") & Hex$(id.Data4(2)) & _
            IIf((id.Data4(3) < &H10), "0", "") & Hex$(id.Data4(3)) & _
            IIf((id.Data4(4) < &H10), "0", "") & Hex$(id.Data4(4)) & _
            IIf((id.Data4(5) < &H10), "0", "") & Hex$(id.Data4(5)) & _
            IIf((id.Data4(6) < &H10), "0", "") & Hex$(id.Data4(6)) & _
            IIf((id.Data4(7) < &H10), "0", "") & Hex$(id.Data4(7) _
        )
    End If
End Function

'========================================================================
' Determine if an ISO_ROTATED coordinate is invisible
'========================================================================
Public Function isoOffEdge(ByVal x As Long, ByVal y As Long, ByRef board As TKBoard) As Boolean: On Error Resume Next
    If board.coordType And ISO_ROTATED Then
        'Top.
        If x + y <= board.sizex Then isoOffEdge = True
        'Left.
        If y - x > board.sizex Then isoOffEdge = True
        'Right.
        If x - y >= board.sizex Then isoOffEdge = True
        'Bottom.
        If x + y > board.sizex + board.sizey + board.sizey + 1 Then isoOffEdge = True
    End If
End Function

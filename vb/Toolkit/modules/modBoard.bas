Attribute VB_Name = "modBoard"
'========================================================================
'All contents copyright 2006 Jonathan D. Hughes
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'========================================================================
Option Explicit

Private Declare Function BRDPixelToTile Lib "actkrt3.dll" (ByRef x As Long, ByRef y As Long, ByVal coordType As Integer, ByVal brdSizeX As Integer) As Long
Private Declare Function BRDTileToPixel Lib "actkrt3.dll" (ByRef x As Long, ByRef y As Long, ByVal coordType As Integer, ByVal brdSizeX As Integer) As Long
Private Declare Function BRDVectorize Lib "actkrt3.dll" (ByVal pCBoard As Long, ByVal pData As Long, ByRef vectors() As TKConvertedVector) As Long
Private Declare Function BRDTileToVector Lib "actkrt3.dll" (ByVal pVector As Long, ByVal x As Long, ByVal y As Long, ByVal coordType As Integer) As Long

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
    file As String
End Type

Public Enum eBoardImage
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
    TT_UNIDIRECTIONAL = 4
    TT_STAIRS = 8
End Enum

'Under vector attributes. See board.h
Public Const TA_BRD_BACKGROUND = 1            'Under vector uses background image.
Public Const TA_ALL_LAYERS_BELOW = 2          'Under vector applies to all layers below.
Public Const TA_RECT_INTERSECT = 4            'Under vector activated by bounding rect intersection.

'=========================================================================
' A board program [tagVBBoardProgram]
'=========================================================================
Public Const PRG_STEP = 0                 'Triggers once until player leaves area.
Public Const PRG_KEYPRESS = 1             'Player must hit activation key.
Public Const PRG_REPEAT = 2               'Triggers repeatedly after a certain distance or
                                          'can only be triggered after a certain distance.
Public Const PRG_STOPS_MOVEMENT = 4       'Running the program clears the movement queue.

Public Const PRG_ACTIVE = 0               'Program is always active.
Public Const PRG_CONDITIONAL = 1          'Program's running depends on RPGCode variables.

Public Type TKBoardProgram
    filename As String                    'Board program filename.
    layer As Long                         'Layer.
    graphic  As String                    'Associated graphic.
    activate As Long                      'PRG_ACTIVE - always active.
                                          'PRG_CONDITIONAL - conditional activation.
    initialVar As String                  'Activation variable.
    finalVar As String                    'Activation variable at end of prg.
    initialValue As String                'Initial value of activation variable.
    finalValue As String                  'Value of variable after program runs.
    activationType As Long                'Activation type (see 1st set of flags above).

    vBase As New CVector                  'The activation area.
    distanceRepeat As Long                'Distance to travel between activations within the vector.
End Type

'=========================================================================
' A RPGToolkit board
'=========================================================================
Public Type TKBoard

    ' New from 3.0.7
    coordType As Integer
    bkgImage As TKBoardImage              'background image
    Images() As TKBoardImage
        
    ' Pre 3.0.7
    bSizeX As Integer                     'board size x
    bSizeY As Integer                     'board size y
    bSizeL As Integer                     'board size layer
    tileIndex() As String                 'lookup table for tiles
    board() As Integer                    'board tiles -- codes indicating where the tiles are on the board
    ambientRed() As Integer               'ambient tile red
    ambientGreen() As Integer             'ambient tile green
    ambientBlue() As Integer              'ambient tile blue
    tiletype() As Byte                    'tile types 0- Normal, 1- solid 2- Under, 3- NorthSouth normal, 4- EastWest Normal, 11- Elevate to level 1, 12- Elevate to level 2... 18- Elevate to level 8
    brdBack As String                     'board background img (parallax layer)
    brdBackCNV As Long                    'Canvas holding the background image
    brdFore As String                     'board foreground image (parallax)
    borderBack As String                  'border background img
    brdColor As Long                      'board color
    borderColor As Long                   'Border color
    ambientEffect As Integer              'boardList(activeBoardIndex).ambient effect applied to the board 0- none, 1- fog, 2- darkness, 3- watery
    dirLink(4) As String                  'Direction links 1- N, 2- S, 3- E, 4-W
    boardSkill As Integer                 'Board skill level
    boardBackground As String             'Fighting background
    fightingYN As Integer                 'Fighting on boardYN (1- yes, 0- no)
    BoardDayNight As Integer              'board is affected by day/night? 0=no, 1=yes
    BoardNightBattleOverride As Integer   'use custom battle options at night? 0=no, 1=yes
    BoardSkillNight As Integer            'Board skill level at night
    BoardBackgroundNight As String        'Fighting background at night
    brdConst(10) As Integer               'Board Constants (1-10)
    boardMusic As String                  'Background music file
    boardTitle(8) As String               'Board title (layer)
    programName(500) As String            'Board program filenames
    progX(500) As Integer                 'program x
    progY(500) As Integer                 'program y
    progLayer(500) As Integer             'program layer
    progGraphic(500) As String            'program graphic
    progActivate(500) As Integer          'program activation: 0- always active, 1- conditional activation.
    progVarActivate(500) As String        'activation variable
    progDoneVarActivate(500) As String    'activation variable at end of prg.
    activateInitNum(500) As String        'initial number of activation
    activateDoneNum(500) As String        'what to make variable at end of activation.
    activationType(500) As Integer        'activation type- 0-step on, 1- conditional (activation key)
    enterPrg As String                    'program to run on entrance
    bgPrg As String                       'background program
    itmName() As String                   'filenames of items
    itmX() As Double                      'x coord
    itmY() As Double                      'y coord
    itmLayer() As Double                  'layer coord
    itmActivate() As Integer              'itm activation: 0- always active, 1- conditional activation.
    itmVarActivate() As String            'activation variable
    itmDoneVarActivate() As String        'activation variable at end of itm.
    itmActivateInitNum() As String        'initial number of activation
    itmActivateDoneNum() As String        'what to make variable at end of activation.
    itmActivationType() As Integer        'activation type- 0-step on, 1- conditional (activation key)
    itemProgram() As String               'program to run when item is touched.
    itemMulti() As String                 'multitask program for item
    playerX As Integer                    'player x ccord
    playerY As Integer                    'player y coord
    playerLayer As Integer                'player layer coord
    brdSavingYN As Integer                'can player save on board? 0-yes, 1-no
    isIsometric As Byte                   'is it an isometric board? (0- no, 1-yes)
    Threads() As String                   'filenames of threads on board
    hasAnmTiles As Boolean                'does board have anim tiles?
    'animatedTile() As TKBoardAnimTile     'animated tiles associated with this board
    anmTileInsertIdx As Long              'index of animated tile insertion
    anmTileLUTIndices() As Long           'indices into LUT of animated tiles
    anmTileLUTInsertIdx As Long           'index of LUT table insertion
    strFileName As String                 'filename of the board
    
    '3.0.7
    vectors() As CVector
    prgs() As TKBoardProgram
    
End Type

'=========================================================================
'Editing option buttons on the lefthand toolbar.
'=========================================================================
Public Enum eBrdSetting
    BS_GENERAL
    BS_TILE
    BS_VECTOR
    BS_PROGRAM
    BS_ITEM
    BS_IMAGE
End Enum
Public Enum eBrdTool
    BT_DRAW
    BT_SELECT
    BT_FLOOD
    BT_ERASE
    BT_EDIT
    BT_UNUSED
    BT_LIST
End Enum
Public Enum eBrdSelectStatus
    SS_NONE
    SS_DRAWING
    SS_FINISHED
    SS_MOVING
    SS_PASTING
End Enum
Public Type brdSelection
    status As eBrdSelectStatus            'Status of selection.
    area As RECT                          'Selection area (board px).
    dragPoint As POINTAPI                 'Mouse point when dragging (board px).
    color As Long
End Type

'=========================================================================
' A board editor document
'=========================================================================
Public Type TKBoardEditorData
    '3.0.7
    ' Following block ordered for actkrt
    pCBoard As Long                       'pointer to associated CBoard in actkrt
    bLayerOccupied() As Boolean           'layer contains tiles
    bLayerVisible() As Boolean            'layer visibility in the editor
        
    ' Unordered
    
    board() As TKBoard                     'actual contents of board (dimmed to MAX_UNDO)
    bUndoData() As Boolean                 'do the board() entries hold undo data?
    
    'Data that are required for classes.
    'topX As Long                          'top x coord (scaled pixels)
    'topY As Long                          'top y coord (scaled pixels)
    'zoom As Double                        'scaling factor
    pCEd As New CBoardEditor
    
    undoIndex As Long                     'index to current .board
    optSetting As eBrdSetting
    optTool As eBrdTool
    selectedTile As String                'Selected tile
    bGrid As Boolean
    bAutotiler As Boolean
    bRevertToDraw As Boolean              'After flooding revert to draw tool
    gridColor As Long
    currentLayer As Integer               'Current board layer
    bHideAllLayers As Boolean
    bShowAllLayers As Boolean
    bNeedUpdate As Boolean                'tbd:have any changes been made to the board data?
    bShowBackColour As Boolean            'tbd:show background colour in editor
        
    currentVectorSet() As CVector         'References to vectors of current optSetting
    currentVector As CVector
    vectorColor(TT_STAIRS) As Long
    programColor As Long
    waypointColor As Long

    'Pre 3.0.7
    boardName As String                   'filename
    tilesX As Long                        'x size
    tilesY As Long                        'y size
    boardAboutToDefineGradient As Boolean 'about to define a gradient?
    boardGradTop As Integer               'top tile of board gradient
    boardGradLeft As Integer              'left tile of board gradient
    boardGradBottom As Integer            'bottom tile of board gradient
    boardGradRight As Integer             'right tile of board gradient
    boardGradientType As Integer          'gradient type 0- l to r, 1- t to b, 2- nw to se, 3- ne to sw
    boardGradientColor1 As Long           'grad color1
    boardGradientColor2 As Long           'grad color2
    boardGradMaintainPrev As Boolean      'retain previous shades?
    BoardDetail As Integer                'Detail of selected board tile
    gridBoard As Integer                  'Board grid on off
    BoardTile(32, 32) As Long             'Tile selected by board
    currentTileType As Integer            'The current tile type
    ambient As Long                       'ambient light
    ambientR As Long                      'ambient red
    ambientG As Long                      'ambient green
    ambientB As Long                      'ambient blue
    infoX As Long                         'Dummy x value, used for tile info
    infoY As Long                         'Dummy y value, used for tile info
    drawState As Integer                  'determines drawState 0- draw lock, 1- type lock, 2- program set, 3- itm set
    spotLight As Integer                  'spot lighting on (1)/ off (0)
    spotLightRadius As Double             'Radius of spot light
    percentFade As Double                 'percent fade of boardList(activeBoardIndex).spotLight
    prgCondition As Integer               'conditions the program set window- if -1, then we start a new prg.
    itmCondition As Integer               'conditions the item set window- if -1, then we start a new itm.    theData As TKBoard
    autotiler As Integer                  'is autotiler enabled?
    
End Type


'=========================================================================
' Board clipboard
'=========================================================================
Public Type TKBoardClipboardTile
    file As String
    brdCoord As POINTAPI
    'Colour, tiletype.
End Type

Public Type TKBoardClipboard
    tiles() As TKBoardClipboardTile
    origin As POINTAPI
    vector As CVector
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
    relWidth = absWidth(ed.board(ed.undoIndex).bSizeX, ed.board(ed.undoIndex).coordType) * ed.pCEd.zoom
End Property
Public Property Get relHeight(ByRef ed As TKBoardEditorData) As Integer ': On Error Resume Next
    relHeight = absHeight(ed.board(ed.undoIndex).bSizeY, ed.board(ed.undoIndex).coordType) * ed.pCEd.zoom
End Property

'=========================================================================
' Conversion routines
'=========================================================================
Public Function screenToBoardPixel(ByVal x As Long, ByVal y As Long, ByRef ed As TKBoardEditorData) As POINTAPI
    Call ed.pCEd.screenToBoardPixel(x, y)
    screenToBoardPixel.x = x
    screenToBoardPixel.y = y
End Function
Public Function boardPixelToScreen(ByVal x As Long, ByVal y As Long, ByRef ed As TKBoardEditorData) As POINTAPI
    Call ed.pCEd.boardPixelToScreen(x, y)
    boardPixelToScreen.x = x
    boardPixelToScreen.y = y
End Function
Public Function boardPixelToTile(ByVal x As Long, ByVal y As Long, ByVal coordType As Long, ByVal brdSizeX As Long) As POINTAPI
    ' Remove any PX_ABSOLUTE flag since we specifically want tile values when using this in the editor.
    Call BRDPixelToTile(x, y, coordType And (TILE_NORMAL Or ISO_ROTATED Or ISO_STACKED), brdSizeX)
    boardPixelToTile.x = x
    boardPixelToTile.y = y
End Function
Public Function tileToBoardPixel(ByVal x As Long, ByVal y As Long, ByVal coordType As Long, ByVal brdSizeX As Long, Optional ByVal bIsoRenderPoint As Boolean = False) As POINTAPI
    Call BRDTileToPixel(x, y, coordType And (TILE_NORMAL Or ISO_ROTATED Or ISO_STACKED), brdSizeX)
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

Public Function vectorCreate(ByRef optSetting As eBrdSetting, ByRef board As TKBoard) As CVector  ':on error resume next
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
            Set vectorCreate = board.vectors(i)
        Case BS_PROGRAM
            '.prgs is always dimensioned.
            For i = 0 To UBound(board.prgs)
                If board.prgs(i).vBase.tiletype = TT_NULL Then
                    bFound = True
                    Exit For
                End If
            Next i
            If Not bFound Then
                ReDim Preserve board.prgs(i)
            End If
            Set vectorCreate = board.prgs(i).vBase
    End Select
    
End Function
Public Sub vectorize(ByRef ed As TKBoardEditorData) ': On Error Resume Next

    Dim vects() As TKConvertedVector, i As Long, j As Long, vector As CVector
    ReDim vects(0)
    
    Call BRDVectorize(ed.pCBoard, VarPtr(ed.board(ed.undoIndex)), vects())
    
    For i = 0 To UBound(vects)
        Set vector = vectorCreate(BS_VECTOR, ed.board(ed.undoIndex))
        For j = 0 To UBound(vects(i).pts)
            Call vector.addPoint(vects(i).pts(j).x, vects(i).pts(j).y)
        Next j
        vector.tiletype = vects(i).type
        Call vector.closeVector(Not vects(i).closed, vects(i).layer)
        vector.attributes = vects(i).attributes
    Next i
End Sub
Public Sub upgradeProgram(ByRef prg As TKBoardProgram, ByVal x As Long, ByVal y As Long, ByVal coordType As Long) ':on error resume next
    
    Dim vect As TKConvertedVector, i As Long
    Call BRDTileToVector(VarPtr(vect), x, y, coordType)
    
    For i = 0 To UBound(vect.pts)
        Call prg.vBase.addPoint(vect.pts(i).x, vect.pts(i).y)
    Next i
    prg.vBase.tiletype = vect.type
    Call prg.vBase.closeVector(0, prg.layer)
End Sub

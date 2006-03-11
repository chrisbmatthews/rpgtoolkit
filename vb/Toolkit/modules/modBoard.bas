Attribute VB_Name = "modBoard"
'========================================================================
'All contents copyright 2006 Jonathan D. Hughes
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'========================================================================
Option Explicit

Private Declare Function BRDPixelToTile Lib "actkrt3.dll" (ByRef x As Long, ByRef y As Long, ByVal coordType As Integer, ByVal brdSizeX As Integer) As Long
Private Declare Function BRDTileToPixel Lib "actkrt3.dll" (ByRef x As Long, ByRef y As Long, ByVal coordType As Integer, ByVal brdSizeX As Integer) As Long

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
    BT_MOVE
    BT_UNUSED
    BT_LIST
End Enum
Public Enum eBrdSelectStatus
    SS_NONE
    SS_DRAWING
    SS_FINISHED
End Enum

'=========================================================================
' A board editor document
'=========================================================================
Public Type TKBoardEditorData
    '3.0.7
    ' Following block used by actkrt
    pCBoard As Long                       'pointer to associated CBoard in actkrt
    bLayerOccupied() As Boolean           'layer contains tiles
    bLayerVisible() As Boolean            'layer visibility in the editor
    board As TKBoard                      'actual contents of board
    
    topX As Long                          'top x coord (scaled pixels)
    topY As Long                          'top y coord (scaled pixels)
    zoom As Double                        'scaling factor
    optSetting As eBrdSetting
    optTool As eBrdTool
    selectedTile As String                'Selected tile
    bGrid As Boolean
    bAutotiler As Boolean
    bRevertToDraw As Boolean              'After flooding revert to draw tool
    gridColor As Long
    currentLayer As Integer               'Current board layer
    selectStatus As eBrdSelectStatus      'Status of selection
    selection As RECT                     'selection tool
    selectionColor As Long
    bHideAllLayers As Boolean
    bShowAllLayers As Boolean
    bNeedUpdate As Boolean                'have any changes been made to the board data?
    
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
' Coordinate type enumeration
'=========================================================================
Public Const TILE_NORMAL = 0
Public Const ISO_STACKED = 1              ' (Old) staggered column method.
Public Const ISO_ROTATED = 2              ' x-y axes rotated by 60 / 30 degrees.
Public Const PX_ABSOLUTE = 4              ' Absolute co-ordinates (iso and 2D).

'=========================================================================
' Absolute board pixel dimensions
'=========================================================================
Public Property Get absWidth(ByRef board As TKBoard) As Integer ': On Error Resume Next
    If (board.coordType And ISO_STACKED) Then
        absWidth = board.bSizeX * 64 - 32
    ElseIf (board.coordType And ISO_ROTATED) Then
        absWidth = board.bSizeX * 64 - 32
    Else
        absWidth = board.bSizeX * 32
    End If
End Property
Public Property Get absHeight(ByRef board As TKBoard) As Integer ': On Error Resume Next
    If (board.coordType And ISO_STACKED) Then
        absHeight = board.bSizeY * 16 - 16
    ElseIf (board.coordType And ISO_ROTATED) Then
        absHeight = board.bSizeY * 32
    Else
        absHeight = board.bSizeY * 32
    End If
End Property

'=========================================================================
' Board pixel dimensions relative to zoom
'=========================================================================
Public Property Get relWidth(ByRef ed As TKBoardEditorData) As Integer ': On Error Resume Next
    relWidth = absWidth(ed.board) * ed.zoom
End Property
Public Property Get relHeight(ByRef ed As TKBoardEditorData) As Integer ': On Error Resume Next
    relHeight = absHeight(ed.board) * ed.zoom
End Property

'=========================================================================
' Conversion routines
'=========================================================================
Public Function screenToBoardPixel(ByVal x As Long, ByVal y As Long, ByRef ed As TKBoardEditorData) As POINTAPI
    screenToBoardPixel.x = (x + ed.topX) / ed.zoom
    screenToBoardPixel.y = (y + ed.topY) / ed.zoom
End Function
Public Function boardPixelToTile(ByVal x As Long, ByVal y As Long, ByRef board As TKBoard) As POINTAPI
    Call BRDPixelToTile(x, y, board.coordType, board.bSizeX)
    boardPixelToTile.x = x
    boardPixelToTile.y = y
End Function
Public Function tileToBoardPixel(ByVal x As Long, ByVal y As Long, ByRef board As TKBoard, Optional ByVal bIsoRenderPoint As Boolean = False) As POINTAPI
    Call BRDTileToPixel(x, y, board.coordType, board.bSizeX)
    tileToBoardPixel.x = x
    tileToBoardPixel.y = y
    If isIsometric(board) And bIsoRenderPoint Then
        'BRDTileToPixel() returns the centre of isometric tiles.
        'In rendering instances, the top-left corner of the tile (i.e., the centre of the NW tile) is required.
        tileToBoardPixel.x = x - 32
        tileToBoardPixel.y = y - 16
    End If
End Function
Public Function boardPixelToScreen(ByVal x As Long, ByVal y As Long, ByRef ed As TKBoardEditorData) As POINTAPI
    boardPixelToScreen.x = x * ed.zoom - ed.topX
    boardPixelToScreen.y = y * ed.zoom - ed.topY
End Function

'=========================================================================
' Tile pixel dimensions relative to zoom
'=========================================================================
Public Function tileWidth(ByRef ed As TKBoardEditorData) As Integer ': On Error Resume Next
    tileWidth = IIf(isIsometric(ed.board), 64, 32) * ed.zoom
End Function
Public Function tileHeight(ByRef ed As TKBoardEditorData) As Integer ': On Error Resume Next
    tileHeight = IIf(isIsometric(ed.board), 32, 32) * ed.zoom
End Function
Public Function scrollUnitWidth(ByRef ed As TKBoardEditorData) As Integer ': On Error Resume Next
    scrollUnitWidth = IIf(isIsometric(ed.board), 32, 32) * ed.zoom
End Function
Public Function scrollUnitHeight(ByRef ed As TKBoardEditorData) As Integer ': On Error Resume Next
    scrollUnitHeight = IIf(isIsometric(ed.board), 16, 32) * ed.zoom
End Function

Public Function isIsometric(ByRef board As TKBoard) As Boolean ': On Error Resume Next
    isIsometric = (board.coordType And (ISO_ROTATED Or ISO_STACKED))
End Function

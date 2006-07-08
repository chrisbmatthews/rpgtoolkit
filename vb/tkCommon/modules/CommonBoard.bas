Attribute VB_Name = "Commonboard"
'=========================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=========================================================================

'=========================================================================
'Requires CommonBinaryIO.bas
'Requires CommonTileAnm.bas
'=========================================================================

'=========================================================================
' RPGToolkit board file format (*.brd)
'=========================================================================

Option Explicit

'=========================================================================
' Member variables
'=========================================================================
Private lastAnm As TKTileAnm    'last opened anm file
Private lastAnmFile As String   'last opened anm file name

'=========================================================================
' Member constants
'=========================================================================
Private Const FILE_HEADER = "RPGTLKIT BOARD"

'=========================================================================
' A RPGToolkit board
'=========================================================================
Public Type uTKBoard
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
    animatedTile() As TKBoardAnimTile     'animated tiles associated with this board
    anmTileInsertIdx As Long              'index of animated tile insertion
    anmTileLUTIndices() As Long           'indices into LUT of animated tiles
    anmTileLUTInsertIdx As Long           'index of LUT table insertion
    strFileName As String                 'filename of the board
End Type

'=========================================================================
' A board editor document
'=========================================================================
Public Type boardDoc
    boardName As String                   'filename
    boardNeedUpdate As Boolean            'something changed?
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
    currentLayer As Integer               'Current board layer
    selectedTile As String                'Selected tile (board)
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
    topX As Double                        'top x coord
    topY As Double                        'top y coord
    autotiler As Integer                  'is autotiler enabled?
    theData As TKBoard                    'actual contents of board
End Type

'=========================================================================
' Integral variables
'=========================================================================
Public boardList() As boardDoc            'list of board documents
Public boardListOccupied() As Boolean     'position used?
Public currentBoard As String             'current board
Public tilesX As Double                   'tiles screen can hold on x
Public tilesY As Double                   'tiles screen can hold on y

'=========================================================================
'Enlarge item related arrays
'Called by: BoardInit, openBoard, saveBoard, BoardClear, CreateItemRPG,
'           CBLoadItem, + itemset.frm: Command3_Click (toolkit3)
'=========================================================================
Public Sub dimensionItemArrays(ByRef theBoard As TKBoard)

    With theBoard

        'Check our dimensioning situation
        On Error GoTo needsDim

        'Get upper bound
        Dim ub As Long
        ub = UBound(.itmName) + 1

        On Error Resume Next

        ReDim Preserve .itmActivate(ub)
        ReDim Preserve .itmActivateDoneNum(ub)
        ReDim Preserve .itmActivateInitNum(ub)
        ReDim Preserve .itmActivationType(ub)
        ReDim Preserve .itmDoneVarActivate(ub)
        ReDim Preserve .itmLayer(ub)
        ReDim Preserve .itmName(ub)
        ReDim Preserve .itmVarActivate(ub)
        ReDim Preserve .itmX(ub)
        ReDim Preserve .itmY(ub)
        ReDim Preserve .itemMulti(ub)
        ReDim Preserve .itemProgram(ub)

#If (isToolkit = 0) Then
        'If we're just opening the board for other information, this isn't
        'the activeboard and we don't need to do this (nor do we want to redim
        'the itmPos and itmMem arrays! - items may disappear!).
        If (VarPtr(boardList(activeBoardIndex).theData) = VarPtr(theBoard)) Then
            ReDim Preserve itemMem(ub)
            ReDim Preserve itmPos(ub)
        End If
#End If

    End With

needsDim:
    If ub = 1 Then ub = 0
    Resume Next

End Sub

'=========================================================================
' Add an animated tile to the board
'=========================================================================
Public Sub BoardAddTileAnmRef(ByRef theBoard As TKBoard, ByVal file As String, ByVal x As Long, ByVal y As Long, ByVal layer As Long)
    On Error Resume Next
    'add a reference to an animated tile to this board
    
    'check size of container...
    Dim sz As Long
    
    If theBoard.anmTileInsertIdx + 1 > UBound(theBoard.animatedTile) Then
        sz = UBound(theBoard.animatedTile) * 2
        ReDim Preserve theBoard.animatedTile(sz)
    End If
    
    'add tile...
    
    If UCase$(lastAnmFile) <> UCase$(file) Then
        Call openTileAnm(projectPath & tilePath & file, lastAnm)
        lastAnmFile = file
    End If
    theBoard.animatedTile(theBoard.anmTileInsertIdx).theTile = lastAnm
    theBoard.animatedTile(theBoard.anmTileInsertIdx).x = x
    theBoard.animatedTile(theBoard.anmTileInsertIdx).y = y
    theBoard.animatedTile(theBoard.anmTileInsertIdx).layer = layer
    
    theBoard.anmTileInsertIdx = theBoard.anmTileInsertIdx + 1
End Sub

'=========================================================================
' Add an animated tile to the look up table (LUT)
'=========================================================================
Public Sub BoardAddTileAnmLUTRef(ByRef theBoard As TKBoard, ByVal idx As Long)
    On Error Resume Next
    'add a reference to an animated tile to this board
    
    'check size of container...
    Dim sz As Long
    
    If theBoard.anmTileLUTInsertIdx + 1 > UBound(theBoard.anmTileLUTIndices) Then
        sz = UBound(theBoard.anmTileLUTIndices) * 2
        ReDim Preserve theBoard.anmTileLUTIndices(sz)
    End If
    
    'add tile...
    theBoard.anmTileLUTIndices(theBoard.anmTileLUTInsertIdx) = idx
    
    theBoard.anmTileLUTInsertIdx = theBoard.anmTileLUTInsertIdx + 1
End Sub

'=========================================================================
' Find the number of consective tiles
'=========================================================================
Public Function BoardFindConsecutive(ByRef x As Integer, ByRef y As Integer, ByRef l As Integer, ByRef theBoard As TKBoard) As Long
    'find the number of consecutive identical tiles there are
    'starting at x, y, l
    'return 1 if there's only the one, else return the number of consecutive tiles
    '(inclusive of the first one).
    'also return the next x, y, l position in the for-loops after determining this (byref)
    On Error Resume Next

    Dim theTile As String
    Dim theRed As Long, theGreen As Long, theBlue As Long, theType As Long
    
    theTile = theBoard.board(x, y, l)
    theRed = theBoard.ambientRed(x, y, l)
    theGreen = theBoard.ambientGreen(x, y, l)
    theBlue = theBoard.ambientBlue(x, y, l)
    theType = theBoard.tiletype(x, y, l)
    
    Dim count As Long, sx As Long, sy As Long, sl As Long
    Dim ll As Long, yy As Long, xx As Long
    
    count = 0
    
    sx = x
    sy = y
    sl = l
    
    'now finf the consecutive similar ones...
    For ll = sl To theBoard.bSizeL
        For yy = sy To theBoard.bSizeY
            For xx = sx To theBoard.bSizeX
                sx = 1: sy = 1: sl = 1
                If theBoard.board(xx, yy, ll) <> theTile Or _
                    theBoard.ambientRed(xx, yy, ll) <> theRed Or _
                    theBoard.ambientGreen(xx, yy, ll) <> theGreen Or _
                    theBoard.ambientBlue(xx, yy, ll) <> theBlue Or _
                    theBoard.tiletype(xx, yy, ll) <> theType Then
                    'does not match-- return!
                    x = xx: y = yy: l = ll
                    BoardFindConsecutive = count
                    Exit Function
                Else
                    count = count + 1
                    If count > 30000 Then
                        x = xx: y = yy: l = ll
                        BoardFindConsecutive = count - 1
                        Exit Function
                    End If
                End If
            Next xx
        Next yy
    Next ll
    
    x = xx
    y = yy
    l = ll
    BoardFindConsecutive = count
End Function

'=========================================================================
' Resize the board
'=========================================================================
Public Sub BoardResize(ByVal newX As Integer, ByVal newY As Integer, ByVal newLayer As Integer, ByRef theBoard As TKBoard)
    'resize the board-- retain the current tiles
    On Error Resume Next
    Dim sizex As Long, sizey As Long, sizeLayer As Long
    
    sizex = newX
    sizey = newY
    sizeLayer = newLayer
    
    'create backup...
    ReDim brd(theBoard.bSizeX, theBoard.bSizeY, theBoard.bSizeL) As Integer
    ReDim r(theBoard.bSizeX, theBoard.bSizeY, theBoard.bSizeL) As Integer
    ReDim g(theBoard.bSizeX, theBoard.bSizeY, theBoard.bSizeL) As Integer
    ReDim b(theBoard.bSizeX, theBoard.bSizeY, theBoard.bSizeL) As Integer
    ReDim t(theBoard.bSizeX, theBoard.bSizeY, theBoard.bSizeL) As Byte
    
    Dim x As Long, y As Long, l As Long
    
    For x = 0 To theBoard.bSizeX
        For y = 0 To theBoard.bSizeY
            For l = 0 To theBoard.bSizeL
                brd(x, y, l) = theBoard.board(x, y, l)
                r(x, y, l) = theBoard.ambientRed(x, y, l)
                g(x, y, l) = theBoard.ambientGreen(x, y, l)
                b(x, y, l) = theBoard.ambientBlue(x, y, l)
                t(x, y, l) = theBoard.tiletype(x, y, l)
            Next l
        Next y
    Next x
    
    'resize...
    ReDim theBoard.board(sizex, sizey, sizeLayer)
    ReDim theBoard.ambientRed(sizex, sizey, sizeLayer)
    ReDim theBoard.ambientGreen(sizex, sizey, sizeLayer)
    ReDim theBoard.ambientBlue(sizex, sizey, sizeLayer)
    ReDim theBoard.tiletype(sizex, sizey, sizeLayer)
    
    Dim xx As Long, yy As Long, ll As Long
    
    If sizex < theBoard.bSizeX Then xx = sizex Else xx = theBoard.bSizeX
    If sizey < theBoard.bSizeY Then yy = sizey Else yy = theBoard.bSizeY
    If sizeLayer < theBoard.bSizeL Then ll = sizeLayer Else ll = theBoard.bSizeL
    
    'now fill it in with the old info...
    For x = 0 To xx
        For y = 0 To yy
            For l = 0 To ll
                theBoard.board(x, y, l) = brd(x, y, l)
                theBoard.ambientRed(x, y, l) = r(x, y, l)
                theBoard.ambientGreen(x, y, l) = g(x, y, l)
                theBoard.ambientBlue(x, y, l) = b(x, y, l)
                theBoard.tiletype(x, y, l) = t(x, y, l)
            Next l
        Next y
    Next x
    
    theBoard.bSizeX = sizex
    theBoard.bSizeY = sizey
    theBoard.bSizeL = sizeLayer
End Sub

'=========================================================================
' Find a file in the look up table
'=========================================================================
Public Function BoardTileInLUT(ByVal filename As String, ByRef theBoard As TKBoard) As Long
    'return the index in the LUT where filename exists
    On Error Resume Next
    
    'first scan the look up table for filenames...
    Dim bWasSet As Boolean, t As Long
    bWasSet = False
    For t = 0 To UBound(theBoard.tileIndex)
        If LCase$(filename) = theBoard.tileIndex(t) Then
            'found it in lookup table...
            BoardTileInLUT = t
            bWasSet = True
            Exit For
        End If
    Next t
    
    Dim bFoundPos As Boolean
    bFoundPos = False
    If Not (bWasSet) Then
        'it wasn't found in the lookup table.
        'we have to add it to the lookup table...
        'first, find an empty slot...
        For t = 1 To UBound(theBoard.tileIndex)
            If (LenB(theBoard.tileIndex(t)) = 0) Then
                'found a position!
                theBoard.tileIndex(t) = LCase$(filename)
                BoardTileInLUT = t
                bFoundPos = True
                Exit For
            End If
        Next t
        
        If Not (bFoundPos) Then
            'no empty slots found-- make the array bigger!
            Dim newSize As Long, insertPos As Long
            newSize = UBound(theBoard.tileIndex) * 2
            insertPos = UBound(theBoard.tileIndex) + 1
            ReDim Preserve theBoard.tileIndex(newSize)
            theBoard.tileIndex(insertPos) = LCase$(filename)
            BoardTileInLUT = insertPos
        End If
    End If
End Function

'=========================================================================
' Get a board's size
'=========================================================================
Public Sub boardSize(ByRef fName As String, ByRef x As Long, ByRef y As Long)

    '// Passing fName ByRef for speed reasons

    On Error Resume Next

    Dim fileOpen As String, xx As Long, yy As Long, num As Long

    fileOpen$ = fName$
    fileOpen$ = PakLocate(fileOpen$)
    xx = 19: yy = 11
    num = FreeFile
    Open fileOpen For Binary Access Read As num
        Dim b As Byte
        Get num, 15, b
        If (b) Then
            Close #num
            GoTo ver2oldboard
        End If
    Close num

    Dim fileHeader As String, majorVer As Long, minorVer As Long, regYN As Long, regCode As String, l As Long
    Open fileOpen For Binary As #num
        fileHeader$ = BinReadString(num)      'Filetype
        'If fileheader$ <> "RPGTLKIT BOARD" Then Close #num: GoTo Ver1Board
        majorVer = BinReadInt(num)       'Version
        minorVer = BinReadInt(num)      'Minor version (ie 2.0)

        If minorVer < 2 Then
            Close #num
            GoTo ver2oldboard
        End If
        
        regYN = BinReadInt(num)     'Is it registered?
        regCode$ = BinReadString(num)            'reg code
        
        'new style boards.
        'first is the board size...
        x = BinReadInt(num)
        y = BinReadInt(num)
        l = BinReadInt(num)
    Close #num
    Exit Sub
    
ver2oldboard:
    Dim isRegistered As String
    Open fileOpen$ For Input As #num
        Input #num, fileHeader$        'Filetype
        If fileHeader$ <> "RPGTLKIT BOARD" Then
            Close #num
            x = 19: y = 11
            Exit Sub
        End If
        Input #num, majorVer           'Version
        Input #num, minorVer           'Minor version (ie 2.0)
        If majorVer <> major Then MsgBox "This board was created with an unrecognised version of the Toolkit", , "Unable to open tile": Exit Sub
        Input #num, isRegistered$         'Is it registered?
        Input #num, regCode$              'reg code
        'Next up0 is the board data.  It goes: tilename, boardList(activeBoardIndex).ambientr, ag, ab, tiletype fopr each tile y's then x's, layer by layer
        
        If minorVer = 1 Then
            Input #num, xx          'size x
            Input #num, yy          'size y
        End If
        If minorVer = 0 Then
            xx = 19
            yy = 11
        End If
    Close #num
    x = xx: y = yy
End Sub

'=========================================================================
' Clear a board structure. Called by open board only (trans3).
'=========================================================================
Public Sub BoardClear(ByRef theBoard As TKBoard): On Error Resume Next

    Dim i As Long
    
    With theBoard
        '3.0.7
        ReDim .vectors(0)
        Set .vectors(0) = Nothing
        ReDim .prgs(0)
        Set .prgs(0) = Nothing
        ReDim .Images(0)
        .Images(0).drawType = BI_NULL
        ReDim .sprites(0)
        Set .sprites(0) = Nothing
        ReDim .spriteImages(0)

        'Pre 3.0.7
        ReDim .tileIndex(5)
        Dim x As Long, y As Long, layer As Long, t As Long
        Call dimensionItemArrays(theBoard)
        For x = 0 To .bSizeX
            For y = 0 To .bSizeY
                For layer = 0 To .bSizeL
                    .board(x, y, layer) = 0
                    .ambientRed(x, y, layer) = 0
                    .ambientGreen(x, y, layer) = 0
                    .ambientBlue(x, y, layer) = 0
                    .tiletype(x, y, layer) = 0
                Next layer
            Next y
        Next x
        .brdBack = vbNullString
        .borderBack = vbNullString
        .brdColor = RGB(255, 255, 255)
        .borderColor = 0
        .ambientEffect = 0
        For t = 0 To 4
            .dirLink(t) = vbNullString
        Next t
        .boardSkill = 0
        .boardBackground = vbNullString
        .fightingYN = 0
        For t = 0 To 10
            .brdConst(t) = 0
        Next t
        .boardMusic = vbNullString
        For t = 0 To 8
            .boardTitle(t) = vbNullString
        Next t
        For t = 0 To UBound(boardList(activeBoardIndex).theData.programName)
            .programName(t) = vbNullString
            .progX(t) = 0
            .progY(t) = 0
            .progLayer(t) = 0
            .progGraphic(t) = vbNullString
            .progActivate(t) = 0
            .progVarActivate(t) = vbNullString
            .progDoneVarActivate(t) = vbNullString
            .activateInitNum(t) = vbNullString
            .activateDoneNum(t) = vbNullString
            .activationType(t) = 0
        Next t
        .enterPrg = vbNullString
        .bgPrg = vbNullString
        For t = 0 To UBound(.itemMulti)
            .itmName(t) = vbNullString
            .itmX(t) = 0
            .itmY(t) = 0
            .itmLayer(t) = 0
            .itmActivate(t) = 0
            .itmVarActivate(t) = vbNullString
            .itmDoneVarActivate(t) = vbNullString
            .itmActivateInitNum(t) = vbNullString
            .itmActivateDoneNum(t) = vbNullString
            .itmActivationType(t) = 0
            .itemProgram(t) = vbNullString
            .itemMulti(t) = vbNullString
        Next t
        .playerX = 1                'Set an initial location in case people neglect to.
        .playerY = 1
        .playerLayer = 1
        .brdSavingYN = 0
        .bSizeX = UBound(.board, 1)
        .bSizeY = UBound(.board, 2)
        .bSizeL = UBound(.board, 3)
        .BoardDayNight = 0
        .BoardNightBattleOverride = 0
        .BoardSkillNight = 0
        .BoardBackgroundNight = vbNullString
        .isIsometric = 0
        ReDim .Threads(0)
        'ReDim .animatedTile(10)
        ReDim .anmTileLUTIndices(10)
        .anmTileLUTInsertIdx = 0
        .anmTileInsertIdx = 0
        .hasAnmTiles = False
    End With
End Sub

'=========================================================================
' Save a board to file
'=========================================================================
Public Sub saveBoard(ByVal filename As String, ByRef theBoard As TKBoard)

    On Error Resume Next

    Dim num As Long, t As Long, l As Long, x As Long, y As Long

    num = FreeFile()

    Const majVer = 2
    Const minVer = 2

    Call Kill(filename)

    Open filename For Binary Access Write As num
        Call BinWriteString(num, "RPGTLKIT BOARD")    'Filetype
        Call BinWriteInt(num, major)
        Call BinWriteInt(num, 3)    'Minor version (ie 2.2 new type, allowing large boards)
        Call BinWriteInt(num, 1)
        Call BinWriteString(num, "NOCODE")            'No reg code

        'first is the board size...
        Call BinWriteInt(num, theBoard.bSizeX)
        Call BinWriteInt(num, theBoard.bSizeY)
        Call BinWriteInt(num, theBoard.bSizeL)
    
        'now some player and saving info...
        Call BinWriteInt(num, theBoard.playerX)            'player x ccord
        Call BinWriteInt(num, theBoard.playerY)           'player y coord
        Call BinWriteInt(num, theBoard.playerLayer)        'player layer coord
        Call BinWriteInt(num, theBoard.brdSavingYN)        'can player save on board? 0-yes, 1-no
    
        'now the look-up table for the tiles...
        'first the size of the LUT
        Call BinWriteInt(num, UBound(theBoard.tileIndex))
        For t = 0 To UBound(theBoard.tileIndex)
            Call BinWriteString(num, theBoard.tileIndex(t))
        Next t
        'now the board tiles...
        For l = 1 To theBoard.bSizeL
            For y = 1 To theBoard.bSizeY
                For x = 1 To theBoard.bSizeX
                    Dim x2 As Integer, y2 As Integer, l2 As Integer
                    x2 = x: y2 = y: l2 = l
                    Dim rep As Long
                    rep = BoardFindConsecutive(x2, y2, l2, theBoard)
                    If rep > 1 Then
                        'found something we can compress (using RLE)
                        'first output the number of repeats (using a negative number
                        'to denote compression)...
                        rep = rep * -1
                        Call BinWriteInt(num, rep)
                        'now write out the board data...
                        Call BinWriteInt(num, theBoard.board(x, y, l))   'board tiles -- codes indicating where the tiles are on the board
                        Call BinWriteInt(num, theBoard.ambientRed(x, y, l))  'board tiles -- codes indicating where the tiles are on the board
                        Call BinWriteInt(num, theBoard.ambientGreen(x, y, l))   'board tiles -- codes indicating where the tiles are on the board
                        Call BinWriteInt(num, theBoard.ambientBlue(x, y, l))   'board tiles -- codes indicating where the tiles are on the board
                        Call BinWriteByte(num, theBoard.tiletype(x, y, l))   'board tiles -- codes indicating where the tiles are on the board
                        'set the new x, y, l...
                        x2 = x2 - 1
                        x = x2: y = y2: l = l2
                    Else
                        'no repetitions-- just write as normal...
                        Call BinWriteInt(num, theBoard.board(x, y, l))   'board tiles -- codes indicating where the tiles are on the board
                        Call BinWriteInt(num, theBoard.ambientRed(x, y, l))  'board tiles -- codes indicating where the tiles are on the board
                        Call BinWriteInt(num, theBoard.ambientGreen(x, y, l))   'board tiles -- codes indicating where the tiles are on the board
                        Call BinWriteInt(num, theBoard.ambientBlue(x, y, l))   'board tiles -- codes indicating where the tiles are on the board
                        Call BinWriteByte(num, theBoard.tiletype(x, y, l))   'board tiles -- codes indicating where the tiles are on the board
                    End If
                Next x
            Next y
        Next l
        Call BinWriteString(num, theBoard.brdBack)      'board background img (parallax layer)
        Call BinWriteString(num, theBoard.brdFore)      'board foreground image (parallax)
        Call BinWriteString(num, theBoard.borderBack)   'border background img
        Call BinWriteLong(num, theBoard.brdColor)    'board color
        Call BinWriteLong(num, theBoard.borderColor)    'Border color
        Call BinWriteInt(num, theBoard.ambientEffect) 'boardList(activeBoardIndex).ambient effect applied to the board 0- none, 1- fog, 2- darkness, 3- watery
        For t = 1 To 4
            Call BinWriteString(num, theBoard.dirLink(t)) 'Direction links 1- N, 2- S, 3- E, 4-W
        Next t
        Call BinWriteInt(num, theBoard.boardSkill) 'Board skill level
        Call BinWriteString(num, theBoard.boardBackground) 'Fighting background
        Call BinWriteInt(num, theBoard.fightingYN)  'Fighting on boardYN (1- yes, 0- no)
        Call BinWriteInt(num, theBoard.BoardDayNight) 'board is affected by day/night? 0=no, 1=yes
        Call BinWriteInt(num, theBoard.BoardNightBattleOverride) 'use custom battle options at night? 0=no, 1=yes
        Call BinWriteInt(num, theBoard.BoardSkillNight) 'Board skill level at night
        Call BinWriteString(num, theBoard.BoardBackgroundNight) 'Fighting background at night
        For t = 0 To 10
            Call BinWriteInt(num, theBoard.brdConst(t)) 'Board Constants (1-10)
        Next t
        Call BinWriteString(num, theBoard.boardMusic) 'Background music file
        For t = 0 To 8
            Call BinWriteString(num, theBoard.boardTitle(t)) 'Board title (layer)
        Next t
        
        Call BinWriteInt(num, UBound(theBoard.programName))  'number of programs on the board...
        For t = 0 To UBound(theBoard.programName)
            Call BinWriteString(num, theBoard.programName(t)) 'Board program filenameames
            Call BinWriteInt(num, theBoard.progX(t))   'program x
            Call BinWriteInt(num, theBoard.progY(t))   'program y
            Call BinWriteInt(num, theBoard.progLayer(t)) 'program layer
            Call BinWriteString(num, theBoard.progGraphic(t)) 'program graphic
            Call BinWriteInt(num, theBoard.progActivate(t)) 'program activation: 0- always active, 1- conditional activation.
            Call BinWriteString(num, theBoard.progVarActivate(t)) 'activation variable
            Call BinWriteString(num, theBoard.progDoneVarActivate(t)) 'activation variable at end of prg.
            Call BinWriteString(num, theBoard.activateInitNum(t)) 'initial number of activation
            Call BinWriteString(num, theBoard.activateDoneNum(t)) 'what to make variable at end of activation.
            Call BinWriteInt(num, theBoard.activationType(t)) 'activation type- 0-step on, 1- conditional (activation key)
        Next t
        Call BinWriteString(num, theBoard.enterPrg)     'program to run on entrance''''''''''''''''''
        Call BinWriteString(num, theBoard.bgPrg)       'background program

        Call dimensionItemArrays(theBoard)
        Call BinWriteInt(num, UBound(theBoard.itmName))   'number of items on the board...
        For t = 0 To UBound(theBoard.itmName)
            Call BinWriteString(num, theBoard.itmName(t))   'filenameames of items
            Call BinWriteInt(num, theBoard.itmX(t))     'x coord
            Call BinWriteInt(num, theBoard.itmY(t))     'y coord
            Call BinWriteInt(num, theBoard.itmLayer(t)) 'layer coord
            Call BinWriteInt(num, theBoard.itmActivate(t)) 'itm activation: 0- always active, 1- conditional activation.
            Call BinWriteString(num, theBoard.itmVarActivate(t)) 'activation variable
            Call BinWriteString(num, theBoard.itmDoneVarActivate(t)) 'activation variable at end of itm.
            Call BinWriteString(num, theBoard.itmActivateInitNum(t)) 'initial number of activation
            Call BinWriteString(num, theBoard.itmActivateDoneNum(t)) 'what to make variable at end of activation.
            Call BinWriteInt(num, theBoard.itmActivationType(t)) 'activation type- 0-step on, 1- conditional (activation key)
            Call BinWriteString(num, theBoard.itemProgram(t))    'program to run when item is touched.
            Call BinWriteString(num, theBoard.itemMulti(t))     'multitask program for item
        Next t

        Call BinWriteLong(num, UBound(theBoard.Threads))
        For t = 0 To UBound(theBoard.Threads)
            Call BinWriteString(num, theBoard.Threads(t))
        Next t

        Call BinWriteByte(num, theBoard.isIsometric)

    Close num

End Sub

'=========================================================================
' Open a board
'=========================================================================
Public Function openBoard(ByVal fileOpen As String, ByRef ed As TKBoardEditorData, ByRef board As TKBoard)

    On Error GoTo loadBrdErr
    
    Call BoardClear(board)
    Call BoardSetSize(50, 50, 8, ed, board)

    With board

        .bSizeX = 50
        .bSizeY = 50
        .bSizeL = 8
    
        boardList(activeBoardIndex).boardNeedUpdate = False

        fileOpen = PakLocate(fileOpen)
        currentBoard = fileOpen ' Potential problems here
    
        .strFileName = RemovePath(fileOpen)
    
        Dim num As Long, fileHeader As String, majorVer As Long, minorVer As Long, user As Long
        Dim regYN As Long, regCode As String, loopControl As Long

        num = FreeFile()

        'Check if we have a v3 or v2 board
        Open fileOpen For Binary As num
            Dim b As Byte
            Get num, 15, b
            If (b) Then
                Close num
                GoTo ver2oldboard
            End If
        Close num

        Open fileOpen For Binary As #num

            fileHeader$ = BinReadString(num)      'Filetype
            If fileHeader$ <> "RPGTLKIT BOARD" Then Close #num: GoTo Ver1Board
            majorVer = BinReadInt(num)       'Version
            minorVer = BinReadInt(num)      'Minor version (ie 2.0)
            If majorVer <> major Then MsgBox "This board was created with an unrecognised version of the Toolkit " + fileOpen, , "Unable to open tile": Exit Function
            'If minorVer > 2 Then
            '    Call MsgBox("There may be trouble opening this board; save it in the editor to resolve this.")
            'End If
            If minorVer < 2 Then
                Close #num
                GoTo ver2oldboard
            End If

            regYN = BinReadInt(num)     'Is it registered?
            regCode$ = BinReadString(num)            'reg code
        
            'new style boards.
            'first is the board size...
            .bSizeX = BinReadInt(num)
            .bSizeY = BinReadInt(num)
            .bSizeL = BinReadInt(num)
            Call BoardSetSize(.bSizeX, .bSizeY, .bSizeL, ed, board)
            
            '3.0.7 wip
            ReDim ed.bLayerOccupied(.bSizeL + 1)

            'now some player and saving info...
            .playerX = BinReadInt(num)            'player x ccord
            .playerY = BinReadInt(num)           'player y coord
            .playerLayer = BinReadInt(num)        'player layer coord
            .brdSavingYN = BinReadInt(num)        'can player save on board? 0-yes, 1-no
    
            'now the look-up table for the tiles...
            'first the size of the LUT
            Dim lutSize As Long, t As Long, Temp As String, ex As String
        
            lutSize = BinReadInt(num)
            ReDim .tileIndex(lutSize)
            For t = 0 To UBound(.tileIndex)
                .tileIndex(t) = BinReadString(num)
                Temp$ = .tileIndex(t)
            
                'scan for animated tiles
                If LenB(Temp$) Then
                    ex$ = GetExt(Temp$)
                    If UCase$(ex$) = "TAN" Then
                        Call BoardAddTileAnmLUTRef(board, t)
                        .hasAnmTiles = True
                    End If
                End If
            
                #If isToolkit = 1 Then
                    Dim pakFileRunning As Boolean
                #End If
            
                If LenB(Temp$) And pakFileRunning Then
                    'do check for pakfile system
                    'ex$ = GetExt(temp$)
                    'ex$ = Left$(ex$, 3)
                    If Left$(UCase$(ex$), 3) = "TST" Then
                        'numof = getTileNum(temp$)
                        Temp$ = tilesetFilename(Temp$)
                    End If
                    'PakLocate (tilePath & Temp$)
                End If
            Next t

            'now the board tiles...
            Dim l As Long, y As Long, x As Long
            For l = 1 To .bSizeL
                For y = 1 To .bSizeY
                    For x = 1 To .bSizeX
                        Dim test As Integer
                        test = BinReadInt(num)
                        If test < 0 Then
                            test = Abs(test)
                            Dim bb As Long, rr As Long, gg As Long, bl As Long, tt As Long, cnt As Long
                            bb = BinReadInt(num)   'board tiles -- codes indicating where the tiles are on the board
                            rr = BinReadInt(num) 'ambiebnt tile red
                            gg = BinReadInt(num) 'boardList(activeBoardIndex).ambient tile green
                            bl = BinReadInt(num) 'boardList(activeBoardIndex).ambient tile blue
                            tt = BinReadByte(num)  'tile types 0- Normal, 1- solid 2- Under, 3- NorthSouth normal, 4- EastWest Normal, 11- Elevate to level 1, 12- Elevate to level 2... 18- Elevate to level 8
                            
                            'Determine if the layer contains tiles.
                            '(0) indicates if the whole board contains tiles. 3.0.7 wip
                            If (bb) Then
                                ed.bLayerOccupied(l) = True
                                ed.bLayerOccupied(0) = True
                            End If
                    
                            For cnt = 1 To test
                                .board(x, y, l) = bb   'board tiles -- codes indicating where the tiles are on the board
                                .ambientRed(x, y, l) = rr 'ambiebnt tile red
                                .ambientGreen(x, y, l) = gg 'boardList(activeBoardIndex).ambient tile green
                                .ambientBlue(x, y, l) = bl 'boardList(activeBoardIndex).ambient tile blue
                                .tiletype(x, y, l) = tt  'tile types 0- Normal, 1- solid 2- Under, 3- NorthSouth normal, 4- EastWest Normal, 11- Elevate to level 1, 12- Elevate to level 2... 18- Elevate to level 8
                                Dim tAnm As Long
                                'check tile type for animations
                                For tAnm = 0 To .anmTileLUTInsertIdx - 1
                                    If .board(x, y, l) = .anmTileLUTIndices(tAnm) Then
                                        'this is an animated tile
                                        Call BoardAddTileAnmRef(board, .tileIndex(.board(x, y, l)), x, y, l)
                                    End If
                                Next tAnm
                                x = x + 1
                                If x > .bSizeX Then
                                    x = 1
                                    y = y + 1
                                    If y > .bSizeY Then
                                        y = 1
                                        l = l + 1
                                        If l > .bSizeL Then
                                            GoTo exitTheFor
                                        End If
                                        'Onto next layer. 3.0.7 wip
                                        If (bb) Then ed.bLayerOccupied(l) = True
                                    End If
                                End If
                            Next cnt
                            x = x - 1
                        Else
                            If (test) Then '3.0.7 wip
                                ed.bLayerOccupied(l) = True
                                ed.bLayerOccupied(0) = True
                            End If
                            
                            .board(x, y, l) = test   'board tiles -- codes indicating where the tiles are on the board
                            .ambientRed(x, y, l) = BinReadInt(num) 'ambiebnt tile red
                            .ambientGreen(x, y, l) = BinReadInt(num) 'boardList(activeBoardIndex).ambient tile green
                            .ambientBlue(x, y, l) = BinReadInt(num) 'boardList(activeBoardIndex).ambient tile blue
                            .tiletype(x, y, l) = BinReadByte(num)  'tile types 0- Normal, 1- solid 2- Under, 3- NorthSouth normal, 4- EastWest Normal, 11- Elevate to level 1, 12- Elevate to level 2... 18- Elevate to level 8
                    
                            'check tile type for animations
                            For tAnm = 0 To .anmTileLUTInsertIdx - 1
                                If .board(x, y, l) = .anmTileLUTIndices(tAnm) Then
                                    'this is an animated tile
                                    Call BoardAddTileAnmRef(board, .tileIndex(.board(x, y, l)), x, y, l)
                                End If
                            Next tAnm
                        End If
                    Next x
                Next y
            Next l
exitTheFor:
            .brdBack = BinReadString(num)      'board background img (parallax layer)
            .brdFore = BinReadString(num)      'board foreground image (parallax)
            .borderBack = BinReadString(num)   'border background img
            .brdColor = BinReadLong(num)    'board color
            .borderColor = BinReadLong(num)    'Border color
            .ambientEffect = BinReadInt(num) 'boardList(activeBoardIndex).ambient effect applied to the board 0- none, 1- fog, 2- darkness, 3- watery
            For t = 1 To 4
                .dirLink(t) = BinReadString(num)  'Direction links 1- N, 2- S, 3- E, 4-W
            Next t
            .boardSkill = BinReadInt(num) 'Board skill level
            .boardBackground = BinReadString(num) 'Fighting background
            .fightingYN = BinReadInt(num)  'Fighting on boardYN (1- yes, 0- no)
            .BoardDayNight = BinReadInt(num) 'board is affected by day/night? 0=no, 1=yes
            .BoardNightBattleOverride = BinReadInt(num) 'use custom battle options at night? 0=no, 1=yes
            .BoardSkillNight = BinReadInt(num) 'Board skill level at night
            .BoardBackgroundNight = BinReadString(num) 'Fighting background at night
            For t = 0 To 10
                .brdConst(t) = BinReadInt(num)  'Board Constants (1-10)
            Next t
            .boardMusic = BinReadString(num) 'Background music file
            For t = 0 To 8
                .boardTitle(t) = BinReadString(num)  'Board title (layer)
            Next t
            
            '3.0.7 wip - load into CBoardProgram structures.
            Dim numPrg As Long, ubPrgs As Long
            numPrg = BinReadInt(num)    'ubound on number of programs written to file.
            
            For t = 0 To numPrg
                '3.0.7 wip - load into CBoardProgram structure instead.
                Dim prg As CBoardProgram
                Set prg = New CBoardProgram
                prg.filename = BinReadString(num)       'Board program filenames
                x = BinReadInt(num)                     'program x
                y = BinReadInt(num)                     'program y
                prg.layer = BinReadInt(num)             'program layer
                prg.graphic = BinReadString(num)        'program graphic
                prg.activate = BinReadInt(num)          'program activation: 0- always active, 1- conditional activation.
                prg.initialVar = BinReadString(num)     'activation variable
                prg.finalVar = BinReadString(num)       'activation variable at end of prg.
                prg.initialValue = BinReadString(num)   'initial number of activation
                prg.finalValue = BinReadString(num)     'what to make variable at end of activation.
                prg.activationType = BinReadInt(num)    'activation type- 0-step on, 1- conditional (activation key)
               
                If (prg.filename <> vbNullString) Then
                    ReDim Preserve .prgs(ubPrgs)
                    Set .prgs(ubPrgs) = prg
                    ' Hold the position in the CVector until the coordtype byte is read.
                    .prgs(ubPrgs).vBase.deletePoints
                    Call .prgs(ubPrgs).vBase.addPoint(x, y)
                    ubPrgs = ubPrgs + 1
                End If
                Set prg = Nothing
            Next t
            .enterPrg = BinReadString(num)      'program to run on entrance
            .bgPrg = BinReadString(num)         'background program
            
            On Error Resume Next
            
            '3.0.7 wip - load into TKBoardSprite structures.
            Dim numItm As Long, ubSprs As Long
            numItm = BinReadInt(num)            'The number of written item slots.
            
            ''Dimension the arrays of this board *not* the activeboard.
            'ReDim .itmName(0)
            'Call dimensionItemArrays(board)
            
            For t = 0 To numItm
                Dim spr As CBoardSprite, filename As String
                Set spr = New CBoardSprite
            
                filename = BinReadString(num)           'activeBoard.spriteUpdateImageData assigns to spr
                spr.x = BinReadInt(num)                 'x coord
                spr.y = BinReadInt(num)                 'y coord
                spr.layer = BinReadInt(num)             'layer coord
                spr.activate = BinReadInt(num)          'itm activation: 0- always active, 1- conditional activation.
                spr.initialVar = BinReadString(num)     'activation variable
                spr.finalVar = BinReadString(num)       'activation variable at end of itm.
                spr.initialValue = BinReadString(num)   'initial number of activation
                spr.finalValue = BinReadString(num)     'what to make variable at end of activation.
                spr.activationType = BinReadInt(num)    'activation type- 0-step on, 1- conditional (activation key)
                spr.prgActivate = BinReadString(num)    'program to run when item is touched.
                spr.prgMultitask = BinReadString(num)   'multitask program for item
                If LenB(filename) Then
                    ReDim Preserve .sprites(ubSprs)
                    ReDim Preserve .spriteImages(ubSprs)
                    Set .sprites(ubSprs) = spr
                    Call activeBoard.spriteUpdateImageData(spr, itmPath & filename)
                    ubSprs = ubSprs + 1
                End If
            Next t

            Dim tCount As Long

            'Read in threads
            If (minorVer >= 3) Then
                tCount = BinReadLong(num)
                ReDim .Threads(tCount)
                For t = 0 To tCount
                    .Threads(t) = BinReadString(num)
                Next t
            End If

            'Read in isometrics
            .isIsometric = BinReadByte(num)
            '3.0.7 wip
            .coordType = .isIsometric

            If (minorVer < 3) Then
                'Read in threads
                Do Until EOF(num)
                    ReDim Preserve .Threads(tCount)
                    .Threads(tCount) = BinReadString(num)
                    tCount = tCount + 1
                Loop
            End If

        Close num
        
        '3.0.7 wip - generate program bases after coordinate type is read.
        Dim i As Long
        For i = 0 To UBound(.prgs)
            If .prgs(i).filename <> vbNullString Then
                Call .prgs(i).vBase.getPoint(0, x, y)
                Call .prgs(i).vBase.deletePoints
                Call upgradeProgram(.prgs(i), x, y, .coordType)
            End If
        Next i
        
        '3.0.7 update item locations to pixel values.
        For i = 0 To UBound(.sprites)
            Dim pt As POINTAPI
            pt = modBoard.tileToBoardPixel(.sprites(i).x, .sprites(i).y, .coordType, True, .bSizeX)
            .sprites(i).x = pt.x
            .sprites(i).y = pt.y
            Call activeBoard.spriteUpdateImageData(.sprites(i), .sprites(i).filename)
        Next i
        
        Exit Function

ver2oldboard:

        Open fileOpen For Input As #num
            fileHeader$ = fread(num)      'Filetype
            If fileHeader$ <> "RPGTLKIT BOARD" Then Close #num: GoTo Ver1Board
            Input #num, majorVer       'Version
            Input #num, minorVer       'Minor version (ie 2.0)
            If majorVer <> major Then MsgBox "This board was created with an unrecognised version of the Toolkit", , "Unable to open tile": Close #num: Exit Function
            If minorVer > 2 Then
                user = MsgBox("This board was created using Version " + CStr(majorVer) + "." + CStr(minorVer) + ".  You have version " + currentVersion + ". Opening this file may not work.  Continue?", 4, "Different Version")
                If user = 7 Then Close #num: Exit Function 'selected no
            End If
        
            Input #num, regYN       'Is it registered?
            regCode$ = fread(num)            'reg code
            'old style boards.
            If minorVer = 1 Then
                .bSizeX = fread(num)        'size x
                .bSizeY = fread(num)        'size y
                Call BoardSetSize(.bSizeX, .bSizeY, .bSizeL, ed, board)
            ElseIf minorVer = 0 Then
                .bSizeX = 19
                .bSizeY = 11
                .bSizeL = 8
                Call BoardSetSize(.bSizeX, .bSizeY, .bSizeL, ed, board)
            End If
            Dim lay As Long
            For x = 1 To .bSizeX
                For y = 1 To .bSizeY
                    For lay = 1 To .bSizeL
                        Temp$ = fread(num)              'Board tiles (the ,8 on the end is 8 layers)
                        Call BoardSetTile(x, y, lay, Temp$, board)
                        .ambientRed(x, y, lay) = fread(num) 'boardList(activeBoardIndex).ambient tile red
                        .ambientGreen(x, y, lay) = fread(num) 'boardList(activeBoardIndex).ambient tile green
                        .ambientBlue(x, y, lay) = fread(num) 'boardList(activeBoardIndex).ambient tile blue
                        .tiletype(x, y, lay) = fread(num) 'Board tile types... 0- Normal, 1- solid
                    Next lay
                Next y
            Next x
            .brdBack$ = fread(num)        'Board background image
            .borderBack$ = fread(num)     'Border background image
            .brdColor = fread(num)        'Board color
            .borderColor = fread(num)    'Border color
            .ambientEffect = fread(num)    'boardList(activeBoardIndex).ambient effect applied to the board 0- none, 1- fog, 2- darkness, 3- watery
            For loopControl = 1 To 4
                .dirLink$(loopControl) = fread(num)      'Direction links 1- N, 2- S, 3- E, 4-W
            Next loopControl
            .boardSkill = fread(num)      'Board skill level
            .boardBackground$ = fread(num) 'Fighting background
            .fightingYN = fread(num)      'Fighting on boardYN (1- yes, 0- no)
            For loopControl = 1 To 10
                .brdConst(loopControl) = fread(num)    'Board Constants (1-10)
            Next loopControl
            .boardMusic$ = fread(num)     'Background music file
            For loopControl = 1 To 8
                .boardTitle$(loopControl) = fread(num) 'Board title (layer)
            Next loopControl
            For loopControl = 0 To 50
                .programName$(loopControl) = fread(num) 'Board program filenames
                .progX(loopControl) = fread(num)       'program x
                .progY(loopControl) = fread(num)       'program y
                .progLayer(loopControl) = fread(num)   'program layer
                .progGraphic$(loopControl) = fread(num) 'program graphic
                .progActivate(loopControl) = fread(num) 'program activation: 0- always active, 1- conditional activation.
                .progVarActivate$(loopControl) = fread(num) 'activation variable
                .progDoneVarActivate$(loopControl) = fread(num) 'activation variable at end of prg.
                .activateInitNum$(loopControl) = fread(num) 'initial number of activation
                .activateDoneNum$(loopControl) = fread(num) 'what to make variable at end of activation.
                .activationType(loopControl) = fread(num) 'activation type- 0-step on, 1- conditional (activation key)
            Next loopControl
            ReDim boardList(activeBoardIndex).theData.itmName(0)
            For loopControl = 0 To 10
                Call dimensionItemArrays(board)
                .itmName(loopControl) = fread(num)   'filenames of items
                .itmX(loopControl) = fread(num)        'x coord
                .itmY(loopControl) = fread(num)             'y coord
                .itmLayer(loopControl) = fread(num)         'layer coord
                .itmActivate(loopControl) = fread(num)      'itm activation: 0- always active, 1- conditional activation.
                .itmVarActivate$(loopControl) = fread(num)  'activation variable
                .itmDoneVarActivate$(loopControl) = fread(num) 'activation variable at end of itm.
                .itmActivateInitNum$(loopControl) = fread(num) 'initial number of activation
                .itmActivateDoneNum$(loopControl) = fread(num) 'what to make variable at end of activation.
                .itmActivationType(loopControl) = fread(num)   'activation type- 0-step on, 1- conditional (activation key)
            Next loopControl
            .playerX = fread(num)                 'player x
            .playerY = fread(num)                 'player y
            .playerLayer = fread(num)             'player layer
            For loopControl = 0 To 10
                .itemProgram$(loopControl) = fread(num)    'item program
            Next loopControl
            .brdSavingYN = fread(num)              'can player save on board? 0-yes, 1-no
            For loopControl = 0 To 10
                .itemMulti$(loopControl) = fread(num)  'item multitask prg
            Next loopControl
            .BoardDayNight = fread(num) 'board is affected by day/night? 0=no, 1=yes
            .BoardNightBattleOverride = fread(num) 'use custom battle options at night? 0=no, 1=yes
            .BoardSkillNight = fread(num)      'Board skill level at night
            .BoardBackgroundNight$ = fread(num) 'Fighting background at night
        Close num

        Exit Function

Ver1Board:

        'We come here if we (apparently) have a version 1 board.

        Call BoardSetSize(19, 11, 8, ed, board)
        .bSizeX = 19
        .bSizeY = 11
        .bSizeL = 8

        Dim pth As String, errorsA As Long
        pth = GetPath(fileOpen$)
        errorsA = 0

        Open fileOpen For Input As #num
            If errorsA = 1 Then
                errorsA = 0
                Call MsgBox("Unable to open selected filename", "Board editor")
                Exit Function
            End If
            For y = 1 To 11
                For x = 1 To 19
                    .tiletype(x, y, 1) = fread(num)          ' PULL IN SOLID DATA
                Next x
            Next y
            Call fread(num)
            For y = 1 To 11
                For x = 1 To 19
                    Temp$ = fread(num)
                    If Temp$ = "VOID" Then Temp$ = vbNullString
                    Temp$ = pth & Temp$
                    Call BoardSetTile(x, y, 1, Temp$, board)
                Next x
            Next y
            Call fread(num)
            .playerX = fread(num)             ' PULL IN PLAYER X POSITION (unsupported)
            .playerY = fread(num)             ' PULL IN PLAYER Y POSITION (unsuppt)
            .boardTitle$(1) = fread(num)      ' PULL IN TITLE (filename)
            Call fread(num)
            For loopControl = 1 To 4
                .dirLink$(loopControl) = fread(num)       ' PULL IN DIRECTION LINKS
            Next loopControl
            .brdColor = fread(num)              ' PULL IN BOARD COLOR
            Call fread(num)
            Call fread(num)
            For loopControl = 0 To 9
                .programName$(loopControl) = fread(num)       ' PULL IN PROGRAM TITLE
                .progX(loopControl) = fread(num)         ' PULL IN PROG X POS
                .progY(loopControl) = fread(num)         ' PULL IN PROG Y POS (NEXT 30 ARE THESE 3)
                .progLayer(loopControl) = 1
            Next loopControl
            Dim fgtBrd As String
            fgtBrd$ = fread(num)             ' FIGHTING ON BOARD (Y/N)
            If UCase$(fgtBrd$) = "Y" Then
                .fightingYN = 1
            Else
                .fightingYN = 0
            End If
            .boardSkill = fread(num)            ' BOARD FIGHTING SKILL
            .boardBackground$ = fread(num)             ' BACKGROUND
            .brdConst(1) = fread(num)                ' BOARD CONSTANT
            Call fread(num)                  'Space for clarity
            .boardMusic$ = fread(num)             'Background Midi File
            .enterPrg$ = fread(num)           'Board entrance program
            .bgPrg$ = fread(num)              'Background program
            .boardTitle$(1) = fread(num)             'Board title
            .playerLayer = 1
        Close num
        
    End With

    Exit Function

loadBrdErr:
    errorsA = 1
    Resume Next

End Function

'=========================================================================
' Get a tile
'=========================================================================
Public Function BoardGetTile(ByVal x As Integer, ByVal y As Integer, ByVal layer As Integer, ByRef theBoard As TKBoard) As String
    On Error Resume Next
    BoardGetTile = theBoard.tileIndex(theBoard.board(x, y, layer))
End Function

'=========================================================================
' Initiate a board
'=========================================================================
Public Sub BoardInit(ByRef theBoard As TKBoard)
    On Error Resume Next
    ReDim theBoard.tileIndex(5)
    'Call BoardSetSize(19, 11, 8, theBoard)
    Call dimensionItemArrays(theBoard)
End Sub

'=========================================================================
' Size a board losing its current contents
'=========================================================================
Public Sub BoardSetSize(ByVal x As Integer, ByVal y As Integer, ByVal z As Integer, ByRef ed As TKBoardEditorData, ByRef board As TKBoard)

    On Error Resume Next
    
    board.bSizeX = x
    board.bSizeY = y
    board.bSizeL = z
    
    'Data matrix must be reshaped for ISO_ROTATED
    x = IIf(board.coordType And ISO_ROTATED, board.bSizeX + board.bSizeY, board.bSizeX)
    y = IIf(board.coordType And ISO_ROTATED, board.bSizeX + board.bSizeY, board.bSizeY)
    ed.effectiveBoardX = x
    ed.effectiveBoardY = y
    
    ReDim board.board(x, y, z)
    ReDim board.ambientRed(x, y, z)
    ReDim board.ambientGreen(x, y, z)
    ReDim board.ambientBlue(x, y, z)
    ReDim board.tiletype(x, y, z)
    ReDim ed.bLayerOccupied(z)

End Sub

'=========================================================================
' Set RGB value of tile
'=========================================================================
Public Sub BoardSetTileRGB(ByVal x As Integer, ByVal y As Integer, ByVal layer As Integer, ByVal filename As String, ByVal ttype As Integer, ByVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByRef theBoard As TKBoard)

    On Error Resume Next
    
    'first scan the look up table for filenames...
    Dim bWasSet As Boolean
    bWasSet = False
    Dim t As Long
    For t = 0 To UBound(theBoard.tileIndex)
        If LCase$(filename) = theBoard.tileIndex(t) Then
            'found it in lookup table...
            theBoard.board(x - 1, y - 1, layer - 1) = t
            bWasSet = True
            Exit For
        End If
    Next t
    
    Dim bFoundPos As Boolean
    bFoundPos = False
    If Not (bWasSet) Then
        'it wasn't found in the lookup table.
        'we have to add it to the lookup table...
        'first, find an empty slot...
        For t = 1 To UBound(theBoard.tileIndex)
            If (LenB(theBoard.tileIndex(t)) = 0) Then
                'found a position!
                theBoard.tileIndex(t) = LCase$(filename)
                theBoard.board(x - 1, y - 1, layer - 1) = t
                bFoundPos = True
                Exit For
            End If
        Next t
        
        Dim newSize As Long, insertPos As Long
        If Not (bFoundPos) Then
            'no empty slots found-- make the array bigger!
            newSize = UBound(theBoard.tileIndex) * 2
            insertPos = UBound(theBoard.tileIndex) + 1
            ReDim Preserve theBoard.tileIndex(newSize)
            theBoard.tileIndex(insertPos) = LCase$(filename)
            theBoard.board(x - 1, y - 1, layer - 1) = insertPos
        End If
    End If
    
    'now set the other info...
    theBoard.tiletype(x - 1, y - 1, layer - 1) = ttype
    theBoard.ambientRed(x - 1, y - 1, layer - 1) = r
    theBoard.ambientGreen(x - 1, y - 1, layer - 1) = g
    theBoard.ambientBlue(x - 1, y - 1, layer - 1) = b
End Sub

'=========================================================================
' Set a tile on the board
'=========================================================================
Public Sub BoardSetTile(ByVal x As Integer, ByVal y As Integer, ByVal layer As Integer, ByVal filename As String, ByRef theBoard As TKBoard)

    On Error Resume Next
    
    'Look for an existing matching entry.
    Dim t As Long
    For t = 0 To UBound(theBoard.tileIndex)
        If LCase$(filename) = theBoard.tileIndex(t) Then
            'found it in lookup table...
            theBoard.board(x, y, layer) = t
            Exit Sub
        End If
    Next t
    
    'Not found, look for an empty slot.
    For t = 1 To UBound(theBoard.tileIndex)
        If (LenB(theBoard.tileIndex(t)) = 0) Then
            'found a position!
            theBoard.tileIndex(t) = LCase$(filename)
            theBoard.board(x, y, layer) = t
            Exit Sub
        End If
    Next t
    
    'Not found, create a new slot.
    Dim newSize As Long, insertPos As Long
    newSize = UBound(theBoard.tileIndex) * 2
    insertPos = UBound(theBoard.tileIndex) + 1
    ReDim Preserve theBoard.tileIndex(newSize)
    theBoard.tileIndex(insertPos) = LCase$(filename)
    theBoard.board(x, y, layer) = insertPos

End Sub

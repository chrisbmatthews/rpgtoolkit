Attribute VB_Name = "Commonboard"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'Requires CommonBinaryIO.bas
'Requires CommonTileAnm.bas

Option Explicit

'Gobals and routines for the board editor.

'to store animated tile data for the board
Public Type TKBoardAnimTile
    theTile As TKTileAnm    'the animation
    x As Long
    y As Long
    layer As Long
End Type

Private lastAnm As TKTileAnm    'last opened anm file
Private lastAnmFile As String   'last opened anm file name

''''''''''''''''''''''board data'''''''''''''''''''''''''

Public Type TKBoard
    Bsizex As Integer            'board size x
    Bsizey As Integer            'board size y
    Bsizel As Integer            'board size layer
    tileIndex() As String       'lookup table for tiles
    board() As Integer          'board tiles -- codes indicating where the tiles are on the board
    ambientred() As Integer     'ambiebnt tile red
    ambientgreen() As Integer   'boardList(activeBoardIndex).ambient tile green
    ambientblue() As Integer    'boardList(activeBoardIndex).ambient tile blue
    tiletype() As Byte          'tile types 0- Normal, 1- solid 2- Under, 3- NorthSouth normal, 4- EastWest Normal, 11- Elevate to level 1, 12- Elevate to level 2... 18- Elevate to level 8
    brdBack As String           'board background img (parallax layer)
    brdFore As String           'board foreground image (parallax)
    borderBack As String        'border background img
    brdColor As Long           'board color
    borderColor As Long         'Border color
    ambienteffect As Integer    'boardList(activeBoardIndex).ambient effect applied to the board 0- none, 1- fog, 2- darkness, 3- watery
    dirLink(4) As String        'Direction links 1- N, 2- S, 3- E, 4-W
    boardskill As Integer       'Board skill level
    boardBackground As String   'Fighting background
    fightingYN As Integer       'Fighting on boardYN (1- yes, 0- no)
    BoardDayNight As Integer     'board is affected by day/night? 0=no, 1=yes
    BoardNightBattleOverride As Integer 'use custom battle options at night? 0=no, 1=yes
    BoardSkillNight As Integer   'Board skill level at night
    BoardBackgroundNight As String   'Fighting background at night
    brdConst(10) As Integer     'Board Constants (1-10)
    boardMusic As String        'Background music file
    boardTitle(8) As String     'Board title (layer)
    programName(500) As String   'Board program filenames
    progX(500) As Integer        'program x
    progY(500) As Integer        'program y
    progLayer(500) As Integer    'program layer
    progGraphic(500) As String   'program graphic
    progActivate(500) As Integer    'program activation: 0- always active, 1- conditional activation.
    progVarActivate(500) As String 'activation variable
    progDoneVarActivate(500) As String 'activation variable at end of prg.
    activateInitNum(500) As String 'initial number of activation
    activateDoneNum(500) As String 'what to make variable at end of activation.
    activationType(500) As Integer 'activation type- 0-step on, 1- conditional (activation key)
    enterPrg As String           'program to run on entrance''''''''''''''''''
    bgPrg As String              'background program
    
    itmName() As String        'filenames of items
    itmX() As Double          'x coord
    itmY() As Double          'y coord
    itmLayer() As Double      'layer coord'''''''''''''
    itmActivate() As Integer   'itm activation: 0- always active, 1- conditional activation.
    itmVarActivate() As String  'activation variable
    itmDoneVarActivate() As String 'activation variable at end of itm.
    itmActivateInitNum() As String 'initial number of activation
    itmActivateDoneNum() As String 'what to make variable at end of activation.
    itmActivationType() As Integer  'activation type- 0-step on, 1- conditional (activation key)
    itemProgram() As String         'program to run when item is touched.
    itemMulti() As String           'multitask program for item

    playerX As Integer           'player x ccord
    playerY As Integer           'player y coord
    playerLayer As Integer       'player layer coord
    brdSavingYN As Integer       'can player save on board? 0-yes, 1-no
    isIsometric As Byte         'is it an isometric board? (0- no, 1-yes)

    threads() As String
    
    'volatile (not in the file or anything)
    hasAnmTiles As Boolean  'does board have anim tiles?
    animatedTile() As TKBoardAnimTile 'animated tiles associated with this board
    anmTileInsertIdx As Long    'index of animated tile insertion
    anmTileLUTIndices() As Long     'indices into LUT of animated tiles
    anmTileLUTInsertIdx As Long    'index of LUT table insertion
End Type

'document type for board editor
Public Type boardDoc
    boardName As String     'filename
    boardNeedUpdate As Boolean
    tilesX As Long
    tilesY As Long       'size of the board in the board editor...
    boardAboutToDefineGradient As Boolean    'about to define a gradient?
    boardGradTop As Integer         'top tile of board gradient
    boardGradLeft As Integer        'left tile of board gradient
    boardGradBottom As Integer      'bottom tile of board gradient
    boardGradRight As Integer       'right tile of board gradient
    boardGradientType As Integer          'gradient type 0- l to r, 1- t to b, 2- nw to se, 3- ne to sw
    boardGradientColor1 As Long           'grad color1
    boardGradientColor2 As Long           'grad color2
    boardGradMaintainPrev As Boolean     'retain previous shades?
    BoardDetail As Integer         'Detail of selected board tile
    gridBoard As Integer           'Board openTileEditorDocs(activeTile.indice).grid on off
    BoardTile(32, 32) As Long    'Tile selected by board
    currentTileType As Integer     'boardList(activeBoardIndex).currentTileType
    currentLayer As Integer         ' Current board layer
    selectedTile As String        'Selected tile (board)
    ambient As Long              'boardList(activeBoardIndex).ambient light
    ambientR As Long             'boardList(activeBoardIndex).ambient red
    ambientG As Long             'boardList(activeBoardIndex).ambient GREEN
    ambientB As Long             'boardList(activeBoardIndex).ambient blue
    infoX As Long                'Dummy x value, used for tile info
    infoY As Long                'Dummy y value, used for tile info
    drawState As Integer            'determines boardList(activeBoardIndex).drawState.  0- draw lock, 1- type lock, 2- program set, 3- itm set
    spotLight As Integer            'spot lighting on (1)/ off (0)
    spotLightRadius As Double      'Radius of spot light
    percentFade As Double          'percent fade of boardList(activeBoardIndex).spotLight
    prgCondition As Integer         'conditions the program set window- if -1, then we start a new prg.
    itmCondition As Integer        'conditions the item set window- if -1, then we start a new itm.    theData As TKBoard
    topX As Double
    topY As Double   'the top x and y coords. (offset)
    theData As TKBoard
End Type

'array of boards used in the MDI children
Public boardList() As boardDoc
Public boardListOccupied() As Boolean

Public currentBoard As String    'current board

Public multiList() As String      'list of 10 multitask programs
Public multiOpen() As Integer     'are the multitask programs open? 0-n, 1-y

Public tilesX As Double, tilesY As Double

Public Sub dimensionItemArrays()
   
    With boardList(activeBoardIndex).theData
    
        On Error GoTo needsDim
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
        ReDim Preserve multiList(ub)
        ReDim Preserve multiOpen(ub)

        #If isToolkit = 0 Then
            ReDim Preserve itemMem(ub)
            ReDim Preserve itmPos(ub)
            ReDim Preserve program(ub + 1)
        #End If

    End With

needsDim:
    If ub = 1 Then ub = 0
    Resume Next

End Sub

Sub BoardAddTileAnmRef(ByRef theBoard As TKBoard, ByVal file As String, ByVal x As Long, ByVal y As Long, ByVal layer As Long)
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
        Call openTileAnm(projectPath$ + tilePath$ + file, lastAnm)
        lastAnmFile = file
    End If
    theBoard.animatedTile(theBoard.anmTileInsertIdx).theTile = lastAnm
    theBoard.animatedTile(theBoard.anmTileInsertIdx).x = x
    theBoard.animatedTile(theBoard.anmTileInsertIdx).y = y
    theBoard.animatedTile(theBoard.anmTileInsertIdx).layer = layer
    
    theBoard.anmTileInsertIdx = theBoard.anmTileInsertIdx + 1
End Sub

Sub BoardAddTileAnmLUTRef(ByRef theBoard As TKBoard, ByVal idx As Long)
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

Function BoardFindConsecutive(ByRef x As Integer, ByRef y As Integer, ByRef l As Integer, ByRef theBoard As TKBoard) As Long
    'find the number of consecutive identical tiles there are
    'starting at x, y, l
    'return 1 if there's only the one, else return the number of consecutive tiles
    '(inclusive of the first one).
    'also return the next x, y, l position in the for-loops after determining this (byref)
    On Error Resume Next

    Dim theTile As String
    Dim theRed As Long, theGreen As Long, theBlue As Long, theType As Long
    
    theTile = theBoard.board(x, y, l)
    theRed = theBoard.ambientred(x, y, l)
    theGreen = theBoard.ambientgreen(x, y, l)
    theBlue = theBoard.ambientblue(x, y, l)
    theType = theBoard.tiletype(x, y, l)
    
    Dim count As Long, sx As Long, sy As Long, sl As Long
    Dim ll As Long, yy As Long, xx As Long
    
    count = 0
    
    sx = x
    sy = y
    sl = l
    
    'now finf the consecutive similar ones...
    For ll = sl To theBoard.Bsizel
        For yy = sy To theBoard.Bsizey
            For xx = sx To theBoard.Bsizex
                sx = 1: sy = 1: sl = 1
                If theBoard.board(xx, yy, ll) <> theTile Or _
                    theBoard.ambientred(xx, yy, ll) <> theRed Or _
                    theBoard.ambientgreen(xx, yy, ll) <> theGreen Or _
                    theBoard.ambientblue(xx, yy, ll) <> theBlue Or _
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

Sub BoardResize(ByVal newX As Integer, ByVal newY As Integer, ByVal newLayer As Integer, ByRef theBoard As TKBoard)
    'resize the board-- retain the current tiles
    On Error Resume Next
    Dim sizex As Long, sizey As Long, sizeLayer As Long
    
    sizex = newX
    sizey = newY
    sizeLayer = newLayer
    
    'create backup...
    ReDim brd(theBoard.Bsizex, theBoard.Bsizey, theBoard.Bsizel) As Integer
    ReDim r(theBoard.Bsizex, theBoard.Bsizey, theBoard.Bsizel) As Integer
    ReDim g(theBoard.Bsizex, theBoard.Bsizey, theBoard.Bsizel) As Integer
    ReDim b(theBoard.Bsizex, theBoard.Bsizey, theBoard.Bsizel) As Integer
    ReDim t(theBoard.Bsizex, theBoard.Bsizey, theBoard.Bsizel) As Byte
    
    Dim x As Long, y As Long, l As Long
    
    For x = 0 To theBoard.Bsizex
        For y = 0 To theBoard.Bsizey
            For l = 0 To theBoard.Bsizel
                brd(x, y, l) = theBoard.board(x, y, l)
                r(x, y, l) = theBoard.ambientred(x, y, l)
                g(x, y, l) = theBoard.ambientgreen(x, y, l)
                b(x, y, l) = theBoard.ambientblue(x, y, l)
                t(x, y, l) = theBoard.tiletype(x, y, l)
            Next l
        Next y
    Next x
    
    'resize...
    ReDim theBoard.board(sizex, sizey, sizeLayer)
    ReDim theBoard.ambientred(sizex, sizey, sizeLayer)
    ReDim theBoard.ambientgreen(sizex, sizey, sizeLayer)
    ReDim theBoard.ambientblue(sizex, sizey, sizeLayer)
    ReDim theBoard.tiletype(sizex, sizey, sizeLayer)
    
    Dim xx As Long, yy As Long, ll As Long
    
    If sizex < theBoard.Bsizex Then xx = sizex Else xx = theBoard.Bsizex
    If sizey < theBoard.Bsizey Then yy = sizey Else yy = theBoard.Bsizey
    If sizeLayer < theBoard.Bsizel Then ll = sizeLayer Else ll = theBoard.Bsizel
    
    'now fill it in with the old info...
    For x = 0 To xx
        For y = 0 To yy
            For l = 0 To ll
                theBoard.board(x, y, l) = brd(x, y, l)
                theBoard.ambientred(x, y, l) = r(x, y, l)
                theBoard.ambientgreen(x, y, l) = g(x, y, l)
                theBoard.ambientblue(x, y, l) = b(x, y, l)
                theBoard.tiletype(x, y, l) = t(x, y, l)
            Next l
        Next y
    Next x
    
    theBoard.Bsizex = sizex
    theBoard.Bsizey = sizey
    theBoard.Bsizel = sizeLayer
End Sub

Function BoardTileInLUT(ByVal filename As String, ByRef theBoard As TKBoard) As Long
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
            If theBoard.tileIndex(t) = "" Then
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

Sub boardSize(ByVal fName As String, ByRef x As Long, ByRef y As Long)
    'give board x, y size
    On Error Resume Next
    Dim fileOpen As String, xx As Long, yy As Long, num As Long
    
    fileOpen$ = fName$
    fileOpen$ = PakLocate(fileOpen$)
    xx = 19: yy = 11
    num = FreeFile
    Open fileOpen For Binary As #num
        Dim b As Byte
        Get #num, 15, b
        If b <> 0 Then
            Close #num
            GoTo ver2oldboard
        End If
    Close #num
    
    Dim fileHeader As String, majorVer As Long, minorVer As Long, regYN As Long, regCode As String, l As Long
    Open fileOpen For Binary As #num
        fileHeader$ = BinReadString(num)      'Filetype
        'If fileheader$ <> "RPGTLKIT BOARD" Then Close #num: GoTo Ver1Board
        majorVer = BinReadInt(num)       'Version
        minorVer = BinReadInt(num)      'Minor version (ie 2.0)
        If minorVer <> 2 Then
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

Public Sub BoardClear(ByRef theBoard As TKBoard)

    'Clear a TKBoard structure

    On Error Resume Next

    With theBoard
        ReDim .tileIndex(5)
        Dim x As Long, y As Long, layer As Long, t As Long
        Call dimensionItemArrays
        For x = 0 To .Bsizex
            For y = 0 To .Bsizey
                For layer = 0 To .Bsizel
                    .board(x, y, layer) = 0
                    .ambientred(x, y, layer) = 0
                    .ambientgreen(x, y, layer) = 0
                    .ambientblue(x, y, layer) = 0
                    .tiletype(x, y, layer) = 0
                Next layer
            Next y
        Next x
        .brdBack = ""
        .borderBack = ""
        .brdColor = RGB(255, 255, 255)
        .borderColor = 0
        .ambienteffect = 0
        For t = 0 To 4
            .dirLink(t) = ""
        Next t
        .boardskill = 0
        .boardBackground = ""
        .fightingYN = 0
        For t = 0 To 10
            .brdConst(t) = 0
        Next t
        .boardMusic = ""
        For t = 0 To 8
            .boardTitle(t) = ""
        Next t
        For t = 0 To UBound(boardList(activeBoardIndex).theData.programName)
            .programName(t) = ""
            .progX(t) = 0
            .progY(t) = 0
            .progLayer(t) = 0
            .progGraphic(t) = ""
            .progActivate(t) = 0
            .progVarActivate(t) = ""
            .progDoneVarActivate(t) = ""
            .activateInitNum(t) = ""
            .activateDoneNum(t) = ""
            .activationType(t) = 0
        Next t
        .enterPrg = ""
        .bgPrg = ""
        For t = 0 To UBound(.itemMulti)
            .itmName(t) = ""
            .itmX(t) = 0
            .itmY(t) = 0
            .itmLayer(t) = 0
            .itmActivate(t) = 0
            .itmVarActivate(t) = ""
            .itmDoneVarActivate(t) = ""
            .itmActivateInitNum(t) = ""
            .itmActivateDoneNum(t) = ""
            .itmActivationType(t) = 0
            .itemProgram(t) = ""
            .itemMulti(t) = ""
        Next t
        .playerX = 0
        .playerY = 0
        .playerLayer = 0
        .brdSavingYN = 0
        .Bsizex = UBound(.board, 1)
        .Bsizey = UBound(.board, 2)
        .Bsizel = UBound(.board, 3)
        .BoardDayNight = 0
        .BoardNightBattleOverride = 0
        .BoardSkillNight = 0
        .BoardBackgroundNight = ""
        .isIsometric = 0
        ReDim .animatedTile(10)
        ReDim .anmTileLUTIndices(10)
        .anmTileLUTInsertIdx = 0
        .anmTileInsertIdx = 0
        .hasAnmTiles = False
        For t = 0 To UBound(.itemMulti)
            multiList(t) = ""
            multiOpen(t) = 0
        Next t
    End With
End Sub

Sub saveboard(ByVal filen As String, ByRef theBoard As TKBoard)

    'Saves board currently in memory
    On Error Resume Next
    Dim num As Long, t As Long, l As Long, x As Long, y As Long
    
    num = FreeFile
    Dim majVer As Integer
    Dim minVer As Integer
    majVer = 2
    minVer = 2
    
    Kill filen$
    
    Open filen$ For Binary As #num
        Call BinWriteString(num, "RPGTLKIT BOARD")    'Filetype
        Call BinWriteInt(num, major)
        Call BinWriteInt(num, 2)    'Minor version (ie 2.2 new type, allowing large boards)
        Call BinWriteInt(num, 0)         'registered yn (0 allowing boards to be read by TK2-CE)
        Call BinWriteString(num, "NOCODE")            'No reg code
        
        'first is the board size...
        Call BinWriteInt(num, theBoard.Bsizex)
        Call BinWriteInt(num, theBoard.Bsizey)
        Call BinWriteInt(num, theBoard.Bsizel)
    
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
        For l = 1 To theBoard.Bsizel
            For y = 1 To theBoard.Bsizey
                For x = 1 To theBoard.Bsizex
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
                        Call BinWriteInt(num, theBoard.ambientred(x, y, l))  'board tiles -- codes indicating where the tiles are on the board
                        Call BinWriteInt(num, theBoard.ambientgreen(x, y, l))   'board tiles -- codes indicating where the tiles are on the board
                        Call BinWriteInt(num, theBoard.ambientblue(x, y, l))   'board tiles -- codes indicating where the tiles are on the board
                        Call BinWriteByte(num, theBoard.tiletype(x, y, l))   'board tiles -- codes indicating where the tiles are on the board
                        'set the new x, y, l...
                        x2 = x2 - 1
                        x = x2: y = y2: l = l2
                    Else
                        'no repetitions-- just write as normal...
                        Call BinWriteInt(num, theBoard.board(x, y, l))   'board tiles -- codes indicating where the tiles are on the board
                        Call BinWriteInt(num, theBoard.ambientred(x, y, l))  'board tiles -- codes indicating where the tiles are on the board
                        Call BinWriteInt(num, theBoard.ambientgreen(x, y, l))   'board tiles -- codes indicating where the tiles are on the board
                        Call BinWriteInt(num, theBoard.ambientblue(x, y, l))   'board tiles -- codes indicating where the tiles are on the board
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
        Call BinWriteInt(num, theBoard.ambienteffect) 'boardList(activeBoardIndex).ambient effect applied to the board 0- none, 1- fog, 2- darkness, 3- watery
        For t = 1 To 4
            Call BinWriteString(num, theBoard.dirLink(t)) 'Direction links 1- N, 2- S, 3- E, 4-W
        Next t
        Call BinWriteInt(num, theBoard.boardskill) 'Board skill level
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
            Call BinWriteString(num, theBoard.programName(t)) 'Board program filenames
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

        Call dimensionItemArrays
        Call BinWriteInt(num, UBound(theBoard.itmName))   'number of items on the board...
        For t = 0 To UBound(theBoard.itmName)
            Call BinWriteString(num, theBoard.itmName(t))   'filenames of items
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
        
        Call BinWriteByte(num, theBoard.isIsometric)

        For t = 0 To UBound(theBoard.threads)
            If Not theBoard.threads(t) = "" Then
                BinWriteString num, theBoard.threads(t)
            End If
        Next t
        
    Close #num
End Sub

Public Sub openBoard(ByVal fileOpen As String, ByRef theBoard As TKBoard)

    On Error GoTo loadBrdErr

    Call BoardClear(theBoard)
    Call BoardSetSize(50, 50, 8, theBoard)

    With theBoard

        .Bsizex = 50
        .Bsizey = 50
        .Bsizel = 8
    
        topX = 0: topY = 0
        boardList(activeBoardIndex).boardNeedUpdate = False

        fileOpen = PakLocate(fileOpen)
        currentBoard = fileOpen
    
        Dim num As Long, fileHeader As String, majorVer As Long, minorVer As Long, user As Long
        Dim regYN As Long, regCode As String, loopControl As Long

        num = FreeFile()

        'Check if we have a v3 or v2 board
        Open fileOpen For Binary As num
            Dim b As Byte
            Get num, 15, b
            If b <> 0 Then
                Close num
                GoTo ver2oldboard
            End If
        Close num
    
        Open fileOpen For Binary As #num

            fileHeader$ = BinReadString(num)      'Filetype
            If fileHeader$ <> "RPGTLKIT BOARD" Then Close #num: GoTo Ver1Board
            majorVer = BinReadInt(num)       'Version
            minorVer = BinReadInt(num)      'Minor version (ie 2.0)
            If majorVer <> major Then MsgBox "This board was created with an unrecognised version of the Toolkit " + fileOpen, , "Unable to open tile": Exit Sub
            If minorVer > 2 Then
                user = MsgBox("This board was created using Version " + str$(majorVer) + "." + str$(minorVer) + ".  You have version " + currentVersion + ". Opening this file may not work.  Continue?", 4, "Different Version")
                If user = 7 Then Close #num: Exit Sub     'selected no
            End If
            If minorVer <> 2 Then
                Close #num
                GoTo ver2oldboard
            End If

            regYN = BinReadInt(num)     'Is it registered?
            regCode$ = BinReadString(num)            'reg code
        
            'new style boards.
            'first is the board size...
            .Bsizex = BinReadInt(num)
            .Bsizey = BinReadInt(num)
            .Bsizel = BinReadInt(num)
            Call BoardSetSize(.Bsizex, .Bsizey, .Bsizel, theBoard)

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
                If Temp$ <> "" Then
                    ex$ = GetExt(Temp$)
                    If UCase$(ex$) = "TAN" Then
                        Call BoardAddTileAnmLUTRef(theBoard, t)
                        .hasAnmTiles = True
                    End If
                End If
            
                #If isToolkit = 1 Then
                    Dim pakFileRunning As Boolean
                #End If
            
                If Temp$ <> "" And pakFileRunning Then
                    'do check for pakfile system
                    'ex$ = GetExt(temp$)
                    'ex$ = Left$(ex$, 3)
                    If Left(UCase$(ex$), 3) = "TST" Then
                        'numof = getTileNum(temp$)
                        Temp$ = tilesetFilename(Temp$)
                    End If
                    'PakLocate (tilePath$ + Temp$)
                End If
            Next t

            'now the board tiles...
            Dim l As Long, y As Long, x As Long
            For l = 1 To .Bsizel
                For y = 1 To .Bsizey
                    For x = 1 To .Bsizex
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
                            For cnt = 1 To test
                                .board(x, y, l) = bb   'board tiles -- codes indicating where the tiles are on the board
                                .ambientred(x, y, l) = rr 'ambiebnt tile red
                                .ambientgreen(x, y, l) = gg 'boardList(activeBoardIndex).ambient tile green
                                .ambientblue(x, y, l) = bl 'boardList(activeBoardIndex).ambient tile blue
                                .tiletype(x, y, l) = tt  'tile types 0- Normal, 1- solid 2- Under, 3- NorthSouth normal, 4- EastWest Normal, 11- Elevate to level 1, 12- Elevate to level 2... 18- Elevate to level 8
                                Dim tAnm As Long
                                'check tile type for animations
                                For tAnm = 0 To .anmTileLUTInsertIdx - 1
                                    If .board(x, y, l) = .anmTileLUTIndices(tAnm) Then
                                        'this is an animated tile
                                        Call BoardAddTileAnmRef(theBoard, .tileIndex(.board(x, y, l)), x, y, l)
                                    End If
                                Next tAnm
                                x = x + 1
                                If x > .Bsizex Then
                                    x = 1
                                    y = y + 1
                                    If y > .Bsizey Then
                                        y = 1
                                        l = l + 1
                                        If l > .Bsizel Then
                                            GoTo exitTheFor
                                        End If
                                    End If
                                End If
                            Next cnt
                            x = x - 1
                        Else
                            .board(x, y, l) = test   'board tiles -- codes indicating where the tiles are on the board
                            .ambientred(x, y, l) = BinReadInt(num) 'ambiebnt tile red
                            .ambientgreen(x, y, l) = BinReadInt(num) 'boardList(activeBoardIndex).ambient tile green
                            .ambientblue(x, y, l) = BinReadInt(num) 'boardList(activeBoardIndex).ambient tile blue
                            .tiletype(x, y, l) = BinReadByte(num)  'tile types 0- Normal, 1- solid 2- Under, 3- NorthSouth normal, 4- EastWest Normal, 11- Elevate to level 1, 12- Elevate to level 2... 18- Elevate to level 8
                    
                            'check tile type for animations
                            For tAnm = 0 To .anmTileLUTInsertIdx - 1
                                If .board(x, y, l) = .anmTileLUTIndices(tAnm) Then
                                    'this is an animated tile
                                    Call BoardAddTileAnmRef(theBoard, .tileIndex(.board(x, y, l)), x, y, l)
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
            .ambienteffect = BinReadInt(num) 'boardList(activeBoardIndex).ambient effect applied to the board 0- none, 1- fog, 2- darkness, 3- watery
            For t = 1 To 4
                .dirLink(t) = BinReadString(num)  'Direction links 1- N, 2- S, 3- E, 4-W
            Next t
            .boardskill = BinReadInt(num) 'Board skill level
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
            Dim numPrg As Long
            numPrg = BinReadInt(num)    'ubound on number of programs...
            For t = 0 To numPrg
                .programName(t) = BinReadString(num)  'Board program filenames
                .progX(t) = BinReadInt(num)   'program x
                .progY(t) = BinReadInt(num)   'program y
                .progLayer(t) = BinReadInt(num)  'program layer
                .progGraphic(t) = BinReadString(num)  'program graphic
                .progActivate(t) = BinReadInt(num)  'program activation: 0- always active, 1- conditional activation.
                .progVarActivate(t) = BinReadString(num)  'activation variable
                .progDoneVarActivate(t) = BinReadString(num)  'activation variable at end of prg.
                .activateInitNum(t) = BinReadString(num)  'initial number of activation
                .activateDoneNum(t) = BinReadString(num)  'what to make variable at end of activation.
                .activationType(t) = BinReadInt(num)  'activation type- 0-step on, 1- conditional (activation key)
            Next t
            .enterPrg = BinReadString(num)     'program to run on entrance''''''''''''''''''
            .bgPrg = BinReadString(num)       'background program
            On Error Resume Next
            Dim numItm As Long
            numItm = BinReadInt(num)
            Dim done As Boolean
            Dim count As Long
            t = 0: count = -1
            ReDim boardList(activeBoardIndex).theData.itmName(0)
            Call dimensionItemArrays
            Do Until done
                .itmName(t) = BinReadString(num)   'filenames of items
                .itmX(t) = BinReadInt(num)     'x coord
                .itmY(t) = BinReadInt(num)     'y coord
                .itmLayer(t) = BinReadInt(num)  'layer coord
                .itmActivate(t) = BinReadInt(num)  'itm activation: 0- always active, 1- conditional activation.
                .itmVarActivate(t) = BinReadString(num)  'activation variable
                .itmDoneVarActivate(t) = BinReadString(num)  'activation variable at end of itm.
                .itmActivateInitNum(t) = BinReadString(num)  'initial number of activation
                .itmActivateDoneNum(t) = BinReadString(num)  'what to make variable at end of activation.
                .itmActivationType(t) = BinReadInt(num)  'activation type- 0-step on, 1- conditional (activation key)
                .itemProgram(t) = BinReadString(num)    'program to run when item is touched.
                .itemMulti(t) = BinReadString(num)     'multitask program for item
                If .itmName(t) <> "" Then
                    t = t + 1
                    Call dimensionItemArrays
                End If
                count = count + 1
                If count >= numItm Then
                    'Done all the items
                    done = True
                End If
            Loop

            'Read in isometrics
            .isIsometric = BinReadByte(num)

            'Read in threads
            Dim tCount As Long
            Dim thread As String
            Do Until EOF(num)
                ReDim Preserve .threads(tCount)
                .threads(tCount) = BinReadString(num)
                tCount = tCount + 1
            Loop

        Close num

        Exit Sub

ver2oldboard:

        Open fileOpen For Input As #num
            fileHeader$ = fread(num)      'Filetype
            If fileHeader$ <> "RPGTLKIT BOARD" Then Close #num: GoTo Ver1Board
            Input #num, majorVer       'Version
            Input #num, minorVer       'Minor version (ie 2.0)
            If majorVer <> major Then MsgBox "This board was created with an unrecognised version of the Toolkit", , "Unable to open tile": Close #num: Exit Sub
            If minorVer > 2 Then
                user = MsgBox("This board was created using Version " + str$(majorVer) + "." + str$(minorVer) + ".  You have version " + currentVersion + ". Opening this file may not work.  Continue?", 4, "Different Version")
                If user = 7 Then Close #num: Exit Sub     'selected no
            End If
        
            Input #num, regYN       'Is it registered?
            regCode$ = fread(num)            'reg code
            'old style boards.
            If minorVer = 1 Then
                .Bsizex = fread(num)        'size x
                .Bsizey = fread(num)        'size y
                Call BoardSetSize(.Bsizex, .Bsizey, .Bsizel, theBoard)
            ElseIf minorVer = 0 Then
                .Bsizex = 19
                .Bsizey = 11
                .Bsizel = 8
                Call BoardSetSize(.Bsizex, .Bsizey, .Bsizel, theBoard)
            End If
            Dim lay As Long
            For x = 1 To .Bsizex
                For y = 1 To .Bsizey
                    For lay = 1 To .Bsizel
                        Temp$ = fread(num)              'Board tiles (the ,8 on the end is 8 layers)
                        Call BoardSetTile(x, y, lay, Temp$, theBoard)
                        .ambientred(x, y, lay) = fread(num) 'boardList(activeBoardIndex).ambient tile red
                        .ambientgreen(x, y, lay) = fread(num) 'boardList(activeBoardIndex).ambient tile green
                        .ambientblue(x, y, lay) = fread(num) 'boardList(activeBoardIndex).ambient tile blue
                        .tiletype(x, y, lay) = fread(num) 'Board tile types... 0- Normal, 1- solid
                    Next lay
                Next y
            Next x
            .brdBack$ = fread(num)        'Board background image
            .borderBack$ = fread(num)     'Border background image
            .brdColor = fread(num)        'Board color
            .borderColor = fread(num)    'Border color
            .ambienteffect = fread(num)    'boardList(activeBoardIndex).ambient effect applied to the board 0- none, 1- fog, 2- darkness, 3- watery
            For loopControl = 1 To 4
                .dirLink$(loopControl) = fread(num)      'Direction links 1- N, 2- S, 3- E, 4-W
            Next loopControl
            .boardskill = fread(num)      'Board skill level
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
            For loopControl = 0 To 10
                Call dimensionItemArrays
                .itmName$(loopControl) = fread(num)   'filenames of items
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

        Exit Sub

Ver1Board:

        'We come here if we (apparently) have a version 1 board.

        Call BoardSetSize(19, 11, 8, theBoard)
        .Bsizex = 19
        .Bsizey = 11
        .Bsizel = 8

        Dim pth As String, errorsA As Long
        pth = GetPath(fileOpen$)
        errorsA = 0

        Open fileOpen For Input As #num
            If errorsA = 1 Then
                errorsA = 0
                Call MsgBox("Unable to open selected filename", "Board editor")
                Exit Sub
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
                    If Temp$ = "VOID" Then Temp$ = ""
                    Temp$ = pth$ + Temp$
                    Call BoardSetTile(x, y, 1, Temp$, theBoard)
                Next x
            Next y
            Call fread(num)
            .playerX = fread(num)             ' PULL IN PLAYER X POSITION (unsupported)
            .playerY = fread(num)             ' PULL IN PLAYER Y POSITION (unsuppt)
            .boardTitle$(1) = fread(num)      ' PULL IN TITLE (filename)
            Call fread(num)
            Dim loopControl As Long
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
            .boardskill = fread(num)            ' BOARD FIGHTING SKILL
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

    Exit Sub

loadBrdErr:
    errorsA = 1
    Resume Next

End Sub

Function BoardGetTile(ByVal x As Integer, ByVal y As Integer, ByVal layer As Integer, ByRef theBoard As TKBoard) As String
    'get the board's tile filename at x, y, layer
    On Error Resume Next
    BoardGetTile = theBoard.tileIndex(theBoard.board(x, y, layer))
End Function

Sub BoardInit(ByRef theBoard As TKBoard)
    'set initial array sizes...
    On Error Resume Next
    ReDim theBoard.tileIndex(5)
    Call BoardSetSize(19, 11, 8, theBoard)
    Call dimensionItemArrays
End Sub

Sub BoardSetSize(ByVal sizex As Integer, ByVal sizey As Integer, ByVal sizeLayer As Integer, ByRef theBoard As TKBoard)
    'resize the board-- do not maintin current contents.
    On Error Resume Next
    
    ReDim theBoard.board(sizex, sizey, sizeLayer)
    ReDim theBoard.ambientred(sizex, sizey, sizeLayer)
    ReDim theBoard.ambientgreen(sizex, sizey, sizeLayer)
    ReDim theBoard.ambientblue(sizex, sizey, sizeLayer)
    ReDim theBoard.tiletype(sizex, sizey, sizeLayer)

    theBoard.Bsizex = sizex
    theBoard.Bsizey = sizey
    theBoard.Bsizel = sizeLayer
End Sub

Sub BoardSetTileRGB(ByVal x As Integer, ByVal y As Integer, ByVal layer As Integer, ByVal filename As String, ByVal ttype As Integer, ByVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByRef theBoard As TKBoard)
    'set a tile on the board at x, y, layer
    'with a specified tile type and r,g,b shade
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
            If theBoard.tileIndex(t) = "" Then
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
    theBoard.ambientred(x - 1, y - 1, layer - 1) = r
    theBoard.ambientgreen(x - 1, y - 1, layer - 1) = g
    theBoard.ambientblue(x - 1, y - 1, layer - 1) = b
End Sub

Sub BoardSetTile(ByVal x As Integer, ByVal y As Integer, ByVal layer As Integer, ByVal filename As String, ByRef theBoard As TKBoard)
    'set a tile on the board at x, y, layer
    'with a specified tile type and r,g,b shade
    On Error Resume Next
    
    'first scan the look up table for filenames...
    Dim bWasSet As Boolean, t As Long
    bWasSet = False
    For t = 0 To UBound(theBoard.tileIndex)
        If LCase$(filename) = theBoard.tileIndex(t) Then
            'found it in lookup table...
            theBoard.board(x, y, layer) = t
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
            If theBoard.tileIndex(t) = "" Then
                'found a position!
                theBoard.tileIndex(t) = LCase$(filename)
                theBoard.board(x, y, layer) = t
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
            theBoard.board(x, y, layer) = insertPos
        End If
    End If
End Sub

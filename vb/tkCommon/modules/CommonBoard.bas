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

Private Declare Function BRDIsometricTransform Lib "actkrt3.dll" (ByRef x As Double, ByRef y As Double, ByVal oldType As Integer, ByVal newType As Integer, ByVal brdSizeX As Integer) As Long

'=========================================================================
' Member constants
'=========================================================================
Private Const FILE_HEADER = "RPGTLKIT BOARD"

'=========================================================================
' An animated tile (trans3 only)
'=========================================================================
Private Type TKBoardAnimTile
    theTile As TKTileAnm
    x As Long
    y As Long
    layer As Long
End Type

'=========================================================================
' A pre-vector RPGToolkit board (up to 3.0.6)
'=========================================================================
Public Type TKpvBoard
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
    theData As TKpvBoard                    'actual contents of board
End Type

'=========================================================================
' Integral variables
'=========================================================================
'tbd: remove
Public boardList() As boardDoc            'list of board documents
Public boardListOccupied() As Boolean     'position used?
Public currentBoard As String             'current board
Public tilesX As Double                   'tiles screen can hold on x
Public tilesY As Double                   'tiles screen can hold on y

Private Const BRD_MINOR = 4               'Current minor version (3.0.7)
Private Const MAX_INTEGER = &H7FFF

'=========================================================================
' Find the number of consective tiles
'=========================================================================
Public Function boardFindConsecutive(ByRef x As Long, ByRef y As Long, ByRef z As Long, ByRef board As TKBoard) As Integer
    'Find and return the number of consecutive identical tiles, starting at x, y, z
    'Also return the terminating x, y, z position ByRef
    On Error Resume Next

    Dim tile As Long, r As Long, g As Long, b As Long
    
    tile = board.board(x, y, z)
    r = board.ambientRed(x, y, z)
    g = board.ambientGreen(x, y, z)
    b = board.ambientBlue(x, y, z)
    
    Dim count As Integer, i As Long, j As Long, k As Long
    count = 0
    
    For k = z To UBound(board.board, 3)
        For j = y To UBound(board.board, 2)
            For i = x To UBound(board.board, 1)
                
                If board.board(i, j, k) <> tile Or _
                    board.ambientRed(i, j, k) <> r Or _
                    board.ambientGreen(i, j, k) <> g Or _
                    board.ambientBlue(i, j, k) <> b Then
                    
                    'First non-matching tile.
                    GoTo exitFor
                End If
                
                If count = MAX_INTEGER Then GoTo exitFor
                count = count + 1
            Next i
            'Reset the start column
            x = 1
        Next j
        y = 1
    Next k
    
exitFor:
    x = i
    y = j
    z = k
    boardFindConsecutive = count
End Function

'=========================================================================
' Find the Lut index of a tile, inserting it if not found
'=========================================================================
Public Function boardTileInLut(ByVal filename As String, ByRef board As TKBoard) As Long: On Error Resume Next
    
    Dim i As Long
    
    For i = 0 To UBound(board.tileIndex)
        If LCase$(filename) = board.tileIndex(i) Then
            boardTileInLut = i
            Exit Function
        End If
    Next i
    
    'Not found - insert into the second empty (= 0) element,
    '(excluding the first element, which indicates no tile at that position).
    For i = 1 To UBound(board.tileIndex)
        If LenB(board.tileIndex(i)) = 0 Then
            board.tileIndex(i) = LCase$(filename)
            boardTileInLut = i
            Exit Function
        End If
    Next i
        
    'No empty slots found - append to array.
    ReDim Preserve board.tileIndex(UBound(board.tileIndex) + 1)
    board.tileIndex(UBound(board.tileIndex)) = LCase$(filename)
    boardTileInLut = UBound(board.tileIndex)

End Function

'=========================================================================
' Save a board to file
'=========================================================================
Public Sub saveBoard(ByVal filename As String, ByRef board As TKBoard)

    On Error Resume Next

    Dim num As Long, i As Long, j As Long, k As Long, x As Long, y As Long, z As Long
    
    Call Kill(filename)

    num = FreeFile()

    With board

        Open filename For Binary Access Write As num
        
            Call BinWriteString(num, "RPGTLKIT BOARD")    'Filetype
            Call BinWriteInt(num, major)                  'Global version - required?
            Call BinWriteInt(num, BRD_MINOR)              'Minor version
            
            'Board dimensions
            Call BinWriteInt(num, .sizex)
            Call BinWriteInt(num, .sizey)
            Call BinWriteInt(num, .sizeL)
            Call BinWriteInt(num, .coordType)
            
            'Tile look-up-table (lut)
            'Remove unused tiles from the lut by recording used indices.
            ReDim bLutIndexUsed(UBound(.tileIndex)) As Boolean
            
            'Do this before the board tile loop since trans3 needs the lut indices
            'to load animated tiles.
           
            For k = 1 To UBound(.board, 3)
                For j = 1 To UBound(.board, 2)
                    For i = 1 To UBound(.board, 1)
                        'Denote this lut index as in use.
                        bLutIndexUsed(.board(i, j, k)) = True
                    Next i
                Next j
            Next k
                        
            For i = UBound(bLutIndexUsed) To 1 Step -1
                If bLutIndexUsed(i) Then Exit For
            Next i
            
            Call BinWriteInt(num, i)
            For j = 0 To i
                Call BinWriteString(num, IIf(bLutIndexUsed(j), .tileIndex(j), ""))
            Next j
            
            'Board tiles
            For k = 1 To UBound(.board, 3)
                For j = 1 To UBound(.board, 2)
                    For i = 1 To UBound(.board, 1)
                        '"Compress" identical tiles:
                        x = i: y = j: z = k
                        
                        Dim count As Integer
                        count = boardFindConsecutive(x, y, z, board)
                        If count > 1 Then
                            'The next 'count' tiles are identical - write 'count' and the
                            'properties of the first tile only. A negative 'count' will
                            'indicate compression when loading.
                            
                            Call BinWriteInt(num, -count)
                            
                            Call BinWriteInt(num, .board(i, j, k))
                            Call BinWriteInt(num, .ambientRed(i, j, k))
                            Call BinWriteInt(num, .ambientGreen(i, j, k))
                            Call BinWriteInt(num, .ambientBlue(i, j, k))
                            
                            'Set the new position. Decrement i since the loop will increment it.
                            i = x - 1: j = y: k = z
                        Else
                            'No consecutive identical tiles - write this tile's properties.
                            
                            Call BinWriteInt(num, .board(i, j, k))
                            Call BinWriteInt(num, .ambientRed(i, j, k))
                            Call BinWriteInt(num, .ambientGreen(i, j, k))
                            Call BinWriteInt(num, .ambientBlue(i, j, k))
                        End If
                    Next i
                Next j
            Next k
            
            'Vectors
            If .vectors(0) Is Nothing Then
                Call BinWriteInt(num, -1)
            Else
                Call BinWriteInt(num, UBound(.vectors))
                For i = 0 To UBound(.vectors)
                    
                    Call BinWriteInt(num, .vectors(i).getPoints)
                    For j = 0 To .vectors(i).getPoints
                        Call .vectors(i).getPoint(j, x, y)
                        Call BinWriteLong(num, x)                   'Stored by pixel (Longs)
                        Call BinWriteLong(num, y)
                    Next j
                    
                    Call BinWriteInt(num, .vectors(i).attributes)
                    Call BinWriteInt(num, CInt(.vectors(i).bClosed))
                    Call BinWriteInt(num, .vectors(i).layer)
                    Call BinWriteInt(num, CInt(.vectors(i).tiletype))
                    
                Next i
            End If
            
            'Programs
            If .prgs(0) Is Nothing Then
                Call BinWriteInt(num, -1)
            Else
                Call BinWriteInt(num, UBound(.prgs))
                For i = 0 To UBound(.prgs)
    
                    Call BinWriteString(num, .prgs(i).filename)
                    Call BinWriteString(num, .prgs(i).initialVar)
                    Call BinWriteString(num, .prgs(i).initialValue)
                    Call BinWriteString(num, .prgs(i).finalVar)
                    Call BinWriteString(num, .prgs(i).finalValue)
                    Call BinWriteInt(num, .prgs(i).activate)
                    Call BinWriteInt(num, .prgs(i).activationType)
                    Call BinWriteInt(num, .prgs(i).distanceRepeat)
                    Call BinWriteInt(num, .prgs(i).layer)
                    
                    Call BinWriteInt(num, .prgs(i).vBase.getPoints)
                    
                    For j = 0 To .prgs(i).vBase.getPoints
                        Call .prgs(i).vBase.getPoint(j, x, y)
                        Call BinWriteLong(num, x)                   'Stored by pixel (Longs)
                        Call BinWriteLong(num, y)
                    Next j
                    
                    Call BinWriteInt(num, CInt(.prgs(i).vBase.bClosed))
                    
                Next i
            End If
            
            'Sprites
            If .sprites(0) Is Nothing Then
                Call BinWriteInt(num, -1)
            Else
                Call BinWriteInt(num, UBound(.sprites))
                For i = 0 To UBound(.sprites)
    
                    Call BinWriteString(num, .sprites(i).filename)
                    Call BinWriteString(num, .sprites(i).prgActivate)
                    Call BinWriteString(num, .sprites(i).prgMultitask)
                    Call BinWriteString(num, .sprites(i).initialVar)
                    Call BinWriteString(num, .sprites(i).initialValue)
                    Call BinWriteString(num, .sprites(i).finalVar)
                    Call BinWriteString(num, .sprites(i).finalValue)
                    Call BinWriteInt(num, .sprites(i).activate)
                    Call BinWriteInt(num, .sprites(i).activationType)
                    Call BinWriteInt(num, .sprites(i).x)
                    Call BinWriteInt(num, .sprites(i).y)
                    Call BinWriteInt(num, .sprites(i).layer)
    
                Next i
            End If
            
            'Images
            If .Images(0).drawType = BI_NULL Then
                Call BinWriteInt(num, -1)
            Else
                Call BinWriteInt(num, UBound(.Images))
                For i = 0 To UBound(.Images)
    
                    Call BinWriteString(num, .Images(i).filename)
                    Call BinWriteLong(num, .Images(i).bounds.Left)
                    Call BinWriteLong(num, .Images(i).bounds.Top)
                    Call BinWriteInt(num, .Images(i).layer)
                    Call BinWriteInt(num, .Images(i).drawType)
                    Call BinWriteLong(num, .Images(i).transpcolor)
    
                Next i
            End If
            
            'Threads
            Call BinWriteInt(num, UBound(.Threads))
            For i = 0 To UBound(.Threads)
                Call BinWriteString(num, .Threads(i))
            Next i
            
            'Constants
            Call BinWriteInt(num, UBound(.constants))
            For i = 0 To UBound(.constants)
                Call BinWriteString(num, .constants(i))
            Next i
            
            'Layer titles
            For i = 0 To .sizeL
                Call BinWriteString(num, .layerTitles(i))
            Next i
            
            'Directional links
            For i = 0 To UBound(.directionalLinks)
                Call BinWriteString(num, .directionalLinks(i))
            Next i
            
            Call BinWriteString(num, .bkgImage.filename)    'Background image
            Call BinWriteLong(num, .bkgImage.drawType)
            Call BinWriteLong(num, .bkgColor)               'Background colour
            Call BinWriteString(num, .bkgMusic)
        
            Call BinWriteString(num, .enterPrg)
            Call BinWriteString(num, .battleBackground)
            Call BinWriteInt(num, .battleSkill)
            Call BinWriteInt(num, .bAllowBattles)
            Call BinWriteInt(num, .bDisableSaving)
            Call BinWriteInt(num, .ambientEffect)
        
        Close num
    
    End With

End Sub

'=========================================================================
' Open a board
'=========================================================================
Public Function openBoard(ByVal fileOpen As String, ByRef ed As TKBoardEditorData, ByRef board As TKBoard)

    'On Error Resume Next
    
    Call boardInitialise(board)
    Call boardSetSize(20, 15, 4, ed, board, False)

    With board

        fileOpen = PakLocate(fileOpen)
    
        Dim num As Long, fileHeader As String, i As Long, j As Long, k As Long

        num = FreeFile()

        'Check if we have a v3 or v2 board
        Open fileOpen For Binary As num
            Dim ver As Byte
            Get num, 15, ver
            If ver Then
                Close num
                MsgBox "Please save this board using RPGToolkit version 3.0.6 or below to upgrade the file format"
                Exit Function
            End If
        Close num

        Open fileOpen For Binary As num

            fileHeader = BinReadString(num)      'Filetype
            If fileHeader <> "RPGTLKIT BOARD" Then
                Close num
                MsgBox "Please save this board using RPGToolkit version 3.0.6 or below to upgrade the file format"
                Exit Function
            End If
            
            Dim majorVer As Long, minorVer As Long
            majorVer = BinReadInt(num)       'Version (?)
            minorVer = BinReadInt(num)       'Minor version (BRD_MINOR)
            If majorVer <> major Then
                MsgBox "This board was created with an unrecognised version of the Toolkit " + fileOpen, , "Unable to open tile"
                Exit Function
            End If
            
            Select Case minorVer
                Case 0, 1
                    Close num
                    MsgBox "Please save this board using RPGToolkit version 3.0.6 or below to upgrade the file format"
                    Exit Function
                Case 2, 3
                    GoTo pvVersion
            End Select

vVersion:
            '3.0.7 - vector collision implementation.
        
            .sizex = BinReadInt(num)
            .sizey = BinReadInt(num)
            .sizeL = BinReadInt(num)
            .coordType = BinReadInt(num)
            Call boardSetSize(.sizex, .sizey, .sizeL, ed, board, False)
            
            'Build the tile look-up-table (Lut).
            Dim lutSize As Long
            lutSize = BinReadInt(num)
            ReDim .tileIndex(lutSize)
            
            For i = 0 To lutSize
                .tileIndex(i) = BinReadString(num)
            Next i
            
            'Read off the Lut indices for each tile.
            Dim x As Long, y As Long, z As Long
            
            z = UBound(.board, 3)
            y = UBound(.board, 2)
            x = UBound(.board, 1)
            
            For z = 1 To UBound(.board, 3)
                For y = 1 To UBound(.board, 2)
                    For x = 1 To UBound(.board, 1)
                    
                        Dim Index As Integer, count As Integer
                        Index = BinReadInt(num)
                        
                        'Negative index indicates compression:
                        'the next 'index' tiles are indentical.
                        If Index < 0 Then
                            count = -Index
                            
                            Dim r As Long, b As Long, g As Long, tiletype As Byte
                            Index = BinReadInt(num)
                            r = BinReadInt(num)
                            g = BinReadInt(num)
                            b = BinReadInt(num)
                            
                            'Determine if the layer contains tiles (editor use).
                            '(0) indicates if the whole board contains tiles.
                            If Index Then
                                ed.bLayerOccupied(z) = True
                                ed.bLayerOccupied(0) = True
                            End If
                    
                            For i = 1 To count
                                .board(x, y, z) = Index
                                .ambientRed(x, y, z) = r
                                .ambientGreen(x, y, z) = g
                                .ambientBlue(x, y, z) = b

                                'Check whether compression spans rows/layers.
                                x = x + 1
                                If x > UBound(.board, 1) Then
                                    x = 1
                                    y = y + 1
                                    If y > UBound(.board, 2) Then
                                        y = 1
                                        z = z + 1
                                        If z > UBound(.board, 3) Then
                                            'Compression to end of board - exit.
                                            GoTo exitForA
                                        End If
                                        
                                        'Spans onto next layer (editor use).
                                        If (Index) Then ed.bLayerOccupied(z) = True
                                    End If
                                End If
                            Next i
                            x = x - 1
                        Else
                            'Single tile.
                            
                            'Determine if the layer contains tiles (editor use).
                            If Index Then
                                ed.bLayerOccupied(z) = True
                                ed.bLayerOccupied(0) = True
                            End If
                            
                            .board(x, y, z) = Index
                            .ambientRed(x, y, z) = BinReadInt(num)
                            .ambientGreen(x, y, z) = BinReadInt(num)
                            .ambientBlue(x, y, z) = BinReadInt(num)
                            
                        End If
                    Next x
                Next y
            Next z
exitForA:

            'Vectors
            Dim ub As Integer, pts As Integer
            ub = BinReadInt(num)
            If ub >= 0 Then
                'Negative number indicates no objects.
            
                ReDim .vectors(ub)
                For i = 0 To ub
                    Set .vectors(i) = New CVector
                    pts = BinReadInt(num)
                    For j = 0 To pts
                        x = BinReadLong(num)
                        y = BinReadLong(num)
                        Call .vectors(i).addPoint(x, y)
                    Next j
                    
                    .vectors(i).attributes = BinReadInt(num)
                    .vectors(i).bClosed = CBool(BinReadInt(num))
                    .vectors(i).layer = BinReadInt(num)
                    .vectors(i).tiletype = BinReadInt(num)
                    
                Next i
            End If
            
            'Programs
            ub = BinReadInt(num)
            If ub >= 0 Then
                ReDim .prgs(ub)
                For i = 0 To ub
                    Set .prgs(i) = New CBoardProgram
                    
                    .prgs(i).filename = BinReadString(num)
                    .prgs(i).initialVar = BinReadString(num)
                    .prgs(i).initialValue = BinReadString(num)
                    .prgs(i).finalVar = BinReadString(num)
                    .prgs(i).finalValue = BinReadString(num)
                    .prgs(i).activate = BinReadInt(num)
                    .prgs(i).activationType = BinReadInt(num)
                    .prgs(i).distanceRepeat = BinReadInt(num)
                    .prgs(i).layer = BinReadInt(num)
                    
                    Set .prgs(i).vBase = New CVector
                    
                    pts = BinReadInt(num)
                    For j = 0 To pts
                        x = BinReadLong(num)
                        y = BinReadLong(num)
                        Call .prgs(i).vBase.addPoint(x, y)
                    Next j
                    
                    .prgs(i).vBase.bClosed = CBool(BinReadInt(num))
                    
                Next i
            End If
            
            'Sprites
            ub = BinReadInt(num)
            If ub >= 0 Then
                ReDim .sprites(ub)
                ReDim .spriteImages(ub)
                For i = 0 To ub
                    Set .sprites(i) = New CBoardSprite
                    
                    .sprites(i).filename = BinReadString(num)
                    .sprites(i).prgActivate = BinReadString(num)
                    .sprites(i).prgMultitask = BinReadString(num)
                    .sprites(i).initialVar = BinReadString(num)
                    .sprites(i).initialValue = BinReadString(num)
                    .sprites(i).finalVar = BinReadString(num)
                    .sprites(i).finalValue = BinReadString(num)
                    .sprites(i).activate = BinReadInt(num)
                    .sprites(i).activationType = BinReadInt(num)
                    .sprites(i).x = BinReadInt(num)
                    .sprites(i).y = BinReadInt(num)
                    .sprites(i).layer = BinReadInt(num)
                
                Next i
                
                'Update only after loading all sprites.
                For i = 0 To ub
                    'tbd: decide on storing default paths.
                    Call activeBoard.spriteUpdateImageData(.sprites(i), .sprites(i).filename, True)
                Next i
            End If
            
            
            'Images
            ub = BinReadInt(num)
            If ub >= 0 Then
                ReDim .Images(ub)
                For i = 0 To ub
                    
                    .Images(i).filename = BinReadString(num)
                    .Images(i).bounds.Left = BinReadLong(num)
                    .Images(i).bounds.Top = BinReadLong(num)
                    .Images(i).layer = BinReadInt(num)
                    .Images(i).drawType = BinReadInt(num)
                    .Images(i).transpcolor = BinReadLong(num)
                
                Next i
            End If
            
            ub = BinReadInt(num)
            ReDim .Threads(ub)
            For i = 0 To ub
                .Threads(i) = BinReadString(num)
            Next i
            
            ub = BinReadInt(num)
            ReDim .constants(ub)
            For i = 0 To ub
                .constants(i) = BinReadString(num)
            Next i
            
            For i = 0 To .sizeL
                .layerTitles(i) = BinReadString(num)
            Next i
            
            ReDim .directionalLinks(3)
            For i = 0 To UBound(.directionalLinks)
                .directionalLinks(i) = BinReadString(num)
            Next i

            .bkgImage.filename = BinReadString(num)
            .bkgImage.drawType = BinReadLong(num)
            .bkgColor = BinReadLong(num)
            .bkgMusic = BinReadString(num)
            
            .enterPrg = BinReadString(num)
            .battleBackground = BinReadString(num)
            .battleSkill = BinReadInt(num)
            .bAllowBattles = CBool(BinReadInt(num))
            .bDisableSaving = CBool(BinReadInt(num))
            .ambientEffect = BinReadInt(num)
            
        Close num
        Exit Function

pvVersion:

            Dim bReg As Integer, regCode As String
            bReg = BinReadInt(num)                  'Created with a registered version?
            regCode = BinReadString(num)            'Registration code
        
            .sizex = BinReadInt(num)
            .sizey = BinReadInt(num)
            .sizeL = BinReadInt(num)
            Call boardSetSize(.sizex, .sizey, .sizeL, ed, board, False)
            ReDim .tiletype(.sizex, .sizey, .sizeL) 'Not done in boardSetSize
            
            'tbd: Player start location data has been moved to the main file.
            x = BinReadInt(num)
            y = BinReadInt(num)
            z = BinReadInt(num)
            
            .bDisableSaving = CBool(BinReadInt(num))
            
            'Build the tile look-up-table (Lut)
            lutSize = BinReadInt(num)
            ReDim .tileIndex(lutSize)
            
            For i = 0 To UBound(.tileIndex)
                .tileIndex(i) = BinReadString(num)
            Next i

            'Read off the Lut indices for each tile.
            For z = 1 To .sizeL
                For y = 1 To .sizey
                    For x = 1 To .sizex
                    
                        Index = BinReadInt(num)
                        
                        'Negative index indicates compression:
                        'the next 'index' tiles are indentical.
                        If Index < 0 Then
                            count = -Index
                            
                            Index = BinReadInt(num)
                            r = BinReadInt(num)
                            g = BinReadInt(num)
                            b = BinReadInt(num)
                            tiletype = BinReadByte(num)
                            
                            'Determine if the layer contains tiles (editor use).
                            '(0) indicates if the whole board contains tiles.
                            If Index Then
                                ed.bLayerOccupied(z) = True
                                ed.bLayerOccupied(0) = True
                            End If
                    
                            For i = 1 To count
                                .board(x, y, z) = Index
                                .ambientRed(x, y, z) = r
                                .ambientGreen(x, y, z) = g
                                .ambientBlue(x, y, z) = b
                                .tiletype(x, y, z) = tiletype

                                'Check whether compression spans rows/layers.
                                x = x + 1
                                If x > .sizex Then
                                    x = 1
                                    y = y + 1
                                    If y > .sizey Then
                                        y = 1
                                        z = z + 1
                                        If z > .sizeL Then
                                            'Compression to end of board - exit.
                                            GoTo exitForB
                                        End If
                                        
                                        'Spans onto next layer (editor use).
                                        If (Index) Then ed.bLayerOccupied(z) = True
                                    End If
                                End If
                            Next i
                            x = x - 1
                        Else
                            'Single tile.
                            
                            'Determine if the layer contains tiles (editor use).
                            If Index Then
                                ed.bLayerOccupied(z) = True
                                ed.bLayerOccupied(0) = True
                            End If
                            
                            .board(x, y, z) = Index
                            .ambientRed(x, y, z) = BinReadInt(num)
                            .ambientGreen(x, y, z) = BinReadInt(num)
                            .ambientBlue(x, y, z) = BinReadInt(num)
                            .tiletype(x, y, z) = BinReadByte(num)
                            
                        End If
                    Next x
                Next y
            Next z
exitForB:
            
            Dim strUnused As String, lUnused As Long, iUnused As Integer

            .bkgImage.filename = BinReadString(num) 'Background image
            .bkgImage.drawType = BI_PARALLAX    'Default for pre-vector boards

            strUnused = BinReadString(num)      'Foreground image (depreciated parallax)
            strUnused = BinReadString(num)      'Border background image (depreciated)
            .bkgColor = BinReadLong(num)        'Background colour
            lUnused = BinReadLong(num)          'Border colour (depreciated)
            .ambientEffect = BinReadInt(num)    'Ambient effect 0: none, 1: fog, 2: darkness, 3: watery
            
            ReDim .directionalLinks(3)
            For i = 0 To 3
                .directionalLinks(i) = BinReadString(num)  'Direction links 0: N, 1: S, 2: E, 3: W
            Next i
            
            .battleSkill = BinReadInt(num)         'Skill level
            .battleBackground = BinReadString(num) 'Fighting background
            .bAllowBattles = CBool(BinReadInt(num)) 'Fighting on board? (1: yes, 0: no)
            
            iUnused = BinReadInt(num)           'Board is affected by day/night? (depreciated)
            iUnused = BinReadInt(num)           'Use custom battle options at night? (depreciated)
            iUnused = BinReadInt(num)           'Skill level at night (depreciated)
            strUnused = BinReadString(num)      'Fighting background at night (depreciated)
            
            ReDim .constants(10)
            For i = 0 To 10
                .constants(i) = CStr(BinReadInt(num))  'Constants
            Next i
            
            .bkgMusic = BinReadString(num)    'Background music file
            
            ReDim .layerTitles(8)
            For i = 0 To 8
                .layerTitles(i) = BinReadString(num)  'Layer titles
            Next i
            
            '3.0.7 - load programs into CBoardProgram structures.
            Dim numPrg As Long, ubPrgs As Long
            numPrg = BinReadInt(num)    'ubound on number of programs written to file.
            
            For i = 0 To numPrg
                Dim prg As CBoardProgram
                Set prg = New CBoardProgram
                prg.filename = BinReadString(num)       'program filenames
                x = BinReadInt(num)                     'program x
                y = BinReadInt(num)                     'program y
                prg.layer = BinReadInt(num)             'program layer
                prg.graphic = BinReadString(num)        'program graphic
                prg.activate = BinReadInt(num)          'program activation - 0: always active, 1: conditional activation.
                prg.initialVar = BinReadString(num)     'activation variable
                prg.finalVar = BinReadString(num)       'activation variable at end of prg.
                prg.initialValue = BinReadString(num)   'initial number of activation
                prg.finalValue = BinReadString(num)     'what to make variable at end of activation.
                prg.activationType = BinReadInt(num)    'activation type - 0: step on, 1: conditional (activation key)
               
                If (prg.filename <> vbNullString) Then
                    ReDim Preserve .prgs(ubPrgs)
                    Set .prgs(ubPrgs) = prg
                    ' Hold the position in the CVector until the coordtype byte is read.
                    .prgs(ubPrgs).vBase.deletePoints
                    Call .prgs(ubPrgs).vBase.addPoint(x, y)
                    ubPrgs = ubPrgs + 1
                End If
                Set prg = Nothing
            Next i
            .enterPrg = BinReadString(num)      'program to run on entrance
            strUnused = BinReadString(num)      'background program (depreciated)
            
            '3.0.7 - load into TKBoardSprite structures.
            Dim numItm As Long, ubSprs As Long
            numItm = BinReadInt(num)            'The number of written item slots.
            
            For i = 0 To numItm
                Dim spr As CBoardSprite
                Set spr = New CBoardSprite
            
                spr.filename = BinReadString(num)
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
                If LenB(spr.filename) Then
                    ReDim Preserve .sprites(ubSprs)
                    ReDim Preserve .spriteImages(ubSprs)
                    Set .sprites(ubSprs) = spr
                    Call activeBoard.spriteUpdateImageData(spr, spr.filename, True)
                    ubSprs = ubSprs + 1
                End If
            Next i

            Dim tCount As Long

            'Read in threads
            If (minorVer >= 3) Then
                tCount = BinReadLong(num)
                ReDim .Threads(tCount)
                For i = 0 To tCount
                    .Threads(i) = BinReadString(num)
                Next i
            End If

            .coordType = BinReadByte(num)

            If (minorVer < 3) Then
                'Read in threads
                Do Until EOF(num)
                    ReDim Preserve .Threads(tCount)
                    .Threads(tCount) = BinReadString(num)
                    tCount = tCount + 1
                Loop
            End If

        Close num
        
        '3.0.7 - generate program bases after coordinate type is read.
        For i = 0 To UBound(.prgs)
            If Not .prgs(i) Is Nothing Then
                If .prgs(i).filename <> vbNullString Then
                    Call .prgs(i).vBase.getPoint(0, x, y)
                    Call .prgs(i).vBase.deletePoints
                    Call upgradeProgram(.prgs(i), x, y, .coordType)
                End If
            End If
        Next i
        
        '3.0.7 - update item locations to pixel values.
        For i = 0 To UBound(.sprites)
            If Not .sprites(i) Is Nothing Then
                Dim pt As POINTAPI
                pt = modBoard.tileToBoardPixel(.sprites(i).x, .sprites(i).y, .coordType, True, .sizex)
                .sprites(i).x = pt.x
                .sprites(i).y = pt.y
                Call activeBoard.spriteUpdateImageData(.sprites(i), .sprites(i).filename, False)
            End If
        Next i
        
        '3.0.7 - vectorise the tiletypes.
        Call vectorize(ed)
         
        '3.0.7 - upgrade tile lighting.
        For z = 1 To .sizeL
            For y = 1 To .sizey
                For x = 1 To .sizex
                    
                    'Store the highest shading values in the new single layer shade.
                    If (.ambientRed(x, y, z) Or .ambientGreen(x, y, z) Or .ambientBlue(x, y, z)) Then
                        .tileShading(0).values(x, y).r = .ambientRed(x, y, z)
                        .tileShading(0).values(x, y).g = .ambientGreen(x, y, z)
                        .tileShading(0).values(x, y).b = .ambientBlue(x, y, z)
                        
                        'Promote the shading layer to cast onto the highest layer occupied.
                        .tileShading(0).layer = z
                    End If
                Next x
            Next y
        Next z
                    
    End With

End Function

'=========================================================================
' Get a tile
'=========================================================================
Public Function boardGetTile(ByVal x As Long, ByVal y As Long, ByVal layer As Long, ByRef board As TKBoard) As String
    On Error Resume Next
    boardGetTile = board.tileIndex(board.board(x, y, layer))
End Function

'=========================================================================
' Initialise the arrays of a board structure.
'=========================================================================
Public Sub boardInitialise(ByRef board As TKBoard): On Error Resume Next
    
    With board
        '3.0.7
        ReDim .vectors(0)
        ReDim .prgs(0)
        ReDim .spriteImages(0)
        ReDim .sprites(0)
        ReDim .Images(0)
        
        Set .vectors(0) = Nothing
        Set .prgs(0) = Nothing
        Set .sprites(0) = Nothing
        .Images(0).drawType = BI_NULL
        
        ReDim .tileShading(0)               'Single layer lighting.
        ReDim .tileShading(0).values(1, 1)
        .tileShading(0).layer = 1
                
        ReDim .lights(0)                    'Dynamic lighting objects.
        Set .lights(0) = Nothing

        'Pre 3.0.7
        ReDim .tileIndex(0)
        ReDim .board(1, 1, 1)
        ReDim .ambientRed(1, 1, 1)
        ReDim .ambientGreen(1, 1, 1)
        ReDim .ambientBlue(1, 1, 1)
        ReDim .directionalLinks(3)
        ReDim .constants(0)
        ReDim .layerTitles(0)
        ReDim .Threads(0)
        
    End With
End Sub

'=========================================================================
' Size a board losing its current contents
'=========================================================================
Public Sub boardSetSize( _
    ByVal x As Long, _
    ByVal y As Long, _
    ByVal z As Long, _
    ByRef ed As TKBoardEditorData, _
    ByRef board As TKBoard, _
    ByVal bPreserveContents As Boolean): On Error Resume Next
    
    Dim i As Long, j As Long, k As Long, u As Long, v As Long, oldSizeX As Long
    Dim Data() As Integer, r() As Integer, g() As Integer, b() As Integer, shading() As TKLayerShade
    
    'tbd: remove r,g,b
    
    If x < 1 Then x = 1
    If y < 1 Then y = 1
    If z < 1 Then z = 1
    
    With board
        oldSizeX = .sizex               'For ISO_ROTATED
        .sizex = x
        .sizey = y
        .sizeL = z
        
        'Data matrix must be reshaped for ISO_ROTATED
        x = IIf(.coordType And ISO_ROTATED, .sizex + .sizey, .sizex)
        y = IIf(.coordType And ISO_ROTATED, .sizex + .sizey, .sizey)
        ed.effectiveBoardX = x
        ed.effectiveBoardY = y
        
        If bPreserveContents Then
            'Assignment redims left-hand objects
            Data = .board
            r = .ambientRed
            g = .ambientGreen
            b = .ambientBlue
            shading = .tileShading
        End If
            
        ReDim .board(x, y, z)
        ReDim .ambientRed(x, y, z)
        ReDim .ambientGreen(x, y, z)
        ReDim .ambientBlue(x, y, z)
        
        For i = 0 To UBound(.tileShading)
            ReDim .tileShading(i).values(x, y)
        Next i
        
        If bPreserveContents Then
                
            If x > UBound(Data, 1) Then x = UBound(Data, 1)
            If y > UBound(Data, 2) Then y = UBound(Data, 2)
            If z > UBound(Data, 3) Then z = UBound(Data, 3)
            
            'Cannot straight assign since arrays would revert to previous dimensions.
            For k = 0 To z
                For j = 0 To y
                    For i = 0 To x
                        If .coordType And ISO_ROTATED Then
                            'The pixel position of a tile is dependent on the board width.
                            '(Equate pixel positions for different board sizes and solve.)
                            u = i
                            v = j - oldSizeX + .sizex
                        Else
                            u = i
                            v = j
                        End If
                    
                        .board(u, v, k) = Data(i, j, k)
                        .ambientRed(u, v, k) = r(i, j, k)
                        .ambientGreen(u, v, k) = g(i, j, k)
                        .ambientBlue(u, v, k) = b(i, j, k)

                    Next i
                Next j
            Next k
            
            'Tile lighting.
            For j = 0 To y
                For i = 0 To x
                    u = i
                    v = IIf(.coordType And ISO_ROTATED, j - oldSizeX + .sizex, j)
                    For k = 0 To UBound(.tileShading)
                        .tileShading(k).values(u, v) = shading(k).values(i, j)
                    Next k
                Next i
            Next j
                
            ReDim Preserve .layerTitles(.sizeL)
            ReDim Preserve ed.bLayerOccupied(.sizeL)
            ReDim Preserve ed.bLayerVisible(.sizeL)
        
            'Make any new layers visible.
            For k = z + 1 To .sizeL
                ed.bLayerVisible(k) = True
            Next k
        Else
            ReDim .layerTitles(z)
            ReDim ed.bLayerOccupied(z)
            ReDim ed.bLayerVisible(z)
        End If
    End With
End Sub

'=========================================================================
' Set a tile on the board
'=========================================================================
Public Sub boardSetTile(ByVal x As Long, ByVal y As Long, ByVal z As Long, ByVal filename As String, ByRef board As TKBoard) ': On Error Resume Next
    Dim i As Long
    i = boardTileInLut(filename, board)
    board.board(x, y, z) = i
End Sub

Public Sub boardToIsoRotated(ByRef ed As TKBoardEditorData, ByRef board As TKBoard) ':on error resume next
    
    Dim backup As TKBoard, i As Long, j As Long, k As Long, x As Long, y As Long, dx As Double, dy As Double
    If board.coordType <> ISO_STACKED Then Exit Sub
    
    Call modBoard.boardCopy(board, backup)
    board.coordType = ISO_ROTATED
    
    'Convert the tile arrays - programs and sprites are converted to pixel co-ordinates regardless.
    
    'Resize the board arrays to the correct size for ISO_ROTATED.
    
    'Calculate the ISO_ROTATED dimensions from the pixel dimensions.
    x = modBoard.absWidth(board.sizex, ISO_STACKED)
    x = (x + 32) / 64
    y = modBoard.absHeight(board.sizey, ISO_STACKED)
    y = CInt((y + 16) / 32)
    
    'Preserve non-tile contents.
    Call boardSetSize(x, y, board.sizeL, ed, board, True)
    For i = 1 To backup.sizex
        For j = 1 To backup.sizey
            dx = CDbl(i): dy = CDbl(j)
            Call BRDIsometricTransform(dx, dy, ISO_STACKED, ISO_ROTATED, board.sizex)
            x = CInt(dx): y = CInt(dy)
            For k = 1 To board.sizeL
                board.board(x, y, k) = backup.board(i, j, k)
                board.ambientRed(x, y, k) = backup.ambientRed(i, j, k)
                board.ambientGreen(x, y, k) = backup.ambientGreen(i, j, k)
                board.ambientBlue(x, y, k) = backup.ambientBlue(i, j, k)
            Next k
        Next j
    Next i
    
End Sub

Attribute VB_Name = "transMovement"
'=======================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=======================================================================
'Movement info for players and items

Option Explicit

'Movement constants
Public Const MV_IDLE = 0
Public Const MV_NORTH = 1
Public Const MV_SOUTH = 2
Public Const MV_EAST = 3
Public Const MV_WEST = 4
Public Const MV_NE = 5
Public Const MV_NW = 6
Public Const MV_SE = 7
Public Const MV_SW = 8

' Queue versions
Public Const MVQ_IDLE = "0"
Public Const MVQ_NORTH = "1"
Public Const MVQ_SOUTH = "2"
Public Const MVQ_EAST = "3"
Public Const MVQ_WEST = "4"
Public Const MVQ_NE = "5"
Public Const MVQ_NW = "6"
Public Const MVQ_SE = "7"
Public Const MVQ_SW = "8"

' Stance versions
Public Const WALK_N = "walk_n"
Public Const WALK_S = "walk_s"
Public Const WALK_E = "walk_e"
Public Const WALK_W = "walk_w"
Public Const WALK_NE = "walk_ne"
Public Const WALK_NW = "walk_nw"
Public Const WALK_SE = "walk_se"
Public Const WALK_SW = "walk_sw"

'Tile type constants.
'Note: Stairs in the form "stairs + layer number"; i.e. layer = stairs - 10
Public Const NORMAL = 0
Public Const SOLID = 1
Public Const UNDER = 2
Public Const NORTH_SOUTH = 3
Public Const EAST_WEST = 4
Public Const STAIRS1 = 11
Public Const STAIRS2 = 12
Public Const STAIRS3 = 13
Public Const STAIRS4 = 14
Public Const STAIRS5 = 15
Public Const STAIRS6 = 16
Public Const STAIRS7 = 17
Public Const STAIRS8 = 18

Public Type PLAYER_POSITION
    stance As String        'Current stance.
    frame As Long           'Animation frame.
    x As Double             'Current board x position (fraction of tiles).
    y As Double             'Current board y position (fraction of tiles).
    l As Long               'Current layer.
    
    '3.0.5
    loopFrame As Long       'Current frame in a movement loop (different from .frame).
    idleTime As Double      'Length of time this item has been idle for.
    
End Type

Public pPos(4) As PLAYER_POSITION       'Player positions of 5 players.
Public itmPos() As PLAYER_POSITION      'Positions of items on board.
Public selectedPlayer As Long           'Index of current player.

'=========================================================================
' A movement queue
'=========================================================================
Private Type MOVEMENT_QUEUE
    lngSize As Long         ' Size of the queue
    lngMovements() As Long  ' Movements in the queue
End Type

Public Type PENDING_MOVEMENT
    direction As Long       'MV_ direction code.
    xOrig As Double         'Original board co-ordinates.
    yOrig As Double
    lOrig As Long           'Integer levels.
    xTarg As Double         'Target board co-ordinates.
    yTarg As Double
    lTarg As Long
    
    '3.0.5
    queue As MOVEMENT_QUEUE 'The pending movements of the player/item.
End Type

Public pendingPlayerMovement(4) As PENDING_MOVEMENT     'Pending player movements.
Public pendingItemMovement() As PENDING_MOVEMENT        'Pending item movements.

Public Enum FACING_DIRECTION
    SOUTH = 1
    WEST
    NORTH
    EAST
End Enum

Public facing As FACING_DIRECTION

Public loopOffset As Long               '3.0.5 main loop offset.

Public Property Get framesPerMove() As Long
    framesPerMove = 4 * movementSize
    '1 fpm just looks bad, in 1/4 tile movement at least.
    If (framesPerMove < 2) Then framesPerMove = 2
End Property

Public Function checkAbove(ByVal x As Long, ByVal y As Long, ByVal layer As Long) As Long
    'Checks if there are tiles on any layer above x,y,layer
    '0- no, 1-yes
    'Called by putSpriteAt
    On Error Resume Next
    If (layer = boardList(activeBoardIndex).theData.bSizeL) Then Exit Function
    Dim lay As Long
    Dim uptile As String
    For lay = layer + 1 To boardList(activeBoardIndex).theData.bSizeL
        uptile$ = BoardGetTile(x, y, lay, boardList(activeBoardIndex).theData)
        If (LenB(uptile)) Then
            checkAbove = 1
            Exit Function
        End If
    Next lay
End Function

Private Function checkObstruction(ByRef pos As PLAYER_POSITION, ByRef pend As PENDING_MOVEMENT, _
                                  ByVal currentPlayer As Long, ByVal currentItem As Long, _
                                  Optional ByVal startingMove As Boolean = False) As Long
'============================================================================================
'-Checks the current location and target co-ordinates against all player and item locations.
'If the subject comes within a certain range of the object, the a SOLID tiletype is returned.
'-This is to be called every 1/4 tile (or less):
'       - every frame for tile mvt
'       - only at start for pixel mvt (since distances are so small).
'-Tile mvt: If beginning move (if .loopFrame = 0) checks against objects that are moving are
'           ignored since they may vacate the tile during the move. Moving items are detected
'           on a per-frame basis.
'-Pixel mvt:This is only called at the start of a move (if .loopFrame = 0), and all items
'           (both moving / stationary) are considered.
'============================================================================================
'Last edited for 3.0.5 by Delano : individual speed movement.
'Called by EffectiveTileType, MoveItems, MovePlayers, PushItem, PushPlayer

    On Error Resume Next

    Dim i As Long, coordMatch As Boolean
    Dim variableType As RPGC_DT, paras As parameters

    'Altered for pixel movement: test location.

    'Transform pixel isometrics.
    Dim posX As Double, posY As Double, xTarg As Double, yTarg As Double
    Dim tPosX As Double, tPosY As Double, txTarg As Double, tyTarg As Double
    Dim pMovementSize As Double

    Call isoCoordTransform(pos.x, pos.y, posX, posY)
    Call isoCoordTransform(pend.xTarg, pend.yTarg, xTarg, yTarg)

    If (boardList(activeBoardIndex).theData.isIsometric = 1) Then
        pMovementSize = 1       '"Sprite depth"
    Else
        pMovementSize = movementSize
    End If

    'Check players.
    For i = 0 To UBound(pendingPlayerMovement)

        If showPlayer(i) And i <> currentPlayer Then
            'Only if the player is on the board, and is not the player we're checking against.

            Call isoCoordTransform(pPos(i).x, pPos(i).y, tPosX, tPosY)
            Call isoCoordTransform(pendingPlayerMovement(i).xTarg, _
                                   pendingPlayerMovement(i).yTarg, _
                                   txTarg, _
                                   tyTarg)

            If Not (movementSize <> 1) Then
                'Tile movement.

                'Current (test!) location against player current location.
                If _
                    Abs(posY - tPosY) < pMovementSize And _
                    Abs(posX - tPosX) < 1 And _
                    pPos(i).l = pos.l Then

                    'Call traceString("ChkObs:P:T:1")

                    checkObstruction = SOLID
                    Exit Function

                End If

                'Only test targets if we're beginning movement.
                'If we're in movement and the target becomes occupied (if it was occupied at start
                'then movement would be rejected) it must be due to another moving *player*.
                'In this case, continue movement because we can't stop!
                If _
                    Abs(yTarg - tyTarg) < pMovementSize And _
                    Abs(xTarg - txTarg) < 1 And _
                    pPos(i).l = pos.l And _
                    startingMove Then

                    'Call traceString("ChkObs:P:T:2")

                    checkObstruction = SOLID
                    Exit Function

                End If

            Else
                'Pixel movement.
                'Only check this at the start of a move.
                If startingMove Then

                    'Current locations: minimum separations. Probably don't even need these.
                    If _
                        Abs(posY - tPosY) < pMovementSize And _
                        Abs(posX - tPosX) < 1 And _
                        pPos(i).l = pos.l Then

                        'Call traceString("ChkObs:P:PX:1 [!]")

                        checkObstruction = SOLID
                        Exit Function

                    End If

                    'Target location against player current location.
                    If _
                        Abs(tPosY - yTarg) < pMovementSize And _
                        Abs(tPosX - xTarg) < 1 And _
                        pPos(i).l = pos.l Then

                        'Call traceString("ChkObs:P:PX:2")

                        checkObstruction = SOLID
                        Exit Function

                    End If

                    'Target location against player target location.
                    If _
                        Abs(yTarg - tyTarg) < pMovementSize And _
                        Abs(xTarg - txTarg) < 1 And _
                        pPos(i).l = pos.l Then

                        'Call traceString("ChkObs:P:PX:3")

                        checkObstruction = SOLID
                        Exit Function

                    End If

                End If 'startingMove.

            End If 'usingPixelMovement.

        End If 'ShowPlayer.

    Next i

    'Items.
    For i = 0 To (UBound(boardList(activeBoardIndex).theData.itmActivate))

        If (LenB(itemMem(i).itemName) <> 0) And i <> currentItem Then

            Call isoCoordTransform(itmPos(i).x, itmPos(i).y, tPosX, tPosY)
            Call isoCoordTransform(pendingItemMovement(i).xTarg, _
                                   pendingItemMovement(i).yTarg, _
                                   txTarg, _
                                   tyTarg)

            If Not ((movementSize <> 1)) Then
                'Tile movement.

                'Current locations.
                If _
                    Abs(tPosY - posY) < pMovementSize And _
                    Abs(tPosX - posX) < 1 And _
                    itmPos(i).l = pos.l Then

                    coordMatch = Not (startingMove And pendingItemMovement(i).direction <> MV_IDLE)
                 
                End If

                'Only test targets if we're beginning movement.
                'If we're in movement and the target becomes occupied (if it was occupied at start
                'then movement would be rejected) it must be due to another moving *player*.
                'In this case, continue movement because we can't stop!
                If _
                    Abs(yTarg - tyTarg) < pMovementSize And _
                    Abs(xTarg - txTarg) < 1 And _
                    itmPos(i).l = pos.l And _
                    startingMove Then
                    coordMatch = True

                End If

            Else
                'Pixel movement.
                'Only check this at the start of a move.
                If startingMove Then

                    'Current locations: minimum separations. Probably don't even need these.
                    If _
                        Abs(tPosY - posY) < pMovementSize And _
                        Abs(tPosX - posX) < 1 And _
                        itmPos(i).l = pos.l Then

                        coordMatch = True

                        'Call traceString("ChkObs:I:PX:4 [!]")

                    End If

                    'Target against  item current location.
                    If _
                        Abs(tPosY - yTarg) < pMovementSize And _
                        Abs(tPosX - xTarg) < 1 And _
                        itmPos(i).l = pos.l Then

                        coordMatch = True

                        'Call traceString("ChkObs:I:PX:5")

                    End If

                    'Target against item target location.
                    If _
                        Abs(yTarg - tyTarg) < pMovementSize And _
                        Abs(xTarg - txTarg) < 1 And _
                        itmPos(i).l = pos.l Then

                        coordMatch = True

                        'Call traceString("ChkObs:I:PX:6")

                    End If

                End If 'startingMove.

            End If 'usingPixelMovement.

            If coordMatch Then

                'There's an item here, but is it active?
                If boardList(activeBoardIndex).theData.itmActivate(i) = 1 Then

                    'conditional activation
                    variableType = getIndependentVariable(boardList(activeBoardIndex).theData.itmVarActivate(i), paras.lit, paras.num)

                    If variableType = DT_NUM Then
                        'it's a numerical variable

                        If paras.num = val(boardList(activeBoardIndex).theData.itmActivateInitNum(i)) Then
                            checkObstruction = SOLID
                            Exit Function
                        End If
                    End If

                    If variableType = DT_LIT Then
                        'it's a literal variable

                        If paras.lit = boardList(activeBoardIndex).theData.itmActivateInitNum(i) Then
                            checkObstruction = SOLID
                            Exit Function
                        End If
                    End If

                Else

                    'Not conditionally activated - permanently active.
                    checkObstruction = SOLID
                    Exit Function

                End If

            End If 'coordMatch

        End If

    Next i

    'We've got here and no match has been found.
    checkObstruction = NORMAL

End Function

Public Function PathFind(ByVal x1 As Integer, ByVal y1 As Integer, ByVal x2 As Integer, ByVal y2 As Integer, ByVal layer As Integer, ByVal bAllowDiagonal As Boolean, ByVal bFaster As Boolean) As String
    '============================================
    'EDITED: [Delano - 8/05/04]
    'Added commas to the letters as they are added to the return string, for compatibility with
    'the new syntax of the #Push/#PushItem commands.
    'Doesn't work very well on isometric boards and cannot yet generate diagonal paths.
    'Needs a bit more work!
    '============================================
    'Called by PlayerStepRPG, ItemStepRPG, PathFindRPG
    'Possibly not the most efficient routine to use for itemStep or PlayerStep?
    
    'find a path from x1,y1, layer to x2,y2,layer
    'return a string of directions if found, else nothing if no path found.
    
    Dim bChanged As Boolean
    
    Dim sx As Integer, sy As Integer
    Dim iX As Integer, iY As Integer
    
    Dim bestX As Integer, bestY As Integer
    Dim BestScore As Integer
    
    ReDim Score(boardList(activeBoardIndex).theData.bSizeX, boardList(activeBoardIndex).theData.bSizeY) As Integer
    
    'Initialise target square
    Score(x2, y2) = 1
    
    'Note - We are defining the score 0 as being
    'untravellable even though in the tutorial
    'it is the target. This is just so we don't need
    'to have another array
    
    Do
        Call processEvent
        bChanged = False
        For sx = 1 To boardList(activeBoardIndex).theData.bSizeX
            For sy = 1 To boardList(activeBoardIndex).theData.bSizeY
                If Score(sx, sy) Then
                    'This square has been travelled to
                    'Check to see if we can go one step
                    'further
                    For iX = sx - 1 To sx + 1
                        For iY = sy - 1 To sy + 1
                            'Cull some squares (those not on map
                            'or those that are already moved to)
                            If Not (iX <> sx And iY <> sy And Not (bAllowDiagonal)) Then
                                If Not (iX = sx And iY = sy) Then
                                    If iX >= 0 And iX <= boardList(activeBoardIndex).theData.bSizeX Then
                                        If iY >= 0 And iY <= boardList(activeBoardIndex).theData.bSizeY Then
                                            'Now we check to see if
                                            'we can move a bit further
                                            'from (sX, sY) to (iX, iY)
                                            If EffectiveTileType(iX, iY, layer, bFaster) <> 1 Then
                                                'It is walkable
                                                'If we are to move there
                                                'will the new score be an improvement?
                                                If Score(sx, sy) + 1 < Score(iX, iY) Or Score(iX, iY) = 0 Then
                                                    'Yes, so we'll put that score in and
                                                    'set bChanged to True
                                                    Score(iX, iY) = Score(sx, sy) + 1
                                                    bChanged = True
                                                End If ' Score(sx, sy) + 1 < Score(iX, iY) Or Score(iX, iY) = 0
                                            End If ' effectiveTileType(iX, iY, layer, bFaster) <> 1
                                        End If ' iY >= 0 And iY <= boardList(activeBoardIndex).theData.bSizeY
                                    End If ' iX >= 0 And iX <= boardList(activeBoardIndex).theData.bSizeX
                                End If ' Not (iX = sx And iY = sy)
                            End If ' Not (iX <> sx And iY <> sy And Not (bAllowDiagonal))
                        Next ' iY = sy - 1 To sy + 1
                    Next ' iX = sx - 1 To sx + 1
                End If ' Score(sx, sy)
            Next ' sy = 1 To boardList(activeBoardIndex).theData.bSizeY
        Next ' sx = 1 To boardList(activeBoardIndex).theData.bSizeX
    Loop While (bChanged)

    '************************************************
    'We now have a map of the distance from the Target
    'stored, now we just have to find a way through it
    'To do this, we can start at the first point
    'and work our way around, always moving to the
    'point with the closest distance.

    Dim toRet As String
    Dim lastX As Double
    Dim lastY As Double
    If Score(x1, y1) Then
        'We found a path
                
        toRet$ = vbNullString
        
        sx = x1
        sy = y1
        lastX = x1
        lastY = y1
        Do
            bestX = -1
            bestY = -1
            BestScore = 32767 'That's a big number, I hope that there aren't over 32767
            
            For iX = sx - 1 To sx + 1
                For iY = sy - 1 To sy + 1
                    'Cull some squares (those not on map
                    'or those that are already moved to)
                    If Not (iX = sx And iY = sy) Then
                        If iX >= 0 And iX <= boardList(activeBoardIndex).theData.bSizeX Then
                            If iY >= 0 And iY <= boardList(activeBoardIndex).theData.bSizeY Then
                                If Score(iX, iY) < BestScore And Score(iX, iY) Then
                                    BestScore = Score(iX, iY)
                                    bestX = iX
                                    bestY = iY
                                End If ' Score(iX, iY) < BestScore And Score(iX, iY)
                            End If ' iY >= 0 And iY <= boardList(activeBoardIndex).theData.bSizeY
                        End If ' iX >= 0 And iX <= boardList(activeBoardIndex).theData.bSizeX
                    End If ' Not (iX = sx And iY = sy)
                Next ' iY = sy - 1 To sy + 1
            Next ' iX = sx - 1 To sx + 1

            If bestX = -1 Then
                'If somehow the next point is not
                'found then throw an error.
                'Lucky 19023 =)
                Error 19023
                PathFind = vbNullString
                Exit Function
            End If

            If bestY <> lastY And bestX <> lastX Then
                'it's diagonal-- determine how the
                'diagonal will be navigated.
                If bestY > lastY And bestX > lastX Then
                    'SE
                    If EffectiveTileType(lastX, bestY, layer, bFaster) <> 1 Then
                    'If boardlist(activeboardindex).thedata.tiletype(lastX, bestY, layer) <> 1 Then
                        
                        'Edit!: Added commas for compatibility with the #Push/#PushItem commands.
                        toRet$ = toRet & "S,E,"
                    Else
                        toRet$ = toRet & "E,S,"
                    End If
                End If
                If bestY > lastY And bestX < lastX Then
                    'SW
                    If EffectiveTileType(lastX, bestY, layer, bFaster) <> 1 Then
                    'If boardlist(activeboardindex).thedata.tiletype(lastX, bestY, layer) <> 1 Then
                        toRet$ = toRet & "S,W,"
                    Else
                        toRet$ = toRet & "W,S,"
                    End If
                End If
                If bestY < lastY And bestX > lastX Then
                    'NE
                    If EffectiveTileType(lastX, bestY, layer, bFaster) <> 1 Then
                    'If boardlist(activeboardindex).thedata.tiletype(lastX, bestY, layer) <> 1 Then
                        toRet$ = toRet & "N,E,"
                    Else
                        toRet$ = toRet & "E,N,"
                    End If
                End If
                If bestY < lastY And bestX < lastX Then
                    'NW
                    If EffectiveTileType(lastX, bestY, layer, bFaster) <> 1 Then
                    'If boardlist(activeboardindex).thedata.tiletype(lastX, bestY, layer) <> 1 Then
                        toRet$ = toRet & "N,W,"
                    Else
                        toRet$ = toRet & "W,N,"
                    End If
                End If
            Else
                If bestY > lastY Then
                    toRet$ = toRet & "S,"
                Else
                    If bestY <> lastY Then
                        toRet$ = toRet & "N,"
                    End If
                End If
                
                If bestX > lastX Then
                    toRet$ = toRet & "E,"
                Else
                    If bestX <> lastX Then
                        toRet$ = toRet & "W,"
                    End If
                End If
            End If
            
            lastX = bestX
            lastY = bestY
            
            If bestX = x2 And bestY = y2 Then Exit Do
            
            sx = bestX
            sy = bestY
            
            Call processEvent
        Loop
        
        'Edit: we now have a string with an extra comma on the end, so:
        toRet$ = Left$(toRet$, Len(toRet$) - 1)
       
        'Hopefully everything is done. Yay
        PathFind = toRet$

        
    Else
        'We didn't
        PathFind = vbNullString
    End If
End Function

Private Function EffectiveTileType(ByVal x As Integer, ByVal y As Integer, ByVal l As Integer, ByVal bFast As Boolean) As Integer
    '===============================
    'return the effective tile type, checking for obstructions.
    '===============================
    'Called by PathFind only.
    On Error Resume Next
    
    Dim typetile As Long
    typetile = boardList(activeBoardIndex).theData.tiletype(x, y, l)
    
    If bFast Then
        EffectiveTileType = typetile
        Exit Function
    End If
    
    Dim testPos As PLAYER_POSITION, testPend As PENDING_MOVEMENT
    testPos.x = x
    testPos.y = y
    testPos.l = l
    testPend.xTarg = x
    testPend.yTarg = y
       
    
    If checkObstruction(testPos, testPend, -1, -1) = SOLID Then
        'Call programtest(testx, testy, testlayer, keycode, facing)
        typetile = SOLID
        'Exit Sub
    End If
    
    
    'check for tiles above...
    Dim underneath As Long
    underneath = checkAbove(x, y, l)
    
    'if we're sitting on stairs, forget about tiles above.
    If typetile >= STAIRS1 And typetile <= STAIRS8 Then
        typetile = NORMAL
        underneath = 0
    End If
    
    If underneath = 1 And typetile <> SOLID Then
        typetile = UNDER
    End If
    
    EffectiveTileType = typetile
End Function

Private Function TestLink(ByVal playerNum As Long, ByVal theLink As Long) As Boolean
    '===============================================================================
    'If player walks off the edge, checks to see if a link is present and if it's
    'possible to go there. If so, then player is sent, and True returned, else False.
    'thelink is a number from 1-4  1-North, 2-South, 3-East, 4-West.
    'Code also present to check and run a program instead of a board.
    'Called by CheckEdges only.
    '===============================================================================
    On Error Resume Next

    'Screen co-ords held in temporary varibles in case true variables altered.
    Dim topXtemp As Double, topYtemp As Double
    topXtemp = topX
    topYtemp = topY

    Dim targetBoard As String
    targetBoard = boardList(activeBoardIndex).theData.dirLink(theLink)

    If (LenB(targetBoard) = 0) Then
        ' No link exists
        Exit Function
    End If

    If (UCase$(GetExt(targetBoard)) = "PRG") Then
        ' Simply run this program:
        Call runProgram(projectPath & prgPath & targetBoard)
        TestLink = True
        Exit Function
    End If

    Dim testX As Long, testY As Long, testLayer As Long
    testX = pPos(playerNum).x
    testY = pPos(playerNum).y
    testLayer = pPos(playerNum).l

    'Isometric addition: sprites jump when moving to new boards.
    'Y has to remain even or odd during transition, rather than just moving to the bottom row.
    'New function: linkIso, to check if the target board is iso. If so, sends to different co-ords.

    Dim targetX As Long, targetY As Long 'Target board dimensions

    Select Case theLink

        Case MV_NORTH

            'Get dimensions of target board.
            Call boardSize(projectPath & brdPath & targetBoard, targetX, targetY)
            testY = targetY 'The bottom row of the board

            'Only notice if you move from iso to normal boards
            'Trial with new function. If bad then use (boardList(activeBoardIndex).theData.isIsometric = 1)
            If linkIso(projectPath & brdPath & targetBoard) Then
                If pPos(playerNum).y Mod 2 <> targetY Mod 2 Then
                    testY = testY - 1
                End If
            End If

        Case MV_SOUTH

            testY = 1
            'Trial with new function. If bad then use (boardList(activeBoardIndex).theData.isIsometric = 1)
            If linkIso(projectPath & brdPath & targetBoard) Then
                testY = 3
                If pPos(playerNum).y Mod 2 = 0 Then
                    testY = testY - 1
                End If
            End If

        Case MV_EAST
            testX = 1

        Case MV_WEST
            'Get the dimensions of the target board.
            Call boardSize(projectPath & brdPath & targetBoard, targetX, targetY)
            testX = targetX

    End Select

    ' Now see if the space is ok
    Dim targetTile As Long
    targetTile = TestBoard(projectPath & brdPath & targetBoard, testX, testY, testLayer)

    'If ((targetTile = -1) Or (targetTile = SOLID)) Then
    If (targetTile = -1) Then
        'If board doesn't exist or board smaller than target location (-1) OR target tile is solid.
        'Stay at current position.
        topX = topXtemp
        topY = topYtemp
        TestLink = False
        Exit Function
    End If

    'Else targetTile is passable.

    'If we can go, then we will

    With pPos(playerNum)
        .x = testX
        .y = testY
        .l = testLayer
        pendingPlayerMovement(selectedPlayer).xOrig = .x
        pendingPlayerMovement(selectedPlayer).yOrig = .y
        pendingPlayerMovement(selectedPlayer).xTarg = .x
        pendingPlayerMovement(selectedPlayer).yTarg = .y
        .loopFrame = -1
    End With

    Call ClearNonPersistentThreads
    Call destroyItemSprites
    Call openBoard(projectPath & brdPath & targetBoard, boardList(activeBoardIndex).theData)
    Call clearAnmCache  'Delano. 3.0.4.

    'Clear the player's last frame render, to force a redraw directly on entering.
    '(Prevents players starting new boards with old frame).
    lastPlayerRender(selectedPlayer).canvas = -1
    scTopX = -1000
    scTopY = -1000

    Call alignBoard(pPos(selectedPlayer).x, pPos(selectedPlayer).y)
    Call openItems
    Call renderNow(-1, True)
    Call canvasGetScreen(cnvRPGCodeScreen)
    
    Call launchBoardThreads(boardList(activeBoardIndex).theData)
    
    'Set the state to GS_DONEMOVE, rather than finishing the last frames (caused pause on moving to new board).
    gGameState = GS_DONEMOVE
    
    'Run the program to run on entering board.
    If LenB(boardList(activeBoardIndex).theData.enterPrg) Then
        Call runProgram(projectPath & prgPath & boardList(activeBoardIndex).theData.enterPrg)
    End If

    TestLink = True

End Function

Private Function CheckEdges(ByRef pend As PENDING_MOVEMENT, ByVal playerNum As Long) As Boolean
    'check if the player has gone off an edge
    'if he has, we put him on the new board or in a new location and return true
    'else return false
    
    On Error Resume Next
    
    Dim bWentThere As Boolean
    
    If pend.yTarg < 1 Then
        'too far north
        bWentThere = TestLink(playerNum, MV_NORTH)
        If bWentThere Then
            CheckEdges = True
            Exit Function
        Else
            CheckEdges = True
            Exit Function
        End If
    ElseIf pend.yTarg > boardList(activeBoardIndex).theData.bSizeY Then
        'too far south!
        bWentThere = TestLink(playerNum, MV_SOUTH)
        If bWentThere Then
            CheckEdges = True
            Exit Function
        Else
            CheckEdges = True
            Exit Function
        End If
    ElseIf pend.xTarg < 1 Then
        'too far west!
        bWentThere = TestLink(playerNum, MV_WEST)
        If bWentThere Then
            CheckEdges = True
            Exit Function
        Else
            CheckEdges = True
            Exit Function
        End If
    ElseIf pend.xTarg > boardList(activeBoardIndex).theData.bSizeX Then
        'too far east!
        bWentThere = TestLink(playerNum, MV_EAST)
        If bWentThere Then
            CheckEdges = True
            Exit Function
        Else
            CheckEdges = True
            Exit Function
        End If
    End If
    CheckEdges = False
End Function

Public Function obtainTileType(ByVal testX As Double, _
                               ByVal testY As Double, _
                               ByVal testL As Long, _
                               ByVal direction As Long, _
                               ByRef passPos As PLAYER_POSITION, _
                               Optional ByVal activeItem As Long = -1) As Byte

    '===========================================================
    'Determines the effective tile type at the test co-ords
    'by considering items, tiletypes and stairs.
    'Items at the location will block movement.
    'The player is moved to the new level on stairs.
    '============================================================
    'Last edited for 3.0.5 by Delano: isometrics, pixel movement.

    'Called by the pushPlayer and pushItem subs.
    On Error Resume Next
    
    Dim typetile As Byte, first As Byte, second As Byte
    Dim underneath As Long
    
    'typetile = boardTileType(testX, testY, testL, thelink)
    
    If testX < 1 Or testY < 1 Then Exit Function
    
    If Not ((movementSize <> 1)) Then
    'If True Then
    
        'Tiletype at the target.
        If (boardList(activeBoardIndex).theData.isIsometric = 1) Then
            'Call invIsoCoordTransform(testX, testY, testX, testY)
            typetile = boardList(activeBoardIndex).theData.tiletype(testX, testY, testL)
        Else
            typetile = boardList(activeBoardIndex).theData.tiletype(testX, testY, testL)
        End If
        
    Else
    
        If (boardList(activeBoardIndex).theData.isIsometric = 1) Then
        
            '========================================================================
            ' Co-ordinate transform! New type to old.
            
            'Ok, we use the non-isometric rounding values, but switch cases since we've rotated
            'the grid. However, all the .tileType() values are referenced in the old co-ordinate
            'system.
            'First, transform to the new system, then do the roundings, transform back, get the
            'tiletype.
            
            '# denotes transformed tiles. Don't remove commented code!
            
            Dim trX As Double, trY As Double
            'Transform.
            Call isoCoordTransform(testX, testY, testX, testY)
            
            With boardList(activeBoardIndex).theData
                Select Case direction
                 Case MV_NE
                     '#first = .tiletype(Int(testX), Int(testY), testL)  'To stay away!
                     '#second = .tiletype(-Int(-testX), Int(testY), testL)
                     ''first = .tileType(Int(testX), -Int(-testY), testL) 'To approach walls.
                     ''second = .tileType(-Int(-testX), -Int(-testY), testL)
                     
                     'Inverse transform: [to stay away - different to 2D]
                     Call invIsoCoordTransform(Int(testX), Int(testY), trX, trY)
                     first = .tiletype(trX, trY, testL)
                     Call invIsoCoordTransform(-Int(-testX), Int(testY), trX, trY)
                     second = .tiletype(trX, trY, testL)
                     
                     
                 Case MV_SW
                     '#first = .tileType(Int(testX), -Int(-testY), testL)
                     '#second = .tileType(-Int(-testX), -Int(-testY), testL)
                 
                     'Transform:
                     Call invIsoCoordTransform(Int(testX), -Int(-testY), trX, trY)
                     first = .tiletype(trX, trY, testL)
                     Call invIsoCoordTransform(-Int(-testX), -Int(-testY), trX, trY)
                     second = .tiletype(trX, trY, testL)
                 
                 
                 Case MV_SE
                     '#first = .tileType(-Int(-testX), -Int(-testY), testL)
                     '#second = .tiletype(-Int(-testX), Int(testY), testL)    'To stay away!
                 
                     'Transform: [to approach]
                     Call invIsoCoordTransform(-Int(-testX), -Int(-testY), trX, trY)
                     first = .tiletype(trX, trY, testL)
                     Call invIsoCoordTransform(-Int(-testX), Int(testY), trX, trY)
                     second = .tiletype(trX, trY, testL)
                 
                 Case MV_NW
                     '#first = .tileType(Int(testX), -Int(-testY), testL)
                     '#second = .tiletype(Int(testX), Int(testY), testL)      'To stay away!
                     
                     'Transform: [to stay away]
                     Call invIsoCoordTransform(Int(testX), -Int(-testY), trX, trY)
                     first = .tiletype(trX, trY, testL)
                     Call invIsoCoordTransform(Int(testX), Int(testY), trX, trY)
                     second = .tiletype(trX, trY, testL)
                
                 
                 'Problems if approaching walls.
                 Case MV_EAST
                     ''typetile = .tiletype(-Int(-testX), -Int(-testY), testL)
                     
                     ''The current type.
                     '#typetile = .tileType(Int(testX), -Int(-testY), testL)
                         
                     'Transform: [to approach]
                     Call invIsoCoordTransform(Int(testX), -Int(-testY), trX, trY)
                     typetile = .tiletype(trX, trY, testL)
                         
                         
                     If testX > Int(testX) Then
                         'We're crossing two tiles horizontally. Test the tile to the right.
                         '#typetile = .tileType(-Int(-testX), -Int(-testY), testL)
                         
                         'Transform: [to approach]
                         Call invIsoCoordTransform(-Int(-testX), -Int(-testY), trX, trY)
                         typetile = .tiletype(trX, trY, testL)
                         
                     End If
                     If testY > Int(testY) Then
                         ''We're moving to two tiles vertically. Test tiles above and to the right.
                         '#first = .tileType(Int(testX), Int(testY), testL)
                         '#second = .tileType(-Int(-testX), Int(testY), testL)
                         
                         'Transform: [to approach]
                         Call invIsoCoordTransform(Int(testX), Int(testY), trX, trY)
                         first = .tiletype(trX, trY, testL)
                         Call invIsoCoordTransform(-Int(-testX), Int(testY), trX, trY)
                         second = .tiletype(trX, trY, testL)
                         
                     End If
                     
                     
                 Case MV_NORTH
                     ''typetile = .tiletype(Int(testX), -Int(-testY), testL)
                     
                     ''The current type.
                     '#typetile = .tileType(Int(testX), -Int(-testY), testL)
                      
                     'Transform: [to approach]
                     Call invIsoCoordTransform(Int(testX), -Int(-testY), trX, trY)
                     typetile = .tiletype(trX, trY, testL)
                         
                     If testX > Int(testX) Then
                         'We're crossing two tiles horizontally. Test the tile to the left.
                         typetile = .tiletype(Int(testX), -Int(-testY), testL)
                         
                         'Transform: [to approach]
                         Call invIsoCoordTransform(Int(testX), -Int(-testY), trX, trY)
                         typetile = .tiletype(trX, trY, testL)
                         
                     End If
                     If testY > Int(testY) Then
                         ''We're moving up to two tiles. Test tiles above and to the left.
                         '#first = .tileType(Int(testX), Int(testY), testL)
                         '#second = .tileType(-Int(-testX), Int(testY), testL)
                         
                         'Transform: [to approach]
                         Call invIsoCoordTransform(Int(testX), Int(testY), trX, trY)
                         first = .tiletype(trX, trY, testL)
                         Call invIsoCoordTransform(-Int(-testX), Int(testY), trX, trY)
                         second = .tiletype(trX, trY, testL)
                         
                     End If
                     
                     
                 Case MV_SOUTH
                     ''typetile = .tiletype(-Int(-testX), -Int(-testY), testL)
                     
                     ''The current type.
                     '#typetile = .tileType(Int(testX), -Int(-testY), testL)
                     
                     'Transform: [to approach]
                     Call invIsoCoordTransform(Int(testX), -Int(-testY), trX, trY)
                     typetile = .tiletype(trX, trY, testL)
                     
                     If testX > Int(testX) Then
                         ''We're crossing two tiles horizontally. Test the tile to the right.
                         '#typetile = .tileType(-Int(-testX), -Int(-testY), testL)
                         
                         'Transform: [to approach]
                         Call invIsoCoordTransform(-Int(-testX), -Int(-testY), trX, trY)
                         typetile = .tiletype(trX, trY, testL)
                         
                     End If
                     If testY - movementSize = Int(testY) Then
                         ''We're moving down to two tiles. Test tiles above and to the right.
                         '#first = .tileType(Int(testX), -Int(-testY), testL)
                         '#second = .tileType(-Int(-testX), -Int(-testY), testL)
                     
                         'Transform: [to approach]
                         Call invIsoCoordTransform(Int(testX), -Int(-testY), trX, trY)
                         first = .tiletype(trX, trY, testL)
                         Call invIsoCoordTransform(-Int(-testX), -Int(-testY), trX, trY)
                         second = .tiletype(trX, trY, testL)
                         
                     End If
                     
                     
                 Case MV_WEST
                     ''typetile = .tiletype(Int(testX), -Int(-testY), testL)
                     
                     ''The current type.
                     '#typetile = .tileType(Int(testX), -Int(-testY), testL)
                     
                     'Transform: [to approach]
                     Call invIsoCoordTransform(Int(testX), -Int(-testY), trX, trY)
                     typetile = .tiletype(trX, trY, testL)
                     
                     If testX > Int(testX) Then
                         ''We're crossing two tiles horizontally. Test the tile to the left.
                         '#typetile = .tileType(Int(testX), -Int(-testY), testL)
                         
                         'Transform: [to approach]
                         Call invIsoCoordTransform(Int(testX), -Int(-testY), trX, trY)
                         typetile = .tiletype(trX, trY, testL)
                         
                         
                     End If
                     If testY - movementSize = Int(testY) Then
                         ''We're moving down to two tiles. Test tiles above and to the left.
                         '#first = .tileType(Int(testX), -Int(-testY), testL)
                         '#second = .tileType(-Int(-testX), -Int(-testY), testL)
                         
                         'Transform: [to approach]
                         Call invIsoCoordTransform(Int(testX), -Int(-testY), trX, trY)
                         first = .tiletype(trX, trY, testL)
                         Call invIsoCoordTransform(-Int(-testX), -Int(-testY), trX, trY)
                         second = .tiletype(trX, trY, testL)
    
                     End If
                     
                End Select
            End With
            
            'All done! transform testX,testY back.
            Call invIsoCoordTransform(testX, testY, testX, testY)
                
        '==================== end transform ================================
        
        Else
            '2D board.
    
             With boardList(activeBoardIndex).theData
                 Select Case direction
                     Case MV_NORTH
                         'first = .tiletype(Int(testX), Int(testY), testL)  'To stay away!
                         'second = .tiletype(-Int(-testX), Int(testY), testL)
                         first = .tiletype(Int(testX), -Int(-testY), testL) 'To approach walls.
                         second = .tiletype(-Int(-testX), -Int(-testY), testL)
                     Case MV_SOUTH
                         first = .tiletype(Int(testX), -Int(-testY), testL)
                         second = .tiletype(-Int(-testX), -Int(-testY), testL)
                     Case MV_EAST
                         first = .tiletype(-Int(-testX), -Int(-testY), testL)
                         'second = .tiletype(-Int(-testX), Int(testY), testL)    'To stay away!
                     Case MV_WEST
                         first = .tiletype(Int(testX), -Int(-testY), testL)
                         'second = .tiletype(Int(testX), Int(testY), testL)      'To stay away!
                         
                     'Problems if approaching walls.
                     Case MV_NE
                         'typetile = .tiletype(-Int(-testX), -Int(-testY), testL)
                         
                         'The current type.
                         typetile = .tiletype(Int(testX), -Int(-testY), testL)
                             
                         If testX > Int(testX) Then
                             'We're crossing two tiles horizontally. Test the tile to the right.
                             typetile = .tiletype(-Int(-testX), -Int(-testY), testL)
                             
                         End If
                         If testY = Int(testY) Then
                             'We're moving to two tiles vertically. Test tiles above and to the right.
                             first = .tiletype(Int(testX), Int(testY), testL)
                             second = .tiletype(-Int(-testX), Int(testY), testL)
                             
                         End If
                         
                         
                     Case MV_NW
                         'typetile = .tiletype(Int(testX), -Int(-testY), testL)
                         
                         'The current type.
                         typetile = .tiletype(Int(testX), -Int(-testY), testL)
                          
                         If testX > Int(testX) Then
                             'We're crossing two tiles horizontally. Test the tile to the left.
                             typetile = .tiletype(Int(testX), -Int(-testY), testL)
                             
                         End If
                         If testY = Int(testY) Then
                             'We're moving up to two tiles. Test tiles above and to the left.
                             first = .tiletype(Int(testX), Int(testY), testL)
                             second = .tiletype(-Int(-testX), Int(testY), testL)
                         End If
                         
                         
                     Case MV_SE
                         'typetile = .tiletype(-Int(-testX), -Int(-testY), testL)
                         
                         'The current type.
                         typetile = .tiletype(Int(testX), -Int(-testY), testL)
                         
                         If testX > Int(testX) Then
                             'We're crossing two tiles horizontally. Test the tile to the right.
                             typetile = .tiletype(-Int(-testX), -Int(-testY), testL)
                             
                         End If
                         If testY - movementSize = Int(testY) Then
                             'We're moving down to two tiles. Test tiles above and to the right.
                             first = .tiletype(Int(testX), -Int(-testY), testL)
                             second = .tiletype(-Int(-testX), -Int(-testY), testL)
                         
                         End If
                         
                         
                     Case MV_SW
                         'typetile = .tiletype(Int(testX), -Int(-testY), testL)
                         
                         'The current type.
                         typetile = .tiletype(Int(testX), -Int(-testY), testL)
                         
                         If testX > Int(testX) Then
                             'We're crossing two tiles horizontally. Test the tile to the left.
                             typetile = .tiletype(Int(testX), -Int(-testY), testL)
                             
                         End If
                         If testY - movementSize = Int(testY) Then
                             'We're moving down to two tiles. Test tiles above and to the left.
                             first = .tiletype(Int(testX), -Int(-testY), testL)
                             second = .tiletype(-Int(-testX), -Int(-testY), testL)

                         End If

                 End Select
             End With

        End If 'boardIso

        Dim i As Byte
        For i = SOLID To STAIRS8
            If (first = i Or second = i) Then
                typetile = i
                Exit For
            End If
        Next i

    End If '(usingPixelMovement)

    'check for tiles above...
    underneath = checkAbove(testX, testY, testL)

    'if we're sitting on stairs, forget about tiles above.
    If typetile >= STAIRS1 And typetile <= STAIRS8 Then
        passPos.l = typetile - 10
        typetile = NORMAL
        underneath = 0
    End If

    If typetile = EAST_WEST And (direction = MV_EAST Or direction = MV_WEST) Then
        typetile = NORMAL   'if ew normal, carry on as if it were normal
    End If

    If typetile = NORTH_SOUTH And (direction = MV_SOUTH Or direction = MV_NORTH) Then
        typetile = NORMAL   'if ns normal, carry on as if it were normal
    End If

    If underneath = 1 And typetile <> SOLID Then
        typetile = UNDER
    End If

    'Added: Prevent players from crossing corners of solid tiles on isometric boards:
    Dim leftTile As Byte, rightTile As Byte, aboveTile As Byte, belowTile As Byte

    If (boardList(activeBoardIndex).theData.isIsometric = 1) And Not (movementSize <> 1) Then
        'Check if the tiles above and below the movement are solid.
        'We get the location with respect to the *test* (target) co-ordinates.
        With boardList(activeBoardIndex).theData
            Select Case direction
                Case MV_NORTH:
                    If testY Mod 2 = 0 Then
                        'Even y
                        leftTile = .tiletype(testX - 1, testY + 1, testL)
                        rightTile = .tiletype(testX, testY + 1, testL)
                    Else
                        'Odd y
                        leftTile = .tiletype(testX, testY + 1, testL)
                        rightTile = .tiletype(testX + 1, testY + 1, testL)
                    End If
                Case MV_SOUTH:
                    If testY Mod 2 = 0 Then
                        'Even y
                        leftTile = .tiletype(testX - 1, testY - 1, testL)
                        rightTile = .tiletype(testX, testY - 1, testL)
                    Else
                        'Odd y
                        leftTile = .tiletype(testX, testY - 1, testL)
                        rightTile = .tiletype(testX + 1, testY - 1, testL)
                    End If
                Case MV_EAST:
                    If testY Mod 2 = 0 Then
                        'Even y
                        aboveTile = .tiletype(testX - 1, testY - 1, testL)
                        belowTile = .tiletype(testX - 1, testY + 1, testL)
                    Else
                        'Odd y
                        aboveTile = .tiletype(testX, testY - 1, testL)
                        belowTile = .tiletype(testX, testY + 1, testL)
                    End If
                 Case MV_WEST:
                    If testY Mod 2 = 0 Then
                        'Even y
                        aboveTile = .tiletype(testX, testY - 1, testL)
                        belowTile = .tiletype(testX, testY + 1, testL)
                    Else
                        'Odd y
                        aboveTile = .tiletype(testX + 1, testY - 1, testL)
                        belowTile = .tiletype(testX + 1, testY + 1, testL)
                    End If
            End Select
        End With
        If (leftTile = SOLID Xor rightTile = SOLID) Or (aboveTile = SOLID Xor belowTile = SOLID) Then
            'Block the movement if one adajecent tile is solid, but not both (Xor).
            'Two solid tiles suggests the player should be able to pass between the tiles.
            typetile = SOLID
        End If
    End If

    obtainTileType = typetile

End Function

Public Function moveItems(Optional ByVal singleItem As Long = -1) As Boolean: On Error Resume Next
'===========================================================
'Loops over items and checks/sets the movement state.
'Returns whether any movement occured.
'If singleItem supplied, will only move this item.
'Called by: gameLogic, runQueuedMovements
'===========================================================

    Dim itmIdx As Long
    Static staticTileType() As Byte
    ReDim Preserve staticTileType(UBound(pendingItemMovement))

    For itmIdx = 0 To UBound(pendingItemMovement)
        'All of these items will be in view.
        If singleItem = itmIdx Or singleItem = -1 Then

            If itmPos(itmIdx).loopFrame <= 0 Then
                'Parse the queue.
                pendingItemMovement(itmIdx).direction = getQueuedMovement(pendingItemMovement(itmIdx).queue)

                If pendingItemMovement(itmIdx).direction <> MV_IDLE Then

                    'Insert the target co-ordinates.
                    Call insertTarget(pendingItemMovement(itmIdx))

                    'Get the tiletype once.
                    With pendingItemMovement(itmIdx)

                        'The board tile isn't going anywhere during the move; get it once.
                        staticTileType(itmIdx) = obtainTileType(.xTarg, _
                                                   .yTarg, _
                                                   .lTarg, _
                                                   .direction, _
                                                   itmPos(itmIdx), _
                                                   itmIdx)
                    End With

                    'Check for stationary items only (for tile mvt).
                    'Check all items now only (for pixel mvt).
                    If checkObstruction(itmPos(itmIdx), _
                                        pendingItemMovement(itmIdx), _
                                        -1, _
                                        itmIdx, _
                                        True) _
                                        = SOLID Then
                                        
                        staticTileType(itmIdx) = SOLID
                        
                    End If

                    'We can start moving.
                    itmPos(itmIdx).loopFrame = 0

                    With itemMem(itmIdx)
                        'Normalise the speed to the average mainloop time.
                        'Also, add the gamespeed loopoffset here.
                        'Scale the offset to match the fps. Take a 10th of the fps.
                        .loopSpeed = Round(.speed / gAvgTime) + (loopOffset * Round((1 / gAvgTime) / 10))

                        'Check divide by zero.
                        If (.loopSpeed <= 0) Then .loopSpeed = 1

                    End With

                End If '.direction <> MV_IDLE

            End If '.loopFrame < 0

            If pendingItemMovement(itmIdx).direction <> MV_IDLE Then

                If pushItem(itmIdx, staticTileType(itmIdx)) Then
                    'Only increment the frames if movement was successful.

                    With itmPos(itmIdx)

                        If .loopFrame Mod (itemMem(itmIdx).loopSpeed / movementSize) = 0 Then
                            'Only increment the frame if we're on a multiple of .speed.
                            '/ movementSize to handle pixel movement.
                            .frame = .frame + 1
                        End If

                        .loopFrame = .loopFrame + 1

                        If .loopFrame = framesPerMove * itemMem(itmIdx).loopSpeed Then
                            'The item has finished moving, update origin, reset the counter.

                            With pendingItemMovement(itmIdx)
                                .direction = MV_IDLE
                                .xOrig = .xTarg
                                .yOrig = .yTarg
                                .lOrig = itmPos(itmIdx).l
                                itmPos(itmIdx).x = .xTarg
                                itmPos(itmIdx).y = .yTarg
                            End With

                            'Start the idle timer:
                            .idleTime = Timer()

                            .loopFrame = 0

                        End If

                    End With 'itmPos(itmIdx)

                End If 'pushItem

                'Movement occured (or was blocked), return True.
                moveItems = True

            End If '.direction <> MV_IDLE

        End If 'singleItem = itmIdx or -1

    Next itmIdx

End Function

Private Function pushItem(ByVal itemNum As Long, ByVal staticTileType As Byte) As Boolean: On Error Resume Next
'==========================================================
'Pushes a single item a fraction of a total move.
'Called by moveItems only.
'==========================================================

    'Check board dimensions.
    With pendingItemMovement(itemNum)
        If _
            .yTarg < 1 Or _
            .xTarg < 1 Or _
            .yTarg > boardList(activeBoardIndex).theData.bSizeY Or _
            .xTarg > boardList(activeBoardIndex).theData.bSizeX Then
    
            Exit Function
        End If
    End With

    'Select the stance direction - surely .stance shouldn't be a string!!
    With itmPos(itemNum)
        Select Case pendingItemMovement(itemNum).direction
            Case MV_NORTH: .stance = WALK_N
            Case MV_SOUTH: .stance = WALK_S
            Case MV_EAST: .stance = WALK_E
            Case MV_WEST: .stance = WALK_W
            Case MV_NE: .stance = WALK_NE
            Case MV_NW: .stance = WALK_NW
            Case MV_SE: .stance = WALK_SE
            Case MV_SW: .stance = WALK_SW
        End Select
    End With

    'Ok, we have to insert the new fractional co-ords into a
    'test pos to see if we can move this frame.
    Dim testPos As PLAYER_POSITION, testPend As PENDING_MOVEMENT
    Dim moveFraction As Double      'From moveItems

    testPos = itmPos(itemNum)
    testPend = pendingItemMovement(itemNum)

    'moveFraction is a fraction of the tile.
    moveFraction = movementSize / (framesPerMove * itemMem(itemNum).loopSpeed)

    'Insert the new fractional co-ords into the test location.
    Call incrementPosition(testPos, testPend, moveFraction)

    'Now, check the new co-ords for blocking objects.
    If _
        staticTileType = SOLID Or _
        checkObstruction(testPos, testPend, -1, itemNum) = SOLID Then
        'The new co-ords are blocked, or the target is permanently blocked.
        'All other tiletypes are evaluated to either NORMAL or UNDER, so
        'we don't need to any other checks.
        Exit Function
    End If

    'We can move:
    itmPos(itemNum) = testPos

    pushItem = True

End Function

Public Function movePlayers(Optional ByVal singlePlayer As Long = -1) As Boolean: On Error Resume Next
'======================================================
'Loops over players and checks/sets the movement state.
'Returns whether any movement occured.
'If singlePlayer supplied, will only move that player.
'Called by: gameLogic, runQueuedMovements
'======================================================

    Dim playerIdx As Long
    Static staticTileType() As Byte
    ReDim Preserve staticTileType(UBound(pendingPlayerMovement))

    For playerIdx = 0 To UBound(pendingPlayerMovement)

        If ((showPlayer(playerIdx)) And ((singlePlayer = playerIdx) Or (singlePlayer = -1))) Then
            ' If player is visible, or we're running this for singlePlayer only

            If (pPos(playerIdx).loopFrame < 0) Then
                ' Negative value indicates idle status

                ' Parse the queue
                pendingPlayerMovement(playerIdx).direction = getQueuedMovement(pendingPlayerMovement(playerIdx).queue)

                If (pendingPlayerMovement(playerIdx).direction <> MV_IDLE) Then

                    ' Insert the target co-ordinates
                    Call insertTarget(pendingPlayerMovement(playerIdx))

                    ' All cases: We only need to get the tiletype once in a move since it's not
                    '            going to change.
                    ' Tile mv:   Check for stationary items, ignore moving items right now
                    '            but check for them on a per-frame basis.
                    ' Pixel mv:  Check all items now: no checks during movement. The increments
                    '            ( <= 1/16th tile) are too small to notice. Moving items block
                    '            whole movement.

                    ' Evaluate the tiletype at the target (from tiles only).
                    With pendingPlayerMovement(playerIdx)

                        staticTileType(playerIdx) = obtainTileType(.xTarg, _
                                                   .yTarg, _
                                                   .lTarg, _
                                                   .direction, _
                                                   pPos(playerIdx))
                    End With

                    ' Check for stationary items only (for tile mvt).
                    ' Check all items only now (for pixel mvt).
                    If (checkObstruction(pPos(playerIdx), _
                                        pendingPlayerMovement(playerIdx), _
                                        playerIdx, _
                                        -1, _
                                        True) _
                                        = SOLID) Then

                        staticTileType(playerIdx) = SOLID

                    End If

                    ' We can start movement!
                    pPos(playerIdx).loopFrame = 0

                    With playerMem(playerIdx)

                        ' Normalise the speed to the average mainloop time.
                        ' Scale the offset to match the fps. Take a 10th of the fps.
                        .loopSpeed = Round(.speed / gAvgTime) + (loopOffset * Round((1 / gAvgTime) / 10))

                        ' Set all players to move at the selected player's speed regardless,
                        ' (won't work otherwise!). I know this is a bug!
                        .loopSpeed = playerMem(selectedPlayer).loopSpeed

                        ' Check divide by zero
                        If (.loopSpeed <= 0) Then .loopSpeed = 1

                    End With

                Else

                    ' Get out of the mainloop state.
                    gGameState = GS_IDLE

                End If ' .direction <> MV_IDLE

            End If ' .loopFrame = 0

            If (pendingPlayerMovement(playerIdx).direction <> MV_IDLE) Then

                ' Always increment the position as a fraction of the total movement.
                If pushPlayer(playerIdx, staticTileType(playerIdx)) Or staticTileType(playerIdx) = SOLID Then
                    ' Only increment frames if we're moving or are not allowed to move.

                    With pPos(playerIdx)

                        If .loopFrame Mod ((playerMem(playerIdx).loopSpeed) / movementSize) = 0 Then
                            ' Only increment the frame if we're on a multiple of .speed.
                            ' / movementSize to handle pixel movement.
                            .frame = .frame + 1
                        End If

                        .loopFrame = .loopFrame + 1

                        If .loopFrame = framesPerMove * (playerMem(playerIdx).loopSpeed) Then
                            ' Movement has ended, update origin, reset the counter

                            ' Do not set the direction to idle, do it after prg check in main loop
                            ' Round to deal with irrational fractions

                            With pendingPlayerMovement(playerIdx)
                                If staticTileType(playerIdx) <> SOLID Then
                                    ' Update origins only if moved.
                                    .xOrig = .xTarg
                                    .yOrig = .yTarg
                                    .lOrig = pPos(playerIdx).l
                                    pPos(playerIdx).x = .xTarg
                                    pPos(playerIdx).y = .yTarg
                                End If
                            End With

                            ' Start the idle timer:
                            .idleTime = Timer()

                            ' Set -1 temporarily to flag the next loop.
                            .loopFrame = -1

                        End If ' loopFrame

                    End With ' pPos(playerIdx)

                End If ' mvOccured

                ' Movement occured, return True.
                movePlayers = True

            End If ' MV_IDLE

        End If ' showPlayer

    Next playerIdx

End Function

Private Function pushPlayer(ByVal pNum As Long, ByVal staticTileType As Byte) As Boolean
'=======================================================================================
'Single push player sub. Tests the fractional position and copies to the player.
'position if movement is possible.
'Returns whether movement occured.
'Called by movePlayers only.
'=======================================================================================
'Last edited for 3.0.5 by Delano: merged directions into one function.

    On Error Resume Next

    Dim testPos As PLAYER_POSITION, testPend As PENDING_MOVEMENT
    Dim moveFraction As Double

    fightInProgress = False
    stepsTaken = stepsTaken + 1

    'Before doing anything, let's see if we are going off the board.
    'Checks for links and will send to new board if a link is possible.
    If CheckEdges(pendingPlayerMovement(pNum), pNum) Then
        pendingPlayerMovement(pNum).direction = MV_IDLE
        pPos(pNum).loopFrame = -1
        Exit Function
    End If

    'Change direction now in case we're going to be walking against a wall.
    Select Case pendingPlayerMovement(pNum).direction
        Case MV_NORTH: pPos(pNum).stance = WALK_N
        Case MV_SOUTH: pPos(pNum).stance = WALK_S
        Case MV_EAST: pPos(pNum).stance = WALK_E
        Case MV_WEST: pPos(pNum).stance = WALK_W
        Case MV_NE: pPos(pNum).stance = WALK_NE
        Case MV_NW: pPos(pNum).stance = WALK_NW
        Case MV_SE: pPos(pNum).stance = WALK_SE
        Case MV_SW: pPos(pNum).stance = WALK_SW
    End Select

    'Ok, we have to insert the new fractional co-ords into a
    'test pos to see if we can move this frame.
    testPos = pPos(pNum)
    testPend = pendingPlayerMovement(pNum)

    'moveFraction is a fraction of the tile.
    moveFraction = movementSize / (framesPerMove * playerMem(pNum).loopSpeed)

    'Insert the new fractional co-ords into the test location.
    Call incrementPosition(testPos, testPend, moveFraction)

    'Now, check the new co-ords for blocking objects.
    If _
        staticTileType = SOLID Or _
        checkObstruction(testPos, testPend, pNum, -1) = SOLID Then
        'The new co-ords are blocked, or the target is permanently blocked.
        'All other tiletypes are evaluated to either NORMAL or UNDER, so
        'we don't need to do any other checks.
        Exit Function
    End If

    'Shift the screen drawing co-ords if needed.
    Select Case pendingPlayerMovement(pNum).direction
        Case MV_NORTH
            If checkScrollNorth(pNum) Then topY = topY - moveFraction
        Case MV_SOUTH
            If checkScrollSouth(pNum) Then topY = topY + moveFraction
        Case MV_EAST
            If checkScrollEast(pNum) Then topX = topX + moveFraction
        Case MV_WEST
            If checkScrollWest(pNum) Then topX = topX - moveFraction
        Case MV_NE
            If (boardList(activeBoardIndex).theData.isIsometric = 1) Then
                If checkScrollEast(pNum) Then topX = topX + moveFraction / 2
                If checkScrollNorth(pNum) Then topY = topY - moveFraction / 2
            Else
                If checkScrollEast(pNum) Then topX = topX + moveFraction
                If checkScrollNorth(pNum) Then topY = topY - moveFraction
            End If
        Case MV_NW
            If (boardList(activeBoardIndex).theData.isIsometric = 1) Then
                If checkScrollWest(pNum) Then topX = topX - moveFraction / 2
                If checkScrollNorth(pNum) Then topY = topY - moveFraction / 2
            Else
                If checkScrollWest(pNum) Then topX = topX - moveFraction
                If checkScrollNorth(pNum) Then topY = topY - moveFraction
            End If
        Case MV_SE
            If (boardList(activeBoardIndex).theData.isIsometric = 1) Then
                If checkScrollEast(pNum) Then topX = topX + moveFraction / 2
                If checkScrollSouth(pNum) Then topY = topY + moveFraction / 2
            Else
                If checkScrollEast(pNum) Then topX = topX + moveFraction
                If checkScrollSouth(pNum) Then topY = topY + moveFraction
            End If
        Case MV_SW
            If (boardList(activeBoardIndex).theData.isIsometric = 1) Then
                If checkScrollWest(pNum) Then topX = topX - moveFraction / 2
                If checkScrollSouth(pNum) Then topY = topY + moveFraction / 2
            Else
                If checkScrollWest(pNum) Then topX = topX - moveFraction
                If checkScrollSouth(pNum) Then topY = topY + moveFraction
            End If

    End Select

    topX = Round(topX, 5)               'Need topX,Y as FRACTIONs.
    topY = Round(topY, 5)

    'We can move, put the test location into the true loc.
    pPos(pNum) = testPos

    pushPlayer = True

End Function

Public Function getQueuedMovement(ByRef queue As MOVEMENT_QUEUE) As Long
'=========================================================================
' Get a queued movement (and remove it from the queue)
'=========================================================================

    ' If there's a queue
    If (queue.lngSize) Then

        ' Obtain the queued movement
        getQueuedMovement = queue.lngMovements(1)

        ' Remove the movement
        Call CopyMemory(queue.lngMovements(0), queue.lngMovements(1), 4 * queue.lngSize)

        ' Decrease the number of movements in the queue
        queue.lngSize = queue.lngSize - 1

    End If

End Function

Public Sub runQueuedMovements(): On Error Resume Next
'======================================================================
'Runs queued movements stacked up through rpgcode.
'======================================================================
'Called by ItemStepRPG, PlayerStepRPG, PushItemRPG, PushRPG, WanderRPG.

    Do While (movePlayers() Or moveItems())
        Call renderNow(cnvRPGCodeScreen, True)
        Call renderRPGCodeScreen
        Call processEvent
    Loop

    'Update the rpgcode canvas in case we're still in a program.
    Call canvasGetScreen(cnvRPGCodeScreen)

    Select Case UCase$(pPos(selectedPlayer).stance)
        Case "WALK_S": facing = SOUTH
        Case "WALK_W": facing = WEST
        Case "WALK_N": facing = NORTH
        Case "WALK_E": facing = EAST
    End Select

End Sub

Public Sub setQueuedMovements(ByRef queue As MOVEMENT_QUEUE, ByRef strPath As String)

    '===========================================================================
    ' Parse a string of movements for pushing and add them to the object's queue
    ' Called by PushItemRPG, PushRPG, PlayerStepRPG, ItemStepRPG, WanderRPG
    '===========================================================================

    On Error Resume Next

    ' First, split at comma delimed directions
    Dim strMovements() As String
    strMovements = Split(strPath, ",")

    ' Count the number of movements, and get the bound on the current queue
    Dim ub As Long, ubQueue As Long
    ub = UBound(strMovements)
    ubQueue = UBound(queue.lngMovements)

    ' Number of movements to add to queue will be larger if in pixel movement
    Dim lngQueueSize As Long
    If (mainMem.pixelMovement = PIXEL_MOVEMENT_TILE_PUSH) Then
        lngQueueSize = 1 / movementSize
    Else
        lngQueueSize = 1
    End If

    ' Get the next position in the queue
    Dim lngQueueOffset As Long
    lngQueueOffset = queue.lngSize + 1

    ' Enlarge the queue, and the array if needed
    queue.lngSize = queue.lngSize + lngQueueSize * (ub + 1)
    If (queue.lngSize >= ubQueue) Then
        ReDim Preserve queue.lngMovements(queue.lngSize)
    End If

    ' For each movement
    Dim i As Long
    For i = 0 To ub

        ' Switch on the movement
        Dim lngMovement As Long
        Select Case UCase$(Trim$(strMovements(i)))

            ' Fill in correct movement code
            Case "NORTH", "N", MVQ_NORTH: lngMovement = MV_NORTH
            Case "SOUTH", "S", MVQ_SOUTH: lngMovement = MV_SOUTH
            Case "EAST", "E", MVQ_EAST: lngMovement = MV_EAST
            Case "WEST", "W", MVQ_WEST: lngMovement = MV_WEST
            Case "NORTHEAST", "NE", MVQ_NE: lngMovement = MV_NE
            Case "NORTHWEST", "NW", MVQ_NW: lngMovement = MV_NW
            Case "SOUTHEAST", "SE", MVQ_SE: lngMovement = MV_SE
            Case "SOUTHWEST", "SW", MVQ_SW: lngMovement = MV_SW
            Case Else: lngMovement = MV_IDLE

        End Select

        ' For the queue size
        Dim j As Long, lngOffset As Long
        lngOffset = i * lngQueueSize
        For j = lngOffset To lngOffset + lngQueueSize - 1

            ' Write in this movement
            queue.lngMovements(lngQueueOffset + j) = lngMovement

        Next j

    Next i

End Sub

Private Function checkScrollNorth(ByVal playerNum As Long) As Boolean
'====================================================================
'Scrolling checks for pushPlayer.
'Last edited for 3.0.5 by Delano.
'====================================================================
    On Error Resume Next

    Dim y As Double
    checkScrollNorth = True

    If (boardList(activeBoardIndex).theData.isIsometric = 1) Then
        
        '3.0.5
        y = getBottomCentreY(pPos(playerNum).x, pPos(playerNum).y)
        
        If _
            (topY * 2 + 1) - 1 <= 0 Or _
            y > (isoTilesY / 2) * 16 Or _
            playerNum <> selectedPlayer Then
                'If at top of board
                'OR in lower half of screen
            
                checkScrollNorth = False
        End If
        
    Else
        
        If _
            pPos(playerNum).y - topY > tilesY / 2 Or _
            topY <= 0 Or _
            playerNum <> selectedPlayer Then
                'If at top of board
                'OR in lower half of screen
            
                checkScrollNorth = False
        End If
    End If

End Function

Private Function checkScrollSouth(ByVal playerNum As Long) As Boolean
'====================================================================
'Scrolling checks for pushPlayer.
'Last edited for 3.0.5 by Delano.
'====================================================================
    On Error Resume Next

    Dim y As Double
    checkScrollSouth = True

    If (boardList(activeBoardIndex).theData.isIsometric = 1) Then
        '3.0.5
        y = getBottomCentreY(pPos(playerNum).x, pPos(playerNum).y)
        
        If (topY * 2 + 1) + isoTilesY >= boardList(activeBoardIndex).theData.bSizeY Or _
            y < (isoTilesY / 2) * 16 Or _
            playerNum <> selectedPlayer Then
                'If at south edge of board
                'OR in middle and pos less than half screen height
            
                checkScrollSouth = False
        End If

    Else
        
        If _
            topY + tilesY >= boardList(activeBoardIndex).theData.bSizeY Or _
            pPos(playerNum).y - topY < tilesY / 2 Or _
            playerNum <> selectedPlayer Then
                'If at south edge of board
                'OR in middle and pos less than half screen height
            
                checkScrollSouth = False
        End If
    End If

End Function

Private Function checkScrollEast(ByVal playerNum As Long) As Boolean
'====================================================================
'Scrolling checks for pushPlayer.
'Last edited for 3.0.5 by Delano.
'====================================================================
    On Error Resume Next
    
    Dim x As Double
    checkScrollEast = True

    If (boardList(activeBoardIndex).theData.isIsometric = 1) Then
        
        x = getBottomCentreX(pPos(playerNum).x, pPos(playerNum).y)

        If _
            topX + isoTilesX + 1 / 2 >= boardList(activeBoardIndex).theData.bSizeX Or _
            x < (isoTilesX / 2) * 64 Or _
            playerNum <> selectedPlayer Then
                'If at east edge of board
                'OR in middle and pos less than half screen width
        
                checkScrollEast = False
        End If
        
    Else
        
        If _
            topX + tilesX >= boardList(activeBoardIndex).theData.bSizeX Or _
            pPos(playerNum).x - topX < tilesX / 2 Or _
            playerNum <> selectedPlayer Then
                'If at east edge of board
                'OR in middle and pos less than half screen width
        
                checkScrollEast = False
        End If
    End If

End Function

Private Function checkScrollWest(ByVal playerNum As Long) As Boolean
'====================================================================
'Scrolling checks for pushPlayer.
'Last edited for 3.0.5 by Delano.
'====================================================================
    On Error Resume Next

    Dim x As Double
    checkScrollWest = True
    
    If (boardList(activeBoardIndex).theData.isIsometric = 1) Then
        
        '3.0.5
        x = getBottomCentreX(pPos(playerNum).x, pPos(playerNum).y)
        
        If _
            x > (isoTilesX / 2) * 64 Or _
            topX <= 0 Or _
            playerNum <> selectedPlayer Then
                'OR on right side of screen.
                'OR at left edge of board.
            
                checkScrollWest = False
        End If
        
    Else
        '2D.
        If _
            pPos(playerNum).x - topX > tilesX / 2 Or _
            topX <= 0 Or _
            playerNum <> selectedPlayer Then
                'OR on right side of screen.
                'OR at left edge of board.
            
                checkScrollWest = False
        End If
    End If

End Function

Public Function TestBoard(ByVal file As String, ByVal testX As Long, ByVal testY As Long, ByVal testL As Long) As Long
'===========================================================
'Tests if we can go to x,x,layer on specified board.
'Returns -1 if we cannot, otherwise it returns the tiletype.
'===========================================================
'Called by: TestLink and Send.
    On Error Resume Next
    
    TestBoard = -1
    
    If Not (pakFileRunning) Then
        If Not fileExists(file) Then Exit Function
    End If

    Dim aBoard As TKBoard
    Call openBoard(file, aBoard)
    ' lastRender.canvas = -1
    If _
        testX > aBoard.bSizeX Or _
        testY > aBoard.bSizeY Or _
        testL > aBoard.bSizeL Then Exit Function
        
    TestBoard = aBoard.tiletype(testX, testY, testL)

End Function

Attribute VB_Name = "transLocate"
'=========================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=========================================================================

'=========================================================================
' Manages board coordiantes
'=========================================================================

'=========================================================================
' I've removed UsingPixelMovement(), and BoardIso() because they should
' be inline and the overhead is not acceptable.
' - Colin
'=========================================================================

Option Explicit

'=========================================================================
' Integral variables
'=========================================================================
Public movementSize As Double    'movement size (in tiles)

'=========================================================================
' Transform old-type isometric co-ordinates to new-type
'=========================================================================
Public Sub isoCoordTransform(ByVal oldX As Double, ByVal oldY As Double, _
                                  ByRef newX As Double, ByRef newY As Double)

    If (boardList(activeBoardIndex).theData.isIsometric = 1) Then
        newX = oldX + (oldY - 1) \ 2
        newY = Int(oldY / 2) + 1 - Int(oldX) + (oldY - Int(oldY))
        
        newY = newY + boardList(activeBoardIndex).theData.bSizeX
    Else
        newX = oldX
        newY = oldY
    End If
                                
End Sub

'=========================================================================
' Inverse transform old-type isometric co-ordinates to new-type
'=========================================================================
Public Sub invIsoCoordTransform(ByVal newX As Double, ByVal newY As Double, _
                                     ByRef oldX As Double, ByRef oldY As Double)

    If (boardList(activeBoardIndex).theData.isIsometric = 1) Then
    
        newY = newY - boardList(activeBoardIndex).theData.bSizeX
    
        If Int(newX) Mod 2 = 0 Then
            oldX = newX \ 2 - ((newY - 1) \ 2) + (newX - Int(newX))
            oldY = Int(newX) + newY
        Else
            oldX = ((newX + 1) \ 2) - (newY \ 2) + (newX - Int(newX))
            oldY = Int(newX) + newY
        End If
        
    Else
        oldX = newX
        oldY = newY
    End If
                                
End Sub

'=========================================================================
' Return if the board passed in is isometric
'=========================================================================
Public Function linkIso(ByVal linkBoard As String) As Boolean
    On Error Resume Next
    If Not fileExists(linkBoard) Then
        Exit Function
    End If
    lastRender.canvas = -1
    Dim brd As TKBoard
    Call openBoard(linkBoard, brd)
    linkIso = (brd.isIsometric = 1)
End Function

'=========================================================================
' Get the x coord at the bottom center of a board
' Called by putSpriteAt, checkScrollEast, checkScrollWest
'=========================================================================
Public Function getBottomCentreX(ByVal boardX As Double, ByVal boardY As Double) As Long

    On Error Resume Next

    'Co-ordinate transforms for isometrics from 3.0.5!

    If (boardList(activeBoardIndex).theData.isIsometric = 1) Then

        Call isoCoordTransform(boardX, boardY, boardX, boardY)
        getBottomCentreX = Int((boardX - (boardY - boardList(activeBoardIndex).theData.bSizeX) - topX * 2) * 32)

    Else

        '2D board - easy!
        getBottomCentreX = Int((boardX - topX) * 32 - 16)

    End If

End Function

'=========================================================================
' Get the y coord at the bottom center of a board
' Called by putSpriteAt, checkScrollNorth, checkScrollSouth
'=========================================================================
Public Function getBottomCentreY(ByVal boardX As Double, ByVal boardY As Double) As Long

    On Error Resume Next

    'Co-ordinate transforms for isometrics from 3.0.5!

    If (boardList(activeBoardIndex).theData.isIsometric = 1) Then
        Call isoCoordTransform(boardX, boardY, boardX, boardY)
        getBottomCentreY = Int((boardX + (boardY - boardList(activeBoardIndex).theData.bSizeX) - (topY * 2 + 1)) * 16)
    Else
        getBottomCentreY = Int((boardY - topY) * 32)
    End If

End Function

'=========================================================================
' Increment a player's position on the board
'=========================================================================
Public Sub incrementPosition( _
                                ByRef pos As PLAYER_POSITION, _
                                ByRef pend As PENDING_MOVEMENT, _
                                ByVal moveFraction As Double _
                                                               )
    On Error Resume Next

    With pos

        If (boardList(activeBoardIndex).theData.isIsometric = 1) Then

            'Co-ordinate transform!
            Call isoCoordTransform(.x, .y, .x, .y)

            Select Case pend.direction

                Case MV_NE
                    .x = .x
                    .y = .y - moveFraction

                Case MV_NW
                    .x = .x - moveFraction
                    .y = .y

                Case MV_SE
                    .x = .x + moveFraction
                    .y = .y

                Case MV_SW
                    .x = .x
                    .y = .y + moveFraction

                Case MV_NORTH
                    .x = .x - moveFraction
                    .y = .y - moveFraction

                Case MV_SOUTH
                    .x = .x + moveFraction
                    .y = .y + moveFraction

                Case MV_EAST
                    .x = .x + moveFraction
                    .y = .y - moveFraction

                Case MV_WEST
                    .x = .x - moveFraction
                    .y = .y + moveFraction

            End Select

            'Invert!
            Call invIsoCoordTransform(.x, .y, .x, .y)

        Else

            Select Case pend.direction

                Case MV_NE
                    .x = .x + moveFraction
                    .y = .y - moveFraction

                Case MV_NW
                    .x = .x - moveFraction
                    .y = .y - moveFraction

                Case MV_SE
                    .x = .x + moveFraction
                    .y = .y + moveFraction

                Case MV_SW
                    .x = .x - moveFraction
                    .y = .y + moveFraction

                Case MV_NORTH
                    .y = .y - moveFraction
                    If .y < pend.yTarg Then .y = pend.yTarg
            
                Case MV_SOUTH
                    .y = .y + moveFraction
                    If .y > pend.yTarg Then .y = pend.yTarg

                Case MV_EAST
                    .x = .x + moveFraction
                    If .x > pend.xTarg Then .x = pend.xTarg

                Case MV_WEST
                    .x = .x - moveFraction
                    If .x < pend.xTarg Then .x = pend.xTarg

            End Select

        End If 'boardIso

    End With 'pos

End Sub

'=========================================================================
' Fill in tile target coordinates from pending movement
'=========================================================================
Public Sub insertTarget(ByRef pend As PENDING_MOVEMENT)

    On Error Resume Next

    'Catch the movementSize property (speed reasons)
    Dim stepSize As Double
    stepSize = movementSize

    With pend

        If (boardList(activeBoardIndex).theData.isIsometric = 1) Then

            'Co-ordinate transform!!
            '============================================================
            Call isoCoordTransform(.xOrig, .yOrig, .xOrig, .yOrig)

            Select Case .direction

                Case MV_NE
                    .xTarg = .xOrig
                    .yTarg = .yOrig - stepSize
                
                Case MV_NW
                    .xTarg = .xOrig - stepSize
                    .yTarg = .yOrig
                
                Case MV_SE
                    .xTarg = .xOrig + stepSize
                    .yTarg = .yOrig

                Case MV_SW
                    .xTarg = .xOrig
                    .yTarg = .yOrig + stepSize
                
                Case MV_NORTH
                    .xTarg = .xOrig - stepSize
                    .yTarg = .yOrig - stepSize
                
                Case MV_SOUTH
                    .xTarg = .xOrig + stepSize
                    .yTarg = .yOrig + stepSize

                Case MV_EAST
                    .xTarg = .xOrig + stepSize
                    .yTarg = .yOrig - stepSize

                Case MV_WEST
                    .xTarg = .xOrig - stepSize
                    .yTarg = .yOrig + stepSize

                Case Else
                    .xTarg = .xOrig
                    .yTarg = .yOrig

            End Select

            Call invIsoCoordTransform(.xTarg, .yTarg, .xTarg, .yTarg)
            Call invIsoCoordTransform(.xOrig, .yOrig, .xOrig, .yOrig)       'Don't forget these!
            '========================================================

        Else
            '2D.
            Select Case .direction

                Case MV_NE
                    .xTarg = .xOrig + stepSize
                    .yTarg = .yOrig - stepSize

                Case MV_NW
                    .xTarg = .xOrig - stepSize
                    .yTarg = .yOrig - stepSize

                Case MV_SE
                    .xTarg = .xOrig + stepSize
                    .yTarg = .yOrig + stepSize

                Case MV_SW
                    .xTarg = .xOrig - stepSize
                    .yTarg = .yOrig + stepSize

                Case MV_NORTH
                    .xTarg = .xOrig
                    .yTarg = .yOrig - stepSize

                Case MV_SOUTH
                    .xTarg = .xOrig
                    .yTarg = .yOrig + stepSize

                Case MV_EAST
                    .xTarg = .xOrig + stepSize
                    .yTarg = .yOrig

                Case MV_WEST
                    .xTarg = .xOrig - stepSize
                    .yTarg = .yOrig

                Case Else
                    .xTarg = .xOrig
                    .yTarg = .yOrig

            End Select

        End If 'boardIso

       .lTarg = .lOrig

    End With 'pend

End Sub

'=========================================================================
' Round player coords
'=========================================================================
Public Function roundCoords(ByRef passPos As PLAYER_POSITION, _
                            ByVal direction As Long) As PLAYER_POSITION

    'We want programs to trigger when it *appears* that the sprite is in far enough onto the
    'tile to trigger it.
    'Sprite size will vary widely, but we assume 32px wide, with "feet" at the very base of
    'the sprite.
    'Triggering will act differently for horizontal and vertical movement.
    '   Horizontally, the position of the base is well-defined, and it can be clearly seen
    '   when a player is aligned with the tile (y = 0.25 -> 1.00 == 4 quarters.)
    '   Vertically, it depends on the width of the player. Assuming 32px, the player will
    '   straddle the trigger tile from x = -0.25 -> 0.75 == 7 quarters, but if we disregard
    '   the first on either side, that leaves x = -0.75 -> 0.5 == 4 quarters which is better.
    '
    '   This does however lead to inconsistencies when walking onto tiles from different
    '   directions: walking up the side of a tile @ x = -0.25 or x = 0.75 won't trigger,
    '   whilst walking on the same spots horizontally will trigger.
    '
    '   There are also problems with diagonals: the corner sectors won't trigger because
    '   their co-ords correspond to other trigger spots.
    '
    '   Trigger programs run only once per tile by only running when first entering the tile.
    '   Decimal checks on the co-ords ensure this.

    Dim rx As Double, ry As Double, pos As PLAYER_POSITION

    roundCoords = passPos

    If Not (movementSize <> 1) Then
        Exit Function
    End If

    With roundCoords

        If (boardList(activeBoardIndex).theData.isIsometric = 1) Then
            'The conditions are slightly different because the sprite's base is a different
            'shape. Also, directions have rotated.

            Call isoCoordTransform(.x, .y, .x, .y)

            Select Case direction

                'First, check technical East-West. Directions have rotated, so North is now
                'NorthEast, SouthEast is now South etc.
                Case MV_EAST, MV_SE, MV_SOUTH

                    If .x - Int(.x) = 1 - movementSize Then
                        rx = -Int(-.x)
                        If Abs(.y - Round(.y)) <= movementSize Then    '<= 1/4 [sprite width / 2]
                            ry = Round(.y)
                        End If
                    End If

                Case MV_NORTH, MV_NW, MV_WEST

                    If .x - Int(.x) = movementSize Then
                        rx = Int(.x)
                        If Abs(.y - Round(.y)) <= movementSize Then    '<= 1/4
                            ry = Round(.y)
                        End If
                    End If

            End Select

            Select Case direction

                'Now check technical North-South. Overwrite rx for diagonals if found.
                Case MV_NORTH, MV_NE, MV_EAST

                    If .y - Int(.y) = movementSize Then
                        ry = Int(.y)
                        If Abs(.x - Round(.x)) <= movementSize Then    '<= 1/4
                            rx = Round(.x)
                        End If
                    End If

                Case MV_WEST, MV_SW, MV_SOUTH

                    If .y - Int(.y) = 1 - movementSize Then
                        ry = -Int(-.y)
                        If Abs(.x - Round(.x)) <= movementSize Then    '<= 1/4
                            rx = Round(.x)
                        End If
                    End If

                Case MV_SE, MV_NW
                    ' Prevent "Case Else"

                Case Else

                    rx = Round(.x)
                    ry = Round(.y)
    
            End Select

            'All cases, assign what we've calculated.
            'Most of the time these will be zero, and no prg will trigger, which prevents
            'multiple runnings whilst walking over a tile.
            .x = rx
            .y = ry

            Call invIsoCoordTransform(.x, .y, .x, .y)
    
        Else
    
            'Standard.
            Select Case direction
            
                'First, check East-West.
                Case MV_EAST, MV_NE, MV_SE
                
                    If .x - Int(.x) = movementSize Then
                        rx = -Int(-.x)
                    End If
                    
                Case MV_WEST, MV_NW, MV_SW
                
                    If .x - Int(.x) = 1 - movementSize Then
                        rx = Int(.x)
                    End If
                    
            End Select
    
            Select Case direction
    
                'Now check North-South. Overwrite rx for diagonals if found.
                Case MV_NORTH, MV_NE, MV_NW
    
                    If Int(.y) = .y Then
                        rx = Round(.x)
                    End If
    
                Case MV_SOUTH, MV_SE, MV_SW
    
                    If .y - Int(.y) = movementSize Then
                        rx = Round(.x)
                    End If
                    
                Case MV_EAST, MV_WEST
                    ' Prevent "Case Else"

                Case Else
                
                    rx = Round(.x)
                    ry = Round(.y)
    
            End Select

            'All cases, assign what we've calculated.
            .x = rx
            .y = -Int(-.y)

        End If 'boardIso

    End With 'pos

End Function

'=========================================================================
'Increment the player co-ords one tile from the direction they are facing, to test
'if items or programs lie directly in front of them.
'Called by programTest only.
'=========================================================================
Public Function activationCoords(ByRef passPos As PLAYER_POSITION, _
                                 ByRef roundPos As PLAYER_POSITION) As PLAYER_POSITION

    Dim passX As Double, passY As Double

    Call isoCoordTransform(passPos.x, passPos.y, passX, passY)

    If (boardList(activeBoardIndex).theData.isIsometric = 1) Then

        'For iso px/tile we can't get closer than a tile (if solid).
        'If .y not integer (px}, it won't trigger, which is good because
        'we don't want it to unless we're right next to it.
        Select Case LCase$(passPos.stance)

            Case "walk_n", "stand_n"

                If passX = Int(passX) Then 'Pushing against a right-hand edge.
                    activationCoords.x = passX - 1
                Else
                    activationCoords.x = Round(passX)
                End If
                If passY = Int(passY) Then 'Pushing against a left-hand edge.
                    activationCoords.y = passY - 1
                Else
                    activationCoords.y = Round(passY)
                End If

            Case "walk_s", "stand_s"

                If passX = Int(passX) Then 'Pushing against a right-hand edge.
                    activationCoords.x = passX + 1
                Else
                    activationCoords.x = Round(passX)
                End If
                If passY = Int(passY) Then 'Pushing against a left-hand edge.
                    activationCoords.y = passY + 1
                Else
                    activationCoords.y = Round(passY)
                End If

            Case "walk_e", "stand_e"

                If passX = Int(passX) Then 'Pushing against an upper edge.
                    activationCoords.x = passX + 1
                Else
                    activationCoords.x = Round(passX)
                End If
                If passY = Int(passY) Then 'Pushing against a lower edge.
                    activationCoords.y = passY - 1
                Else
                    activationCoords.y = Round(passY)
                End If

            Case "walk_w", "stand_w"

                If passX = Int(passX) Then 'Pushing against an upper edge.
                    activationCoords.x = passX - 1
                Else
                    activationCoords.x = Round(passX)
                End If
                If passY = Int(passY) Then 'Pushing against a lower edge.
                    activationCoords.y = passY + 1
                Else
                    activationCoords.y = Round(passY)
                End If

            Case "walk_ne", "stand_ne"
                activationCoords.y = passY - 1
                activationCoords.x = Round(passX)

            Case "walk_nw", "stand_nw"
                activationCoords.x = passX - 1
                activationCoords.y = Round(passY)

            Case "walk_se", "stand_se"
                activationCoords.x = passX + 1
                activationCoords.y = Round(passY)

            Case "walk_sw", "stand_sw"
                activationCoords.y = passY + 1
                activationCoords.x = Round(passX)

        End Select

    Else

        'Using .stance because pend.direction could be mv_idle.
        Select Case LCase$(passPos.stance)

            Case "walk_n", "stand_n"

                activationCoords.x = roundPos.x
                If (movementSize <> 1) Then
                    activationCoords.y = Round(passPos.y)
                Else
                    activationCoords.y = passPos.y - 1
                End If

            Case "walk_s", "stand_s"

                activationCoords.x = roundPos.x
                activationCoords.y = Int(passPos.y) + 1

            Case "walk_e", "stand_e"

                activationCoords.x = Int(passPos.x) + 1
                activationCoords.y = -Int(-passPos.y)

            Case "walk_w", "stand_w"

                activationCoords.x = -Int(-passPos.x) - 1
                activationCoords.y = -Int(-passPos.y)

            Case "walk_ne", "stand_ne"

                activationCoords.x = Int(passPos.x) + 1
                If (movementSize <> 1) Then
                    activationCoords.y = Round(passPos.y) - 1
                Else
                    activationCoords.y = passPos.y - 1
                End If

            Case "walk_nw", "stand_nw"

                activationCoords.x = -Int(-passPos.x) - 1
                If (movementSize <> 1) Then
                    activationCoords.y = Round(passPos.y) - 1
                Else
                    activationCoords.y = passPos.y - 1
                End If

            Case "walk_se", "stand_se"

                activationCoords.x = Int(passPos.x) + 1
                activationCoords.y = Int(passPos.y) - 1

            Case "walk_sw", "stand_sw"

                activationCoords.x = -Int(-passPos.x) - 1
                activationCoords.y = Int(passPos.y) + 1

       End Select

    End If 'boardIso

End Function

Attribute VB_Name = "transLocate"
'=========================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=========================================================================

'=========================================================================
' Manages board coordiantes
' Status: B+
'=========================================================================

Option Explicit

'=========================================================================
' Integral variables
'=========================================================================
Private m_movementSize As Double    'movement size (in pixels)

'=========================================================================
' Returns movement size (in pixels)
'=========================================================================
Public Property Get movementSize() As Double
    movementSize = m_movementSize
    If movementSize = 0 Then
        movementSize = 1
        walkDelay = 0.01
    End If
End Property

'=========================================================================
' Change movement size (in pixels)
'=========================================================================
Public Property Let movementSize(ByVal newVal As Double)
    m_movementSize = newVal
End Property

'=========================================================================
' Return if we are using pixel movement
'=========================================================================
Public Property Get usingPixelMovement() As Boolean
    If (Not movementSize = 1) And (Not boardIso()) Then
        usingPixelMovement = True
    End If
End Property

'=========================================================================
' Return if we're on an isometric board
'=========================================================================
Public Property Get boardIso() As Boolean
    On Error Resume Next
    If boardList(activeBoardIndex).theData.isIsometric = 1 Then
        boardIso = True
    End If
End Property

'=========================================================================
' Return if the board passed in is isometric
'=========================================================================
Public Function linkIso(ByVal linkBoard As String) As Boolean
    On Error Resume Next
    If Not fileExists(linkBoard) Then
        Exit Function
    End If
    Dim TestBoard As TKBoard
    Call openBoard(linkBoard$, TestBoard)
    lastRender.canvas = -1
    If TestBoard.isIsometric = 1 Then
        linkIso = True
    End If
End Function

'=========================================================================
' Get the x coord at the bottom center of a board
'=========================================================================
Public Function getBottomCentreX( _
                                    ByVal boardX As Double, _
                                    ByVal boardY As Double, _
                                    ByRef pending As PENDING_MOVEMENT _
                                                                        ) As Long

    On Error Resume Next

    If boardIso() Then
       
       'The horziontal position depends on the parity of the origin Y-tile.
       
       If pending.yOrig Mod 2 = 0 Then
            
            If pending.direction > 4 Then
                'If moving diagonally.
                'X doesn't always vary so has to depend on Y instead.
                getBottomCentreX = ((boardX - topX) * 64 - 64) + Abs(boardY - pending.yOrig) * 32
            Else
                getBottomCentreX = (boardX - topX) * 64 - 64
            End If
            
        Else
            
            If pending.direction > 4 Then
                'If moving diagonally.
                'X doesn't always vary so has to depend on Y instead.
                getBottomCentreX = ((boardX - topX) * 64 - 32) - Abs(boardY - pending.yOrig) * 32
            Else
                getBottomCentreX = (boardX - topX) * 64 - 32
            End If
        End If
    
    Else
        getBottomCentreX = (boardX - topX) * 32 - 16
    End If
    
End Function

'=========================================================================
' Get the y coord at the bottom center of a board
'=========================================================================
Public Function getBottomCentreY(ByVal boardY As Double) As Long
    On Error Resume Next
    If boardIso() Then
        getBottomCentreY = ((boardY - (topY * 2 + 1)) * 16) + 8
    Else
        getBottomCentreY = (boardY - topY) * 32
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

        If boardIso() Then

            Select Case pend.direction

                Case MV_NE
                    If pend.yOrig Mod 2 = 0 Then
                        .x = .x
                        .y = .y - moveFraction
                    Else
                        .x = .x + moveFraction
                        .y = .y - moveFraction
                    End If
            
                Case MV_NW
                    If pend.yOrig Mod 2 = 0 Then
                        .x = .x - moveFraction
                        .y = .y - moveFraction
                    Else
                        .x = .x
                        .y = .y - moveFraction
                    End If
            
                Case MV_SE
                    If pend.yOrig Mod 2 = 0 Then
                        .x = .x
                        .y = .y + moveFraction
                    Else
                        .x = .x + moveFraction
                        .y = .y + moveFraction
                    End If
            
                Case MV_SW
                    If pend.yOrig Mod 2 = 0 Then
                        .x = .x - moveFraction
                        .y = .y + moveFraction
                    Else
                        .x = .x
                        .y = .y + moveFraction
                    End If
            
                Case MV_NORTH
                    .y = .y - moveFraction * 2
            
                Case MV_SOUTH
                    .y = .y + moveFraction * 2
            
                Case MV_EAST
                    .x = .x + moveFraction
            
                Case MV_WEST
                    .x = .x - moveFraction
            
            End Select

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
            
                Case MV_SOUTH
                    .y = .y + moveFraction
            
                Case MV_EAST
                    .x = .x + moveFraction
            
                Case MV_WEST
                    .x = .x - moveFraction
            
            End Select

        End If
    
    End With
    
End Sub

'=========================================================================
' Fill in tile target coordinates from pending movement
'=========================================================================
Public Sub insertTarget(ByRef pend As PENDING_MOVEMENT)

    'Called by scanKeys when movement is initiated, and the RPG commands
    'PlayerStepRPG, ItemStepRPG, PushItemRPG, PushRPG, WanderRPG.
    'Called once in a movement cycle.

    On Error Resume Next

    'Catch the movementSize property (speed reasons)
    Dim stepSize As Double
    stepSize = movementSize

    With pend

        If boardIso() Then

            Select Case .direction

                Case MV_NE
                    If .yOrig Mod 2 = 0 Then
                        .xTarg = .xOrig
                        .yTarg = .yOrig - stepSize
                        .lTarg = .lOrig
                    Else
                        .xTarg = .xOrig + stepSize
                        .yTarg = .yOrig - stepSize
                        .lTarg = .lOrig
                    End If
                
                Case MV_NW
                    If .yOrig Mod 2 = 0 Then
                        .xTarg = .xOrig - stepSize
                        .yTarg = .yOrig - stepSize
                        .lTarg = .lOrig
                    Else
                        .xTarg = .xOrig
                        .yTarg = .yOrig - stepSize
                        .lTarg = .lOrig
                    End If
            
                Case MV_SE
                    If .yOrig Mod 2 = 0 Then
                        .xTarg = .xOrig
                        .yTarg = .yOrig + stepSize
                        .lTarg = .lOrig
                    Else
                        .xTarg = .xOrig + stepSize
                        .yTarg = .yOrig + stepSize
                        .lTarg = .lOrig
                    End If
            
                Case MV_SW
                    If .yOrig Mod 2 = 0 Then
                        .xTarg = .xOrig - stepSize
                        .yTarg = .yOrig + stepSize
                        .lTarg = .lOrig
                    Else
                        .xTarg = .xOrig
                        .yTarg = .yOrig + stepSize
                        .lTarg = .lOrig
                    End If
            
                Case MV_NORTH
                    .xTarg = .xOrig
                    .yTarg = .yOrig - stepSize * 2
                    .lTarg = .lOrig
            
                Case MV_SOUTH
                    .xTarg = .xOrig
                    .yTarg = .yOrig + stepSize * 2
                    .lTarg = .lOrig
            
                Case MV_EAST
                    .xTarg = .xOrig + stepSize
                    .yTarg = .yOrig
                    .lTarg = .lOrig
            
                Case MV_WEST
                    .xTarg = .xOrig - stepSize
                    .yTarg = .yOrig
                    .lTarg = .lOrig
            
                Case Else
                    .xTarg = .xOrig
                    .yTarg = .yOrig
                    .lTarg = .lOrig

            End Select

        Else

            Select Case .direction

                Case MV_NE
                    .xTarg = .xOrig + stepSize
                    .yTarg = .yOrig - stepSize
                    .lTarg = .lOrig
            
                Case MV_NW
                    .xTarg = .xOrig - stepSize
                    .yTarg = .yOrig - stepSize
                    .lTarg = .lOrig
            
                Case MV_SE
                    .xTarg = .xOrig + stepSize
                    .yTarg = .yOrig + stepSize
                    .lTarg = .lOrig
            
                Case MV_SW
                    .xTarg = .xOrig - stepSize
                    .yTarg = .yOrig + stepSize
                    .lTarg = .lOrig
            
                Case MV_NORTH
                    .xTarg = .xOrig
                    .yTarg = .yOrig - stepSize
                    .lTarg = .lOrig
            
                Case MV_SOUTH
                    .xTarg = .xOrig
                    .yTarg = .yOrig + stepSize
                    .lTarg = .lOrig
            
                Case MV_EAST
                    .xTarg = .xOrig + stepSize
                    .yTarg = .yOrig
                    .lTarg = .lOrig
            
                Case MV_WEST
                    .xTarg = .xOrig - stepSize
                    .yTarg = .yOrig
                    .lTarg = .lOrig
            
                Case Else
                    .xTarg = .xOrig
                    .yTarg = .yOrig
                    .lTarg = .lOrig

            End Select

        End If
    
    End With

End Sub

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

'========================================================================='
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
    
    Dim x As Long
    
    If boardIso() Then
       
       'The horziontal position depends on the parity of the origin Y-tile.
       
       If pending.yOrig Mod 2 = 0 Then
            
            If pending.direction > 4 Then
                'If moving diagonally.
                'X doesn't always vary so has to depend on Y instead.
                x = ((boardX - topX) * 64 - 64) + Abs(boardY - pending.yOrig) * 32
            Else
                x = (boardX - topX) * 64 - 64
            End If
            
        Else
            
            If pending.direction > 4 Then
                'If moving diagonally.
                'X doesn't always vary so has to depend on Y instead.
                x = ((boardX - topX) * 64 - 32) - Abs(boardY - pending.yOrig) * 32
            Else
                x = (boardX - topX) * 64 - 32
            End If
        End If
    
    Else
        x = (boardX - topX) * 32 - 16
    End If
    
    getBottomCentreX = x
    
End Function

'=========================================================================
' Get the y coord at the bottom center of a board
'=========================================================================
Public Function getBottomCentreY(ByVal boardY As Double) As Long
    On Error Resume Next
    Dim y As Long
    If boardIso() Then
        y = (boardY - (topY * 2 + 1)) * 16
        y = y + 8 'Vertical offset to 3/4 down the tile
    Else
        y = (boardY - topY) * 32
    End If
    getBottomCentreY = y
End Function

'=========================================================================
' Increment a player's position on the board
'=========================================================================
Public Sub incrementPosition( _
                                ByRef pos As PLAYER_POSITION, _
                                ByRef pend As PENDING_MOVEMENT, _
                                ByVal moveFraction As Double _
                                                               )

    'Called by the pushPlayer and pushItem Subs.
    'Called each frame of a movement cycle (currently 4 times).
    
    On Error Resume Next
    
    Dim doubleMoveFraction As Double
    doubleMoveFraction = moveFraction * 2
        
    If boardIso() Then
        Select Case pend.direction
            Case MV_NE:
                If pend.yOrig Mod 2 = 0 Then
                    pos.x = pos.x
                    pos.y = pos.y - moveFraction
                Else
                    pos.x = pos.x + moveFraction
                    pos.y = pos.y - moveFraction
                End If
            
            Case MV_NW:
                If pend.yOrig Mod 2 = 0 Then
                    pos.x = pos.x - moveFraction
                    pos.y = pos.y - moveFraction
                Else
                    pos.x = pos.x
                    pos.y = pos.y - moveFraction
                End If
            
            Case MV_SE:
                If pend.yOrig Mod 2 = 0 Then
                    pos.x = pos.x
                    pos.y = pos.y + moveFraction
                Else
                    pos.x = pos.x + moveFraction
                    pos.y = pos.y + moveFraction
                End If
            
            Case MV_SW:
                If pend.yOrig Mod 2 = 0 Then
                    pos.x = pos.x - moveFraction
                    pos.y = pos.y + moveFraction
                Else
                    pos.x = pos.x
                    pos.y = pos.y + moveFraction
                End If
            
            Case MV_NORTH:
                pos.y = pos.y - doubleMoveFraction
            
            Case MV_SOUTH:
                pos.y = pos.y + doubleMoveFraction
            
            Case MV_EAST:
                pos.x = pos.x + moveFraction
            
            Case MV_WEST:
                pos.x = pos.x - moveFraction
            
            Case Else:
        End Select
    Else
        Select Case pend.direction
            Case MV_NE:
                pos.x = pos.x + moveFraction
                pos.y = pos.y - moveFraction
            
            Case MV_NW:
                pos.x = pos.x - moveFraction
                pos.y = pos.y - moveFraction
            
            Case MV_SE:
                pos.x = pos.x + moveFraction
                pos.y = pos.y + moveFraction
            
            Case MV_SW:
                pos.x = pos.x - moveFraction
                pos.y = pos.y + moveFraction
            
            Case MV_NORTH:
                pos.y = pos.y - moveFraction
            
            Case MV_SOUTH:
                pos.y = pos.y + moveFraction
            
            Case MV_EAST:
                pos.x = pos.x + moveFraction
            
            Case MV_WEST:
                pos.x = pos.x - moveFraction
            
            Case Else:
        End Select
    End If
End Sub

'=========================================================================
' Fill in tile target coordinates from pending movement
'=========================================================================
Public Sub insertTarget(ByRef pend As PENDING_MOVEMENT)

    'Called by scanKeys when movement is initiated, and the RPG commands:
    'PlayerStepRPG, ItemStepRPG, PushItemRPG, PushRPG, WanderRPG.
    'Called once in a movement cycle.
    
    On Error Resume Next
    
    Dim stepSize As Double
    stepSize = movementSize
    
    Dim doubleStepSize As Double
    doubleStepSize = stepSize * 2
    
    If boardIso() Then
        Select Case pend.direction
            Case MV_NE:
                If pend.yOrig Mod 2 = 0 Then
                    pend.xTarg = pend.xOrig
                    pend.yTarg = pend.yOrig - stepSize
                    pend.lTarg = pend.lOrig
                Else
                    pend.xTarg = pend.xOrig + stepSize
                    pend.yTarg = pend.yOrig - stepSize
                    pend.lTarg = pend.lOrig
                End If
                
            Case MV_NW:
                If pend.yOrig Mod 2 = 0 Then
                    pend.xTarg = pend.xOrig - stepSize
                    pend.yTarg = pend.yOrig - stepSize
                    pend.lTarg = pend.lOrig
                Else
                    pend.xTarg = pend.xOrig
                    pend.yTarg = pend.yOrig - stepSize
                    pend.lTarg = pend.lOrig
                End If
            
            Case MV_SE:
                If pend.yOrig Mod 2 = 0 Then
                    pend.xTarg = pend.xOrig
                    pend.yTarg = pend.yOrig + stepSize
                    pend.lTarg = pend.lOrig
                Else
                    pend.xTarg = pend.xOrig + stepSize
                    pend.yTarg = pend.yOrig + stepSize
                    pend.lTarg = pend.lOrig
                End If
            
            Case MV_SW:
                If pend.yOrig Mod 2 = 0 Then
                    pend.xTarg = pend.xOrig - stepSize
                    pend.yTarg = pend.yOrig + stepSize
                    pend.lTarg = pend.lOrig
                Else
                    pend.xTarg = pend.xOrig
                    pend.yTarg = pend.yOrig + stepSize
                    pend.lTarg = pend.lOrig
                End If
            
            Case MV_NORTH:
                pend.xTarg = pend.xOrig
                pend.yTarg = pend.yOrig - doubleStepSize
                pend.lTarg = pend.lOrig
            
            Case MV_SOUTH:
                pend.xTarg = pend.xOrig
                pend.yTarg = pend.yOrig + doubleStepSize
                pend.lTarg = pend.lOrig
            
            Case MV_EAST:
                pend.xTarg = pend.xOrig + stepSize
                pend.yTarg = pend.yOrig
                pend.lTarg = pend.lOrig
            
            Case MV_WEST:
                pend.xTarg = pend.xOrig - stepSize
                pend.yTarg = pend.yOrig
                pend.lTarg = pend.lOrig
            
            Case Else:
                pend.xTarg = pend.xOrig
                pend.yTarg = pend.yOrig
                pend.lTarg = pend.lOrig
            End Select
    Else
        Select Case pend.direction
            Case MV_NE:
                pend.xTarg = pend.xOrig + stepSize
                pend.yTarg = pend.yOrig - stepSize
                pend.lTarg = pend.lOrig
            
            Case MV_NW:
                pend.xTarg = pend.xOrig - stepSize
                pend.yTarg = pend.yOrig - stepSize
                pend.lTarg = pend.lOrig
            
            Case MV_SE:
                pend.xTarg = pend.xOrig + stepSize
                pend.yTarg = pend.yOrig + stepSize
                pend.lTarg = pend.lOrig
            
            Case MV_SW:
                pend.xTarg = pend.xOrig - stepSize
                pend.yTarg = pend.yOrig + stepSize
                pend.lTarg = pend.lOrig
            
            Case MV_NORTH:
                pend.xTarg = pend.xOrig
                pend.yTarg = pend.yOrig - stepSize
                pend.lTarg = pend.lOrig
            
            Case MV_SOUTH:
                pend.xTarg = pend.xOrig
                pend.yTarg = pend.yOrig + stepSize
                pend.lTarg = pend.lOrig
            
            Case MV_EAST:
                pend.xTarg = pend.xOrig + stepSize
                pend.yTarg = pend.yOrig
                pend.lTarg = pend.lOrig
            
            Case MV_WEST:
                pend.xTarg = pend.xOrig - stepSize
                pend.yTarg = pend.yOrig
                pend.lTarg = pend.lOrig
            
            Case Else:
                pend.xTarg = pend.xOrig
                pend.yTarg = pend.yOrig
                pend.lTarg = pend.lOrig
        End Select
    End If

End Sub


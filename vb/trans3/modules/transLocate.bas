Attribute VB_Name = "transLocate"
'=====================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=====================================================

'Maps board and screen co-ordinates and for isometric and non-isometric boards.
Option Explicit

'==========================================================================================
'Declaration Changed [KSNiloc]

Private mVarMovementSize As Double

Public Property Get movementSize() As Double
    movementSize = mVarMovementSize
    If movementSize = 0 Then
        'movementSize = 8 / 32 'Default size is 8 pixels
        movementSize = 1
        walkDelay = 0.01
    End If
End Property

Public Property Let movementSize(newVal As Double)
    mVarMovementSize = newVal
End Property

'==========================================================================================

Public Function usingPixelMovement() As Boolean
    '================================================
    'Returns if we are using pixel movement [KSNiloc]
    '================================================

    If Not movementSize = 1 Then usingPixelMovement = True

End Function

Function boardIso() As Boolean
    '=========================================
    'Checks if the current board is isometric.
    '=========================================
    On Error Resume Next
    
    If boardList(activeBoardIndex).theData.isIsometric = 1 Then
        boardIso = True
    Else
        boardIso = False
    End If
    
End Function

Public Function linkIso(ByVal linkBoard As String) As Boolean
'===========================================
'NEW FUNCTION: [Isometrics - Delano 3/04/04]
'Checks if a linked (directional) board is isometric.
'The filename (with path) of the linked board is passed.
'Usage: linkIso(projectPath$ + brdPath$ + boardList(activeBoardIndex).theData.dirLink$(thelink))
'Called by TestLink only, to give different co-ordinates for moving to iso boards.
'===========================================

    On Error Resume Next

    linkIso = False

    Dim test As Boolean
 
    test = fileExists(linkBoard$)
    If Not test Then Exit Function

    Dim TestBoard As TKBoard
    Call openboard(linkBoard$, TestBoard)
    lastRender.canvas = -1
    If TestBoard.isIsometric = 1 Then linkIso = True

End Function

Function getBottomCentreX(ByVal boardx As Double, ByVal boardy As Double, ByRef pending As PENDING_MOVEMENT) As Long
    '=========================================
    'REWRITTEN: [Isometrics - Delano 29/03/04]
    'Receives 2 extra arguments: the accompanying boardy and pending, as an isometric fix. (Could be item or player)
    'Gets pixel location on the screen of the centre of the tile at boardx, boardy, specifically for a player or item.
    'Accounts for the screen offset.
    '=========================================
    
    'Called by putSpriteAt only. This is why the arguments are a little strange - might be better to receive the ppos ByRef
    
    On Error Resume Next
    
    Dim x As Long
    
    If boardIso() Then
       
       'The horziontal position depends on the parity of the origin Y-tile.
       
       If pending.yOrig Mod 2 = 0 Then
            
            If pending.direction > 4 Then
                'If moving diagonally.
                'X doesn't always vary so has to depend on Y instead.
                x = ((boardx - topX) * 64 - 64) + Abs(boardy - pending.yOrig) * 32
            Else
                x = (boardx - topX) * 64 - 64
            End If
            
        Else
            
            If pending.direction > 4 Then
                'If moving diagonally.
                'X doesn't always vary so has to depend on Y instead.
                x = ((boardx - topX) * 64 - 32) - Abs(boardy - pending.yOrig) * 32
            Else
                x = (boardx - topX) * 64 - 32
            End If
        End If
    
    Else
        x = (boardx - topX) * 32 - 16
    End If
    
    getBottomCentreX = x
    
End Function

Function getBottomCentreY(ByVal boardy As Double) As Long
    '=========================================
    'REWRITTEN: [Isometrics - Delano 29/03/04]
    'Gets pixel location on the screen of the vertical centre of the tile at boardy, specifically for a player or item.
    'Accounts for the screen offset.
    'Could consider adding an offset to move sprites further down the tile for isometrics.
    '=========================================
    
    'Called by putSpriteAt only. Sprites are placed on this line.
   
    On Error Resume Next
    
    Dim y As Long
    
    If boardIso() Then
        
        'isoTopY = topY * 2 + 1
        y = (boardy - (topY * 2 + 1)) * 16
        y = y + 8 'Vertical offset to 3/4 down the tile
    Else
        y = (boardy - topY) * 32
    End If
    
    getBottomCentreY = y
    
End Function

Sub incrementPosition(ByRef pos As PLAYER_POSITION, ByRef pend As PENDING_MOVEMENT, ByVal moveFraction As Double)
    '=========================================
    'EDITED: [Isometrics - Delano 28/03/04]
    'Increment the players tile position on the board based on the pending movement.
    'These are positions on the board NOT the screen.
    'This updates the position for each sprite frame; increments are made in fractions of a tile.
    '=========================================
    
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

Sub insertTarget(ByRef pend As PENDING_MOVEMENT)
    '===========================================
    'EDITED: [Isometrics - Delano 28/03/04]
    'Pass in a pending movement with the direction specified and the tile origin specified.
    'Fills in target tile co-ordinates (taking isometrics into account).
    'These are positions on the board NOT the screen.
    '===========================================
    
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



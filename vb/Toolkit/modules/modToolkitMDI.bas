Attribute VB_Name = "modToolkitMDI"
'========================================================================
' The RPG Toolkit, Version 3
' This file copyright (C) 2007 Christopher Matthews & contributors
'
' Contributors:
'    - Colin James Fitzpatrick
'    - Jonathan D. Hughes
'========================================================================
'
' This program is free software; you can redistribute it and/or
' modify it under the terms of the GNU General Public License
' as published by the Free Software Foundation; either version 2
' of the License, or (at your option) any later version.
'
' This program is distributed in the hope that it will be useful,
' but WITHOUT ANY WARRANTY; without even the implied warranty of
' MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
' GNU General Public License for more details.
'
'========================================================================

'=========================================================================
' Global editor multiple document interface procedures
'=========================================================================

'=========================================================================
' VB option settings
'=========================================================================
Option Compare Binary
Option Explicit
Option Base 0

'=========================================================================
' Child form types
'=========================================================================
Public Const FT_BOARD = 11
Public Const FT_ANIMATION = 12
Public Const FT_CHARACTER = 13
Public Const FT_BACKGROUND = 14
Public Const FT_ENEMY = 15
Public Const FT_ITEM = 16
Public Const FT_MAINFILE = 17
Public Const FT_SM = 18
Public Const FT_STATUS = 19
Public Const FT_TILEBITMAP = 20
Public Const FT_RPGCODE = 21
Public Const FT_TILEANIM = 22
Public Const FT_TILE = 23
Public Const FT_GRAB = 24
Public Const FT_CONFIG = 25
Public Const FT_FIGHTING = 26
Public Const FT_RUNTIME = 27
Public Const FT_TIPS = 28
Public Const FT_TUTORIAL = 29
Public Const FT_CURSOR = 30
Public Const FT_HELP = 31

'=========================================================================
' Editor documents
'=========================================================================

Public Type RPGCodeDoc
    prgName As String               'filename
    prgNeedUpdate As Boolean        'needs update?
    prgText As String               'saved text
    Ifont As String                 'initial font
    IfontSize As Integer            'font size
    Imwin As String                 'init message window gfx
    Ichar(4) As String              'initial chars (0-4)
    Iboard As String                'initial board
End Type

Public Type tileDoc
    tileName As String              'Filename
    tileNeedUpdate As Boolean       'Needs to be updated?
    tileMode As Integer             'Current drawing mode in tile editor
    transparentLayer As Integer     'Is layering done transparently
    angle As Integer                'The angle in the "light" form
    lightLength As Integer
    grabx1 As Integer
    graby1 As Integer
    grabx2 As Integer
    graby2 As Integer
    currentColor As Long            'Currently selected tile color
    oldDetail As Integer            'Detail before color conversion
    grid As Integer                 'Grid on/off (tile)
    undoTile() As Long              'Tile undo
    captureColor As Long            'Capture color on/off
    transpcolor As Long             'Transparent color in tile grabber
    getTransp As Long               'GetTranp on/off (grabber)
    bAllowExtraTst As Boolean       'Allow selecting one past the end in tileset editor? Y/N
    changeColor As Long             'Used for changecolor function
    detail As Byte                  'Detail level of tile
    tileMem(64, 32) As Long         'The tile
    isometric As Boolean            'Isometric?
End Type

'=========================================================================
' Active child window
'=========================================================================
Public activeForm As Form
Public activeTileBmp As editTileBitmap
Public activeTileAnm As tileanim
Public activeAnimation As animationeditor
Public activeStatusEffect As editstatus
Public activeBackground As editBackground
Public activeSpecialMove As editsm
Public activeEnemy As editenemy
Public activeRPGCode As rpgcodeedit
Public activeItem As edititem
Public activePlayer As characteredit
Public activeBoard As frmBoardEdit
Public activeTile As tileedit

'=========================================================================
' Open editors
'=========================================================================
Public enemylist() As enemyDoc
Public enemyListOccupied() As Boolean
Public animationList() As animationDoc
Public animationListOccupied() As Boolean
Public bkgList() As bkgDoc
Public bkgListOccupied() As Boolean
Public itemList() As itemDoc
Public itemListOccupied() As Boolean
Public playerList() As playerDoc
Public playerListOccupied() As Boolean
Public specialMoveList() As specialMoveDoc
Public specialMoveListOccupied() As Boolean
Public statusEffectList() As statusEffectDoc
Public statusEffectListOccupied() As Boolean
Public tileAnmList() As tileAnmDoc
Public tileAnmListOccupied() As Boolean
Public tileBmpList() As tileBitmapDoc
Public tileBmpListOccupied() As Boolean
Public rpgcodeList() As RPGCodeDoc
Public rpgcodeListOccupied() As Boolean
Public openTileEditors() As tileedit
Public openTileEditorDocs() As tileDoc

'=========================================================================
' Editor vector procedures
'=========================================================================

Public Sub VectEnemyKillSlot(ByVal idx As Long)
    On Error Resume Next
    'free up memory in the enemy list vector
    enemyListOccupied(idx) = False
End Sub

Public Function VectEnemyNewSlot() As Long
    On Error GoTo vecterr
       
    'test size of array
    Dim test As Long, oldSize As Long, newSize As Long, t As Long
    test = UBound(enemylist)
    
    'find a new slot in the list of boards and return an index we can use
    For t = 0 To UBound(enemylist)
        If enemyListOccupied(t) = False Then
            enemyListOccupied(t) = True
            VectEnemyNewSlot = t
            Exit Function
        End If
    Next t
    
    'must resize the vector...
    oldSize = UBound(enemylist)
    newSize = UBound(enemylist) * 2
    ReDim Preserve enemylist(newSize)
    ReDim Preserve enemyListOccupied(newSize)
    
    enemyListOccupied(oldSize + 1) = True
    VectEnemyNewSlot = oldSize + 1
    
    Exit Function

vecterr:
    ReDim enemylist(1)
    ReDim enemyListOccupied(1)
    Resume Next
    
End Function

Public Sub VectAnimationKillSlot(ByVal idx As Long)
    On Error Resume Next
    'free up memory in the ste list vector
    animationListOccupied(idx) = False
End Sub

Public Function VectAnimationNewSlot() As Long
    On Error GoTo vecterr
       
    'test size of array
    Dim test As Long
    Dim oldSize As Long, newSize As Long, t As Long
    test = UBound(animationList)
    
    'find a new slot in the list of boards and return an index we can use
    For t = 0 To UBound(animationList)
        If animationListOccupied(t) = False Then
            animationListOccupied(t) = True
            VectAnimationNewSlot = t
            Exit Function
        End If
    Next t
    
    'must resize the vector...
    oldSize = UBound(animationList)
    newSize = UBound(animationList) * 2
    ReDim Preserve animationList(newSize)
    ReDim Preserve animationListOccupied(newSize)
    
    animationListOccupied(oldSize + 1) = True
    VectAnimationNewSlot = oldSize + 1
    
    Exit Function

vecterr:
    ReDim animationList(1)
    ReDim animationListOccupied(1)
    Resume Next
    
End Function

Public Sub VectBackgroundKillSlot(ByVal idx As Long)
    On Error Resume Next
    'free up memory in the ste list vector
    bkgListOccupied(idx) = False
End Sub

Public Function VectBackgroundNewSlot() As Long
    On Error GoTo vecterr
       
    'test size of array
    Dim test As Long
    Dim oldSize As Long, newSize As Long, t As Long
    test = UBound(bkgList)
    
    'find a new slot in the list of boards and return an index we can use
    For t = 0 To UBound(bkgList)
        If bkgListOccupied(t) = False Then
            bkgListOccupied(t) = True
            VectBackgroundNewSlot = t
            Exit Function
        End If
    Next t
    
    'must resize the vector...
    oldSize = UBound(bkgList)
    newSize = UBound(bkgList) * 2
    ReDim Preserve bkgList(newSize)
    ReDim Preserve bkgListOccupied(newSize)
    
    bkgListOccupied(oldSize + 1) = True
    VectBackgroundNewSlot = oldSize + 1
    
    Exit Function

vecterr:
    ReDim bkgList(1)
    ReDim bkgListOccupied(1)
    Resume Next
    
End Function

Public Sub VectItemKillSlot(ByVal idx As Long)
    On Error Resume Next
    'free up memory in the item list vector
    itemListOccupied(idx) = False
End Sub

Public Function VectItemNewSlot() As Long
    On Error GoTo vecterr
       
    'test size of array
    Dim test As Long, t As Long, oldSize As Long, newSize As Long
    test = UBound(itemList)
    
    'find a new slot in the list of boards and return an index we can use
    For t = 0 To UBound(itemList)
        If itemListOccupied(t) = False Then
            itemListOccupied(t) = True
            VectItemNewSlot = t
            Exit Function
        End If
    Next t
    
    'must resize the vector...
    oldSize = UBound(itemList)
    newSize = UBound(itemList) * 2
    ReDim Preserve itemList(newSize)
    ReDim Preserve itemListOccupied(newSize)
    
    itemListOccupied(oldSize + 1) = True
    VectItemNewSlot = oldSize + 1
    
    Exit Function

vecterr:
    ReDim itemList(1)
    ReDim itemListOccupied(1)
    Resume Next
    
End Function

Public Sub VectPlayerKillSlot(ByVal idx As Long)
    On Error Resume Next
    'free up memory in the player list vector
    playerListOccupied(idx) = False
End Sub

Public Function VectPlayerNewSlot() As Long
    On Error GoTo vecterr
       
    'test size of array
    Dim test As Long, t As Long, oldSize As Long, newSize As Long
    test = UBound(playerList)
    
    'find a new slot in the list of boards and return an index we can use
    For t = 0 To UBound(playerList)
        If playerListOccupied(t) = False Then
            playerListOccupied(t) = True
            VectPlayerNewSlot = t
            Exit Function
        End If
    Next t
    
    'must resize the vector...
    oldSize = UBound(playerList)
    newSize = UBound(playerList) * 2
    ReDim Preserve playerList(newSize)
    ReDim Preserve playerListOccupied(newSize)
    
    playerListOccupied(oldSize + 1) = True
    VectPlayerNewSlot = oldSize + 1
    
    Exit Function

vecterr:
    ReDim playerList(1)
    ReDim playerListOccupied(1)
    Resume Next
    
End Function

Public Sub VectSpecialMoveKillSlot(ByVal idx As Long)
    On Error Resume Next
    specialMoveListOccupied(idx) = False
End Sub

Public Function VectSpecialMoveNewSlot() As Long
    On Error GoTo vecterr
       
    Dim test As Long, t As Long, oldSize As Long, newSize As Long
    test = UBound(specialMoveList)
    
    'find a new slot in the list of boards and return an index we can use
    For t = 0 To UBound(specialMoveList)
        If specialMoveListOccupied(t) = False Then
            specialMoveListOccupied(t) = True
            VectSpecialMoveNewSlot = t
            Exit Function
        End If
    Next t
    
    'must resize the vector...
    oldSize = UBound(specialMoveList)
    newSize = UBound(specialMoveList) * 2
    ReDim Preserve specialMoveList(newSize)
    ReDim Preserve specialMoveListOccupied(newSize)
    
    specialMoveListOccupied(oldSize + 1) = True
    VectSpecialMoveNewSlot = oldSize + 1
    
    Exit Function

vecterr:
    ReDim specialMoveList(1)
    ReDim specialMoveListOccupied(1)
    Resume Next
    
End Function

Public Sub VectStatusEffectKillSlot(ByVal idx As Long)
    On Error Resume Next
    'free up memory in the ste list vector
    statusEffectListOccupied(idx) = False
End Sub

Public Function VectStatusEffectNewSlot() As Long
    On Error GoTo vecterr
       
    'test size of array
    Dim test As Long, t As Long, oldSize As Long, newSize As Long
    test = UBound(statusEffectList)
    
    'find a new slot in the list of boards and return an index we can use
    For t = 0 To UBound(statusEffectList)
        If statusEffectListOccupied(t) = False Then
            statusEffectListOccupied(t) = True
            VectStatusEffectNewSlot = t
            Exit Function
        End If
    Next t
    
    'must resize the vector...
    oldSize = UBound(statusEffectList)
    newSize = UBound(statusEffectList) * 2
    ReDim Preserve statusEffectList(newSize)
    ReDim Preserve statusEffectListOccupied(newSize)
    
    statusEffectListOccupied(oldSize + 1) = True
    VectStatusEffectNewSlot = oldSize + 1
    
    Exit Function

vecterr:
    ReDim statusEffectList(1)
    ReDim statusEffectListOccupied(1)
    Resume Next
    
End Function

Public Sub VectTileAnmKillSlot(ByVal idx As Long)
    On Error Resume Next
    'free up memory in the tile anm list vector
    tileAnmListOccupied(idx) = False
End Sub

Public Function VectTileAnmNewSlot() As Long
    On Error GoTo vecterr
       
    'test size of array
    Dim test As Long, t As Long, oldSize As Long, newSize As Long
    test = UBound(tileAnmList)
    
    'find a new slot in the list of boards and return an index we can use
    For t = 0 To UBound(tileAnmList)
        If tileAnmListOccupied(t) = False Then
            tileAnmListOccupied(t) = True
            VectTileAnmNewSlot = t
            Exit Function
        End If
    Next t
    
    'must resize the vector...
    oldSize = UBound(tileAnmList)
    newSize = UBound(tileAnmList) * 2
    ReDim Preserve tileAnmList(newSize)
    ReDim Preserve tileAnmListOccupied(newSize)
    
    tileAnmListOccupied(oldSize + 1) = True
    VectTileAnmNewSlot = oldSize + 1
    
    Exit Function

vecterr:
    ReDim tileAnmList(1)
    ReDim tileAnmListOccupied(1)
    Resume Next
    
End Function

Public Sub VectTileBmpKillSlot(ByVal idx As Long)
    On Error Resume Next
    'free up memory in the tile bmp list vector
    tileBmpListOccupied(idx) = False
End Sub

Public Function VectTileBmpNewSlot() As Long
    On Error GoTo vecterr
       
    'test size of array
    Dim test As Long, t As Long, oldSize As Long, newSize As Long
    test = UBound(tileBmpList)
    
    'find a new slot in the list of boards and return an index we can use
    For t = 0 To UBound(tileBmpList)
        If tileBmpListOccupied(t) = False Then
            tileBmpListOccupied(t) = True
            VectTileBmpNewSlot = t
            Exit Function
        End If
    Next t
    
    'must resize the vector...
    oldSize = UBound(tileBmpList)
    newSize = UBound(tileBmpList) * 2
    ReDim Preserve tileBmpList(newSize)
    ReDim Preserve tileBmpListOccupied(newSize)
    
    tileBmpListOccupied(oldSize + 1) = True
    VectTileBmpNewSlot = oldSize + 1
    
    Exit Function

vecterr:
    ReDim tileBmpList(1)
    ReDim tileBmpListOccupied(1)
    Resume Next
    
End Function

Public Sub VectRPGCodeKillSlot(ByVal idx As Long)
    On Error Resume Next
    'free up memory in the special move list vector
    specialMoveListOccupied(idx) = False
End Sub

Public Function VectRPGCodeNewSlot() As Long
    On Error GoTo vecterr
       
    'test size of array
    Dim test As Long, t As Long, oldSize As Long, newSize As Long
    test = UBound(rpgcodeList)
    
    'find a new slot in the list of boards and return an index we can use
    For t = 0 To UBound(rpgcodeList)
        If rpgcodeListOccupied(t) = False Then
            rpgcodeListOccupied(t) = True
            VectRPGCodeNewSlot = t
            Exit Function
        End If
    Next t
    
    'must resize the vector...
    oldSize = UBound(rpgcodeList)
    newSize = UBound(rpgcodeList) * 2
    ReDim Preserve rpgcodeList(newSize)
    ReDim Preserve rpgcodeListOccupied(newSize)
    
    rpgcodeListOccupied(oldSize + 1) = True
    VectRPGCodeNewSlot = oldSize + 1
    
    Exit Function

vecterr:
    ReDim rpgcodeList(1)
    ReDim rpgcodeListOccupied(1)
    Resume Next
    
End Function

Public Function newTileEditIndice() As Long
    
    On Error GoTo newArray

    Dim a As Long
    For a = 0 To UBound(openTileEditors)
        If openTileEditors(a) Is Nothing Then
            'Free spot
            newTileEditIndice = a
            Exit Function
        End If
    Next a

    'If we made it here then we need to enlarge the array
    ReDim Preserve openTileEditors(UBound(openTileEditors) + 1)
    ReDim Preserve openTileEditorDocs(UBound(openTileEditors))
    newTileEditIndice = UBound(openTileEditors)

    Exit Function

newArray:
    ReDim openTileEditors(0)
    ReDim openTileEditorDocs(0)

End Function

Public Sub clearTileDoc(ByRef theTileDoc As tileDoc)
    On Error Resume Next
    With theTileDoc
        .angle = 0
        .bAllowExtraTst = False
        .captureColor = 0
        .changeColor = 0
        .currentColor = 0
        .detail = 1
        .getTransp = 0
        .grabx1 = 0
        .grabx2 = 0
        .graby1 = 0
        .graby2 = 0
        .grid = False
        .isometric = False
        .lightLength = 0
        .oldDetail = 0
        .tileMode = 0
        .tileName = ""
        .tileNeedUpdate = False
        .transparentLayer = 0
        .transpcolor = 0
        ReDim undoTile(0)
        Dim a As Long, b As Long
        For a = 0 To 64
            For b = 0 To 32
                .tileMem(a, b) = -1
            Next b
        Next a
    End With
End Sub

Public Sub redrawAllTiles()
    Dim a As Long, currenttile As tileedit
    Set currenttile = activeTile
    For a = 0 To UBound(openTileEditors)
        If Not openTileEditors(a) Is Nothing Then
            Set activeTile = openTileEditors(a)
            Call activeTile.tileRedraw
        End If
    Next a
    Set activeTile = currenttile
End Sub

Public Property Get tileMem(ByVal x As Long, ByVal y As Long) As Long
    On Error Resume Next
    If activeTile Is Nothing Then
        Set activeTile = New tileedit
    End If
    tileMem = openTileEditorDocs(activeTile.indice).tileMem(x, y)
End Property
Public Property Let tileMem(ByVal x As Long, ByVal y As Long, ByVal newVal As Long)
    On Error Resume Next
    If activeTile Is Nothing Then
        Set activeTile = New tileedit
    End If
    openTileEditorDocs(activeTile.indice).tileMem(x, y) = newVal
End Property

Public Property Get detail() As Byte
    On Error Resume Next
    If activeTile Is Nothing Then
        Set activeTile = New tileedit
    End If
    detail = openTileEditorDocs(activeTile.indice).detail
End Property
Public Property Let detail(ByVal newValue As Byte)
    On Error Resume Next
    If activeTile Is Nothing Then
        Set activeTile = New tileedit
    End If
    openTileEditorDocs(activeTile.indice).detail = newValue
End Property

VERSION 5.00
Begin VB.Form boardedit 
   Appearance      =   0  'Flat
   Caption         =   "Board Editor (Untitled)"
   ClientHeight    =   5715
   ClientLeft      =   -465
   ClientTop       =   750
   ClientWidth     =   9615
   BeginProperty Font 
      Name            =   "Courier New"
      Size            =   6
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H80000008&
   Icon            =   "BOARDEDI.frx":0000
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5715
   ScaleWidth      =   9615
   Tag             =   "2"
   Begin VB.HScrollBar HScroll1 
      Height          =   255
      Left            =   120
      Max             =   32
      Min             =   1
      TabIndex        =   2
      TabStop         =   0   'False
      Top             =   5400
      Value           =   1
      Width           =   9135
   End
   Begin VB.VScrollBar VScroll1 
      Height          =   5295
      Left            =   9240
      Max             =   40
      Min             =   1
      TabIndex        =   1
      TabStop         =   0   'False
      Top             =   120
      Value           =   1
      Width           =   255
   End
   Begin VB.PictureBox boardform 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BackColor       =   &H00FFFFFF&
      BorderStyle     =   0  'None
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   5295
      Left            =   120
      MousePointer    =   2  'Cross
      ScaleHeight     =   353
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   609
      TabIndex        =   0
      Top             =   120
      Width           =   9135
   End
   Begin VB.PictureBox rowstrip 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   735
      Left            =   2640
      ScaleHeight     =   735
      ScaleWidth      =   4215
      TabIndex        =   3
      Top             =   600
      Visible         =   0   'False
      Width           =   4215
   End
   Begin VB.PictureBox colstrip 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   1095
      Left            =   1080
      ScaleHeight     =   1095
      ScaleWidth      =   375
      TabIndex        =   4
      Top             =   240
      Visible         =   0   'False
      Width           =   375
   End
   Begin VB.PictureBox isomask 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   480
      Left            =   0
      Picture         =   "BOARDEDI.frx":0CCA
      ScaleHeight     =   32
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   64
      TabIndex        =   5
      Top             =   0
      Width           =   960
   End
   Begin VB.Menu boardfilemenu 
      Caption         =   "File"
      Tag             =   "1201"
      Begin VB.Menu newprojectmnu 
         Caption         =   "New Project"
         Shortcut        =   ^N
      End
      Begin VB.Menu newmnu 
         Caption         =   "New..."
         Begin VB.Menu newtilemnu 
            Caption         =   "Tile"
         End
         Begin VB.Menu newanimatedtilemnu 
            Caption         =   "Animated Tile"
         End
         Begin VB.Menu newbrdmnu 
            Caption         =   "Board"
         End
         Begin VB.Menu newplayermnu 
            Caption         =   "Player"
         End
         Begin VB.Menu newitemmnu 
            Caption         =   "Item"
         End
         Begin VB.Menu newenemymnu 
            Caption         =   "Enemy"
         End
         Begin VB.Menu newrpgcodeprogrammnu 
            Caption         =   "RPGCode Program"
         End
         Begin VB.Menu mnuNewFightBackground 
            Caption         =   "Fight Background"
         End
         Begin VB.Menu newspecialmovemnu 
            Caption         =   "Special Move"
         End
         Begin VB.Menu newstatuseffectmnu 
            Caption         =   "Status Effect"
         End
         Begin VB.Menu newanimationmnu 
            Caption         =   "Animation"
         End
         Begin VB.Menu newtilebitmapmnu 
            Caption         =   "Tile Bitmap"
         End
      End
      Begin VB.Menu sub1 
         Caption         =   "-"
      End
      Begin VB.Menu mnuOpenProject 
         Caption         =   "Open Project"
      End
      Begin VB.Menu openbrdmnu 
         Caption         =   "Open"
         Shortcut        =   ^O
         Tag             =   "1279"
      End
      Begin VB.Menu savebrdmnu 
         Caption         =   "Save"
         Shortcut        =   ^S
         Tag             =   "1280"
      End
      Begin VB.Menu savebrdasmnu 
         Caption         =   "Save As"
         Shortcut        =   ^A
         Tag             =   "1281"
      End
      Begin VB.Menu saveallmnu 
         Caption         =   "Save All"
      End
      Begin VB.Menu sub2 
         Caption         =   "-"
      End
      Begin VB.Menu dellay 
         Caption         =   "Delete Layer"
         Tag             =   "1282"
      End
      Begin VB.Menu closeditor 
         Caption         =   "Close"
         Tag             =   "1088"
      End
      Begin VB.Menu exitmnu 
         Caption         =   "Exit"
      End
   End
   Begin VB.Menu settingsmenu 
      Caption         =   "Board Settings"
      Tag             =   "1285"
      Begin VB.Menu brdinfomnu 
         Caption         =   "Board Information"
         Tag             =   "1039"
      End
      Begin VB.Menu brdbackgroundmenu 
         Caption         =   "Background"
         Shortcut        =   ^B
         Tag             =   "1053"
      End
      Begin VB.Menu setplyrmnu 
         Caption         =   "Set Player Position"
         Tag             =   "1286"
      End
   End
   Begin VB.Menu blight 
      Caption         =   "Board Lighting"
      Tag             =   "1287"
      Begin VB.Menu lcolor 
         Caption         =   "Light Color"
         Tag             =   "1288"
      End
      Begin VB.Menu SpotLightmnu 
         Caption         =   "Spot Light"
         Tag             =   "1289"
      End
      Begin VB.Menu AmbientEffectsmnu 
         Caption         =   "Ambient Effects"
         Tag             =   "1290"
      End
   End
   Begin VB.Menu rpgcodemnu 
      Caption         =   "RPGCode"
      Tag             =   "1196"
      Begin VB.Menu prgmnu 
         Caption         =   "Set Program"
         Shortcut        =   ^P
         Tag             =   "1291"
      End
      Begin VB.Menu wrp 
         Caption         =   "Set Warp Tile"
         Shortcut        =   ^W
         Tag             =   "1292"
      End
      Begin VB.Menu mnusetitm 
         Caption         =   "Set Item"
         Shortcut        =   ^I
         Tag             =   "1293"
      End
      Begin VB.Menu pmnu 
         Caption         =   "Program Menu"
         Tag             =   "1294"
      End
      Begin VB.Menu itmmenu 
         Caption         =   "Item Menu"
         Tag             =   "1295"
      End
      Begin VB.Menu mnuThreading 
         Caption         =   "Threading"
      End
   End
   Begin VB.Menu toolkitmnu 
      Caption         =   "Toolkit"
      Begin VB.Menu mnutestgame 
         Caption         =   "Test Game"
         Shortcut        =   {F5}
      End
      Begin VB.Menu selectlanguagemnu 
         Caption         =   "Select Language"
         Shortcut        =   ^L
      End
      Begin VB.Menu sub44 
         Caption         =   "-"
      End
      Begin VB.Menu installupgrademnu 
         Caption         =   "Install Upgrade"
      End
   End
   Begin VB.Menu buildmnu 
      Caption         =   "Build"
      Begin VB.Menu createpakfilemnu 
         Caption         =   "Create PakFile"
      End
      Begin VB.Menu makexemnu 
         Caption         =   "Make EXE"
         Shortcut        =   {F7}
      End
      Begin VB.Menu sub45 
         Caption         =   "-"
      End
      Begin VB.Menu createsetupmnu 
         Caption         =   "Create Setup"
      End
   End
   Begin VB.Menu wmdmenu 
      Caption         =   "Window"
      WindowList      =   -1  'True
      Begin VB.Menu showtoolsmnu 
         Caption         =   "Show/Hide Tools"
      End
      Begin VB.Menu showprojectlistmnu 
         Caption         =   "Show/Hide Project List"
      End
      Begin VB.Menu sep5 
         Caption         =   "-"
      End
      Begin VB.Menu tilehorizontallymnu 
         Caption         =   "Tile Horizontally"
      End
      Begin VB.Menu tileverticallymnu 
         Caption         =   "Tile Vertically"
      End
      Begin VB.Menu cascademnu 
         Caption         =   "Cascade"
      End
      Begin VB.Menu arrangeiconsmnu 
         Caption         =   "Arrange Icons"
      End
   End
   Begin VB.Menu h 
      Caption         =   "Help"
      Tag             =   "1206"
      Begin VB.Menu toc 
         Caption         =   "User's Guide"
         Shortcut        =   {F1}
         Tag             =   "1207"
      End
      Begin VB.Menu rpgcodeprimermnu 
         Caption         =   "RPGCode Primer"
      End
      Begin VB.Menu rpgcodreferencemnu 
         Caption         =   "RPGCode Reference"
      End
      Begin VB.Menu sub46 
         Caption         =   "-"
      End
      Begin VB.Menu tutorialmnu 
         Caption         =   "Tutorial"
      End
      Begin VB.Menu historytxtmnu 
         Caption         =   "History.txt"
      End
      Begin VB.Menu sub47 
         Caption         =   "-"
      End
      Begin VB.Menu registrationinfomnu 
         Caption         =   "Registration Info"
      End
      Begin VB.Menu aboutmnu 
         Caption         =   "About"
      End
   End
   Begin VB.Menu mnuPop 
      Caption         =   "Pop"
      Visible         =   0   'False
      Begin VB.Menu mnuPop_Info 
         Caption         =   "Info"
      End
      Begin VB.Menu mnuPop_Type 
         Caption         =   "Type"
         Begin VB.Menu mnuPop_Type_T 
            Caption         =   "Normal"
            Index           =   0
         End
         Begin VB.Menu mnuPop_Type_T 
            Caption         =   "Solid"
            Index           =   1
         End
         Begin VB.Menu mnuPop_Type_T 
            Caption         =   "Under"
            Index           =   2
         End
         Begin VB.Menu mnuPop_Type_T 
            Caption         =   "North-South Normal"
            Index           =   3
         End
         Begin VB.Menu mnuPop_Type_T 
            Caption         =   "East-West Normal"
            Index           =   4
         End
         Begin VB.Menu mnuPop_Type_Layer 
            Caption         =   "Stairs to layer"
            Begin VB.Menu mnuPop_Type_L 
               Caption         =   "one"
               Index           =   11
            End
            Begin VB.Menu mnuPop_Type_L 
               Caption         =   "two"
               Index           =   12
            End
            Begin VB.Menu mnuPop_Type_L 
               Caption         =   "three"
               Index           =   13
            End
            Begin VB.Menu mnuPop_Type_L 
               Caption         =   "four"
               Index           =   14
            End
            Begin VB.Menu mnuPop_Type_L 
               Caption         =   "five"
               Index           =   15
            End
            Begin VB.Menu mnuPop_Type_L 
               Caption         =   "six"
               Index           =   16
            End
            Begin VB.Menu mnuPop_Type_L 
               Caption         =   "seven"
               Index           =   17
            End
            Begin VB.Menu mnuPop_Type_L 
               Caption         =   "eight"
               Index           =   18
            End
         End
      End
      Begin VB.Menu mnuPop_Erase 
         Caption         =   "Erase"
      End
   End
   Begin VB.Menu mTB 
      Caption         =   "ToolBar_Pop"
      Visible         =   0   'False
      Begin VB.Menu mTB_Settings 
         Caption         =   "Settings"
      End
      Begin VB.Menu mTB_Edit 
         Caption         =   "Edit"
      End
      Begin VB.Menu mTB_Remove 
         Caption         =   "Remove"
      End
   End
End
Attribute VB_Name = "boardedit"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'========================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'========================================================================
Option Explicit
'========================================================================
' BOARD EDITOR
'========================================================================

'===================================================
' Additions for new isometric tilesets.
' For 3.0.4 by Delano.
'
'       Changes are required or have been made in the following subs.
'   changeSelectedTile
'   boardSelectTile
'
' Isometric board size issues:
'   boardIso,resizeForm,redrawbrd,Form_Load,refreshGrid,viewTiletype
'   Form boardinformation - size tab alterations.
'   scroll.bas - scrolling changes
'====================================================

'========================================================================
' variable declaration
'========================================================================

' Loading Board {true/false}
Private bOpeningBoard As Boolean

' Current Tile Transparency {true/false}
Private bCurrentTileIsTransparent As Boolean

' Current Tile {if animated}
Private selectedAnm As TKTileAnm

' Board index
Public dataIndex As Long

'Isometric control.
Private minBoardSizeX As Long           '= 19 for 2D, 10 for isometric
Private minBoardSizeY As Long           '= 11 for 2D (should be 15), 30 for isometric (was 23)

' Tile Type UDT
Private Type udtTileType
    color As Integer
    name As String
End Type

'========================================================================
' get tiletype details (color, name) returned as UDT
'========================================================================
Private Function tiletype(value As Variant) As udtTileType

    Dim levelnum As Integer
    
    With tiletype
    
        Select Case value
            Case 0 ' Normal
                .name = LoadStringLoc(816, "Normal")
                .color = 7
                
            Case 1 ' Solid
                .name = LoadStringLoc(817, "Solid")
                .color = 9
                
            Case 2 ' Under
                .name = LoadStringLoc(818, "Under")
                .color = 13
                
            Case 3 ' North-South Normal
                .name = LoadStringLoc(819, "North-South Normal")
                .color = 10
                
            Case 4 ' East-West Normal
                .name = LoadStringLoc(820, "East-West Normal")
                .color = 12
                
            Case 11 To 18 ' Stairs to Layer X
                levelnum = boardList(activeBoardIndex).currentTileType - 10
                .name = LoadStringLoc(821, "Stairs to layer") + str$(levelnum)
                .color = 14
        
        End Select
    
    End With

End Function

'========================================================================
' update board editor tool settings
'========================================================================
Private Sub boardToolSettings(draw As Integer, typel As Integer, eraser As Integer, fill As Integer)
    ignore = 1
    ' set appropiate main form control values
    tkMainForm.boardDrawLock.value = draw
    tkMainForm.boardTypeLock.value = typel
    tkMainForm.boardEraser.value = eraser
    tkMainForm.boardFillTool.value = fill
    ignore = 0
End Sub

'========================================================================
' resets layer list according to board settings
'========================================================================
Private Sub resetLayerList()
    ' clear list
    tkMainForm.Editlayer.Clear
    
    Dim i As Integer, name As String
    
    ' list initial four items
    For i = 1 To 4
        If boardList(activeBoardIndex).theData.boardTitle(i) = "" Then
            name = "Untitled"
        Else
            name = boardList(activeBoardIndex).theData.boardTitle(i)
        End If
        tkMainForm.Editlayer.AddItem "Layer " & i & ": " & name
    Next i
    
    ' if board has 8 layers possible
    If boardList(activeBoardIndex).theData.Bsizel = 8 Then
    For i = 5 To 8
        If boardList(activeBoardIndex).theData.boardTitle(i) = "" Then
            name = "Untitled"
        Else
            name = boardList(activeBoardIndex).theData.boardTitle(i)
        End If
        tkMainForm.Editlayer.AddItem "Layer " & i & ": " & name
    Next i
    Else
        If boardList(activeBoardIndex).currentLayer > 4 Then boardList(activeBoardIndex).currentLayer = 1
    End If
    
    ' set current item selected
    tkMainForm.Editlayer.ListIndex = boardList(activeBoardIndex).currentLayer - 1
End Sub

'========================================================================
' select 'fill' draw setting {from tkMainForm: boardFillTool_Click}
'========================================================================
Public Sub boardFillTool(): On Error Resume Next

    If ignore = 1 Then Exit Sub
    
    ' set board draw state to 8
    boardList(activeBoardIndex).drawState = 8
    
    ' set draw state caption
    tkMainForm.drawstatebox.Caption = LoadStringLoc(1678, "Flood Fill")
    
    ' !UPDATED! update tool settings
    boardToolSettings 0, 0, 0, 1
    
    Call boardRedraw
    
End Sub

'========================================================================
' change selected tile {from tkMainForm: currentTilesetForm_MouseDown}
'========================================================================
Public Sub changeSelectedTile(ByVal file As String): On Error Resume Next
'===================================================
'Additions for .iso tiles, for 3.0.4 by Delano

    If file = "" Then Exit Sub
    
    ' update tileset filename
    boardList(activeBoardIndex).selectedTile$ = file
    
    ' open tileset
    Call openWinTile(projectPath$ + tilePath$ + file)
    
    ' if tileset detail inappropiate, increase detail
    If detail = 2 Or detail = 4 Or detail = 6 Then Call increaseDetail
    
    ' clear isometric tile picture box
    Call vbPicCls(tkMainForm.currenttileIso)
    
    ' call draw isomtric tile routine
    'Added!: different arguement for .iso:
    If UCase$(GetExt(tilesetFilename(file$))) = "ISO" Then
        Call tileDrawIso(tkMainForm.currenttileIso, 0, 0, ISODETAIL)
    Else
    Call tileDrawIso(tkMainForm.currenttileIso, 0, 0, 3)
    End If
    
    Dim X As Long, Y As Long
    
    ' update current board tile
    For X = 1 To 32
        For Y = 1 To 32
            boardList(activeBoardIndex).BoardTile(X, Y) = tilemem(X, Y)
            tilemem(X, Y) = buftile(X, Y)
        Next Y
    Next X
    
    ' update board detail
    boardList(activeBoardIndex).BoardDetail = detail
    detail = publicTile.oldDetail
    
    Dim dx As Long, dy As Long, colorDraw As Long
    
    ' clear current tile picture box
    Call vbPicCls(tkMainForm.currenttile)
    
    ' draw new tile in 'current tile' picture box
    For dx = 1 To 32
        For dy = 1 To 32
            colorDraw = boardList(activeBoardIndex).BoardTile(dx, dy)
            
            'Added: draw white for .iso
            If colorDraw = -1 Or UCase$(GetExt(tilesetFilename(file$))) = "ISO" Then colorDraw = vbQBColor(15)
            
            Call vbPicPSet(tkMainForm.currenttile, dx - 1, dy - 1, colorDraw)
        Next dy
    Next dx
    
    ' update current tileset caption to filename
    tkMainForm.bFrame(2).Caption = "Current Tile - " & boardList(activeBoardIndex).selectedTile$
    
    ' update main form control values
    tkMainForm.animTile.Enabled = False
    tkMainForm.Command20.Enabled = False
    tkMainForm.Command22.Enabled = False
    
End Sub

'========================================================================
' file board with selected tile
'========================================================================
Public Sub fillBoard(ByVal X As Long, ByVal Y As Long, ByVal l As Long, ByVal tileFile As String, Optional ByVal lastX As Long = -1, Optional ByVal lastY As Long = -1): On Error Resume Next
    
    ' get old tile
    Dim replaceTile As Long
    replaceTile = boardList(activeBoardIndex).theData.board(X, Y, l)
    
    ' get new tile
    Dim newTile As Long
    newTile = BoardTileInLUT(tileFile, boardList(activeBoardIndex).theData)
    
    ' check if old and new tile are the same
    If replaceTile = newTile Then Exit Sub
    
    ' set grid reference to new tile
    boardList(activeBoardIndex).theData.board(X, Y, l) = newTile
    boardList(activeBoardIndex).theData.tiletype(X, Y, l) = boardList(activeBoardIndex).currentTileType
    
    Dim sizex As Long, sizey As Long
    
    ' get current board size
    sizex = boardList(activeBoardIndex).theData.Bsizex
    sizey = boardList(activeBoardIndex).theData.Bsizey
    
    Dim x2 As Long, y2 As Long
    
    ' get new x and y position
    x2 = X + 1: y2 = Y
    
    ' check against boundries of board
    If (x2 <= sizex And y2 <= sizey And x2 >= 1 And y2 >= 1 And (x2 <> lastX Or y2 <> lastY)) Then
    
        ' if old tile is the same as replaced tile
        If boardList(activeBoardIndex).theData.board(x2, y2, l) = replaceTile Then: Call fillBoard(x2, y2, l, tileFile, X, Y)

    End If
    
    ' get new x and y position
    x2 = X: y2 = Y - 1
    
    ' check against boundries of board
    If (x2 <= sizex And y2 <= sizey And x2 >= 1 And y2 >= 1 And (x2 <> lastX Or y2 <> lastY)) Then
    
        ' if old tile is same as replaced tile
        If boardList(activeBoardIndex).theData.board(x2, y2, l) = replaceTile Then: Call fillBoard(x2, y2, l, tileFile, X, Y)
    
    End If
    
    ' get new x and y position
    x2 = X - 1: y2 = Y
    
    ' check against boundries of board
    If (x2 <= sizex And y2 <= sizey And x2 >= 1 And y2 >= 1 And (x2 <> lastX Or y2 <> lastY)) Then
        
        ' if old tile is same as replaced tile
        If boardList(activeBoardIndex).theData.board(x2, y2, l) = replaceTile Then: Call fillBoard(x2, y2, l, tileFile, X, Y)
    
    End If
    
    ' get new x and y position
    x2 = X: y2 = Y + 1
    
    ' check against boundries of board
    If (x2 <= sizex And y2 <= sizey And x2 >= 1 And y2 >= 1 And (x2 <> lastX Or y2 <> lastY)) Then
        
        ' if old tile is same as replaced tile
        If boardList(activeBoardIndex).theData.board(x2, y2, l) = replaceTile Then: Call fillBoard(x2, y2, l, tileFile, X, Y)

    End If
    
End Sub

'========================================================================
' change board state {2d/isometric}
'========================================================================
Sub boardIso(ByVal val As Integer): On Error Resume Next
'=====================================================
'Alterations for isometric sizing, for 3.0.4 by Delano

    If ignore = 1 Then Exit Sub

    ' set isomertic value
    boardList(activeBoardIndex).theData.isIsometric = val
    
    ' if board 2d
    MsgBox "Your board has now changed mode, you may need to change the board size and placement of items/programs as a result." _
        & chr$(13) & chr$(13) _
        & "Isometric boards have minimum dimensions of 10x30, and standard boards 19x11. Smaller boards will be enlarged upon conversion."
    
    'Isometric settings
    If val = 1 Then
        'Isometric.
        'Minimum *viewing* dimensions! Used in resizeForm.
        minBoardSizeX = 10
        minBoardSizeY = 23
        
        If boardList(activeBoardIndex).theData.Bsizey < 30 Then _
            Call BoardResize(boardList(activeBoardIndex).theData.Bsizex, 30, _
                boardList(activeBoardIndex).theData.Bsizel, boardList(activeBoardIndex).theData)
        
    Else
        'Minimum *viewing* dimensions!!!
        minBoardSizeX = 19
        minBoardSizeY = 11
        
        If boardList(activeBoardIndex).theData.Bsizex < 19 Then _
            Call BoardResize(19, boardList(activeBoardIndex).theData.Bsizey, _
            boardList(activeBoardIndex).theData.Bsizel, boardList(activeBoardIndex).theData)
        
    End If
    
    ' redraw board
    boardList(activeBoardIndex).topX = 0
    boardList(activeBoardIndex).topY = 0
    Call boardRedraw
    Call resizeForm(0, 0)
        
    
End Sub

'========================================================================
' change current layer {from tkMainForm: Editlayer_Click}
'========================================================================
Public Sub changeLayer(): On Error Resume Next

    ' set new layer value
    boardList(activeBoardIndex).currentLayer = tkMainForm.Editlayer.ListIndex + 1
    
    ' redraw current layer
    Call boardRedraw

    tkMainForm.boardToolbar.Objects.Populate
    
End Sub

'========================================================================
' draw all layers {from tkMainForm: Command21_Click}
'========================================================================
Public Sub drawLayers(Optional buttonClick As Boolean = False): On Error Resume Next

    If buttonClick = False Then
        If tkMainForm.boardToolbar.Display.Setting(eRedrawAll) = 0 Then
            Call boardRedraw
            Exit Sub
        End If
    End If

    ' fill picture box with board color
    Call vbPicFillRect(boardform, 0, 0, 2000, 2000, boardList(activeBoardIndex).theData.brdColor)
    
    Dim Temp As String, col As Long, ext As String, offsetX As Long, offsetY As Long, X As Long, Y As Long, xx As Long, yy As Long
    
    ' drawbackground
    DrawBackground
    
    ' set picture box auto redraw to true
    Call vbPicAutoRedraw(boardform, True)
    
    Dim layernum As Integer
    
    ' loop through each layer and redraw
    For layernum = 1 To boardList(activeBoardIndex).theData.Bsizel: Call activeBoard.redrawbrd(layernum): Next layernum
    
    ' refresh grid
    Call refreshGrid
    
    ' draw tile types
    Call viewtiletypes
    
    ' draw programs
    Call drawPrograms
    
    ' draw items
    Call drawItems
    
    ' draw warps
    Call drawWarps
    
    ' refresh picture box
    Call vbPicRefresh(boardform)
    
End Sub

'========================================================================
' play animated tile {from tkMainForm: Command22_Click}
'========================================================================
Public Sub playAnimatedTile(): On Error Resume Next

    Dim whichType As String
    
    ' get extension of selected tile
    whichType$ = extention(boardList(activeBoardIndex).selectedTile$)
    
    ' check it is animated tile and enable animated tile timer
    If UCase$(whichType$) = "TAN" Then: tkMainForm.animTile.Enabled = True
    
End Sub

'========================================================================
' identify type of form
'========================================================================
Public Function formType() As Long: On Error Resume Next

    formType = FT_BOARD
    
End Function

'========================================================================
' get current board y co-ord from pixel co-ords
'========================================================================
Function pixelToBoardCoordX(ByVal X As Long, ByVal Y As Long) As Long

    Dim xx As Long, yy As Long, oy As Long, ox As Long, ex As Long, ey As Long, pt As Long, offsetX As Long, offsetY As Long
    
    ' perform calculartion depending on isometric or not
    If boardList(activeBoardIndex).theData.isIsometric = 0 Then
    
        ' calculate x
        xx = Int(X / 32) + 1
        
        ' calculate y
        yy = Int(Y / 32) + 1
        
    Else
    
        ' isometric calculation
        If boardList(activeBoardIndex).topY Mod 2 = 0 Then
        
            offsetY = 16
            
        Else
        
            offsetY = 0
            
        End If
        
        xx = Int(X / 64) + 1
        oy = Int((Y + offsetY) / 32) + 1
        yy = 2 * oy - 1
        
        ex = (xx - 1) * 64
        ey = (oy - 1) * 32
        
        ex = X - ex
        ey = (Y + offsetY) - ey
        
        pt = vbPicPoint(isomask, ex, ey)
        
        If pt <> RGB(255, 255, 255) Then
        
            If (ex >= 32 And ey <= 16) Then
            
                xx = xx + 1
                yy = yy - 1
                
            ElseIf (ex >= 32 And ey > 16) Then
            
                xx = xx + 1
                yy = yy + 1
                
            ElseIf (ex < 32 And ey <= 16) Then
            
                yy = yy - 1
                
            ElseIf (ex < 32 And ey > 16) Then
            
                yy = yy + 1
                
            End If
            
        End If
        
    End If
    
    ' return board x co-ord
    pixelToBoardCoordX = xx + boardList(activeBoardIndex).topX
    
End Function

'========================================================================
' get current board y co-ord from pixel co-ords
'========================================================================
Function pixelToBoardCoordY(ByVal X As Long, ByVal Y As Long) As Long

    Dim xTile As Long, yTile As Long, offsetX As Long, offsetY As Long
    Dim ox As Long, oy As Long, ex As Long, ey As Long, pt As Long
    Dim maskX As Integer, maskY As Integer, dx As Integer, dy As Integer
    
    ' perform calculartion depending on isometric or not
    If boardList(activeBoardIndex).theData.isIsometric = 0 Then
    
        ' calculate x
        xTile = Int(X / 32) + 1
        
        ' calculate y
        yTile = Int(Y / 32) + 1
        
    Else
        'Isometric. New!
    
        If boardList(activeBoardIndex).topY Mod 2 = 0 Then
            offsetY = 16
        Else
            offsetY = 0
        End If
        
        'Calculate initial tile position.
        xTile = Int(X / 64) + 1
        yTile = Int((Y + offsetY) / 32) * 2 + 1 + boardList(activeBoardIndex).topY Mod 2
            
        'Calculate the position on the mask.
        maskX = X Mod 64
        maskY = (Y + offsetY) Mod 32
        
        'Some initial values for the correction.
        dx = 0: dy = 0
            
        'Compare the click to the mask. (1->64, 1->32)
        If isoMaskBmp(maskX + 1, maskY + 1) <> 0 Then
            'This pixel is on the masked off area, and
            'corresponds to a different tile.
                
            'Calculate the tile number corrections.
            dx = Int(maskX / 32): If dx = 0 Then dx = -1
            dy = Int(maskY / 16): If dy = 0 Then dy = -1
                
        End If
            
        'Calculate the new co-ordinates.
        xTile = xTile + dx
        yTile = yTile + dy
    
    End If
        
    pixelToBoardCoordY = yTile + boardList(activeBoardIndex).topY
    
    Exit Function

    'Old code.
    
        ' isometric calculation
        If boardList(activeBoardIndex).topY Mod 2 = 0 Then
        
            offsetY = 16
            
        Else
        
            offsetY = 0
            
        End If
        
        xTile = Int(X / 64) + 1
        oy = Int((Y + offsetY) / 32) + 1 + boardList(activeBoardIndex).topY Mod 2
        yTile = 2 * oy - 1
        
        ex = (xTile - 1) * 64
        ey = (oy - 1) * 32
        
        ex = X - ex
        ey = (Y + offsetY) - ey
        
        pt = vbPicPoint(isomask, ex, ey)
        
        If pt <> RGB(255, 255, 255) Then
        
            If (ex >= 32 And ey <= 16) Then
            
                xTile = xTile + 1
                yTile = yTile - 1
                
            ElseIf (ex >= 32 And ey > 16) Then
            
                xTile = xTile + 1
                yTile = yTile + 1
                
            ElseIf (ex < 32 And ey <= 16) Then
            
                yTile = yTile - 1
                
            ElseIf (ex < 32 And ey > 16) Then
            
                yTile = yTile + 1
                
            End If
            
        End If
        
    'End If
    
    ' return board y co-ord
    pixelToBoardCoordY = yTile + boardList(activeBoardIndex).topY
    
End Function

'========================================================================
' refresh grid
'========================================================================
Sub refreshGrid(): On Error Resume Next
'=====================================================
'Alterations for isometric sizing, for 3.0.4 by Delano
    
    Dim col As Long, offsetY As Long, yy As Long, xx As Long, X As Long, Y As Long
    
    ' check grid is on
    If boardList(activeBoardIndex).gridBoard = 1 Then
    
        col = 1
        
        ' if isometric
        If boardList(activeBoardIndex).theData.isIsometric Then
        
            If boardList(activeBoardIndex).topY Mod 2 = 0 Then
                offsetY = 0
            Else
                offsetY = 16
            End If
            
            'First set of gridlines rewritten. Should work in every case now!
            Dim gridHeight As Long
            gridHeight = boardList(activeBoardIndex).tilesX / 2 + boardList(activeBoardIndex).tilesY
            
            xx = 0
            
            ' draw grid lines. Top right to bottom left.
            For Y = 0 To gridHeight * 32 Step 32
                Call vbPicLine(boardform, 0, Y + offsetY, xx + offsetY * 2, 0, vbQBColor(col))
                xx = xx + 64
            Next Y

            xx = 0
            
            ' draw grid lines. Top left to bottom right.
            For Y = boardList(activeBoardIndex).tilesY * 32 To -boardList(activeBoardIndex).tilesY * 32 Step -32
                Call vbPicLine(boardform, 0, Y + offsetY, xx, boardList(activeBoardIndex).tilesY * 32 + offsetY, vbQBColor(col))
                xx = xx + 64
            Next Y
        
        ' if 2d
        Else
        
            ' draw grid lines
            For X = 0 To boardList(activeBoardIndex).tilesX * 32 Step 32: Call vbPicLine(boardform, X, 0, X, boardList(activeBoardIndex).tilesY * 32, vbQBColor(col)): Next X
            For Y = 0 To boardList(activeBoardIndex).tilesY * 32 Step 32: Call vbPicLine(boardform, 0, Y, boardList(activeBoardIndex).tilesX * 32, Y, vbQBColor(col)): Next Y
            
        End If
        
    End If

End Sub

'========================================================================
' toggle tile type setting {from tkMainForm: toggle_Click}
'========================================================================
Public Sub toggleTileType(): On Error Resume Next

    ' increment tile type
    boardList(activeBoardIndex).currentTileType = boardList(activeBoardIndex).currentTileType + 1
    
    ' if tile type if five, then set to 11
    If boardList(activeBoardIndex).currentTileType = 5 Then boardList(activeBoardIndex).currentTileType = 11
    
    ' reset to 0 once last type is passed
    If boardList(activeBoardIndex).currentTileType > 18 Then boardList(activeBoardIndex).currentTileType = 0
    
    Dim levelnum As Long, aPoint As Long, colorCode As Long, xx As Long, yy As Long
    
    ' !UPDATED! update caption with appropiate tile type caption
    tkMainForm.bFrame(1).Caption = "Tile Type - " & tiletype(boardList(activeBoardIndex).currentTileType).name
    colorCode = tiletype(boardList(activeBoardIndex).currentTileType).color
    
    ' draw tile type image in pixture box
    For aPoint = 9 To 16: Call vbPicLine(tkMainForm.arrowtype, xx + aPoint - 4, yy + aPoint - 6, xx + 32 - aPoint - 4, yy + aPoint - 6, vbQBColor(colorCode)): Next aPoint

End Sub

'========================================================================
' select new tile type {from tkMainForm: tiletypes_MouseDown}
'========================================================================
Public Sub ChangeTileType(button As Integer, Shift As Integer, X As Single, Y As Single): On Error Resume Next
    
    Dim ttype As Long, colorCode As Long, levelnum As Long, aPoint As Long, xx As Long, yy As Long
    
    ' get tile type number from click x co-ord
    ttype = Int(X / 18)
    
    ' update board tile type
    boardList(activeBoardIndex).currentTileType = ttype
    
    ' if tile type if five, then set to 11
    If boardList(activeBoardIndex).currentTileType >= 5 Then boardList(activeBoardIndex).currentTileType = boardList(activeBoardIndex).currentTileType + 6
    
    ' reset to 0 once last type is passed
    If boardList(activeBoardIndex).currentTileType > 18 Then boardList(activeBoardIndex).currentTileType = 18

    ' !UPDATED! update caption with appropiate tile type caption
    tkMainForm.bFrame(1).Caption = "Tile Type - " & tiletype(boardList(activeBoardIndex).currentTileType).name
    colorCode = tiletype(boardList(activeBoardIndex).currentTileType).color

    ' draw tile type image in pixture box
    For aPoint = 9 To 16: Call vbPicLine(tkMainForm.arrowtype, xx + aPoint - 4, yy + aPoint - 6, xx + 32 - aPoint - 4, yy + aPoint - 6, vbQBColor(colorCode)): Next aPoint

End Sub

'========================================================================
' change ambient light {from tkMainForm: ambientlight_Change}
'========================================================================
Public Sub changeAmbientLight(): On Error Resume Next

    ' update RGB values for board
    boardList(activeBoardIndex).ambientR = tkMainForm.ambientlight.value
    boardList(activeBoardIndex).ambientG = tkMainForm.ambientlight.value
    boardList(activeBoardIndex).ambientB = tkMainForm.ambientlight.value
    
    ' update form caption for ambient value
    tkMainForm.ambientnumber.Text = toString(tkMainForm.ambientlight.value)
    
    ' set picture box as ambience
    Call vbPicFillRect(tkMainForm.Picture1, 0, 0, 1000, 1000, RGB(255, 255, 255))
    
End Sub

'========================================================================
' change ambient number {from tkMainForm: ambientnumber_Change}
'========================================================================
Public Sub changeAmbientNumber(): On Error Resume Next

    ' check numeric value entered
    If tkMainForm.ambientnumber.Text = "-" Then Exit Sub
    
    Dim level As Long
    
    ' convert text to numeral
    level = val(tkMainForm.ambientnumber.Text)
    
    ' check boundries
    If level > 255 Then level = 255
    If level < -255 Then level = -255
    
    ' update ambient light value
    tkMainForm.ambientlight.value = level

End Sub

'========================================================================
' select ambient colour {from tkMainForm: Picture1_Click}
'========================================================================
Public Sub selectAmbientColor(): On Error Resume Next

    Dim c As Long
    
    ' open colour dialog
    c = ColorDialog()
    
    ' if colour selected
    If (c <> -1) Then
    
        ' update ambient colour settings
        boardList(activeBoardIndex).ambientR = red(c)
        boardList(activeBoardIndex).ambientG = green(c)
        boardList(activeBoardIndex).ambientB = blue(c)
        
        ' update picture box with new color
        Call vbPicFillRect(tkMainForm.Picture1, 0, 0, 1000, 1000, c)
        
        ' update ambient number text box value
        tkMainForm.ambientnumber.Text = "0"
        
    End If
    
End Sub

'========================================================================
' animate tile {from tkMainForm: animTile_Timer}
'========================================================================
Public Sub animateTile()

    If TileAnmShouldDrawFrame(selectedAnm) Then
    
        ' clear current tile picture box
        Call vbPicCls(tkMainForm.currenttile)
        
        ' draw next frame of animated tile
        Call TileAnmDrawNextFrame(selectedAnm, vbPicHDC(tkMainForm.currenttile), 1, 1, 0, 0, 0)
        
        ' refresh picture box
        Call vbPicRefresh(tkMainForm.currenttile)
        
    End If
    
End Sub

'========================================================================
' animate tile
'========================================================================
Public Sub saveAsFile(): On Error Resume Next

    ' check if board has been altered
    If boardList(activeBoardIndex).boardNeedUpdate = True Then

        Me.Show
        
        ' call save routine
        savebrdasmnu_click
        
    End If
    
End Sub

'========================================================================
' apply gradient to board
'========================================================================
Sub applyGradient(): On Error Resume Next

    Dim r1 As Long, g1 As Long, b1 As Long, r2 As Long, g2 As Long, b2 As Long, _
    rd As Long, ri As Double, gd As Long, gi As Double, bd As Long, bi As Double, _
    ra As Long, ga As Long, ba As Long, inter As Long, xx As Long, yy As Long
    
    ' get first gradient colour
    r1 = red(boardList(activeBoardIndex).boardGradientColor1)
    g1 = green(boardList(activeBoardIndex).boardGradientColor1)
    b1 = blue(boardList(activeBoardIndex).boardGradientColor1)
    
    ' get second gradient colour
    r2 = red(boardList(activeBoardIndex).boardGradientColor2)
    g2 = green(boardList(activeBoardIndex).boardGradientColor2)
    b2 = blue(boardList(activeBoardIndex).boardGradientColor2)
    
    ' perform appropiate gradient type
    Select Case boardList(activeBoardIndex).boardGradientType
    
        Case 0 ' left to right
        
            rd = r2 - r1
            ri = rd / (boardList(activeBoardIndex).boardGradRight - boardList(activeBoardIndex).boardGradLeft)
            
            gd = g2 - g1
            gi = gd / (boardList(activeBoardIndex).boardGradRight - boardList(activeBoardIndex).boardGradLeft)
            
            bd = b2 - b1
            bi = bd / (boardList(activeBoardIndex).boardGradRight - boardList(activeBoardIndex).boardGradLeft)
            
            ' loop across x axis
            For xx = boardList(activeBoardIndex).boardGradLeft To boardList(activeBoardIndex).boardGradRight
            
                ' loop across y axis
                For yy = boardList(activeBoardIndex).boardGradTop To boardList(activeBoardIndex).boardGradBottom
                    
                    inter = xx - boardList(activeBoardIndex).boardGradLeft
                    
                    ra = inter * ri
                    ga = inter * gi
                    ba = inter * bi
                    
                    If boardList(activeBoardIndex).boardGradMaintainPrev = True Then
                    
                        boardList(activeBoardIndex).theData.ambientred(xx, yy, boardList(activeBoardIndex).currentLayer) = boardList(activeBoardIndex).theData.ambientred(xx, yy, boardList(activeBoardIndex).currentLayer) + r1 + ra
                        boardList(activeBoardIndex).theData.ambientgreen(xx, yy, boardList(activeBoardIndex).currentLayer) = boardList(activeBoardIndex).theData.ambientgreen(xx, yy, boardList(activeBoardIndex).currentLayer) + g1 + ga
                        boardList(activeBoardIndex).theData.ambientblue(xx, yy, boardList(activeBoardIndex).currentLayer) = boardList(activeBoardIndex).theData.ambientblue(xx, yy, boardList(activeBoardIndex).currentLayer) + b1 + ba
                    
                    Else
                    
                        boardList(activeBoardIndex).theData.ambientred(xx, yy, boardList(activeBoardIndex).currentLayer) = r1 + ra
                        boardList(activeBoardIndex).theData.ambientgreen(xx, yy, boardList(activeBoardIndex).currentLayer) = g1 + ga
                        boardList(activeBoardIndex).theData.ambientblue(xx, yy, boardList(activeBoardIndex).currentLayer) = b1 + ba
                        
                    End If
                    
                Next yy
                
            Next xx
    
        Case 1 ' top to bottom
        
            rd = r2 - r1
            ri = rd / (boardList(activeBoardIndex).boardGradBottom - boardList(activeBoardIndex).boardGradTop)
            
            gd = g2 - g1
            gi = gd / (boardList(activeBoardIndex).boardGradBottom - boardList(activeBoardIndex).boardGradTop)
            
            bd = b2 - b1
            bi = bd / (boardList(activeBoardIndex).boardGradRight - boardList(activeBoardIndex).boardGradLeft)
            
            ' loop across y axis
            For yy = boardList(activeBoardIndex).boardGradTop To boardList(activeBoardIndex).boardGradBottom
                
                ' loop across x axis
                For xx = boardList(activeBoardIndex).boardGradLeft To boardList(activeBoardIndex).boardGradRight
                    
                    inter = yy - boardList(activeBoardIndex).boardGradTop
                    
                    ra = inter * ri
                    ga = inter * gi
                    ba = inter * bi
                    
                    If boardList(activeBoardIndex).boardGradMaintainPrev = True Then
                        
                        boardList(activeBoardIndex).theData.ambientred(xx, yy, boardList(activeBoardIndex).currentLayer) = boardList(activeBoardIndex).theData.ambientred(xx, yy, boardList(activeBoardIndex).currentLayer) + r1 + ra
                        boardList(activeBoardIndex).theData.ambientgreen(xx, yy, boardList(activeBoardIndex).currentLayer) = boardList(activeBoardIndex).theData.ambientgreen(xx, yy, boardList(activeBoardIndex).currentLayer) + g1 + ga
                        boardList(activeBoardIndex).theData.ambientblue(xx, yy, boardList(activeBoardIndex).currentLayer) = boardList(activeBoardIndex).theData.ambientblue(xx, yy, boardList(activeBoardIndex).currentLayer) + b1 + ba
                    
                    Else
                    
                        boardList(activeBoardIndex).theData.ambientred(xx, yy, boardList(activeBoardIndex).currentLayer) = r1 + ra
                        boardList(activeBoardIndex).theData.ambientgreen(xx, yy, boardList(activeBoardIndex).currentLayer) = g1 + ga
                        boardList(activeBoardIndex).theData.ambientblue(xx, yy, boardList(activeBoardIndex).currentLayer) = b1 + ba
                    
                    End If
                    
                Next xx
                
            Next yy
    
    End Select
    
End Sub

'========================================================================
' apply gradient to board
'========================================================================
Public Sub boardDrawLock(): On Error Resume Next
    
    If ignore = 1 Then Exit Sub
    
    ' update board draw state
    boardList(activeBoardIndex).drawState = 0
    
    ' update caption
    tkMainForm.drawstatebox.Caption = LoadStringLoc(1277, "Draw Lock")
    
    ' !UPDATED! update tool settings
    boardToolSettings 1, 0, 0, 0
    
    ' redraw board
    Call boardRedraw

End Sub

'========================================================================
' select eraser
'========================================================================
Public Sub boardEraser(): On Error Resume Next
    
    If ignore = 1 Then Exit Sub
    
    ' update board draw state
    boardList(activeBoardIndex).drawState = 6
    
    ' update caption
    tkMainForm.drawstatebox.Caption = LoadStringLoc(1677, "Eraser")
    
    ' update tool settings
    boardToolSettings 0, 0, 1, 0
    
    Call boardRedraw
    
End Sub

'========================================================================
' load board gradient form
'========================================================================
Public Sub boardGradient(): On Error Resume Next

    ' load board gradient form
    boardgradientdefine.Show vbModal
    
End Sub

'========================================================================
' draw background image
'========================================================================
Public Sub DrawBackground()
'=====================================================
'Alterations for isometric sizing, for 3.0.4 by Delano

    Dim Temp As String, col As Long, ext As String, offsetX As Long, offsetY As Long, X As Long, Y As Long, xx As Long, yy As Long
    
    ' calculate x and y pixel positions
    If boardList(activeBoardIndex).theData.isIsometric = 1 Then
        X = 0 - (boardList(activeBoardIndex).topX * 64)
        Y = 0 - (boardList(activeBoardIndex).topY * 16)         'Altered - was * 48
    Else
        X = 0 - (boardList(activeBoardIndex).topX * 32)
        Y = 0 - (boardList(activeBoardIndex).topY * 32)
    End If
    
    ' if border has a background image
    If boardList(activeBoardIndex).theData.borderBack$ <> "" Then
    
        ' set string as image filename
        Temp$ = projectPath$ + bmpPath$ + boardList(activeBoardIndex).theData.borderBack$
        
        ' extract file extension
        ext = extention(boardList(activeBoardIndex).theData.borderBack$)
        
        ' set form auto redraw to true
        Call vbPicAutoRedraw(boardedit, True)
        
        ' draw image to form
        Call DrawImage(Temp$, X, Y, vbFrmHDC(boardedit))
        
        ' refresh form
        Call vbFrmRefresh(boardedit)
        
    End If
    
    ' if board has a background image
    If boardList(activeBoardIndex).theData.brdBack$ <> "" Then
    
        ' set string as image filename
        Temp$ = projectPath$ + bmpPath$ + boardList(activeBoardIndex).theData.brdBack$
        
        ' extract file extension
        ext = extention(boardList(activeBoardIndex).theData.brdBack$)
        
        ' draw image to picture box
        Call DrawImage(Temp$, X, Y, vbPicHDC(boardform))
        
    End If
    
End Sub

'========================================================================
' redraw board
'========================================================================
Public Sub boardRedraw(): On Error Resume Next

    If tkMainForm.boardToolbar.Display.Setting(eRedrawAll) = 1 Then
        Call drawLayers
        Exit Sub
    End If
    
    ' fill picture box with board color
    Call vbPicFillRect(boardform, 0, 0, 2000, 2000, boardList(activeBoardIndex).theData.brdColor)
    
    Dim Temp As String, col As Long, ext As String, offsetX As Long, offsetY As Long, X As Long, Y As Long, xx As Long, yy As Long
    
    Call DrawBackground
    
    ' set picture box auto redraw to true
    Call vbPicAutoRedraw(boardform, True)

    ' redraw current layer
    Call redrawbrd(boardList(activeBoardIndex).currentLayer)
    
    ' refresh grid
    Call refreshGrid
    
    ' draw tile types
    Call viewtiletypes
    
    ' draw programs
    Call drawPrograms
    
    ' draw items
    Call drawItems
    
    ' draw warps
    Call drawWarps

    ' refresh picture box
    Call vbPicRefresh(boardform)
    
End Sub

'========================================================================
' select new tile
'========================================================================
Public Sub boardSelectTile(): On Error Resume Next
'========================================================================
'Edited by Delano for 3.0.4 new isometric tilesets.
'Added .iso to available tiles.
    
    Dim X As Long, Y As Long, antiPath As String, whichType As String
    
    bCurrentTileIsTransparent = False
    
    ignore = 1
    
    ' set old detail
    publicTile.oldDetail = detail
    
    ' get old tile
    For X = 1 To 32
        For Y = 1 To 32
            buftile(X, Y) = tilemem(X, Y)
        Next Y
    Next X
    
    ' change directory
    ChDir (currentDir$)
    
    ' initialise file dialog
    Dim dlg As FileDialogInfo
    
    ' set dialog values
    dlg.strDefaultFolder = projectPath$ + tilePath$
    dlg.strTitle = "Select Tile"
    dlg.strDefaultExt = "gph"
    'Added: .iso
    dlg.strFileTypes = "Supported Types|*.gph;*.tst;*.tan;*.iso|RPG Toolkit Tile (*.gph)|*.gph|RPG Toolkit TileSet (*.tst)|*.tst|Tile Animation (*.tan)|*.tan|RPG Toolkit Isometric TileSet (*.iso)|*.iso|All files(*.*)|*.*"
    
    ' get user action
    If OpenFileDialog(dlg, Me.hwnd) Then
    
        ' get filename selected
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
        
    Else
    
        Exit Sub
        
    End If
    
    ' change directory
    ChDir (currentDir$)
    
    ' if no file selected
    If filename$(1) = "" Then Exit Sub
    
    ' get file extension.
    whichType$ = extention(filename$(1))

    ' check if file is a tileset. .iso added!
    If UCase$(whichType$) = "TST" Or UCase$(whichType$) = "ISO" Then
    
        tstnum = 0
        
        ' copy file into direcotry
        FileCopy filename$(1), projectPath$ + tilePath$ + antiPath$
        
        tstFile$ = antiPath$
        lastTileset$ = tstFile$
        
        ' open tileset form
        tilesetform.Show vbModal

        ' if no tile selected
        If setFilename$ = "" Then Exit Sub
        
        ' update current tile and selected tile
        boardList(activeBoardIndex).selectedTile$ = setFilename$
        
        ' open tileset
        Call openWinTile(projectPath$ + tilePath$ + setFilename$)
        
        ' if tileset detail inappropiate, increase detail
        If detail = 2 Or detail = 4 Or detail = 6 Then Call increaseDetail
        
        ' call draw isomtric tile routine
        'Added: different argument for .iso
        If UCase$(whichType$) = "ISO" Then
            Call tileDrawIso(tkMainForm.currenttileIso, 0, 0, ISODETAIL)
        Else
        Call tileDrawIso(tkMainForm.currenttileIso, 0, 0, 3)
        End If
        
        ' update current board tile
        For X = 1 To 32
            For Y = 1 To 32
                boardList(activeBoardIndex).BoardTile(X, Y) = tilemem(X, Y)
                tilemem(X, Y) = buftile(X, Y)
            Next Y
        Next X

        ' update board detail
        boardList(activeBoardIndex).BoardDetail = detail
        detail = publicTile.oldDetail
        
        Dim dx As Long, dy As Long, colorDraw As Long
        
        ' draw new tile in 'current tile' picture box
        For dx = 1 To 32
            For dy = 1 To 32
                colorDraw = boardList(activeBoardIndex).BoardTile(dx, dy)
                
                'Added: draw white for .iso
                If colorDraw = -1 Or UCase$(whichType$) = "ISO" Then colorDraw = vbQBColor(15)
                
                Call vbPicPSet(tkMainForm.currenttile, dx - 1, dy - 1, colorDraw)
            Next dy
        Next dx
        
        
        ' update current tileset caption to filename
        tkMainForm.bFrame(2).Caption = "Current Tile - " & boardList(activeBoardIndex).selectedTile$

        ' update main form control values
        tkMainForm.animTile.Enabled = False
        tkMainForm.Command20.Enabled = False
        tkMainForm.Command22.Enabled = False
        
    Else
        ' if file is animated tile
        If UCase$(whichType$) = "TAN" Then
        
            ' copy file to directory
            FileCopy filename$(1), projectPath$ + tilePath$ + antiPath$
            
            ' update current tile to selected tile
            boardList(activeBoardIndex).selectedTile$ = antiPath$
            
            ' open animated tile
            Call openTileAnm(filename$(1), selectedAnm)
            
            ' open tileset
            Call openWinTile(projectPath$ + tilePath$ + TileAnmGet(selectedAnm, 0))
            
            ' if tileset detail inappropiate, increase detail
            If detail = 2 Or detail = 4 Or detail = 6 Then Call increaseDetail
            
            ' call draw isomtric tile routine
            Call tileDrawIso(tkMainForm.currenttileIso, 0, 0, 3)
            
            ' update current board tile
            For X = 1 To 32
                For Y = 1 To 32
                    boardList(activeBoardIndex).BoardTile(X, Y) = tilemem(X, Y)
                    tilemem(X, Y) = buftile(X, Y)
                Next Y
            Next X

            ' update board detail
            boardList(activeBoardIndex).BoardDetail = detail
            detail = publicTile.oldDetail
            
            ' draw new tile in 'current tile' picture box
            For dx = 1 To 32
                For dy = 1 To 32
                    colorDraw = boardList(activeBoardIndex).BoardTile(dx, dy)
                    If colorDraw = -1 Then colorDraw = vbQBColor(15)
                    Call vbPicPSet(tkMainForm.currenttile, dx - 1, dy - 1, colorDraw)
                Next dy
            Next dx
            
            ' refresh pixture box
            Call vbPicRefresh(tkMainForm.currenttile)
            
            ' update current tileset caption to filename
            tkMainForm.bFrame(2).Caption = "Current Tile - " & boardList(activeBoardIndex).selectedTile$
            
            ' update main form control values
            tkMainForm.animTile.Enabled = True
            tkMainForm.Command20.Enabled = True
            tkMainForm.Command22.Enabled = True
            
        Else ' is a single tile
        
            ' copy to directory
            FileCopy filename$(1), projectPath$ + tilePath$ + antiPath$
            
            ' update current tile as selected tile
            boardList(activeBoardIndex).selectedTile$ = antiPath$
            
            ' open tileset
            Call openWinTile(filename$(1))
            
            ' if tileset detail inappropiate, increase detail
            If detail = 2 Or detail = 4 Or detail = 6 Then Call increaseDetail
            
            ' call draw isomtric tile routine
            Call tileDrawIso(tkMainForm.currenttileIso, 0, 0, 3)
            
            ' update current board tile
            For X = 1 To 32
                For Y = 1 To 32
                    boardList(activeBoardIndex).BoardTile(X, Y) = tilemem(X, Y)
                    tilemem(X, Y) = buftile(X, Y)
                Next Y
            Next X
            
            ' update board detail
            boardList(activeBoardIndex).BoardDetail = detail
            detail = publicTile.oldDetail
            
            ' draw new tile in 'current tile' picture box
            For dx = 1 To 32
                For dy = 1 To 32
                    colorDraw = boardList(activeBoardIndex).BoardTile(dx, dy)
                    If colorDraw = -1 Then colorDraw = vbQBColor(15)
                    Call vbPicPSet(tkMainForm.currenttile, dx - 1, dy - 1, colorDraw)
                Next dy
            Next dx
            
            ' refresh pixture box
            Call vbPicRefresh(tkMainForm.currenttile)
            
            ' update current tileset caption to filename
            tkMainForm.bFrame(2).Caption = "Current Tile - " & boardList(activeBoardIndex).selectedTile$
            
            ' update main form control values
            tkMainForm.animTile.Enabled = False
            tkMainForm.Command20.Enabled = False
            tkMainForm.Command22.Enabled = False
            
        End If
        
    End If
    
    ' set any pixels to transparent if appropiate
    For X = 1 To 32
        For Y = 1 To 32
            If boardList(activeBoardIndex).BoardTile(X, Y) = -1 Then
                bCurrentTileIsTransparent = True
            End If
        Next Y
    Next X
    
    ' refresh current tile picture box
    Call vbPicRefresh(tkMainForm.currenttile)
    
    ' refresh isometric tile alternative picture box
    Call vbPicRefresh(tkMainForm.currenttileIso)
    
End Sub

'========================================================================
' select type lock
'========================================================================
Public Sub boardTypeLock(): On Error Resume Next
    
    If ignore = 1 Then Exit Sub
    
    ' update draw state
    boardList(activeBoardIndex).drawState = 1
    
    ' update caption
    tkMainForm.drawstatebox.Caption = LoadStringLoc(994, "Type Lock")
    
    ' !UPDATED! update tool settings
    boardToolSettings 0, 1, 0, 0
    
    ' update tile types menu
    Call viewtiletypes
    
End Sub

'========================================================================
' save board
'========================================================================
Public Sub checkSave(): On Error Resume Next

    Dim aa As Long
    
    ' check if board has been changed
    If boardList(activeBoardIndex).boardNeedUpdate = True Then
    
        ' prompt user to save changes
        aa = MsgBox(LoadStringLoc(939, "Would you like to save your changes to the current board?"), vbYesNo, LoadStringLoc(940, "Save board"))
        
        ' if yes
        If aa = 6 Then

            ' call save routine
            Call saveFile
            
        End If
        
    End If

End Sub

'========================================================================
' toggle grid off/on
'========================================================================
Public Sub boardGrid(ByVal value As Integer): On Error Resume Next

    If ignore = 1 Then Exit Sub
    
    ' set board value
    boardList(activeBoardIndex).gridBoard = value
    
    ' redraw board
    Call boardRedraw
    
End Sub

'========================================================================
' toggle grid off/on
'========================================================================
Public Sub openFile(file$): On Error Resume Next

    activeBoard.Show
    
    ' check if current board needs saving
    Call checkSave
    
    ' get path
    filename$(1) = file$
    
    Dim antiPath As String
    
    ' get filename
    antiPath$ = absNoPath(file$)
    
    ' copy board to directory
    FileCopy filename$(1), projectPath$ + brdPath$ + antiPath$
    
    ' open board
    Call openboard(filename$(1), boardList(activeBoardIndex).theData)
    
    ' redraw board
    Call boardRedraw
    
    ' set board path value
    boardList(activeBoardIndex).boardName$ = antiPath$
    
    ' update form caption
    activeBoard.Caption = LoadStringLoc(802, "Board Editor (" + antiPath$ + ")")
    
    ' set picture box auto redraw as true
    Call vbPicAutoRedraw(boardform, True)
    
    ' ! ADDED BY KSNiloc...
    Form_Resize
    
End Sub

'========================================================================
' !UPDATE! resize form
'========================================================================
Public Sub resizeForm(a As Long, b As Long): On Error Resume Next
'=====================================================
'Alterations for isometric sizing, for 3.0.4 by Delano

    If ignore = 1 Then Exit Sub

    ' variables
    Dim oldX As Long, oldY As Long, W As Long, h As Long
    
    
    ' check minimum boundries (and set if needed)
    W = activeBoard.Width
    h = activeBoard.height
    
    'minBoardSizeX,Y assigned in BoardIso.
    If tilesX(W) < minBoardSizeX Then W = TwipsX(minBoardSizeX)
    If tilesY(h) < minBoardSizeY Then h = TwipsY(minBoardSizeY)
    
    ' get old width/height
    oldX = boardList(activeBoardIndex).tilesX
    oldY = boardList(activeBoardIndex).tilesY
    
    ' calculate tiles per row/column
    If boardList(activeBoardIndex).theData.isIsometric = 0 Then
        '2D.
        boardList(activeBoardIndex).tilesX = tilesX(W) - 1
        boardList(activeBoardIndex).tilesY = tilesY(h) - 2
        
    Else
        'Added. Isometric.
        boardList(activeBoardIndex).tilesX = tilesX(W) - 0
        boardList(activeBoardIndex).tilesY = tilesY(h) - 4
        
    End If
    
    ' check width/height against actual board width/height
    If boardList(activeBoardIndex).tilesX > boardList(activeBoardIndex).theData.Bsizex Then boardList(activeBoardIndex).tilesX = boardList(activeBoardIndex).theData.Bsizex
    If boardList(activeBoardIndex).tilesY > boardList(activeBoardIndex).theData.Bsizey Then boardList(activeBoardIndex).tilesY = boardList(activeBoardIndex).theData.Bsizey
    
    ' update picture
    boardform.Left = 0
    boardform.Top = 0
    boardform.Width = TwipsX(boardList(activeBoardIndex).tilesX)
    boardform.height = TwipsY(boardList(activeBoardIndex).tilesY)
    
    'Added: Check we haven't exceeded the maximum size. Reduce the tiles until it's small enough.
    If boardform.Width + VScroll1.Width > activeBoard.Width Then
        boardList(activeBoardIndex).tilesX = tilesX(activeBoard.Width - VScroll1.Width)
        boardform.Width = TwipsX(boardList(activeBoardIndex).tilesX)
    End If
    If boardform.height + HScroll1.height > activeBoard.height Then
        boardList(activeBoardIndex).tilesY = tilesY(activeBoard.height - HScroll1.height)
        boardform.height = TwipsY(boardList(activeBoardIndex).tilesY)
    End If
    
    ' calculate scroll bar lengths
    ignore = 1
    If boardList(activeBoardIndex).tilesY = boardList(activeBoardIndex).theData.Bsizey Then
        VScroll1.Visible = False
        Me.Width = boardform.Width + 115
    Else
        VScroll1.Visible = True
        VScroll1.Top = 0
        VScroll1.Left = boardform.Width
    VScroll1.height = boardform.height
        VScroll1.value = boardList(activeBoardIndex).topY
    VScroll1.max = boardList(activeBoardIndex).theData.Bsizey - boardList(activeBoardIndex).tilesY + 1
        VScroll1.LargeChange = boardList(activeBoardIndex).tilesY - 1           'Added.
        Me.Width = boardform.Width + VScroll1.Width + 115
    End If
    If boardList(activeBoardIndex).tilesX = boardList(activeBoardIndex).theData.Bsizex Then
        HScroll1.Visible = False
        Me.height = boardform.height + HScroll1.height + 206
    Else
        HScroll1.Visible = True
        HScroll1.Left = 0
        HScroll1.Top = boardform.height
        HScroll1.Width = boardform.Width
        HScroll1.value = boardList(activeBoardIndex).topX
    HScroll1.max = boardList(activeBoardIndex).theData.Bsizex - boardList(activeBoardIndex).tilesX + 1
        HScroll1.LargeChange = boardList(activeBoardIndex).tilesX - 1           'Added.
        Me.height = boardform.height + (HScroll1.height * 2) + 206
    End If
    ignore = 0
    
    colstrip.height = boardform.height
    rowstrip.Width = boardform.Width
    
    isomask.Top = boardform.Top
    isomask.Left = boardform.Left

    Call VScroll1_Change
    Call HScroll1_Change
    
    ' if height/width of tiles has change then redraw
    If oldX <> boardList(activeBoardIndex).tilesX Or oldY <> boardList(activeBoardIndex).tilesY Then
        Call boardRedraw
    End If
    
End Sub

'========================================================================
' save file
'========================================================================
Public Sub saveFile(): On Error Resume Next

    ' get filename
    filename$(2) = boardList(activeBoardIndex).boardName$
        
    ' set changes to false
    boardList(activeBoardIndex).boardNeedUpdate = False
        
    ' if new board then call save as routine
    If filename$(2) = "" Then
        Me.Show
        savebrdasmnu_click
        Exit Sub
    End If
        
    ' save board
    Call saveboard(projectPath$ + brdPath$ + filename$(2), boardList(activeBoardIndex).theData)
    
    ' update form caption
    activeBoard.Caption = LoadStringLoc(802, "Board Editor") + " (" + filename$(2) + ")"

End Sub

'========================================================================
' load ambient effects menu
'========================================================================
Private Sub ambienteffectsmnu_Click(): On Error Resume Next

    ' update board as changed
    boardList(activeBoardIndex).boardNeedUpdate = True
    
    ' show form
    ambienteffectform.Show vbModal
    
    ' redraw board
    Call boardRedraw

End Sub

'========================================================================
' when board is clicked
'========================================================================
Private Sub boardform_MouseDown(button As Integer, Shift As Integer, X As Single, Y As Single): On Error Resume Next
    
    ' update board as changed
    boardList(activeBoardIndex).boardNeedUpdate = True
    
    If ignore = 1 Then
        ignore = 0
        Exit Sub
    End If
    
    Dim xx As Long, yy As Long, redraw As Boolean
    
    redraw = True
    
    ' get tile co-ordinates
    xx = pixelToBoardCoordX(X, Y)
    yy = pixelToBoardCoordY(X, Y)
    
    ' left click
    If button = 1 Then
    
        ' if gradient is about to be defined
        If boardList(activeBoardIndex).boardAboutToDefineGradient = True Then
            
            ' see if gradient needs defining
            If boardList(activeBoardIndex).boardGradTop = -1 Or boardList(activeBoardIndex).boardGradLeft = -1 Then
                
                ' define top left
                boardList(activeBoardIndex).boardGradTop = yy
                boardList(activeBoardIndex).boardGradLeft = xx
                
                ' ask use to define bottom right tile
                MsgBox LoadStringLoc(941, "Now click to define the bottom right tile for the graident"), , LoadStringLoc(942, "Define Gradient")
            
            Else
            
                ' handle if x less than gradient left
                If xx < boardList(activeBoardIndex).boardGradLeft Then
                    boardList(activeBoardIndex).boardGradRight = boardList(activeBoardIndex).boardGradLeft
                    boardList(activeBoardIndex).boardGradLeft = xx
                Else
                    boardList(activeBoardIndex).boardGradRight = xx
                End If
                
                ' handle if y is less than gradient top
                If yy < boardList(activeBoardIndex).boardGradTop Then
                    boardList(activeBoardIndex).boardGradBottom = boardList(activeBoardIndex).boardGradTop
                    boardList(activeBoardIndex).boardGradTop = yy
                Else
                    boardList(activeBoardIndex).boardGradBottom = yy
                End If
                
                ' apply gradient
                Call applyGradient
                
                ' board no longer waiting to define gradient
                boardList(activeBoardIndex).boardAboutToDefineGradient = False
                
                ' redraw board
                Call boardRedraw
            
            End If
            
            Exit Sub
            
        End If
        
        ' if draw lock is in place
        If boardList(activeBoardIndex).drawState = 0 Then
        
            ' if a tile has been selected
            If boardList(activeBoardIndex).selectedTile$ <> "" Then
            
                Dim newX As Long, newY As Long, iso As Boolean, eo As Boolean
                
                ' get co-ords in relation to board
                newX = xx - boardList(activeBoardIndex).topX
                newY = yy - boardList(activeBoardIndex).topY
              
                ' set isometric value
                If boardList(activeBoardIndex).theData.isIsometric = 0 Then
                    iso = False
                Else
                    iso = True
                End If
                
                If (boardList(activeBoardIndex).topY Mod 2 = 0) Then
                    eo = False
                Else
                    eo = True
                End If
                
                ' draw new tile
                Call drawtile(vbPicHDC(boardform), _
                                     tilePath$ + boardList(activeBoardIndex).selectedTile$, _
                                     xx - boardList(activeBoardIndex).topX, _
                                     yy - boardList(activeBoardIndex).topY, _
                                     boardList(activeBoardIndex).ambientR, _
                                     boardList(activeBoardIndex).ambientG, _
                                     boardList(activeBoardIndex).ambientB, _
                                     False, _
                                     False, _
                                     iso, _
                                     eo)
                                     
                ' refresh picture box
                Call vbPicRefresh(boardform)
                
                ' set new tile details
                Call BoardSetTile(xx, yy, boardList(activeBoardIndex).currentLayer, boardList(activeBoardIndex).selectedTile$, boardList(activeBoardIndex).theData)
                
                ' set ambient details
                boardList(activeBoardIndex).theData.ambientred(xx, yy, boardList(activeBoardIndex).currentLayer) = boardList(activeBoardIndex).ambientR
                boardList(activeBoardIndex).theData.ambientgreen(xx, yy, boardList(activeBoardIndex).currentLayer) = boardList(activeBoardIndex).ambientG
                boardList(activeBoardIndex).theData.ambientblue(xx, yy, boardList(activeBoardIndex).currentLayer) = boardList(activeBoardIndex).ambientB
                
                ' set tiletype details
                boardList(activeBoardIndex).theData.tiletype(xx, yy, boardList(activeBoardIndex).currentLayer) = boardList(activeBoardIndex).currentTileType
                
                ' if we have spot light
                If boardList(activeBoardIndex).spotLight = 1 Then
                    
                    Dim theRadius As Long, fadeValue As Double, startR As Long, startG As Long, startB As Long, radius As Long, radian As Double
                    
                    ' get spotlight values
                    theRadius = boardList(activeBoardIndex).spotLightRadius
                    fadeValue = boardList(activeBoardIndex).percentFade
                    
                    ' get ambient values
                    startR = boardList(activeBoardIndex).ambientR
                    startG = boardList(activeBoardIndex).ambientG
                    startB = boardList(activeBoardIndex).ambientB
                    
                    ' check RGB minimum values
                    If startR < 0 Then startR = 0
                    If startG < 0 Then startG = 0
                    If startB < 0 Then startB = 0
                    
                    ' draw spotlight circle
                    For radius = 1 To theRadius
                        
                        startR = startR - fadeValue
                        startG = startG - fadeValue
                        startB = startB - fadeValue
                        
                        If startR < 0 Then startR = 0
                        If startG < 0 Then startG = 0
                        If startB < 0 Then startB = 0
                        
                        For publicTile.angle = 0 To 360
                        
                            radian = (publicTile.angle * 3.14159) / 180
                            
                            Dim xyx As Double, yxy As Double
                            
                            xyx = Cos(radian)
                            yxy = Sin(radian)
                            
                            xyx = round(xyx * radius)
                            yxy = round(yxy * radius)
                            
                            Dim lx As Double, ly As Double
                            
                            lx = newX + xyx
                            ly = newY + yxy
                            
                            If lx > 19 Then lx = 19: If lx < 1 Then lx = 1
                            If ly > 11 Then ly = 11: If ly < 1 Then ly = 1
                            
                            If lx >= 1 And lx <= 20 And ly >= 1 And ly <= 12 Then
                                boardList(activeBoardIndex).theData.ambientred(lx + boardList(activeBoardIndex).topX, ly + boardList(activeBoardIndex).topY, boardList(activeBoardIndex).currentLayer) = startR
                                boardList(activeBoardIndex).theData.ambientgreen(lx + boardList(activeBoardIndex).topX, ly + boardList(activeBoardIndex).topY, boardList(activeBoardIndex).currentLayer) = startG
                                boardList(activeBoardIndex).theData.ambientblue(lx + boardList(activeBoardIndex).topX, ly + boardList(activeBoardIndex).topY, boardList(activeBoardIndex).currentLayer) = startB
                            End If

                        Next publicTile.angle
                        
                    Next radius
                    
                    boardList(activeBoardIndex).theData.ambientred(newX + boardList(activeBoardIndex).topX, newY + boardList(activeBoardIndex).topY, boardList(activeBoardIndex).currentLayer) = boardList(activeBoardIndex).ambientR
                    boardList(activeBoardIndex).theData.ambientgreen(newX + boardList(activeBoardIndex).topX, newY + boardList(activeBoardIndex).topY, boardList(activeBoardIndex).currentLayer) = boardList(activeBoardIndex).ambientG
                    boardList(activeBoardIndex).theData.ambientblue(newX + boardList(activeBoardIndex).topX, newY + boardList(activeBoardIndex).topY, boardList(activeBoardIndex).currentLayer) = boardList(activeBoardIndex).ambientB
                
                End If
                
            End If
            
            redraw = False
            
        End If
        
        Dim colorCode As Long, aPoint As Long
        
        ' if type lock
        If boardList(activeBoardIndex).drawState = 1 Then
        
            ' update tile type
            boardList(activeBoardIndex).theData.tiletype(xx, yy, boardList(activeBoardIndex).currentLayer) = boardList(activeBoardIndex).currentTileType
                
            ' update tiletype for that tile only
            viewtiletypes xx, yy
            
            redraw = False

        End If
        
        ' set program
        If boardList(activeBoardIndex).drawState = 2 Then
        
            ' update draw state caption
            tkMainForm.drawstatebox.Caption = LoadStringLoc(1277, "Draw Lock")
            
            ' set back to draw lock
            boardList(activeBoardIndex).drawState = 0
            
            'find x and y coords
            boardList(activeBoardIndex).infoX = xx
            boardList(activeBoardIndex).infoY = yy
            
            ignore = 1
            
            ' show program set form
            programset.Show vbModal
            
            Exit Sub
            
        End If
        
        ' set item
        If boardList(activeBoardIndex).drawState = 3 Then
        
            ' update caption
            tkMainForm.drawstatebox.Caption = LoadStringLoc(1277, "Draw Lock")
            
            ' set back to draw lock
            boardList(activeBoardIndex).drawState = 0
            
            'find x and y coords
            boardList(activeBoardIndex).infoX = xx
            boardList(activeBoardIndex).infoY = yy
            
            ignore = 1
            
            ' item set form
            itemset.Show vbModal
            
            Exit Sub
            
        End If
        
        ' set player
        If boardList(activeBoardIndex).drawState = 4 Then
        
            ' update caption
            tkMainForm.drawstatebox.Caption = LoadStringLoc(1277, "Draw Lock")
            
            ' set back to draw lock
            boardList(activeBoardIndex).drawState = 0
            
            ' find x and y coords
            boardList(activeBoardIndex).infoX = xx
            boardList(activeBoardIndex).infoY = yy
            
            ' set player position data
            boardList(activeBoardIndex).theData.playerX = boardList(activeBoardIndex).infoX
            boardList(activeBoardIndex).theData.playerY = boardList(activeBoardIndex).infoY
            boardList(activeBoardIndex).theData.playerLayer = boardList(activeBoardIndex).currentLayer
            
            ignore = 1
            
            ' inform user
            MsgBox LoadStringLoc(944, "Player position set!")
            
            viewtiletypes xx, yy
            
            redraw = False
            
        End If
        
        ' set warp tile
        If boardList(activeBoardIndex).drawState = 5 Then
        
            ' update caption
            tkMainForm.drawstatebox.Caption = LoadStringLoc(1277, "Draw Lock")
            
            ' set back to draw lock
            boardList(activeBoardIndex).drawState = 0
            
            'find x and y coords
            boardList(activeBoardIndex).infoX = xx
            boardList(activeBoardIndex).infoY = yy
            
            ignore = 1
            
            ' show warp form
            warpset.Show vbModal
            
            Exit Sub
            
        End If
        
        ' eraser
        If boardList(activeBoardIndex).drawState = 6 Then
        
            ' reset ambient data
            boardList(activeBoardIndex).theData.ambientred(xx, yy, boardList(activeBoardIndex).currentLayer) = 0
            boardList(activeBoardIndex).theData.ambientgreen(xx, yy, boardList(activeBoardIndex).currentLayer) = 0
            boardList(activeBoardIndex).theData.ambientblue(xx, yy, boardList(activeBoardIndex).currentLayer) = 0
            
            ' reset tiletype data
            boardList(activeBoardIndex).theData.tiletype(xx, yy, boardList(activeBoardIndex).currentLayer) = 0
                
            ' get tile data
            Call BoardSetTile(xx, yy, boardList(activeBoardIndex).currentLayer, "", boardList(activeBoardIndex).theData)
                
        End If
        
        ' set event
        If boardList(activeBoardIndex).drawState = 7 Then

            ' update caption
            tkMainForm.drawstatebox.Caption = LoadStringLoc(1277, "Draw Lock")
            
            ' set back to draw lock
            boardList(activeBoardIndex).drawState = 0
            
            'find x and y coords
            boardList(activeBoardIndex).infoX = xx
            boardList(activeBoardIndex).infoY = yy
            
            ignore = 1
            
            ' show event form
            EventMenu.Show vbModal
            
            Exit Sub
            
        End If
        
        ' fill tool
        If boardList(activeBoardIndex).drawState = 8 Then
    
            ' update caption
            tkMainForm.drawstatebox.Caption = LoadStringLoc(1678, "Flood Fill")
            
            ' run fill routine
            Call fillBoard(xx, yy, boardList(activeBoardIndex).currentLayer, boardList(activeBoardIndex).selectedTile$)
            
        End If
    
    End If
    
    ' right click {show tile info}
    If button = 2 Then
    
        Dim i As Integer

        ' get x and y co-ord
        boardList(activeBoardIndex).infoX = xx
        boardList(activeBoardIndex).infoY = yy
        
        ' make sure all menu items are enabled
        With mnuPop_Type_T
            For i = 0 To 5
                .Item(i).Enabled = True
            Next i
        End With
        With mnuPop_Type_L
            For i = 11 To 18
                .Item(i).Enabled = True
            Next i
        End With
        
        ' disable current tile type
        If boardList(activeBoardIndex).currentTileType < 11 Then mnuPop_Type_T.Item(boardList(activeBoardIndex).theData.tiletype(xx, yy, boardList(activeBoardIndex).currentLayer)).Enabled = False
        If boardList(activeBoardIndex).currentTileType >= 11 Then mnuPop_Type_L.Item(boardList(activeBoardIndex).theData.tiletype(xx, yy, boardList(activeBoardIndex).currentLayer)).Enabled = False
        
        ' setup popup menu
        If boardList(activeBoardIndex).theData.Bsizel = 4 Then
            With mnuPop_Type_L
                For i = 15 To 18
                    .Item(i).Visible = False
                Next i
            End With
        Else
            With mnuPop_Type_L
                For i = 15 To 18
                    .Item(i).Visible = True
                Next i
            End With
        End If
        
        PopupMenu mnuPop
        
        Exit Sub
        
    End If
    
    ignore = 0
    
    ' redraw board
    If redraw = True Then Call boardRedraw
    
End Sub

'========================================================================
' when mouse moves over board
'========================================================================
Private Sub boardform_MouseMove(button As Integer, Shift As Integer, X As Single, Y As Single): On Error Resume Next
    
    Dim xx As Long, yy As Long
    
    ' get x and y co-ords
    xx = pixelToBoardCoordX(X, Y)
    yy = pixelToBoardCoordY(X, Y)
    
    ' update co-ords caption
    tkMainForm.boardCoords.Caption = str$(xx) + "," + str$(yy)
    
    If ignore = 1 Then
        ignore = 0
        Exit Sub
    End If
    
    ' if left mouse button held down
    If button = 1 Then
        Call boardform_MouseDown(button, Shift, X, Y)
    End If
    
End Sub

'========================================================================
' show forms
'========================================================================
Private Sub boardLight_Click(): On Error Resume Next
    boardlighting.Show vbModal
End Sub
Private Sub brdbackgroundmenu_Click(): On Error Resume Next
    brdbackground.Show vbModal
End Sub
Private Sub brdinfomnu_Click(): On Error Resume Next
    boardList(activeBoardIndex).boardNeedUpdate = True
    boardinformation.Show vbModal
    resetLayerList
    boardRedraw
End Sub

Private Sub itmmenu_Click(): On Error Resume Next
    boardList(activeBoardIndex).boardNeedUpdate = True
    itemmenu.Show vbModal
    boardRedraw
End Sub

'========================================================================
' Erase tile, selected via pop-up menu
'========================================================================
Private Sub mnuPop_Erase_Click()

    ' reset ambient data
    boardList(activeBoardIndex).theData.ambientred(boardList(activeBoardIndex).infoX, boardList(activeBoardIndex).infoY, boardList(activeBoardIndex).currentLayer) = 0
    boardList(activeBoardIndex).theData.ambientgreen(boardList(activeBoardIndex).infoX, boardList(activeBoardIndex).infoY, boardList(activeBoardIndex).currentLayer) = 0
    boardList(activeBoardIndex).theData.ambientblue(boardList(activeBoardIndex).infoX, boardList(activeBoardIndex).infoY, boardList(activeBoardIndex).currentLayer) = 0
            
    ' reset tiletype data
    boardList(activeBoardIndex).theData.tiletype(boardList(activeBoardIndex).infoX, boardList(activeBoardIndex).infoY, boardList(activeBoardIndex).currentLayer) = 0
                
    ' get tile data
    Call BoardSetTile(boardList(activeBoardIndex).infoX, boardList(activeBoardIndex).infoY, boardList(activeBoardIndex).currentLayer, "", boardList(activeBoardIndex).theData)
                
    ' board redraw
    Call boardRedraw
    
End Sub

'========================================================================
' View tile info, via popup menu
'========================================================================
Private Sub mnuPop_Info_Click()

    tileinfo.Show vbModal

End Sub

'========================================================================
' Update tile type, via popup menu
'========================================================================
Private Sub mnuPop_Type_L_Click(Index As Integer)

    ' update tile type
    boardList(activeBoardIndex).theData.tiletype(boardList(activeBoardIndex).infoX, boardList(activeBoardIndex).infoY, boardList(activeBoardIndex).currentLayer) = Index
                
    ' update tiletype for that tile only
    viewtiletypes boardList(activeBoardIndex).infoX, boardList(activeBoardIndex).infoY
            
End Sub

'========================================================================
' Update tile type, via popup menu
'========================================================================
Private Sub mnuPop_Type_T_Click(Index As Integer)

    ' update tile type
    boardList(activeBoardIndex).theData.tiletype(boardList(activeBoardIndex).infoX, boardList(activeBoardIndex).infoY, boardList(activeBoardIndex).currentLayer) = Index
                
    ' update tiletype for that tile only
    viewtiletypes boardList(activeBoardIndex).infoX, boardList(activeBoardIndex).infoY
            
End Sub

Private Sub mnuThreading_Click(): On Error Resume Next

'========================================================================
' ADDED BY KSNiloc
'========================================================================

    frmThreading.Show 1

End Sub

'========================================================================
' Edit object, via toolbar popup menu
'========================================================================
Private Sub mTB_Edit_Click(): On Error Resume Next
    tkMainForm.boardToolbar.Objects.Edit
End Sub

'========================================================================
' Remove object, via toolbar popup menu
'========================================================================
Private Sub mTB_Remove_Click(): On Error Resume Next
    tkMainForm.boardToolbar.Objects.Remove
End Sub

'========================================================================
' View object settings, via toolbar popup menu
'========================================================================
Private Sub mTB_Settings_Click(): On Error Resume Next
    tkMainForm.boardToolbar.Objects.Settings
End Sub

Private Sub pmnu_Click(): On Error Resume Next
    boardList(activeBoardIndex).boardNeedUpdate = True
    programmenu.Show vbModal: boardRedraw
End Sub
Private Sub seltile_Click(): On Error Resume Next
    boardSelectTile
End Sub
Private Sub SpotLightmnu_Click(): On Error Resume Next
    spotlighting.Show vbModal
End Sub

'========================================================================
' close editor
'========================================================================
Private Sub closeditor_Click(): On Error Resume Next
    Unload activeBoard
End Sub

'========================================================================
' ???
'========================================================================
Private Sub Command6_Click()
    MsgBox TileAnmGet(boardList(activeBoardIndex).theData.animatedTile(0).theTile, 0)
End Sub

'========================================================================
' ???
'========================================================================
Private Sub Command1_Click()
    On Error Resume Next
    Dim X As Long, Y As Long, a As Long
    For X = 0 To 64
        For Y = 0 To 32
            a = isomask.point(X, Y)
            Call vbPicPSet(boardform, X, Y, a)
        Next Y
    Next X
    Call vbPicRefresh(boardform)
End Sub

'========================================================================
' delete current layer
'========================================================================
Private Sub deleteLayer(): On Error Resume Next

    Dim user As Long, X As Long, Y As Long
    
    ' confirm user action
    user = MsgBox(LoadStringLoc(945, "Delete this entire layer.  Are you sure?"), 4)
    
    ' if confirmed
    If user = 6 Then
    
        ' loop through tiles
        For X = 0 To boardList(activeBoardIndex).theData.Bsizex
            For Y = 0 To boardList(activeBoardIndex).theData.Bsizey

                ' get tile data
                Call BoardSetTile(X, Y, boardList(activeBoardIndex).currentLayer, "", boardList(activeBoardIndex).theData)
                
                ' reset tile data
                boardList(activeBoardIndex).theData.ambientred(X, Y, boardList(activeBoardIndex).currentLayer) = 0
                boardList(activeBoardIndex).theData.ambientgreen(X, Y, boardList(activeBoardIndex).currentLayer) = 0
                boardList(activeBoardIndex).theData.ambientblue(X, Y, boardList(activeBoardIndex).currentLayer) = 0
                boardList(activeBoardIndex).theData.tiletype(X, Y, boardList(activeBoardIndex).currentLayer) = 0
            
            Next Y
        Next X
        
        ' redraw board
        Call boardRedraw
        
    End If

End Sub

'========================================================================
' run on form activation
'========================================================================
Private Sub Form_Activate(): On Error Resume Next
'=====================================================
'Alterations for isometric sizing, for 3.0.4 by Delano
'Added resizeForm.

    Set activeBoard = Me
    Set activeForm = Me
    
    activeBoardIndex = dataIndex
    
    ' extras
    hideAllTools
    tkMainForm.popButton(3).Visible = True
    tkMainForm.boardTools.Visible = True
    tkMainForm.boardTools.Top = tkMainForm.toolTop
    tkMainForm.bBar.Visible = True
    
    tkMainForm.boardToolbar.Display.Refresh
    
    ' maintain board's tool settings.
    ignore = 1
    tkMainForm.boardGrid.value = boardList(activeBoardIndex).gridBoard
    tkMainForm.boardIso.value = boardList(activeBoardIndex).theData.isIsometric
    If boardList(activeBoardIndex).drawState = 0 Then boardToolSettings 1, 0, 0, 0
    If boardList(activeBoardIndex).drawState = 1 Then boardToolSettings 0, 1, 0, 0
    If boardList(activeBoardIndex).drawState = 6 Then boardToolSettings 0, 0, 1, 0
    If boardList(activeBoardIndex).drawState = 8 Then boardToolSettings 0, 0, 0, 1
    resetLayerList
    ignore = 0
    
    ' if open, refresh board objects bar
    If tkMainForm.popButton(3).value = 1 Then tkMainForm.boardToolbar.Objects.Populate (activeBoardIndex)
    
    'Added.
    Call resizeForm(0, 0)
    
End Sub

'========================================================================
' key press
'========================================================================
Private Sub Form_KeyPress(KeyAscii As Integer): On Error Resume Next

    Dim X As Long, Y As Long, dx As Long, dy As Long, colorDraw As Long
    
    ' Toggle
    If UCase$(chr$(KeyAscii)) = "T" Then tkMainForm.toggle_Click
    
    ' Select New Tile
    If UCase$(chr$(KeyAscii)) = "S" Then boardSelectTile
    
    ' Program Menu
    If UCase$(chr$(KeyAscii)) = "G" Then programmenu.Show vbModal
    
    ' Set Player Position
    If UCase$(chr$(KeyAscii)) = "P" Then setplyrmnu_click
    
    ' Last Tileset
    If UCase$(chr$(KeyAscii)) = "L" Then
    
        ' if no previous tileset opened
        If lastTileset = "" Then
        
            Call boardSelectTile
            Exit Sub
            
        End If
        
        ' if previous tileset opened then open once more
        If lastTileset$ <> "" Then
        
            tstFile$ = lastTileset$
            
            ' open tileset form
            tilesetform.Show vbModal
            
            ' change selected tile
            Call changeSelectedTile(setFilename$)
            
        End If
        
    End If
    
    ' refresh current tile pixture box
    Call vbPicRefresh(tkMainForm.currenttile)
    
    ' refresh current tile isometric alternative
    Call vbPicRefresh(tkMainForm.currenttileIso)
    
End Sub

'========================================================================
' run on form load
'========================================================================
Private Sub Form_Load(): On Error Resume Next
'=====================================================
'Alterations for isometric sizing, for 3.0.4 by Delano

    Call LocalizeForm(Me)
    
    Set activeBoard = Me
    
    tkMainForm.boardCount = tkMainForm.boardCount + 1
    
    ' incement index
    dataIndex = VectBoardNewSlot()
    
    activeBoardIndex = dataIndex
    
    ' clear board
    Call BoardClear(boardList(dataIndex).theData)
    
    ' set board size
    Call BoardSetSize(19, 11, 8, boardList(dataIndex).theData)
    
    activeBoard.KeyPreview = True
    
    ' set auto redraw for picture box
    Call vbPicAutoRedraw(boardform, True)

    ' reset ambience data
    boardList(activeBoardIndex).ambient = 0
    tkMainForm.ambientlight.max = 255
    tkMainForm.ambientlight.min = -255
    tkMainForm.ambientnumber.Text = "0"

    ' set up the layering menu
    boardList(activeBoardIndex).currentLayer = 1
    resetLayerList

    Dim colorCode As Long, aPoint As Long, levelnum As Long, xx As Long, yy As Long
    
    ' update caption with appropiate tile type caption
    tkMainForm.bFrame(1).Caption = "Tile Type - " & tiletype(boardList(activeBoardIndex).currentTileType).name
    colorCode = tiletype(boardList(activeBoardIndex).currentTileType).color
    
    ' draw tile type arrow
    Call vbPicAutoRedraw(tkMainForm.arrowtype, True)
    
    For aPoint = 9 To 16: Call vbPicLine(tkMainForm.arrowtype, xx + aPoint - 4, yy + aPoint - 6, xx + 32 - aPoint - 4, yy + aPoint - 6, vbQBColor(colorCode)): Next aPoint

    ' set draw state caption
    Select Case boardList(activeBoardIndex).drawState
        Case 0
            tkMainForm.drawstatebox.Caption = LoadStringLoc(1277, "Draw Lock")
            
        Case 1
            tkMainForm.drawstatebox.Caption = LoadStringLoc(994, "Type Lock")
    End Select

    'Added: Initial dimension settings:
    minBoardSizeX = 19
    minBoardSizeY = 11

    Call resizeForm(0, 0)
    
End Sub

'========================================================================
' run on form resize
'========================================================================
Private Sub Form_Resize()

    ' call resize form routine
    Call resizeForm(0, 0)
    
End Sub

'========================================================================
' run on form unload
'========================================================================
Private Sub Form_Unload(Cancel As Integer): On Error Resume Next

    tkMainForm.boardCount = tkMainForm.boardCount - 1

    If tkMainForm.boardCount = 0 Then
        tkMainForm.popButton(3).value = 0
        tkMainForm.popButton(3).Visible = False
        tkMainForm.pTools.Visible = False
        tkMainForm.bBar.Visible = False
        tkMainForm.bottomFrame.Visible = True
    End If

    Call hideAllTools
    
End Sub

'========================================================================
' !UPDATE! horizontal scroll
'========================================================================
Private Sub HScroll1_Change(): On Error Resume Next
'=====================================================
'Alterations for isometric sizing, for 3.0.4 by Delano
    
    ' exit if opening board
    If bOpeningBoard Then
        Exit Sub
    End If
    
    If ignore = 1 Then
        ignore = 0
        Exit Sub
    End If
    
    Dim tX As Long, tY As Long
    
    ' get board width/height
    tX = boardList(activeBoardIndex).tilesX
    tY = boardList(activeBoardIndex).tilesY
    
    ' alter x/y if isometric - removed!
    'If boardList(activeBoardIndex).theData.isIsometric = 1 Then
    '
    '    tX = Int(tX / 2) + 1
    '    tY = tY * 2 + 1
    '
    'End If
    
    ' check scroll bar boundries
    If HScroll1.max <> boardList(activeBoardIndex).theData.Bsizex - tX + 1 Then
        HScroll1.max = boardList(activeBoardIndex).theData.Bsizex - tX + 1
    End If
    
    If HScroll1.value + tX - 1 > boardList(activeBoardIndex).theData.Bsizex Then
        ignore = 1
        
        HScroll1.value = boardList(activeBoardIndex).theData.Bsizex - tX - 1
        
        Call boardRedraw
        
        Exit Sub
    End If
    
    If HScroll1.value - 1 = boardList(activeBoardIndex).topX + 1 Then
    
        ' update x value
        boardList(activeBoardIndex).topX = HScroll1.value - 1
        
        ' shift to left
        Call shiftLeft
        
        Call boardRedraw
        
        Exit Sub
        
    End If
    
    If HScroll1.value - 1 = boardList(activeBoardIndex).topX - 1 Then
    
        ' update x value
        boardList(activeBoardIndex).topX = HScroll1.value - 1
        
        ' shift to right
        Call shiftRight
        
        Call boardRedraw
        
        Exit Sub
        
    End If
    
    ' set board x value
    boardList(activeBoardIndex).topX = HScroll1.value - 1
    
    ' redraw board
    Call boardRedraw

End Sub

'========================================================================
' light colour
'========================================================================
Private Sub lcolor_Click(): On Error Resume Next

    Dim c As Long
    
    ' show color dialog
    c = ColorDialog()
    
    ' if selection made
    If (c <> -1) Then
    
        ' update colours
        boardList(activeBoardIndex).ambientR = red(c)
        boardList(activeBoardIndex).ambientG = green(c)
        boardList(activeBoardIndex).ambientB = blue(c)
        
        ' update picture box with colour
        Call vbPicFillRect(tkMainForm.Picture1, 0, 0, 1000, 1000, c)
        
        ' update caption
        tkMainForm.ambientnumber.Text = "0"
        
    End If

End Sub

'========================================================================
' set item
'========================================================================
Private Sub mnusetitm_Click(): On Error Resume Next

    ' give user instructions
    MsgBox LoadStringLoc(946, "To set an item, click on the tile you want")
    
    ' update caption
    tkMainForm.drawstatebox.Caption = LoadStringLoc(907, "Set Item")
    
    ' set draw state
    boardList(activeBoardIndex).drawState = 3
    
    ' set item condition
    boardList(activeBoardIndex).itmCondition = -1

    Exit Sub
    
    ' begin error handling code:
ErrorHandler:

    Call HandleError
    
    Resume Next
    
End Sub

'========================================================================
' create new board
'========================================================================
Private Sub newBoard(): On Error Resume Next

    ' set top / left values
    boardList(activeBoardIndex).topX = 0
    boardList(activeBoardIndex).topY = 0
    
    ' set width / height values
    boardList(activeBoardIndex).theData.Bsizex = 19
    boardList(activeBoardIndex).theData.Bsizey = 11
    
    ' fill picture box with board colour
    Call vbPicFillRect(boardform, 0, 0, 1000, 1000, boardList(activeBoardIndex).theData.brdColor)
    
    ' set initial values
    boardList(activeBoardIndex).gridBoard = 0
    boardList(activeBoardIndex).drawState = 0
    activeBoard.Caption = LoadStringLoc(1264, "Board Editor (Untitled)")
    boardList(activeBoardIndex).spotLight = 0

    ' set board size
    Call BoardSetSize(19, 11, 8, boardList(activeBoardIndex).theData)
    
    ' clear board
    Call BoardClear(boardList(activeBoardIndex).theData)
    
End Sub

'========================================================================
' set program
'========================================================================
Private Sub prgmnu_Click(): On Error Resume Next

    ' give you instructions
    MsgBox LoadStringLoc(948, "To set a program, click on the tile you want")
    
    ' update caption
    tkMainForm.drawstatebox.Caption = LoadStringLoc(908, "Set Program")
    
    ' set board values
    boardList(activeBoardIndex).drawState = 2
    boardList(activeBoardIndex).prgCondition = -1

End Sub

'========================================================================
' redraw board layer
'========================================================================
' FIXIT: FillStyle property has no Visual Basic .NET equivalent and will not be upgraded.     FixIT90210ae-R7593-R67265
Public Sub redrawbrd(ByVal layer As Long): On Error Resume Next
'=====================================================
'Alterations for isometric sizing, for 3.0.4 by Delano
    
    ' kill cache
    Call GFXClearTileCache
    
    ' set autoredraw on picture box to true
    Call vbPicAutoRedraw(boardform, True)
    
    ' set fill style
    FillStyle = 1
    
    Dim X As Long, Y As Long
    
    ' get tile data
    For X = 1 To 32
        For Y = 1 To 32
            buftile(X, Y) = tilemem(X, Y)
        Next Y
    Next X
    
    Dim addonR As Long, addonG As Long, addonB As Long, tX As Long, tY As Long
    
    ' get RGB add-on value depending on ambient effect selected
    Select Case boardList(activeBoardIndex).theData.ambienteffect
    
        Case 0 ' None
            addonR = 0
            addonG = 0
            addonB = 0
            
        Case 1 ' Fog/Mist
            addonR = 75
            addonG = 75
            addonB = 75
            
        Case 2 ' Darkness
            addonR = -75
            addonG = -75
            addonB = -75
            
        Case 3 ' Watery
            addonR = 0
            addonG = 0
            addonB = 75
            
    End Select
    
    ' change directory
    ChDir (projectPath$)
    
    ' get tile width / height
    tX = boardList(activeBoardIndex).tilesX
    tY = boardList(activeBoardIndex).tilesY
    
    ' if board is isometric then alter x / y values - removed!
    'If boardList(activeBoardIndex).theData.isIsometric = 1 Then
    '    tX = Int(tX / 2) + 1
    '    tY = tY * 2 + 1
    'End If
    
    Call GFXdrawboard(vbPicHDC(boardform), -1, layer, _
                    boardList(activeBoardIndex).topX, boardList(activeBoardIndex).topY, _
                    tX, tY, _
                    boardList(activeBoardIndex).theData.Bsizex, _
                    boardList(activeBoardIndex).theData.Bsizey, _
                    boardList(activeBoardIndex).theData.Bsizel, _
                    addonR, addonG, addonB, _
                    boardList(activeBoardIndex).theData.isIsometric)
    
    ' chane directory
    ChDir (currentDir$)
    
    ' restore tile
    For X = 1 To 32
        For Y = 1 To 32
            tilemem(X, Y) = buftile(X, Y)
        Next Y
    Next X
    
    ' set picture box auto redraw to true
    Call vbPicAutoRedraw(boardform, True)
    
End Sub

'========================================================================
' save as routine
'========================================================================
Private Sub savebrdasmnu_click(): On Error Resume Next

    ' change directory
    ChDir (currentDir$)
    
    ' initialise file dialog
    Dim dlg As FileDialogInfo
    Dim antiPath As String, aa As Long, bb As Long
    
    ' set values
    dlg.strDefaultFolder = projectPath$ + brdPath$
    dlg.strTitle = "Save Board As"
    dlg.strDefaultExt = "brd"
    dlg.strFileTypes = "RPG Toolkit Board (*.brd)|*.brd|All files(*.*)|*.*"
    
    ' get filename selected
    If SaveFileDialog(dlg, Me.hwnd) Then
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    
    ' change direcoty
    ChDir (currentDir$)
    
    ' if no filename entered
    If filename$(1) = "" Then Exit Sub
    
    ' confirm user wants to overwrite file
    If fileExists(filename(1)) Then
        bb = MsgBox(LoadStringLoc(949, "That file exists.  Are you sure you want to overwrite it?"), vbYesNo, LoadStringLoc(950, "Save"))
        If bb = 7 Then Exit Sub
    End If
    
    ' save board
    Call saveboard(filename$(1), boardList(activeBoardIndex).theData)
    
    ' set filename
    boardList(activeBoardIndex).boardName$ = antiPath$
    
    ' update form caption
    activeBoard.Caption = LoadStringLoc(802, "Board Editor") + " (" + antiPath$ + ")"
    
    ' set changes to false
    boardList(activeBoardIndex).boardNeedUpdate = False
    
    ' add to project tree
    Call tkMainForm.fillTree("", projectPath$)
    
End Sub

'========================================================================
' save routine
'========================================================================
Private Sub savebrdmnu_Click(): On Error Resume Next

    ' get filename
    filename$(2) = boardList(activeBoardIndex).boardName$
    
    ' set changes to false
    boardList(activeBoardIndex).boardNeedUpdate = False
    
    ' if no filename exists, call save as routine
    If filename$(2) = "" Then savebrdasmnu_click: Exit Sub
    
    ' save board
    Call saveboard(projectPath$ + brdPath$ + filename$(2), boardList(activeBoardIndex).theData)
    
    ' update form caption
    activeBoard.Caption = LoadStringLoc(802, "Board Editor") + " (" + filename$(2) + ")"

End Sub

'========================================================================
' set player
'========================================================================
Private Sub setplyrmnu_click(): On Error Resume Next

    ' give user instructions
    MsgBox LoadStringLoc(951, "To set player position, click on the tile you want")
    
    ' update caption
    tkMainForm.drawstatebox.Caption = LoadStringLoc(909, "Set Player Position")
    
    ' set draw state
    boardList(activeBoardIndex).drawState = 4
    
End Sub

'========================================================================
' display tile types - adapted to allow for individual tile redraw
'========================================================================
Public Sub viewtiletypes(Optional X As Long = 0, Optional Y As Long = 0): On Error Resume Next
'=====================================================
'Alterations for isometric sizing, for 3.0.4 by Delano

    ' check if option selected
    If tkMainForm.boardTypeLock.value = 1 Then

        Dim xxx As Long, yyy As Long, colorCode As Long, aPoint As Long
        
        ' !NEW! Min and Max values
        Dim minX As Long, minY As Long, maxX As Long, maxY As Long
        
        ' !NEW! Apply min and max values
        If X = 0 Or Y = 0 Then
            minX = boardList(activeBoardIndex).topX + 1
            minY = boardList(activeBoardIndex).topY + 1
            
            'Edited - maxX,Y same in both cases.
            'If boardList(activeBoardIndex).theData.isIsometric = 1 Then
            '    maxX = (boardList(activeBoardIndex).tilesX / 2) + boardList(activeBoardIndex).topX + 1
            '    maxY = (boardList(activeBoardIndex).tilesY * 2) + boardList(activeBoardIndex).topY + 1
            'Else
                maxX = (boardList(activeBoardIndex).tilesX) + boardList(activeBoardIndex).topX + 1
                maxY = (boardList(activeBoardIndex).tilesY) + boardList(activeBoardIndex).topY + 1
            'End If
        Else
            minX = X
            minY = Y
            maxX = X
            maxY = Y
        End If
        
        ' loop through tiles
        For xxx = minX To maxX
            For yyy = minY To maxY
                
                ' !UPDATED! get color code for tile type
                colorCode = tiletype(boardList(activeBoardIndex).theData.tiletype(xxx, yyy, boardList(activeBoardIndex).currentLayer)).color
                
                Dim xx As Long, yy As Long
                
                'find x and y coords
                If boardList(activeBoardIndex).theData.isIsometric = 0 Then
                    xx = (xxx - boardList(activeBoardIndex).topX) * 32 - 32
                    yy = (yyy - boardList(activeBoardIndex).topY) - 1
                    yy = yy * 32
                Else
                    If (yyy Mod 2 = 0) Then
                        xx = (xxx - boardList(activeBoardIndex).topX) * 64 - 81
                        yy = (yyy - boardList(activeBoardIndex).topY) * 16 - 26
                    Else
                        xx = (xxx - boardList(activeBoardIndex).topX) * 64 - 50
                        yy = (yyy - boardList(activeBoardIndex).topY) * 16 - 26
                    End If
                End If
    
                ' draw arrow
                For aPoint = 9 To 16: Call vbPicLine(boardform, xx + aPoint, yy + aPoint, xx + 32 - aPoint, yy + aPoint, vbQBColor(colorCode)): Next aPoint
            
            Next yyy
            
        Next xxx
        
        ' Draw program and item markers
        drawPrograms True
        drawItems True
        drawWarps True

    End If
    
End Sub


'========================================================================
' display programs
'========================================================================
Sub drawPrograms(Optional fromTileType As Boolean = False)

    If fromTileType = True Or tkMainForm.boardToolbar.Display.Setting(eShowPrograms) = 1 Then
    
        Dim t As Long, xx As Long, yy As Long
        
        ' show the rpgcode programs...
        For t = 0 To UBound(boardList(activeBoardIndex).theData.programName)
        
            If boardList(activeBoardIndex).theData.progX(t) <> 0 And boardList(activeBoardIndex).theData.progY(t) <> 0 And boardList(activeBoardIndex).theData.progLayer(t) <> 0 Then
                
                If boardList(activeBoardIndex).theData.progX(t) >= 1 + boardList(activeBoardIndex).topX And boardList(activeBoardIndex).theData.progX(t) <= boardList(activeBoardIndex).tilesX + boardList(activeBoardIndex).topX And _
                    boardList(activeBoardIndex).theData.progY(t) >= 1 + boardList(activeBoardIndex).topY And boardList(activeBoardIndex).theData.progY(t) <= boardList(activeBoardIndex).tilesY + boardList(activeBoardIndex).topY And _
                    boardList(activeBoardIndex).theData.progLayer(t) = boardList(activeBoardIndex).currentLayer Then
                
                    If Left(boardList(activeBoardIndex).theData.programName(t), 4) <> "warp" Then
                
                        If boardList(activeBoardIndex).theData.isIsometric = 0 Then
                            
                            ' calculate co-ordinates for cross
                            xx = (boardList(activeBoardIndex).theData.progX(t) - boardList(activeBoardIndex).topX) * 32 - 32
                            yy = (boardList(activeBoardIndex).theData.progY(t) - boardList(activeBoardIndex).topY) - 1
                            yy = yy * 32
                            
                            ' draw cross
                            Call vbPicLine(boardform, xx, yy, xx + 32, yy + 32, RGB(255, 0, 0))
                            Call vbPicLine(boardform, xx + 1, yy, xx + 32, yy + 31, RGB(255, 0, 0))
                            Call vbPicLine(boardform, xx + 2, yy, xx + 32, yy + 30, RGB(255, 0, 0))
                        
                            Call vbPicLine(boardform, xx + 32, yy, xx, yy + 32, RGB(255, 0, 0))
                            Call vbPicLine(boardform, xx + 31, yy, xx, yy + 31, RGB(255, 0, 0))
                            Call vbPicLine(boardform, xx + 30, yy, xx, yy + 30, RGB(255, 0, 0))
                            
                        Else
                        
                            ' calculate co-ordinates for cross
                            If (boardList(activeBoardIndex).theData.progY(t) Mod 2 = 0) Then
                                xx = (boardList(activeBoardIndex).theData.progX(t) - boardList(activeBoardIndex).topX) * 64 - 81
                                yy = (boardList(activeBoardIndex).theData.progY(t) - boardList(activeBoardIndex).topY) * 16 - 26
                            Else
                                xx = (boardList(activeBoardIndex).theData.progX(t) - boardList(activeBoardIndex).topX) * 64 - 50
                                yy = (boardList(activeBoardIndex).theData.progY(t) - boardList(activeBoardIndex).topY) * 16 - 26
                            End If
                            
                            ' draw cross
                            Call vbPicLine(boardform, xx + 5, yy, xx + 27, yy + 22, RGB(255, 0, 0))
                            Call vbPicLine(boardform, xx + 6, yy, xx + 27, yy + 21, RGB(255, 0, 0))
                            Call vbPicLine(boardform, xx + 7, yy, xx + 27, yy + 20, RGB(255, 0, 0))
                    
                            Call vbPicLine(boardform, xx + 27, yy, xx + 5, yy + 22, RGB(255, 0, 0))
                            Call vbPicLine(boardform, xx + 26, yy, xx + 5, yy + 21, RGB(255, 0, 0))
                            Call vbPicLine(boardform, xx + 25, yy, xx + 5, yy + 20, RGB(255, 0, 0))
                        
                        End If
                    
                    End If
                    
                End If
                
            End If
            
        Next t
        
    End If
        
End Sub

'========================================================================
' display warp tiles
'========================================================================
Sub drawWarps(Optional fromTileType As Boolean = False)

    If fromTileType = True Or tkMainForm.boardToolbar.Display.Setting(eShowWarps) = 1 Then
    
        Dim t As Long, xx As Long, yy As Long
        
        ' show the warps...
        For t = 0 To UBound(boardList(activeBoardIndex).theData.programName)
        
            If boardList(activeBoardIndex).theData.progX(t) <> 0 And boardList(activeBoardIndex).theData.progY(t) <> 0 And boardList(activeBoardIndex).theData.progLayer(t) <> 0 Then
                
                If boardList(activeBoardIndex).theData.progX(t) >= 1 + boardList(activeBoardIndex).topX And boardList(activeBoardIndex).theData.progX(t) <= boardList(activeBoardIndex).tilesX + boardList(activeBoardIndex).topX And _
                    boardList(activeBoardIndex).theData.progY(t) >= 1 + boardList(activeBoardIndex).topY And boardList(activeBoardIndex).theData.progY(t) <= boardList(activeBoardIndex).tilesY + boardList(activeBoardIndex).topY And _
                    boardList(activeBoardIndex).theData.progLayer(t) = boardList(activeBoardIndex).currentLayer Then
                
                    If Left(boardList(activeBoardIndex).theData.programName(t), 4) = "warp" Then
                
                        If boardList(activeBoardIndex).theData.isIsometric = 0 Then
                            
                            ' calculate co-ordinates for cross
                            xx = (boardList(activeBoardIndex).theData.progX(t) - boardList(activeBoardIndex).topX) * 32 - 32
                            yy = (boardList(activeBoardIndex).theData.progY(t) - boardList(activeBoardIndex).topY) - 1
                            yy = yy * 32
                            
                            ' draw cross
                            Call vbPicLine(boardform, xx, yy, xx + 32, yy + 32, RGB(0, 255, 0))
                            Call vbPicLine(boardform, xx + 1, yy, xx + 32, yy + 31, RGB(0, 255, 0))
                            Call vbPicLine(boardform, xx + 2, yy, xx + 32, yy + 30, RGB(0, 255, 0))
                        
                            Call vbPicLine(boardform, xx + 32, yy, xx, yy + 32, RGB(0, 255, 0))
                            Call vbPicLine(boardform, xx + 31, yy, xx, yy + 31, RGB(0, 255, 0))
                            Call vbPicLine(boardform, xx + 30, yy, xx, yy + 30, RGB(0, 255, 0))
                            
                        Else
                        
                            ' calculate co-ordinates for cross
                            If (boardList(activeBoardIndex).theData.progY(t) Mod 2 = 0) Then
                                xx = (boardList(activeBoardIndex).theData.progX(t) - boardList(activeBoardIndex).topX) * 64 - 81
                                yy = (boardList(activeBoardIndex).theData.progY(t) - boardList(activeBoardIndex).topY) * 16 - 26
                            Else
                                xx = (boardList(activeBoardIndex).theData.progX(t) - boardList(activeBoardIndex).topX) * 64 - 50
                                yy = (boardList(activeBoardIndex).theData.progY(t) - boardList(activeBoardIndex).topY) * 16 - 26
                            End If
                            
                            ' draw cross
                            Call vbPicLine(boardform, xx + 5, yy, xx + 27, yy + 22, RGB(0, 255, 0))
                            Call vbPicLine(boardform, xx + 6, yy, xx + 27, yy + 21, RGB(0, 255, 0))
                            Call vbPicLine(boardform, xx + 7, yy, xx + 27, yy + 20, RGB(0, 255, 0))
                    
                            Call vbPicLine(boardform, xx + 27, yy, xx + 5, yy + 22, RGB(0, 255, 0))
                            Call vbPicLine(boardform, xx + 26, yy, xx + 5, yy + 21, RGB(0, 255, 0))
                            Call vbPicLine(boardform, xx + 25, yy, xx + 5, yy + 20, RGB(0, 255, 0))
                        
                        End If
                    
                    End If
                
                End If
                
            End If
            
        Next t
        
    End If
        
End Sub

'========================================================================
' display items
'========================================================================
Sub drawItems(Optional fromTileType As Boolean = False)

    If fromTileType = True Or tkMainForm.boardToolbar.Display.Setting(eShowItems) = 1 Then

        Dim t As Long, xx As Long, yy As Long

        ' show items
        For t = 0 To UBound(boardList(activeBoardIndex).theData.itmName)
            If boardList(activeBoardIndex).theData.itmX(t) <> 0 And boardList(activeBoardIndex).theData.itmY(t) <> 0 And boardList(activeBoardIndex).theData.itmLayer(t) <> 0 Then
                If boardList(activeBoardIndex).theData.itmX(t) >= 1 + boardList(activeBoardIndex).topX And boardList(activeBoardIndex).theData.itmX(t) <= boardList(activeBoardIndex).tilesX + boardList(activeBoardIndex).topX And _
                    boardList(activeBoardIndex).theData.itmY(t) >= 1 + boardList(activeBoardIndex).topY And boardList(activeBoardIndex).theData.itmY(t) <= boardList(activeBoardIndex).tilesY + boardList(activeBoardIndex).topY And _
                    boardList(activeBoardIndex).theData.itmLayer(t) = boardList(activeBoardIndex).currentLayer Then
                    
                    If tkMainForm.boardToolbar.Display.Setting(eShowGraphics) = 0 Then
                    
                        If boardList(activeBoardIndex).theData.isIsometric = 0 Then
                            
                            ' calculate co-ordinates for cross
                            xx = (boardList(activeBoardIndex).theData.itmX(t) - boardList(activeBoardIndex).topX) * 32 - 32
                            yy = (boardList(activeBoardIndex).theData.itmY(t) - boardList(activeBoardIndex).topY) - 1
                            yy = yy * 32
                            
                            ' draw cross
                            Call vbPicLine(boardform, xx, yy, xx + 32, yy + 32, RGB(0, 0, 255))
                            Call vbPicLine(boardform, xx + 1, yy, xx + 32, yy + 31, RGB(0, 0, 255))
                            Call vbPicLine(boardform, xx + 2, yy, xx + 32, yy + 30, RGB(0, 0, 255))
                        
                            Call vbPicLine(boardform, xx + 32, yy, xx, yy + 32, RGB(0, 0, 255))
                            Call vbPicLine(boardform, xx + 31, yy, xx, yy + 31, RGB(0, 0, 255))
                            Call vbPicLine(boardform, xx + 30, yy, xx, yy + 30, RGB(0, 0, 255))
                            
                        Else
                        
                            ' calculate co-ordinates for cross
                            If (boardList(activeBoardIndex).theData.itmY(t) Mod 2 = 0) Then
                                xx = (boardList(activeBoardIndex).theData.itmX(t) - boardList(activeBoardIndex).topX) * 64 - 81
                                yy = (boardList(activeBoardIndex).theData.itmY(t) - boardList(activeBoardIndex).topY) * 16 - 26
                            Else
                                xx = (boardList(activeBoardIndex).theData.itmX(t) - boardList(activeBoardIndex).topX) * 64 - 50
                                yy = (boardList(activeBoardIndex).theData.itmY(t) - boardList(activeBoardIndex).topY) * 16 - 26
                            End If
                            
                            ' draw cross
                            Call vbPicLine(boardform, xx + 5, yy, xx + 27, yy + 22, RGB(0, 0, 255))
                            Call vbPicLine(boardform, xx + 6, yy, xx + 27, yy + 21, RGB(0, 0, 255))
                            Call vbPicLine(boardform, xx + 7, yy, xx + 27, yy + 20, RGB(0, 0, 255))
                    
                            Call vbPicLine(boardform, xx + 27, yy, xx + 5, yy + 22, RGB(0, 0, 255))
                            Call vbPicLine(boardform, xx + 26, yy, xx + 5, yy + 21, RGB(0, 0, 255))
                            Call vbPicLine(boardform, xx + 25, yy, xx + 5, yy + 20, RGB(0, 0, 255))
                        
                        End If
                        
                    Else
                    
                        ' draw item graphic
                        
                    
                    End If
                
                End If
                
            End If
            
        Next t
        
    End If
                
End Sub

'========================================================================
' !UPDATE! vertical scroll
'========================================================================
Private Sub VScroll1_Change(): On Error Resume Next
'=====================================================
'Alterations for isometric sizing, for 3.0.4 by Delano
    
    If bOpeningBoard Then
        Exit Sub
    End If
    
    If ignore = 1 Then
        ignore = 0
        Exit Sub
    End If
    
    Dim tX As Long, tY As Long
    
    ' get x and y values
    tX = boardList(activeBoardIndex).tilesX
    tY = boardList(activeBoardIndex).tilesY
    
    ' alter values if isometric board - removed!!
    'If boardList(activeBoardIndex).theData.isIsometric = 1 Then
    '    tX = Int(tX / 2) + 1
    '    tY = tY * 2 + 1
    'End If
    
    ' check maximum values
    If VScroll1.max <> boardList(activeBoardIndex).theData.Bsizey - tY + 1 Then
        VScroll1.max = boardList(activeBoardIndex).theData.Bsizey - tY + 1
    End If
    
    If VScroll1.value + tY - 1 > boardList(activeBoardIndex).theData.Bsizey Then
        ignore = 1
        
        VScroll1.value = boardList(activeBoardIndex).theData.Bsizey - tY - 1
        
        Call boardRedraw
        
        Exit Sub
    End If
    
    If VScroll1.value - 1 = boardList(activeBoardIndex).topY + 1 Then
    
        boardList(activeBoardIndex).topY = VScroll1.value - 1
        
        Call shiftUp
    
        Call boardRedraw
        
        Exit Sub
        
    End If
    
    If VScroll1.value - 1 = boardList(activeBoardIndex).topY - 1 Then
    
        boardList(activeBoardIndex).topY = VScroll1.value - 1
        
        Call shiftDown
        
        Call boardRedraw
        
        Exit Sub
        
    End If
    
    ' update top value
    boardList(activeBoardIndex).topY = VScroll1.value - 1
    
    ' redraw board
    Call boardRedraw

End Sub

'============================================================
' set warp
'============================================================
Private Sub wrp_Click(): On Error Resume Next

    ' give user instructions
    MsgBox LoadStringLoc(952, "To set a warp tile, click on the tile you want")
    
    ' update caption
    tkMainForm.drawstatebox.Caption = LoadStringLoc(910, "Set Warp Tile")
    
    ' set draw state value
    boardList(activeBoardIndex).drawState = 5

End Sub

'========================================================================
' !NEW! get tiles amount from twips and vice versa + isometric versions.
'========================================================================
Private Function tilesX(twips As Long) As Long

    If boardList(activeBoardIndex).theData.isIsometric = 1 Then
        tilesX = round(((twips / Screen.TwipsPerPixelX) + 32) / 64)
    Else
        tilesX = round((twips / Screen.TwipsPerPixelX) / 32)
    End If
    
End Function
Private Function tilesY(twips As Long) As Long
    
    If boardList(activeBoardIndex).theData.isIsometric = 1 Then
        tilesY = round(((twips / Screen.TwipsPerPixelY) + 16) / 16)
    Else
        tilesY = round((twips / Screen.TwipsPerPixelY) / 32)
    End If

End Function
Private Function TwipsX(tiles As Long) As Long

    If boardList(activeBoardIndex).theData.isIsometric = 1 Then
        TwipsX = Screen.TwipsPerPixelX * (tiles * 64 - 32)
    Else
        TwipsX = Screen.TwipsPerPixelX * (tiles * 32)
    End If
    
End Function
Private Function TwipsY(tiles As Long) As Long

    If boardList(activeBoardIndex).theData.isIsometric = 1 Then
        TwipsY = Screen.TwipsPerPixelY * (tiles * 16 - 16)
    Else
        TwipsY = Screen.TwipsPerPixelY * (tiles * 32)
    End If
    
End Function

'============================================================
' Main Form Menu
'============================================================
'Open New Project
Private Sub mnuOpenProject_Click()
    On Error Resume Next: Call tkMainForm.mnuOpenProject_Click
End Sub
' New Fight BackGround
Private Sub mnuNewFightBackground_Click()
    On Error Resume Next: Call tkMainForm.mnuNewFightBackground_Click
End Sub
' Open Tutorial
Private Sub tutorialmnu_Click()
    On Error Resume Next: Call tkMainForm.tutorialmnu_Click
End Sub
' Show Project Menu
Private Sub showprojectlistmnu_Click()
    Call tkMainForm.showprojectlistmnu_Click
End Sub
' Show Tool Menu
Private Sub showtoolsmnu_Click()
    Call tkMainForm.showtoolsmnu_Click
End Sub
' Tile Windows Horizontally
Private Sub tilehorizontallymnu_Click()
    On Error Resume Next: Call tkMainForm.tilehorizonatllymnu_Click
End Sub
' Tile Windows By Type
Private Sub tiletypesel_Click()
    On Error Resume Next: Call tkMainForm.toggle_Click
End Sub
' Tile Windows Vertically
Private Sub tileverticallymnu_Click()
    On Error Resume Next: Call tkMainForm.tileverticallymnu_Click
End Sub
' Open User Guide
Private Sub toc_Click()
    On Error Resume Next: Call tkMainForm.usersguidemnu_Click
End Sub
' Select Language
Private Sub selectlanguagemnu_Click()
    On Error Resume Next: Call tkMainForm.selectlanguagemnu_Click
End Sub
' Registrayion Info
Private Sub registrationinfomnu_Click()
    On Error Resume Next: Call tkMainForm.registrationinfomnu_Click
End Sub
' Open RPG Code Primer
Private Sub rpgcodeprimermnu_Click()
    On Error Resume Next: Call tkMainForm.rpgcodeprimermnu_Click
End Sub
' Open RPG Code Reference
Private Sub rpgcodreferencemnu_Click()
    On Error Resume Next: Call tkMainForm.rpgcodereferencemnu_Click
End Sub
' Save All Documents
Private Sub saveallmnu_Click()
    On Error Resume Next: Call tkMainForm.saveallmnu_Click
End Sub
' Test Game
Private Sub mnutestgame_Click()
    On Error Resume Next: tkMainForm.testgamemnu_Click
End Sub
' New Animated Tile
Private Sub newanimatedtilemnu_Click()
    On Error Resume Next: Call tkMainForm.newanimtilemnu_Click
End Sub
' New Animation
Private Sub newanimationmnu_Click()
    On Error Resume Next: Call tkMainForm.newanimationmnu_Click
End Sub
' New Board
Private Sub newbrdmnu_Click()
    On Error Resume Next: Call tkMainForm.newboardmnu_Click
End Sub
' New Enemy
Private Sub newenemymnu_Click()
    On Error Resume Next: Call tkMainForm.newenemymnu_Click
End Sub
' New Item
Private Sub newitemmnu_Click()
    On Error Resume Next: Call tkMainForm.newitemmnu_Click
End Sub
' New Player
Private Sub newplayermnu_Click()
    On Error Resume Next: Call tkMainForm.newplayermnu_Click
End Sub
' New Project
Private Sub newprojectmnu_Click()
    On Error Resume Next: Call tkMainForm.newprojectmnu_Click
End Sub
' New RPG Code Program
Private Sub newrpgcodeprogrammnu_Click()
    On Error Resume Next: Call tkMainForm.newrpgcodemnu_Click
End Sub
' New Special Move
Private Sub newspecialmovemnu_Click()
    On Error Resume Next: Call tkMainForm.newspecialmovemnu_Click
End Sub
' New Status Effect
Private Sub newstatuseffectmnu_Click()
    On Error Resume Next: Call tkMainForm.newstatuseffectmnu_Click
End Sub
' New Tile Bitmap
Private Sub newtilebitmapmnu_Click()
    On Error Resume Next: Call tkMainForm.newtilebitmapmnu_Click
End Sub
' New Tile
Private Sub newtilemnu_Click()
    On Error Resume Next: Call tkMainForm.newtilemnu_Click
End Sub
' Open Board
Private Sub openbrdmnu_Click()
    On Error Resume Next: Call tkMainForm.openmnu_Click
End Sub
' Make EXE
Private Sub makexemnu_Click()
    On Error Resume Next: Call tkMainForm.makeexemnu_Click
End Sub
' Install Upgrade
Private Sub installupgrademnu_Click()
    On Error Resume Next: Call tkMainForm.installupgrademnu_Click
End Sub
' Arrange Icons
Private Sub arrangeiconsmnu_Click()
    On Error Resume Next: Call tkMainForm.arrangeiconsmnu_Click
End Sub
' Cascade Windows
Private Sub cascademnu_Click()
    On Error Resume Next: Call tkMainForm.cascademnu_Click
End Sub
' Create Pak File
Private Sub createpakfilemnu_Click()
    On Error Resume Next: Call tkMainForm.createpakfilemnu_Click
End Sub
' Create Setup
Private Sub createsetupmnu_Click()
    On Error Resume Next: Call tkMainForm.createsetupmnu_Click
End Sub
' Exit
Private Sub exitmnu_Click()
    On Error Resume Next: Call tkMainForm.exitmnu_Click
End Sub
' Open History
Private Sub historytxtmnu_Click()
    On Error Resume Next: Call tkMainForm.historytxtmnu_Click
End Sub
' About Toolkit
Private Sub aboutmnu_Click()
    On Error Resume Next: Call tkMainForm.aboutmnu_Click
End Sub

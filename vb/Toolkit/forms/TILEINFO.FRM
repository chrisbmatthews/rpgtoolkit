VERSION 5.00
Begin VB.Form tileinfo 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Tile Information"
   ClientHeight    =   3330
   ClientLeft      =   2145
   ClientTop       =   2220
   ClientWidth     =   7365
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
   Icon            =   "TILEINFO.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   222
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   491
   StartUpPosition =   1  'CenterOwner
   Tag             =   "1701"
   Begin VB.Timer animTile 
      Enabled         =   0   'False
      Interval        =   5
      Left            =   0
      Top             =   0
   End
   Begin VB.Frame Frame1 
      Caption         =   "Tile Information"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   3015
      Left            =   120
      TabIndex        =   3
      Tag             =   "1701"
      Top             =   120
      Width           =   5295
      Begin VB.PictureBox Picture1 
         BorderStyle     =   0  'None
         Height          =   855
         Left            =   4320
         ScaleHeight     =   855
         ScaleWidth      =   855
         TabIndex        =   18
         Top             =   1800
         Width           =   855
         Begin VB.CommandButton EditItem 
            Caption         =   "Edit"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   0
            TabIndex        =   20
            Tag             =   "1377"
            Top             =   360
            Width           =   615
         End
         Begin VB.CommandButton EditProgram 
            Caption         =   "Edit"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   0
            TabIndex        =   19
            Tag             =   "1377"
            Top             =   0
            Width           =   615
         End
      End
      Begin VB.PictureBox tileInfoIso 
         BackColor       =   &H80000005&
         Height          =   545
         Left            =   840
         ScaleHeight     =   32
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   64
         TabIndex        =   17
         Top             =   2400
         Width           =   1020
      End
      Begin VB.PictureBox tileinfopic 
         BackColor       =   &H00FFFFFF&
         Height          =   545
         Left            =   120
         ScaleHeight     =   32
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   32
         TabIndex        =   16
         Top             =   2400
         Width           =   545
      End
      Begin VB.Label Label2 
         Caption         =   "Location:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   120
         TabIndex        =   15
         Tag             =   "1711"
         Top             =   720
         Width           =   855
      End
      Begin VB.Label Label3 
         Caption         =   "Layer:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   120
         TabIndex        =   14
         Tag             =   "1710"
         Top             =   1080
         Width           =   1095
      End
      Begin VB.Label Label4 
         Caption         =   "Tile Type:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   120
         TabIndex        =   13
         Tag             =   "1275"
         Top             =   1440
         Width           =   1095
      End
      Begin VB.Label Label5 
         Caption         =   "Filename:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   120
         TabIndex        =   12
         Tag             =   "1013"
         Top             =   360
         Width           =   1095
      End
      Begin VB.Label filename 
         Caption         =   "Filename"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   1800
         TabIndex        =   11
         Tag             =   "1470"
         Top             =   360
         Width           =   1935
      End
      Begin VB.Label location 
         Caption         =   "x,y"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   1800
         TabIndex        =   10
         Tag             =   "1709"
         Top             =   720
         Width           =   2175
      End
      Begin VB.Label layer 
         Caption         =   "layer"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   1800
         TabIndex        =   9
         Tag             =   "1041"
         Top             =   1080
         Width           =   2055
      End
      Begin VB.Label tiletypex 
         Caption         =   "type"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   1800
         TabIndex        =   8
         Tag             =   "1708"
         Top             =   1440
         Width           =   2175
      End
      Begin VB.Label Label6 
         Caption         =   "RPGCode Program:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   120
         TabIndex        =   7
         Tag             =   "1360"
         Top             =   1800
         Width           =   1455
      End
      Begin VB.Label Label7 
         Caption         =   "Item:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   120
         TabIndex        =   6
         Tag             =   "1707"
         Top             =   2160
         Width           =   1455
      End
      Begin VB.Label rpgcodebox 
         Caption         =   "rpgcodebox"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   1800
         TabIndex        =   5
         Tag             =   "1706"
         Top             =   1800
         Width           =   2175
      End
      Begin VB.Label itembox 
         Caption         =   "itembox"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   1800
         TabIndex        =   4
         Tag             =   "1705"
         Top             =   2160
         Width           =   2175
      End
   End
   Begin VB.CommandButton ChangeTileType 
      Appearance      =   0  'Flat
      Caption         =   "Change Type"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   5520
      TabIndex        =   2
      Tag             =   "1702"
      Top             =   2760
      Width           =   1695
   End
   Begin VB.CommandButton EraseTile 
      Appearance      =   0  'Flat
      Caption         =   "Erase Tile"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   5520
      TabIndex        =   1
      Tag             =   "1703"
      Top             =   2280
      Width           =   1695
   End
   Begin VB.CommandButton ReturnToEditor 
      Appearance      =   0  'Flat
      Caption         =   "Return To Editor"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   5520
      TabIndex        =   0
      Tag             =   "1704"
      Top             =   240
      Width           =   1695
   End
End
Attribute VB_Name = "tileinfo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'=======================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=======================================================================

'=======================================================================
'Additions for new isometric tilesets.
'Edited by Delano for 3.0.4
'   Set Option Explicit
'   Added isometric picture box - draws using tileDrawIso.
'   Renamed subs.
'
'Changes have been made in the following subs.
'   form_load
'=======================================================================

Option Explicit

Private selectedAnm As TKTileAnm

Private Sub animTile_Timer()
    If TileAnmShouldDrawFrame(selectedAnm) Then
        Call vbPicCls(tileinfopic)
        
        Call TileAnmDrawNextFrame(selectedAnm, vbPicHDC(tileinfopic), 1, 1, 0, 0, 0)
        Call vbPicRefresh(tileinfopic)
    End If
End Sub


Private Sub ReturnToEditor_Click()
'=================================
'Exits the Tile Info window.
'=================================
    On Error GoTo ErrorHandler
    Unload tileinfo

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub EraseTile_Click()
'============================
'Erases the current tile.
'============================
    On Error GoTo ErrorHandler
    
    Dim xx As Long, yy As Long
    
    Call BoardSetTile(boardList(activeBoardIndex).infoX, boardList(activeBoardIndex).infoY, boardList(activeBoardIndex).currentLayer, "", boardList(activeBoardIndex).theData)
    boardList(activeBoardIndex).theData.ambientRed(boardList(activeBoardIndex).infoY, boardList(activeBoardIndex).infoY, boardList(activeBoardIndex).currentLayer) = 0
    boardList(activeBoardIndex).theData.ambientGreen(boardList(activeBoardIndex).infoY, boardList(activeBoardIndex).infoY, boardList(activeBoardIndex).currentLayer) = 0
    boardList(activeBoardIndex).theData.ambientBlue(boardList(activeBoardIndex).infoY, boardList(activeBoardIndex).infoY, boardList(activeBoardIndex).currentLayer) = 0
    xx = boardList(activeBoardIndex).infoX * 32 - 32
    yy = boardList(activeBoardIndex).infoY * 32 - 32
    Call vbPicFillRect(activeBoard.boardform, xx, yy, xx + 32, yy + 32, vbQBColor(15))
    Unload tileinfo

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub EditProgram_Click()
'==============================
'Loads the set program dialog.
'==============================
    On Error Resume Next
    
    Dim t As Integer
    
    For t = 0 To UBound(boardList(activeBoardIndex).theData.programName)
        If boardList(activeBoardIndex).theData.progX(t) = boardList(activeBoardIndex).infoX And boardList(activeBoardIndex).theData.progY(t) = boardList(activeBoardIndex).infoY And boardList(activeBoardIndex).theData.progLayer(t) = boardList(activeBoardIndex).currentLayer Then
            boardList(activeBoardIndex).prgCondition = t
            programset.Show vbModal ', me
            Exit Sub
        End If
    Next t
    
    'if we got here, then no program was found on this space...
    For t = 0 To UBound(boardList(activeBoardIndex).theData.programName)
        If boardList(activeBoardIndex).theData.programName$(t) = "" Then
            boardList(activeBoardIndex).prgCondition = t
            programset.Show vbModal ', me
            Exit Sub
        End If
    Next t
    
    MsgBox LoadStringLoc(955, "No open program slots left on this board!")
End Sub

Private Sub ChangeTileType_Click()
'=================================
'Cycles through the tile types.
'=================================
    On Error GoTo ErrorHandler
    
    Dim thistile As Integer, levelnum As Integer
    
    thistile = boardList(activeBoardIndex).theData.tiletype(boardList(activeBoardIndex).infoX, boardList(activeBoardIndex).infoY, boardList(activeBoardIndex).currentLayer)
    thistile = thistile + 1
    If thistile = 5 Then thistile = 11
    If thistile > 18 Then thistile = 0
    boardList(activeBoardIndex).theData.tiletype(boardList(activeBoardIndex).infoX, boardList(activeBoardIndex).infoY, boardList(activeBoardIndex).currentLayer) = thistile
    Select Case thistile
        Case 0
            tiletypex.Caption = LoadStringLoc(816, "Normal")
        Case 1
            tiletypex.Caption = LoadStringLoc(817, "Solid")
        Case 2
            tiletypex.Caption = LoadStringLoc(818, "Under")
        Case 3
            tiletypex.Caption = LoadStringLoc(819, "North-South Normal")
        Case 4
            tiletypex.Caption = LoadStringLoc(820, "East-West Normal")
        Case 11 To 18
            levelnum = thistile - 10
            tiletypex.Caption = LoadStringLoc(821, "Stairs to layer") + str$(levelnum)
    End Select



    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub EditItem_Click()
'===========================
'Loads the item set dialog.
'===========================
    On Error Resume Next
    
    Dim t As Integer
    
    For t = 0 To 10
        If boardList(activeBoardIndex).theData.itmX(t) = boardList(activeBoardIndex).infoX And boardList(activeBoardIndex).theData.itmY(t) = boardList(activeBoardIndex).infoY And boardList(activeBoardIndex).theData.itmLayer(t) = boardList(activeBoardIndex).currentLayer Then
            boardList(activeBoardIndex).itmCondition = t
            itemset.Show vbModal ', me
            Exit Sub
        End If
    Next t
    
    'if we got here, then no program was found on this space...
    For t = 0 To 10
        If boardList(activeBoardIndex).theData.itmName$(t) = "" Then
            boardList(activeBoardIndex).itmCondition = t
            itemset.Show vbModal ', me
            Exit Sub
        End If
    Next t
    
    MsgBox LoadStringLoc(956, "No open item slots left on this board!")
End Sub

Private Sub Form_Load()
'===============================================
'Enters the data about the tile, draws the tile.
'===============================================
'Edited by Delano for 3.0.4
'Added isometric picture box, support for .iso.

    On Error Resume Next
    
    Dim X As Integer, Y As Integer, colorit As Long
    Dim Temp As String, tileopen As String, fn As String, ex As String
    Dim levelnum As Integer, numof As Integer, testtype As Integer, t As Integer
    
    ' Call LocalizeForm(Me)
    
    Call vbPicAutoRedraw(tileinfopic, True)
    Call vbPicAutoRedraw(tileInfoIso, True)         'Added.

    'Hold the current tilemem in the tile buffer.
    openTileEditorDocs(activeTile.indice).oldDetail = detail
    For X = 1 To 32
        For Y = 1 To 32
            bufTile(X, Y) = tileMem(X, Y)
        Next Y
    Next X
    
    'First, see if it's in an archive
    tileopen$ = projectPath$ + tilePath$ + BoardGetTile(boardList(activeBoardIndex).infoX, boardList(activeBoardIndex).infoY, boardList(activeBoardIndex).currentLayer, boardList(activeBoardIndex).theData)
    ex$ = UCase$(GetExt(tilesetFilename(tileopen$)))
    
    If ex$ = "TAN" Then
        Call openTileAnm(tileopen$, selectedAnm)
        animTile.Enabled = True
    Else
        '.gph, .tst, .iso
        
        Call openWinTile(tileopen$)
        If detail = 2 Then Call increaseDetail
        
        'Added.
        'Draw the tile isometrically. Draws tilemem which was loaded in openwintile.
        If ex$ = "ISO" Then
            Call tileDrawIso(tileInfoIso, 0, 0, ISODETAIL)
        Else
            Call tileDrawIso(tileInfoIso, 0, 0, 3)
        End If
        
        'Draw the tile 2D. Not edited for .iso, incase people want to use .iso on 2D boards...
        For X = 1 To 32
            For Y = 1 To 32
                colorit = tileMem(X, Y)
                If colorit = -1 Then colorit = vbQBColor(15)
                Call vbPicPSet(tileinfopic, X - 1, Y - 1, colorit)
                
                tileMem(X, Y) = bufTile(X, Y)
            Next Y
        Next X
        detail = openTileEditorDocs(activeTile.indice).oldDetail
    End If

'Fill in info
    filename.Caption = ""
    Temp$ = BoardGetTile(boardList(activeBoardIndex).infoX, boardList(activeBoardIndex).infoY, boardList(activeBoardIndex).currentLayer, boardList(activeBoardIndex).theData)
    ex$ = UCase$(GetExt(tilesetFilename(Temp$)))
    
    If UCase$(ex$) = "TST" Or UCase$(ex$) = "ISO" Then
        numof = getTileNum(Temp$)
        fn$ = tilesetFilename(Temp$)
        fn$ = projectPath$ + tilePath$ + fn$
        fn$ = noPath$(fn$)
        fn$ = Mid$(fn$, 2, Len(fn$) - 1)
        fn$ = fn$ + CStr(numof)
        'fn$ = nospace(fn$)
        Temp$ = fn$
    Else
        Temp$ = projectPath$ + tilePath$ + BoardGetTile(boardList(activeBoardIndex).infoX, boardList(activeBoardIndex).infoY, boardList(activeBoardIndex).currentLayer, boardList(activeBoardIndex).theData)
        Temp$ = noPath$(Temp$)
        Temp$ = Mid$(Temp$, 2, Len(Temp$) - 1)
    End If
    
    filename.Caption = Temp$
    location.Caption = str$(boardList(activeBoardIndex).infoX) + "," + str$(boardList(activeBoardIndex).infoY)
    layer.Caption = str$(boardList(activeBoardIndex).currentLayer)
    
    'Tile type
    testtype = boardList(activeBoardIndex).theData.tiletype(boardList(activeBoardIndex).infoX, boardList(activeBoardIndex).infoY, boardList(activeBoardIndex).currentLayer)
    Select Case testtype
        Case 0
            tiletypex.Caption = LoadStringLoc(816, "Normal")
        Case 1
            tiletypex.Caption = LoadStringLoc(817, "Solid")
        Case 2
            tiletypex.Caption = LoadStringLoc(818, "Under")
        Case 3
            tiletypex.Caption = LoadStringLoc(819, "North-South Normal")
        Case 4
            tiletypex.Caption = LoadStringLoc(820, "East-West Normal")
        Case 11 To 18
            levelnum = testtype - 10
            tiletypex.Caption = LoadStringLoc(821, "Stairs to layer") + str$(levelnum)
    End Select

    'check rpgcode programs...
    rpgcodebox.Caption = LoadStringLoc(1010, "None")
    For t = 0 To UBound(boardList(activeBoardIndex).theData.programName)
        If boardList(activeBoardIndex).theData.progX(t) = boardList(activeBoardIndex).infoX And boardList(activeBoardIndex).theData.progY(t) = boardList(activeBoardIndex).infoY And boardList(activeBoardIndex).theData.progLayer(t) = boardList(activeBoardIndex).currentLayer Then
            rpgcodebox.Caption = boardList(activeBoardIndex).theData.programName$(t)
            Exit For
        End If
    Next t

    'check items programs...
    itembox.Caption = LoadStringLoc(1010, "None")
    For t = 0 To 10
        If boardList(activeBoardIndex).theData.itmX(t) = boardList(activeBoardIndex).infoX And boardList(activeBoardIndex).theData.itmY(t) = boardList(activeBoardIndex).infoY And boardList(activeBoardIndex).theData.itmLayer(t) = boardList(activeBoardIndex).currentLayer Then
            itembox.Caption = boardList(activeBoardIndex).theData.itmName$(t)
            Exit For
        End If
    Next t

    Call vbPicRefresh(tileinfopic)
    Call vbPicRefresh(tileInfoIso)  'Added.
End Sub


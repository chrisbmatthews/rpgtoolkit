VERSION 5.00
Begin VB.Form itmgfx2 
   Caption         =   "Item Graphics"
   ClientHeight    =   3105
   ClientLeft      =   360
   ClientTop       =   2280
   ClientWidth     =   8910
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
   Icon            =   "ITMGFX2.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   3105
   ScaleWidth      =   8910
   StartUpPosition =   1  'CenterOwner
   Tag             =   "1633"
   Begin VB.CheckBox tool 
      Height          =   375
      Index           =   0
      Left            =   8160
      Picture         =   "ITMGFX2.frx":0CCA
      Style           =   1  'Graphical
      TabIndex        =   25
      Tag             =   "1269"
      ToolTipText     =   "Eraser"
      Top             =   1800
      Width           =   375
   End
   Begin VB.PictureBox atrestgfx 
      AutoRedraw      =   -1  'True
      BackColor       =   &H00FFFFFF&
      Height          =   990
      Left            =   120
      ScaleHeight     =   62
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   29
      TabIndex        =   23
      Top             =   2040
      Width           =   495
   End
   Begin VB.PictureBox Walkstance 
      BackColor       =   &H00FFFFFF&
      Height          =   990
      Index           =   0
      Left            =   120
      ScaleHeight     =   62
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   29
      TabIndex        =   17
      Top             =   600
      Width           =   495
   End
   Begin VB.PictureBox Walkstance 
      BackColor       =   &H00FFFFFF&
      Height          =   990
      Index           =   1
      Left            =   600
      ScaleHeight     =   62
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   29
      TabIndex        =   16
      Top             =   600
      Width           =   495
   End
   Begin VB.PictureBox Walkstance 
      BackColor       =   &H00FFFFFF&
      Height          =   990
      Index           =   2
      Left            =   1080
      ScaleHeight     =   62
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   29
      TabIndex        =   15
      Top             =   600
      Width           =   495
   End
   Begin VB.PictureBox Walkstance 
      BackColor       =   &H00FFFFFF&
      Height          =   990
      Index           =   3
      Left            =   1560
      ScaleHeight     =   62
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   29
      TabIndex        =   14
      Top             =   600
      Width           =   495
   End
   Begin VB.PictureBox Walkstance 
      BackColor       =   &H00FFFFFF&
      Height          =   990
      Index           =   4
      Left            =   2280
      ScaleHeight     =   62
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   29
      TabIndex        =   13
      Top             =   600
      Width           =   495
   End
   Begin VB.PictureBox Walkstance 
      BackColor       =   &H00FFFFFF&
      Height          =   990
      Index           =   5
      Left            =   2760
      ScaleHeight     =   62
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   29
      TabIndex        =   12
      Top             =   600
      Width           =   495
   End
   Begin VB.PictureBox Walkstance 
      BackColor       =   &H00FFFFFF&
      Height          =   990
      Index           =   6
      Left            =   3240
      ScaleHeight     =   62
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   29
      TabIndex        =   11
      Top             =   600
      Width           =   495
   End
   Begin VB.PictureBox Walkstance 
      BackColor       =   &H00FFFFFF&
      Height          =   990
      Index           =   7
      Left            =   3720
      ScaleHeight     =   62
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   29
      TabIndex        =   10
      Top             =   600
      Width           =   495
   End
   Begin VB.PictureBox Walkstance 
      BackColor       =   &H00FFFFFF&
      Height          =   990
      Index           =   8
      Left            =   4440
      ScaleHeight     =   62
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   29
      TabIndex        =   9
      Top             =   600
      Width           =   495
   End
   Begin VB.PictureBox Walkstance 
      BackColor       =   &H00FFFFFF&
      Height          =   990
      Index           =   9
      Left            =   4920
      ScaleHeight     =   62
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   29
      TabIndex        =   8
      Top             =   600
      Width           =   495
   End
   Begin VB.PictureBox Walkstance 
      BackColor       =   &H00FFFFFF&
      Height          =   990
      Index           =   10
      Left            =   5400
      ScaleHeight     =   62
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   29
      TabIndex        =   7
      Top             =   600
      Width           =   495
   End
   Begin VB.PictureBox Walkstance 
      BackColor       =   &H00FFFFFF&
      Height          =   990
      Index           =   11
      Left            =   5880
      ScaleHeight     =   62
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   29
      TabIndex        =   6
      Top             =   600
      Width           =   495
   End
   Begin VB.PictureBox Walkstance 
      BackColor       =   &H00FFFFFF&
      Height          =   990
      Index           =   12
      Left            =   8040
      ScaleHeight     =   62
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   29
      TabIndex        =   5
      Top             =   600
      Width           =   495
   End
   Begin VB.PictureBox Walkstance 
      BackColor       =   &H00FFFFFF&
      Height          =   990
      Index           =   13
      Left            =   7560
      ScaleHeight     =   62
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   29
      TabIndex        =   4
      Top             =   600
      Width           =   495
   End
   Begin VB.PictureBox Walkstance 
      BackColor       =   &H00FFFFFF&
      Height          =   990
      Index           =   14
      Left            =   7080
      ScaleHeight     =   62
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   29
      TabIndex        =   3
      Top             =   600
      Width           =   495
   End
   Begin VB.PictureBox Walkstance 
      BackColor       =   &H00FFFFFF&
      Height          =   990
      Index           =   15
      Left            =   6600
      ScaleHeight     =   62
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   29
      TabIndex        =   2
      Top             =   600
      Width           =   495
   End
   Begin VB.CommandButton Command2 
      Appearance      =   0  'Flat
      Caption         =   "Animate!"
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
      Left            =   7320
      TabIndex        =   1
      Tag             =   "1237"
      Top             =   2520
      Width           =   1215
   End
   Begin VB.PictureBox walkanimate 
      AutoRedraw      =   -1  'True
      BackColor       =   &H00FFFFFF&
      Height          =   990
      Left            =   6600
      ScaleHeight     =   62
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   29
      TabIndex        =   0
      Top             =   1920
      Width           =   495
   End
   Begin VB.Label Label1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Standard Rest Graphic:"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   255
      Index           =   5
      Left            =   120
      TabIndex        =   24
      Tag             =   "1635"
      Top             =   1800
      Width           =   2895
   End
   Begin VB.Label Label1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Standard Walking Graphics:"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   255
      Index           =   0
      Left            =   120
      TabIndex        =   22
      Tag             =   "1263"
      Top             =   120
      Width           =   3495
   End
   Begin VB.Label Label3 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Front View"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   135
      Index           =   0
      Left            =   120
      TabIndex        =   21
      Tag             =   "1260"
      Top             =   480
      Width           =   1095
   End
   Begin VB.Label Label3 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Rear View"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   135
      Index           =   1
      Left            =   4440
      TabIndex        =   20
      Tag             =   "1259"
      Top             =   480
      Width           =   1215
   End
   Begin VB.Label Label3 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Left View"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   135
      Index           =   2
      Left            =   6600
      TabIndex        =   19
      Tag             =   "1258"
      Top             =   480
      Width           =   855
   End
   Begin VB.Label Label3 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Right View"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   135
      Index           =   3
      Left            =   2280
      TabIndex        =   18
      Tag             =   "1257"
      Top             =   480
      Width           =   1095
   End
End
Attribute VB_Name = "itmgfx2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private selectedCharTile$
Private Sub atrestgfx_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
    On Error GoTo errorhandler
    yy = Int(y / 32)
    If itemList(activeItemIndex).itmLayTile = False Then
        Call openbox
    Else
        If selectedCharTile$ <> "" Then
            itemList(activeItemIndex).itmLayTile = False
        End If
    End If
    'Walkstance(Index).Line (0, 0)-(100, 100), vbqbcolor(15), BF
    itemList(activeItemIndex).theData.itmrestGfx$(yy) = selectedCharTile$
    For x = 1 To 32
        For y = 1 To 32
              coluse = tilemem(x, y)
              If coluse <> -1 Then
                Call vbPicPSet(atrestgfx, x - 1, y - 1 + yy * 32, coluse)
              End If
        Next y
    Next x
    Call vbPicRefresh(atrestgfx)


    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command1_Click()
End Sub

Private Sub Command2_Click()
    On Error GoTo errorhandler
    For cycle = 0 To 3
        For loops = 1 To 4
            For t = 0 To 3
                Call vbPicAutoRedraw(walkanimate, True)
                For u = 0 To 1
                    If itemList(activeItemIndex).theData.itmwalkGfx$(t + cycle * 4, u) <> "" Then
                        Call openwintile(projectPath$ + tilepath$ + itemList(activeItemIndex).theData.itmwalkGfx$(t + cycle * 4, u))
                        For x = 1 To 32
                            For y = 1 To 32
                                coluse = tilemem(x, y)
                                If coluse <> -1 Then
                                    Call vbPicPSet(walkanimate, x - 1, y - 1 + u * 32, coluse)
                                End If
                            Next y
                        Next x
                    End If
                Next u
                ll = Timer
                Do While Timer - ll < 0.05
                Loop
                Call vbPicRefresh(walkanimate)
                Call vbPicCls(walkanimate)
                'walkanimate.AutoRedraw = False
            Next t
        Next loops
    Next cycle

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)
    On Error GoTo errorhandler
    If UCase$(Chr$(KeyAscii)) = "L" Then
        tool(0).value = False
        If lastTileset$ = "" Then
            Call openbox
            Exit Sub
        End If
        If lastTileset$ <> "" Then
            tstFile$ = lastTileset$
            tilesetform.Show 1
            'MsgBox setFilename$
            If setFilename$ = "" Then Exit Sub
            Call openwintile(projectPath$ + tilepath$ + setFilename$)
            selectedCharTile$ = setFilename$
            itemList(activeItemIndex).itmLayTile = True
        End If
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Form_Load()
    On Error GoTo errorhandler
    Call LocalizeForm(Me)
    
    Call GFXClearTileCache  ''kill the cache
    
    onemoment.Show
    itemList(activeItemIndex).itmLayTile = False
    For t = 0 To 15
        Call vbPicAutoRedraw(Walkstance(t), True)
    Next t
    ChDir (projectPath$)
    
    For t = 0 To 15
        For u = 0 To 1
            If itemList(activeItemIndex).theData.itmwalkGfx$(t, u) <> "" Then
                'Call openwintile(projectPath$ + tilepath$ + itemList(activeitemindex).thedata.itmwalkGfx$(t, u))
                'For x = 1 To 32
                '    For y = 1 To 32
                '        coluse = tilemem(x, y)
                '        If coluse <> -1 Then Walkstance(t).PSet (x - 1, y - 1 + u * 32), coluse
                '    Next y
                'Next x
                a = GFXdrawtile(itemList(activeItemIndex).theData.itmwalkGfx$(t, u), 1, u + 1, 0, 0, 0, vbPicHDC(Walkstance(t)), 0)
            End If
        Next u
    Next t
    For u = 0 To 1
        If itemList(activeItemIndex).theData.itmrestGfx$(u) <> "" Then
            'Call openwintile(projectPath$ + tilepath$ + itemList(activeitemindex).thedata.itmrestGfx$(u))
            'For x = 1 To 32
            '    For y = 1 To 32
            '        coluse = tilemem(x, y)
            '        If coluse <> -1 Then atrestgfx.PSet (x - 1, y - 1 + u * 32), coluse
            '    Next y
            'Next x
                a = GFXdrawtile(itemList(activeItemIndex).theData.itmrestGfx$(u), 1, u + 1, 0, 0, 0, vbPicHDC(atrestgfx), 0)
        End If
    Next u
    ChDir (currentdir$)
    
    Unload onemoment

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub openbox()
    On Error Resume Next
    ChDir (currentdir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + tilepath$
    
    dlg.strTitle = "Open Tile"
    dlg.strDefaultExt = "gph"
    dlg.strFileTypes = "Supported Files|*.gph;*.tst|RPG Toolkit Tile (*.gph)|*.gph|All files(*.*)|*.*"
    
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antipath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentdir$)
    If filename$(1) = "" Then Exit Sub
    whichtype$ = extention(filename$(1))
    If UCase$(whichtype$) = "TST" Then      'Yipes! we've selected an archive!
        tstnum = 0
        lastTileset = antipath$
        tstFile$ = antipath$
        tilesetform.Show 1
        'MsgBox setFilename$
        If setFilename$ = "" Then Exit Sub
        Call openwintile(projectPath$ + tilepath$ + setFilename$)
        selectedCharTile$ = setFilename$
    Else
        Call openwintile(filename$(1))
        selectedCharTile$ = antipath$
    End If
    If detail = 2 Or detail = 4 Or detail = 6 Then Call increasedetail
End Sub

Private Sub tool_Click(Index As Integer)
    On Error Resume Next
    selectedCharTile$ = ""
    itemList(activeItemIndex).itmLayTile = tool(0).value
    For x = 0 To 32
        For y = 0 To 32
            tilemem(x, y) = RGB(255, 255, 255)
        Next y
    Next x
End Sub

Private Sub Walkstance_MouseDown(Index As Integer, Button As Integer, Shift As Integer, x As Single, y As Single)
    On Error GoTo errorhandler
    charnum = Index
    yy = Int(y / 32)
    If itemList(activeItemIndex).itmLayTile = False Then
        Call openbox
    Else
        If selectedCharTile$ <> "" Then
            itemList(activeItemIndex).itmLayTile = False
        End If
    End If
    'Walkstance(Index).Line (0, 0)-(100, 100), vbqbcolor(15), BF
    itemList(activeItemIndex).theData.itmwalkGfx$(Index, yy) = selectedCharTile$
    For x = 1 To 32
        For y = 1 To 32
              coluse = tilemem(x, y)
              If coluse <> -1 Then
                Call vbPicPSet(Walkstance(charnum), x - 1, y - 1 + yy * 32, coluse)
              End If
        Next y
    Next x
    Call vbPicRefresh(Walkstance(Index))


    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub



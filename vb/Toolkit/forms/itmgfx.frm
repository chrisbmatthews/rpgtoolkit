VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Begin VB.Form itmgfx 
   Caption         =   "Item Graphics"
   ClientHeight    =   2430
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
   Icon            =   "itmgfx.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   2430
   ScaleWidth      =   8910
Tag = "1633"
   Begin MSComDlg.CommonDialog CMDialog1 
      Left            =   0
      Top             =   0
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.PictureBox atrestgfx 
      AutoRedraw      =   -1  'True
      BackColor       =   &H00FFFFFF&
      Height          =   495
      Left            =   6960
      ScaleHeight     =   29
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   29
      TabIndex        =   25
      Top             =   600
      Width           =   495
   End
   Begin VB.PictureBox Walkstance 
      BackColor       =   &H00FFFFFF&
      Height          =   495
      Index           =   0
      Left            =   360
      ScaleHeight     =   29
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   29
      TabIndex        =   18
      Top             =   600
      Width           =   495
   End
   Begin VB.PictureBox Walkstance 
      BackColor       =   &H00FFFFFF&
      Height          =   495
      Index           =   1
      Left            =   960
      ScaleHeight     =   29
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   29
      TabIndex        =   17
      Top             =   600
      Width           =   495
   End
   Begin VB.PictureBox Walkstance 
      BackColor       =   &H00FFFFFF&
      Height          =   495
      Index           =   2
      Left            =   1560
      ScaleHeight     =   29
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   29
      TabIndex        =   16
      Top             =   600
      Width           =   495
   End
   Begin VB.PictureBox Walkstance 
      BackColor       =   &H00FFFFFF&
      Height          =   495
      Index           =   3
      Left            =   2160
      ScaleHeight     =   29
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   29
      TabIndex        =   15
      Top             =   600
      Width           =   495
   End
   Begin VB.PictureBox Walkstance 
      BackColor       =   &H00FFFFFF&
      Height          =   495
      Index           =   4
      Left            =   3000
      ScaleHeight     =   29
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   29
      TabIndex        =   14
      Top             =   600
      Width           =   495
   End
   Begin VB.PictureBox Walkstance 
      BackColor       =   &H00FFFFFF&
      Height          =   495
      Index           =   5
      Left            =   3600
      ScaleHeight     =   29
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   29
      TabIndex        =   13
      Top             =   600
      Width           =   495
   End
   Begin VB.PictureBox Walkstance 
      BackColor       =   &H00FFFFFF&
      Height          =   495
      Index           =   6
      Left            =   4200
      ScaleHeight     =   29
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   29
      TabIndex        =   12
      Top             =   600
      Width           =   495
   End
   Begin VB.PictureBox Walkstance 
      BackColor       =   &H00FFFFFF&
      Height          =   495
      Index           =   7
      Left            =   4800
      ScaleHeight     =   29
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   29
      TabIndex        =   11
      Top             =   600
      Width           =   495
   End
   Begin VB.PictureBox Walkstance 
      BackColor       =   &H00FFFFFF&
      Height          =   495
      Index           =   8
      Left            =   360
      ScaleHeight     =   29
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   29
      TabIndex        =   10
      Top             =   1440
      Width           =   495
   End
   Begin VB.PictureBox Walkstance 
      BackColor       =   &H00FFFFFF&
      Height          =   495
      Index           =   9
      Left            =   960
      ScaleHeight     =   29
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   29
      TabIndex        =   9
      Top             =   1440
      Width           =   495
   End
   Begin VB.PictureBox Walkstance 
      BackColor       =   &H00FFFFFF&
      Height          =   495
      Index           =   10
      Left            =   1560
      ScaleHeight     =   29
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   29
      TabIndex        =   8
      Top             =   1440
      Width           =   495
   End
   Begin VB.PictureBox Walkstance 
      BackColor       =   &H00FFFFFF&
      Height          =   495
      Index           =   11
      Left            =   2160
      ScaleHeight     =   29
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   29
      TabIndex        =   7
      Top             =   1440
      Width           =   495
   End
   Begin VB.PictureBox Walkstance 
      BackColor       =   &H00FFFFFF&
      Height          =   495
      Index           =   12
      Left            =   4800
      ScaleHeight     =   29
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   29
      TabIndex        =   6
      Top             =   1440
      Width           =   495
   End
   Begin VB.PictureBox Walkstance 
      BackColor       =   &H00FFFFFF&
      Height          =   495
      Index           =   13
      Left            =   4200
      ScaleHeight     =   29
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   29
      TabIndex        =   5
      Top             =   1440
      Width           =   495
   End
   Begin VB.PictureBox Walkstance 
      BackColor       =   &H00FFFFFF&
      Height          =   495
      Index           =   14
      Left            =   3600
      ScaleHeight     =   29
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   29
      TabIndex        =   4
      Top             =   1440
      Width           =   495
   End
   Begin VB.PictureBox Walkstance 
      BackColor       =   &H00FFFFFF&
      Height          =   495
      Index           =   15
      Left            =   3000
      ScaleHeight     =   29
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   29
      TabIndex        =   3
      Top             =   1440
      Width           =   495
   End
   Begin VB.CommandButton Command1 
      Appearance      =   0  'Flat
      Caption         =   "Import Version 1.4 Animation"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   0
      TabIndex        =   2
      Top             =   2040
      Width           =   1935
Tag = "1634"
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
      Left            =   5400
      TabIndex        =   1
      Top             =   960
      Width           =   1215
Tag = "1237"
   End
   Begin VB.PictureBox walkanimate 
      AutoRedraw      =   -1  'True
      BackColor       =   &H00FFFFFF&
      Height          =   495
      Left            =   5760
      ScaleHeight     =   29
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   29
      TabIndex        =   0
      Top             =   1440
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
      Left            =   6720
      TabIndex        =   26
      Top             =   120
      Width           =   2295
Tag = "1635"
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
      TabIndex        =   24
      Top             =   120
      Width           =   3015
Tag = "1263"
   End
   Begin VB.Label Label2 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Click On A Square To Change The Graphic"
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
      Height          =   375
      Left            =   1800
      TabIndex        =   23
      Top             =   2040
      Width           =   2175
Tag = "1262"
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
      Left            =   360
      TabIndex        =   22
      Top             =   480
      Width           =   615
Tag = "1260"
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
      Left            =   360
      TabIndex        =   21
      Top             =   1320
      Width           =   615
Tag = "1259"
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
      Left            =   3000
      TabIndex        =   20
      Top             =   1320
      Width           =   615
Tag = "1258"
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
      Left            =   3000
      TabIndex        =   19
      Top             =   480
      Width           =   615
Tag = "1257"
   End
End
Attribute VB_Name = "itmgfx"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub atrestgfx_Click()
    On Error GoTo errorhandler
    If itmLayTile = False Then
        Call openbox
    Else
        itmLayTile = False
    End If
    For x = 1 To 32
        For y = 1 To 32
              itmrest(x, y) = tilemem(x, y)
              coluse = tilemem(x, y)
              If coluse <> -1 Then atrestgfx.PSet (x - 1, y - 1), coluse
        Next y
    Next x

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command1_Click()
    On Error Resume Next
    ReDim sixteenfiles$(16)
    ChDir (currentdir$)
    CMDialog1.CancelError = True
    CMDialog1.InitDir = projectPath$ + tilepath$
    CMDialog1.filename = ""
    CMDialog1.DialogTitle = "Import Version 1.4 CHA Animation"
    CMDialog1.DefaultExt = "cha"
    CMDialog1.Filter = "Toolkit 1.4 Animation (*.cha)|*.cha|All files(*.*)|*.*"
    CMDialog1.Action = 1
    If Err.number <> 32755 Then  'user pressed cancel
        filename$(1) = CMDialog1.filename
        antipath$ = CMDialog1.FileTitle
        Length = Len(antipath$)
        len2 = Len(filename$(1))
        ppathof$ = Mid$(filename$(1), 1, (len2 - Length))
    Else
        Exit Sub
    End If
    ChDir (currentdir$)
    If filename$(1) = "" Then Exit Sub
    
    'OK, Now to open up the version 1.4 CHA File and import it.
    filenum = FreeFile
    Open filename$(1) For Input As #filenum
        'The version 1.4 CHA format is just a list of 16 GPH files:
        For t = 1 To 16
            Input #filenum, sixteenfiles$(t)
        Next t
    Close #filenum

    'Now to import each of those files into our animation.
    For t = 1 To 16
        Call openwintile(ppathof$ + sixteenfiles$(t))
        If detail = 2 Then Call increasedetail: yaya = 1
        For x = 1 To 32
            For y = 1 To 32
                'MsgBox Str$(tilemem(x, y))
                itmwalk(x, y, t) = tilemem(x, y)
                If itmwalk(x, y, t) = 0 And yaya = 1 Then itmwalk(x, y, t) = -1
                coluse = itmwalk(x, y, t)
                If coluse = -1 Then coluse = QBColor(15)
                Walkstance(t - 1).PSet (x - 1, y - 1), coluse
            Next y
        Next x
    Next t
    yaya = 0

End Sub

Private Sub Command2_Click()
    On Error GoTo errorhandler
    For cycle = 1 To 4
    For loops = 1 To 4
        For t = 1 To 4
            walkanimate.AutoRedraw = True
            For x = 1 To 32
                For y = 1 To 32
                    coluse = itmwalk(x, y, (cycle * 4 - 4) + t)
                    If coluse = -1 Then coluse = QBColor(15)
                    walkanimate.PSet (x - 1, y - 1), coluse
                Next y
            Next x
            ll = Timer
            Do While Timer - ll < 0.05
            Loop
            walkanimate.AutoRedraw = False
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
        If lastTileset$ = "" Then
            Call openbox
            Exit Sub
        End If
        If lastTileset$ <> "" Then
            tstFile$ = lastTileset$
            tilesetform.Show 1
            'MsgBox setFilename$
            Call openwintile(projectPath$ + tilepath$ + setFilename$)
            itmLayTile = True
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
    onemoment.Show
    For t = 0 To 15
        Walkstance(t).AutoRedraw = True
    Next t
    For t = 1 To 16
        For x = 1 To 32
            For y = 1 To 32
                coluse = itmwalk(x, y, t)
                If coluse <> -1 Then Walkstance(t - 1).PSet (x - 1, y - 1), coluse
            Next y
        Next x
    Next t
    For x = 1 To 32
        For y = 1 To 32
            coluse = itmrest(x, y)
            If coluse <> -1 Then atrestgfx.PSet (x - 1, y - 1), coluse
        Next y
    Next x
    onemoment.Hide

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub openbox()
    On Error Resume Next
    ChDir (currentdir$)
    CMDialog1.CancelError = True
    CMDialog1.InitDir = projectPath$ + tilepath$
    CMDialog1.filename = ""
    CMDialog1.DialogTitle = "Open Tile"
    CMDialog1.DefaultExt = "gph"
    CMDialog1.Filter = "Supported Files|*.gph;*.tst|RPG Toolkit Tile (*.gph)|*.gph|All files(*.*)|*.*"
    CMDialog1.Action = 1
    If Err.number <> 32755 Then  'user pressed cancel
        filename$(1) = CMDialog1.filename
        antipath$ = CMDialog1.FileTitle
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
        Call openwintile(projectPath$ + tilepath$ + setFilename$)
    Else
        Call openwintile(filename$(1))
    End If
    If detail = 2 Or detail = 4 Or detail = 6 Then Call increasedetail
End Sub

Private Sub Walkstance_Click(Index As Integer)
    On Error GoTo errorhandler
    Walkstance(Index).ScaleMode = 3
    charnum = Index
    If itmLayTile = False Then
        Call openbox
    Else
        itmLayTile = False
    End If
    For x = 1 To 32
        For y = 1 To 32
              itmwalk(x, y, charnum + 1) = tilemem(x, y)
              coluse = tilemem(x, y)
              If coluse <> -1 Then Walkstance(charnum).PSet (x - 1, y - 1), coluse
        Next y
    Next x


    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


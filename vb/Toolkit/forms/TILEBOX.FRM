VERSION 5.00
Begin VB.Form tilebox 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Tile Selection (tile edit)"
   ClientHeight    =   1845
   ClientLeft      =   1080
   ClientTop       =   1470
   ClientWidth     =   3345
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
   Icon            =   "TILEBOX.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   1845
   ScaleWidth      =   3345
   StartUpPosition =   1  'CenterOwner
   Tag             =   "1831"
   Begin VB.CommandButton Command2 
      Appearance      =   0  'Flat
      Caption         =   "Rename"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   345
      Left            =   1920
      TabIndex        =   3
      Tag             =   "1832"
      Top             =   1320
      Width           =   1095
   End
   Begin VB.CommandButton Command1 
      Appearance      =   0  'Flat
      Caption         =   "Open"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   345
      Left            =   1920
      TabIndex        =   2
      Tag             =   "1350"
      Top             =   840
      Width           =   1095
   End
   Begin VB.PictureBox browse 
      AutoRedraw      =   -1  'True
      BackColor       =   &H00FFFFFF&
      Height          =   615
      Left            =   1920
      ScaleHeight     =   37
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   37
      TabIndex        =   1
      Top             =   120
      Width           =   615
   End
   Begin VB.FileListBox files 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1650
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   1815
   End
End
Attribute VB_Name = "tilebox"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Command1_Click()
    On Error Resume Next
    f$ = files.filename
    t$ = nopath(f$)
    
    Call opentile2(projectPath$ + tilepath$ + f$)
    tilename$ = t$
    activeTile.caption = LoadStringLoc(801, "Tile Editor") + "  (" + t$ + ")"
    If detail = 1 Or detail = 3 Or detail = 5 Then Call activeTile.highredraw
    If detail = 2 Or detail = 4 Or detail = 6 Then Call activeTile.lowredraw
    Unload tilebox
End Sub

Private Sub Command2_Click()
    On Error GoTo errorhandler
    f$ = files.filename
    t$ = nopath(f$)
    
    Call renameFile(t$)


    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub files_Click()
    On Error Resume Next
    f$ = files.filename
    t$ = nopath(f$)
    
    For x = 1 To 32
        For y = 1 To 32
            buftile(x, y) = tilemem(x, y)
        Next y
    Next x
    Call opentile2(projectPath$ + tilepath$ + f$)
    Call vbPicFillRect(browse, 0, 0, 100, 100, vbQBColor(15))
    If detail = 1 Or detail = 3 Or detail = 5 Then
        For x = 0 To 31
            For y = 0 To 31
                col = tilemem(x + 1, y + 1)
                If col = -1 Then col = vbQBColor(15)
                Call vbPicPSet(browse, x, y, col)
            Next y
        Next x
    Else
        For x = 0 To 15
            For y = 0 To 15
                col = tilemem(x + 1, y + 1)
                If col = -1 Then col = vbQBColor(15)
                Call vbPicFillRect(browse, x * 2, y * 2, x * 2 + 2, y * 2 + 2, col)
            Next y
        Next x
    End If
    For x = 1 To 32
        For y = 1 To 32
            tilemem(x, y) = buftile(x, y)
        Next y
    Next x
    browse.Refresh

End Sub

Private Sub Form_Load()
    On Error GoTo errorhandler
    Call LocalizeForm(Me)
    
    files.path = projectPath$ + tilepath$
    files.Pattern = "*.gph"

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


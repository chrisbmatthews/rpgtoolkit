VERSION 5.00
Begin VB.Form brdbackground 
   Appearance      =   0  'Flat
   BackColor       =   &H80000005&
   BorderStyle     =   0  'None
   Caption         =   "Board Backgrounds"
   ClientHeight    =   1815
   ClientLeft      =   1860
   ClientTop       =   1785
   ClientWidth     =   7215
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
   Icon            =   "BRDBACKG.frx":0000
   LinkTopic       =   "Form2"
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   1815
   ScaleWidth      =   7215
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Tag             =   "1079"
   Begin Toolkit.TKButton Command3 
      Height          =   375
      Left            =   6240
      TabIndex        =   8
      Top             =   600
      Width           =   855
      _ExtentX        =   1508
      _ExtentY        =   661
      Object.Width           =   360
      Caption         =   "OK"
   End
   Begin VB.PictureBox command16 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   375
      Left            =   2640
      MousePointer    =   99  'Custom
      Picture         =   "BRDBACKG.frx":0CCA
      ScaleHeight     =   375
      ScaleWidth      =   615
      TabIndex        =   6
      Top             =   1000
      Width           =   615
   End
   Begin Toolkit.TKTopBar TopBar 
      Height          =   480
      Left            =   0
      TabIndex        =   5
      Top             =   0
      Width           =   4215
      _ExtentX        =   7435
      _ExtentY        =   847
      Object.Width           =   4215
      Caption         =   "Board Background"
   End
   Begin VB.Frame Frame3 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Board Color"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   1215
      Left            =   3600
      TabIndex        =   3
      Tag             =   "1083"
      Top             =   480
      Width           =   2535
      Begin Toolkit.TKButton command1 
         Height          =   375
         Left            =   600
         TabIndex        =   7
         Top             =   480
         Width           =   1815
         _ExtentX        =   3201
         _ExtentY        =   661
         Object.Width           =   360
         Caption         =   "Select Color"
      End
      Begin VB.PictureBox Picture1 
         Appearance      =   0  'Flat
         AutoRedraw      =   -1  'True
         BackColor       =   &H80000005&
         ForeColor       =   &H80000008&
         Height          =   375
         Left            =   120
         ScaleHeight     =   345
         ScaleWidth      =   345
         TabIndex        =   4
         Top             =   480
         Width           =   375
      End
   End
   Begin VB.Frame Frame1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Board Bitmap"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   1215
      Left            =   120
      TabIndex        =   0
      Tag             =   "1085"
      Top             =   480
      Width           =   3375
      Begin VB.TextBox brdbmpname 
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Left            =   120
         TabIndex        =   1
         Top             =   600
         Width           =   2295
      End
      Begin VB.Label Label2 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
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
         ForeColor       =   &H80000008&
         Height          =   255
         Index           =   0
         Left            =   120
         TabIndex        =   2
         Tag             =   "1013"
         Top             =   360
         Width           =   1215
      End
   End
   Begin VB.Shape Shape1 
      Height          =   1815
      Left            =   0
      Top             =   0
      Width           =   7215
   End
End
Attribute VB_Name = "brdbackground"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984

Private Sub borderselect_Click()

End Sub

Private Sub brdbmpfilename_Click()
End Sub

Private Sub borderbmpname_Change()
    On Error Resume Next
    boardList(activeBoardIndex).theData.borderBack$ = borderbmpname.Text
End Sub

Private Sub brdbmpname_Change()
    On Error Resume Next
    boardList(activeBoardIndex).theData.brdBack$ = brdbmpname.Text
End Sub

Private Sub Command1_Click()
    On Error GoTo ErrorHandler
    boardList(activeBoardIndex).theData.brdColor = ColorDialog()
    Call vbPicFillRect(Picture1, 0, 0, 1000, 1000, brdColor)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    'Call HandleError
    Resume Next
End Sub

Private Sub Command16_Click()
On Error Resume Next
    Dim dlg As FileDialogInfo
    ChDir (currentDir$)
    dlg.strDefaultFolder = projectPath$ + bmpPath$
    dlg.strTitle = "Open Bitmap"
    dlg.strDefaultExt = "bmp"
    dlg.strFileTypes = strFileDialogFilterGfx
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + bmpPath$ + antiPath$
    thextention$ = extention(filename$(1))
   ' If UCase$(thextention$) = "GIF" Then
   '     dummy = GifToBMP(Filename$(1), "rpgscrtc.bmp")
   '     Filename$(1) = "rpgscrtc.bmp"
   ' End If
    boardList(activeBoardIndex).theData.brdBack$ = antiPath$
    brdbmpname.Text = antiPath$
End Sub

Private Sub Command3_Click()
    On Error GoTo ErrorHandler
    boardNeedUpdate = True
    Unload brdbackground

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command4_Click()
On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + bmpPath$
    dlg.strTitle = "Open Graphic"
    dlg.strDefaultExt = "bmp"
    dlg.strFileTypes = strFileDialogFilterGfx
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + bmpPath$ + antiPath$
    thextention$ = extention(filename$(1))
   ' If UCase$(thextention$) = "GIF" Then
   '     dummy = GifToBMP(Filename$(1), "rpgscrtc.bmp")
   '     Filename$(1) = "rpgscrtc.bmp"
   ' End If
    boardList(activeBoardIndex).theData.borderBack$ = antiPath$
    borderbmpname.Text = antiPath$
End Sub

Private Sub Form_Activate()
    On Error GoTo ErrorHandler
If boardList(activeBoardIndex).theData.brdBack$ <> "" Then brdbmpname.Text = boardList(activeBoardIndex).theData.brdBack$
If boardList(activeBoardIndex).theData.borderBack$ <> "" Then borderbmpname.Text = boardList(activeBoardIndex).theData.borderBack$


    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Form_Load()
    On Error GoTo ErrorHandler
    Call LocalizeForm(Me)

    If boardList(activeBoardIndex).theData.brdBack$ <> "" Then brdbmpname.Text = boardList(activeBoardIndex).theData.brdBack$
    Call vbPicFillRect(Picture1, 0, 0, 1000, 1000, boardList(activeBoardIndex).theData.brdColor)
    Set TopBar.theForm = Me
    command16.MouseIcon = Images.MouseLink()
    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub


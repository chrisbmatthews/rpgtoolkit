VERSION 5.00
Begin VB.Form brdbackground 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Board Backgrounds"
   ClientHeight    =   1560
   ClientLeft      =   1905
   ClientTop       =   2115
   ClientWidth     =   8070
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
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   1560
   ScaleWidth      =   8070
   StartUpPosition =   1  'CenterOwner
   Tag             =   "1079"
   Begin VB.Frame Frame3 
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
      Height          =   1215
      Left            =   4080
      TabIndex        =   5
      Tag             =   "1083"
      Top             =   120
      Width           =   2535
      Begin VB.PictureBox Picture1 
         AutoRedraw      =   -1  'True
         BackColor       =   &H00FFFFFF&
         Height          =   495
         Left            =   120
         ScaleHeight     =   435
         ScaleWidth      =   315
         TabIndex        =   7
         Top             =   360
         Width           =   375
      End
      Begin VB.CommandButton Command1 
         Appearance      =   0  'Flat
         Caption         =   "Select Color"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Left            =   600
         TabIndex        =   6
         Tag             =   "1080"
         Top             =   360
         Width           =   1335
      End
   End
   Begin VB.Frame Frame1 
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
      Height          =   1215
      Left            =   120
      TabIndex        =   1
      Tag             =   "1085"
      Top             =   120
      Width           =   3735
      Begin VB.CommandButton Command16 
         Caption         =   "Browse..."
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
         Left            =   2520
         TabIndex        =   3
         Tag             =   "1021"
         Top             =   600
         Width           =   1095
      End
      Begin VB.TextBox brdbmpname 
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
         TabIndex        =   2
         Top             =   600
         Width           =   2295
      End
      Begin VB.Image Image1 
         Appearance      =   0  'Flat
         Height          =   270
         Left            =   2520
         Picture         =   "BRDBACKG.frx":0CCA
         Top             =   240
         Width           =   375
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
         TabIndex        =   4
         Tag             =   "1013"
         Top             =   360
         Width           =   1215
      End
   End
   Begin VB.CommandButton Command3 
      Appearance      =   0  'Flat
      Caption         =   "OK"
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
      Left            =   6840
      TabIndex        =   0
      Tag             =   "1022"
      Top             =   240
      Width           =   1095
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
    boardList(activeBoardIndex).theData.borderBack$ = borderbmpname.text
End Sub

Private Sub brdbmpname_Change()
    On Error Resume Next
    boardList(activeBoardIndex).theData.brdBack$ = brdbmpname.text
End Sub

Private Sub Command1_Click()
    On Error GoTo errorhandler
    boardList(activeBoardIndex).theData.brdColor = ColorDialog()
    Call vbPicFillRect(Picture1, 0, 0, 1000, 1000, brdColor)

    Exit Sub
'Begin error handling code:
errorhandler:
    'Call HandleError
    Resume Next
End Sub

Private Sub Command16_Click()
On Error Resume Next
    Dim dlg As FileDialogInfo
    ChDir (currentdir$)
    dlg.strDefaultFolder = projectPath$ + bmppath$
    dlg.strTitle = "Open Bitmap"
    dlg.strDefaultExt = "bmp"
    dlg.strFileTypes = strFileDialogFilterGfx
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentdir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + bmppath$ + antiPath$
    thextention$ = extention(filename$(1))
   ' If UCase$(thextention$) = "GIF" Then
   '     dummy = GifToBMP(Filename$(1), "rpgscrtc.bmp")
   '     Filename$(1) = "rpgscrtc.bmp"
   ' End If
    boardList(activeBoardIndex).theData.brdBack$ = antiPath$
    brdbmpname.text = antiPath$
End Sub

Private Sub Command3_Click()
    On Error GoTo errorhandler
    boardNeedUpdate = True
    Unload brdbackground

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command4_Click()
On Error Resume Next
    ChDir (currentdir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + bmppath$
    dlg.strTitle = "Open Graphic"
    dlg.strDefaultExt = "bmp"
    dlg.strFileTypes = strFileDialogFilterGfx
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentdir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + bmppath$ + antiPath$
    thextention$ = extention(filename$(1))
   ' If UCase$(thextention$) = "GIF" Then
   '     dummy = GifToBMP(Filename$(1), "rpgscrtc.bmp")
   '     Filename$(1) = "rpgscrtc.bmp"
   ' End If
    boardList(activeBoardIndex).theData.borderBack$ = antiPath$
    borderbmpname.text = antiPath$
End Sub

Private Sub Form_Activate()
    On Error GoTo errorhandler
If boardList(activeBoardIndex).theData.brdBack$ <> "" Then brdbmpname.text = boardList(activeBoardIndex).theData.brdBack$
If boardList(activeBoardIndex).theData.borderBack$ <> "" Then borderbmpname.text = boardList(activeBoardIndex).theData.borderBack$


    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Form_Load()
    On Error GoTo errorhandler
    Call LocalizeForm(Me)

    If boardList(activeBoardIndex).theData.brdBack$ <> "" Then brdbmpname.text = boardList(activeBoardIndex).theData.brdBack$
    Call vbPicFillRect(Picture1, 0, 0, 1000, 1000, boardList(activeBoardIndex).theData.brdColor)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


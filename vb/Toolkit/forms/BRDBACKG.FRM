VERSION 5.00
Begin VB.Form brdbackground 
   Appearance      =   0  'Flat
   BackColor       =   &H80000005&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Board Backgrounds"
   ClientHeight    =   1815
   ClientLeft      =   1905
   ClientTop       =   2220
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
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   1815
   ScaleWidth      =   7215
   StartUpPosition =   1  'CenterOwner
   Tag             =   "1079"
   Begin VB.CommandButton cmdOK 
      Caption         =   "OK"
      Default         =   -1  'True
      Height          =   375
      Left            =   6240
      TabIndex        =   5
      Top             =   600
      Width           =   855
   End
   Begin VB.Frame brdColour 
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
      Top             =   240
      Width           =   2535
      Begin VB.PictureBox Picture1 
         BackColor       =   &H80000009&
         BorderStyle     =   0  'None
         Height          =   375
         Left            =   720
         ScaleHeight     =   375
         ScaleWidth      =   1695
         TabIndex        =   6
         Top             =   480
         Width           =   1695
         Begin VB.CommandButton cmdSelectColor 
            Caption         =   "Select Color"
            Height          =   375
            Left            =   0
            TabIndex        =   7
            Top             =   0
            Width           =   1695
         End
      End
      Begin VB.PictureBox picBoardColor 
         Appearance      =   0  'Flat
         AutoRedraw      =   -1  'True
         BackColor       =   &H80000005&
         ForeColor       =   &H80000008&
         Height          =   375
         Left            =   240
         ScaleHeight     =   345
         ScaleWidth      =   345
         TabIndex        =   4
         Top             =   480
         Width           =   375
      End
   End
   Begin VB.Frame brdBitmap 
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
      Top             =   240
      Width           =   3375
      Begin VB.PictureBox Picture2 
         BackColor       =   &H80000009&
         BorderStyle     =   0  'None
         Height          =   255
         Left            =   2640
         ScaleHeight     =   255
         ScaleWidth      =   495
         TabIndex        =   8
         Top             =   600
         Width           =   495
         Begin VB.CommandButton cmdChangeBoardBitmap 
            Caption         =   "..."
            Height          =   255
            Left            =   0
            TabIndex        =   9
            Top             =   0
            Width           =   495
         End
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
         Left            =   240
         TabIndex        =   1
         Top             =   600
         Width           =   2295
      End
      Begin VB.Label brdBitmapFilename 
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
         Left            =   240
         TabIndex        =   2
         Tag             =   "1013"
         Top             =   360
         Width           =   1215
      End
   End
End
Attribute VB_Name = "brdbackground"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'==============================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'==============================================================================

Option Explicit

'==============================================================================
'Change the board bitmap text field.
'==============================================================================
Private Sub brdbmpname_Change(): On Error Resume Next

    boardList(activeBoardIndex).theData.brdBack = brdbmpname.Text
    
    'Destroy the old image canvas, reset the pointer.
    If boardList(activeBoardIndex).theData.brdBackCNV <> 0 Then
        Call destroyCanvas(boardList(activeBoardIndex).theData.brdBackCNV)
        boardList(activeBoardIndex).theData.brdBackCNV = 0
    End If
    
End Sub

'==============================================================================
'"Select color" - Change the board background colour.
'==============================================================================
Private Sub cmdSelectColor_Click(): On Error Resume Next
    boardList(activeBoardIndex).theData.brdColor = ColorDialog()
    Call vbPicFillRect(picBoardColor, 0, 0, 1000, 1000, boardList(activeBoardIndex).theData.brdColor)
End Sub

'==============================================================================
'Change the board background bitmap.
'==============================================================================
Private Sub cmdChangeBoardBitmap_Click(): On Error Resume Next

    ChDir (currentDir)

    Dim dlg As FileDialogInfo, antiPath As String
    dlg.strDefaultFolder = projectPath & bmpPath
    dlg.strTitle = "Open Bitmap"
    dlg.strDefaultExt = "bmp"
    dlg.strFileTypes = strFileDialogFilterGfx
    
    If OpenFileDialog(dlg, Me.hwnd) Then
        filename(1) = dlg.strSelectedFile
        antiPath = dlg.strSelectedFileNoPath
    Else
        Exit Sub    'User pressed cancel.
    End If
    ChDir (currentDir)
    
    If dlg.strSelectedFile = "" Then Exit Sub
    
    FileCopy dlg.strSelectedFile, projectPath & bmpPath & antiPath
   
    boardList(activeBoardIndex).theData.brdBack = antiPath
    
    'Destroy the old image canvas, reset the pointer.
    If boardList(activeBoardIndex).theData.brdBackCNV <> 0 Then
        Call destroyCanvas(boardList(activeBoardIndex).theData.brdBackCNV)
        boardList(activeBoardIndex).theData.brdBackCNV = 0
    End If
    
    brdbmpname.Text = antiPath
    
End Sub

'==============================================================================
'OK = exit.
'==============================================================================
Private Sub cmdOK_Click(): On Error Resume Next
    boardList(activeBoardIndex).boardNeedUpdate = True
    Unload brdbackground
End Sub

Private Sub Form_Activate(): On Error Resume Next
    'Refill data.
    brdbmpname.Text = boardList(activeBoardIndex).theData.brdBack
End Sub

Private Sub Form_Load(): On Error Resume Next

    ' Call LocalizeForm(Me)

    'Set data.
    brdbmpname.Text = boardList(activeBoardIndex).theData.brdBack
    Call vbPicFillRect(picBoardColor, 0, 0, 1000, 1000, boardList(activeBoardIndex).theData.brdColor)
    
    cmdChangeBoardBitmap.MouseIcon = Images.MouseLink()
       
End Sub

Private Sub Form_Unload(Cancel As Integer): On Error Resume Next
    'Redraw the board when we leave.
    Call activeBoard.boardRedraw
End Sub

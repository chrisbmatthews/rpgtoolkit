VERSION 5.00
Begin VB.Form BoardDayNightForm 
   Appearance      =   0  'Flat
   BackColor       =   &H80000005&
   BorderStyle     =   0  'None
   Caption         =   "Board Night Fighting Options"
   ClientHeight    =   3015
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   6375
   Icon            =   "BoardDayNightForm.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3015
   ScaleWidth      =   6375
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Tag             =   "1860"
   Begin Toolkit.TKTopBar TopBar 
      Height          =   480
      Left            =   0
      TabIndex        =   10
      Top             =   0
      Width           =   3375
      _ExtentX        =   5953
      _ExtentY        =   847
      Object.Width           =   3375
      Caption         =   "Night Fighting Options"
   End
   Begin Toolkit.TKButton Command1 
      Height          =   495
      Left            =   5160
      TabIndex        =   8
      Top             =   480
      Width           =   1095
      _ExtentX        =   661
      _ExtentY        =   873
      Object.Width           =   360
      Caption         =   "OK"
   End
   Begin VB.Frame Frame1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   2535
      Left            =   120
      TabIndex        =   0
      Tag             =   "1862"
      Top             =   360
      Width           =   4935
      Begin VB.PictureBox command5 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   375
         Left            =   3960
         Picture         =   "BoardDayNightForm.frx":0CCA
         ScaleHeight     =   375
         ScaleWidth      =   615
         TabIndex        =   9
         Top             =   1490
         Width           =   615
      End
      Begin VB.TextBox Text1 
         Appearance      =   0  'Flat
         Height          =   285
         Left            =   1800
         TabIndex        =   6
         Top             =   1560
         Width           =   2055
      End
      Begin VB.TextBox skillbox 
         Appearance      =   0  'Flat
         Height          =   285
         Left            =   1800
         TabIndex        =   2
         Text            =   "1"
         Top             =   840
         Width           =   2055
      End
      Begin VB.CheckBox fyes 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "When night falls, use custom battle options"
         ForeColor       =   &H80000008&
         Height          =   495
         Left            =   120
         TabIndex        =   1
         Tag             =   "1861"
         Top             =   240
         Width           =   4335
      End
      Begin VB.Label Label5 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "Also see Background Editor"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   -1  'True
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   495
         Index           =   1
         Left            =   2280
         MouseIcon       =   "BoardDayNightForm.frx":12B4
         MousePointer    =   99  'Custom
         TabIndex        =   7
         Tag             =   "1056"
         Top             =   1920
         Visible         =   0   'False
         Width           =   2295
      End
      Begin VB.Label Label3 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "Also see Enemy Info"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   -1  'True
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   255
         Index           =   2
         Left            =   2280
         MouseIcon       =   "BoardDayNightForm.frx":15BE
         MousePointer    =   99  'Custom
         TabIndex        =   4
         Tag             =   "1055"
         Top             =   1200
         Visible         =   0   'False
         Width           =   2415
      End
      Begin VB.Label Label1 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "Background:"
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   120
         TabIndex        =   5
         Tag             =   "1053"
         Top             =   1560
         Width           =   1455
      End
      Begin VB.Label Label3 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "Board Skill:"
         ForeColor       =   &H80000008&
         Height          =   255
         Index           =   0
         Left            =   120
         TabIndex        =   3
         Tag             =   "1054"
         Top             =   840
         Width           =   1215
      End
   End
   Begin VB.Shape Shape1 
      Height          =   3015
      Left            =   0
      Top             =   0
      Width           =   6375
   End
End
Attribute VB_Name = "BoardDayNightForm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

Option Explicit

Sub infoFill()
    On Error GoTo ErrorHandler

    fyes.value = boardList(activeBoardIndex).theData.BoardNightBattleOverride
    If boardList(activeBoardIndex).theData.BoardNightBattleOverride = 0 Then
        'fyes.Value = 0
        Label3(0).Enabled = 0
        Command5.Enabled = 0
        skillbox.Enabled = 0
        Label1.Enabled = False
        Text1.Enabled = False
    Else
        'fyes.Value = 1
        Label3(0).Enabled = 1
        Command5.Enabled = 1
        skillbox.Enabled = 1
        Label1.Enabled = True
        Text1.Enabled = True
    End If

    skillbox.Text = str$(boardList(activeBoardIndex).theData.BoardSkillNight)
    If boardList(activeBoardIndex).theData.BoardBackgroundNight$ <> "" Then
        Text1.Text = boardList(activeBoardIndex).theData.BoardBackgroundNight$
    End If

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub


Private Sub Command1_Click()
    Unload BoardDayNightForm
End Sub

Private Sub Command5_Click()
    On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    Dim antiPath As String
    dlg.strDefaultFolder = projectPath$ + bkgPath$
    dlg.strTitle = "Board Background"
    dlg.strDefaultExt = "bkg"
    dlg.strFileTypes = "Supported Files|*.bkg|RPG Toolkit Background (*.bkg)|*.bkg|All files(*.*)|*.*"
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + bkgPath$ + antiPath$
    boardList(activeBoardIndex).theData.BoardBackgroundNight$ = antiPath$
    Text1.Text = antiPath$
End Sub

Private Sub Form_Load()
    Call LocalizeForm(Me)
    Call infoFill
    Command5.MousePointer = 99
    Command5.MouseIcon = Images.MouseLink
    Set TopBar.theForm = Me
End Sub

Private Sub fyes_Click()
    On Error GoTo ErrorHandler
    boardList(activeBoardIndex).theData.BoardNightBattleOverride = fyes.value
    If boardList(activeBoardIndex).theData.BoardNightBattleOverride = 0 Then
        'fyes.Value = 0
        Label3(0).Enabled = 0
        Command5.Enabled = 0
        skillbox.Enabled = 0
        Label1.Enabled = False
        Text1.Enabled = False
    Else
        'fyes.Value = 1
        Label3(0).Enabled = 1
        Command5.Enabled = 1
        skillbox.Enabled = 1
        Label1.Enabled = True
        Text1.Enabled = True
    End If


    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Label3_Click(Index As Integer)
    On Error GoTo ErrorHandler
    If Index = 2 Then mainfight.Show

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Label5_Click(Index As Integer)
    On Error GoTo ErrorHandler
    If Index = 1 Then editBackground.Show

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub


Private Sub skillbox_Change()
    On Error GoTo ErrorHandler
    
    boardList(activeBoardIndex).theData.BoardSkillNight = val(skillbox.Text)
    
    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub


Private Sub Text1_Change()
    boardList(activeBoardIndex).theData.BoardBackgroundNight$ = Text1.Text
End Sub



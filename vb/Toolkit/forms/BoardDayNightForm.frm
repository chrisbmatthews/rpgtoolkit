VERSION 5.00
Begin VB.Form BoardDayNightForm 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Board Night Fighting Options"
   ClientHeight    =   2790
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   6375
   Icon            =   "BoardDayNightForm.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2790
   ScaleWidth      =   6375
   StartUpPosition =   2  'CenterScreen
   Tag             =   "1860"
   Begin VB.CommandButton Command1 
      Caption         =   "OK"
      Default         =   -1  'True
      Height          =   375
      Left            =   5160
      TabIndex        =   1
      Top             =   240
      Width           =   1095
   End
   Begin VB.Frame Frame1 
      Height          =   2535
      Left            =   120
      TabIndex        =   0
      Tag             =   "1862"
      Top             =   120
      Width           =   4935
      Begin VB.PictureBox Picture1 
         BorderStyle     =   0  'None
         Height          =   2175
         Left            =   120
         ScaleHeight     =   2175
         ScaleWidth      =   4695
         TabIndex        =   2
         Top             =   240
         Width           =   4695
         Begin VB.CommandButton Command5 
            Caption         =   ".."
            Height          =   285
            Left            =   3840
            TabIndex        =   8
            Top             =   1320
            Width           =   615
         End
         Begin VB.CheckBox fyes 
            Caption         =   "When night falls, use custom battle options"
            Height          =   495
            Left            =   0
            TabIndex        =   5
            Tag             =   "1861"
            Top             =   0
            Width           =   4335
         End
         Begin VB.TextBox skillbox 
            Height          =   285
            Left            =   1680
            TabIndex        =   4
            Text            =   "1"
            Top             =   600
            Width           =   2055
         End
         Begin VB.TextBox Text1 
            Height          =   285
            Left            =   1680
            TabIndex        =   3
            Top             =   1320
            Width           =   2055
         End
         Begin VB.Label Label3 
            Caption         =   "Board Skill:"
            Height          =   255
            Index           =   0
            Left            =   0
            TabIndex        =   7
            Tag             =   "1054"
            Top             =   600
            Width           =   1215
         End
         Begin VB.Label Label1 
            Caption         =   "Background:"
            Height          =   255
            Left            =   0
            TabIndex        =   6
            Tag             =   "1053"
            Top             =   1320
            Width           =   1455
         End
      End
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

Sub infofill()
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
    Call infofill
    Command5.MousePointer = 99
    Command5.MouseIcon = Images.MouseLink
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



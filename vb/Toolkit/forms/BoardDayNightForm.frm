VERSION 5.00
Begin VB.Form BoardDayNightForm 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Board Night Fighting Options"
   ClientHeight    =   2850
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   6555
   Icon            =   "BoardDayNightForm.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2850
   ScaleWidth      =   6555
   StartUpPosition =   1  'CenterOwner
   Tag             =   "1860"
   Begin VB.CommandButton Command1 
      Appearance      =   0  'Flat
      Caption         =   "OK"
      Height          =   345
      Left            =   5280
      TabIndex        =   9
      Tag             =   "1022"
      Top             =   240
      Width           =   1095
   End
   Begin VB.Frame Frame1 
      Caption         =   "Night Battle Options"
      Height          =   2535
      Left            =   120
      TabIndex        =   0
      Tag             =   "1862"
      Top             =   120
      Width           =   4935
      Begin VB.CommandButton Command5 
         Appearance      =   0  'Flat
         Caption         =   "Browse..."
         Height          =   345
         Left            =   3720
         TabIndex        =   7
         Tag             =   "1021"
         Top             =   1560
         Width           =   1095
      End
      Begin VB.TextBox Text1 
         Height          =   285
         Left            =   1800
         TabIndex        =   6
         Top             =   1560
         Width           =   1815
      End
      Begin VB.TextBox skillbox 
         Height          =   285
         Left            =   1800
         TabIndex        =   2
         Text            =   "1"
         Top             =   840
         Width           =   1815
      End
      Begin VB.CheckBox fyes 
         Caption         =   "When night falls, use custom battle options"
         Height          =   495
         Left            =   120
         TabIndex        =   1
         Tag             =   "1861"
         Top             =   360
         Width           =   4335
      End
      Begin VB.Label Label5 
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
         ForeColor       =   &H00FF0000&
         Height          =   495
         Index           =   1
         Left            =   2280
         MouseIcon       =   "BoardDayNightForm.frx":0CCA
         MousePointer    =   99  'Custom
         TabIndex        =   8
         Tag             =   "1056"
         Top             =   1920
         Visible         =   0   'False
         Width           =   2295
      End
      Begin VB.Label Label3 
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
         ForeColor       =   &H00FF0000&
         Height          =   255
         Index           =   2
         Left            =   2280
         MouseIcon       =   "BoardDayNightForm.frx":0FD4
         MousePointer    =   99  'Custom
         TabIndex        =   4
         Tag             =   "1055"
         Top             =   1200
         Visible         =   0   'False
         Width           =   2415
      End
      Begin VB.Label Label1 
         Caption         =   "Background:"
         Height          =   255
         Left            =   120
         TabIndex        =   5
         Tag             =   "1053"
         Top             =   1560
         Width           =   1455
      End
      Begin VB.Label Label3 
         Caption         =   "Board Skill:"
         Height          =   255
         Index           =   0
         Left            =   120
         TabIndex        =   3
         Tag             =   "1054"
         Top             =   840
         Width           =   1215
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
    On Error GoTo errorhandler

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

    skillbox.text = str$(boardList(activeBoardIndex).theData.BoardSkillNight)
    If boardList(activeBoardIndex).theData.BoardBackgroundNight$ <> "" Then
        Text1.text = boardList(activeBoardIndex).theData.BoardBackgroundNight$
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Private Sub Command1_Click()
    Unload BoardDayNightForm
End Sub

Private Sub Command5_Click()
    On Error Resume Next
    ChDir (currentdir$)
    Dim dlg As FileDialogInfo
    Dim antiPath As String
    dlg.strDefaultFolder = projectPath$ + bkgpath$
    dlg.strTitle = "Board Background"
    dlg.strDefaultExt = "bkg"
    dlg.strFileTypes = "Supported Files|*.bkg|RPG Toolkit Background (*.bkg)|*.bkg|All files(*.*)|*.*"
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentdir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + bkgpath$ + antiPath$
    boardList(activeBoardIndex).theData.BoardBackgroundNight$ = antiPath$
    Text1.text = antiPath$
End Sub


Private Sub Form_Load()
    Call LocalizeForm(Me)
    Call infofill
End Sub

Private Sub fyes_Click()
    On Error GoTo errorhandler
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
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Label3_Click(Index As Integer)
    On Error GoTo errorhandler
    If Index = 2 Then mainfight.Show

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Label5_Click(Index As Integer)
    On Error GoTo errorhandler
    If Index = 1 Then editBackground.Show

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Private Sub skillbox_Change()
    On Error GoTo errorhandler
    
    boardList(activeBoardIndex).theData.BoardSkillNight = val(skillbox.text)
    
    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Private Sub Text1_Change()
    boardList(activeBoardIndex).theData.BoardBackgroundNight$ = Text1.text
End Sub



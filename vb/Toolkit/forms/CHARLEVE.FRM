VERSION 5.00
Begin VB.Form charlevels 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Character Levels"
   ClientHeight    =   5730
   ClientLeft      =   2670
   ClientTop       =   1815
   ClientWidth     =   5805
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
   Icon            =   "CHARLEVE.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5730
   ScaleWidth      =   5805
   StartUpPosition =   1  'CenterOwner
   Tag             =   "1594"
   Begin VB.PictureBox Picture2 
      BorderStyle     =   0  'None
      Height          =   855
      Left            =   240
      ScaleHeight     =   855
      ScaleWidth      =   3975
      TabIndex        =   25
      Top             =   1680
      Width           =   3975
      Begin VB.OptionButton Option2 
         Caption         =   "Linear"
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
         Left            =   240
         TabIndex        =   28
         Tag             =   "1601"
         Top             =   480
         Width           =   1575
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Exponential"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   240
         TabIndex        =   27
         Tag             =   "1600"
         Top             =   240
         Value           =   -1  'True
         Width           =   1575
      End
      Begin VB.TextBox maxlevbox 
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
         Left            =   2640
         TabIndex        =   26
         Text            =   "99"
         Top             =   240
         Width           =   735
      End
      Begin VB.Label Label8 
         Caption         =   "Level-up Type:"
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
         TabIndex        =   30
         Tag             =   "1603"
         Top             =   0
         Width           =   2295
      End
      Begin VB.Label Label3 
         Caption         =   "Maximum Level:"
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
         Left            =   2280
         TabIndex        =   29
         Tag             =   "1602"
         Top             =   0
         Width           =   1215
      End
   End
   Begin VB.PictureBox Picture1 
      BorderStyle     =   0  'None
      Height          =   2295
      Left            =   360
      ScaleHeight     =   2295
      ScaleWidth      =   3855
      TabIndex        =   9
      Top             =   3120
      Width           =   3855
      Begin VB.CommandButton Command2 
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
         Left            =   2160
         TabIndex        =   15
         Tag             =   "1021"
         Top             =   1920
         Width           =   1095
      End
      Begin VB.TextBox rpgcodelev 
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
         Left            =   1440
         TabIndex        =   14
         Top             =   1560
         Width           =   1815
      End
      Begin VB.TextBox smup 
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
         Left            =   2520
         TabIndex        =   13
         Text            =   "0"
         Top             =   1080
         Width           =   735
      End
      Begin VB.TextBox fpup 
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
         Left            =   2520
         TabIndex        =   12
         Text            =   "0"
         Top             =   720
         Width           =   735
      End
      Begin VB.TextBox dpup 
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
         Left            =   2520
         TabIndex        =   11
         Text            =   "0"
         Top             =   360
         Width           =   735
      End
      Begin VB.TextBox hpup 
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
         Left            =   2520
         TabIndex        =   10
         Text            =   "0"
         Top             =   0
         Width           =   735
      End
      Begin VB.Label p 
         Caption         =   "%"
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
         Index           =   4
         Left            =   3480
         TabIndex        =   24
         Tag             =   "1598"
         Top             =   1080
         Width           =   255
      End
      Begin VB.Label p 
         Caption         =   "%"
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
         Index           =   3
         Left            =   3480
         TabIndex        =   23
         Tag             =   "1598"
         Top             =   720
         Width           =   255
      End
      Begin VB.Label p 
         Caption         =   "%"
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
         Index           =   2
         Left            =   3480
         TabIndex        =   22
         Tag             =   "1598"
         Top             =   360
         Width           =   255
      End
      Begin VB.Label p 
         Caption         =   "%"
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
         Index           =   1
         Left            =   3480
         TabIndex        =   21
         Tag             =   "1598"
         Top             =   0
         Width           =   255
      End
      Begin VB.Label Label5 
         Caption         =   "Level up RPGCode"
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
         Index           =   4
         Left            =   0
         TabIndex        =   20
         Tag             =   "1597"
         Top             =   1560
         Width           =   1575
      End
      Begin VB.Label Label5 
         Caption         =   "Max SMP Increase By"
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
         Index           =   3
         Left            =   0
         TabIndex        =   19
         Tag             =   "1596"
         Top             =   1080
         Width           =   2055
      End
      Begin VB.Label Label5 
         Caption         =   "FP Increase By"
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
         Index           =   2
         Left            =   0
         TabIndex        =   18
         Tag             =   "1502"
         Top             =   720
         Width           =   2175
      End
      Begin VB.Label Label5 
         Caption         =   "DP Increase By"
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
         Index           =   1
         Left            =   0
         TabIndex        =   17
         Tag             =   "1503"
         Top             =   360
         Width           =   2055
      End
      Begin VB.Label Label5 
         Caption         =   "Max Health Increase By"
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
         Index           =   0
         Left            =   0
         TabIndex        =   16
         Tag             =   "1505"
         Top             =   0
         Width           =   2055
      End
   End
   Begin VB.CommandButton Command6 
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
      Left            =   4560
      TabIndex        =   0
      Tag             =   "1022"
      Top             =   240
      Width           =   1095
   End
   Begin VB.Frame Frame3 
      Caption         =   "Skill Increase At Level-Up"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2775
      Left            =   120
      TabIndex        =   8
      Tag             =   "1595"
      Top             =   2760
      Width           =   4215
   End
   Begin VB.Frame Frame2 
      Caption         =   "Level-Up"
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
      TabIndex        =   7
      Tag             =   "1599"
      Top             =   1440
      Width           =   4215
   End
   Begin VB.Frame Frame1 
      Caption         =   "Experience"
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
      Tag             =   "1604"
      Top             =   120
      Width           =   4215
      Begin VB.TextBox exponentlev 
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
         Left            =   2760
         TabIndex        =   4
         Text            =   "2"
         Top             =   720
         Width           =   735
      End
      Begin VB.TextBox Text1 
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
         Left            =   2760
         TabIndex        =   2
         Top             =   360
         Width           =   735
      End
      Begin VB.Label describe 
         Caption         =   "Experience Required Increases By:"
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
         Tag             =   "1605"
         Top             =   720
         Width           =   2535
      End
      Begin VB.Label p 
         Caption         =   "%"
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
         Index           =   0
         Left            =   3600
         TabIndex        =   5
         Tag             =   "1598"
         Top             =   720
         Width           =   255
      End
      Begin VB.Label Label2 
         Caption         =   "Initial Exp For Level Up:"
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
         TabIndex        =   3
         Tag             =   "1606"
         Top             =   360
         Width           =   2415
      End
   End
End
Attribute VB_Name = "charlevels"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984

Private Sub Command2_Click()
    On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + prgPath$
    dlg.strTitle = "Select Program"
    dlg.strDefaultExt = "prg"
    dlg.strFileTypes = "RPG Toolkit Program (*.prg)|*.prg|All files(*.*)|*.*"
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + prgPath$ + antiPath$
    playerList(activePlayerIndex).theData.charLevelUpRPGCode$ = antiPath$
    rpgcodelev.Text = antiPath$
End Sub

Private Sub Command6_Click()
    Unload charlevels
End Sub

'FIXIT: p_Change event has no Visual Basic .NET equivalent and will not be upgraded.       FixIT90210ae-R7593-R67265
Private Sub dpup_Change()
    On Error GoTo ErrorHandler
    playerList(activePlayerIndex).theData.levelDp = val(dpup.Text)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub exponentlev_Change()
    On Error GoTo ErrorHandler
    playerList(activePlayerIndex).theData.experienceIncrease = val(exponentlev.Text)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Form_Load()
    On Error GoTo ErrorHandler
    ' Call LocalizeForm(Me)
    
    Text1.Text = str$(playerList(activePlayerIndex).theData.levelType)
    maxlevbox.Text = str$(playerList(activePlayerIndex).theData.maxLevel)
    exponentlev.Text = str$(playerList(activePlayerIndex).theData.experienceIncrease)
    hpup.Text = str$(playerList(activePlayerIndex).theData.levelHp)
    dpup.Text = str$(playerList(activePlayerIndex).theData.levelDp)
    fpup.Text = str$(playerList(activePlayerIndex).theData.levelFp)
    smup.Text = str$(playerList(activePlayerIndex).theData.levelSm)
    rpgcodelev.Text = playerList(activePlayerIndex).theData.charLevelUpRPGCode$
    If playerList(activePlayerIndex).theData.charLevelUpType = 0 Then
        Option1.value = True
        For t = 0 To 4
            p(t).Caption = "%"
        Next t
    Else
        Option2.value = True
        For t = 0 To 4
            p(t).Caption = "pt"
        Next t
    End If

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

'FIXIT: p_Change event has no Visual Basic .NET equivalent and will not be upgraded.       FixIT90210ae-R7593-R67265
Private Sub fpup_Change()
    On Error GoTo ErrorHandler
    playerList(activePlayerIndex).theData.levelFp = val(fpup.Text)


    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

'FIXIT: p_Change event has no Visual Basic .NET equivalent and will not be upgraded.       FixIT90210ae-R7593-R67265
Private Sub hpup_Change()
    On Error GoTo ErrorHandler
    playerList(activePlayerIndex).theData.levelHp = val(hpup.Text)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub maxlevbox_Change()
    On Error GoTo ErrorHandler
    playerList(activePlayerIndex).theData.maxLevel = val(maxlevbox.Text)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Option1_Click()
    On Error GoTo ErrorHandler
    For t = 0 To 4
        p(t).Caption = "%"
    Next t
    playerList(activePlayerIndex).theData.charLevelUpType = 0

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Option2_Click()
    On Error GoTo ErrorHandler
    For t = 0 To 4
        p(t).Caption = "pt"
    Next t
    playerList(activePlayerIndex).theData.charLevelUpType = 1

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub rpgcodelev_Change()
    On Error Resume Next
    playerList(activePlayerIndex).theData.charLevelUpRPGCode$ = rpgcodelev.Text
End Sub

'FIXIT: p_Change event has no Visual Basic .NET equivalent and will not be upgraded.       FixIT90210ae-R7593-R67265
Private Sub smup_Change()
    On Error GoTo ErrorHandler
    playerList(activePlayerIndex).theData.levelSm = val(smup.Text)


    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Text1_Change()
    On Error GoTo ErrorHandler
    playerList(activePlayerIndex).theData.levelType = val(Text1.Text)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub


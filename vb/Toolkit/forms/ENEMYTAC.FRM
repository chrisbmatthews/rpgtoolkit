VERSION 5.00
Begin VB.Form enemytactics 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Enemy Tactics"
   ClientHeight    =   2595
   ClientLeft      =   2520
   ClientTop       =   2625
   ClientWidth     =   7905
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
   Icon            =   "ENEMYTAC.frx":0000
   LinkTopic       =   "Form3"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   2595
   ScaleWidth      =   7905
   StartUpPosition =   1  'CenterOwner
   Tag             =   "1447"
   Begin VB.CommandButton Command5 
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
      Left            =   6600
      TabIndex        =   0
      Tag             =   "1022"
      Top             =   240
      Width           =   1095
   End
   Begin VB.Frame Frame2 
      Caption         =   "Battle Tactics"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2295
      Left            =   120
      TabIndex        =   1
      Tag             =   "1452"
      Top             =   120
      Width           =   6255
      Begin VB.PictureBox Picture1 
         BorderStyle     =   0  'None
         Height          =   495
         Left            =   4920
         ScaleHeight     =   495
         ScaleWidth      =   1215
         TabIndex        =   8
         Top             =   1680
         Width           =   1215
         Begin VB.CommandButton Command14 
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
            Left            =   0
            TabIndex        =   9
            Tag             =   "1021"
            Top             =   0
            Width           =   1095
         End
      End
      Begin VB.Frame Frame1 
         Caption         =   "AI"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   855
         Left            =   240
         TabIndex        =   5
         Tag             =   "1450"
         Top             =   360
         Width           =   5775
         Begin VB.HScrollBar ai 
            Height          =   240
            Left            =   120
            Max             =   3
            TabIndex        =   6
            Top             =   360
            Width           =   2535
         End
         Begin VB.Label aitext 
            Caption         =   "Low"
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
            Left            =   2760
            TabIndex        =   7
            Tag             =   "1451"
            Top             =   360
            Width           =   1335
         End
      End
      Begin VB.TextBox code 
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
         Left            =   1680
         TabIndex        =   3
         Text            =   "None"
         Top             =   1680
         Width           =   3135
      End
      Begin VB.CheckBox Check1 
         Caption         =   "Instead of AI, use RPGCode guided tactics."
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
         TabIndex        =   2
         Tag             =   "1448"
         Top             =   1320
         Width           =   4815
      End
      Begin VB.Label Label3 
         Caption         =   "Program to run:"
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
         Left            =   240
         TabIndex        =   4
         Tag             =   "1449"
         Top             =   1680
         Width           =   1335
      End
   End
End
Attribute VB_Name = "enemytactics"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Private Sub ai_Change()
    On Error GoTo ErrorHandler
    enemylist(activeEnemyIndex).theData.eneAI = ai.value
    If enemylist(activeEnemyIndex).theData.eneAI = 0 Then aitext.Caption = LoadStringLoc(2029, "Low")
    If enemylist(activeEnemyIndex).theData.eneAI = 1 Then aitext.Caption = LoadStringLoc(2030, "Medium")
    If enemylist(activeEnemyIndex).theData.eneAI = 2 Then aitext.Caption = LoadStringLoc(2031, "High")
    If enemylist(activeEnemyIndex).theData.eneAI = 3 Then aitext.Caption = LoadStringLoc(2032, "Very High")

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Check1_Click()
    On Error GoTo ErrorHandler
    enemylist(activeEnemyIndex).theData.eneUseRPGCode = Check1.value
    If enemylist(activeEnemyIndex).theData.eneUseRPGCode = 1 Then
        Label3.Enabled = True
        code.Enabled = True
    Else
        Label3.Enabled = False
        code.Enabled = False
    End If

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub code_Change()
    On Error Resume Next
    enemylist(activeEnemyIndex).theData.eneRPGCode$ = code.Text
End Sub

Private Sub Command14_Click()
    On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + prgPath$
    
    dlg.strTitle = "Select Program"
    dlg.strDefaultExt = "prg"
    dlg.strFileTypes = "Supported Files|*.prg|RPG Toolkit Program (*.prg)|*.prg|All files(*.*)|*.*"
    
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + prgPath$ + antiPath$
    code.Text = antiPath$
    enemylist(activeEnemyIndex).theData.eneRPGCode$ = antiPath$
End Sub


Private Sub Command5_Click()
    Unload enemytactics
End Sub

Private Sub Form_Load()
    On Error GoTo ErrorHandler
    ' Call LocalizeForm(Me)
    Call infofill

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub infofill()
    On Error GoTo ErrorHandler
    ai.value = enemylist(activeEnemyIndex).theData.eneAI
    Check1.value = enemylist(activeEnemyIndex).theData.eneUseRPGCode
    If enemylist(activeEnemyIndex).theData.eneUseRPGCode = 1 Then
        Label3.Enabled = True
        code.Enabled = True
    Else
        Label3.Enabled = False
        code.Enabled = False
    End If
    code.Text = enemylist(activeEnemyIndex).theData.eneRPGCode$

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub


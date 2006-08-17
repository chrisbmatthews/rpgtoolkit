VERSION 5.00
Begin VB.Form enemytactics 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Enemy Tactics"
   ClientHeight    =   2400
   ClientLeft      =   2520
   ClientTop       =   2625
   ClientWidth     =   6975
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
   ScaleHeight     =   2400
   ScaleWidth      =   6975
   StartUpPosition =   1  'CenterOwner
   Tag             =   "1447"
   Begin VB.CommandButton cmdOK 
      Appearance      =   0  'Flat
      Caption         =   "OK"
      Default         =   -1  'True
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
      Left            =   5760
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
      Height          =   2175
      Left            =   120
      TabIndex        =   1
      Tag             =   "1452"
      Top             =   120
      Width           =   5535
      Begin VB.PictureBox Picture2 
         BorderStyle     =   0  'None
         Height          =   975
         Left            =   120
         ScaleHeight     =   975
         ScaleWidth      =   5295
         TabIndex        =   7
         Top             =   240
         Width           =   5295
         Begin VB.Frame Frame1 
            Caption         =   "Artificial Intelligence Level (Internal Algorithm)"
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
            Left            =   0
            TabIndex        =   8
            Tag             =   "1450"
            Top             =   0
            Width           =   5295
            Begin VB.HScrollBar ai 
               Height          =   240
               Left            =   1320
               Max             =   3
               TabIndex        =   9
               Top             =   360
               Width           =   2775
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
               Left            =   240
               TabIndex        =   10
               Tag             =   "1451"
               Top             =   360
               Width           =   1335
            End
         End
      End
      Begin VB.PictureBox Picture1 
         BorderStyle     =   0  'None
         Height          =   495
         Left            =   4320
         ScaleHeight     =   495
         ScaleWidth      =   1095
         TabIndex        =   5
         Top             =   1560
         Width           =   1095
         Begin VB.CommandButton cmdBrowse 
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
            TabIndex        =   6
            Tag             =   "1021"
            Top             =   120
            Width           =   1095
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
         Left            =   1440
         TabIndex        =   3
         Text            =   "None"
         Top             =   1680
         Width           =   2775
      End
      Begin VB.CheckBox Check1 
         Caption         =   "Use RPGCode guided-tactics"
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
'==============================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'==============================================================================

Option Explicit

Private Sub ai_Change(): On Error Resume Next
    enemylist(activeEnemyIndex).theData.eneAI = ai.value
    If enemylist(activeEnemyIndex).theData.eneAI = 0 Then aitext.Caption = LoadStringLoc(2029, "Low")
    If enemylist(activeEnemyIndex).theData.eneAI = 1 Then aitext.Caption = LoadStringLoc(2030, "Medium")
    If enemylist(activeEnemyIndex).theData.eneAI = 2 Then aitext.Caption = LoadStringLoc(2031, "High")
    If enemylist(activeEnemyIndex).theData.eneAI = 3 Then aitext.Caption = LoadStringLoc(2032, "Very High")
End Sub

Private Sub Check1_Click(): On Error Resume Next
    enemylist(activeEnemyIndex).theData.eneUseRPGCode = Check1.value
    cmdBrowse.Enabled = (enemylist(activeEnemyIndex).theData.eneUseRPGCode = 1)
    code.Enabled = cmdBrowse.Enabled
    Label3.Enabled = cmdBrowse.Enabled
    ai.Enabled = Not cmdBrowse.Enabled
    aitext.Enabled = Not cmdBrowse.Enabled
End Sub

Private Sub code_Change(): On Error Resume Next
    enemylist(activeEnemyIndex).theData.eneRPGCode$ = code.Text
End Sub

Private Sub cmdBrowse_Click(): On Error Resume Next
    Dim file As String, fileTypes As String
    fileTypes = "RPG Toolkit Program (*.prg)|*.prg|All files(*.*)|*.*"
    If browseFileDialog(Me.hwnd, projectPath & prgPath, "Select program", "prg", fileTypes, file) Then
        code.Text = file
        enemylist(activeEnemyIndex).theData.eneRPGCode = file
    End If
End Sub

Private Sub cmdOK_Click(): On Error Resume Next
    Unload Me
End Sub

Private Sub Form_Load(): On Error Resume Next
    Call infofill
End Sub

Private Sub infofill(): On Error Resume Next
    ai.value = enemylist(activeEnemyIndex).theData.eneAI
    Check1.value = enemylist(activeEnemyIndex).theData.eneUseRPGCode
    cmdBrowse.Enabled = (enemylist(activeEnemyIndex).theData.eneUseRPGCode = 1)
    code.Enabled = cmdBrowse.Enabled
    Label3.Enabled = cmdBrowse.Enabled
    ai.Enabled = Not cmdBrowse.Enabled
    aitext.Enabled = Not cmdBrowse.Enabled
    code.Text = enemylist(activeEnemyIndex).theData.eneRPGCode
End Sub

VERSION 5.00
Begin VB.Form enemyrewards 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Enemy Rewards"
   ClientHeight    =   2880
   ClientLeft      =   3015
   ClientTop       =   2850
   ClientWidth     =   6570
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
   Icon            =   "ENEMYREW.frx":0000
   LinkTopic       =   "Form4"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   2880
   ScaleWidth      =   6570
   StartUpPosition =   1  'CenterOwner
   Tag             =   "1386"
   Begin VB.CommandButton Command1 
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
      Left            =   5280
      TabIndex        =   0
      Tag             =   "1022"
      Top             =   240
      Width           =   1095
   End
   Begin VB.Frame Frame1 
      Caption         =   "Rewards For Defeating Enemy"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2535
      Left            =   120
      TabIndex        =   1
      Tag             =   "1390"
      Top             =   120
      Width           =   4935
      Begin VB.PictureBox Picture1 
         BorderStyle     =   0  'None
         Height          =   495
         Left            =   3720
         ScaleHeight     =   495
         ScaleWidth      =   1095
         TabIndex        =   9
         Top             =   1560
         Width           =   1095
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
            TabIndex        =   10
            Tag             =   "1021"
            Top             =   0
            Width           =   1095
         End
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
         Left            =   1920
         TabIndex        =   4
         Text            =   "0"
         Top             =   360
         Width           =   1695
      End
      Begin VB.TextBox Text2 
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
         Left            =   1920
         TabIndex        =   3
         Text            =   "0"
         Top             =   720
         Width           =   1695
      End
      Begin VB.TextBox Text3 
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
         Text            =   "None"
         Top             =   1560
         Width           =   3495
      End
      Begin VB.Label Label2 
         Caption         =   "Experience Gained:"
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
         Left            =   120
         TabIndex        =   8
         Tag             =   "1389"
         Top             =   360
         Width           =   1695
      End
      Begin VB.Label Label3 
         Caption         =   "GP Earned:"
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
         Left            =   120
         TabIndex        =   7
         Tag             =   "1388"
         Top             =   720
         Width           =   1695
      End
      Begin VB.Label Label4 
         Caption         =   "Program to run upon defeating enemy:"
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
         Left            =   120
         TabIndex        =   6
         Tag             =   "1387"
         Top             =   1200
         Width           =   4215
      End
      Begin VB.Label link1 
         Alignment       =   1  'Right Justify
         Caption         =   "Also see RPGCode Editor"
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
         Left            =   1560
         MouseIcon       =   "ENEMYREW.frx":0CCA
         MousePointer    =   99  'Custom
         TabIndex        =   5
         Tag             =   "1150"
         Top             =   2040
         Visible         =   0   'False
         Width           =   3015
      End
   End
End
Attribute VB_Name = "enemyrewards"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Private Sub Command1_Click()
    Unload enemyrewards
End Sub

Private Sub Command14_Click()
    On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + prgPath$
    
    dlg.strTitle = "Select Program"
    dlg.strDefaultExt = "prg"
    dlg.strFileTypes = "Supported Files|*.prg|RPG Toolkit Program (*.prg)|*.prg|All files(*.*)|*.*"
    
    If Err = 32755 Then
        Text3.Text = ""
        enemylist(activeEnemyIndex).theData.eneWinPrg$ = ""
    End If
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + prgPath$ + antiPath$
    Text3.Text = antiPath$
    enemylist(activeEnemyIndex).theData.eneWinPrg$ = antiPath$
End Sub

Private Sub Form_Load()
    On Error GoTo ErrorHandler
    Call LocalizeForm(Me)
    Call infofill

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub infofill()
    On Error GoTo ErrorHandler
    Text1.Text = str$(enemylist(activeEnemyIndex).theData.eneExp)
    Text2.Text = str$(enemylist(activeEnemyIndex).theData.eneGP)
    Text3.Text = enemylist(activeEnemyIndex).theData.eneWinPrg$

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub link1_Click()
    On Error GoTo ErrorHandler
    activeRPGCode.Show

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Text1_Change()
    On Error GoTo ErrorHandler
    enemylist(activeEnemyIndex).theData.eneExp = val(Text1.Text)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Text2_Change()
    On Error GoTo ErrorHandler
    enemylist(activeEnemyIndex).theData.eneGP = val(Text2.Text)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Text3_Change()
    On Error Resume Next
    enemylist(activeEnemyIndex).theData.eneWinPrg$ = Text3.Text
End Sub


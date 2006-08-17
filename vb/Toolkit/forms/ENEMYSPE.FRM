VERSION 5.00
Begin VB.Form enemyspecialmoves 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Enemy Special Move Info"
   ClientHeight    =   2760
   ClientLeft      =   795
   ClientTop       =   1560
   ClientWidth     =   8460
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
   Icon            =   "ENEMYSPE.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   2760
   ScaleWidth      =   8460
   StartUpPosition =   1  'CenterOwner
   Tag             =   "1453"
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
      Left            =   7320
      TabIndex        =   0
      Tag             =   "1022"
      Top             =   240
      Width           =   1095
   End
   Begin VB.Frame Frame2 
      Caption         =   "Weaknesses"
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
      Left            =   3720
      TabIndex        =   2
      Tag             =   "1454"
      Top             =   120
      Width           =   3495
      Begin VB.PictureBox Picture2 
         BorderStyle     =   0  'None
         Height          =   975
         Left            =   2280
         ScaleHeight     =   975
         ScaleWidth      =   1095
         TabIndex        =   8
         Top             =   240
         Width           =   1095
         Begin VB.CommandButton cmdSetWeakness 
            Appearance      =   0  'Flat
            Caption         =   "Set..."
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
            Tag             =   "1455"
            Top             =   0
            Width           =   1095
         End
         Begin VB.CommandButton cmdRemoveWeakness 
            Appearance      =   0  'Flat
            Caption         =   "Remove"
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
            Tag             =   "1096"
            Top             =   480
            Width           =   1095
         End
      End
      Begin VB.ListBox weaklist 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   2205
         Left            =   120
         TabIndex        =   4
         Top             =   240
         Width           =   2055
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Special Moves"
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
      Tag             =   "1337"
      Top             =   120
      Width           =   3495
      Begin VB.PictureBox Picture1 
         BorderStyle     =   0  'None
         Height          =   1095
         Left            =   2280
         ScaleHeight     =   1095
         ScaleWidth      =   1095
         TabIndex        =   5
         Top             =   240
         Width           =   1095
         Begin VB.CommandButton cmdSetSpc 
            Appearance      =   0  'Flat
            Caption         =   "Set..."
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
            TabIndex        =   7
            Tag             =   "1455"
            Top             =   0
            Width           =   1095
         End
         Begin VB.CommandButton cmdRemoveSpc 
            Appearance      =   0  'Flat
            Caption         =   "Remove"
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
            Tag             =   "1096"
            Top             =   480
            Width           =   1095
         End
      End
      Begin VB.ListBox smlist 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   2205
         Left            =   240
         TabIndex        =   3
         Top             =   240
         Width           =   1935
      End
   End
End
Attribute VB_Name = "enemyspecialmoves"
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

Private Sub cmdSetSpc_Click(): On Error Resume Next
    Dim file As String, fileTypes As String
    fileTypes = "Special Moves (*.spc)|*.spc|All files (*.*)|*.*"
    If browseFileDialog(Me.hwnd, projectPath & spcPath, "Select special move", "spc", fileTypes, file) Then
        enemylist(activeEnemyIndex).theData.eneSpecialMove(smlist.ListIndex) = file
    End If
    
    Call infofill
End Sub

Private Sub cmdRemoveSpc_Click(): On Error Resume Next
    enemylist(activeEnemyIndex).theData.eneSpecialMove(smlist.ListIndex) = vbNullString
    Call infofill
End Sub

Private Sub cmdSetWeakness_Click(): On Error Resume Next
    Dim file As String, fileTypes As String
    fileTypes = "Special Moves (*.spc)|*.spc|All files (*.*)|*.*"
    If browseFileDialog(Me.hwnd, projectPath & spcPath, "Select special move", "spc", fileTypes, file) Then
        enemylist(activeEnemyIndex).theData.eneWeakness(weaklist.ListIndex) = file
    End If
    
    Call infofill
End Sub

Private Sub cmdRemoveWeakness_Click(): On Error Resume Next
    enemylist(activeEnemyIndex).theData.eneWeakness(weaklist.ListIndex) = vbNullString
    Call infofill
End Sub

Private Sub cmdOK_Click(): On Error Resume Next
    Unload Me
End Sub

Private Sub Form_Load(): On Error Resume Next
    Call infofill
End Sub

Private Sub infofill(): On Error Resume Next
    Dim i As Long, sIndex As Long, wIndex As Long
    
    sIndex = IIf(smlist.ListIndex < 0, 0, smlist.ListIndex)
    wIndex = IIf(weaklist.ListIndex < 0, 0, weaklist.ListIndex)
    smlist.clear
    weaklist.clear
    
    With enemylist(activeEnemyIndex).theData
        For i = 0 To 100
            smlist.AddItem (CStr(i) & ": " & IIf(LenB(.eneSpecialMove(i)), .eneSpecialMove(i), "None"))
            weaklist.AddItem (CStr(i) & ": " & IIf(LenB(.eneWeakness(i)), .eneWeakness(i), "None"))
        Next i
    End With
    
    smlist.ListIndex = sIndex
    weaklist.ListIndex = wIndex

End Sub

Private Sub smlist_DblClick(): On Error Resume Next
    Call cmdSetSpc_Click
End Sub

Private Sub weaklist_dblClick(): On Error Resume Next
    Call cmdSetWeakness_Click
End Sub

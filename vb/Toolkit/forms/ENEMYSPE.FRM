VERSION 5.00
Begin VB.Form enemyspecialmoves 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Enemy Special Move Info"
   ClientHeight    =   3450
   ClientLeft      =   795
   ClientTop       =   1560
   ClientWidth     =   9255
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
   ScaleHeight     =   3450
   ScaleWidth      =   9255
   StartUpPosition =   1  'CenterOwner
   Tag             =   "1453"
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
      Left            =   8040
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
      Height          =   2895
      Left            =   4080
      TabIndex        =   2
      Tag             =   "1454"
      Top             =   120
      Width           =   3855
      Begin VB.CommandButton Command4 
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
         Left            =   2280
         TabIndex        =   6
         Tag             =   "1096"
         Top             =   720
         Width           =   1095
      End
      Begin VB.CommandButton Command3 
         Appearance      =   0  'Flat
         Caption         =   "Set"
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
         Left            =   2280
         TabIndex        =   5
         Tag             =   "1455"
         Top             =   240
         Width           =   1095
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
      Height          =   2895
      Left            =   120
      TabIndex        =   1
      Tag             =   "1337"
      Top             =   120
      Width           =   3855
      Begin VB.CommandButton Command2 
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
         Left            =   2280
         TabIndex        =   8
         Tag             =   "1096"
         Top             =   720
         Width           =   1095
      End
      Begin VB.CommandButton Command1 
         Appearance      =   0  'Flat
         Caption         =   "Set"
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
         Left            =   2280
         TabIndex        =   7
         Tag             =   "1455"
         Top             =   240
         Width           =   1095
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
   Begin VB.Label link1 
      Alignment       =   1  'Right Justify
      Caption         =   "Also see Special Move Editor"
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
      Left            =   4320
      MouseIcon       =   "ENEMYSPE.frx":0CCA
      MousePointer    =   99  'Custom
      TabIndex        =   9
      Tag             =   "1101"
      Top             =   3120
      Visible         =   0   'False
      Width           =   3615
   End
End
Attribute VB_Name = "enemyspecialmoves"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'!NEW! Variables used for the currently selected items in the listbox
Dim currentenesm As Integer
Dim currenteneweak As Integer


'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Private Sub Command1_Click()
    On Error GoTo errorhandler
    If smlist.ListIndex = -1 Then
        MsgBox LoadStringLoc(973, "Please Select A Slot!")
        Exit Sub
    End If
    n = smlist.ListIndex
    'open OPEN box
    ChDir (currentdir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + spcpath$
    
    dlg.strTitle = "Select Special Move"
    dlg.strDefaultExt = "spc"
    dlg.strFileTypes = "Special Moves (*.spc)|*.spc|All files (*.*)|*.*"
    
    ChDir (currentdir$)
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    If filename$(1) = "" Then Exit Sub
        
    enemylist(activeEnemyIndex).theData.eneSpecialMove$(n) = antiPath$
    ChDir (currentdir$)
    
    '!NEW! Check what the current selected item is
    currentenesm = smlist.ListIndex
    
    Call infofill

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command2_Click()
    On Error GoTo errorhandler
    If smlist.ListIndex = -1 Then
        MsgBox "Please Select A Slot!"
        Exit Sub
    End If
    n = smlist.ListIndex
    enemylist(activeEnemyIndex).theData.eneSpecialMove$(n) = ""
    Call infofill

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command3_Click()
    On Error GoTo errorhandler
    If weaklist.ListIndex = -1 Then
        MsgBox "Please Select A Slot!"
        Exit Sub
    End If
    n = weaklist.ListIndex
    'open OPEN box
    ChDir (currentdir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + spcpath$
    
    dlg.strTitle = "Select Special Move"
    dlg.strDefaultExt = "spc"
    dlg.strFileTypes = "Special Moves (*.spc)|*.spc|All files (*.*)|*.*"
    
    ChDir (currentdir$)
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    If filename$(1) = "" Then Exit Sub
        
    enemylist(activeEnemyIndex).theData.eneWeakness$(n) = antiPath$
    ChDir (currentdir$)
    
    '!NEW! Check what the current selected item is
    currenteneweak = weaklist.ListIndex
    
    Call infofill

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command4_Click()
    On Error GoTo errorhandler
    If weaklist.ListIndex = -1 Then
        MsgBox "Please Select A Slot!"
        Exit Sub
    End If
    n = weaklist.ListIndex
    enemylist(activeEnemyIndex).theData.eneWeakness$(n) = ""
    Call infofill

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command5_Click()
    Unload enemyspecialmoves
End Sub

Private Sub Form_Load()
    On Error GoTo errorhandler
    Call LocalizeForm(Me)
    Call infofill

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub infofill()
    On Error GoTo errorhandler
    smlist.Clear
    For t = 0 To 100
        text$ = str$(t) + ": "
        If enemylist(activeEnemyIndex).theData.eneSpecialMove$(t) = "" Then
            use$ = LoadStringLoc(1010, "None")
        Else
            use$ = enemylist(activeEnemyIndex).theData.eneSpecialMove$(t)
        End If
        text$ = text$ + use$
        smlist.AddItem (text$)
    Next t
    
    '!NEW! The selected item is now the same as it was before the refresh
    smlist.ListIndex = currentenesm
    
    weaklist.Clear
    For t = 0 To 100
        text$ = str$(t) + ": "
        If enemylist(activeEnemyIndex).theData.eneWeakness$(t) = "" Then
            use$ = LoadStringLoc(1010, "None")
        Else
            use$ = enemylist(activeEnemyIndex).theData.eneWeakness$(t)
        End If
        text$ = text$ + use$
        weaklist.AddItem (text$)
    Next t
    
    '!NEW! The selected item is now the same as it was before the refresh
    weaklist.ListIndex = currenteneweak

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub link1_Click()
    On Error GoTo errorhandler
    activeSpecialMove.Show

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

'!NEW! Makes it easier to edit the special moves
Private Sub smlist_DblClick()
    Call Command1_Click
End Sub

'!NEW! Makes it easier to edit the weaknesses
Private Sub weaklist_dblClick()
    Call Command3_Click
End Sub

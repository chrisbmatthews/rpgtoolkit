VERSION 5.00
Begin VB.Form characterGraphics 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Character Graphics"
   ClientHeight    =   5055
   ClientLeft      =   480
   ClientTop       =   1170
   ClientWidth     =   8610
   Icon            =   "characterGraphics.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   ScaleHeight     =   5055
   ScaleWidth      =   8610
   StartUpPosition =   1  'CenterOwner
   Tag             =   "1236"
   Begin VB.CommandButton Command6 
      Appearance      =   0  'Flat
      Caption         =   "OK"
      Height          =   345
      Left            =   7320
      TabIndex        =   0
      Tag             =   "1022"
      Top             =   240
      Width           =   1095
   End
   Begin VB.Frame Frame1 
      Caption         =   "Sprite List"
      Height          =   4695
      Left            =   120
      TabIndex        =   1
      Top             =   120
      Width           =   6975
      Begin VB.CommandButton Command2 
         Appearance      =   0  'Flat
         Caption         =   "Remove"
         Height          =   345
         Left            =   3480
         TabIndex        =   8
         Top             =   4200
         Width           =   1095
      End
      Begin VB.CommandButton Command1 
         Appearance      =   0  'Flat
         Caption         =   "Add"
         Height          =   345
         Left            =   3480
         TabIndex        =   7
         Top             =   3720
         Width           =   1095
      End
      Begin VB.ListBox spriteList 
         Height          =   4155
         Left            =   240
         TabIndex        =   5
         Top             =   360
         Width           =   3015
      End
      Begin VB.TextBox Text1 
         Height          =   285
         Left            =   3480
         TabIndex        =   4
         Top             =   600
         Width           =   2055
      End
      Begin VB.CommandButton Command14 
         Caption         =   "Browse..."
         Height          =   345
         Left            =   5640
         TabIndex        =   3
         Tag             =   "1021"
         Top             =   600
         Width           =   1095
      End
      Begin VB.CommandButton Command8 
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   3480
         Picture         =   "characterGraphics.frx":0CCA
         Style           =   1  'Graphical
         TabIndex        =   2
         Top             =   960
         Width           =   375
      End
      Begin VB.Label Label2 
         Caption         =   "Animation"
         Height          =   255
         Left            =   3480
         TabIndex        =   6
         Tag             =   "2061"
         Top             =   360
         Width           =   2415
      End
   End
End
Attribute VB_Name = "characterGraphics"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

Option Explicit
Sub infofill()
    'fill in the info...
    On Error Resume Next
    
    spriteList.Clear
    
    spriteList.AddItem (LoadStringLoc(1260, "Face S (Front View)"))
    spriteList.AddItem (LoadStringLoc(1259, "Face N (Rear View)"))
    spriteList.AddItem (LoadStringLoc(1257, "Face E (Right View)"))
    spriteList.AddItem (LoadStringLoc(1258, "Face W (Left View)"))
    spriteList.AddItem (LoadStringLoc(2055, "Face NW"))
    spriteList.AddItem (LoadStringLoc(2053, "Face NE"))
    spriteList.AddItem (LoadStringLoc(2054, "Face SW"))
    spriteList.AddItem (LoadStringLoc(2056, "Face SE"))
    spriteList.AddItem (LoadStringLoc(2057, "Attack"))
    spriteList.AddItem (LoadStringLoc(2058, "Defend"))
    spriteList.AddItem (LoadStringLoc(822, "Special Move"))
    spriteList.AddItem (LoadStringLoc(2059, "Die"))
    spriteList.AddItem (LoadStringLoc(2060, "Rest"))
    
    Dim t As Long
    For t = 0 To UBound(playerList(activePlayerIndex).theData.customGfxNames)
        If playerList(activePlayerIndex).theData.customGfxNames(t) <> "" Then
            spriteList.AddItem (playerList(activePlayerIndex).theData.customGfxNames(t))
        End If
    Next t
    
    
    spriteList.ListIndex = 0
End Sub


Private Sub Command1_Click()
    'enter new custom anim
    On Error Resume Next
    
    Dim idx As Long, newName As String
    idx = spriteList.ListIndex
    If idx = -1 Then idx = 0
    
    newName$ = InputBox(LoadStringLoc(2063, "Enter the handle for a new animation"))
    If newName$ <> "" Then
        Call playerAddCustomGfx(playerList(activePlayerIndex).theData, newName$, "")
        Call infofill
        spriteList.ListIndex = idx
    End If
End Sub

Private Sub Command14_Click()
    On Error Resume Next
    ChDir (currentdir$)
    Dim dlg As FileDialogInfo
    Dim antiPath As String, idx As Long, dx As Long
    
    dlg.strDefaultFolder = projectPath$ + miscPath$
    
    dlg.strTitle = "Select Animation"
    dlg.strDefaultExt = "anm"
    dlg.strFileTypes = "RPG Toolkit Animation (*.anm)|*.anm|All files(*.*)|*.*"
    
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentdir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + miscPath$ + antiPath$
    Text1.text = antiPath$
    
    idx = spriteList.ListIndex
    If idx = -1 Then idx = 0
    
    If idx < UBound(playerList(activePlayerIndex).theData.gfx) Then
        playerList(activePlayerIndex).theData.gfx(idx) = antiPath$
    Else
        dx = playerGetCustomHandleIdx(playerList(activePlayerIndex).theData, idx - UBound(playerList(activePlayerIndex).theData.gfx))
        playerList(activePlayerIndex).theData.customGfx(dx) = antiPath$
    End If
End Sub

Private Sub Command2_Click()
    On Error Resume Next
    
    Dim idx As Long, dx As Long
    
    idx = spriteList.ListIndex
    If idx = -1 Then idx = 0
    
    If idx < UBound(playerList(activePlayerIndex).theData.gfx) Then
        MsgBox LoadStringLoc(2062, "Cannot remove system animations")
    Else
        dx = playerGetCustomHandleIdx(playerList(activePlayerIndex).theData, idx - UBound(playerList(activePlayerIndex).theData.gfx))
        playerList(activePlayerIndex).theData.customGfx(dx) = ""
        playerList(activePlayerIndex).theData.customGfxNames(dx) = ""
        Call infofill
        spriteList.ListIndex = idx
    End If
End Sub

Private Sub Command6_Click()
    On Error Resume Next
    Unload Me
End Sub

Private Sub Command8_Click()
    'play animation...
    
    On Error Resume Next
    
    Dim idx As Long, anmFile As String, dx As Long
    idx = spriteList.ListIndex
    If idx = -1 Then idx = 0
    
    anmFile$ = ""
    If idx < UBound(playerList(activePlayerIndex).theData.gfx) Then
        anmFile$ = playerList(activePlayerIndex).theData.gfx(idx)
    Else
        dx = playerGetCustomHandleIdx(playerList(activePlayerIndex).theData, idx - UBound(playerList(activePlayerIndex).theData.gfx))
        anmFile$ = playerList(activePlayerIndex).theData.customGfx(dx)
    End If
    
    If anmFile$ <> "" And FileExists(projectPath$ + miscPath$ + anmFile$) Then
        'play animation
        animationHost.file = projectPath$ + miscPath$ + anmFile$
        animationHost.repeats = 3
        animationHost.Show vbModal
    End If
End Sub


Private Sub Form_Load()
    On Error Resume Next
    Call LocalizeForm(Me)
    
    Call infofill
End Sub


Private Sub spriteList_Click()
    On Error Resume Next
    
    Dim idx As Long, dx As Long
    idx = spriteList.ListIndex
    If idx = -1 Then idx = 0
    
    If idx < UBound(playerList(activePlayerIndex).theData.gfx) Then
        Text1.text = playerList(activePlayerIndex).theData.gfx(idx)
    Else
        dx = playerGetCustomHandleIdx(playerList(activePlayerIndex).theData, idx - UBound(playerList(activePlayerIndex).theData.gfx))
        Text1.text = playerList(activePlayerIndex).theData.customGfx(dx)
    End If
End Sub


Private Sub spriteList_DblClick()
    On Error Resume Next
    Call Command8_Click
End Sub


Private Sub Text1_Change()
    On Error Resume Next
    
    Dim idx As Long, dx As Long
    idx = spriteList.ListIndex
    If idx = -1 Then idx = 0
    
    If idx < UBound(playerList(activePlayerIndex).theData.gfx) Then
        playerList(activePlayerIndex).theData.gfx(idx) = Text1.text
    Else
        dx = playerGetCustomHandleIdx(playerList(activePlayerIndex).theData, idx - UBound(playerList(activePlayerIndex).theData.gfx))
        playerList(activePlayerIndex).theData.customGfx(dx) = Text1.text
    End If
End Sub



VERSION 5.00
Begin VB.Form characterGraphics 
   Appearance      =   0  'Flat
   BackColor       =   &H80000005&
   BorderStyle     =   0  'None
   Caption         =   "Character Graphics"
   ClientHeight    =   5055
   ClientLeft      =   435
   ClientTop       =   840
   ClientWidth     =   8175
   Icon            =   "characterGraphics.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   ScaleHeight     =   5055
   ScaleWidth      =   8175
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Tag             =   "1236"
   Begin Toolkit.TKTopBar TopBar 
      Height          =   480
      Left            =   0
      TabIndex        =   5
      Top             =   0
      Width           =   3135
      _ExtentX        =   5530
      _ExtentY        =   847
      Object.Width           =   3135
      Caption         =   "Character Sprite List"
   End
   Begin Toolkit.TKButton Command6 
      Height          =   375
      Left            =   7200
      TabIndex        =   4
      Top             =   600
      Width           =   735
      _ExtentX        =   661
      _ExtentY        =   661
      Object.Width           =   360
      Caption         =   "OK"
   End
   Begin VB.Frame Frame1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   4335
      Left            =   120
      TabIndex        =   0
      Top             =   480
      Width           =   6975
      Begin Toolkit.TKButton Command2 
         Height          =   375
         Left            =   3480
         TabIndex        =   9
         Top             =   3720
         Width           =   1335
         _ExtentX        =   661
         _ExtentY        =   661
         Object.Width           =   360
         Caption         =   "Remove"
      End
      Begin Toolkit.TKButton Command1 
         CausesValidation=   0   'False
         Height          =   375
         Left            =   3480
         TabIndex        =   8
         Top             =   3240
         Width           =   1095
         _ExtentX        =   661
         _ExtentY        =   661
         Object.Width           =   360
         Caption         =   "Add"
      End
      Begin VB.PictureBox Command8 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         ForeColor       =   &H80000008&
         Height          =   442
         Left            =   3480
         MousePointer    =   99  'Custom
         Picture         =   "characterGraphics.frx":0CCA
         ScaleHeight     =   405
         ScaleWidth      =   435
         TabIndex        =   7
         Top             =   960
         Width           =   465
      End
      Begin VB.PictureBox command14 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   375
         Left            =   6120
         MousePointer    =   99  'Custom
         Picture         =   "characterGraphics.frx":1654
         ScaleHeight     =   375
         ScaleWidth      =   615
         TabIndex        =   6
         Top             =   530
         Width           =   615
      End
      Begin VB.ListBox spriteList 
         Appearance      =   0  'Flat
         Height          =   3735
         Left            =   240
         TabIndex        =   2
         Top             =   360
         Width           =   3015
      End
      Begin VB.TextBox Text1 
         Appearance      =   0  'Flat
         Height          =   285
         Left            =   3480
         TabIndex        =   1
         Top             =   600
         Width           =   2535
      End
      Begin VB.Label Label2 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "Animation"
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   3480
         TabIndex        =   3
         Tag             =   "2061"
         Top             =   360
         Width           =   2415
      End
   End
   Begin VB.Shape Shape1 
      Height          =   5055
      Left            =   0
      Top             =   0
      Width           =   8175
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
    Text1.Text = antiPath$
    
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
    Set TopBar.theForm = Me
    Call infofill
    Command8.MouseIcon = Images.MouseLink
    Command14.MouseIcon = Images.MouseLink
End Sub


Private Sub spriteList_Click()
    On Error Resume Next
    
    Dim idx As Long, dx As Long
    idx = spriteList.ListIndex
    If idx = -1 Then idx = 0
    
    If idx < UBound(playerList(activePlayerIndex).theData.gfx) Then
        Text1.Text = playerList(activePlayerIndex).theData.gfx(idx)
    Else
        dx = playerGetCustomHandleIdx(playerList(activePlayerIndex).theData, idx - UBound(playerList(activePlayerIndex).theData.gfx))
        Text1.Text = playerList(activePlayerIndex).theData.customGfx(dx)
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
        playerList(activePlayerIndex).theData.gfx(idx) = Text1.Text
    Else
        dx = playerGetCustomHandleIdx(playerList(activePlayerIndex).theData, idx - UBound(playerList(activePlayerIndex).theData.gfx))
        playerList(activePlayerIndex).theData.customGfx(dx) = Text1.Text
    End If
End Sub



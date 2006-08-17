VERSION 5.00
Begin VB.Form enemyGfx 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Edit Enemy Graphics"
   ClientHeight    =   2400
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   7065
   Icon            =   "enemyGfx.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2400
   ScaleWidth      =   7065
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Tag             =   "1493"
   Begin VB.Frame Frame1 
      Caption         =   "Sprite List"
      Height          =   2175
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   6855
      Begin VB.PictureBox Picture1 
         BorderStyle     =   0  'None
         Height          =   1695
         Left            =   3360
         ScaleHeight     =   1695
         ScaleWidth      =   3375
         TabIndex        =   2
         Top             =   360
         Width           =   3375
         Begin VB.CommandButton cmdOK 
            Appearance      =   0  'Flat
            Caption         =   "OK"
            Default         =   -1  'True
            Height          =   345
            Left            =   2160
            TabIndex        =   9
            Tag             =   "1022"
            Top             =   1320
            Width           =   1095
         End
         Begin VB.TextBox Text1 
            Height          =   285
            Left            =   0
            TabIndex        =   7
            Top             =   240
            Width           =   2055
         End
         Begin VB.CommandButton cmdAnimate 
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
            Left            =   0
            Picture         =   "enemyGfx.frx":0CCA
            Style           =   1  'Graphical
            TabIndex        =   6
            ToolTipText     =   "Preview animation"
            Top             =   600
            Width           =   375
         End
         Begin VB.CommandButton cmdBrowse 
            Caption         =   "Browse..."
            Height          =   345
            Left            =   2160
            TabIndex        =   5
            Tag             =   "1021"
            Top             =   240
            Width           =   1095
         End
         Begin VB.CommandButton cmdRemove 
            Appearance      =   0  'Flat
            Caption         =   "Remove"
            Height          =   345
            Left            =   2160
            TabIndex        =   4
            ToolTipText     =   "Remove custom animation"
            Top             =   960
            Width           =   1095
         End
         Begin VB.CommandButton cmdAdd 
            Appearance      =   0  'Flat
            Caption         =   "Add..."
            Height          =   345
            Left            =   2160
            TabIndex        =   3
            ToolTipText     =   "Add custom animation"
            Top             =   600
            Width           =   1095
         End
         Begin VB.Label Label2 
            Caption         =   "Animation"
            Height          =   255
            Left            =   0
            TabIndex        =   8
            Tag             =   "2061"
            Top             =   0
            Width           =   2415
         End
      End
      Begin VB.ListBox spriteList 
         Height          =   1620
         Left            =   240
         TabIndex        =   1
         Top             =   360
         Width           =   3015
      End
   End
End
Attribute VB_Name = "enemyGfx"
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

Private Sub infofill(): On Error Resume Next
    spriteList.clear
    
    spriteList.AddItem (LoadStringLoc(2060, "Rest"))
    spriteList.AddItem (LoadStringLoc(2057, "Attack"))
    spriteList.AddItem (LoadStringLoc(2058, "Defend"))
    spriteList.AddItem (LoadStringLoc(822, "Special Move"))
    spriteList.AddItem (LoadStringLoc(2059, "Die"))
    
    Dim t As Long
    For t = 0 To UBound(enemylist(activeEnemyIndex).theData.customGfxNames)
        If enemylist(activeEnemyIndex).theData.customGfxNames(t) <> "" Then
            spriteList.AddItem (enemylist(activeEnemyIndex).theData.customGfxNames(t))
        End If
    Next t
    
    spriteList.ListIndex = 0
End Sub

Private Sub cmdAdd_Click(): On Error Resume Next
    'enter new custom anim
   
    Dim idx As Long, newName As String
    idx = spriteList.ListIndex
    If idx = -1 Then idx = 0
    
    newName = InputBox(LoadStringLoc(2063, "Enter the handle for a new animation"))
    If LenB(newName) Then
        Call enemyAddCustomGfx(enemylist(activeEnemyIndex).theData, newName, vbNullString)
        Call infofill
        spriteList.ListIndex = idx
    End If
End Sub

Private Sub cmdBrowse_Click()
    On Error Resume Next
    Dim file As String, fileTypes As String, idx As Long
    
    fileTypes = "RPG Toolkit Animation (*.anm)|*.anm|All files(*.*)|*.*"
    If browseFileDialog(Me.hwnd, projectPath & miscPath, "Select Animation", "anm", fileTypes, file) Then
        Text1.Text = file
   
        idx = spriteList.ListIndex
        If idx = -1 Then idx = 0
        
        If idx < UBound(enemylist(activeEnemyIndex).theData.gfx) Then
            enemylist(activeEnemyIndex).theData.gfx(idx) = file
        Else
            idx = enemyGetCustomHandleIdx(enemylist(activeEnemyIndex).theData, idx - UBound(enemylist(activeEnemyIndex).theData.gfx))
            enemylist(activeEnemyIndex).theData.customGfx(idx) = file
        End If
    End If
End Sub

Private Sub cmdRemove_Click(): On Error Resume Next
    
    Dim idx As Long, dx As Long
    
    idx = spriteList.ListIndex
    If idx = -1 Then idx = 0
    
    If idx < UBound(enemylist(activeEnemyIndex).theData.gfx) Then
        MsgBox LoadStringLoc(2062, "Cannot remove system animations")
    Else
        dx = enemyGetCustomHandleIdx(enemylist(activeEnemyIndex).theData, idx - UBound(enemylist(activeEnemyIndex).theData.gfx))
        enemylist(activeEnemyIndex).theData.customGfx(dx) = ""
        enemylist(activeEnemyIndex).theData.customGfxNames(dx) = ""
        Call infofill
        spriteList.ListIndex = idx
    End If
End Sub

Private Sub cmdOK_Click(): On Error Resume Next
    Unload Me
End Sub

Private Sub cmdAnimate_Click(): On Error Resume Next
    'play animation...
    
    Dim idx As Long, anmFile As String, dx As Long
    idx = spriteList.ListIndex
    If idx = -1 Then idx = 0
    
    If idx < UBound(enemylist(activeEnemyIndex).theData.gfx) Then
        anmFile = enemylist(activeEnemyIndex).theData.gfx(idx)
    Else
        dx = enemyGetCustomHandleIdx(enemylist(activeEnemyIndex).theData, idx - UBound(enemylist(activeEnemyIndex).theData.gfx))
        anmFile = enemylist(activeEnemyIndex).theData.customGfx(dx)
    End If
    
    If LenB(anmFile) And fileExists(projectPath & miscPath & anmFile) Then
        'play animation
        animationHost.file = projectPath & miscPath & anmFile
        animationHost.repeats = 3
        animationHost.Show vbModal
    End If
End Sub

Private Sub Form_Load(): On Error Resume Next
    Call infofill
End Sub

Private Sub spriteList_Click(): On Error Resume Next
    Dim idx As Long, dx As Long
    idx = spriteList.ListIndex
    If idx = -1 Then idx = 0
    
    If idx < UBound(enemylist(activeEnemyIndex).theData.gfx) Then
        Text1.Text = enemylist(activeEnemyIndex).theData.gfx(idx)
    Else
        dx = enemyGetCustomHandleIdx(enemylist(activeEnemyIndex).theData, idx - UBound(enemylist(activeEnemyIndex).theData.gfx))
        Text1.Text = enemylist(activeEnemyIndex).theData.customGfx(dx)
    End If
End Sub

Private Sub spriteList_DblClick(): On Error Resume Next
    Call cmdAnimate_Click
End Sub

Private Sub Text1_Change(): On Error Resume Next
    Dim idx As Long, dx As Long
    idx = spriteList.ListIndex
    If idx = -1 Then idx = 0
    
    If idx < UBound(enemylist(activeEnemyIndex).theData.gfx) Then
        enemylist(activeEnemyIndex).theData.gfx(idx) = Text1.Text
    Else
        dx = enemyGetCustomHandleIdx(enemylist(activeEnemyIndex).theData, idx - UBound(enemylist(activeEnemyIndex).theData.gfx))
        enemylist(activeEnemyIndex).theData.customGfx(dx) = Text1.Text
    End If
End Sub



VERSION 5.00
Begin VB.Form characterGraphics 
   Appearance      =   0  'Flat
   BackColor       =   &H80000005&
   BorderStyle     =   0  'None
   Caption         =   "Character Graphics"
   ClientHeight    =   6375
   ClientLeft      =   435
   ClientTop       =   840
   ClientWidth     =   7575
   Icon            =   "characterGraphics.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   ScaleHeight     =   6375
   ScaleWidth      =   7575
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Tag             =   "1236"
   Begin VB.ListBox lstBattle 
      Appearance      =   0  'Flat
      CausesValidation=   0   'False
      Height          =   1005
      ItemData        =   "characterGraphics.frx":0CCA
      Left            =   240
      List            =   "characterGraphics.frx":0CCC
      TabIndex        =   9
      Top             =   3000
      Width           =   3015
   End
   Begin Toolkit.TKTopBar TopBar 
      Height          =   480
      Left            =   0
      TabIndex        =   4
      Top             =   0
      Width           =   5175
      _extentx        =   9128
      _extenty        =   847
      Object.width           =   5175
      caption         =   "Character Sprite List"
   End
   Begin Toolkit.TKButton butOK 
      Height          =   375
      Left            =   6720
      TabIndex        =   3
      Top             =   720
      Width           =   735
      _extentx        =   661
      _extenty        =   661
      Object.width           =   360
      caption         =   "OK"
   End
   Begin VB.Frame Frame1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   5535
      Left            =   120
      TabIndex        =   0
      Top             =   600
      Width           =   6495
      Begin VB.ListBox lstStand 
         Appearance      =   0  'Flat
         CausesValidation=   0   'False
         Height          =   1590
         ItemData        =   "characterGraphics.frx":0CCE
         Left            =   3240
         List            =   "characterGraphics.frx":0CD0
         TabIndex        =   16
         Top             =   435
         Width           =   3015
      End
      Begin Toolkit.TKButton butDelete 
         Height          =   375
         Left            =   1440
         TabIndex        =   13
         Top             =   4920
         Width           =   1095
         _extentx        =   661
         _extenty        =   661
         Object.width           =   360
         caption         =   "Delete"
      End
      Begin Toolkit.TKButton butNew 
         Height          =   375
         Left            =   120
         TabIndex        =   12
         Top             =   4920
         Width           =   1215
         _extentx        =   661
         _extenty        =   661
         Object.width           =   360
         caption         =   "New"
      End
      Begin VB.PictureBox picStop 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         ForeColor       =   &H80000008&
         Height          =   435
         Left            =   3840
         MousePointer    =   99  'Custom
         Picture         =   "characterGraphics.frx":0CD2
         ScaleHeight     =   405
         ScaleWidth      =   435
         TabIndex        =   11
         Top             =   4920
         Width           =   465
      End
      Begin VB.ListBox lstCustom 
         Appearance      =   0  'Flat
         CausesValidation=   0   'False
         Height          =   1005
         ItemData        =   "characterGraphics.frx":41CA
         Left            =   120
         List            =   "characterGraphics.frx":41CC
         TabIndex        =   7
         Top             =   3840
         Width           =   3015
      End
      Begin VB.PictureBox picPlay 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         ForeColor       =   &H80000008&
         Height          =   442
         Left            =   3240
         MousePointer    =   99  'Custom
         Picture         =   "characterGraphics.frx":41CE
         ScaleHeight     =   405
         ScaleWidth      =   435
         TabIndex        =   6
         Top             =   4920
         Width           =   465
      End
      Begin VB.PictureBox picBrowse 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   375
         Left            =   5760
         MousePointer    =   99  'Custom
         Picture         =   "characterGraphics.frx":4B58
         ScaleHeight     =   375
         ScaleWidth      =   615
         TabIndex        =   5
         Top             =   4440
         Width           =   615
      End
      Begin VB.ListBox lstMove 
         Appearance      =   0  'Flat
         CausesValidation=   0   'False
         Height          =   1590
         ItemData        =   "characterGraphics.frx":5142
         Left            =   120
         List            =   "characterGraphics.frx":5144
         TabIndex        =   2
         Top             =   435
         Width           =   3015
      End
      Begin VB.TextBox txtAnim 
         Appearance      =   0  'Flat
         Height          =   285
         Left            =   3240
         TabIndex        =   1
         Top             =   4560
         Width           =   2415
      End
      Begin VB.PictureBox picAnim 
         Appearance      =   0  'Flat
         AutoRedraw      =   -1  'True
         BackColor       =   &H80000005&
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   735
         Left            =   4320
         ScaleHeight     =   49
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   81
         TabIndex        =   18
         Top             =   3480
         Width           =   1215
      End
      Begin VB.Label lblToBig 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "The animation is to big for this animation screen. Press the play button to view the animation in the animationhost."
         ForeColor       =   &H80000008&
         Height          =   975
         Left            =   3360
         TabIndex        =   19
         Top             =   2520
         Visible         =   0   'False
         Width           =   2175
      End
      Begin VB.Shape Shape2 
         BorderStyle     =   3  'Dot
         Height          =   1935
         Left            =   3240
         Top             =   2400
         Width           =   2415
      End
      Begin VB.Label lblAnimation 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "Animation"
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   3240
         TabIndex        =   17
         Top             =   2160
         Width           =   2535
      End
      Begin VB.Label lblWalking 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "Walking Animations"
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   120
         TabIndex        =   15
         Top             =   195
         Width           =   3015
      End
      Begin VB.Label lblStanding 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "Standing Animations/Graphics"
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   3240
         TabIndex        =   14
         Top             =   195
         Width           =   3015
      End
      Begin VB.Label lblBattle 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "Battle Animations"
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   120
         TabIndex        =   10
         Top             =   2160
         Width           =   3015
      End
      Begin VB.Label lblCustom 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "Custom Animations/Postures"
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   120
         TabIndex        =   8
         Top             =   3600
         Width           =   3015
      End
   End
   Begin VB.Shape Shape1 
      Height          =   6375
      Left            =   0
      Top             =   0
      Width           =   7575
   End
End
Attribute VB_Name = "characterGraphics"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'========================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'========================================================================

Option Explicit

'========================================================================
' Set the info of the listboxes
'========================================================================
Private Sub fillInfo(Optional ByVal list As ListBox, Optional ByVal Index As Integer): On Error Resume Next
    
    'The movement listbox
    With lstMove
    
        'First clear it
        .Clear
        
        'Now add the items
        .AddItem "South (Front View)"
        .AddItem "North (Rear View)"
        .AddItem "East (Right View)"
        .AddItem "West (Left View)"
        .AddItem "North-West"
        .AddItem "East-West"
        .AddItem "South-West"
        .AddItem "South-East"
    
    End With
    
    'The standing listbox
    With lstStand
    
        'First clear it
        .Clear
        
        'Now add the items
        .AddItem "South (Front View)"
        .AddItem "North (Rear View)"
        .AddItem "East (Right View)"
        .AddItem "West (Left View)"
        .AddItem "North-West"
        .AddItem "East-West"
        .AddItem "South-West"
        .AddItem "South-East"
        
    End With
    
    'Battle animations
    With lstBattle
        
        'First clear it
        .Clear
        
        'Now add them
        .AddItem "Attack"
        .AddItem "Defend"
        .AddItem "Special Move"
        .AddItem "Die"
        .AddItem "Rest"
        
    End With
    
    'The custom listbox
    With playerList(activePlayerIndex).theData
    
        'First clear it
        lstCustom.Clear
        
        'Go through the custom animations loop
        Dim i As Integer
        For i = 0 To UBound(.customGfxNames)
            If .customGfxNames(i) <> "" Then
            
                'Add it to the listbox
                lstCustom.AddItem (.customGfxNames(i))
                
            End If
        Next i
        
    End With

    'Set the selected animation
    If IsMissing(list) And IsMissing(Index) Then
        lstMove.ListIndex = 0
    Else
        list.ListIndex = Index
    End If
    
End Sub

'========================================================================
' Cancel button
'========================================================================
Private Sub butDelete_click(): On Error Resume Next
    
    'Exit sub if no animation is selected
    If lstCustom.ListIndex = -1 Then Exit Sub
    
    'See which animation the player wants to delete
    Dim dx As Long
    dx = playerGetCustomHandleIdx(playerList(activePlayerIndex).theData, lstCustom.ListIndex - UBound(playerList(activePlayerIndex).theData.gfx))
    
    'Delete it
    playerList(activePlayerIndex).theData.customGfx(dx) = ""
    playerList(activePlayerIndex).theData.customGfxNames(dx) = ""
    
    'Update
    Call fillInfo
    
    'Set the listIndex to the first animation
    lstCustom.ListIndex = 0

End Sub

'========================================================================
' New button
'========================================================================
Private Sub butNew_click(): On Error Resume Next
    
    'Ask what handle the user wants
    Dim newName As String
    newName = InputBox(LoadStringLoc(2063, "Enter the handle for a new animation"))
    
    If newName <> "" Then
    
        'Add it to the main data
        Call playerAddCustomGfx(playerList(activePlayerIndex).theData, newName$, "")
        
        'Update
        Call fillInfo
        
        'Set the listIndex to the just entered animation
        lstCustom.ListIndex = lstCustom.ListCount - 1
        
    End If
    
End Sub

'========================================================================
' Form_Load
'========================================================================
Private Sub Form_Load(): On Error Resume Next

    'Localize this form
    Call LocalizeForm(Me)
    
    'Make sure the top bar knows which form it is on
    Set TopBar.theForm = Me
    
    'Fill in the data
    Call fillInfo
    
    'Set the mousecursor of the 2 buttons
    picPlay.MouseIcon = Images.MouseLink
    picStop.MouseIcon = Images.MouseLink
    picBrowse.MouseIcon = Images.MouseLink
    
    'Set the default selected item
    lstMove.ListIndex = 0
    
End Sub

'========================================================================
' When you click on the Walking Animations listbox
'========================================================================
Private Sub lstMove_Click(): On Error Resume Next
    
    'Update the textbox
    txtAnim.Text = playerList(activePlayerIndex).theData.gfx(lstMove.ListIndex)
    
    'Update the animation
    If ignore = 0 Then Call setAnim
    
End Sub

'========================================================================
' When you click on the Standing Animations/Graphics listbox
'========================================================================
Private Sub lstStand_Click(): On Error Resume Next

    'Update the textbox
    txtAnim.Text = playerList(activePlayerIndex).theData.standingGfx(lstStand.ListIndex)
    
    'Update the animation
    If ignore = 0 Then Call setAnim

End Sub

'========================================================================
' When you click on the Battle Animations listbox
'========================================================================
Private Sub lstBattle_Click(): On Error Resume Next

    'Update the textbox
    txtAnim.Text = playerList(activePlayerIndex).theData.gfx(lstBattle.ListIndex + 8)
    
    'Update the animation
    If ignore = 0 Then Call setAnim

End Sub

'========================================================================
' When you click on the Custom Animations/Postures listbox
'========================================================================
Private Sub lstCustom_Click(): On Error Resume Next

    'Update the textbox
    Dim dx As Integer
    dx = playerGetCustomHandleIdx(playerList(activePlayerIndex).theData, lstCustom.ListIndex)
    txtAnim.Text = playerList(activePlayerIndex).theData.customGfx(dx)
    
    'Update the animation
    If ignore = 0 Then Call setAnim

End Sub

'========================================================================
' When this gets focus, set the other listIndexes to -1
'========================================================================
Private Sub lstMove_GotFocus(): On Error Resume Next
    lstCustom.ListIndex = -1
    lstBattle.ListIndex = -1
    lstStand.ListIndex = -1
End Sub

'========================================================================
' When this gets focus, set the other listIndexes to -1
'========================================================================
Private Sub lstBattle_GotFocus(): On Error Resume Next
    lstCustom.ListIndex = -1
    lstMove.ListIndex = -1
    lstStand.ListIndex = -1
End Sub

'========================================================================
' When this gets focus, set the other listIndexes to -1
'========================================================================
Private Sub lstCustom_GotFocus(): On Error Resume Next
    lstBattle.ListIndex = -1
    lstMove.ListIndex = -1
    lstStand.ListIndex = -1
End Sub

'========================================================================
' When this gets focus, set the other listIndexes to -1
'========================================================================
Private Sub lstStand_GotFocus(): On Error Resume Next
    lstCustom.ListIndex = -1
    lstMove.ListIndex = -1
    lstBattle.ListIndex = -1
End Sub

'========================================================================
' Set the animation and show the first frame of the animation
'========================================================================
Private Sub setAnim(): On Error Resume Next
    
    'Firstly, clear the label
    lblToBig.Visible = False
    
    'And, show the picturebox
    picAnim.Visible = True
    
    'First open the animation
    Dim anmFile As String
    
    anmFile = getAnim()
    
    If anmFile <> "" And fileExists(projectPath + miscPath + anmFile) Then
        
        'Open the animation
        Dim anm As TKAnimation
        Call openAnimation(projectPath & miscPath & anmFile, anm)
        
        If anm.animSizeX > (2000 / Screen.TwipsPerPixelX) Or anm.animSizeY > (1600 / Screen.TwipsPerPixelY) Then
            
            'To big for the animation picturebox, tell the user
            picAnim.Visible = False
            lblToBig.Visible = True
        
        Else
        
            'Position the picture box & set the width and height
            picAnim.width = anm.animSizeX * Screen.TwipsPerPixelX
            picAnim.height = anm.animSizeY * Screen.TwipsPerPixelY
            picAnim.Left = Shape2.Left + 100
            picAnim.Top = Shape2.Top + 100
            
            'Draw it
            picAnim.cls
            Call AnimDrawFrame(anm, 0, 0, 0, picAnim.hdc)
            picAnim.Refresh
            
        End If
        
    Else
    
        'There is no animation, hide the picturebox just to be sure
        picAnim.Visible = False
        
    End If
    
End Sub

'========================================================================
' Browse button
'========================================================================
Private Sub picBrowse_Click(): On Error Resume Next

    'Set the info for the DLG we will open
    Dim dlg As FileDialogInfo
    ChDir (currentDir$)
    dlg.strDefaultFolder = projectPath$ + miscPath$
    dlg.strTitle = "Select Animation"
    dlg.strDefaultExt = "anm"
    dlg.strFileTypes = "RPG Toolkit Animation (*.anm)|*.anm|All files(*.*)|*.*"
    
    'Exit Sub if pressed cancel
    If Not OpenFileDialog(dlg, Me.hwnd) Then Exit Sub
    
    'Needed variables
    Dim noPath As String, idx As Long, dx As Long
    filename(1) = dlg.strSelectedFile
    noPath = dlg.strSelectedFileNoPath

    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    
    'Copy the file to the good folder
    FileCopy filename(1), projectPath + miscPath + noPath
    
    'Put the info in the textbox
    txtAnim.Text = noPath
    
    'Get the selected animation
    idx = lstCustom.ListIndex
    If idx = -1 Then idx = 0
    
    With playerList(activePlayerIndex).theData
    
        'See what exactly the player wants to add
        If lstMove.ListIndex <> -1 Then
            
            'A built in move!
            .gfx(idx) = noPath
            
        ElseIf lstStand.ListIndex <> -1 Then
            
            'A standing animation/graphic!
            .standingGfx(idx) = noPath
            
        ElseIf lstBattle.ListIndex <> -1 Then
            
            'A battle move!
            .gfx(idx + 8) = noPath
        
        Else
            
            'A custom animation!
            dx = playerGetCustomHandleIdx(playerList(activePlayerIndex).theData, idx - UBound(.gfx))
            .customGfx(dx) = noPath
            
        End If
    
    End With
    
    'Redraw the picturebox
    Call setAnim
    
End Sub

'========================================================================
' The OK Button, just unload
'========================================================================
Private Sub butOK_Click(): On Error Resume Next
    Unload Me
End Sub

'========================================================================
' Stop button
'========================================================================
Private Sub picStop_Click(): On Error Resume Next
    picPlay.Enabled = True
End Sub

'========================================================================
' The Play Button
'========================================================================
Private Sub picPlay_Click(): On Error Resume Next

    'Open the animation
    Dim anmFile As String
    
    anmFile = getAnim()
    
    If anmFile <> "" And fileExists(projectPath + miscPath + anmFile) Then
    
        'Open the animation
        Dim anm As TKAnimation
        Call openAnimation(projectPath & miscPath & anmFile, anm)
        
        If anm.animSizeX > (2000 / Screen.TwipsPerPixelX) Or anm.animSizeY > (1600 / Screen.TwipsPerPixelY) Then

            'To big for the animation screen - open in animation host
            animationHost.file = projectPath + miscPath + anmFile
            animationHost.repeats = 3
            animationHost.Show vbModal
        
        Else
        
            'Position the picture box & set the width and height
            picAnim.width = anm.animSizeX * Screen.TwipsPerPixelX
            picAnim.height = anm.animSizeY * Screen.TwipsPerPixelY
            picAnim.Left = Shape2.Left + 100
            picAnim.Top = Shape2.Top + 100
            
            'Un-enable some stuff
            picPlay.Enabled = False
            ignore = 1
            
            'Animate it
            MsgBox anm.animFrame(0)
            picAnim.cls
            Do Until picPlay.Enabled = True
            
               Call AnimateAt(anm, 0, 0, anm.animSizeX, anm.animSizeY, picAnim)
               DoEvents
               
            Loop
            
            ignore = 0
        End If

    End If

End Sub

'========================================================================
' Get the animationfile
'========================================================================
Private Function getAnim() As String: On Error Resume Next

    With playerList(activePlayerIndex).theData
    
        'See in which listbox we are
        If lstMove.ListIndex <> -1 Then
                    
            'Moves
            getAnim = .gfx(lstMove.ListIndex)
                    
        ElseIf lstStand.ListIndex <> -1 Then
                    
            'Stands
            .standingGfx(lstStand.ListIndex) = .standingGfx(lstMove.ListIndex)
                    
        ElseIf lstBattle.ListIndex <> -1 Then
                    
            'Battle
            getAnim = .gfx(lstBattle.ListIndex + 8)
                
        ElseIf lstCustom.ListIndex <> -1 Then
                    
            'Custom
            getAnim = .customGfx(lstCustom.ListIndex)
                    
        Else
        
            'None - return emptyness
            getAnim = ""
            
        End If
    
    End With
     
End Function

'========================================================================
' When you type something in the textbox
'========================================================================
Private Sub txtAnim_Change(): On Error Resume Next
    
    With playerList(activePlayerIndex).theData
    
        'See in which listbox we are
        If lstMove.ListIndex <> -1 Then
                    
            'Moves
            .gfx(lstMove.ListIndex) = txtAnim.Text
                    
        ElseIf lstStand.ListIndex <> -1 Then
                    
            'Stands
            .standingGfx(lstMove.ListIndex) = txtAnim.Text
                    
        ElseIf lstBattle.ListIndex <> -1 Then
                    
            'Battle
            .gfx(lstBattle.ListIndex + 8) = txtAnim.Text
                
        ElseIf lstCustom.ListIndex <> -1 Then
                    
            'Custom
            .customGfx(lstCustom.ListIndex) = txtAnim.Text
            
        End If
        
    End With
    
    'Also update the animation
    Call setAnim
    
End Sub

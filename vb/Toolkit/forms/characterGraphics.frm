VERSION 5.00
Begin VB.Form characterGraphics 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Character Sprite List"
   ClientHeight    =   6495
   ClientLeft      =   480
   ClientTop       =   1275
   ClientWidth     =   7575
   Icon            =   "characterGraphics.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   6495
   ScaleWidth      =   7575
   StartUpPosition =   2  'CenterScreen
   Tag             =   "1236"
   Begin VB.CommandButton butOK 
      Caption         =   "OK"
      Default         =   -1  'True
      Height          =   375
      Left            =   6720
      TabIndex        =   12
      Top             =   240
      Width           =   735
   End
   Begin VB.ListBox lstBattle 
      CausesValidation=   0   'False
      Height          =   1035
      ItemData        =   "characterGraphics.frx":0CCA
      Left            =   240
      List            =   "characterGraphics.frx":0CCC
      TabIndex        =   4
      Top             =   2520
      Width           =   3015
   End
   Begin VB.Frame Frame1 
      Height          =   6135
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   6495
      Begin VB.PictureBox Picture2 
         BorderStyle     =   0  'None
         Height          =   375
         Left            =   3240
         ScaleHeight     =   375
         ScaleWidth      =   3135
         TabIndex        =   21
         Top             =   4440
         Width           =   3135
         Begin VB.CommandButton picBrowse 
            Caption         =   "..."
            Height          =   255
            Left            =   2520
            TabIndex        =   23
            Top             =   0
            Width           =   495
         End
         Begin VB.TextBox txtAnim 
            Height          =   285
            Left            =   0
            TabIndex        =   22
            Top             =   0
            Width           =   2415
         End
      End
      Begin VB.PictureBox Picture1 
         BorderStyle     =   0  'None
         Height          =   1095
         Left            =   120
         ScaleHeight     =   1095
         ScaleWidth      =   6255
         TabIndex        =   13
         Top             =   4920
         Width           =   6255
         Begin VB.TextBox txtFrameTime 
            Height          =   285
            Left            =   4080
            TabIndex        =   18
            Top             =   720
            Width           =   735
         End
         Begin VB.TextBox txtIdleTime 
            Height          =   285
            Left            =   1680
            TabIndex        =   17
            Top             =   720
            Width           =   735
         End
         Begin VB.CommandButton picPlay 
            Caption         =   ">"
            Height          =   375
            Left            =   3120
            TabIndex        =   16
            Top             =   0
            Width           =   375
         End
         Begin VB.CommandButton butDelete 
            Caption         =   "Delete"
            Height          =   375
            Left            =   1440
            TabIndex        =   15
            Top             =   0
            Width           =   855
         End
         Begin VB.CommandButton butNew 
            Caption         =   "New"
            Height          =   375
            Left            =   360
            TabIndex        =   14
            Top             =   0
            Width           =   855
         End
         Begin VB.Label lblSecond2 
            BackStyle       =   0  'Transparent
            Caption         =   "Seconds between each step:"
            Height          =   495
            Left            =   2640
            TabIndex        =   20
            Top             =   600
            Width           =   1575
         End
         Begin VB.Label lblDelay 
            BackStyle       =   0  'Transparent
            Caption         =   "Seconds before player is considered idle:"
            Height          =   495
            Left            =   0
            TabIndex        =   19
            Top             =   600
            Width           =   1695
         End
      End
      Begin VB.ListBox lstStand 
         CausesValidation=   0   'False
         Height          =   1620
         ItemData        =   "characterGraphics.frx":0CCE
         Left            =   3240
         List            =   "characterGraphics.frx":0CD0
         TabIndex        =   8
         Top             =   435
         Width           =   3015
      End
      Begin VB.ListBox lstCustom 
         CausesValidation=   0   'False
         Height          =   840
         ItemData        =   "characterGraphics.frx":0CD2
         Left            =   120
         List            =   "characterGraphics.frx":0CD4
         TabIndex        =   2
         Top             =   3840
         Width           =   3015
      End
      Begin VB.ListBox lstMove 
         CausesValidation=   0   'False
         Height          =   1620
         ItemData        =   "characterGraphics.frx":0CD6
         Left            =   120
         List            =   "characterGraphics.frx":0CD8
         TabIndex        =   1
         Top             =   435
         Width           =   3015
      End
      Begin VB.PictureBox picAnim 
         AutoRedraw      =   -1  'True
         BorderStyle     =   0  'None
         Height          =   735
         Left            =   4320
         ScaleHeight     =   49
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   81
         TabIndex        =   10
         Top             =   3480
         Width           =   1215
      End
      Begin VB.Label lblToBig 
         Caption         =   "The animation is to big for this animation screen. Press the play button to view the animation in a new window."
         Height          =   975
         Left            =   3360
         TabIndex        =   11
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
         Caption         =   "Animation"
         Height          =   255
         Left            =   3240
         TabIndex        =   9
         Top             =   2160
         Width           =   2535
      End
      Begin VB.Label lblWalking 
         Caption         =   "Walking Animations"
         Height          =   255
         Left            =   120
         TabIndex        =   7
         Top             =   195
         Width           =   3015
      End
      Begin VB.Label lblStanding 
         Caption         =   "Idle Animations"
         Height          =   255
         Left            =   3240
         TabIndex        =   6
         Top             =   195
         Width           =   3015
      End
      Begin VB.Label lblBattle 
         Caption         =   "Battle Animations"
         Height          =   255
         Left            =   120
         TabIndex        =   5
         Top             =   2160
         Width           =   3015
      End
      Begin VB.Label lblCustom 
         Caption         =   "Custom Animations/Postures"
         Height          =   255
         Left            =   120
         TabIndex        =   3
         Top             =   3600
         Width           =   3015
      End
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
Private Sub fillInfo(Optional ByVal list As ListBox, Optional ByVal index As Integer): On Error Resume Next

    'Delay and idle time
    txtFrameTime.Text = CStr(playerList(activePlayerIndex).theData.speed)
    txtIdleTime.Text = CStr(playerList(activePlayerIndex).theData.idleTime)

    'The movement listbox
    With lstMove
    
        'First clear it
        Call .Clear
        
        'Now add the items
        Call .AddItem("South (Front View)")
        Call .AddItem("North (Rear View)")
        Call .AddItem("East (Right View)")
        Call .AddItem("West (Left View)")
        Call .AddItem("North-West")
        Call .AddItem("North-East")
        Call .AddItem("South-West")
        Call .AddItem("South-East")
    
    End With
    
    With lstStand
    
        'First clear it
        Call .Clear
        
        'Now add the items
        Call .AddItem("South (Front View)")
        Call .AddItem("North (Rear View)")
        Call .AddItem("East (Right View)")
        Call .AddItem("West (Left View)")
        Call .AddItem("North-West")
        Call .AddItem("North-West")
        Call .AddItem("South-West")
        Call .AddItem("South-East")
    
    End With
    
    'Battle animations
    With lstBattle
        
        'First clear it
        Call .Clear
        
        'Now add them
        Call .AddItem("Attack")
        Call .AddItem("Defend")
        Call .AddItem("Special Move")
        Call .AddItem("Die")
        Call .AddItem("Rest")

    End With

    'The custom listbox
    With playerList(activePlayerIndex).theData
    
        'First clear it
        Call lstCustom.Clear
        
        'Go through the custom animations loop
        Dim i As Integer
        For i = 0 To UBound(.customGfxNames)
            If .customGfxNames(i) <> "" Then

                'Add it to the listbox
                Call lstCustom.AddItem(.customGfxNames(i))

            End If
        Next i

    End With

    'Set the selected animation
    If IsMissing(list) And IsMissing(index) Then
        lstMove.ListIndex = 0
    Else
        list.ListIndex = index
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
    
    If (newName <> "") Then
    
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
    ' Call LocalizeForm(Me)
       
    'Fill in the data
    Call fillInfo
    
    'Set the mousecursor of the 2 buttons
    picPlay.MouseIcon = Images.MouseLink()
    picBrowse.MouseIcon = Images.MouseLink()
    
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
    If (ignore = 0) Then Call setAnim

End Sub

'========================================================================
' Double-click on a list box
'========================================================================
Private Sub lstMove_DblClick()
    Call picBrowse_Click
End Sub
Private Sub lstStand_DblClick()
    Call picBrowse_Click
End Sub
Private Sub lstBattle_DblClick()
    Call picBrowse_Click
End Sub
Private Sub lstCustom_DblClick()
    Call picBrowse_Click
End Sub

'========================================================================
' When you click on the Standing Animations/Graphics listbox
'========================================================================
Private Sub lstStand_Click(): On Error Resume Next

    'Update the textbox
    txtAnim.Text = playerList(activePlayerIndex).theData.standingGfx(lstStand.ListIndex)
    
    'Update the animation
    If (ignore = 0) Then Call setAnim

End Sub

'========================================================================
' When you click on the Battle Animations listbox
'========================================================================
Private Sub lstBattle_Click(): On Error Resume Next

    'Update the textbox
    txtAnim.Text = playerList(activePlayerIndex).theData.gfx(lstBattle.ListIndex + 8)
    
    'Update the animation
    If (ignore = 0) Then Call setAnim

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
    If (ignore = 0) Then Call setAnim

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
    
    If (anmFile <> "") And (fileExists(projectPath & miscPath & anmFile)) Then
        
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
            picAnim.Height = anm.animSizeY * Screen.TwipsPerPixelY
            picAnim.Left = Shape2.Left + 100
            picAnim.Top = Shape2.Top + 100
            
            'Draw it
            Call picAnim.Cls
            Call AnimDrawFrame(anm, 0, 0, 0, picAnim.hdc, False)
            Call picAnim.Refresh
            
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
    Call ChDir(currentDir)
    With dlg
        .strDefaultFolder = projectPath$ & miscPath$
        .strTitle = "Select Animation"
        .strDefaultExt = "anm"
        .strFileTypes = "RPG Toolkit Animation (*.anm)|*.anm|All files(*.*)|*.*"
    End With
    
    'Exit Sub if pressed cancel
    If Not OpenFileDialog(dlg, Me.hwnd) Then Exit Sub
    
    'Needed variables
    Dim noPath As String, idx As Long, dx As Long
    filename(1) = dlg.strSelectedFile
    noPath = dlg.strSelectedFileNoPath

    Call ChDir(currentDir$)
    If (filename$(1) = "") Then Exit Sub
    
    'Copy the file to the good folder
    Call FileCopy(filename(1), projectPath & miscPath & noPath)
    
    'Put the info in the textbox
    txtAnim.Text = noPath
       
    With playerList(activePlayerIndex).theData
    
        'See what exactly the player wants to add
        If lstMove.SelCount <> 0 Then
            
            'A built in move!
            .gfx(lstMove.ListIndex) = noPath
            
        ElseIf lstStand.SelCount <> 0 Then
            
            'A standing animation/graphic!
            .standingGfx(lstStand.ListIndex) = noPath
            
        ElseIf lstBattle.SelCount <> 0 Then
            
            'A battle move!
            .gfx(lstBattle.ListIndex + 8) = noPath
        
        Else
            
            'A custom animation!
            dx = playerGetCustomHandleIdx(playerList(activePlayerIndex).theData, lstCustom.ListIndex - UBound(.gfx))
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
    Call Unload(Me)
End Sub

'========================================================================
' The Play Button
'========================================================================
Private Sub picPlay_Click(): On Error Resume Next

    'Open the animation
    Dim anmFile As String
    
    anmFile = getAnim()
    
    If (anmFile <> "") And (fileExists(projectPath & miscPath & anmFile)) Then
    
        'Open the animation
        Dim anm As TKAnimation
        Call openAnimation(projectPath & miscPath & anmFile, anm)
        'Change the animation's speed to the player's speed for the walking animations (only).
        If lstMove.SelCount Then anm.animPause = playerList(activePlayerIndex).theData.speed
        
        If anm.animSizeX > (2000 / Screen.TwipsPerPixelX) Or anm.animSizeY > (1600 / Screen.TwipsPerPixelY) Then

            'To big for the animation screen - open in animation host
            With animationHost
                .file = projectPath & miscPath & anmFile
                .repeats = 3
                Call .Show(vbModal)
            End With
        
        Else
        
            'Position the picture box & set the width and height
            With picAnim
                .width = anm.animSizeX * Screen.TwipsPerPixelX
                .Height = anm.animSizeY * Screen.TwipsPerPixelY
                .Left = Shape2.Left + 100
                .Top = Shape2.Top + 100
            End With
            
            'Un-enable some stuff
            picPlay.Visible = False
            ignore = 1
            DoEvents
            
            'Animate it
            Call picAnim.Cls
            Dim repeat As Long
            For repeat = 1 To 3
               Call AnimateAt(anm, 0, 0, anm.animSizeX, anm.animSizeY, picAnim)
               DoEvents
            Next repeat
            
            ignore = 0
            picPlay.Visible = True
        End If

    End If

End Sub

'========================================================================
' Get the animationfile
'========================================================================
Private Function getAnim() As String: On Error Resume Next

    With playerList(activePlayerIndex).theData

        'See in which listbox we are
        If (lstMove.SelCount <> 0) Then

            'Moves
            getAnim = .gfx(lstMove.ListIndex)

        ElseIf lstStand.SelCount <> 0 Then

            'Stands
            getAnim = .standingGfx(lstStand.ListIndex)

        ElseIf lstBattle.SelCount <> 0 Then

            'Battle
            getAnim = .gfx(lstBattle.ListIndex + 8)

        ElseIf lstCustom.SelCount <> 0 Then

            'Custom
            getAnim = .customGfx(lstCustom.ListIndex)

        End If

    End With

End Function

'========================================================================
' When you type something in the textbox
'========================================================================
Private Sub txtAnim_Change(): On Error Resume Next
    
    With playerList(activePlayerIndex).theData
    
        'See in which listbox we are
        If (lstMove.SelCount <> 0) Then
                    
            'Moves
            .gfx(lstMove.ListIndex) = txtAnim.Text
                    
        ElseIf lstStand.SelCount <> 0 Then
                    
            'Stands
            .standingGfx(lstStand.ListIndex) = txtAnim.Text
                    
        ElseIf lstBattle.SelCount <> 0 Then
                    
            'Battle
            .gfx(lstBattle.ListIndex + 8) = txtAnim.Text
                
        ElseIf lstCustom.SelCount <> 0 Then
                    
            'Custom
            .customGfx(lstCustom.ListIndex) = txtAnim.Text
            
        End If
        
    End With
    
    'Also update the animation
    Call setAnim
    
End Sub

'========================================================================
' Change idle time
'========================================================================
Private Sub txtIdleTime_Change()
    On Error Resume Next
    playerList(activePlayerIndex).theData.idleTime = CDbl(txtIdleTime.Text)
End Sub

'========================================================================
' Change speed
'========================================================================
Private Sub txtFrameTime_Change()
    On Error Resume Next
    playerList(activePlayerIndex).theData.speed = CDbl(txtFrameTime.Text)
End Sub

'========================================================================
' Type a key in the speed field
'========================================================================
Private Sub txtFrameTime_KeyPress(ByRef KeyAscii As Integer)
    On Error GoTo letter
    Dim ret As Double
    ret = CDbl(txtFrameTime.Text & chr(KeyAscii))
    Exit Sub
letter:
    If (KeyAscii <> 8) Then
        'Bad key
        KeyAscii = 0
    End If
End Sub

'========================================================================
' Type a key in the idle time field
'========================================================================
Private Sub txtIdleTime_KeyPress(ByRef KeyAscii As Integer)
    On Error GoTo letter
    Dim ret As Double
    ret = CDbl(txtIdleTime.Text & chr(KeyAscii))
    Exit Sub
letter:
    If (KeyAscii <> 8) Then
        'Bad key
        KeyAscii = 0
    End If
End Sub

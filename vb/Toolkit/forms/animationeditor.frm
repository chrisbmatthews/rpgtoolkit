VERSION 5.00
Begin VB.Form animationeditor 
   Caption         =   "Animation Editor (Untitled)"
   ClientHeight    =   5925
   ClientLeft      =   165
   ClientTop       =   450
   ClientWidth     =   6735
   Icon            =   "animationeditor.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   ScaleHeight     =   5925
   ScaleWidth      =   6735
   Tag             =   "1"
   Begin VB.PictureBox arena 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   3735
      Left            =   240
      ScaleHeight     =   249
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   257
      TabIndex        =   0
      Top             =   240
      Width           =   3855
   End
   Begin VB.Menu afilemnu 
      Caption         =   "File"
      Tag             =   "1201"
      Begin VB.Menu mnuNewProject 
         Caption         =   "New Project"
         Shortcut        =   ^N
      End
      Begin VB.Menu mnuNew 
         Caption         =   "New..."
         Begin VB.Menu mnuNewTile 
            Caption         =   "Tile"
         End
         Begin VB.Menu mnuNewAnimatedTile 
            Caption         =   "Animated Tile"
         End
         Begin VB.Menu mnuNewBoard 
            Caption         =   "Board"
         End
         Begin VB.Menu mnuNewPlayer 
            Caption         =   "Player"
         End
         Begin VB.Menu mnuNewItem 
            Caption         =   "Item"
         End
         Begin VB.Menu mnuNewEnemy 
            Caption         =   "Enemy"
         End
         Begin VB.Menu mnuNewRPGCodeProgram 
            Caption         =   "RPGCode Program"
         End
         Begin VB.Menu mnuNewFightBackground 
            Caption         =   "Fight Background"
         End
         Begin VB.Menu mnuNewSpecialMove 
            Caption         =   "Special Move"
         End
         Begin VB.Menu mnuNewStatusEffect 
            Caption         =   "Status Effect"
         End
         Begin VB.Menu mnuNewAnimation 
            Caption         =   "Animation"
         End
         Begin VB.Menu mnuNewTileBitmap 
            Caption         =   "Tile Bitmap"
         End
      End
      Begin VB.Menu sub1 
         Caption         =   "-"
      End
      Begin VB.Menu mnuOpenProject 
         Caption         =   "Open Project"
      End
      Begin VB.Menu mnuOpen 
         Caption         =   "Open"
         Shortcut        =   ^O
      End
      Begin VB.Menu saveanimmnu 
         Caption         =   "Save Animation"
         Shortcut        =   ^S
         Tag             =   "1530"
      End
      Begin VB.Menu saveasanimmnu 
         Caption         =   "Save Animation As"
         Shortcut        =   ^A
         Tag             =   "1531"
      End
      Begin VB.Menu mnuSaveAll 
         Caption         =   "Save All"
      End
      Begin VB.Menu sub2 
         Caption         =   "-"
      End
      Begin VB.Menu closeanimmnu 
         Caption         =   "Close"
         Tag             =   "1088"
      End
      Begin VB.Menu mnuExit 
         Caption         =   "Exit"
      End
   End
   Begin VB.Menu mnuToolkit 
      Caption         =   "Toolkit"
      Begin VB.Menu mnuTestGame 
         Caption         =   "Test Game"
         Shortcut        =   {F5}
      End
      Begin VB.Menu mnuSelectLanguage 
         Caption         =   "Select Language"
         Shortcut        =   ^L
      End
      Begin VB.Menu sub3 
         Caption         =   "-"
      End
      Begin VB.Menu mnuInstallUpgrade 
         Caption         =   "Install Upgrade"
      End
   End
   Begin VB.Menu mnuBuild 
      Caption         =   "Build"
      Begin VB.Menu mnuCreatePakFile 
         Caption         =   "Create PakFile"
      End
      Begin VB.Menu mnuMakeEXE 
         Caption         =   "Make EXE"
         Shortcut        =   {F7}
      End
      Begin VB.Menu sub4 
         Caption         =   "-"
      End
      Begin VB.Menu mnuCreateSetup 
         Caption         =   "Create Setup"
      End
   End
   Begin VB.Menu mnuWindow 
      Caption         =   "Window"
      WindowList      =   -1  'True
      Begin VB.Menu mnuShowTools 
         Caption         =   "Show/Hide Tools"
      End
      Begin VB.Menu mnushowProjectList 
         Caption         =   "Show/Hide Project List"
      End
      Begin VB.Menu sub5 
         Caption         =   "-"
      End
      Begin VB.Menu mnuTileHorizontally 
         Caption         =   "Tile Horizontally"
      End
      Begin VB.Menu mnuTileVertically 
         Caption         =   "Tile Vertically"
      End
      Begin VB.Menu mnuCascade 
         Caption         =   "Cascade"
      End
      Begin VB.Menu mnuArrangeIcons 
         Caption         =   "Arrange Icons"
      End
   End
   Begin VB.Menu mnuHelp 
      Caption         =   "Help"
      Begin VB.Menu mnuUsersGuide 
         Caption         =   "User's Guide"
         Shortcut        =   {F1}
      End
      Begin VB.Menu mnuRPGCodePrimer 
         Caption         =   "RPGCode Primer"
      End
      Begin VB.Menu mnuRPGCodeReference 
         Caption         =   "RPGCode Reference"
      End
      Begin VB.Menu sub7 
         Caption         =   "-"
      End
      Begin VB.Menu mnuTutorial 
         Caption         =   "Tutorial"
      End
      Begin VB.Menu mnuHistorytxt 
         Caption         =   "History.txt"
      End
      Begin VB.Menu sub8 
         Caption         =   "-"
      End
      Begin VB.Menu mnuRegistrationInfo 
         Caption         =   "Registration Info"
      End
      Begin VB.Menu mnuAbout 
         Caption         =   "About"
      End
   End
End
Attribute VB_Name = "animationeditor"
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

'Index into the vector of animations maintained in commonanimation
Public dataIndex As Long

'========================================================================
' Identify type of form
'========================================================================
Public Function formType() As Long
    On Error Resume Next
    formType = FT_ANIMATION
End Function

'========================================================================
' Initialize the animation
'========================================================================
Private Sub fillInfo(): On Error Resume Next

    With animationList(activeAnimationIndex).theData
    
        'Animation size
        tkMainForm.txtAnimXSize.Text = str(.animSizeX)
        tkMainForm.txtAnimYSize.Text = str(.animSizeY)
        tkMainForm.txtAnimXSize.Enabled = False
        tkMainForm.txtAnimYSize.Enabled = False
        
        'If the sizes are 0, set them to 64
        If .animSizeX = 0 Then .animSizeX = 64
        If .animSizeY = 0 Then .animSizeY = 64
        
        'See which size it is
        If (.animSizeX = 64 And .animSizeY = 64) Or _
           (.animSizeX = 128 And .animSizeX = 128) Or _
           (.animSizeX = 256 And .animSizeY = 256) Or _
           (.animSizeX = 32 And .animSizeY = 64) Then
            
            'Default size
            If tkMainForm.optAnimSize(4).value Then
            
                'Enable textboxes
                tkMainForm.txtAnimXSize.Enabled = True
                tkMainForm.txtAnimYSize.Enabled = True
                
            End If
            
        Else
            
            'Custom size, enable textboxes
            tkMainForm.txtAnimXSize.Enabled = True
            tkMainForm.txtAnimYSize.Enabled = True
            
        End If
       
        'Set the value of the pausebar
        tkMainForm.hsbAnimPause.value = .animPause * 30
        
        'Resize the form
        Call sizeForm
        
        'Draw the current frame
        Call DrawFrame(.animCurrentFrame)
        
    End With
    
End Sub

'========================================================================
' Set the size of the animation
'========================================================================
Public Sub setAnimSize(ByVal Index As Integer): On Error Resume Next

    'Needs to be updated
    animationList(activeAnimationIndex).animNeedUpdate = True
    
    If Index <> 4 Then
        
        'It is not a custom animation, un-enable the 2 textboxes
        tkMainForm.txtAnimXSize.Enabled = False
        tkMainForm.txtAnimYSize.Enabled = False
        
    End If
    
    With animationList(activeAnimationIndex).theData
        
        'Now, see which one is clicked and set the width & height
        Select Case Index
            Case 0
                
                'Small
                .animSizeX = 64
                .animSizeY = 64
                
            Case 1
            
                'Medium
                .animSizeX = 128
                .animSizeY = 128
                
            Case 2
            
                'Large
                .animSizeX = 256
                .animSizeY = 256
                
            Case 3
                
                'Sprite
                .animSizeX = 32
                .animSizeY = 64
                
            Case 4
            
                'Custom
                .animSizeX = val(tkMainForm.txtAnimXSize.Text)
                .animSizeY = val(tkMainForm.txtAnimYSize.Text)
                
                'Enable the textboxes
                tkMainForm.txtAnimXSize.Enabled = True
                tkMainForm.txtAnimYSize.Enabled = True
                
        End Select
        
    End With
    
    'Resize the form
    Call sizeForm
    Call Form_Resize
    
End Sub

'========================================================================
' Set the XSize (Custom anim only)
'========================================================================
Public Sub setXSize(): On Error Resume Next

    'Needs to be updated
    animationList(activeAnimationIndex).animNeedUpdate = True
    
    'If it is lower then 0, set it to 0
    If val(tkMainForm.txtAnimXSize.Text) < 0 Then tkMainForm.txtAnimXSize.Text = 0
    
    'Set the X-Size
    animationList(activeAnimationIndex).theData.animSizeX = val(tkMainForm.txtAnimXSize.Text)
    
    'Resize the form
    Call sizeForm
    Call Form_Resize
    
End Sub

'========================================================================
' Set the YSize (Custom anim only)
'========================================================================
Public Sub setYSize(): On Error Resume Next
    
    'Needs to be updated
    animationList(activeAnimationIndex).animNeedUpdate = True
    
    'If it is lower then 0, set it to 0
    If val(tkMainForm.txtAnimYSize.Text) < 0 Then tkMainForm.txtAnimYSize.Text = 0
    
    'Set the Y-Size
    animationList(activeAnimationIndex).theData.animSizeY = val(tkMainForm.txtAnimYSize.Text)
    
    'Resize the form
    Call sizeForm
    Call Form_Resize
    
End Sub

'========================================================================
' Set the pause value
'========================================================================
Public Sub setPause(): On Error Resume Next

    'Needs to be updated
    animationList(activeAnimationIndex).animNeedUpdate = True
    
    'Update the animation data
    animationList(activeAnimationIndex).theData.animPause = tkMainForm.hsbAnimPause.value / 30

End Sub

'========================================================================
' Set the frame sound
'========================================================================
Public Sub setSound(): On Error Resume Next
    
    'Info of the Dialog Box we will open
    Dim dlg As FileDialogInfo
    ChDir (currentDir$)
    dlg.strDefaultFolder = projectPath$ + mediaPath$
    dlg.strTitle = "Select ISound"
    dlg.strDefaultExt = "wav"
    dlg.strFileTypes = "Wav Digital (*.wav)|*.wav|All files (*.*)|*.*"
    
    If Not OpenFileDialog(dlg, Me.hwnd) Then Exit Sub 'User pressed cancel
    
    'Needs to be updated
    animationList(activeAnimationIndex).animNeedUpdate = True
    
    'Choosen filename
    filename(1) = dlg.strSelectedFile
    
    'Choosen filename without path
    Dim antiPath As String
    antiPath = dlg.strSelectedFileNoPath
    
    ChDir (currentDir$)
    
    'If filename is empty, exit sub
    If filename$(1) = "" Then Exit Sub
    
    'Copy the file to the media folder of the current project
    FileCopy filename(1), projectPath + mediaPath + antiPath
    
    'Set the current sound
    animationList(activeAnimationIndex).theData.animSound(animationList(activeAnimationIndex).theData.animCurrentFrame) = antiPath
    
    'Put the filename in the textbox
    tkMainForm.txtAnimSound.Text = antiPath

End Sub

'========================================================================
' Delete the frame sound
'========================================================================
Public Sub delSound(): On Error Resume Next

    'Clear the textbox
    tkMainForm.txtAnimSound.Text = ""
    
    'Clear the data
    animationList(activeAnimationIndex).theData.animSound(animationList(activeAnimationIndex).theData.animCurrentFrame) = ""

End Sub

'========================================================================
' Set the transparent color
'========================================================================
Public Sub setTransp(): On Error Resume Next
    
    'Set it to true
    animationList(activeAnimationIndex).theData.animGetTransp = True
    
    'Tell the user what to do
    MsgBox LoadStringLoc(970, "Please click on the image to select the transparent color.")

End Sub

'========================================================================
' Play animation
'========================================================================
Public Sub animPlay(): On Error Resume Next

    'Get the current frame
    Dim oldF As Long
    oldF = animationList(activeAnimationIndex).theData.animCurrentFrame
    
    'Clear the arena
    Call arena.cls
    
    'Animate the frames
    Call AnimateAt(animationList(activeAnimationIndex).theData, 0, 0, animationList(activeAnimationIndex).theData.animSizeX, animationList(activeAnimationIndex).theData.animSizeY, arena)

    'Set the current frame again
    animationList(activeAnimationIndex).theData.animCurrentFrame = oldF
    
    'Redraw
    Call DrawFrame(oldF)

End Sub

'========================================================================
' Insert frame
'========================================================================
Public Sub animIns(): On Error Resume Next

    With animationList(activeAnimationIndex).theData
        
        'Change the values of the frames
        Dim i As Long
        For i = UBound(.animFrame) - 1 To .animCurrentFrame Step -1
            .animFrame(i + 1) = .animFrame(i)
            .animTransp(i + 1) = .animTransp(i)
        Next i
        
        'Clear the data of the just added frame
        .animFrame(.animCurrentFrame) = ""
        .animTransp(.animCurrentFrame) = 0
        
        'Draw the frame
        Call DrawFrame(.animCurrentFrame)
        
    End With

End Sub

'========================================================================
' Delete frame
'========================================================================
Public Sub animDel(): On Error Resume Next

    With animationList(activeAnimationIndex).theData
        
        'Change the values of the frames
        Dim i As Long
        For i = .animCurrentFrame To UBound(.animFrame)
            .animFrame(i) = .animFrame(i + 1)
            .animTransp(i) = .animTransp(i + 1)
        Next i
        
        'Clear the data of the frame
        .animFrame(50) = ""
        .animTransp(50) = 0
        
        'Draw the current frame
        Call DrawFrame(.animCurrentFrame)

    End With

End Sub

'========================================================================
' Forward
'========================================================================
Public Sub animForward(): On Error Resume Next

    With animationList(activeAnimationIndex).theData
        
        'Go one frame forward
        If .animCurrentFrame = 50 Then Exit Sub
        .animCurrentFrame = .animCurrentFrame + 1
        
        'Draw it
        arena.cls
        Call DrawFrame(.animCurrentFrame)
    
    End With
    
End Sub

'========================================================================
' Back
'========================================================================
Public Sub animBack(): On Error Resume Next

    With animationList(activeAnimationIndex).theData
        
        'Go one frame back
        If .animCurrentFrame = 0 Then Exit Sub
        .animCurrentFrame = .animCurrentFrame - 1
        
        'Draw it
        arena.cls
        Call DrawFrame(.animCurrentFrame)
    
    End With
    
End Sub

'========================================================================
' Draw the frame referenced by framenum, loads a file into the picturebox
' and resizes it. Also updates the framecount caption, sound textbox and
' transparent picturebox.
'========================================================================
Private Sub DrawFrame(ByVal framenum As Long): On Error Resume Next

    'Clear the pic box
    Call arena.cls
    
    'Draw the frame
    Call AnimDrawFrame(animationList(activeAnimationIndex).theData, framenum, 0, 0, arena.hdc)
    
    'Refresh the picturebox
    Call arena.Refresh
    
    'Get the total number of frames
    Dim maxFrame As Long
    maxFrame = animGetMaxFrame(animationList(activeAnimationIndex).theData)
    
    With animationList(activeAnimationIndex).theData
    
        'Update the boxes and such
        tkMainForm.lblAnimFrameCount.Caption = "Frame " & CStr(.animCurrentFrame + 1) & " / " & CStr(maxFrame + 1)
        tkMainForm.txtAnimSound.Text = .animSound(.animCurrentFrame)
        tkMainForm.transpcolor.BackColor = .animTransp(.animCurrentFrame)
    
    End With
    
End Sub

'========================================================================
' Form_Load
'========================================================================
Private Sub Form_Load(): On Error Resume Next

    'Localize this form
    Call LocalizeForm(Me)
    
    'Create new slot
    dataIndex = VectAnimationNewSlot()
    activeAnimationIndex = dataIndex
    
    'Clear the animation info
    Call AnimationClear(animationList(dataIndex).theData)
    animationList(dataIndex).theData.animPause = 0.15

End Sub
'========================================================================
' Form_Activate
'========================================================================
Private Sub Form_Activate(): On Error Resume Next
    
    'Set the activeAnim & activeForm variables
    Set activeAnimation = Me
    Set activeForm = Me
    activeAnimationIndex = dataIndex

    'Hide & Show tools
    Call hideAllTools
    
    With tkMainForm
        tkMainForm.bBar.Visible = True
        tkMainForm.animationExtras.Visible = True
        tkMainForm.animationTools.Visible = True
        tkMainForm.animationTools.Top = tkMainForm.toolTop
    End With
    
    'Set the info
    Call fillInfo
    
End Sub

'========================================================================
' Form_Unload
'========================================================================
Private Sub Form_Unload(Cancel As Integer): On Error Resume Next

    'See if the file needs to be saved
    If animationList(activeAnimationIndex).animNeedUpdate Then
        
        'Yup, ask if the user wants to
        Dim answer As Integer
        answer = MsgBox("Save changes to " & insideBrackets(Me.Caption) & "?", vbYesNoCancel + vbQuestion)
        
        If answer = vbCancel Then
        
            'Cancel unload
            Cancel = 1
            Exit Sub
            
        ElseIf answer = vbYes Then
        
            'Ask where to save
            Call saveanimmnu_Click
            
        End If
    
    End If
    
    'Hide the tools
    Call hideAllTools
       
End Sub

'========================================================================
' Form_Resize (NEW for 3.0.4 by Woozy)
'========================================================================
Private Sub Form_Resize(): On Error Resume Next

    'Set a minimum width & height relative to the arena width and height
    If Me.height <= arena.height + 1000 Then Me.height = arena.height + 1000
    If Me.width <= arena.width + 600 Then Me.width = arena.width + 600
        
    'The position
    arena.Left = ((Me.width - arena.width) / 2) - 55
    arena.Top = (Me.height - arena.height) / 2 - 250
    
End Sub

'========================================================================
' Resizes the form & arena
'========================================================================
Private Sub sizeForm(): On Error Resume Next
    
    'Resize the arena
    arena.width = Screen.TwipsPerPixelX * animationList(activeAnimationIndex).theData.animSizeX
    arena.height = Screen.TwipsPerPixelY * animationList(activeAnimationIndex).theData.animSizeY
    
    'Resize the form
    Me.width = arena.width + 500
    Me.height = arena.height + 500
    
    'Redraw the frame
    Call DrawFrame(animationList(activeAnimationIndex).theData.animCurrentFrame)

End Sub

'========================================================================
' Form_KeyPress
'========================================================================
Private Sub Form_KeyPress(KeyAscii As Integer): On Error Resume Next

    'Check which key is pressed
    If (UCase(chr(KeyAscii)) = "L") Then
    
        'L, open tileset
        If configfile.lastTileset = "" Then
        
            'Last tileset is empty
            Call arena_MouseDown(0, 0, 0, 0)
            Exit Sub
            
        Else
        
            'Open it
            tstFile = configfile.lastTileset
            tilesetForm.Show vbModal ', me
            
            'Set it
            Call changeSelectedTile(setFilename)
            
        End If
        
    ElseIf (UCase(chr(KeyAscii)) = "B") Then
        
        'B, open new board
        Call tkMainForm.newboardmnu_Click
        
    End If
    
End Sub

'========================================================================
' When you click in the animation picturebox
'========================================================================
Private Sub arena_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
    On Error Resume Next
    
    With animationList(activeAnimationIndex).theData
    
        'If the user wants to set the transparent color
        If .animGetTransp Then
            
            'Needs to be updated
            animationList(activeAnimationIndex).animNeedUpdate = True
            
            'Set the variable to false - a transparent color is selected
            .animGetTransp = False
            
            'Get the color of the pixel
            Dim colour As Long
            colour = vbFrmPoint(arena, X, Y)
            
            'Set the transparent color
            .animTransp(.animCurrentFrame) = colour
            
            'If the next frame is empty, set the transparent color there too
            If .animFrame(.animCurrentFrame + 1) = "" Then
                .animTransp(.animCurrentFrame + 1) = colour
            End If
            
            'Redraw the current frame
            Call DrawFrame(.animCurrentFrame)
            
        Else
        
            'User wants to give the current frame an image
            Dim dlg As FileDialogInfo
            
            'Info of the Dialog Box we will open
            ChDir (currentDir$)
            dlg.strDefaultFolder = projectPath$ + bmpPath$
            dlg.strTitle = "Select Image"
            dlg.strDefaultExt = "bmp"
            dlg.strFileTypes = strFileDialogFilterWithTiles
            
            If Not OpenFileDialog(dlg, Me.hwnd) Then Exit Sub 'User pressed cancel
                
            'Choosen filename
            filename$(1) = dlg.strSelectedFile
            
            'Choosen filename without path
            Dim antiPath As String
            antiPath = dlg.strSelectedFileNoPath
                
            'Needs to be updated
            animationList(activeAnimationIndex).animNeedUpdate = True
            
            ChDir (currentDir$)
            
            'If the filename is empty, exit sub
            If filename$(1) = "" Then Exit Sub
                
            'Extension of filename
            Dim ex As String
            ex = GetExt(filename$(1))
            
            If UCase(ex) = "TST" Or UCase(ex) = "GPH" Or UCase(ex) = "ISO" Then 'If it's a tile(set)
                
                'Copy the file to the tile folder of the current project
                FileCopy filename(1), projectPath + tilePath + antiPath
                    
                If UCase(ex) = "TST" Or UCase(ex) = "ISO" Then 'If it's a tileset, open the tileset browser
                    tstnum = 0
                    tstFile = antiPath
                    
                    'Update the last tileset variable
                    configfile.lastTileset = tstFile
                    tilesetForm.Show vbModal
                    
                    'If the filename is empty, exit sub
                    If setFilename$ = "" Then Exit Sub
                    
                    'Update the frame
                    .animFrame(.animCurrentFrame) = setFilename
                    
                Else
                    
                    'It's a tile, update the frame
                    .animFrame(.animCurrentFrame) = antiPath
                        
                End If
                    
            Else
                
                'It's not a picture so probably an image. Copy the file to the
                'bitmap folder of the current project
                
                FileCopy filename$(1), projectPath$ + bmpPath$ + antiPath$
                
                'Update the frame
                .animFrame(.animCurrentFrame) = antiPath
                
            End If
            
            'If the next frame is empty, set the transparent color there
            
            If .animFrame(.animCurrentFrame + 1) = "" Then
                .animTransp(.animCurrentFrame + 1) = .animTransp(.animCurrentFrame)
            End If
            
            'Redraw the frame
            Call DrawFrame(.animCurrentFrame)
            
        End If
        
    End With
    
End Sub

'========================================================================
' Change the currently selected tile
'========================================================================
Public Sub changeSelectedTile(ByVal file As String): On Error Resume Next
    
    'Exit sub if file is empty
    If file = "" Then Exit Sub
    
    With animationList(activeAnimationIndex).theData
    
        'Set the file of the current frame
        .animFrame(.animCurrentFrame) = file
        If .animFrame(.animCurrentFrame + 1) = "" Then
        
            'Set the transparent color of the next frame
            .animTransp(.animCurrentFrame + 1) = .animTransp(.animCurrentFrame)
            
        End If
        
        Call DrawFrame(.animCurrentFrame)
        
    End With
    
End Sub

'========================================================================
' Opens animation
'========================================================================
Public Sub openFile(ByVal file As String): On Error Resume Next

    filename(1) = file
    
    'File without path
    Dim antiPath As String
    antiPath = absNoPath(file)
    
    'Copy the file to the misc folder of the current project
    FileCopy filename(1), projectPath & miscPath & antiPath
    
    'Open the animation
    Call openAnimation(filename(1), animationList(activeAnimationIndex).theData)
    
    'Fill the info
    Call fillInfo
    
    'No need to update
    animationList(activeAnimationIndex).animNeedUpdate = False
    
    'Set the animation file
    animationList(activeAnimationIndex).animFile = antiPath
    
    'Set the caption
    activeAnimation.Caption = LoadStringLoc(811, "Animation Editor") + "  (" + antiPath + ")"
    
End Sub

'========================================================================
' Saves the file
'========================================================================
Public Sub saveFile(): On Error Resume Next
    
    If animationList(activeAnimationIndex).animFile = "" Then
        
        'Filename is empty - ask where to save
        activeAnimation.Show
        saveasanimmnu_Click
        Exit Sub
        
    End If
    
    'If we got here, we know the animfile. Just save
    Call saveAnimation(projectPath & miscPath & animationList(activeAnimationIndex).animFile, animationList(activeAnimationIndex).theData)
    
    'No need to update anymore
    animationList(activeAnimationIndex).animNeedUpdate = False
    
    'Update caption
    activeAnimation.Caption = LoadStringLoc(811, "Animation Editor") + " (" + animationList(activeAnimationIndex).animFile$ + ")"

End Sub

'========================================================================
' Save animation
'========================================================================
Private Sub saveanimmnu_Click(): On Error Resume Next
    
    'If the animation hasn't been saved yet, call the "Save As" sub
    If animationList(activeAnimationIndex).animFile$ = "" Then
        
        Call saveasanimmnu_Click
        
    Else
        
        'If the animation is already saved, save it again
        Call saveAnimation(projectPath$ + miscPath$ + animationList(activeAnimationIndex).animFile, animationList(activeAnimationIndex).theData)
        
        'No need to update anymore
        animationList(activeAnimationIndex).animNeedUpdate = False
        
    End If

End Sub

'========================================================================
' Save animation as
'========================================================================
Private Sub saveasanimmnu_Click(): On Error Resume Next
    
    ChDir (currentDir)
    
    'Info of the Dialog Box we will open
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath & miscPath
    dlg.strTitle = "Save Animation As"
    dlg.strDefaultExt = "anm"
    dlg.strFileTypes = "RPG Toolkit Animation (*.anm)|*.anm|All files(*.*)|*.*"
    
    If (Not SaveFileDialog(dlg, Me.hwnd, True)) Then Exit Sub 'User pressed cancel
    If dlg.strSelectedFile = vbNullString Then Exit Sub
    
    ChDir (currentDir)
    
    'No need to update anymore
    animationList(activeAnimationIndex).animNeedUpdate = False
     
    'Save the animation
    Call saveAnimation(dlg.strSelectedFile, animationList(activeAnimationIndex).theData)
    
    'Set the animation name
    animationList(activeAnimationIndex).animFile = dlg.strSelectedFileNoPath
    
    'Update the caption
    activeAnimation.Caption = LoadStringLoc(811, "Animation Editor") & " (" & dlg.strSelectedFileNoPath & ")"
    
    'Update the tree
    Call tkMainForm.fillTree("", projectPath)
    
End Sub

'========================================================================
' Close
'========================================================================
Private Sub closeanimmnu_Click(): On Error Resume Next
    
    'Just unload
    Unload Me

End Sub

'========================================================================
' A lot of menu commands...
'========================================================================
Private Sub mnutilehorizontally_Click()
    On Error Resume Next
    Call tkMainForm.tilehorizonatllymnu_Click
End Sub
Private Sub mnutilevertically_Click()
    On Error Resume Next
    Call tkMainForm.tileverticallymnu_Click
End Sub
Private Sub mnuTutorial_Click()
    On Error Resume Next
    Call tkMainForm.tutorialmnu_Click
End Sub
Private Sub mnuusersguide_Click()
    On Error Resume Next
    Call tkMainForm.usersguidemnu_Click
End Sub
Private Sub mnuAbout_Click()
    On Error Resume Next
    Call tkMainForm.aboutmnu_Click
End Sub
Private Sub mnuArrangeIcons_Click()
    On Error Resume Next
    Call tkMainForm.arrangeiconsmnu_Click
End Sub
Private Sub mnuCascade_Click()
    On Error Resume Next
    Call tkMainForm.cascademnu_Click
End Sub
Private Sub mnucreatepakfile_Click()
    On Error Resume Next
    Call tkMainForm.createpakfilemnu_Click
End Sub
Private Sub mnucreatesetup_Click()
    On Error Resume Next
    Call tkMainForm.createsetupmnu_Click
End Sub
Private Sub mnuexit_Click()
    On Error Resume Next
    Call tkMainForm.exitmnu_Click
End Sub
Private Sub mnuHistorytxt_Click()
    On Error Resume Next
    Call tkMainForm.historytxtmnu_Click
End Sub
Private Sub mnuinstallupgrade_Click()
    On Error Resume Next
    Call tkMainForm.installupgrademnu_Click
End Sub
Private Sub mnumakeexe_Click()
    On Error Resume Next
    Call tkMainForm.makeexemnu_Click
End Sub
Private Sub mnunewanimatedtile_Click()
    On Error Resume Next
    Call tkMainForm.newanimtilemnu_Click
End Sub
Private Sub mnunewanimation_Click()
    On Error Resume Next
    Call tkMainForm.newanimationmnu_Click
End Sub
Private Sub mnunewboard_Click()
    On Error Resume Next
    Call tkMainForm.newboardmnu_Click
End Sub
Private Sub mnunewenemy_Click()
    On Error Resume Next
    Call tkMainForm.newenemymnu_Click
End Sub
Private Sub mnunewitem_Click()
    On Error Resume Next
    Call tkMainForm.newitemmnu_Click
End Sub
Private Sub mnunewplayer_Click()
    On Error Resume Next
    Call tkMainForm.newplayermnu_Click
End Sub
Private Sub mnunewproject_Click()
    On Error Resume Next
    Call tkMainForm.newprojectmnu_Click
End Sub
Private Sub mnunewrpgcodeprogram_Click()
    On Error Resume Next
    Call tkMainForm.newrpgcodemnu_Click
End Sub
Private Sub mnunewspecialmove_Click()
    On Error Resume Next
    Call tkMainForm.newspecialmovemnu_Click
End Sub
Private Sub mnunewstatuseffect_Click()
    On Error Resume Next
    Call tkMainForm.newstatuseffectmnu_Click
End Sub
Private Sub mnunewtile_Click()
    On Error Resume Next
    Call tkMainForm.newtilemnu_Click
End Sub
Private Sub mnunewtilebitmap_Click()
    On Error Resume Next
    Call tkMainForm.newtilebitmapmnu_Click
End Sub
Private Sub mnuopen_Click()
    On Error Resume Next
    Call tkMainForm.openmnu_Click
End Sub
Private Sub mnuRegistrationInfo_Click()
    On Error Resume Next
    Call tkMainForm.registrationinfomnu_Click
End Sub
Private Sub mnuRPGCodePrimer_Click()
    On Error Resume Next
    Call tkMainForm.rpgcodeprimermnu_Click
End Sub
Private Sub mnurpgcodereference_Click()
    On Error Resume Next
    Call tkMainForm.rpgcodereferencemnu_Click
End Sub
Private Sub mnusaveall_Click()
    On Error Resume Next
    Call tkMainForm.saveallmnu_Click
End Sub
Private Sub mnuselectlanguage_Click()
    On Error Resume Next
    Call tkMainForm.selectlanguagemnu_Click
End Sub
Private Sub mnushowprojectlist_Click()
    On Error Resume Next
    Call tkMainForm.showprojectlistmnu_Click
End Sub
Private Sub mnushowtools_Click()
    On Error Resume Next
    Call tkMainForm.showtoolsmnu_Click
End Sub
Private Sub mnutestgame_Click()
    On Error Resume Next
    Call tkMainForm.testgamemnu_Click
End Sub
Private Sub mnuOpenProject_Click()
    On Error Resume Next
    Call tkMainForm.mnuOpenProject_Click
End Sub
Private Sub mnuNewFightBackground_Click()
    On Error Resume Next
    Call tkMainForm.mnuNewFightBackground_Click
End Sub




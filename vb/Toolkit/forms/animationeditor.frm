VERSION 5.00
Begin VB.Form animationeditor 
   Caption         =   "Animation Editor (Untitled)"
   ClientHeight    =   5925
   ClientLeft      =   165
   ClientTop       =   450
   ClientWidth     =   6705
   Icon            =   "animationeditor.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   ScaleHeight     =   5925
   ScaleWidth      =   6705
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
' The 5 different options
'========================================================================
'Small (64x64)
Public Sub Option1_Click()
    On Error GoTo ErrorHandler
    animationList(activeAnimationIndex).animNeedUpdate = True
    tkMainForm.xsize.Enabled = False
    tkMainForm.ysize.Enabled = False
    'Update the size of the animation
    animationList(activeAnimationIndex).theData.animSizeX = 64
    animationList(activeAnimationIndex).theData.animSizeY = 64
    'Resize the form
    Call sizeform
    '(NEW for 3.0.4 by Woozy)
    Call Form_Resize

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub
'Medium (128x128)
Public Sub Option2_Click()
    On Error GoTo ErrorHandler
    animationList(activeAnimationIndex).animNeedUpdate = True
    tkMainForm.xsize.Enabled = False
    tkMainForm.ysize.Enabled = False
    'Update the size of the animation
    animationList(activeAnimationIndex).theData.animSizeX = 128
    animationList(activeAnimationIndex).theData.animSizeY = 128
    'Resize the form
    Call sizeform
    '(NEW for 3.0.4 by Woozy)
    Call Form_Resize

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub
'Large (256x256)
Public Sub Option3_Click()
    On Error GoTo ErrorHandler
    animationList(activeAnimationIndex).animNeedUpdate = True
    tkMainForm.xsize.Enabled = False
    tkMainForm.ysize.Enabled = False
    'Update the size of the animation
    animationList(activeAnimationIndex).theData.animSizeX = 256
    animationList(activeAnimationIndex).theData.animSizeY = 256
    'Resize the form
    Call sizeform
    '(NEW for 3.0.4 by Woozy)
    Call Form_Resize

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub
'Sprite (32x64)
Public Sub Option5_Click()
    On Error GoTo ErrorHandler
    animationList(activeAnimationIndex).animNeedUpdate = True
    tkMainForm.xsize.Enabled = False
    tkMainForm.ysize.Enabled = False
    'Update the size of the animation
    animationList(activeAnimationIndex).theData.animSizeX = 32
    animationList(activeAnimationIndex).theData.animSizeY = 64
    'Resize the form
    Call sizeform
    '(NEW for 3.0.4 by Woozy)
    Call Form_Resize

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub
'Custom
Public Sub Option4_Click()
    On Error GoTo ErrorHandler
    animationList(activeAnimationIndex).animNeedUpdate = True
    tkMainForm.xsize.Enabled = True
    tkMainForm.ysize.Enabled = True
    'Update the size of the animation
    animationList(activeAnimationIndex).theData.animSizeX = val(tkMainForm.xsize.Text)
    animationList(activeAnimationIndex).theData.animSizeY = val(tkMainForm.ysize.Text)
    'Resize the form
    Call sizeform
    '(NEW for 3.0.4 by Woozy)
    Call Form_Resize

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub
'========================================================================
' The xsize textbox in tkMainForm
'========================================================================
Public Sub xsize_Change()
    On Error GoTo ErrorHandler
    animationList(activeAnimationIndex).animNeedUpdate = True
    If val(tkMainForm.xsize.Text) < 0 Then tkMainForm.xsize.Text = 0
    
    'Set the x-size of the animation
    animationList(activeAnimationIndex).theData.animSizeX = val(tkMainForm.xsize.Text)
    
    Call sizeform
    '(NEW for 3.0.4 by Woozy)
    Call Form_Resize
    
    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub
'========================================================================
' The ysize textbox in tkMainForm
'========================================================================
Public Sub ysize_Change()
    On Error GoTo ErrorHandler
    animationList(activeAnimationIndex).animNeedUpdate = True
    If val(tkMainForm.ysize.Text) < 0 Then tkMainForm.ysize.Text = 0
    
    'Set the y-size of the animation
    animationList(activeAnimationIndex).theData.animSizeY = val(tkMainForm.ysize.Text)
    
    Call sizeform
    '(NEW for 3.0.4)
    Call Form_Resize
    
    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub
'========================================================================
' When you change the pausebar in tkMainForm
'========================================================================
'FIXIT: bar_Change event has no Visual Basic .NET equivalent and will not be upgraded.     FixIT90210ae-R7593-R67265
Public Sub pausebar_Change()
    On Error GoTo ErrorHandler
    'Needs to be updated
    animationList(activeAnimationIndex).animNeedUpdate = True
    'Update the animation data
    animationList(activeAnimationIndex).theData.animPause = tkMainForm.pausebar.value / 30

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub
'========================================================================
' Set the frame sound
'========================================================================
Public Sub soundeffect_Click()
    On Error Resume Next
    
    Dim dlg As FileDialogInfo
    Dim antiPath As String
    'Info of the Dialog Box we will open
    ChDir (currentDir$)
    dlg.strDefaultFolder = projectPath$ + mediaPath$
    dlg.strTitle = "Select ISound"
    dlg.strDefaultExt = "wav"
    dlg.strFileTypes = "Wav Digital (*.wav)|*.wav|All files (*.*)|*.*"
    
    If OpenFileDialog(dlg, Me.hwnd) Then 'If the user didn't press cancel
        'Choosen filename
        filename$(1) = dlg.strSelectedFile
        'Choosen filename without path
        antiPath = dlg.strSelectedFileNoPath
        'Needs to be updated
        animationList(activeAnimationIndex).animNeedUpdate = True
    
        ChDir (currentDir$)
        'If filename is empty, exit sub
        If filename$(1) = "" Then Exit Sub
        'Copy the file to the media folder of the current project
        FileCopy filename$(1), projectPath$ + mediaPath$ + antiPath
        'Set the current sound
        animationList(activeAnimationIndex).theData.animSound(animationList(activeAnimationIndex).theData.animCurrentFrame) = antiPath
        'Put the filename in the textbox
        tkMainForm.soundeffect.Text = antiPath
    End If
End Sub
'========================================================================
' Deletes the frame sound
'========================================================================
Public Sub Command7_Click()
    On Error GoTo ErrorHandler
    'Clear the textbox
    tkMainForm.soundeffect.Text = ""
    'Clear the data
    animationList(activeAnimationIndex).theData.animSound(animationList(activeAnimationIndex).theData.animCurrentFrame) = ""

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub
'========================================================================
' Set the transparant color
'========================================================================
Public Sub Command6_Click()
    On Error GoTo ErrorHandler
    animationList(activeAnimationIndex).theData.animGetTransp = True
    MsgBox LoadStringLoc(970, "Please click on the image to select a color.")

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub
'========================================================================
' Initialize the animation
'========================================================================
Sub infofill()
    On Error GoTo ErrorHandler
    'Put the correct data in the animation size textboxes
    tkMainForm.xsize.Text = str$(animationList(activeAnimationIndex).theData.animSizeX)
    tkMainForm.ysize.Text = str$(animationList(activeAnimationIndex).theData.animSizeY)
    
    tkMainForm.xsize.Enabled = False
    tkMainForm.ysize.Enabled = False
    If animationList(activeAnimationIndex).theData.animSizeX = 0 Then animationList(activeAnimationIndex).theData.animSizeX = 64
    If animationList(activeAnimationIndex).theData.animSizeY = 0 Then animationList(activeAnimationIndex).theData.animSizeY = 64
    
    Dim ch As Boolean
    ch = False
    'Check the size of the animation
    If animationList(activeAnimationIndex).theData.animSizeX = 64 And animationList(activeAnimationIndex).theData.animSizeY = 64 Then
        tkMainForm.Option1.value = True
        ch = True
    End If
    If animationList(activeAnimationIndex).theData.animSizeX = 128 And animationList(activeAnimationIndex).theData.animSizeY = 128 Then
        tkMainForm.Option2.value = True
        ch = True
    End If
    If animationList(activeAnimationIndex).theData.animSizeX = 256 And animationList(activeAnimationIndex).theData.animSizeY = 256 Then
        tkMainForm.Option3.value = True
        ch = True
    End If
    If animationList(activeAnimationIndex).theData.animSizeX = 32 And animationList(activeAnimationIndex).theData.animSizeY = 64 Then
        tkMainForm.Option5.value = True
        ch = True
    End If
    If (ch = False) Then
        'If we have come here, the animation has a custom size
        tkMainForm.Option4.value = True
        tkMainForm.xsize.Enabled = True
        tkMainForm.ysize.Enabled = True
    End If
    'Set the value of the pausebar
    tkMainForm.pausebar.value = animationList(activeAnimationIndex).theData.animPause * 30
    
    'Resize the form
    Call sizeform
    'Draw the current frame
    Call DrawFrame(animationList(activeAnimationIndex).theData.animCurrentFrame)
    
    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub
'========================================================================
' When you click in the animation picturebox
'========================================================================
Private Sub arena_MouseDown(button As Integer, Shift As Integer, X As Single, Y As Single)
    On Error Resume Next
    Dim antiPath As String, col As Long
    'If the user wants to set the transparent color
    If animationList(activeAnimationIndex).theData.animGetTransp Then
        'Needs to be updated
        animationList(activeAnimationIndex).animNeedUpdate = True
        'Set the variable to false - a transparent color is selected
        animationList(activeAnimationIndex).theData.animGetTransp = False
        'Get the color of the pixel
        col = vbFrmPoint(arena, X, Y)
        'Set the transparent color
        animationList(activeAnimationIndex).theData.animTransp(animationList(activeAnimationIndex).theData.animCurrentFrame) = col
        'If the next frame is empty, set the transparent color there too
        If animationList(activeAnimationIndex).theData.animFrame(animationList(activeAnimationIndex).theData.animCurrentFrame + 1) = "" Then
            animationList(activeAnimationIndex).theData.animTransp(animationList(activeAnimationIndex).theData.animCurrentFrame + 1) = col
        End If
        'Redraw the current frame
        Call DrawFrame(animationList(activeAnimationIndex).theData.animCurrentFrame)
    Else 'If the user didn't click on the "Select" button, he wants to set an image
        Dim dlg As FileDialogInfo
        'Info of the Dialog Box we will open
        ChDir (currentDir$)
        dlg.strDefaultFolder = projectPath$ + bmpPath$
        dlg.strTitle = "Select Image"
        dlg.strDefaultExt = "bmp"
        dlg.strFileTypes = strFileDialogFilterWithTiles
        
        If OpenFileDialog(dlg, Me.hwnd) Then 'If the user didn't press cancel
            'Choosen filename
            filename$(1) = dlg.strSelectedFile
            'Choosen filename without path
            antiPath = dlg.strSelectedFileNoPath
            'Needs to be updated
            animationList(activeAnimationIndex).animNeedUpdate = True
        
            ChDir (currentDir$)
            'If the filename is empty, exit sub
            If filename$(1) = "" Then Exit Sub
            
            'Extension of filename
            Dim ex As String
            ex = GetExt(filename$(1))
            If UCase(ex) = "TST" Or UCase(ex) = "GPH" Then 'If it's a tile(set)
                'Copy the file to the tile folder of the current project
                FileCopy filename$(1), projectPath$ + tilePath$ + antiPath$
                
                If UCase(ex) = "TST" Then 'If it's a tileset, open the tileset browser
                    tstnum = 0
                    tstFile$ = antiPath
                    'Update teh last tileset variable
                    configfile.lastTileset$ = tstFile$
                    tilesetform.Show vbModal
                    'If the filename is empty, exit sub
                    If setFilename$ = "" Then Exit Sub
                    'Update the frame
                    animationList(activeAnimationIndex).theData.animFrame(animationList(activeAnimationIndex).theData.animCurrentFrame) = setFilename$
                Else 'If it's a tile
                    'Update the frame
                    animationList(activeAnimationIndex).theData.animFrame(animationList(activeAnimationIndex).theData.animCurrentFrame) = antiPath
                End If
            Else 'If it's not a tile(set), it's probably a picture, so...
                '...copy the file to the bitmap folder of the current project
                FileCopy filename$(1), projectPath$ + bmpPath$ + antiPath$
                'Update the frame
                animationList(activeAnimationIndex).theData.animFrame(animationList(activeAnimationIndex).theData.animCurrentFrame) = antiPath
            End If
            'If the next frame is empty, set the transparent color there
            If animationList(activeAnimationIndex).theData.animFrame(animationList(activeAnimationIndex).theData.animCurrentFrame + 1) = "" Then
                animationList(activeAnimationIndex).theData.animTransp(animationList(activeAnimationIndex).theData.animCurrentFrame + 1) = animationList(activeAnimationIndex).theData.animTransp(animationList(activeAnimationIndex).theData.animCurrentFrame)
            End If
            'Redraw the frame
            Call DrawFrame(animationList(activeAnimationIndex).theData.animCurrentFrame)
        End If
    End If
End Sub
'========================================================================
' Change the currently selected tile
'========================================================================
Public Sub changeSelectedTile(ByVal file As String)
    On Error Resume Next
    If file = "" Then Exit Sub
    
    animationList(activeAnimationIndex).theData.animFrame(animationList(activeAnimationIndex).theData.animCurrentFrame) = file
    If animationList(activeAnimationIndex).theData.animFrame(animationList(activeAnimationIndex).theData.animCurrentFrame + 1) = "" Then
        animationList(activeAnimationIndex).theData.animTransp(animationList(activeAnimationIndex).theData.animCurrentFrame + 1) = animationList(activeAnimationIndex).theData.animTransp(animationList(activeAnimationIndex).theData.animCurrentFrame)
    End If
    Call DrawFrame(animationList(activeAnimationIndex).theData.animCurrentFrame)
End Sub
'========================================================================
' ???
'========================================================================
Public Sub saveAsFile()
    'saves the file.
    On Error GoTo ErrorHandler
    If animationList(activeAnimationIndex).animNeedUpdate = True Then
        Me.Show
        saveasanimmnu_Click
    End If
    
    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub
'========================================================================
' Opens animation
'========================================================================
Public Sub openFile(ByVal file As String)
    On Error Resume Next
    'In tkMainForm, there has already been created a new animation form, let's show
    'that now
    activeAnimation.Show
    filename$(1) = file$
    
    'File without path
    Dim antiPath As String
    antiPath$ = absNoPath(file$)
    
    'Copy the file to the misc folder of the current project
    FileCopy filename$(1), projectPath$ & miscPath$ & antiPath
    'Open the animation
    Call openAnimation(filename$(1), animationList(activeAnimationIndex).theData)
    'Fill the info
    Call infofill
    'No need to update
    animationList(activeAnimationIndex).animNeedUpdate = False
    'Set the animation file
    animationList(activeAnimationIndex).animFile$ = antiPath$
    'Set the caption
    activeAnimation.Caption = LoadStringLoc(811, "Animation Editor") + "  (" + antiPath$ + ")"
End Sub
'========================================================================
' Saves the file
'========================================================================
Public Sub saveFile()
    On Error GoTo ErrorHandler
    
    animationList(activeAnimationIndex).animNeedUpdate = False
    
    If animationList(activeAnimationIndex).animFile$ = "" Then
        activeAnimation.Show
        saveasanimmnu_Click
        Exit Sub
    End If
    'Save
    Call saveAnimation(projectPath$ + miscPath$ + animationList(activeAnimationIndex).animFile$, animationList(activeAnimationIndex).theData)
    'Update caption
    activeAnimation.Caption = LoadStringLoc(811, "Animation Editor") + " (" + animationList(activeAnimationIndex).animFile$ + ")"

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub
'========================================================================
' Menu - Save animation
'========================================================================
Private Sub saveanimmnu_Click()
    On Error GoTo ErrorHandler
    'If the animation hasn't been saved yet, call the "Save As" sub
    If animationList(activeAnimationIndex).animFile$ = "" Then
        Call saveasanimmnu_Click
    Else 'If the animation is already saved, save it again
        Call saveAnimation(projectPath$ + miscPath$ + animationList(activeAnimationIndex).animFile, animationList(activeAnimationIndex).theData)
        'No need to update
        animationList(activeAnimationIndex).animNeedUpdate = False
    End If

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub
'========================================================================
' Menu - Save Animation As...
'========================================================================
Private Sub saveasanimmnu_Click()
    On Error Resume Next
    Dim dlg As FileDialogInfo
    Dim antiPath As String, aa As Long, bb As Long
    'Info of the Dialog Box we will open
    ChDir (currentDir$)
    dlg.strDefaultFolder = projectPath$ + miscPath$
    dlg.strTitle = "Save Animation As"
    dlg.strDefaultExt = "anm"
    dlg.strFileTypes = "RPG Toolkit Animation (*.anm)|*.anm|All files(*.*)|*.*"
    
    If SaveFileDialog(dlg, Me.hwnd) Then 'If the user didn't press cancel
        'Filename
        filename$(1) = dlg.strSelectedFile
        'Filename without path
        antiPath$ = dlg.strSelectedFileNoPath
        ChDir (currentDir$)
        'No need to update
        animationList(activeAnimationIndex).animNeedUpdate = False
        'If the file is empty, exit sub
        If filename$(1) = "" Then Exit Sub

        If fileExists(filename(1)) Then 'File exists
            bb = MsgBox(LoadStringLoc(949, "That file exists.  Are you sure you want to overwrite it?"), vbYesNo)
            If bb = vbNo Then Exit Sub 'If no, exit sub
        End If
        
        'Save the animation
        Call saveAnimation(filename$(1), animationList(activeAnimationIndex).theData)
        'Set the animation nam
        animationList(activeAnimationIndex).animFile$ = antiPath$
        'Update the caption
        activeAnimation.Caption = LoadStringLoc(811, "Animation Editor") + " (" + antiPath$ + ")"
        'Update the tree
        Call tkMainForm.fillTree("", projectPath$)
    End If
End Sub
'========================================================================
' Menu - Close
'========================================================================
Private Sub closeanimmnu_Click()
    On Error GoTo ErrorHandler
    Unload activeAnimation

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub
Private Sub animateFrames()
    'find max frame...
    On Error GoTo ErrorHandler
    
    Call AnimateAt(animationList(activeAnimationIndex).theData, 0, 0, animationList(activeAnimationIndex).theData.animSizeX, animationList(activeAnimationIndex).theData.animSizeY, arena)
    Exit Sub

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub
'========================================================================
' Draw the frame referenced by framenum, loads a file into the picturebox
' and resizes it. Also updates the framecount caption, sound textbox and
' transparent picturebox.
'========================================================================
Private Sub DrawFrame(ByVal framenum As Long)

    On Error Resume Next

    'Clear picturebox
    Call vbPicCls(arena)

    'Draw the frame
    Call AnimDrawFrame(animationList(activeAnimationIndex).theData, framenum, 0, 0, vbPicHDC(arena))

    'Refresh the picturebox
    Call vbPicRefresh(arena)

    'Get the total number of frames
    Dim maxFrame As Long
    maxFrame = animGetMaxFrame(animationList(activeAnimationIndex).theData)

    'Update the boxes and such
    tkMainForm.framecount.Caption = "Frame " & CStr(animationList(activeAnimationIndex).theData.animCurrentFrame + 1) & " / " & CStr(maxFrame + 1)
    tkMainForm.soundeffect.Text = animationList(activeAnimationIndex).theData.animSound(animationList(activeAnimationIndex).theData.animCurrentFrame)
    Call vbPicFillRect(tkMainForm.transpcolor, 0, 0, 1000, 1000, animationList(activeAnimationIndex).theData.animTransp(animationList(activeAnimationIndex).theData.animCurrentFrame))

End Sub
'========================================================================
' Back button in tkMainForm
'========================================================================
Public Sub animationBack()
    On Error GoTo ErrorHandler
    If animationList(activeAnimationIndex).theData.animCurrentFrame = 0 Then Exit Sub
    Call vbPicCls(arena)
    animationList(activeAnimationIndex).theData.animCurrentFrame = animationList(activeAnimationIndex).theData.animCurrentFrame - 1
    Call DrawFrame(animationList(activeAnimationIndex).theData.animCurrentFrame)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub
'========================================================================
' Forward button in tkMainForm
'========================================================================
Public Sub animationForward()
    On Error GoTo ErrorHandler
    If animationList(activeAnimationIndex).theData.animCurrentFrame = 50 Then Exit Sub
    animationList(activeAnimationIndex).theData.animCurrentFrame = animationList(activeAnimationIndex).theData.animCurrentFrame + 1
    Call DrawFrame(animationList(activeAnimationIndex).theData.animCurrentFrame)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub
'========================================================================
' Play button in tkMainForm
'========================================================================
Public Sub animationPlay()
    On Error GoTo ErrorHandler
    'Variable for current frame
    Dim oldF As Long
    oldF = animationList(activeAnimationIndex).theData.animCurrentFrame
    Call vbPicCls(arena)
    Call animateFrames
    'Set the frame back
    animationList(activeAnimationIndex).theData.animCurrentFrame = oldF
    'Redraw
    Call DrawFrame(oldF)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub
'========================================================================
' Insert button in tkMainForm
'========================================================================
Public Sub animationIns()
    On Error GoTo ErrorHandler
    Dim t As Long
    For t = UBound(animationList(activeAnimationIndex).theData.animFrame) - 1 To animationList(activeAnimationIndex).theData.animCurrentFrame Step -1
        animationList(activeAnimationIndex).theData.animFrame(t + 1) = animationList(activeAnimationIndex).theData.animFrame(t)
        animationList(activeAnimationIndex).theData.animTransp(t + 1) = animationList(activeAnimationIndex).theData.animTransp(t)
    Next t
    animationList(activeAnimationIndex).theData.animFrame(animationList(activeAnimationIndex).theData.animCurrentFrame) = ""
    animationList(activeAnimationIndex).theData.animTransp(animationList(activeAnimationIndex).theData.animCurrentFrame) = 0
    Call DrawFrame(animationList(activeAnimationIndex).theData.animCurrentFrame)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub
'========================================================================
' Delete button in tkMainForm
'========================================================================
Public Sub animationDel()
    On Error GoTo ErrorHandler
    Dim t As Long
    For t = animationList(activeAnimationIndex).theData.animCurrentFrame To UBound(animationList(activeAnimationIndex).theData.animFrame)
        animationList(activeAnimationIndex).theData.animFrame(t) = animationList(activeAnimationIndex).theData.animFrame(t + 1)
        animationList(activeAnimationIndex).theData.animTransp(t) = animationList(activeAnimationIndex).theData.animTransp(t + 1)
    Next t
    animationList(activeAnimationIndex).theData.animFrame(50) = ""
    animationList(activeAnimationIndex).theData.animTransp(50) = 0
    Call DrawFrame(animationList(activeAnimationIndex).theData.animCurrentFrame)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub
'========================================================================
' Form_Load
'========================================================================
Private Sub Form_Load()
    On Error GoTo ErrorHandler
    Call LocalizeForm(Me)
    
    Set activeAnimation = Me
    dataIndex = VectAnimationNewSlot()
    activeAnimationIndex = dataIndex
    Call AnimationClear(animationList(dataIndex).theData)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub
'========================================================================
' Form_Activate
'========================================================================
Private Sub Form_Activate()
    On Error Resume Next
    
    Set activeAnimation = Me
    Set activeForm = Me
    activeAnimationIndex = dataIndex

    'Extras [Vampz - Make Sure Other Tools Hidden]
    Call hideAllTools
    tkMainForm.bottomFrame.Visible = True
    tkMainForm.animationExtras.Visible = True
    tkMainForm.animationTools.Visible = True
    tkMainForm.animationTools.Top = tkMainForm.toolTop
    
    Call infofill
End Sub
'========================================================================
' Form_Unload
'========================================================================
Private Sub Form_Unload(Cancel As Integer)
    On Error Resume Next
    Call hideAllTools
End Sub
'========================================================================
' Form_Resize (NEW for 3.0.4 by Woozy)
'========================================================================
Private Sub Form_Resize()
    On Error Resume Next
    'Set a minimum width and height relative to the arena width and height
    If Me.height <= arena.height + 1000 Then Me.height = arena.height + 1000
    If Me.width <= arena.width + 600 Then Me.width = arena.width + 600
        
    'The position
    arena.Left = ((Me.width - arena.width) / 2) - 55
    arena.Top = (Me.height - arena.height) / 2 - 250
End Sub
'========================================================================
' When you press a key
'========================================================================
Private Sub Form_KeyPress(KeyAscii As Integer)
    On Error Resume Next
    If UCase$(chr$(KeyAscii)) = "L" Then
        If configfile.lastTileset = "" Then
            Call arena_MouseDown(0, 0, 0, 0)
            Exit Sub
        End If
        If configfile.lastTileset$ <> "" Then
            tstFile$ = configfile.lastTileset$
            tilesetform.Show vbModal ', me
            Call changeSelectedTile(setFilename)
        End If
    End If
End Sub
'========================================================================
' Resizes the form
'========================================================================
Private Sub sizeform()
    On Error GoTo ErrorHandler
    'Resize the arena
    arena.width = Screen.TwipsPerPixelX * animationList(activeAnimationIndex).theData.animSizeX
    arena.height = Screen.TwipsPerPixelY * animationList(activeAnimationIndex).theData.animSizeY
    'Resize the form
    Me.width = arena.width + 500
    Me.height = arena.height + 500
    'Redraw the frame
    Call DrawFrame(animationList(activeAnimationIndex).theData.animCurrentFrame)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
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


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
   MinButton       =   0   'False
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
         Visible         =   0   'False
      End
      Begin VB.Menu mnuInstallUpgrade 
         Caption         =   "Install Upgrade"
         Visible         =   0   'False
      End
   End
   Begin VB.Menu mnuAnm 
      Caption         =   "Animation"
      Begin VB.Menu mnuWizard 
         Caption         =   "Wizard..."
         Shortcut        =   ^W
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
   End
   Begin VB.Menu mnuHelp 
      Caption         =   "Help"
      Begin VB.Menu mnuUsersGuide 
         Caption         =   "User's Guide"
         Shortcut        =   {F1}
      End
      Begin VB.Menu sub7 
         Caption         =   "-"
      End
      Begin VB.Menu mnuTutorial 
         Caption         =   "Tutorial"
         Visible         =   0   'False
      End
      Begin VB.Menu mnuHistorytxt 
         Caption         =   "History.txt"
      End
      Begin VB.Menu sub8 
         Caption         =   "-"
      End
      Begin VB.Menu mnuRegistrationInfo 
         Caption         =   "Registration Info"
         Visible         =   0   'False
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
'All contents copyright 2003, 2004, 2005 Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'========================================================================

Option Explicit

'Index into the vector of animations maintained in commonanimation
Public dataIndex As Long

'Defines for resizing the animation
Private Declare Function IMGGetWidth Lib "actkrt3.dll" (ByVal nFreeImagePtr As Long) As Long
Private Declare Function IMGGetHeight Lib "actkrt3.dll" (ByVal nFreeImagePtr As Long) As Long
Private Declare Function IMGLoad Lib "actkrt3.dll" (ByVal filename As String) As Long
Private Declare Function IMGFree Lib "actkrt3.dll" (ByVal nFreeImagePtr As Long) As Long

'List entry in tkmainform.anmCmbSize
Private Const IMAGE_SIZE = "Image Size"

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
Public Sub fillInfo(): On Error Resume Next

    With animationList(activeAnimationIndex).theData
    
        'Animation size
        tkMainForm.txtAnimXSize.Text = CStr(.animSizeX)
        tkMainForm.txtAnimYSize.Text = CStr(.animSizeY)
        
        'Set the value of the pausebar
        tkMainForm.hsbAnimPause.value = .animPause * 20
        
        tkMainForm.anmTxtPause.Text = CStr(.animPause)
        
        'Resize the form
        Call sizeForm
        
        'Draw the current frame
        Call DrawFrame(.animCurrentFrame)
        
    End With
    
End Sub

'========================================================================
' Set the size of the animation
'========================================================================
Public Sub setAnimSize(ByVal dims As String): On Error Resume Next

    animationList(activeAnimationIndex).animNeedUpdate = True
    
    If dims = IMAGE_SIZE Then
        Call resizeToImage(animationList(activeAnimationIndex).theData)
    Else
        Dim x As Long, y As Long
        x = val(Left$(dims, InStr(1, dims, "x", vbTextCompare)))
        y = val(Mid$(dims, InStr(1, dims, "x", vbTextCompare) + 1))
        
        If x > 0 Then tkMainForm.txtAnimXSize = x
        If y > 0 Then tkMainForm.txtAnimYSize = y
    End If
        
    'Resize the form
    Call Form_Resize
    Call fillInfo
    
End Sub

'========================================================================
' Set the XSize
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
' Set the YSize
'========================================================================
Public Sub setYSize(): On Error Resume Next
    
    'Needs to be updated
    animationList(activeAnimationIndex).animNeedUpdate = True
    
    'Set the Y-Size
    animationList(activeAnimationIndex).theData.animSizeY = Abs(val(tkMainForm.txtAnimYSize.Text))
    
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
    animationList(activeAnimationIndex).theData.animPause = Abs(val(tkMainForm.anmTxtPause.Text))
    
End Sub

'========================================================================
' Set the frame sound
'========================================================================
Public Sub browseSound(): On Error Resume Next
    Dim file As String, fileTypes As String
    If browseFileDialog(Me.hwnd, projectPath & mediaPath, "Select frame sound", "wav", strFileDialogFilterMedia, file) Then
        animationList(activeAnimationIndex).theData.animSound(animationList(activeAnimationIndex).theData.animCurrentFrame) = file
        tkMainForm.anmTxtSound.Text = file
        animationList(activeAnimationIndex).animNeedUpdate = True
    End If
End Sub

'========================================================================
' Change the frame sound
'========================================================================
Public Sub changeSound(ByVal file As String): On Error Resume Next

    animationList(activeAnimationIndex).theData.animSound(animationList(activeAnimationIndex).theData.animCurrentFrame) = file
    animationList(activeAnimationIndex).animNeedUpdate = True
    
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
    Call arena.Cls
    
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
        .animFrame(.animCurrentFrame) = vbNullString
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
        .animFrame(50) = vbNullString
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
        arena.Cls
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
        arena.Cls
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
    Call arena.Cls
    
    'Draw the frame
    Call AnimDrawFrame(animationList(activeAnimationIndex).theData, framenum, 0, 0, arena.hdc)
    
    'Refresh the picturebox
    Call arena.Refresh
    
    'Get the total number of frames
    Dim maxFrame As Long
    maxFrame = animGetMaxFrame(animationList(activeAnimationIndex).theData)
    
    With animationList(activeAnimationIndex).theData
    
        'Update the boxes and such
        tkMainForm.lblAnimFrameCount.Caption = CStr(.animCurrentFrame + 1) & " / " & CStr(maxFrame + 1) & ": " & .animFrame(.animCurrentFrame)
        tkMainForm.anmTxtSound.Text = .animSound(.animCurrentFrame)
        tkMainForm.transpcolor.backColor = .animTransp(.animCurrentFrame)
        tkMainForm.lblAnimRGB.Caption = "RGB (" & red(.animTransp(.animCurrentFrame)) & _
                                        ", " & green(.animTransp(.animCurrentFrame)) & _
                                        ", " & blue(.animTransp(.animCurrentFrame)) & ")"
    End With
    
End Sub

'========================================================================
' Animation wizard
'========================================================================
Private Sub mnuWizard_Click(): On Error Resume Next
    frmAnmWizard.Show vbModal
End Sub

'========================================================================
' Form_Load
'========================================================================
Private Sub Form_Load(): On Error Resume Next
   
    'Create new slot
    dataIndex = VectAnimationNewSlot()
    activeAnimationIndex = dataIndex
    
    'Clear the animation info
    Call AnimationClear(animationList(dataIndex).theData)
    animationList(dataIndex).theData.animPause = 0.15
    
    tkMainForm.anmCmbSize.list(0) = IMAGE_SIZE

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
        tkMainForm.bBar.visible = True
        tkMainForm.animationExtras.visible = True
        tkMainForm.animationTools.visible = True
        tkMainForm.animationTools.Top = tkMainForm.toolTop
    End With
    
    'Set the info
    Call fillInfo
    
    
End Sub

'========================================================================
' Update selected color if dropper selected (will have changed in
' arena_MouseMove)
'========================================================================
Private Sub Form_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
    With animationList(activeAnimationIndex).theData
        If .animGetTransp Then
            tkMainForm.transpcolor.backColor = .animTransp(.animCurrentFrame)
            tkMainForm.lblAnimRGB.Caption = "RGB (" & red(.animTransp(.animCurrentFrame)) & _
                                            ", " & green(.animTransp(.animCurrentFrame)) & _
                                            ", " & blue(.animTransp(.animCurrentFrame)) & ")"
        End If
    End With
End Sub

'========================================================================
' Form_Unload
'========================================================================
Private Sub Form_Unload(Cancel As Integer): On Error Resume Next

    'See if the file needs to be saved
    If animationList(activeAnimationIndex).animNeedUpdate Then
        
        'Yup, ask if the user wants to
        Dim answer As VbMsgBoxResult
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
    Call tkMainForm.refreshTabs
    
End Sub

'========================================================================
' Form_Resize
'========================================================================
Private Sub Form_Resize(): On Error Resume Next

    'Set a minimum width & height relative to the arena width and height
    If Me.Height <= arena.Height + 1000 Then Me.Height = arena.Height + 1000
    If Me.width <= arena.width + 600 Then Me.width = arena.width + 600
        
    'The position
    arena.Left = ((Me.width - arena.width) / 2) - 55
    arena.Top = (Me.Height - arena.Height) / 2 - 250
    
End Sub

'========================================================================
' Resizes the form & arena
'========================================================================
Private Sub sizeForm(): On Error Resume Next
    
    'Resize the arena
    arena.width = Screen.TwipsPerPixelX * animationList(activeAnimationIndex).theData.animSizeX
    arena.Height = Screen.TwipsPerPixelY * animationList(activeAnimationIndex).theData.animSizeY
    
    'Resize the form
    Me.width = arena.width + 500
    Me.Height = arena.Height + 500
    
    'Redraw the frame
    Call DrawFrame(animationList(activeAnimationIndex).theData.animCurrentFrame)

End Sub

'========================================================================
' Form_KeyPress
'========================================================================
Private Sub Form_KeyPress(KeyAscii As Integer): On Error Resume Next

    'Check which key is pressed
    If (UCase(chr$(KeyAscii)) = "L") Then
    
        'L, open tileset
        If LenB(configfile.lastTileset) = 0 Then
        
            'Last tileset is empty
            Call arena_MouseDown(0, 0, 0, 0)
            Exit Sub
            
        Else
        
            tstFile = configfile.lastTileset
            tilesetForm.Show vbModal
            Call changeSelectedTile(setFilename)
            
        End If
    End If
    
End Sub

'========================================================================
' When you click in the animation picturebox
'========================================================================
Private Sub arena_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
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
            colour = vbFrmPoint(arena, x, y)
            
            'Set the transparent color
            .animTransp(.animCurrentFrame) = colour
            
            'If the next frame is empty, set the transparent color there too
            If LenB(.animFrame(.animCurrentFrame + 1)) = 0 Then
                .animTransp(.animCurrentFrame + 1) = colour
            End If
            
            'Redraw the current frame
            Call DrawFrame(.animCurrentFrame)
            
        Else
        
            'Frame click assigns a new image.
            'Both image files (from the \Bitmap folder) and tiles can be selected here,
            'so a check for valid subfolders is more tricky than browseFileDialog().
            
            Dim dlg As FileDialogInfo
            
            dlg.strDefaultFolder = projectPath & bmpPath
            dlg.strTitle = "Select Image"
            dlg.strDefaultExt = "bmp"
            dlg.strFileTypes = strFileDialogFilterWithTiles
            
            ChDir (currentDir)
            If Not OpenFileDialog(dlg, Me.hwnd) Then Exit Sub
            If LenB(dlg.strSelectedFileNoPath) = 0 Then Exit Sub
                
            'Needs to be updated
            animationList(activeAnimationIndex).animNeedUpdate = True
                
            'Extension of filename
            Dim ex As String, file As String, defaultPath As String
            ex = UCase$(GetExt(dlg.strSelectedFile))
            
            defaultPath = projectPath & IIf(ex = "TST", tilePath, bmpPath)
            
            'Preserve the path if a sub-folder is chosen.
            If Not getValidPath(dlg.strSelectedFile, defaultPath, file, True) Then Exit Sub
            
            'Copy folders outside the default directory into the default directory.
            If Not fileExists(defaultPath & file) Then
                FileCopy dlg.strSelectedFile, defaultPath & file
            End If
                
            If ex = "TST" Then
                'Set a few badly-named globals for the tileset browser.
                tstnum = 0
                tstFile = file
                configfile.lastTileset = tstFile
                
                tilesetForm.Show vbModal
                If LenB(setFilename) = 0 Then Exit Sub
                
                .animFrame(.animCurrentFrame) = setFilename
                    
            Else
                'All other images should reside in the \Bitmap folder or subfolders therein.
                .animFrame(.animCurrentFrame) = file
            End If
            
            'If the next frame is empty, set the transparent color.
            If LenB(.animFrame(.animCurrentFrame + 1)) = 0 Then
                .animTransp(.animCurrentFrame + 1) = .animTransp(.animCurrentFrame)
            End If
            
            'Redraw the frame
            Call resizeToImage(animationList(activeAnimationIndex).theData)
            Call fillInfo
            
        End If
        
    End With
    
End Sub

'========================================================================
' Update selected color if dropper selected
'========================================================================
Private Sub arena_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single): On Error Resume Next
    If animationList(activeAnimationIndex).theData.animGetTransp Then
        Dim color As Long
        color = arena.point(x, y)
        tkMainForm.transpcolor.backColor = color
        tkMainForm.lblAnimRGB.Caption = "RGB (" & red(color) & _
                                        ", " & green(color) & _
                                        ", " & blue(color) & ")"
    End If
End Sub

'========================================================================
' Change the currently selected tile
'========================================================================
Public Sub changeSelectedTile(ByVal file As String): On Error Resume Next
    
    'Exit sub if file is empty
    If LenB(file) = 0 Then Exit Sub
    
    With animationList(activeAnimationIndex).theData
    
        'Set the file of the current frame
        .animFrame(.animCurrentFrame) = file
        If LenB(.animFrame(.animCurrentFrame + 1)) = 0 Then
        
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

    activeAnimation.Show
    Call openAnimation(file, animationList(activeAnimationIndex).theData)
    
    'Preserve the path if file is in a sub-folder.
    Call getValidPath(file, projectPath & miscPath, animationList(activeAnimationIndex).animFile, False)
    activeAnimation.Caption = animationList(activeAnimationIndex).animFile
    
    Call fillInfo
    animationList(activeAnimationIndex).animNeedUpdate = False
   
End Sub

'========================================================================
' Saves the file
'========================================================================
Public Sub saveFile(): On Error Resume Next
    Call Show
    Call saveanimmnu_Click
End Sub

'========================================================================
' Save animation
'========================================================================
Private Sub saveanimmnu_Click(): On Error Resume Next

    ' If the animation hasn't been saved yet, call the "Save As" sub
    If LenB(animationList(activeAnimationIndex).animFile) = 0 Then
    
        Call saveasanimmnu_Click
        
    Else
        Dim strFile As String
        strFile = projectPath & miscPath & animationList(activeAnimationIndex).animFile

        ' Make sure it's writable
        If (fileExists(strFile)) Then
            If (GetAttr(strFile) And vbReadOnly) Then

                ' Read-only
                Call MsgBox("This file is read-only; please choose a different file.")
                Call saveasanimmnu_Click
                Exit Sub

            End If
        End If

        ' If the animation is already saved, save it again
        Call saveAnimation(strFile, animationList(activeAnimationIndex).theData)

        ' No need to update anymore
        animationList(activeAnimationIndex).animNeedUpdate = False

    End If

End Sub

'========================================================================
' Save animation as
'========================================================================
Private Sub saveasanimmnu_Click(): On Error Resume Next
    
    Dim dlg As FileDialogInfo
    
    dlg.strDefaultFolder = projectPath & miscPath
    dlg.strTitle = "Save Animation As"
    dlg.strDefaultExt = "anm"
    dlg.strFileTypes = "RPG Toolkit Animation (*.anm)|*.anm|All files(*.*)|*.*"
    
    If Not SaveFileDialog(dlg, Me.hwnd, True) Then Exit Sub
    If LenB(dlg.strSelectedFile) = 0 Then Exit Sub
    
    'Preserve the path if a sub-folder is chosen.
    If Not getValidPath(dlg.strSelectedFile, dlg.strDefaultFolder, animationList(activeAnimationIndex).animFile, True) Then Exit Sub

    ' Save the animation
    Call saveAnimation(dlg.strDefaultFolder & animationList(activeAnimationIndex).animFile, animationList(activeAnimationIndex).theData)
    animationList(activeAnimationIndex).animNeedUpdate = False
    
    ' Update the caption
    activeAnimation.Caption = animationList(activeAnimationIndex).animFile
    Call tkMainForm.fillTree(vbNullString, projectPath)
    
End Sub

'========================================================================
' Close
'========================================================================
Private Sub closeanimmnu_Click(): On Error Resume Next
    Unload Me
End Sub

'========================================================================
' Resize the animation to the current frame's image
'========================================================================
Private Sub resizeToImage(ByRef anm As TKAnimation): On Error Resume Next
    
    Dim ex As String
    ex = UCase$(GetExt(anm.animFrame(anm.animCurrentFrame)))
    
    If Left$(ex, 3) = "TST" Then
        anm.animSizeX = 32
        anm.animSizeY = 32
    ElseIf ex = "TBM" Then
        Dim tbm As TKTileBitmap
        Call OpenTileBitmap(projectPath & bmpPath & anm.animFrame(anm.animCurrentFrame), tbm)
        anm.animSizeX = tbm.sizex * 32
        anm.animSizeY = tbm.sizey * 32
    Else
        Dim img As Long
        img = IMGLoad(projectPath & bmpPath & anm.animFrame(anm.animCurrentFrame))
        If (img) Then
            anm.animSizeX = IMGGetWidth(img)
            anm.animSizeY = IMGGetHeight(img)
            Call IMGFree(img)
        End If
    End If
    
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




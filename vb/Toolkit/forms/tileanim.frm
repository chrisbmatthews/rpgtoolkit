VERSION 5.00
Begin VB.Form tileanim 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Animated Tile"
   ClientHeight    =   2520
   ClientLeft      =   45
   ClientTop       =   615
   ClientWidth     =   4815
   Icon            =   "tileanim.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   ScaleHeight     =   2520
   ScaleWidth      =   4815
   Tag             =   "1814"
   Begin VB.Frame mainFrame 
      Height          =   2175
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   4575
      Begin VB.PictureBox isotForm 
         Appearance      =   0  'Flat
         AutoRedraw      =   -1  'True
         BackColor       =   &H80000005&
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   480
         Left            =   960
         ScaleHeight     =   32
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   64
         TabIndex        =   13
         Top             =   360
         Width           =   960
      End
      Begin VB.Timer animTimer 
         Interval        =   5
         Left            =   3960
         Top             =   720
      End
      Begin VB.PictureBox tform 
         Appearance      =   0  'Flat
         AutoRedraw      =   -1  'True
         BackColor       =   &H80000005&
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   480
         Left            =   240
         ScaleHeight     =   32
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   32
         TabIndex        =   9
         Top             =   360
         Width           =   480
      End
      Begin VB.HScrollBar pausebar 
         Height          =   135
         Left            =   2280
         Max             =   200
         Min             =   1
         TabIndex        =   8
         Top             =   480
         Value           =   1
         Width           =   2175
      End
      Begin VB.Frame Frame1 
         Height          =   735
         Left            =   120
         TabIndex        =   1
         Top             =   1200
         Width           =   4335
         Begin VB.CommandButton Command6 
            Height          =   375
            Left            =   1440
            Picture         =   "tileanim.frx":0CCA
            Style           =   1  'Graphical
            TabIndex        =   3
            Top             =   240
            Width           =   375
         End
         Begin VB.CommandButton Command1 
            Height          =   375
            Left            =   480
            Picture         =   "tileanim.frx":1994
            Style           =   1  'Graphical
            TabIndex        =   5
            Top             =   240
            Width           =   375
         End
         Begin VB.CommandButton Command5 
            Caption         =   "Del"
            Height          =   375
            Left            =   3720
            TabIndex        =   7
            Tag             =   "1517"
            Top             =   240
            Width           =   495
         End
         Begin VB.CommandButton Command4 
            Height          =   375
            Left            =   120
            Picture         =   "tileanim.frx":265E
            Style           =   1  'Graphical
            TabIndex        =   6
            Top             =   240
            Width           =   375
         End
         Begin VB.CommandButton Command2 
            Height          =   375
            Left            =   1080
            Picture         =   "tileanim.frx":3328
            Style           =   1  'Graphical
            TabIndex        =   4
            Top             =   240
            Width           =   375
         End
         Begin VB.CommandButton Command3 
            Caption         =   "Ins"
            Height          =   375
            Left            =   3120
            TabIndex        =   2
            Tag             =   "1518"
            Top             =   240
            Width           =   495
         End
      End
      Begin VB.Label framecount 
         Caption         =   "Frame 1 / 1"
         Height          =   255
         Left            =   2280
         TabIndex        =   12
         Tag             =   "1527"
         Top             =   720
         Width           =   2175
      End
      Begin VB.Label Label2 
         Caption         =   "Slow"
         Height          =   255
         Left            =   2280
         TabIndex        =   11
         Tag             =   "1179"
         Top             =   240
         Width           =   495
      End
      Begin VB.Label Label1 
         Caption         =   "Fast"
         Height          =   255
         Left            =   3960
         TabIndex        =   10
         Tag             =   "1178"
         Top             =   240
         Width           =   495
      End
   End
   Begin VB.Menu filemnu 
      Caption         =   "File"
      Begin VB.Menu mnunewproject 
         Caption         =   "New Project"
         Shortcut        =   ^N
      End
      Begin VB.Menu mnunew 
         Caption         =   "New..."
         Begin VB.Menu mnunewtile 
            Caption         =   "Tile"
         End
         Begin VB.Menu mnunewanimatedtile 
            Caption         =   "Animated Tile"
         End
         Begin VB.Menu mnunewboard 
            Caption         =   "Board"
         End
         Begin VB.Menu mnunewplayer 
            Caption         =   "Player"
         End
         Begin VB.Menu mnunewitem 
            Caption         =   "Item"
         End
         Begin VB.Menu mnunewenemy 
            Caption         =   "Enemy"
         End
         Begin VB.Menu mnunewrpgcodeprogram 
            Caption         =   "RPGCode Program"
         End
         Begin VB.Menu mnuNewFightBackground 
            Caption         =   "Fight Background"
         End
         Begin VB.Menu mnunewspecialmove 
            Caption         =   "Special Move"
         End
         Begin VB.Menu mnunewstatuseffect 
            Caption         =   "Status Effect"
         End
         Begin VB.Menu mnunewanimation 
            Caption         =   "Animation"
         End
         Begin VB.Menu mnunewtilebitmap 
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
      Begin VB.Menu savemnu 
         Caption         =   "Save Animation"
         Shortcut        =   ^S
         Tag             =   "1530"
      End
      Begin VB.Menu saveasmnu 
         Caption         =   "Save Animation As"
         Shortcut        =   ^A
         Tag             =   "1531"
      End
      Begin VB.Menu mnusaveall 
         Caption         =   "Save All"
      End
      Begin VB.Menu sub2 
         Caption         =   "-"
      End
      Begin VB.Menu closemnu 
         Caption         =   "Close"
         Tag             =   "1088"
      End
      Begin VB.Menu mnuexit 
         Caption         =   "Exit"
      End
   End
   Begin VB.Menu mnutoolkit 
      Caption         =   "Toolkit"
      Begin VB.Menu mnutestgame 
         Caption         =   "Test Game"
         Shortcut        =   {F5}
      End
      Begin VB.Menu mnuselectlanguage 
         Caption         =   "Select Language"
         Shortcut        =   ^L
      End
      Begin VB.Menu sub3 
         Caption         =   "-"
      End
      Begin VB.Menu mnuinstallupgrade 
         Caption         =   "Install Upgrade"
      End
   End
   Begin VB.Menu mnubuild 
      Caption         =   "Build"
      Begin VB.Menu mnucreatepakfile 
         Caption         =   "Create PakFile"
      End
      Begin VB.Menu mnumakeexe 
         Caption         =   "Make EXE"
         Shortcut        =   {F7}
      End
      Begin VB.Menu sub5 
         Caption         =   "-"
      End
      Begin VB.Menu mnucreatesetup 
         Caption         =   "Create Setup"
      End
   End
   Begin VB.Menu mnuwindow 
      Caption         =   "Window"
      WindowList      =   -1  'True
      Begin VB.Menu mnushowtools 
         Caption         =   "Show/Hide Tools"
      End
      Begin VB.Menu mnushowprojectlist 
         Caption         =   "Show/Hide Project List"
      End
      Begin VB.Menu sub6 
         Caption         =   "-"
      End
      Begin VB.Menu mnutilehorizontally 
         Caption         =   "Tile Horizontally"
      End
      Begin VB.Menu mnutilevertically 
         Caption         =   "Tile Vertically"
      End
      Begin VB.Menu mnucascade 
         Caption         =   "Cascade"
      End
      Begin VB.Menu mnuarrangeicons 
         Caption         =   "Arrange Icons"
      End
   End
   Begin VB.Menu mnuHelp 
      Caption         =   "Help"
      Begin VB.Menu mnuusersguide 
         Caption         =   "User's Guide"
         Shortcut        =   {F1}
      End
      Begin VB.Menu mnurpgcodeprimer 
         Caption         =   "RPGCode Primer"
      End
      Begin VB.Menu mnurpgcodereference 
         Caption         =   "RPGCode Reference"
      End
      Begin VB.Menu sub8 
         Caption         =   "-"
      End
      Begin VB.Menu mnututorial 
         Caption         =   "Tutorial"
      End
      Begin VB.Menu mnuhistorytxt 
         Caption         =   "History.txt"
      End
      Begin VB.Menu sub9 
         Caption         =   "-"
      End
      Begin VB.Menu mnuregistrationinfo 
         Caption         =   "Registration Info"
      End
      Begin VB.Menu mnuabout 
         Caption         =   "About"
      End
   End
End
Attribute VB_Name = "tileanim"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984

Public dataIndex As Long    'index into the vector of ste maintained in commonenemy


Public Sub changeSelectedTile(ByVal file As String)
    On Error Resume Next
    
    If file = "" Then Exit Sub
    Call TileAnmInsert(file, tileAnmList(activeTileAnmIndex).theData, tileAnmList(activeTileAnmIndex).theData.animTileCurrentFrame)
    Call DrawTileFrame(tileAnmList(activeTileAnmIndex).theData.animTileCurrentFrame)
End Sub


Public Function formType() As Long
    'identify type of form
    On Error Resume Next
    formType = FT_TILEANIM
End Function


Public Sub saveAsFile()
    'saves the file.
    On Error GoTo errorhandler
    If tileAnmList(activeTileAnmIndex).animTileNeedUpdate = True Then
        Me.Show
        saveasmnu_Click
    End If
    
    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub





Public Sub saveFile()
    'saves the file.
    On Error GoTo errorhandler
    'If tileAnmList(activeTileAnmIndex).animTileNeedUpdate = True Then
        tileAnmList(activeTileAnmIndex).animTileNeedUpdate = False
        If tileAnmList(activeTileAnmIndex).animTileFile$ = "" Then
            Me.Show
            saveasmnu_Click
            Exit Sub
        End If
        Call saveTileAnm(projectPath$ + tilepath$ + tileAnmList(activeTileAnmIndex).animTileFile$, tileAnmList(activeTileAnmIndex).theData)
        Me.caption = LoadStringLoc(1814, "Create Animated Tile") + " (" + tileAnmList(activeTileAnmIndex).animTileFile$ + ")"
    'End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub



Public Sub checkSave()
    'check if the anim has changed an it needs to be saved...
    On Error GoTo errorhandler
    If tileAnmList(activeTileAnmIndex).animTileNeedUpdate = True Then
        aa = MsgBox(LoadStringLoc(939, "Would you like to save your changes to the current animation?"), vbYesNo)
        If aa = 6 Then
            'yes-- save
            Call saveFile
        End If
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub



Public Sub openFile(file$)
    'opens animation.
    On Error Resume Next
    activeTileAnm.Show
    Call checkSave
    filename$(1) = file$
    antiPath$ = absNoPath(file$)
    FileCopy filename$(1), projectPath$ + tilepath$ + antiPath$
    Call openTileAnm(filename$(1), tileAnmList(activeTileAnmIndex).theData)
    Call infofill
    tileAnmList(activeTileAnmIndex).animTileFile$ = antiPath$
    Me.caption = LoadStringLoc(1814, "Create Animated Tile") + "  (" + antiPath$ + ")"
    tileAnmList(activeTileAnmIndex).animTileNeedUpdate = False
End Sub



Sub animateTileFrames()
    'find max frame...
    On Error GoTo errorhandler
    Dim pauseLen As Double
    pauseLen = 0
    pauseLen = 1 / tileAnmList(activeTileAnmIndex).theData.animTilePause
    
    For t = 0 To tileAnmList(activeTileAnmIndex).theData.animTileFrames - 1
        Call DrawTileFrame(t)
        DoEvents
        ll = Timer
        Do While Timer - ll < pauseLen
        Loop
    Next t
    tileAnmList(activeTileAnmIndex).theData.animTileCurrentFrame = t

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


'FIXIT: Declare 'framenum' with an early-bound data type                                   FixIT90210ae-R1672-R1B8ZE
Private Sub fillFrameNum(framenum)
    'now fill in frame number text box...
    'find max frame...
    On Error GoTo errorhandler
    mf = 0
    For t = 0 To UBound(tileAnmList(activeTileAnmIndex).theData.animTileFrame)
        If TileAnmGet(tileAnmList(activeTileAnmIndex).theData, t) <> "" Then
            mf = mf + 1
        End If
    Next t
    framecount.caption = str$(framenum + 1) + " of"
    If tileAnmList(activeTileAnmIndex).theData.animTileFrames = 0 Then
        framecount.caption = framecount.caption + " 1"
    Else
        framecount.caption = framecount.caption + str$(TileAnmFrameCount(tileAnmList(activeTileAnmIndex).theData))
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Sub infofill()
    'pausebar.Value = animationList(activeanimationindex).theData.animPause * 30
    On Error GoTo errorhandler
    BF = tileAnmList(activeTileAnmIndex).animTileNeedUpdate
    Call DrawTileFrame(tileAnmList(activeTileAnmIndex).theData.animTileCurrentFrame)
    pausebar.value = tileAnmList(activeTileAnmIndex).theData.animTilePause
    tileAnmList(activeTileAnmIndex).animTileNeedUpdate = BF

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

'FIXIT: Declare 'framenum' with an early-bound data type                                   FixIT90210ae-R1672-R1B8ZE
Sub DrawTileFrame(framenum)
    'draw the frame number.
    On Error GoTo errorhandler
    Call GFXClearTileCache
    
    Call vbPicCls(tform)
    Call vbPicCls(isotForm)
    If TileAnmGet(tileAnmList(activeTileAnmIndex).theData, framenum) <> "" Then
        Call drawtile(vbPicHDC(tform), projectPath$ + tilepath$ + TileAnmGet(tileAnmList(activeTileAnmIndex).theData, framenum), 1, 1, 0, 0, 0, False)
    
        Call drawtile(vbPicHDC(isotForm), projectPath$ + tilepath$ + TileAnmGet(tileAnmList(activeTileAnmIndex).theData, framenum), 1, 2, 0, 0, 0, False, True, True, True)
    End If
    
    Call vbPicRefresh(tform)
    Call vbPicRefresh(isotForm)
    Call fillFrameNum(framenum)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Private Sub animTimer_Timer()
    If TileAnmShouldDrawFrame(tileAnmList(activeTileAnmIndex).theData) Then
        Call vbPicCls(tform)
        Call vbPicCls(isotForm)
        
        Call TileAnmDrawNextFrame(tileAnmList(activeTileAnmIndex).theData, vbPicHDC(tform), 1, 1, 0, 0, 0, True, True, False, vbPicHDC(isotForm))
        Call vbPicRefresh(tform)
        Call vbPicRefresh(isotForm)
        
        'Call fillFrameNum(framenum)
    End If
End Sub

Private Sub closemnu_Click()
    activeTileAnm.Hide
End Sub

Private Sub Command1_Click()
    On Error GoTo errorhandler
    If tileAnmList(activeTileAnmIndex).theData.animTileCurrentFrame = UBound(tileAnmList(activeTileAnmIndex).theData.animTileFrame) Then Exit Sub
    tileAnmList(activeTileAnmIndex).theData.animTileCurrentFrame = tileAnmList(activeTileAnmIndex).theData.animTileCurrentFrame + 1
    Call DrawTileFrame(tileAnmList(activeTileAnmIndex).theData.animTileCurrentFrame)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command2_Click()
    On Error GoTo errorhandler
    'oldf = tileanmlist(activetileanmindex).thedata.animTileCurrentFrame
    'Call animateTileFrames
    'tileanmlist(activetileanmindex).thedata.animTileCurrentFrame = oldf
    'Call DrawTileFrame(oldf)
    Call GFXClearTileCache
    Command1.Enabled = False
    Command3.Enabled = False
    Command4.Enabled = False
    Command5.Enabled = False
    Command2.Enabled = False
    animTimer.Enabled = True

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command3_Click()
    On Error GoTo errorhandler
    tileAnmList(activeTileAnmIndex).animTileNeedUpdate = True
    For t = UBound(tileAnmList(activeTileAnmIndex).theData.animTileFrame) To tileAnmList(activeTileAnmIndex).theData.animTileCurrentFrame Step -1
        Call TileAnmInsert(TileAnmGet(tileAnmList(activeTileAnmIndex).theData, t), tileAnmList(activeTileAnmIndex).theData, t + 1)
    Next t
    Call TileAnmInsert("", tileAnmList(activeTileAnmIndex).theData, tileAnmList(activeTileAnmIndex).theData.animTileCurrentFrame)
    Call DrawTileFrame(tileAnmList(activeTileAnmIndex).theData.animTileCurrentFrame)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command4_Click()
    On Error GoTo errorhandler
    If tileAnmList(activeTileAnmIndex).theData.animTileCurrentFrame = 0 Then Exit Sub
    tileAnmList(activeTileAnmIndex).theData.animTileCurrentFrame = tileAnmList(activeTileAnmIndex).theData.animTileCurrentFrame - 1
    Call DrawTileFrame(tileAnmList(activeTileAnmIndex).theData.animTileCurrentFrame)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Private Sub Command5_Click()
    On Error GoTo errorhandler
    tileAnmList(activeTileAnmIndex).animTileNeedUpdate = True
    For t = tileAnmList(activeTileAnmIndex).theData.animTileCurrentFrame To UBound(tileAnmList(activeTileAnmIndex).theData.animTileFrame)
        Call TileAnmInsert(TileAnmGet(tileAnmList(activeTileAnmIndex).theData, t + 1), tileAnmList(activeTileAnmIndex).theData, t)
    Next t
    Call TileAnmInsert("", tileAnmList(activeTileAnmIndex).theData, UBound(tileAnmList(activeTileAnmIndex).theData.animTileFrame))
    Call DrawTileFrame(tileAnmList(activeTileAnmIndex).theData.animTileCurrentFrame)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command6_Click()
    Command1.Enabled = True
    Command3.Enabled = True
    Command4.Enabled = True
    Command5.Enabled = True
    Command2.Enabled = True
    animTimer.Enabled = False
End Sub

Private Sub Form_Activate()
    On Error Resume Next
    Set activeTileAnm = Me
    Set activeForm = Me
    activeTileAnmIndex = dataIndex


    'extras
    tkMainForm.animationExtras.Visible = False
    tkMainForm.bottomFrame.Visible = False
    tkMainForm.tileExtras.Visible = False
    tkMainForm.tileBmpExtras.Visible = False
    
    'tools
    tkMainForm.tilebmpTools.Visible = False
    tkMainForm.animationTools.Visible = False
    tkMainForm.rpgcodeTools.Visible = False
    tkMainForm.tileTools.Visible = False
    tkMainForm.tileTools.Top = tkMainForm.toolTop
    tkMainForm.boardTools.Visible = False
End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)
    On Error Resume Next
    If UCase$(Chr$(KeyAscii)) = "L" Then
        If lastTileset$ = "" Then
            ChDir (currentdir$)
            Dim dlg As FileDialogInfo
            dlg.strDefaultFolder = projectPath$ + tilepath$
            
            dlg.strTitle = "Open Tile"
            dlg.strDefaultExt = "tst"
            dlg.strFileTypes = "RPG Toolkit TileSet (*.tst)|*.tst|All files(*.*)|*.*"
            
            If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
                filename$(1) = dlg.strSelectedFile
                antiPath$ = dlg.strSelectedFileNoPath
            Else
                Exit Sub
            End If
            ChDir (currentdir$)
            If filename$(1) = "" Then Exit Sub
            FileCopy filename$(1), projectPath$ + tilepath$ + antiPath$
            whichType$ = extention(filename$(1))
            If UCase$(whichType$) = "TST" Then      'Yipes! we've selected an archive!
                tstnum = 0
                FileCopy filename$(1), projectPath$ + tilepath$ + antiPath$
                tstFile$ = antiPath$
                lastTileset$ = tstFile$
                tilesetform.Show 1
                'MsgBox setFilename$
                Call changeSelectedTile(setFilename)
            End If
            Exit Sub
        End If
        If lastTileset$ <> "" Then
            tstFile$ = lastTileset$
            tilesetform.Show 1
            If setFilename$ = "" Then Exit Sub
            Call TileAnmInsert(setFilename$, tileAnmList(activeTileAnmIndex).theData, tileAnmList(activeTileAnmIndex).theData.animTileCurrentFrame)
            Call DrawTileFrame(tileAnmList(activeTileAnmIndex).theData.animTileCurrentFrame)
        End If
    End If
End Sub

Private Sub Form_Load()
    On Error GoTo errorhandler
    Call LocalizeForm(Me)
    
    Set activeTileAnm = Me
    dataIndex = VectTileAnmNewSlot()
    activeTileAnmIndex = dataIndex
    Call TileAnmClear(tileAnmList(dataIndex).theData)
    
    animTimer.Enabled = False
    Call infofill

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Private Sub Form_Resize()
    On Error Resume Next
    'mainFrame.Left = (Me.width - mainFrame.width) / 2
    'mainFrame.Top = (Me.height - mainFrame.height) / 2
End Sub

Private Sub Form_Unload(Cancel As Integer)
    On Error Resume Next
    Call hideAllTools
End Sub

Private Sub isotForm_Click()
    On Error Resume Next
    Call tform_Click
End Sub

'FIXIT: bar_Change event has no Visual Basic .NET equivalent and will not be upgraded.     FixIT90210ae-R7593-R67265
Private Sub pausebar_Change()
    On Error GoTo errorhandler
    tileAnmList(activeTileAnmIndex).animTileNeedUpdate = True
    tileAnmList(activeTileAnmIndex).theData.animTilePause = pausebar.value
    'animTilePause = pausebar.Value / 30

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub saveasmnu_Click()
    On Error Resume Next
    ChDir (currentdir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + tilepath$
    dlg.strTitle = "Save Animation As"
    dlg.strDefaultExt = "tan"
    dlg.strFileTypes = "Tile Animation (*.tan)|*.tan|All files(*.*)|*.*"
    If SaveFileDialog(dlg, Me.hwnd) Then 'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentdir$)
    tileAnmList(activeTileAnmIndex).animTileNeedUpdate = False
    
    If filename$(1) = "" Then Exit Sub
    
    aa = fileExist(filename$(1))
    If aa = 1 Then
        bb = MsgBox(LoadStringLoc(949, "That file exists.  Are you sure you want to overwrite it?"), vbYesNo)
        If bb = 7 Then Exit Sub
    End If
    Call saveTileAnm(filename$(1), tileAnmList(activeTileAnmIndex).theData)
    animationList(activeAnimationIndex).animFile$ = antiPath$
    Me.caption = LoadStringLoc(1814, "Create Animated Tile") + " (" + antiPath$ + ")"
    Call tkMainForm.fillTree("", projectPath$)
End Sub

Private Sub savemnu_Click()
    On Error GoTo errorhandler
    If tileAnmList(activeTileAnmIndex).animTileFile$ = "" Then saveasmnu_Click: Exit Sub
    Call saveTileAnm(projectPath$ + tilepath$ + tileAnmList(activeTileAnmIndex).animTileFile, tileAnmList(activeTileAnmIndex).theData)
    tileAnmList(activeTileAnmIndex).animTileNeedUpdate = False

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub tform_Click()
    On Error Resume Next
    tileAnmList(activeTileAnmIndex).animTileNeedUpdate = True
    ChDir (currentdir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + tilepath$
    
    dlg.strTitle = "Open Tile"
    dlg.strDefaultExt = "tst"
    dlg.strFileTypes = "Supported Files|*.gph;*.tst|RPG Toolkit TileSet (*.tst)|*.tst|RPG Toolkit Tile (*.gph)|*.gph|All files(*.*)|*.*"
    
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentdir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + tilepath$ + antiPath$
    whichType$ = extention(filename$(1))
    If UCase$(whichType$) = "TST" Then      'Yipes! we've selected an archive!
        tstnum = 0
        FileCopy filename$(1), projectPath$ + tilepath$ + antiPath$
        tstFile$ = antiPath$
        lastTileset$ = tstFile$
        tilesetform.Show 1
        'MsgBox setFilename$
        If setFilename$ = "" Then Exit Sub
        Call TileAnmInsert(setFilename$, tileAnmList(activeTileAnmIndex).theData, tileAnmList(activeTileAnmIndex).theData.animTileCurrentFrame)
    Else
        Call TileAnmInsert(antiPath$, tileAnmList(activeTileAnmIndex).theData, tileAnmList(activeTileAnmIndex).theData.animTileCurrentFrame)
    End If
    
    Call DrawTileFrame(tileAnmList(activeTileAnmIndex).theData.animTileCurrentFrame)
End Sub


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
    tkMainForm.testgamemnu_Click
End Sub

Private Sub mnuOpenProject_Click()
    On Error Resume Next
    Call tkMainForm.mnuOpenProject_Click
End Sub

Private Sub mnuNewFightBackground_Click()
    On Error Resume Next
    Call tkMainForm.mnuNewFightBackground_Click
End Sub


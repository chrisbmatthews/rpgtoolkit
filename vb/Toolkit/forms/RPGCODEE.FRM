VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "richtx32.ocx"
Begin VB.Form rpgcodeedit 
   Caption         =   "RPGCode Program Editor (Untitled)"
   ClientHeight    =   5280
   ClientLeft      =   660
   ClientTop       =   1035
   ClientWidth     =   8010
   ControlBox      =   0   'False
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
   Icon            =   "RPGCODEE.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5280
   ScaleWidth      =   8010
   Tag             =   "12"
   WindowState     =   2  'Maximized
   Begin VB.Timer splitLinesTimer 
      Interval        =   1
      Left            =   1320
      Top             =   4200
   End
   Begin VB.PictureBox bookmarkToolbar 
      Align           =   1  'Align Top
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   330
      Left            =   0
      ScaleHeight     =   300
      ScaleWidth      =   7980
      TabIndex        =   1
      TabStop         =   0   'False
      Top             =   0
      Width           =   8010
      Begin VB.ComboBox cboCommentBookmarks 
         Height          =   315
         ItemData        =   "RPGCODEE.frx":0CCA
         Left            =   4080
         List            =   "RPGCODEE.frx":0CCC
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   5
         TabStop         =   0   'False
         Top             =   0
         Visible         =   0   'False
         Width           =   2010
      End
      Begin VB.ComboBox cboLabelBookmarks 
         Height          =   315
         ItemData        =   "RPGCODEE.frx":0CCE
         Left            =   6120
         List            =   "RPGCODEE.frx":0CD0
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   4
         TabStop         =   0   'False
         Top             =   0
         Visible         =   0   'False
         Width           =   1890
      End
      Begin VB.ComboBox cboMethodBookmarks 
         Height          =   315
         ItemData        =   "RPGCODEE.frx":0CD2
         Left            =   2040
         List            =   "RPGCODEE.frx":0CD4
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   3
         TabStop         =   0   'False
         Top             =   0
         Visible         =   0   'False
         Width           =   2010
      End
      Begin VB.ComboBox cboBookmarkType 
         Height          =   315
         ItemData        =   "RPGCODEE.frx":0CD6
         Left            =   0
         List            =   "RPGCODEE.frx":0CE3
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   2
         TabStop         =   0   'False
         Top             =   0
         Width           =   2010
      End
   End
   Begin VB.Timer RestartReColor 
      Interval        =   1
      Left            =   5880
      Top             =   4080
   End
   Begin VB.Timer CheckReColor 
      Interval        =   1
      Left            =   6360
      Top             =   4080
   End
   Begin RichTextLib.RichTextBox CodeForm 
      Height          =   2655
      Left            =   240
      TabIndex        =   0
      Top             =   1080
      Width           =   7695
      _ExtentX        =   13573
      _ExtentY        =   4683
      _Version        =   393217
      BorderStyle     =   0
      HideSelection   =   0   'False
      ScrollBars      =   3
      DisableNoScroll =   -1  'True
      TextRTF         =   $"RPGCODEE.frx":0D08
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Courier New"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.Menu prgfilemnu 
      Caption         =   "&File"
      Tag             =   "1201"
      Begin VB.Menu mnunewproject 
         Caption         =   "New Project"
      End
      Begin VB.Menu mnuNewPRG 
         Caption         =   "&New"
         Shortcut        =   ^N
         Visible         =   0   'False
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
         Begin VB.Menu mnunewAnimation 
            Caption         =   "Animation"
         End
         Begin VB.Menu mnunewTileBitmap 
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
         Caption         =   "&Open"
         Shortcut        =   ^O
      End
      Begin VB.Menu saveprgmnu 
         Caption         =   "&Save Program"
         Shortcut        =   ^S
         Tag             =   "1621"
      End
      Begin VB.Menu sasmnu 
         Caption         =   "Save Program &As"
         Tag             =   "1622"
      End
      Begin VB.Menu mnuSaveAll 
         Caption         =   "Save All"
      End
      Begin VB.Menu sub2 
         Caption         =   "-"
      End
      Begin VB.Menu closemnu 
         Caption         =   "Close"
         Tag             =   "1088"
      End
      Begin VB.Menu mnuExit 
         Caption         =   "E&xit"
      End
   End
   Begin VB.Menu mnuEdit 
      Caption         =   "Edit"
      Begin VB.Menu mnuCut 
         Caption         =   "C&ut"
      End
      Begin VB.Menu mnuCopy 
         Caption         =   "&Copy"
      End
      Begin VB.Menu mnuPaste 
         Caption         =   "&Paste"
      End
      Begin VB.Menu blankmenu1 
         Caption         =   "-"
         Visible         =   0   'False
      End
      Begin VB.Menu mnuUndo 
         Caption         =   "&Undo"
         Visible         =   0   'False
      End
      Begin VB.Menu mnuRedo 
         Caption         =   "&Redo"
         Visible         =   0   'False
      End
      Begin VB.Menu blankmenu5 
         Caption         =   "-"
      End
      Begin VB.Menu mnuSelectAll 
         Caption         =   "Select &All"
      End
   End
   Begin VB.Menu mnuView 
      Caption         =   "View"
      Begin VB.Menu mnuBookmarkToolbar 
         Caption         =   "&Bookmark Toolbar"
         Checked         =   -1  'True
      End
      Begin VB.Menu mnuNotepadMode 
         Caption         =   "&Notepad Mode"
         Checked         =   -1  'True
      End
   End
   Begin VB.Menu mnuTools 
      Caption         =   "Tools"
      Begin VB.Menu mnuIndentWizard 
         Caption         =   "Indent Wizard"
         Shortcut        =   ^I
      End
      Begin VB.Menu mnuAutoCommandWizard 
         Caption         =   "AutoCommand Wizard"
         Visible         =   0   'False
      End
      Begin VB.Menu mnuColorCoding 
         Caption         =   "Options"
      End
   End
   Begin VB.Menu rmnu 
      Caption         =   "Run"
      Tag             =   "1623"
      Begin VB.Menu rprg 
         Caption         =   "Run Program"
         Shortcut        =   {F5}
         Tag             =   "1624"
      End
      Begin VB.Menu dbmnu 
         Caption         =   "Debug"
         Enabled         =   0   'False
         Shortcut        =   +{F5}
         Tag             =   "1625"
      End
      Begin VB.Menu tpref 
         Caption         =   "Test Preferences"
         Tag             =   "1626"
      End
   End
   Begin VB.Menu gcodemnu 
      Caption         =   "Generate Code"
      Tag             =   "1627"
      Begin VB.Menu cconmnu 
         Caption         =   "Edit as Event"
         Tag             =   "1628"
         Visible         =   0   'False
      End
      Begin VB.Menu tkvismnu 
         Caption         =   "Visual Editor"
         Tag             =   "1629"
      End
   End
   Begin VB.Menu mnuToolkit 
      Caption         =   "Toolkit"
      Begin VB.Menu mnuTestGame 
         Caption         =   "Test Game"
      End
      Begin VB.Menu mnuSelectLanguage 
         Caption         =   "Select Language"
         Shortcut        =   ^L
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
      Begin VB.Menu mnuShowProjectList 
         Caption         =   "Show/Hide Project List"
      End
      Begin VB.Menu sub5 
         Caption         =   "-"
      End
      Begin VB.Menu mnuTileHorizonatlly 
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
   Begin VB.Menu hlpmen 
      Caption         =   "Help"
      Tag             =   "1206"
      Begin VB.Menu crefmnu 
         Caption         =   "Quick Reference"
         Shortcut        =   {F1}
         Tag             =   "1630"
      End
      Begin VB.Menu sub6 
         Caption         =   "-"
      End
      Begin VB.Menu mnuUsersGuide 
         Caption         =   "User's Guide"
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
      Begin VB.Menu mnuhistorytxt 
         Caption         =   "History.txt"
      End
      Begin VB.Menu sub8 
         Caption         =   "-"
      End
      Begin VB.Menu mnuAbout 
         Caption         =   "About"
      End
   End
End
Attribute VB_Name = "rpgcodeedit"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'TBD: Option Explicit

Public dataIndex As Long    'index into the vector of ste maintained in commonenemy
Private openingPorgram As Boolean  'flag to determine if a program is being opened.  Allows for loading large files in background

Public blackLine As Boolean
Private secondCombo As ComboBox
Private MouseDownSelStart As Long
Private MouseDownSelLength As Long
Private lastType As String
Private lastSecondCombo As String
Private dragging As Boolean
Private startX As Single
Private startY As Single
Private startTop As Single
Private oldLine As Long
Private undoBuffer() As String
Private oldCaption As String
Private meOldCaption As String
Private formLoaded As Boolean

' What is Purpose of this Function ?
' KSNiloc says:
'  So you can go TKMainForm.ActiveForm.FormType and tell what type of form
'  is active.
Public Function formType() As Long
On Error Resume Next

'Identify type of form
formType = FT_RPGCODE

End Function

Public Sub checkBadHabits(ByVal txt As String)
 'Select Case GetCommandName(AddNumberSignIfNeeded(txt))
 ' Case "LABEL"
 '  frmCodeTip.showTip "RPGCode Tip :: Labels", "You appear to be using a cod" _
    & "e label. While these may seem to be a practical solution to many loop" _
    & "ing or other program flow problems it will cause you much grief in " _
    & "the end. It is a generally bad programming habit and it is highly " _
    & "advised that you do not proceed to use them.", 1
 ' Case "BRANCH", "FBRANCH"
 '  frmCodeTip.showTip "RPGCode Tip :: Branching", "You appear to be using th" _
    & "e Branch() command. While branching may seem a practical and sensible " _
    & "way to access different parts of your program, it simply creates messy" _
    & "code. Branch() is *never* truly required in a program. Consider lookin" _
    & "g into the Method(), While(), and For() commands for a much nicer alte" _
    & "rnative.", 2
 ' Case "MBOX"
 '  frmCodeTip.showTip "RPGCode Tip :: MWin() Command", "It appears you are " _
    & "attempting to add a line of text to the message window by simply typi" _
    & "ng the command. It is strongly urged you use the MWin(text$) command " _
    & "to serve this purpose. Loose text is not supported with the use of " _
    & "AutoCommand() and soon it will not be supported at all.", 3
 'End Select
 'If InStr(1, txt, "#", vbTextCompare) > 0 And _
 ' Not GetCommandName(AddNumberSignIfNeeded(txt)) = "AUTOCOMMAND" Then
 ' frmCodeTip.showTip "RPGCode Tip :: AutoCommand()", "You seem to be using" _
   & " the ""#"" character to prefix a command. This is no longer required. " _
   & "Simply place ""#AutoCommand()"" at the top of your program. If you are" _
   & " using an existing program you can use the ""AutoCommand Wizard"" to " _
   & "save you time.", 4
 'End If
End Sub

Sub OpenProgram(ByVal filename As String)
On Error GoTo ErrorHandler

' Load the Program into text box.
codeForm.LoadFile filename, rtfText

' Call Syntax Color Routines
Call SplitLines
Exit Sub

ErrorHandler:
MsgBox "Cannot open specified filename", vbInformation + vbOKOnly, "RPG Toolkit"
Exit Sub
End Sub

Public Sub openFile(ByVal FileToOpen As String)
On Error Resume Next

Dim antiPath As String

' Create a new instant of the Program editor window
activeRPGCode.Show

' Not Sure ?
filename$(1) = FileToOpen
antiPath = absNoPath(FileToOpen)
FileCopy filename$(1), projectPath$ + prgPath$ + antiPath

' Open The Program
Call OpenProgram(filename$(1))

' Not Sure ?
rpgcodeList(activeRPGCodeIndex).prgName$ = antiPath$

' Localization ?
activeRPGCode.Caption = LoadStringLoc(803, "RPGCode Program Editor") + "  (" + antiPath$ + ")"

' We Haven't modified this file yet
rpgcodeList(activeRPGCodeIndex).prgNeedUpdate = False

End Sub

Public Sub saveFile(): On Error Resume Next
    'saves the file.
    
    filename(2) = rpgcodeList(activeRPGCodeIndex).prgName
    
    rpgcodeList(activeRPGCodeIndex).prgNeedUpdate = False
    
    If filename(2) = "" Then
        activeRPGCode.Show
        Call sasmnu_Click
        Exit Sub
    End If
    
    Call saveProgram(projectPath & prgPath & filename(2))

End Sub

Private Sub cconmnu_Click()
    Call frmEventEditor.Show(vbModal)
End Sub

Private Sub mnuAutoCommandWizard_Click()
 frmAutoCommandWizard.Show 1
End Sub

Private Sub mnuBookmarkToolbar_Click()

    ' ADDED BY KSNiloc
    
    On Error Resume Next

    Select Case mnuBookmarkToolbar.Checked
    
        Case True
            mnuBookmarkToolbar.Checked = False
            bookmarkToolbar.Visible = False
        
        Case False
            mnuBookmarkToolbar.Checked = True
            bookmarkToolbar.Visible = True
    
    End Select
    
    Form_Resize

End Sub

Private Sub mnuIndentWizard_Click()
 frmIndentWizard.Show 1
End Sub

'============================================================================
'Real-Time Syntax Coloring
'Designed and Programmed by Colin James Fitzpatrick (KSNiloc)
'============================================================================
'Depends on modSyntax
'============================================================================

Private Sub CodeForm_GotFocus()
    If Not mnuNotepadMode.Checked Then blackLine = True
End Sub

Private Sub CodeForm_KeyPress(KeyAscii As Integer): On Error Resume Next

    'Alterations made.
    rpgcodeList(activeRPGCodeIndex).prgNeedUpdate = True

    Select Case KeyAscii
    
        Case 22 ' Ctrl+V
            colorPastedCode
            addUndo

        Case 3  ' Ctrl+C
            Clipboard.SetText codeForm.SelText
            
        Case 26 ' Ctrl+Z
            doUndo

        Case 25 ' Ctrl+Y
            doRedo
            addUndo
            
        Case Else
            addUndo
            
    End Select

End Sub

Private Sub doUndo()
    
    On Error GoTo noUndo
    Dim dat As String
    dat = undoBuffer(-1)
    
    On Error Resume Next
    Dim oSS As Long
    Dim oSL As Long
    oSS = codeForm.selStart
    oSL = codeForm.SelLength
    codeForm.Text = undoBuffer(-1)
    codeForm.selStart = oSS
    codeForm.SelLength = oSL

    Dim a As Long
    ReDim Preserve undoBuffer(LBound(undoBuffer) To UBound(undoBuffer) + 1)
    For a = UBound(undoBuffer) - 1 To LBound(undoBuffer) Step -1
        undoBuffer(a + 1) = undoBuffer(a)
    Next
    ReDim Preserve undoBuffer(LBound(undoBuffer) + 1 To UBound(undoBuffer))

noUndo:
End Sub

Private Sub doRedo()

    On Error GoTo noRedo
    Dim dat As String
    dat = undoBuffer(1)

    On Error Resume Next
    Dim oSS As Long
    Dim oSL As Long
    oSS = codeForm.selStart
    oSL = codeForm.SelLength
    codeForm.Text = undoBuffer(1)
    codeForm.selStart = oSS
    codeForm.SelLength = oSL
    
    Dim a As Long
    ReDim Preserve undoBuffer(LBound(undoBuffer) - 1 To UBound(undoBuffer))
    For a = UBound(undoBuffer) To LBound(undoBuffer) + 1 Step -1
        undoBuffer(a - 1) = undoBuffer(a)
    Next
    ReDim Preserve undoBuffer(LBound(undoBuffer) To UBound(undoBuffer) - 1)
    
noRedo:
End Sub

Private Sub addUndo()

    On Error Resume Next
    Dim a As Long
    
    ReDim Preserve undoBuffer(LBound(undoBuffer) - 1 To UBound(undoBuffer))
    For a = 0 To LBound(undoBuffer) + 1 Step -1
        undoBuffer(a - 1) = undoBuffer(a)
    Next a
    
    ReDim Preserve undoBuffer(LBound(undoBuffer) To UBound(undoBuffer) + 1)
    For a = UBound(undoBuffer) - 1 To 1 Step -1
        undoBuffer(a + 1) = undoBuffer(a)
    Next a
    
    undoBuffer(0) = codeForm.Text

End Sub

Private Sub colorPastedCode()

    Dim oldSS As Long
    Dim oldSL As Long
    oldSS = codeForm.selStart
    oldSL = codeForm.SelLength
    SplitLines oldLine, codeForm.GetLineFromChar(oldSS)
    codeForm.selStart = oldSS
    codeForm.SelLength = oldSL
    blackLine = True
    codeForm.SetFocus
    blackLine = False

End Sub

Private Sub mnuNewPRG_Click()
    ' ! ADDED BY KSNiloc...
    On Error Resume Next
    Shell App.path & "\" & App.EXEName & ".exe .prg", vbNormalFocus
End Sub

Public Sub mnuNotepadMode_Click()

    On Error Resume Next

    WindowState = 0

    Select Case mnuNotepadMode.Checked

        Case True ' Leaving notepad mode
            mnuNotepadMode.Checked = False
            tkMainForm.mainToolbar.Visible = True
            tkMainForm.leftBarContainer.Visible = True
            tkMainForm.newBarContainerContainer.Visible = True
            ' tkMainForm.Picture2.Visible = True
            tkMainForm.StatusBar1.Visible = True
            Form_Activate
            tkMainForm.popTray.Visible = True
            WindowState = 0
            tkMainForm.Caption = oldCaption
            Caption = meOldCaption

        Case False ' Entering notepad mode
            mnuNotepadMode.Checked = True
            tkMainForm.WindowState = 0
            tkMainForm.Width = Width
            tkMainForm.Height = Height
            tkMainForm.Top = Top
            tkMainForm.Left = Left
            tkMainForm.mainToolbar.Visible = False
            tkMainForm.popTray.Visible = False
            tkMainForm.leftBarContainer.Visible = False
            tkMainForm.newBarContainerContainer.Visible = False
            ' tkMainForm.Picture2.Visible = False
            tkMainForm.StatusBar1.Visible = False
            hideAllTools
            WindowState = 2
            Form_Resize
            oldCaption = tkMainForm.Caption
            tkMainForm.Caption = Caption
            meOldCaption = Caption
            Caption = "Notepad Mode"
            mnuBookmarkToolbar.Checked = True
            mnuBookmarkToolbar_Click

    End Select

End Sub

Private Sub mnuRedo_Click()
    doRedo
End Sub

Private Sub mnuUndo_Click()
    doUndo
End Sub

Private Sub RestartReColor_Timer()
 'Added by KSNiloc
 On Error Resume Next
 If programEditorCountDown = 0 Then CheckReColor.Enabled = True
 If codeForm.SelText = "" And Not codeForm.SelColor = _
  &H0& Then codeForm.SelColor = &H0&
End Sub

Private Sub CheckReColor_Timer()

 'KSNiloc says:
 'Even though this code is run every millisecond it won't cause any
 'slow downs or flicker because if it isn't supposed to be re-coloing
 'it will not even run.
 
 If Not needsReColor Then Exit Sub
 SplitLines
 programEditorCountDown = programEditorCountDown - 1
 CheckReColor.Enabled = False
 If programEditorCountDown = 0 Then needsReColor = False

End Sub

'Added by KSNiloc...
Private Sub codeform_MouseDown(Button As Integer, Shift As Integer, _
 x As Single, y As Single)
 
 'Record where we're moving from...
 MouseDownSelStart = codeForm.selStart
 MouseDownSelLength = codeForm.SelLength
 
 oldLine = codeForm.GetLineFromChar(codeForm.selStart)

End Sub

Private Sub codeform_KeyDown(keyCode As Integer, Shift As Integer): On Error Resume Next

    'Alterations made.
    rpgcodeList(activeRPGCodeIndex).prgNeedUpdate = True

    If Not mnuNotepadMode.Checked Then
        Dim inf As TextLineInfo
        inf = getTextLineInfo(codeForm.Text, codeForm.selStart)
        tkMainForm.StatusBar1.Panels(3).Text = CStr(codeForm.GetLineFromChar(codeForm.selStart) + 1)
        tkMainForm.StatusBar1.Panels(4).Text = str$(inf.insertPosition)
    End If

    ''''''''''''''''''''''''''
    '    Added by KSNiloc    '
    ''''''''''''''''''''''''''
    '[6/19/04]
    
    'This addition allows for real-time syntax coloring
    
    oldLine = codeForm.GetLineFromChar(codeForm.selStart)
    
    'Declare variables...
    Dim enterKey As String
    Dim a As Long
    Dim b As Long
    
    'Certain keys don't require us to do anything...
    If keyCode = 20 Or keyCode = 124 Or keyCode = 17 Or _
        keyCode = 16 Or keyCode = 36 Or keyCode = 36 Or keyCode = 37 Or _
        keyCode = 39 Or keyCode = 35 Then Exit Sub
    
    'We're leaving the line- color it!
    If keyCode = 38 Or keyCode = 40 Or keyCode = 13 Or keyCode = 18 Then
        If blackLine Then
            ReColorLine blackLine
            blackLine = False
        End If
        Exit Sub
    End If
    
    'The user is modifying the line- turn it black!
    If Not blackLine Then
        ReColorLine , True
        blackLine = True
    End If
    
    ''''''''''''''''''''''''''
    '      End Addition      '
    ''''''''''''''''''''''''''
End Sub

Private Sub codeform_MouseUp(Button As Integer, Shift As Integer, _
 x As Single, y As Single)

    '''''''''''''''''''''''''''''
    'Color the line we just left'
    '''''''''''''''''''''''''''''

    oldLine = codeForm.GetLineFromChar(codeForm.selStart)

    'Make sure we aren't wasting time coloring a line that's already colored
    If blackLine Then

        'Declarations...
        Dim nSS As Long
        Dim nSL As Long
 
        'Record where the mouse clicked down...
        nSS = codeForm.selStart
        nSL = codeForm.SelLength
 
        'Move back to the line we just left...
        codeForm.selStart = MouseDownSelStart
        codeForm.SelLength = MouseDownSelLength

        'Color the line we just left...
        ReColorLine
 
        'Flag that the line is no longer black...
        blackLine = False
 
        'Move back to where the mouse clicked down...
        codeForm.selStart = nSS
        codeForm.SelLength = nSL

    End If
    
    If Button = 2 Then

        'Popup the right-click menu...
        PopupMenu mnuEdit
        
    End If

End Sub

'============================================================================
'End "Real-Time Syntax Coloring" code
'============================================================================

'============================================================================
'RPGCode Bookmarks 1.0
'Designed and Programmed by Colin James Fitzpatrick (KSNiloc)
'============================================================================
'Depends on modSyntax
'============================================================================

Private Sub cboBookmarkType_Change()
 On Error Resume Next
 cboMethodBookmarks.Visible = False
 cboCommentBookmarks.Visible = False
 cboLabelBookmarks.Visible = False
 Select Case cboBookmarkType.list(cboBookmarkType.ListIndex)
  Case "(Methods)": Set secondCombo = cboMethodBookmarks
  Case "(Comments)": Set secondCombo = cboCommentBookmarks
  Case "(Labels)": Set secondCombo = cboLabelBookmarks
 End Select
 secondCombo.ListIndex = 1
 'If secondCombo.text = "" Then secondCombo.text = secondCombo.List(0)
 Form_Resize
End Sub

Public Sub addBookmark(ByVal bookmarkName As String, ByRef cbo As ComboBox)

 'Declarations...
 Dim a As Long

 With cbo
 
  'First make sure it's not a duplicate bookmark...
  For a = 0 To .ListCount - 1
   If Trim(LCase(bookmarkName)) = Trim(LCase(.list(a))) Then
   
    'Remove the item so it won't be in the list twice...
    .RemoveItem a
    
    'MsgBox "Duplicate bookmark name found-- " & bookmarkName & vbCrLf & _
    ' "It is suggested that you correct this to prevent future errors." _
    ' , vbCritical, "Duplicate bookmark!"
    'Exit Sub
   End If
  Next a
  
  'Add the bookmark to the list...
  .AddItem Trim(bookmarkName)
  
 End With
End Sub

Public Sub removeBookmark(ByVal bookmarkName As String, ByRef cbo As ComboBox)

 'Declarations...
 Dim a As Long
 
 With cbo
 
  'Find the bookmark in the combo box...
  For a = 0 To .ListCount - 1
   If Trim(LCase(bookmarkName)) = Trim(LCase(.list(a))) Then
    'We found it!
    .RemoveItem a
    Exit Sub
   End If
  Next a
 
 End With

End Sub

Private Sub gotoBookmark()
 GotoLine secondCombo.list(secondCombo.ListIndex)
End Sub

Private Sub checkBookmarkChange()
 On Error Resume Next
 If Not lastType = cboBookmarkType.list(cboBookmarkType.ListIndex) Then
  lastType = cboBookmarkType.list(cboBookmarkType.ListIndex)
  cboBookmarkType_Change
 End If
 If Not lastSecondCombo = secondCombo.list(secondCombo.ListIndex) Then
  lastSecondCombo = secondCombo.list(secondCombo.ListIndex)
  gotoBookmark
 End If
End Sub

Private Sub cboBookmarkType_Click()
 checkBookmarkChange
End Sub

Private Sub cboCommentBookmarks_Change()
 gotoBookmark
End Sub

Private Sub cboCommentBookmarks_Click()
 checkBookmarkChange
End Sub

Private Sub cboLabelBookmarks_Change()
 gotoBookmark
End Sub

Private Sub cboLabelBookmarks_Click()
 checkBookmarkChange
End Sub

Private Sub cboMethodBookmarks_Change()
 gotoBookmark
End Sub

Private Sub cboMethodBookmarks_Click()
 checkBookmarkChange
End Sub

'============================================================================
'End of "RPGCode Bookmarks" code
'============================================================================

' CLOSE MENU
Private Sub closemnu_Click()
On Error GoTo ErrorHandler

rpgcodeList(activeRPGCodeIndex).prgText$ = codeForm.Text
Unload Me

Exit Sub

'Begin error handling code:
ErrorHandler:
Call HandleError
Resume Next

End Sub

Private Sub codeform_Click()
On Error Resume Next

Dim inf As TextLineInfo
inf = getTextLineInfo(codeForm.Text, codeForm.selStart)
tkMainForm.StatusBar1.Panels(3).Text = CStr(codeForm.GetLineFromChar(codeForm.selStart) + 1)
tkMainForm.StatusBar1.Panels(4).Text = str$(inf.insertPosition)
End Sub

Public Sub prgRun()
On Error GoTo ErrorHandler

Call rprg_Click

Exit Sub

'Begin error handling code:
ErrorHandler:
Call HandleError
Resume Next
End Sub

Public Sub prgDebug()
On Error GoTo ErrorHandler
Call dbmnu_Click
Exit Sub

'Begin error handling code:
ErrorHandler:
Call HandleError
Resume Next
End Sub

Public Sub prgEventEdit()
On Error Resume Next

' Edit as Event

numLines = countTextLines(codeForm.Text)
ReDim evtList$(numLines + 500)
Dim i As Integer
For i = 0 To numLines - 1
    evtList(i) = getTextLineNumber(codeForm.Text, i)
Next i
EventEdit.Show

End Sub

' QUICK REFERENCE MENU
Private Sub crefmnu_Click()
On Error GoTo ErrorHandler

' Show Command Reference Form
commandRef.Show vbModal

Exit Sub

'Begin error handling code:
ErrorHandler:
Call HandleError
Resume Next

End Sub

' DEBUG MENU
Private Sub dbmnu_Click()
On Error GoTo ErrorHandler

tprg$ = ""
If rpgcodeList(activeRPGCodeIndex).Ifont$ <> "" Then
    tprg$ = tprg$ + "#font(" + rpgcodeList(activeRPGCodeIndex).Ifont$ + ")" + chr$(13) + chr$(10)
End If
If rpgcodeList(activeRPGCodeIndex).IfontSize < 8 Then rpgcodeList(activeRPGCodeIndex).IfontSize = 8
    tprg$ = tprg$ + "#fontsize(" + str$(rpgcodeList(activeRPGCodeIndex).IfontSize) + ")" + chr$(13) + chr$(10)
If rpgcodeList(activeRPGCodeIndex).Imwin$ <> "" Then
    tprg$ = tprg$ + "#Wingraphic(" + rpgcodeList(activeRPGCodeIndex).Imwin$ + ")" + chr$(13) + chr$(10)
End If
For t = 0 To 4
    If rpgcodeList(activeRPGCodeIndex).Ichar$(t) <> "" Then
        tprg$ = tprg$ + "#addplayer(" + rpgcodeList(activeRPGCodeIndex).Ichar$(t) + ")" + chr$(13) + chr$(10)
    End If
Next t
If rpgcodeList(activeRPGCodeIndex).Iboard$ <> "" Then
    tprg$ = tprg$ + "#send(" + rpgcodeList(activeRPGCodeIndex).Iboard$ + ",9,5)" + chr$(13) + chr$(10)
End If
tprg$ = tprg$ + "#BREAK()" + chr$(13) + chr$(10)

tprg$ = tprg$ + codeForm.Text
    
' Save Test Program
Call saveprogramtst(projectPath$ + prgPath$ + "sys_test.prg", tprg$)

' Run Trans3
a = Shell("trans3 " + mainFile$ + " sys_test.prg")

Exit Sub

'Begin error handling code:
ErrorHandler:
Call HandleError
Resume Next

End Sub

Sub saveprogramtst(tprg$, file$)
    'Save program
    On Error Resume Next
    num = FreeFile
    Open file$ For Output As #num
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
        Print #num, tprg$
    Close #num
End Sub

' FORM ACTIVATE
Private Sub Form_Activate(): On Error Resume Next

     Set activeRPGCode = Me
     Set activeForm = Me

     activeRPGCodeIndex = dataIndex

     Call hideAllTools
     tkMainForm.rpgcodeTools.Visible = True
     tkMainForm.rpgcodeTools.Top = tkMainForm.toolTop

     ' [KSNiloc] 3.0.4
     GetLineColors
     programEditorCount = programEditorCount + 1

End Sub

' FORM LOAD
Private Sub Form_Load()
On Error GoTo ErrorHandler

' Localization
Call LocalizeForm(Me)

' The Currently Active Form is this selected one (this is probably redundtant soon)
Set activeRPGCode = Me

' Not Entirely Sure What Chris did here
dataIndex = VectRPGCodeNewSlot()
activeRPGCodeIndex = dataIndex
    
codeForm.Width = Me.Width * 0.9 - 255
codeForm.Height = Me.Height * 0.9 - 335
codeForm.Left = (Me.Width * 0.1) / 2
codeForm.Top = Command1.Top + Command1.Height + 335

WindowState = 0

If tag <> "1" Then
    mnuNotepadMode.Checked = False
Else
    mnuNotepadMode_Click
End If

' KSNiloc...
Form_Resize

' ADDED BY KSNiloc...
ReDim undoBuffer(0 To 0)

codeForm.Text = GetSetting("RPGToolkit3", "PRG Editor", "Common", "")
If codeForm.Text <> "" Then codeForm.Text = codeForm.Text & vbCrLf
codeForm.selStart = Len(codeForm.Text)

formLoaded = True

Exit Sub

'Begin error handling code:
ErrorHandler:
Call HandleError
Resume Next

End Sub

' RESIZING CODE
Private Sub Form_Resize()
On Error GoTo ErrorHandler

' ! KSNiloc...
' If mnuNotepadMode.Checked And formLoaded Then
    If WindowState <> 2 Then WindowState = 2
' End If

'Numbers changed to work with bookmarks...
Dim cfTop As Long
If mnuBookmarkToolbar.Checked Then cfTop = 335
codeForm.Move 0, cfTop, Me.ScaleWidth, Me.ScaleHeight - cfTop
cboBookmarkType.Width = (Me.Width - 60) / 2
secondCombo.Left = cboBookmarkType.Width
secondCombo.Width = cboBookmarkType.Width - 60
secondCombo.Visible = True

Exit Sub

'Begin error handling code:
ErrorHandler:
Call HandleError
Resume Next

End Sub

' FORM UNLOAD CODE
Private Sub Form_Unload(Cancel As Integer): On Error Resume Next

    'See if the program needs saving.
    If rpgcodeList(activeRPGCodeIndex).prgNeedUpdate Then
        
        'Yup, ask if the user wants to.
        Dim answer As VbMsgBoxResult
        answer = MsgBox("Save changes to " & insideBrackets(Me.Caption) & "?", vbYesNoCancel + vbQuestion)
        
        If answer = vbCancel Then
        
            'Cancel unload.
            Cancel = 1
            Exit Sub
            
        ElseIf answer = vbYes Then
        
            'Save the file, prompt if need.
            Call saveFile
            
        End If
    
    End If

    programEditorCount = programEditorCount - 1
    rpgcodeList(activeRPGCodeIndex).prgText = codeForm.Text
    Call hideAllTools
    
    ' KSNiloc...
    If mnuNotepadMode.Checked Then
        mnuNotepadMode_Click
    End If
    
    If tag = "1" Then mnuexit_Click

    Call tkMainForm.refreshTabs

End Sub

Private Sub mnuColorCoding_Click()
 'Added by KSNiloc...
 frmColoringOptions.Show 1
End Sub

' COPY MENU
Private Sub mnuCopy_Click()
On Error Resume Next

Clipboard.SetText codeForm.SelText
End Sub

' CUT MENU
Private Sub mnuCut_Click()
On Error Resume Next

' Copy Selected Text Into Clipboard
Clipboard.SetText codeForm.SelText

' Remove Selected Text From Text Box
codeForm.SelText = vbNullString
End Sub

' PASTE MENU
Private Sub mnuPaste_Click()
On Error Resume Next

' MODIFIED BY KSNiloc...

If Clipboard.GetFormat(vbCFText) = True Then
    ' Place the contents of the clipboard into current location in text box
    codeForm.SelText = Clipboard.GetText
    colorPastedCode
End If

End Sub

Private Sub rpgin_Click()
    On Error GoTo ErrorHandler
    Call BrowseFile(helpPath$ + ObtainCaptionFromTag(DB_Help2, resourcePath$ + m_LangFile))

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub rpgr_Click()
    On Error GoTo ErrorHandler
    Call BrowseFile(helpPath$ + ObtainCaptionFromTag(DB_Help3, resourcePath$ + m_LangFile))

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub mnuSelectAll_Click()
codeForm.selStart = 0
codeForm.SelLength = Len(codeForm.Text)
End Sub

' RUN CODE MENU
Private Sub rprg_Click()
'==========================
'EDITED: [Delano - 8/05/04]
'FIXED: trans3 crashes when this button is pressed (sometimes)!
'CAUSE: the Shell call windowstyle was set to default, which caused trans3 to be minimized,
'       which caused trans3 to crash.
'==========================

'Called when Run Program is selected from the menu, F5 is pressed or the green arrow is clicked.
'Creates the program "sys_test.prg" with the test preferences converted to rpg commands,
'and passes this to trans3.exe as an arguement.

    On Error Resume Next
    
    Dim TestPRG As String ' We no longer need to assign this to = "", as it goes out of scope on sub end
    
    If rpgcodeList(activeRPGCodeIndex).Ifont$ <> "" Then
        TestPRG = TestPRG + "Font(" + rpgcodeList(activeRPGCodeIndex).Ifont$ + ")" + chr$(13) + chr$(10)
    End If
    'If rpgcodeList(activeRPGCodeIndex).IfontSize < 8 Then rpgcodeList(activeRPGCodeIndex).IfontSize = 8
    '    TestPRG = TestPRG + "#fontsize(" + str$(rpgcodeList(activeRPGCodeIndex).IfontSize) + ")" + chr$(13) + chr$(10)
    If rpgcodeList(activeRPGCodeIndex).Imwin$ <> "" Then
        TestPRG = TestPRG + "WinGraphic(" + rpgcodeList(activeRPGCodeIndex).Imwin$ + ")" + chr$(13) + chr$(10)
    End If
    For t = 0 To 4
        If rpgcodeList(activeRPGCodeIndex).Ichar$(t) <> "" Then
            TestPRG = TestPRG + "AddPlayer(" + rpgcodeList(activeRPGCodeIndex).Ichar$(t) + ")" + chr$(13) + chr$(10)
        End If
    Next t
    If rpgcodeList(activeRPGCodeIndex).Iboard$ <> "" Then
        TestPRG = TestPRG + "Send(" + rpgcodeList(activeRPGCodeIndex).Iboard$ + ",9,5)" + chr$(13) + chr$(10)
    End If
    
    ' Complete TestPRG String
    TestPRG = TestPRG & codeForm.Text

    ' ! MODIFIED BY KSNiloc...
    Dim num As Long
    num = FreeFile()
    Open projectPath & prgPath & "sys_test.prg" For Output As num
        Print #num, TestPRG
    Close num
    
    ' Exexcute Trans3 with the program
    
    'Run trans3 through the Shell. Fix: Added second argument, to give trans3 the focus.
    Call Shell("trans3 " & loadedMainFile & " sys_test.prg", vbNormalFocus)

End Sub

' SAVE AS MENU
Private Sub sasmnu_Click(): On Error Resume Next

    ChDir (currentDir)

    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath & prgPath
    dlg.strTitle = "Save Program As"
    dlg.strDefaultExt = "prg"
    dlg.strFileTypes = "RPG Toolkit Program (*.prg)|*.prg|All files(*.*)|*.*"
    
    'Set optional parameter to prompt for overwrite.
    If Not (SaveFileDialog(dlg, Me.hwnd, True)) Then Exit Sub
    
    ChDir (currentDir)
    
    'Exit if filename empty.
    If dlg.strSelectedFile = "" Then Exit Sub
    
    Call saveProgram(dlg.strSelectedFile)
    
    rpgcodeList(activeRPGCodeIndex).prgName = dlg.strSelectedFileNoPath
    
    activeRPGCode.Caption = LoadStringLoc(803, "Program Editor") & " (" & dlg.strSelectedFileNoPath & ")"
    
    'Redraw the file tree, adding new file if created.
    Call tkMainForm.fillTree("", projectPath)
    
    'File is now unaltered.
    rpgcodeList(activeRPGCodeIndex).prgNeedUpdate = False

End Sub

' SAVE PROGRAM MENU
Private Sub SavePrgMnu_Click(): On Error Resume Next

    filename(2) = rpgcodeList(activeRPGCodeIndex).prgName$
    If filename(2) = "" Then sasmnu_Click: Exit Sub
    
    If tag = "1" Then
        Call saveProgram(filename(2))
    Else
        Call saveProgram(projectPath & prgPath & filename(2))
    End If
    
    'File is now unaltered.
    rpgcodeList(activeRPGCodeIndex).prgNeedUpdate = False

End Sub

Private Sub splitLinesTimer_Timer()
    splitLinesTimer.Enabled = False
    If codeForm.tag <> "1" Then
        SplitLines
        codeForm.SetFocus
        codeForm.selStart = Len(codeForm.Text)
        blackLine = False
    End If
End Sub

' VISUAL EDITOR MENU
Private Sub tkvismnu_Click()
On Error GoTo ErrorHandler
tkvisual.Show
Exit Sub

'Begin error handling code:
ErrorHandler:
Call HandleError
Resume Next

End Sub

' TEST PREFERENCES MENU
Private Sub tpref_Click()
On Error GoTo ErrorHandler

testprefs.Show vbModal

Exit Sub

'Begin error handling code:
ErrorHandler:
Call HandleError
Resume Next

End Sub

Private Sub mnutilehorizontally_Click()
On Error Resume Next

Call tkMainForm.tilehorizonatllymnu_Click

End Sub

Private Sub mnutilevertically_Click()
On Error Resume Next
Call tkMainForm.tileverticallymnu_Click
End Sub

' TUTORIAL MENU
Private Sub mnuTutorial_Click()
    On Error Resume Next
    Call tkMainForm.tutorialmnu_Click
End Sub

' USER GUIDE MENU
Private Sub mnuusersguide_Click()
    On Error Resume Next
    Call tkMainForm.usersguidemnu_Click
End Sub

' ABOUT MENU
Private Sub mnuAbout_Click()
    On Error Resume Next
    Call tkMainForm.aboutmnu_Click
End Sub

' ARRANGE ICONS MENU
Private Sub mnuArrangeIcons_Click()
    On Error Resume Next
    Call tkMainForm.arrangeiconsmnu_Click
End Sub

' CASCADE MENU
Private Sub mnuCascade_Click()
    On Error Resume Next
    Call tkMainForm.cascademnu_Click
End Sub

' CREATE PAK FILE MENU
Private Sub mnucreatepakfile_Click()
    On Error Resume Next
    Call tkMainForm.createpakfilemnu_Click
End Sub

' CREATE SETUP MENU
Private Sub mnucreatesetup_Click()
    On Error Resume Next
    Call tkMainForm.createsetupmnu_Click
End Sub

' EXIT MENU
Private Sub mnuexit_Click()
    On Error Resume Next
    Call tkMainForm.exitmnu_Click
End Sub

' HISTORY MENU
Private Sub mnuHistorytxt_Click()
On Error Resume Next
Call tkMainForm.historytxtmnu_Click
End Sub

' MAKE EXE MENU
Private Sub mnumakeexe_Click()
    On Error Resume Next
    Call tkMainForm.makeexemnu_Click
End Sub

' NEW ANIMTATED TILE MENU
Private Sub mnunewanimatedtile_Click()
    On Error Resume Next
    Call tkMainForm.newanimtilemnu_Click
End Sub

' NEW ANIMATION MENU
Private Sub mnunewanimation_Click()
    On Error Resume Next
    Call tkMainForm.newanimationmnu_Click
End Sub

' NEW BOARD MENMU
Private Sub mnunewboard_Click()
    On Error Resume Next
    Call tkMainForm.newboardmnu_Click
End Sub

' NEW ENEMY MENU
Private Sub mnunewenemy_Click()
    On Error Resume Next
    Call tkMainForm.newenemymnu_Click
End Sub

' NEW ITEM MENU
Private Sub mnunewitem_Click()
    On Error Resume Next
    Call tkMainForm.newitemmnu_Click
End Sub

' NEW PLAYER MENU
Private Sub mnunewplayer_Click()
    On Error Resume Next
    Call tkMainForm.newplayermnu_Click
End Sub

' NEW PROJECT MENU
Private Sub mnunewproject_Click()
    On Error Resume Next
    Call tkMainForm.newprojectmnu_Click
End Sub

' NEW RPG CODE PROGRAM MENU
Private Sub mnunewrpgcodeprogram_Click()
    On Error Resume Next
    Call tkMainForm.newrpgcodemnu_Click
End Sub

' NEW SPECIAL MOVE MENU
Private Sub mnunewspecialmove_Click()
    On Error Resume Next
    Call tkMainForm.newspecialmovemnu_Click
End Sub

' NEW STATUS EFFECT MENU
Private Sub mnunewstatuseffect_Click()
    On Error Resume Next
    Call tkMainForm.newstatuseffectmnu_Click
End Sub

' NEW TILE MENU
Private Sub mnunewtile_Click()
    On Error Resume Next
    Call tkMainForm.newtilemnu_Click
End Sub

' NEW TILE BITMAP MENU
Private Sub mnunewtilebitmap_Click()
    On Error Resume Next
    Call tkMainForm.newtilebitmapmnu_Click
End Sub

' OPEN FILE MENU
Private Sub mnuopen_Click()
On Error Resume Next

If tag = "1" Then
    ChDir (currentDir)
    Dim antiPath As String
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath
    dlg.strTitle = "Open"
    dlg.strFileTypes = "RPGCode Programs (*.prg)|*.prg"
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename(1) = dlg.strSelectedFile
        antiPath = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentDir)
    If filename(1) = "" Then Exit Sub
    Shell App.path & "\" & App.EXEName & ".exe " & filename(1), vbNormalFocus
Else
    Call tkMainForm.openmnu_Click
End If

End Sub

' RPG CODE PRIMER MENU
Private Sub mnuRPGCodePrimer_Click()
    On Error Resume Next
    Call tkMainForm.rpgcodeprimermnu_Click
End Sub

' RPG CODE REFERNECE MENU
Private Sub mnurpgcodereference_Click()
    On Error Resume Next
    Call tkMainForm.rpgcodereferencemnu_Click
End Sub

' SAVE ALL MENU
Private Sub mnusaveall_Click()
    On Error Resume Next
    Call tkMainForm.saveallmnu_Click
End Sub

' SELECT LANGUAGE MENU
Private Sub mnuselectlanguage_Click()
    On Error Resume Next
    Call tkMainForm.selectlanguagemnu_Click
End Sub

' SHOW / HIDE PROJECT LIST MENU
Private Sub mnushowprojectlist_Click()
    On Error Resume Next
    Call tkMainForm.showprojectlistmnu_Click
End Sub

' SHOW / HIDE TOOLS MENU
Private Sub mnushowtools_Click()
    On Error Resume Next
    Call tkMainForm.showtoolsmnu_Click
End Sub

' TEST GAME MENU
Private Sub mnutestgame_Click()
    On Error Resume Next
    tkMainForm.testgamemnu_Click
End Sub

' OPEN PROJECT MENU
Private Sub mnuOpenProject_Click()
    On Error Resume Next
    Call tkMainForm.mnuOpenProject_Click
End Sub

' NEW FIGHT BACKGROUND MENU
Private Sub mnuNewFightBackground_Click()
    On Error Resume Next
    Call tkMainForm.mnuNewFightBackground_Click
End Sub

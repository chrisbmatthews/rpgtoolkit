VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "richtx32.ocx"
Begin VB.Form rpgcodeedit 
   Caption         =   "RPGCode Program Editor (Untitled)"
   ClientHeight    =   5280
   ClientLeft      =   660
   ClientTop       =   1035
   ClientWidth     =   8010
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
   Begin RichTextLib.RichTextBox CodeForm 
      Height          =   2655
      Left            =   120
      TabIndex        =   0
      Top             =   1080
      Width           =   7695
      _ExtentX        =   13573
      _ExtentY        =   4683
      _Version        =   393217
      BorderStyle     =   0
      Enabled         =   -1  'True
      HideSelection   =   0   'False
      ScrollBars      =   3
      DisableNoScroll =   -1  'True
      RightMargin     =   5.00000e5
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
   Begin VB.Menu mnuPopPrg 
      Caption         =   "Right-click on program"
      Visible         =   0   'False
      Begin VB.Menu mnuPopPrg_Cut 
         Caption         =   "Cut"
      End
      Begin VB.Menu mnuPopPrg_Copy 
         Caption         =   "Copy"
      End
      Begin VB.Menu mnuPopPrg_Paste 
         Caption         =   "Paste"
      End
      Begin VB.Menu separator 
         Caption         =   "-"
      End
      Begin VB.Menu mnuPopPrg_SelectAll 
         Caption         =   "Select All"
      End
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
         Shortcut        =   ^X
      End
      Begin VB.Menu mnuCopy 
         Caption         =   "&Copy"
         Shortcut        =   ^C
      End
      Begin VB.Menu mnuPaste 
         Caption         =   "&Paste"
         Shortcut        =   ^V
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
         Shortcut        =   ^A
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
         Caption         =   "Indent Wizard..."
         Shortcut        =   ^I
      End
      Begin VB.Menu mnuAutoCommandWizard 
         Caption         =   "AutoCommand Wizard..."
         Visible         =   0   'False
      End
      Begin VB.Menu mnuUpdateRpgCode 
         Caption         =   "Update RPGCode..."
      End
      Begin VB.Menu mnuColorCoding 
         Caption         =   "Options..."
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
         Caption         =   "Test Preferences..."
         Tag             =   "1626"
      End
   End
   Begin VB.Menu gcodemnu 
      Caption         =   "Generate Code"
      Tag             =   "1627"
      Visible         =   0   'False
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
      Begin VB.Menu sub7 
         Caption         =   "-"
      End
      Begin VB.Menu mnuTutorial 
         Caption         =   "Tutorial"
         Visible         =   0   'False
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
'========================================================================
' The RPG Toolkit, Version 3
' This file copyright (C) 2007 Christopher Matthews & contributors
'
' Contributors:
'    - Colin James Fitzpatrick
'    - Jonathan D. Hughes
'    - Phil Carty
'========================================================================
'
' This program is free software; you can redistribute it and/or
' modify it under the terms of the GNU General Public License
' as published by the Free Software Foundation; either version 2
' of the License, or (at your option) any later version.
'
' This program is distributed in the hope that it will be useful,
' but WITHOUT ANY WARRANTY; without even the implied warranty of
' MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
' GNU General Public License for more details.
'
'========================================================================

Option Explicit

'==========================================================================
' Declares
'==========================================================================
Private Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, lParam As Any) As Long

'==========================================================================
' Globals
'==========================================================================
Public dataIndex As Long            ' Index of this editor
Public blackLine As Boolean         ' Editing a line?

'==========================================================================
' Members
'==========================================================================
Private secondCombo As ComboBox     ' Second bookmark combo box
Private mouseDownSelStart As Long   ' Current position at mouse down
Private mouseDownSelLength As Long  ' Length of selection at mouse down
Private oldLine As Long             ' Old line

'==========================================================================
' Constants
'==========================================================================
Private Const WM_CUT = &H300
Private Const WM_COPY = &H301
Private Const WM_PASTE = &H302
Private Const WM_CLEAR = &H303
Private Const WM_UNDO = &H304

'==========================================================================
' Obtain type of form
'==========================================================================
Public Property Get formType() As Long
    formType = FT_RPGCODE
End Property

'==========================================================================
' Open a program
'==========================================================================
Public Sub openProgram(ByVal filename As String)

    On Error GoTo ErrorHandler

    ' Load the Program into text box.
    Call codeForm.LoadFile(filename, rtfText)

    ' Call Syntax Color Routines
    Call SplitLines
    Exit Sub

ErrorHandler:
    MsgBox "Cannot open specified filename", vbInformation + vbOKOnly, "RPG Toolkit"

End Sub

'==========================================================================
' Open a file (called from tkMainForm)
'==========================================================================
Public Sub openFile(ByVal file As String): On Error Resume Next

    Call activeRPGCode.Show
    Call openProgram(file)
    
    'Preserve the path if file is in a sub-folder.
    Call getValidPath(file, projectPath & prgPath, rpgcodeList(activeRPGCodeIndex).prgName, False)
    
    Me.Caption = rpgcodeList(activeRPGCodeIndex).prgName
    rpgcodeList(activeRPGCodeIndex).prgNeedUpdate = False

End Sub

'==========================================================================
' Save the file (called from tkMainForm)
'==========================================================================
Public Sub saveFile(): On Error Resume Next
    Call Show
    Call Form_Activate
    Call SavePrgMnu_Click
End Sub

'==========================================================================
' Show the event editor
'==========================================================================
Private Sub cconmnu_Click()
    Call EventEdit.Show(vbModal)
End Sub

'==========================================================================
' Show/hide the bookmark toolbar
'==========================================================================
Private Sub mnuBookmarkToolbar_Click()
  
    On Error Resume Next

    Select Case mnuBookmarkToolbar.Checked
    
        Case True
            mnuBookmarkToolbar.Checked = False
            bookmarkToolbar.visible = False
        
        Case False
            mnuBookmarkToolbar.Checked = True
            bookmarkToolbar.visible = True
    
    End Select
    
    Call Form_Resize

End Sub

'==========================================================================
' Show the indentation wizard
'==========================================================================
Private Sub mnuIndentWizard_Click()
    Call frmIndentWizard.Show(vbModal)
End Sub

'==========================================================================
' Obtain focus
'==========================================================================
Private Sub CodeForm_GotFocus()
    If Not (mnuNotepadMode.Checked) Then blackLine = True
End Sub

'==========================================================================
' Edit Menu
'==========================================================================
Private Sub mnuCut_Click(): On Error Resume Next
    rpgcodeList(activeRPGCodeIndex).prgNeedUpdate = True
    'Call Clipboard.SetText(codeForm.SelText, vbCFText)
    'codeForm.SelText = vbNullString
    Call SendMessage(codeForm.hwnd, WM_CUT, 0, 0&)
    Call Clipboard.SetText(Clipboard.GetText(vbCFText), vbCFText)
End Sub

Private Sub mnuCopy_Click(): On Error Resume Next
    'Call Clipboard.SetText(codeForm.SelText, vbCFText)
    Call SendMessage(codeForm.hwnd, WM_COPY, 0, 0&)
    Call Clipboard.SetText(Clipboard.GetText(vbCFText), vbCFText)
End Sub

Private Sub mnuPaste_Click(): On Error Resume Next
    rpgcodeList(activeRPGCodeIndex).prgNeedUpdate = True
    Call Clipboard.SetText(Clipboard.GetText(vbCFText), vbCFText)
    Call SendMessage(codeForm.hwnd, WM_PASTE, 0, 0&)
    Call colorPastedCode                'This is crap!
End Sub

Private Sub mnuSelectAll_Click(): On Error Resume Next
    codeForm.selStart = 0
    codeForm.SelLength = Len(codeForm.Text)
End Sub

'==========================================================================
' Right-click edit menu
'==========================================================================
Private Sub mnuPopPrg_Copy_Click(): On Error Resume Next
    Call mnuCopy_Click
End Sub

Private Sub mnuPopPrg_Cut_Click(): On Error Resume Next
    Call mnuCut_Click
End Sub

Private Sub mnuPopPrg_Paste_Click(): On Error Resume Next
    Call mnuPaste_Click
End Sub

Private Sub mnuPopPrg_SelectAll_Click(): On Error Resume Next
    Call mnuSelectAll_Click
End Sub

'==========================================================================
' Key pressed in the code field
'==========================================================================
Private Sub CodeForm_KeyPress(KeyAscii As Integer): On Error Resume Next

    ' Alterations made
    'rpgcodeList(activeRPGCodeIndex).prgNeedUpdate = True

    Select Case KeyAscii

        Case 3  ' Ctrl+C
            Call Clipboard.SetText(codeForm.SelText, vbCFText)

    End Select

End Sub

'==========================================================================
' Colour code pasted into the field
'==========================================================================
Private Sub colorPastedCode()

    Dim oldSS As Long
    Dim oldSL As Long
    oldSS = codeForm.selStart()
    oldSL = codeForm.SelLength()
    Call SplitLines(oldLine, codeForm.GetLineFromChar(oldSS))
    codeForm.selStart = oldSS
    codeForm.SelLength = oldSL
    blackLine = True
    Call codeForm.SetFocus
    blackLine = False

End Sub

'==========================================================================
' File -> New for notepad mode
'==========================================================================
Private Sub mnuNewPRG_Click()
    On Error Resume Next
    Call Shell(App.path & "\" & App.EXEName & ".exe .prg", vbNormalFocus)
End Sub

'==========================================================================
' Enter or exit notepad mode
'==========================================================================
Public Sub mnuNotepadMode_Click()

    On Error Resume Next

    Static oldCaption As String, meOldCaption As String

    WindowState = 0

    Select Case mnuNotepadMode.Checked

        Case True ' Leaving notepad mode
            mnuNotepadMode.Checked = False
            tkMainForm.mainToolbar.visible = True
            tkMainForm.leftBarContainer.visible = True
            tkMainForm.newBarContainerContainer.visible = True
            Call tkMainForm.ShowTabs
            tkMainForm.StatusBar1.visible = True
            Form_Activate
            tkMainForm.popTray.visible = True
            WindowState = 0
            tkMainForm.Caption = oldCaption
            Caption = meOldCaption

        Case False ' Entering notepad mode
            mnuNotepadMode.Checked = True
            tkMainForm.WindowState = 0
            tkMainForm.width = width
            tkMainForm.Height = Height
            tkMainForm.Top = Top
            tkMainForm.Left = Left
            tkMainForm.mainToolbar.visible = False
            tkMainForm.popTray.visible = False
            tkMainForm.leftBarContainer.visible = False
            tkMainForm.newBarContainerContainer.visible = False
            Call tkMainForm.hideTabs
            tkMainForm.StatusBar1.visible = False
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

    If (tkMainForm.Left < 0) Then tkMainForm.Left = 0
    If (tkMainForm.Top < 0) Then tkMainForm.Top = 0

End Sub

'==========================================================================
' Mouse down the field
'==========================================================================
Private Sub codeform_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
    
    If Button = vbRightButton Then
        
        mnuPopPrg_Copy.Enabled = False
        mnuPopPrg_Paste.Enabled = False
        mnuPopPrg_Cut.Enabled = False
        
        'Determine which options to enable.
        If LenB(Clipboard.GetText(vbCFText)) Then mnuPopPrg_Paste.Enabled = True
        If codeForm.SelLength Then mnuPopPrg_Copy.Enabled = True: mnuPopPrg_Cut.Enabled = True
    
        PopupMenu mnuPopPrg
        
    Else
        'Highlight code.
        mouseDownSelStart = codeForm.selStart
        mouseDownSelLength = codeForm.SelLength
        oldLine = codeForm.GetLineFromChar(codeForm.selStart)
    End If
    
End Sub

'==========================================================================
' Key down on the field
'==========================================================================
Private Sub codeform_KeyDown(keyCode As Integer, Shift As Integer): On Error Resume Next
    
    If ((Shift = 2) And (keyCode = 86)) Then

        ' Paste
        Call mnuPaste_Click
        'CodeForm.SelText = Clipboard.GetText(vbCFText)
        'Call colorPastedCode
        keyCode = 0: Shift = 0
        Exit Sub

    End If

    ' Alterations made.
    rpgcodeList(activeRPGCodeIndex).prgNeedUpdate = True

    If Not (mnuNotepadMode.Checked) Then
        Dim inf As TextLineInfo
        inf = getTextLineInfo(codeForm.Text, codeForm.selStart)
        tkMainForm.StatusBar1.Panels(3).Text = CStr(codeForm.GetLineFromChar(codeForm.selStart) + 1)
        tkMainForm.StatusBar1.Panels(4).Text = str$(inf.insertPosition)
    End If

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
        If (blackLine) Then
            Call reColorLine(blackLine)
            blackLine = False
            If (codeForm.selStart = Len(codeForm.Text)) Then
                codeForm.SelItalic = 0
            End If
        End If
        Exit Sub
    End If

    'The user is modifying the line- turn it black!
    If Not (blackLine) Then
        Call reColorLine(True, True)
        blackLine = True
    End If
    
End Sub

'==========================================================================
' Mouse up on the field
'==========================================================================
Private Sub codeform_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)

    oldLine = codeForm.GetLineFromChar(codeForm.selStart)

    ' Make sure we aren't wasting time coloring a line that's already colored
    If (blackLine) Then

        ' Declarations
        Dim nSS As Long
        Dim nSL As Long
 
        ' Record where the mouse clicked down
        nSS = codeForm.selStart
        nSL = codeForm.SelLength
 
        ' Move back to the line we just left
        codeForm.selStart = mouseDownSelStart
        codeForm.SelLength = mouseDownSelLength

        ' Color the line we just left
        reColorLine
 
        ' Flag that the line is no longer black
        blackLine = False
 
        ' Move back to where the mouse clicked down
        codeForm.selStart = nSS
        codeForm.SelLength = nSL

    End If

    If (codeForm.selStart = Len(codeForm.Text)) Then
        codeForm.SelItalic = 0
    End If

End Sub

'==========================================================================
' Change type of bookmarks shown
'==========================================================================
Private Sub cboBookmarkType_Change()
    On Error Resume Next
    cboMethodBookmarks.visible = False
    cboCommentBookmarks.visible = False
    cboLabelBookmarks.visible = False
    Select Case cboBookmarkType.List(cboBookmarkType.ListIndex)
        Case "(Methods)": Set secondCombo = cboMethodBookmarks
        Case "(Comments)": Set secondCombo = cboCommentBookmarks
        Case "(Labels)": Set secondCombo = cboLabelBookmarks
    End Select
    secondCombo.ListIndex = 1
    Call Form_Resize
End Sub

'==========================================================================
' Add a bookmark
'==========================================================================
Public Sub addBookmark(ByVal bookmarkName As String, ByRef cbo As ComboBox)

    Dim i As Long

    For i = 0 To cbo.ListCount - 1
        If (Trim$(LCase$(bookmarkName)) = Trim$(LCase$(cbo.List(i)))) Then
            Call cbo.RemoveItem(i)
        End If
    Next i

    Call cbo.AddItem(Trim$(bookmarkName))

End Sub

'==========================================================================
' Remove a bookmark
'==========================================================================
Public Sub removeBookmark(ByVal bookmarkName As String, ByRef cbo As ComboBox)

    Dim i As Long

    For i = 0 To cbo.ListCount - 1
        If (Trim$(LCase$(bookmarkName)) = Trim$(LCase$(cbo.List(i)))) Then
            Call cbo.RemoveItem(i)
            Exit Sub
        End If
    Next i

End Sub

'==========================================================================
' Goto a boomark line
'==========================================================================
Private Sub gotoBookmark()
    Call GotoLine(secondCombo.List(secondCombo.ListIndex))
End Sub

'==========================================================================
' Determine whether a bookmark change is in order
'==========================================================================
Private Sub checkBookmarkChange()
    On Error Resume Next
    Static lastType As String, lastSecondCombo As String
    If (lastType <> cboBookmarkType.List(cboBookmarkType.ListIndex)) Then
        lastType = cboBookmarkType.List(cboBookmarkType.ListIndex)
        Call cboBookmarkType_Change
    End If
    If (lastSecondCombo <> secondCombo.List(secondCombo.ListIndex)) Then
        lastSecondCombo = secondCombo.List(secondCombo.ListIndex)
        Call gotoBookmark
    End If
End Sub

'==========================================================================
' Bookmark change events
'==========================================================================
Private Sub cboBookmarkType_Click()
    Call checkBookmarkChange
End Sub
Private Sub cboCommentBookmarks_Change()
    Call gotoBookmark
End Sub
Private Sub cboCommentBookmarks_Click()
    Call checkBookmarkChange
End Sub
Private Sub cboLabelBookmarks_Change()
    Call gotoBookmark
End Sub
Private Sub cboLabelBookmarks_Click()
    Call checkBookmarkChange
End Sub
Private Sub cboMethodBookmarks_Change()
    Call gotoBookmark
End Sub
Private Sub cboMethodBookmarks_Click()
    Call checkBookmarkChange
End Sub

'==========================================================================
' File -> Close
'==========================================================================
Private Sub closemnu_Click()
    rpgcodeList(activeRPGCodeIndex).prgText = codeForm.Text
    Call Unload(Me)
End Sub

'==========================================================================
' Click on the field
'==========================================================================
Private Sub codeform_Click()
    On Error Resume Next
    Dim inf As TextLineInfo
    inf = getTextLineInfo(codeForm.Text, codeForm.selStart)
    tkMainForm.StatusBar1.Panels(3).Text = CStr(codeForm.GetLineFromChar(codeForm.selStart) + 1)
    tkMainForm.StatusBar1.Panels(4).Text = str$(inf.insertPosition)
End Sub

'==========================================================================
' Run the program in question
'==========================================================================
Public Sub prgRun()
    Call rprg_Click
End Sub

'==========================================================================
' Open the event editor
'==========================================================================
Public Sub prgEventEdit()
    On Error Resume Next
    Dim numLines As Long
    numLines = countTextLines(codeForm.Text)
    ReDim evtList(numLines + 500) As String
    Dim i As Long
    For i = 0 To numLines - 1
        evtList(i) = getTextLineNumber(codeForm.Text, i)
    Next i
    Call EventEdit.Show
End Sub

'==========================================================================
' Show the quick reference
'==========================================================================
Private Sub crefmnu_Click()
    Call commandRef.Show(vbModal)
End Sub

'==========================================================================
' Form activation
'==========================================================================
Private Sub Form_Activate(): On Error Resume Next

     Set activeRPGCode = Me
     Set activeForm = Me

     activeRPGCodeIndex = dataIndex

     Call hideAllTools
     tkMainForm.rpgcodeTools.visible = True
     tkMainForm.rpgcodeTools.Top = tkMainForm.toolTop

End Sub

'==========================================================================
' Form initialization
'==========================================================================
Private Sub Form_Load()
On Error GoTo ErrorHandler

Call GetLineColors

' The Currently Active Form is this selected one
Set activeRPGCode = Me

' Not Entirely Sure What Chris did here
dataIndex = VectRPGCodeNewSlot()
activeRPGCodeIndex = dataIndex
    
codeForm.width = Me.width * 0.9 - 255
codeForm.Height = Me.Height * 0.9 - 335
codeForm.Left = (Me.width * 0.1) / 2
codeForm.Top = 335

WindowState = 0

If (Tag <> "1") Then
    mnuNotepadMode.Checked = False
Else
    Call mnuNotepadMode_Click
End If

Call Form_Resize

codeForm.Text = GetSetting("RPGToolkit3", "PRG Editor", "Common", vbNullString)
If (LenB(codeForm.Text)) Then codeForm.Text = codeForm.Text & vbCrLf
codeForm.selStart = Len(codeForm.Text)

Exit Sub

'Begin error handling code:
ErrorHandler:
Call HandleError
Resume Next

End Sub

'==========================================================================
' Form resize
'==========================================================================
Private Sub Form_Resize()

    Dim cfTop As Long
    If (mnuBookmarkToolbar.Checked) Then cfTop = 335
    codeForm.move 0, cfTop, Me.ScaleWidth, Me.ScaleHeight - cfTop
    cboBookmarkType.width = (Me.width - 60) / 2
    If Not (secondCombo Is Nothing) Then
        secondCombo.Left = cboBookmarkType.width
        secondCombo.width = cboBookmarkType.width - 60
        secondCombo.visible = True
    End If

End Sub

'==========================================================================
' Form unload
'==========================================================================
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

    rpgcodeList(activeRPGCodeIndex).prgText = codeForm.Text
    Call hideAllTools
    If (mnuNotepadMode.Checked) Then Call mnuNotepadMode_Click
    If (Tag = "1") Then Call mnuexit_Click
    Call tkMainForm.refreshTabs

End Sub

'==========================================================================
' Show options
'==========================================================================
Private Sub mnuColorCoding_Click()
    Call frmColoringOptions.Show(vbModal)
End Sub

'==========================================================================
' Show the introduction
'==========================================================================
Private Sub rpgin_Click()
    On Error GoTo ErrorHandler
    Call BrowseFile(helpPath$ + ObtainCaptionFromTag(DB_Help2, resourcePath$ + m_LangFile))

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

'==========================================================================
' Show the reference
'==========================================================================
Private Sub rpgr_Click(): On Error Resume Next
    Call BrowseFile(helpPath$ + ObtainCaptionFromTag(DB_Help3, resourcePath$ + m_LangFile))
End Sub

'==========================================================================
' Launch the RPGCode updater.
'==========================================================================
Private Sub mnuUpdateRpgCode_Click()
    Call frmRpgCodeUpdate.Show(vbModal)
End Sub

'==========================================================================
' Test the program in question
'==========================================================================
Private Sub rprg_Click()

    'On Error Resume Next
    
    Dim testPRG As String, i As Long
    
    If LenB(rpgcodeList(activeRPGCodeIndex).Ifont) Then
        testPRG = testPRG + "Font(" + """" + rpgcodeList(activeRPGCodeIndex).Ifont + """" + ");" + vbCrLf
    End If
    
    If rpgcodeList(activeRPGCodeIndex).IfontSize >= 8 Then
        testPRG = testPRG + "FontSize(" + CStr(rpgcodeList(activeRPGCodeIndex).IfontSize) + ");" + vbCrLf
    End If
    
    If LenB(rpgcodeList(activeRPGCodeIndex).Imwin) Then
        testPRG = testPRG + "WinGraphic(" + """" + rpgcodeList(activeRPGCodeIndex).Imwin + """" + ");" + vbCrLf
    End If
    
    For i = 0 To 4
        If LenB(rpgcodeList(activeRPGCodeIndex).Ichar(i)) Then
            testPRG = testPRG + "AddPlayer(" + """" + rpgcodeList(activeRPGCodeIndex).Ichar(i) + """" + ");" + vbCrLf
        End If
    Next i
    
    If LenB(rpgcodeList(activeRPGCodeIndex).Iboard) Then
        testPRG = testPRG + "Send(" + """" + rpgcodeList(activeRPGCodeIndex).Iboard + """" + ", 9, 5, 1);" + vbCrLf
    End If
    
    testPRG = testPRG & vbCrLf & codeForm.Text

    i = FreeFile()
    Open projectPath & prgPath & "sys_test.prg" For Output As i
        Print #i, testPRG
    Close i
    
    'Run trans3 through the Shell.
    Call Shell("trans3 " & loadedMainFile & " sys_test.prg", vbNormalFocus)

End Sub

'==========================================================================
' Save the program as...
'==========================================================================
Private Sub sasmnu_Click(): On Error Resume Next

    Dim dlg As FileDialogInfo
    
    dlg.strDefaultFolder = projectPath & prgPath
    dlg.strTitle = "Save Program As"
    dlg.strDefaultExt = "prg"
    dlg.strFileTypes = "RPG Toolkit Program (*.prg)|*.prg|All files(*.*)|*.*"
    
    ChDir (currentDir)
    If Not SaveFileDialog(dlg, Me.hwnd, True) Then Exit Sub
    If LenB(dlg.strSelectedFile) = 0 Then Exit Sub
    
     'Preserve the path if a sub-folder is chosen.
    If Not getValidPath(dlg.strSelectedFile, dlg.strDefaultFolder, rpgcodeList(activeRPGCodeIndex).prgName, True) Then Exit Sub
   
    Call saveProgram(dlg.strDefaultFolder & rpgcodeList(activeRPGCodeIndex).prgName)
    activeRPGCode.Caption = rpgcodeList(activeRPGCodeIndex).prgName
    
    rpgcodeList(activeRPGCodeIndex).prgNeedUpdate = False
    Call tkMainForm.tvAddFile(dlg.strSelectedFile)
    
End Sub

'==========================================================================
' Save the program in question
'==========================================================================
Private Sub SavePrgMnu_Click(): On Error Resume Next

    If LenB(rpgcodeList(activeRPGCodeIndex).prgName) = 0 Then
        Call sasmnu_Click
        Exit Sub
    End If
    
    Dim strFile As String
    
    If Tag = "1" Then
        strFile = rpgcodeList(activeRPGCodeIndex).prgName
        ' Call saveProgram(rpgcodeList(activeRPGCodeIndex).prgName)
    Else
        strFile = projectPath & prgPath & rpgcodeList(activeRPGCodeIndex).prgName
        ' Call saveProgram(projectPath & prgPath & rpgcodeList(activeRPGCodeIndex).prgName)
    End If
    
    If (fileExists(strFile)) Then
        If (GetAttr(strFile) And vbReadOnly) Then

            Call MsgBox("This file is read-only; please choose a different file.")
            Call sasmnu_Click
            Exit Sub

        End If
    End If

    Call saveProgram(strFile)
    
    'File is now unaltered.
    rpgcodeList(activeRPGCodeIndex).prgNeedUpdate = False

End Sub

'==========================================================================
' Show the visual editor
'==========================================================================
Private Sub tkvismnu_Click()
On Error GoTo ErrorHandler
Call tkvisual.Show
Exit Sub

'Begin error handling code:
ErrorHandler:
Call HandleError
Resume Next

End Sub

'==========================================================================
' Show the test preferences
'==========================================================================
Private Sub tpref_Click()
On Error GoTo ErrorHandler

Call testprefs.Show(vbModal)

Exit Sub

'Begin error handling code:
ErrorHandler:
Call HandleError
Resume Next

End Sub

'==========================================================================
' Main form menus
'==========================================================================

' TILE HORIZONTALLY MENU
Private Sub mnutilehorizontally_Click()
    On Error Resume Next
    Call tkMainForm.tilehorizonatllymnu_Click
End Sub

' TILE VERTICALLY MENU
Private Sub mnutilevertically_Click()
    On Error Resume Next
    Call tkMainForm.tileverticallymnu_Click
End Sub

' SHOW TUTORIAL MENU
Private Sub mnuTutorial_Click()
    On Error Resume Next
    Call tkMainForm.tutorialmnu_Click
End Sub

' SHOW GUIDE MENU
Private Sub mnuusersguide_Click()
    On Error Resume Next
    Call tkMainForm.usersguidemnu_Click
End Sub

' ABOUT SCREEN MENU
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

' OPEN FILE MENU
Private Sub mnuopen_Click(): On Error Resume Next
    
    If Tag = "1" Then
    
        Dim file As String, fileTypes As String
        fileTypes = "RPG Toolkit Program (*.prg)|*.prg"
        
        If browseFileDialog(Me.hwnd, projectPath, "Open program", "prg", fileTypes, file) Then
            Shell App.path & "\" & App.EXEName & ".exe " & filename(1), vbNormalFocus
        End If
        
    Else
        Call tkMainForm.openmnu_Click
    End If

End Sub

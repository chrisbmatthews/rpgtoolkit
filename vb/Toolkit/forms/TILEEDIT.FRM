VERSION 5.00
Begin VB.Form tileedit 
   Caption         =   "Tile Editor (Untitled)"
   ClientHeight    =   5520
   ClientLeft      =   1170
   ClientTop       =   1155
   ClientWidth     =   6555
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
   Icon            =   "TILEEDIT.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5520
   ScaleWidth      =   6555
   Tag             =   "1636"
   Begin VB.PictureBox tileform 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   4680
      Left            =   480
      MousePointer    =   2  'Cross
      ScaleHeight     =   310
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   310
      TabIndex        =   0
      Top             =   240
      Width           =   4680
   End
   Begin VB.Menu tileeditfile 
      Caption         =   "File"
      Tag             =   "1201"
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
      Begin VB.Menu savenoquestions 
         Caption         =   "Save Tile"
         Shortcut        =   ^S
         Tag             =   "1665"
      End
      Begin VB.Menu savetile2 
         Caption         =   "Save Tile As..."
         Shortcut        =   ^A
         Tag             =   "1666"
      End
      Begin VB.Menu mnusts 
         Caption         =   "Save Into Tileset"
         Tag             =   "1667"
      End
      Begin VB.Menu mnusaveall 
         Caption         =   "Save All"
      End
      Begin VB.Menu sub2 
         Caption         =   "-"
      End
      Begin VB.Menu exit 
         Caption         =   "Close"
         Tag             =   "1088"
      End
      Begin VB.Menu mnuexit 
         Caption         =   "Exit"
      End
   End
   Begin VB.Menu edittilemenu 
      Caption         =   "Edit"
      Tag             =   "1377"
      Begin VB.Menu undotilemenu 
         Caption         =   "Undo"
         Shortcut        =   ^Z
         Tag             =   "1669"
      End
      Begin VB.Menu mnuRedo 
         Caption         =   "Redo"
         Enabled         =   0   'False
         Shortcut        =   ^Y
         Visible         =   0   'False
      End
      Begin VB.Menu sub9 
         Caption         =   "-"
      End
      Begin VB.Menu cutcornermnu 
         Caption         =   "Cut Corner"
         Tag             =   "1215"
      End
      Begin VB.Menu mnuSkew 
         Caption         =   "Skew"
         Tag             =   "1693"
      End
      Begin VB.Menu cmdClear 
         Caption         =   "Clear"
         Shortcut        =   +{DEL}
      End
      Begin VB.Menu sub12 
         Caption         =   "-"
      End
      Begin VB.Menu mnuRotate 
         Caption         =   "Rotate"
         Begin VB.Menu mnuRotate180 
            Caption         =   "180°"
         End
         Begin VB.Menu mnuRotate90CW 
            Caption         =   "90° CW"
         End
         Begin VB.Menu mnuRotate90CCW 
            Caption         =   "90° CCW"
         End
         Begin VB.Menu sub10 
            Caption         =   "-"
         End
         Begin VB.Menu mnuFlipHor 
            Caption         =   "Flip Horizontal"
         End
         Begin VB.Menu mnuFlipVer 
            Caption         =   "Flip Vertical"
         End
      End
   End
   Begin VB.Menu mnuImage 
      Caption         =   "Image"
      Begin VB.Menu convert 
         Caption         =   "Import Image"
         Shortcut        =   ^I
      End
      Begin VB.Menu layer 
         Caption         =   "Layer Tile"
         Tag             =   "1591"
      End
      Begin VB.Menu gtilemnu 
         Caption         =   "Grab Tiles"
         Shortcut        =   ^G
         Tag             =   "1699"
      End
      Begin VB.Menu sub11 
         Caption         =   "-"
      End
      Begin VB.Menu scolormnu 
         Caption         =   "Select Color"
         Shortcut        =   ^R
         Tag             =   "1080"
      End
      Begin VB.Menu mnuDOS 
         Caption         =   "DOS Palette"
      End
      Begin VB.Menu shadetle 
         Caption         =   "Shade Tile"
         Tag             =   "1673"
      End
      Begin VB.Menu gryscle 
         Caption         =   "Grayscale"
      End
   End
   Begin VB.Menu drawmenutile 
      Caption         =   "Draw"
      Tag             =   "1674"
      Begin VB.Menu mnuGrid 
         Caption         =   "Grid On/Off"
         Tag             =   "1675"
      End
      Begin VB.Menu mnuPencil 
         Caption         =   "Pencil"
      End
      Begin VB.Menu mnuColorCap 
         Caption         =   "Color Capture"
         Shortcut        =   ^P
         Tag             =   "1676"
      End
      Begin VB.Menu mnuEraser 
         Caption         =   "Eraser"
         Shortcut        =   ^E
         Tag             =   "1677"
      End
      Begin VB.Menu mnuFloodFill 
         Caption         =   "Flood Fill"
         Shortcut        =   ^F
         Tag             =   "1678"
      End
   End
   Begin VB.Menu efmenu 
      Caption         =   "Effects"
      Tag             =   "1475"
      Begin VB.Menu blurmnu 
         Caption         =   "Blur"
         Shortcut        =   ^B
         Tag             =   "1683"
      End
      Begin VB.Menu lsrc 
         Caption         =   "Light Source"
         Tag             =   "1684"
      End
      Begin VB.Menu mnuTexturize 
         Caption         =   "Texturize"
      End
      Begin VB.Menu mnuTranslucentize 
         Caption         =   "Translucentize"
      End
   End
   Begin VB.Menu mnuToolkit 
      Caption         =   "Toolkit"
      Begin VB.Menu mnutestgame 
         Caption         =   "Test Game"
         Shortcut        =   {F5}
      End
      Begin VB.Menu mnuselectlanguage 
         Caption         =   "Select Language"
         Shortcut        =   ^L
      End
      Begin VB.Menu sub4 
         Caption         =   "-"
      End
      Begin VB.Menu mnuinstallupgrade 
         Caption         =   "Install Upgrade"
      End
   End
   Begin VB.Menu mnuBuild 
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
   Begin VB.Menu mnuWindow 
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
      Begin VB.Menu mnuCascade 
         Caption         =   "Cascade"
      End
      Begin VB.Menu mnuArrangeIcons 
         Caption         =   "Arrange Icons"
      End
   End
   Begin VB.Menu hmnu 
      Caption         =   "Help"
      Tag             =   "1206"
      Begin VB.Menu mnuusersguide 
         Caption         =   "User's Guide"
         Shortcut        =   {F1}
      End
      Begin VB.Menu mnuRPGCodePrimer 
         Caption         =   "RPGCode Primer"
      End
      Begin VB.Menu mnurpgcodereference 
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
Attribute VB_Name = "tileedit"
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
' Function declaration
'========================================================================

'Flood fill a device context with the current brush
Private Declare Function ExtFloodFill Lib "gdi32" (ByVal hdc As Long, ByVal X As Long, ByVal Y As Long, ByVal crColor As Long, ByVal wFillType As Long) As Long

'Create a solid brush object of the color passed in
Private Declare Function CreateSolidBrush Lib "gdi32" (ByVal crColor As Long) As Long

'Assign an object to a device context
Private Declare Function SelectObject Lib "gdi32" (ByVal hdc As Long, ByVal hObject As Long) As Long

'Delete an object
Private Declare Function DeleteObject Lib "gdi32" (ByVal hObject As Long) As Long

'========================================================================
' Variable declaration
'========================================================================

'This form's indice
Private mVarIndice As Long

'Ignore reactivation action
Public ignoreDeactivate As Boolean

'Have we begun dragging?
Private bDragBegin As Boolean

'Initial x and y coords if drag
Private dragX1 As Integer, dragY1 As Integer

'For the new ISO mode; 1 = Normal, 2 = ISO
Private xMod As Byte

'For the changecolor function
Private bChangeColor As Byte

'Current position in undo array
Private currentUndo As Long

'========================================================================
' Enum declaration
'========================================================================

'Addshape
Private Enum ADDSHAPE_TYPE
    FilledRectangle = 1
    Rectangle = 2
    FilledEllipse = 3
    Ellipse = 4
    SingleLine = 5
End Enum

'Scroll
Public Enum SCROLL_TYPE
    North = 1
    East = 2
    South = 3
    West = 4
End Enum

'Flip
Private Enum FLIP_TYPE
    Horizontal = 1
    Vertical = 2
End Enum

'Rotate
Private Enum ROTATE_TYPE
    Left = 1
    Right = 2
    OneHundredEighty = 3
End Enum

'========================================================================
' Return type of form
'========================================================================
Public Function formType() As Long
    formType = FT_TILE
End Function

'========================================================================
' Indice property
'========================================================================
Public Property Let indice(ByVal newVal As Long)
    mVarIndice = newVal
End Property
Public Property Get indice() As Long
    If useLockIndice Then
        indice = lockIndice
    Else
        indice = mVarIndice
    End If
End Property

'========================================================================
' Change the mode to normal/ISO
'========================================================================
Public Sub isoChange( _
                        ByVal isoCheck As Boolean, _
                        Optional ByVal doNotDealWithImport As Boolean _
                                                                        )

    On Error Resume Next

    'Exit sub if the mode is already the called mode
    If isoCheck = openTileEditorDocs(indice).isometric Then Exit Sub

    If isoCheck Then
        If openTileEditorDocs(indice).tileNeedUpdate Then
            If MsgBox("Conversion to a .iso isometric tile is permanent!" _
                       & " Note you can still use .tst tiles on isometric" _
                       & " boards without having to convert to .iso. Do you" _
                       & " wish to continue?", vbOKCancel + vbExclamation, "Isometric Mode") = vbCancel Then
                tkMainForm.tileIsoCheck.value = 0
                Exit Sub
            End If
        End If
        
        'Convert the tilemem to isometric through the rotation code, and store it
        'in the buffer tile
        Call tstToIsometric
        
        'Copy the buffer tile into tilemem.

        Dim X As Integer, Y As Integer
        For X = 0 To 64
            For Y = 0 To 32
                tileMem(X + 1, Y + 1) = bufTile(X, Y)
            Next Y
        Next X

        xMod = 2
        xRange = 64
        
        'Delete border of the isomirror in TkMainForm
        tkMainForm.isoMirror.BorderStyle = 0
        'Clear mirror in TkMainForm
        Call vbPicFillRect(tkMainForm.mirror, 0, 0, 100, 100, vbQBColor(15))
    Else
        If openTileEditorDocs(indice).tileNeedUpdate Then
            If MsgBox("Conversion from isometric to 2D is not possible. The" _
                       & " current tile will be erased. Do you wish to continue?", vbOKCancel + vbExclamation, "Isometric Mode") = vbCancel Then
                tkMainForm.tileIsoCheck.value = 1
                Exit Sub
            End If
        End If

        'Clear the tilemem data.
        For X = 0 To 64
            For Y = 0 To 32
                tileMem(X, Y) = -1
            Next Y
        Next X
        
        'Clear the tilename.
        openTileEditorDocs(indice).tileName = ""
        activeTile.Caption = LoadStringLoc(801, "Tile Editor") + "  (Untitled)"
        
        For X = 0 To 64
            For Y = 0 To 32
                tileMem(X, Y) = -1
            Next Y
        Next X
        xMod = 1
        xRange = 32

        'Show border of the isomirror in TkMainForm
        tkMainForm.isoMirror.BorderStyle = 1
        tkMainForm.isoMirror.cls
    End If
    
    'Update ISO variable
    openTileEditorDocs(indice).isometric = isoCheck
    
    'Update buttons/menu
    Call isoUpdate
    
    'Update tilename
    openTileEditorDocs(indice).tileName = ""
    'Update caption
    Me.Caption = LoadStringLoc(801, "Tile Editor") + "  (Untitled)"
    
    'Resize/Redraw
    Call Form_Resize
End Sub

'========================================================================
' Update buttons/menu
'========================================================================
Private Sub isoUpdate(): On Error Resume Next
    With openTileEditorDocs(indice)
        mnuRotate.Enabled = Not .isometric
        cutcornermnu.Enabled = Not .isometric
        mnuSkew.Enabled = Not .isometric
        convert.Enabled = Not .isometric
        layer.Enabled = Not .isometric
        lsrc.Enabled = Not .isometric
        tkMainForm.cmdImport.Enabled = Not .isometric
        tkMainForm.Command15.Enabled = Not .isometric
        tkMainForm.Command16.Enabled = Not .isometric
        tkMainForm.Command18.Enabled = Not .isometric
        tkMainForm.Command19.Enabled = Not .isometric
    End With
End Sub

'========================================================================
' Set the color to transparant
'========================================================================
Public Sub Command1_Click(): On Error GoTo ErrorHandler
    'Set the current color to transparent
    openTileEditorDocs(indice).currentColor = -1
    'Update selected color Picturebox in TkMainForm
    Call vbPicFillRect(tkMainForm.selectedcolor, 0, 0, 100, 100, RGB(255, 255, 255))
    Call vbPicFillRect(tkMainForm.selectedcolor, 0, 0, (tkMainForm.selectedcolor.Width / 2) / 15, (tkMainForm.selectedcolor.height / 2) / 15, vbQBColor(7))
    Call vbPicFillRect(tkMainForm.selectedcolor, (tkMainForm.selectedcolor.Width / 2) / 15, (tkMainForm.selectedcolor.height / 2) / 15, 100, 100, vbQBColor(7))
    'Refresh
    Call vbPicRefresh(tkMainForm.selectedcolor)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

'========================================================================
' When you click in the color picker in TkMainform
'========================================================================
Public Sub palettebox_MouseDown(button As Integer, Shift As Integer, X As Single, Y As Single): On Error GoTo ErrorHandler
    'Set the current color
    openTileEditorDocs(indice).currentColor = vbFrmPoint(tkMainForm.palettebox, X, Y)
    
    'Update selected color picturebox in tkMainForm
    Call vbPicFillRect(tkMainForm.selectedcolor, 0, 0, 100, 100, openTileEditorDocs(indice).currentColor)
    
    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

'========================================================================
' Set Grid On/Off
'========================================================================
Public Sub tileGrid(ByVal value As Byte): On Error Resume Next
    If value = 0 Then openTileEditorDocs(indice).grid = False Else openTileEditorDocs(indice).grid = True
    'Redraw
    Call tileRedraw
End Sub

'========================================================================
' Scroll
'========================================================================
Public Sub Scroll(ByVal how As SCROLL_TYPE): On Error Resume Next
    'Undo
    Call setUndo
    
    Dim xx As Integer, yy As Integer
    
    Select Case how
        Case North
            For xx = 1 To 32
                For yy = 1 To 32 - 1
                    bufTile(xx, yy) = tileMem(xx, yy + 1)
                Next yy
            Next xx
        
            For xx = 1 To 32
                bufTile(xx, 32) = tileMem(xx, 1)
            Next xx
        Case East
            For xx = 1 To 32
                For yy = 1 To 32
                    bufTile(xx, yy) = tileMem(xx - 1, yy)
                Next yy
            Next xx
            
            For yy = 1 To 32
                bufTile(1, yy) = tileMem(32, yy)
            Next yy
        Case South
            For xx = 1 To 32
                For yy = 1 To 32
                    bufTile(xx, yy) = tileMem(xx, yy - 1)
                Next yy
            Next xx
        
            For xx = 1 To 32
                bufTile(xx, 1) = tileMem(xx, 32)
            Next xx
        Case West
            For xx = 1 To 32 - 1
                For yy = 1 To 32
                    bufTile(xx, yy) = tileMem(xx + 1, yy)
                Next yy
            Next xx
            
            For yy = 1 To 32
                bufTile(32, yy) = tileMem(1, yy)
            Next yy
    End Select
    
    'Change the tile
    For xx = 1 To 32
        For yy = 1 To 32
            tileMem(xx, yy) = bufTile(xx, yy)
        Next yy
    Next xx
    
    'Redraw
    Call tileRedraw
End Sub

'========================================================================
' Rotates the tile
'========================================================================
Private Sub Rotate(ByVal how As ROTATE_TYPE)
   'Undo
    Call setUndo

    Dim X As Integer, Y As Integer, xx As Integer, yy As Integer
   
    'Buff it
    For X = 1 To 32
        For Y = 1 To 32
            bufTile(X, Y) = tileMem(X, Y)
        Next Y
    Next X
   
    'Reset variables
    yy = 1: xx = 1

    'Start changing the tiles
    Select Case how
        Case Left
            For X = 1 To 32
                For Y = 32 To 1 Step -1
                    tileMem(X, Y) = bufTile(xx, yy)
                    xx = xx + 1
                Next Y
                xx = 1
                yy = yy + 1
            Next X
        Case Right
            For X = 32 To 1 Step -1
                For Y = 1 To 32
                    tileMem(X, Y) = bufTile(xx, yy)
                    xx = xx + 1
                Next Y
                xx = 1
                yy = yy + 1
            Next X
        Case OneHundredEighty
            For Y = 32 To 1 Step -1
                For X = 32 To 1 Step -1
                    tileMem(X, Y) = bufTile(xx, yy)
                    xx = xx + 1
                Next X
                xx = 1
                yy = yy + 1
            Next Y
    End Select
    'Redraw
    Call tileRedraw
End Sub

'========================================================================
' Flips the tile
'========================================================================
Private Sub Flip(ByVal how As FLIP_TYPE)
    'Undo
    Call setUndo
   
    Dim X As Integer, Y As Integer
   
    For X = 1 To 32
        For Y = 1 To 32
            If how = Horizontal Then
                bufTile(X, Y) = tileMem(32 - X + 1, Y)
            Else 'Vertical
                bufTile(X, Y) = tileMem(X, 32 - Y + 1)
            End If
        Next Y
    Next X
   
    For X = 1 To 32
        For Y = 1 To 32
            tileMem(X, Y) = bufTile(X, Y)
        Next Y
    Next X

    'Redraw
    Call tileRedraw
End Sub

'========================================================================
' Put the tile in the undo buffer
'========================================================================
Public Sub setUndo()

    On Error Resume Next

    'Enlarge undo array
    ReDim Preserve openTileEditorDocs(indice).undoTile(currentUndo, 64, 32)

    Dim X As Integer, Y As Integer
    For X = 1 To xRange
        For Y = 1 To 32
            openTileEditorDocs(indice).undoTile(currentUndo, X, Y) = tileMem(X, Y)
            openTileEditorDocs(indice).undoTile(X, Y) = tileMem(X, Y)
        Next Y
    Next X

    'Move onto the next place in the array
    currentUndo = currentUndo + 1

End Sub

'========================================================================
' This gets the info from the undo and changes the tile back
'========================================================================
Public Sub getUndo()

    On Error Resume Next

    If currentUndo = 0 Then
        'No undos have been saved
        Exit Sub
    End If

    Dim undoFrom As Long, undoTo As Long

    'currentUndo will be one higher than the last used position
    'in the undo array
    undoFrom = currentUndo - 1

    'currentUndo will be the next avaliable position in the undo array
    undoTo = currentUndo

    'Enlarge the array to make room for undoTo
    ReDim Preserve openTileEditorDocs(indice).undoTile(undoTo, 64, 32)

    'Now copy tileMem --> undoTo and undoFrom --> tileMem
    Dim a As Long, b As Long
    For a = 1 To xRange
        For b = 1 To 32
            'tileMem --> undoTo
            openTileEditorDocs(indice).undoTile(undoTo, a, b) = tileMem(a, b)
            'undoFrom --> tileMem
            tileMem(a, b) = openTileEditorDocs(indice).undoTile(undoFrom, a, b)
            'undoTo --> undoFrom
            openTileEditorDocs(indice).undoTile(undoFrom, a, b) = openTileEditorDocs(indice).undoTile(undoTo, a, b)
        Next b
    Next a

    'Decrease currentUndo so the next undo yields it
    currentUndo = currentUndo - 1

    'Redraw the tile
    Call tileRedraw
    
End Sub

'========================================================================
'Redo what was just undone
'========================================================================
Public Sub useRedo()

    On Error Resume Next

    Dim redoFrom As Long, redoTo As Long

    'currentUndo will equal one higher than the last undo dimension used.
    'This is also the position of the current redo.
    redoFrom = currentUndo

    'currentUndo will equal one higher than the last used position. One higher
    'than this is new free position for redoing.
    redoTo = currentUndo + 1

    'Enlarge the array to fit redoTo
    ReDim Preserve openTileEditorDocs(indice).undoTile(redoTo + 1, 64, 32)

    'At this point, things look like this:
    'undoTile(...
    '             currentUndo - 1 == current undo buffer
    '             currentUndo     == current redo buffer [redoFrom]
    '             currentUndo + 1 == free redo buffer    [redoTo]
    '                                                               ..., x, y)
    
    'Now it's time to do the loop
    Dim a As Long, b As Long
    For a = 1 To xRange
        For b = 1 To 32
            'tileMem --> redoTo
            openTileEditorDocs(indice).undoTile(redoTo, a, b) = tileMem(a, b)
            'redoFrom --> tileMem
            tileMem(a, b) = openTileEditorDocs(indice).undoTile(redoFrom, a, b)
            'redoTo --> redoFrom
            openTileEditorDocs(indice).undoTile(redoFrom, a, b) = openTileEditorDocs(indice).undoTile(redoTo, a, b)
        Next b
    Next a

    'Now move forward in the array
    currentUndo = currentUndo + 1

    'Things are still as they were (setup wise)

    'Redraw!
    Call tileRedraw

End Sub

'========================================================================
' Changes one color to another color in the editor
'========================================================================
Public Sub changeColor()
    'If the user has choosen the color he wants to change, we go through this loop
    If bChangeColor = 2 Then
        Dim X As Integer, Y As Integer
        For X = 1 To xRange                            '<-- Edit
            For Y = 1 To 32
                If tileMem(X, Y) = openTileEditorDocs(indice).changeColor Then
                    tileMem(X, Y) = openTileEditorDocs(indice).currentColor
                End If
            Next Y
        Next X
        'Redraw the tile
        Call tileRedraw
        'Reset the function
        bChangeColor = 0
    Else
        MsgBox "Select the color you want to change.", vbOKOnly + vbQuestion
        bChangeColor = 1
        'Select the eyedropper
        Call ToolSet(1)
    End If
End Sub

'========================================================================
' Tile Tools
'========================================================================

'Fill
Private Sub fillTile( _
                        ByVal X As Long, _
                        ByVal Y As Long, _
                        ByVal crColor As Long _
                                                )

    '========================================================================
    'Re-written by KSNiloc
    '
    ' + Now uses GDI
    ' + Much, much, much faster
    '========================================================================

    On Error Resume Next

    'Get the color where the user clicked down
    Dim clickColor As Long
    clickColor = tileMem(X, Y)

    If clickColor = crColor Then
        'Click color and color we're changing to are the same- don't bother
        Exit Sub
    End If

    'Make this 'undoable'
    Call setUndo

    'Create a canvas
    Dim cnv As Long
    cnv = CreateCanvas(xRange + 1, 32 + 1)

    'Draw the tile on the canvas
    Dim a As Long, b As Long
    For a = 1 To xRange
        For b = 1 To 32
            Call CanvasSetPixel(cnv, a, b, tileMem(a, b))
        Next b
    Next a

    'Open the canvas' device context
    Dim hdc As Long
    hdc = CanvasOpenHDC(cnv)

    'Create a brush
    Dim brush As Long
    brush = CreateSolidBrush(crColor)

    'Assign the brush to the device context
    Call SelectObject(hdc, brush)

    'Process the flood fill on the device context
    Call ExtFloodFill(hdc, X, Y, clickColor, 1)

    'Destroy the brush
    Call DeleteObject(brush)

    'Close the device context
    Call CanvasCloseHDC(cnv, hdc)

    'Transfer the content on the canvas back to the tileMem() array
    For a = 1 To xRange
        For b = 1 To 32
            tileMem(a, b) = CanvasGetPixel(cnv, a, b)
        Next b
    Next a

    'Destroy the canvas
    Call DestroyCanvas(cnv)

    'Redraw the tile
    Call tileRedraw

End Sub

'Others
Private Sub tileAddShape(ByVal x1 As Integer, ByVal y1 As Integer, ByVal x2 As Integer, ByVal y2 As Integer, ByVal how As ADDSHAPE_TYPE): On Error Resume Next
    'Undo
    Call setUndo
    
    Dim X, Y As Integer
    Dim Canv As Long
    Dim tc As Long, p As Long
    'Create an offscreen canvas, and test it
    Canv = CreateCanvas(xRange, 32)
    tc = RGB(255, 100, 50)
    Call CanvasSetPixel(Canv, 0, 0, tc)
    tc = CanvasGetPixel(Canv, 0, 0)
    
    'Copy the tilemem to the offscreen canvas.
    For X = 1 To xRange
        For Y = 1 To 32
            If tileMem(X, Y) <> -1 Then
                Call CanvasSetPixel(Canv, X - 1, Y - 1, tileMem(X, Y))
            Else
                'Set tc (from above) as the transparent color
                Call CanvasSetPixel(Canv, X - 1, Y - 1, tc)
                p = CanvasGetPixel(Canv, X - 1, Y - 1)
            End If
        Next Y
    Next X
        
    Select Case how
        Case 1 'Filled Rectangle
            If openTileEditorDocs(indice).currentColor <> -1 Then
                Call CanvasFillBox(Canv, x1 - 1, y1 - 1, x2 - 1, y2 - 1, openTileEditorDocs(indice).currentColor)
            Else
                Call CanvasFillBox(Canv, x1 - 1, y1 - 1, x2 - 1, y2 - 1, tc)
            End If
        Case 2 'Rectangle
            If openTileEditorDocs(indice).currentColor <> -1 Then
                Call CanvasBox(Canv, x1 - 1, y1 - 1, x2 - 1, y2 - 1, openTileEditorDocs(indice).currentColor)
            Else
                Call CanvasBox(Canv, x1 - 1, y1 - 1, x2 - 1, y2 - 1, tc)
            End If
        Case 3 'Filled Ellipse
            If openTileEditorDocs(indice).currentColor <> -1 Then
                Call CanvasDrawFilledEllipse(Canv, x1 - 1, y1 - 1, x2 - 1, y2 - 1, openTileEditorDocs(indice).currentColor)
            Else
                Call CanvasDrawFilledEllipse(Canv, x1 - 1, y1 - 1, x2 - 1, y2 - 1, tc)
            End If
        Case 4 'Ellipse
            If openTileEditorDocs(indice).currentColor <> -1 Then
                Call CanvasDrawEllipse(Canv, x1 - 1, y1 - 1, x2 - 1, y2 - 1, openTileEditorDocs(indice).currentColor)
            Else
                Call CanvasDrawEllipse(Canv, x1 - 1, y1 - 1, x2 - 1, y2 - 1, tc)
            End If
        Case 5 'Line
            If openTileEditorDocs(indice).currentColor <> -1 Then
                Call CanvasDrawLine(Canv, x1 - 1, y1 - 1, x2 - 1, y2 - 1, openTileEditorDocs(indice).currentColor)
            Else
                Call CanvasDrawLine(Canv, x1 - 1, y1 - 1, x2 - 1, y2 - 1, tc)
            End If
    End Select

    'Copy the canvas back to the tilemem.
    For X = 1 To xRange
        For Y = 1 To 32
            p = CanvasGetPixel(Canv, X - 1, Y - 1)
            If p = tc Then
                'Transparent colour.
                tileMem(X, Y) = -1
            Else
                tileMem(X, Y) = p
            End If
        Next Y
    Next X
    
    'Destroy the Canvas
    Call DestroyCanvas(Canv)
    
    'Redraw
    Call tileRedraw
End Sub

'========================================================================
' Form_Activate
'========================================================================
Private Sub Form_Activate(): On Error GoTo ErrorHandler
    'Set some variables for the form

    Set activeTile = Me
    Set activeForm = Me

    filename(2) = ""
    ignoreDeactivate = False

    If openTileEditorDocs(indice).isometric Then
        tkMainForm.tileIsoCheck.value = 1
        xRange = 64
        xMod = 2
    Else
        tkMainForm.tileIsoCheck.value = 0
        xRange = 32
        xMod = 1
    End If

    Call isoUpdate
    
    'Redraw
    Call tileRedraw
    
    'Set the current tool
    Call ToolSet(openTileEditorDocs(indice).tileMode)
    
    'Set the selected color
    Call vbPicFillRect(tkMainForm.selectedcolor, 0, 0, 1000, 1000, openTileEditorDocs(indice).currentColor)
    
    'Hide tools/extra's
    Call hideAllTools
    'Show the ones we need
    tkMainForm.bottomFrame.Visible = True
    tkMainForm.tileExtras.Visible = True
    tkMainForm.tileTools.Visible = True
    tkMainForm.tileTools.Top = tkMainForm.toolTop
    
    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

'========================================================================
' Form_Deactivate (EDIT for 3.0.4 by Delano)
'========================================================================
Private Sub Form_Deactivate(): On Error Resume Next

    Dim X As Integer, Y As Integer
    
    'Refresh data
    For X = 0 To xRange
        For Y = 0 To 32
            openTileEditorDocs(indice).tileMem(X, Y) = tileMem(X, Y)
        Next Y
    Next X

End Sub

'========================================================================
' New instance of form created
'========================================================================
Private Sub Form_Initialize()
    'Create a new indice
    indice = newTileEditIndice()
    Set openTileEditors(indice) = Me
    Set activeTile = Me
    Call clearTileDoc(openTileEditorDocs(indice))
End Sub

'========================================================================
' Form_KeyPress
'========================================================================
Private Sub Form_KeyPress(KeyAscii As Integer): On Error GoTo ErrorHandler
    If UCase(chr(KeyAscii)) = "L" Then
        If configfile.lastTileset = "" Then
            Call opentile_Click
            Exit Sub
        End If
        tstFile = configfile.lastTileset
        ignoreDeactivate = True
        tilesetform.Show vbModal ', me
        If setFilename$ = "" Then Exit Sub
        
        'Open tile
        Call openTile2(projectPath$ + tilePath$ + setFilename$)
        
        'Redraw tile
        Call highRedraw
        
        'Update filename
        openTileEditorDocs(indice).tileName = setFilename$
        
        'Update caption
        Caption = LoadStringLoc(801, "Tile Editor") & "  (" & setFilename & ")"
        activeTile.Caption = LoadStringLoc(801, "Tile Editor") + "  (" + setFilename$ + ")"

    End If
        
    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

'========================================================================
' Form_Load
'========================================================================
Private Sub Form_Load(): On Error GoTo ErrorHandler

    'Set some variables for the form
    Call LocalizeForm(Me)

    'Refresh Data
    Dim X As Integer, Y As Integer
    For X = 1 To 64
        For Y = 1 To 32
            openTileEditorDocs(indice).tileMem(X, Y) = -1
        Next Y
    Next X
    
    'Set some variables for ISO
    xMod = 1
    xRange = 32
    
    openTileEditorDocs(indice).grid = True
    
    'Make the current tool the pen tool
    Call ToolSet(0)
    
    Exit Sub
'Error Handler
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

'========================================================================
' Form_Resize
'========================================================================
Private Sub Form_Resize(): On Error Resume Next
    'Minimum size
    If Me.Width < (6070 * xMod) And Me.WindowState = 0 Then Me.Width = 6070 * xMod
    If Me.height < 6070 And Me.WindowState = 0 Then Me.height = 6070
    
    'Needed variables
    Dim tfWidth As Integer, tfHeight As Integer
    
    'Calculate size
    tfWidth = (Me.Width - 200) / Screen.TwipsPerPixelX
    tfWidth = (Round(tfWidth / 32) * 32) * Screen.TwipsPerPixelX

    'Calculate height
    tfHeight = (Me.height - 1200) / Screen.TwipsPerPixelY
    tfHeight = (Round(tfHeight / 32) * 32) * Screen.TwipsPerPixelY
        
    'Only resize if the calculated size isn't the same as the current size
    If tfWidth <> tileform.Width And tfHeight <> tileform.height Then
        'Set size
        If tfWidth < tfHeight Then
            tileform.Width = tfWidth
            tileform.height = tfWidth
        Else
            tileform.Width = tfHeight
            tileform.height = tfHeight
        End If
    End If
    
    tileform.Width = tileform.height * xMod
    
    'Reduce the width if it's bigger then the tileform
    If (tileform.Width > Me.Width - 200) Then tileform.Width = tileform.Width - 960
    
    'Set location
    tileform.Left = ((Me.Width - tileform.Width) / 2) - Screen.TwipsPerPixelX * 4
    tileform.Top = (Me.height - tileform.height) / 2 / 2 + Screen.TwipsPerPixelX * 3
    
    'Redraw
    Call tileRedraw
End Sub

'========================================================================
' Form_Unload
'========================================================================
Private Sub Form_Unload(Cancel As Integer): On Error Resume Next

    'Hide all tools
    Call hideAllTools
    
    'Remove this form's indice
    Set openTileEditors(indice) = Nothing

End Sub

'========================================================================
' Depress tool index, and unpress the others
'========================================================================
Public Sub ToolSet(ByVal Index As Byte): On Error Resume Next
    'If this sub is called during this sub, Exit Sub
    If ignore = 1 Then Exit Sub
    
    ignore = 1
    
    'Update current tool variable
    openTileEditorDocs(indice).tileMode = Index
    
    'Go through the tools
    Dim i As Integer
    For i = 0 To 8
        If i = Index Then
            tkMainForm.tileTool(i).value = 1
        Else
            tkMainForm.tileTool(i).value = 0
        End If
    Next i

    ignore = 0
End Sub

'========================================================================
' Redraws the tileform
'========================================================================
Private Sub highRedraw()

    On Error GoTo ErrorHandler

    'Clear tileform and mirrors in TkMainForm
    tileform.cls
    tkMainForm.mirror.cls
    tkMainForm.isoMirror.cls
    
    'Tileform size in pixels
    Dim wwidth, hheight As Integer
    wwidth = (tileform.Width) / Screen.TwipsPerPixelX
    hheight = (tileform.height) / Screen.TwipsPerPixelY
    
    'Size of a pixel on the tileform
    Dim pixelWidth As Integer, pixelHeight As Integer
    pixelWidth = (wwidth / xRange)
    pixelHeight = (hheight / 32)
    
    Dim X As Integer, Y As Integer
    Dim xx As Integer, yy As Integer
    
    Dim bottomX As Long, bottomY As Long
    Dim topX As Long, topY As Long

    For X = 1 To xRange
        For Y = 1 To 32
            xx = (X * pixelWidth) - (pixelWidth - 1)
            yy = (Y * pixelHeight) - (pixelHeight - 1)
            
            If isoMaskBmp(X, Y) <> vbQBColor(0) And openTileEditorDocs(indice).isometric Then
                'Draw background color pixels at the corners if this tile is isometric
                Call vbPicFillRect(tileform, xx, yy, xx + (pixelWidth - 1), yy + (pixelHeight - 1), Me.BackColor)
                Call vbPicPSet(tkMainForm.isoMirror, X - 1, Y - 1, Me.BackColor)
                
                'Clear the tilemem entry
                tileMem(X, Y) = -1
            ElseIf tileMem(X, Y) <> -1 Then
                'If the pixel isn't transparent and isn't masked - both isometric and 2D
                    
                Call vbPicFillRect(tileform, xx - 1, yy - 1, xx + (pixelWidth - 1) - 2, yy + (pixelHeight - 1) - 2, tileMem(X, Y))
                
                If openTileEditorDocs(indice).isometric Then
                    'Draw the isomirror here (moved from tileRedraw.) Don't draw the 2D mirror
                    Call vbPicPSet(tkMainForm.isoMirror, X - 1, Y - 1, tileMem(X, Y))
                Else
                    'Draw the 2D mirror - isomirror drawn in tileRedraw
                    Call vbPicPSet(tkMainForm.mirror, X - 1, Y - 1, tileMem(X, Y))
                End If
                
            Else
                'Transparent.
                Call vbPicFillRect(tileform, xx - 1, yy - 1, xx + pixelWidth / 2 - 2, yy + pixelHeight / 2 - 2, vbQBColor(7))
                Call vbPicFillRect(tileform, xx + pixelWidth / 2 - 1, yy + pixelHeight / 2 - 1, xx + (pixelWidth - 1) - 2, yy + (pixelHeight - 1) - 2, vbQBColor(7))
            End If
        Next Y
    Next X
    
    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

'========================================================================
' Draw the Grid on the tileform
'========================================================================
Private Sub drawGrid(): On Error Resume Next
    'Exit Sub if the grid is set on Off
    If Not openTileEditorDocs(indice).grid Then Exit Sub
    
    'Size of form in pixels.
    Dim tfWidth As Integer, tfHeight As Integer
    tfWidth = (tileform.Width) / Screen.TwipsPerPixelX
    tfHeight = (tileform.height) / Screen.TwipsPerPixelY

    'Size of a pixel on the tileform
    Dim pixelWidth, pixelHeight As Integer
    pixelWidth = Round((tfWidth / xRange))
    pixelHeight = (tfHeight / 32)
    
    Dim X As Integer, Y As Integer
    'Vertical Lines
    For X = -1 To tfWidth Step pixelWidth
        Call vbPicLine(tileform, X, -1, X, tfHeight, vbQBColor(1))
    Next X
    'Horizontal Lines
    For Y = -1 To tfHeight Step pixelHeight
        Call vbPicLine(tileform, -1, Y, tfWidth, Y, vbQBColor(1))
    Next Y
End Sub

'========================================================================
' Redraw the tile
'========================================================================
Public Sub tileRedraw(): On Error GoTo ErrorHandler
    Call highRedraw
    Call drawGrid

    Exit Sub
'Error Handler
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub mnuRedo_Click()
    Call useRedo
End Sub

'========================================================================
' When you click in the Tile Editor
'========================================================================
Private Sub tileform_MouseDown(button As Integer, Shift As Integer, X As Single, Y As Single): On Error Resume Next

    openTileEditorDocs(indice).tileNeedUpdate = True

    'Get current color
    Dim coloruse As Long
    coloruse = openTileEditorDocs(indice).currentColor
        
    'Tileform size in pixels
    Dim tfWidth As Integer, tfHeight As Integer
    tfWidth = (tileform.Width) / Screen.TwipsPerPixelX
    tfHeight = (tileform.height) / Screen.TwipsPerPixelY
        
    'Size of a pixel on the tileform
    Dim pixelWidth, pixelHeight As Integer
    pixelWidth = Round((tfWidth / xRange))
    pixelHeight = (tfHeight / 32)
        
    'Tile pixel co-ordinates (which pixel selected)
    Dim mouseX As Integer, mouseY As Integer
    mouseX = Int(X / pixelWidth)
    mouseY = Int(Y / pixelHeight)
        
    'If a rouge pixel has been selected, Exit Sub
    If mouseX > (xRange - 1) Or mouseY > 31 Then Exit Sub
        
    'If there's clicked in the not-available part, Exit Sub
    If isoMaskBmp(mouseX + 1, mouseY + 1) <> vbQBColor(0) And openTileEditorDocs(indice).isometric Then Exit Sub
        
    Select Case openTileEditorDocs(indice).tileMode
        Case 0, 3

            'Undo
            Call setUndo

            'If the user wants to erase, set colorUse to -1 (Transparent)
            If openTileEditorDocs(indice).tileMode = 3 Then
                coloruse = -1
            End If

            'Tile pixel co-ordinates (which pixel selected)
            Dim newX, newY As Integer
            newX = (mouseX * pixelWidth) + 1
            newY = (mouseY * pixelHeight) + 1

            If (openTileEditorDocs(indice).isometric And isoMaskBmp(mouseX + 1, mouseY + 1) = vbQBColor(0)) Or Not (openTileEditorDocs(indice).isometric) Then
                If coloruse = -1 Then
                    'Transparent; Erase
                    Call vbPicFillRect(tileform, newX - 1, newY - 1, newX + (pixelWidth - 1) - 2, newY + (pixelHeight - 1) - 2, vbQBColor(15))
                    Call vbPicFillRect(tileform, newX - 1, newY - 1, newX + (pixelWidth / 2) - 2, newY + (pixelHeight / 2) - 2, vbQBColor(7))
                    Call vbPicFillRect(tileform, newX + (pixelWidth / 2) - 1, newY + (pixelHeight / 2) - 1, newX + (pixelWidth - 1) - 2, newY + (pixelHeight - 1) - 2, vbQBColor(7))
                                           
                    'Draw grid around the tile
                    If openTileEditorDocs(indice).grid Then
                        Call vbPicRect(tileform, newX - 1, newY - 1, newX + (pixelWidth - 1), newY + (pixelHeight - 1), vbQBColor(1))
                    End If
                        
                    'Store pixel color
                    tileMem(mouseX + 1, mouseY + 1) = coloruse
                        
                    'Set colorUse to white for the mirrors in TkMainForm
                    coloruse = RGB(255, 255, 255)
                Else
                    'Solid; Paint
                    Call vbPicFillRect(tileform, newX - 1, newY - 1, newX + (pixelWidth - 2), newY + (pixelHeight - 2), coloruse)
    
                    'Draw grid around the tile
                    If openTileEditorDocs(indice).grid Then
                        Call vbPicRect(tileform, newX - 2, newY - 2, newX + (pixelWidth - 1) - 1, newY + (pixelHeight - 1) - 1, vbQBColor(1))
                    End If
    
                    tileMem(mouseX + 1, mouseY + 1) = coloruse
                End If
                
            End If
            
            'Draw the pixels on the mirrors
            If openTileEditorDocs(indice).isometric And isoMaskBmp(mouseX + 1, mouseY + 1) = vbQBColor(0) Then
                'Isometric; update isoMirror only
                Call vbPicPSet(tkMainForm.isoMirror, mouseX, mouseY, coloruse)
                Call vbPicRefresh(tkMainForm.isoMirror)
            ElseIf Not (openTileEditorDocs(indice).isometric) Then
                '2D; update both mirrors
                Call vbPicPSet(tkMainForm.mirror, mouseX, mouseY, coloruse)
                Call vbPicPSet(tkMainForm.isoMirror, getIsoX(mouseX, mouseY), getIsoY(mouseX, mouseY), coloruse)
            End If
        Case 1 'Eye Dropper
            If bChangeColor = 1 Then
                openTileEditorDocs(indice).changeColor = tileMem(mouseX + 1, mouseY + 1)
                bChangeColor = 2
                Call changeColor
                Exit Sub
            End If
            
            openTileEditorDocs(indice).currentColor = tileMem(mouseX + 1, mouseY + 1)
            
            'Update the selected color picturebox in TkMainForm
            Call vbPicFillRect(tkMainForm.selectedcolor, 0, 0, 100, 100, openTileEditorDocs(indice).currentColor)
            
            'Change the selected tool
            openTileEditorDocs(indice).tileMode = 0
            Call ToolSet(openTileEditorDocs(indice).tileMode)
        Case 2 'Fill
            Call fillTile(mouseX + 1, mouseY + 1, coloruse)
    End Select
    
    DoEvents

End Sub

'========================================================================
' When you move the mouse in the Tile Editor
'========================================================================
Private Sub tileform_MouseMove(button As Integer, Shift As Integer, X As Single, Y As Single): On Error Resume Next
    'Get current color
    Dim coloruse As Long
    coloruse = openTileEditorDocs(indice).currentColor
    
    'Tileform size in pixels
    Dim tfWidth As Integer, tfHeight As Integer
    tfWidth = (tileform.Width) / Screen.TwipsPerPixelX
    tfHeight = (tileform.height) / Screen.TwipsPerPixelY
        
    'Size of a pixel on the tileform
    Dim pixelWidth, pixelHeight As Integer
    pixelWidth = Round((tfWidth / xRange))
    pixelHeight = (tfHeight / 32)
        
    'Tile pixel co-ordinates (which pixel selected)
    Dim mouseX As Integer, mouseY As Integer
    mouseX = Int(X / pixelWidth)
    mouseY = Int(Y / pixelHeight)
        
    'If a rouge pixel has been selected, Exit Sub
    If mouseX > (xRange - 1) Or mouseY > 31 Then Exit Sub
    
    'Update Co-ordinate label
    tkMainForm.coords.Caption = "(" + toString(mouseX + 1) + "," + toString(mouseY + 1) + ")"
    
    '...?
    If ignore = 1 Then ignore = 0: Exit Sub
    
    'If no mousebutton is clicked, Exit Sub
    If button = 0 Then Exit Sub
    
    mouseX = mouseX * pixelWidth + (pixelWidth / 2)
    mouseY = mouseY * pixelHeight + (pixelHeight / 2)
    
    Dim x1, y1 As Integer
    x1 = Int(dragX1 / pixelWidth) * pixelWidth + (pixelWidth / 2)
    y1 = Int(dragY1 / pixelHeight) * pixelHeight + (pixelHeight / 2)
    
    Call vbPicRefresh(tileform)
    
    'Get the current color
    Dim coluse As Long
    coluse = openTileEditorDocs(indice).currentColor
    If coluse = -1 Then coluse = 0
    
    Select Case openTileEditorDocs(indice).tileMode
        Case 4:
            'Line
            If bDragBegin Then
                tileform.AutoRedraw = False
                Call vbPicLine(tileform, x1, y1, mouseX, mouseY, coluse)
                tileform.AutoRedraw = True
                Exit Sub
            End If
        Case 5, 6:
            '(Filled) Ellipse
            Dim Temp As Integer
            If mouseX < x1 Then
                Temp = x1
                x1 = mouseX
                mouseX = Temp
            End If
            If mouseY < y1 Then
                Temp = y1
                y1 = mouseY
                mouseY = Temp
            End If
    
            Dim cx As Integer, cy As Integer
            Dim rx As Integer, ry As Integer
            Dim rad As Integer, asp As Integer
            
            cx = x1 + ((mouseX - x1) / 2)
            cy = y1 + ((mouseY - y1) / 2)
            rx = mouseX - cx
            ry = mouseY - cy
            rad = rx
            asp = ry / rx

            If bDragBegin Then
                tileform.AutoRedraw = False
                If asp > 1 Then
                    Call vbPicCircle(tileform, cx, cy, rad * asp, coluse, -1, -1, asp)
                Else
                    Call vbPicCircle(tileform, cx, cy, rad, coluse, -1, -1, asp)
                End If
                tileform.AutoRedraw = True
                Exit Sub
            End If
        Case 7, 8:
            '(Filled) Rectangle
            If bDragBegin Then
                tileform.AutoRedraw = False
                Call vbPicRect(tileform, x1, y1, mouseX, mouseY, coluse)
                tileform.AutoRedraw = True
                Exit Sub
            End If
    End Select
    
    Call tileform_MouseDown(button, Shift, X, Y)
    bDragBegin = True
    dragX1 = X
    dragY1 = Y
End Sub

'========================================================================
' When you release the mouse in the Tile Editor
'========================================================================
Private Sub tileform_MouseUp(button As Integer, Shift As Integer, X As Single, Y As Single): On Error Resume Next
    Dim tfWidth As Integer, tfHeight As Integer
    tfWidth = (tileform.Width) / Screen.TwipsPerPixelX
    tfHeight = (tileform.height) / Screen.TwipsPerPixelY
    
    Dim pixelWidth As Integer, pixelHeight As Integer
    pixelWidth = Round((tfWidth / xRange))
    pixelHeight = (tfHeight / 32)
    
    Dim x2 As Integer, y2 As Integer
    Dim x1 As Integer, y1 As Integer
    x2 = Int(X / pixelWidth)
    y2 = Int(Y / pixelHeight)
    x1 = Int(dragX1 / pixelWidth)
    y1 = Int(dragY1 / pixelHeight)
    
    If bDragBegin Then
        bDragBegin = False
        Select Case openTileEditorDocs(indice).tileMode
            Case 4 'Line
                Call tileAddShape(x1 + 1, y1 + 1, x2 + 1, y2 + 1, 5)
            Case 5 'Ellipse
                Call tileAddShape(x1 + 1, y1 + 1, x2 + 1, y2 + 1, 4)
            Case 6 'Filled Ellipse
                Call tileAddShape(x1 + 1, y1 + 1, x2 + 1, y2 + 1, 3)
            Case 7 'Rectangle
                Call tileAddShape(x1 + 1, y1 + 1, x2 + 1, y2 + 1, 2)
            Case 8 'Filled Rectangle
                Call tileAddShape(x1 + 1, y1 + 1, x2 + 1, y2 + 1, 1)
        End Select
    End If
End Sub

'========================================================================
' Check if the file has changed an it needs to be saved
'========================================================================
Public Sub checkSave(): On Error GoTo ErrorHandler
    If openTileEditorDocs(indice).tileNeedUpdate = True Then
        If MsgBox(LoadStringLoc(939, "Would you like to save your changes to the current file?"), vbYesNo) = 6 Then Call saveFile
    End If

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

'========================================================================
' Saves the file
'========================================================================
Public Sub saveFile(): On Error GoTo ErrorHandler
    
    filename(2) = openTileEditorDocs(indice).tileName
    openTileEditorDocs(indice).tileNeedUpdate = False
    If filename(2) = "" Then
        Call Show
        Call savenoquestions_Click
        Exit Sub
    End If
    'Save the tile
    Call saveTile(projectPath & tilePath & filename(2))

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

'========================================================================
' Opens the file
'========================================================================
Public Sub openFile(ByVal file As String): On Error Resume Next

    Set activeTile = Me

    lockIndice = indice
    useLockIndice = True

    Call Show
    Call ChDir(currentDir)
    ignoreDeactivate = True
    
    If tag <> 1 Then Call checkSave      'Check if a tile is already open and needs saving.
    openTileEditorDocs(indice).tileNeedUpdate = False
    
    Dim antiPath As String
    filename(1) = file
    antiPath = absNoPath(file)
    
    Call FileCopy(filename(1), projectPath & tilePath & antiPath)

    Dim whichType As String
    whichType = GetExt(filename(1))
    
    If UCase(whichType) = "ISO" Then
        'Set the mode to isometric.
        activeTile.isoChange (True)
    Else
        activeTile.isoChange (False)
    End If
    
    If UCase(whichType) = "TST" Or UCase(whichType) = "ISO" Then
        'Yipes! we've selected an archive!
    
        tstnum = 0
        
        configfile.lastTileset = antiPath
        tstFile = antiPath

        Call Hide
        Call redrawAllTiles
        Call tilesetform.Show(vbModal)             'Show the tileset browser.
        Call Show
        Set activeTile = Me
        DoEvents

        'setFilename created in tilesetform. Contains the tilenumber.
        If setFilename = "" Then
            useLockIndice = False
            Call redrawAllTiles
            Exit Sub
        End If

        Call openFromTileSet(projectPath & tilePath & tilesetFilename(setFilename), getTileNum(setFilename))

        If detail = 2 Or detail = 4 Or detail = 6 Then
            'only 32x32 tiles allowed
            Call increaseDetail
        End If
        Call color_16million
        
        'Now we need to rearrange the pixels in the tilemem from 32x32 to 62x32
        
        If UCase(whichType$) = "ISO" Then
            Dim xCount As Byte, yCount As Byte, X As Integer, Y As Integer
            xCount = 1: yCount = 1
        
            'Now we need to form the 32x32 tile into a 64x32 in tilemem:
            
            'Temporarily hold tilemem in the buffer.
            Dim xx As Long, yy As Long
            For xx = 1 To 32
                For yy = 1 To 32
                    bufTile(xx, yy) = tileMem(xx, yy)
                Next yy
            Next xx
            
            For xx = 1 To 64
                For yy = 1 To 32
                                
                    If isoMaskBmp(xx, yy) <> RGB(0, 0, 0) Then
                        'Masked pixel.
                        tileMem(xx, yy) = -1
                    Else
                        'Unmasked pixel.
                        tileMem(xx, yy) = bufTile(xCount, yCount)
                                            
                        'Increment the tilemem entry.
                        yCount = yCount + 1
                        If yCount > 32 Then
                            xCount = xCount + 1
                            yCount = 1
                        End If
                    End If
                Next yy
            Next xx
        End If '(whichtype$ = "ISO")
        
        Call highRedraw
        
        openTileEditorDocs(indice).tileName = setFilename
        Caption = LoadStringLoc(801, "Tile Editor") & "  (" & setFilename & ")"

    Else
        '.gph

        DoEvents
        Call openTile2(filename(1))
        Call highRedraw
        openTileEditorDocs(indice).tileName = antiPath
        Caption = LoadStringLoc(801, "Tile Editor") & "  (" & antiPath & ")"

    End If

    Call tileGrid(tkMainForm.tileGrid.value)

    useLockIndice = False
    Call redrawAllTiles

End Sub

'========================================================================
' Opens a tile
'========================================================================
Public Sub opentile_Click(): On Error Resume Next
    Call ChDir(currentDir)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath & tilePath

    dlg.strTitle = "Open Tile"
    dlg.strDefaultExt = "tst"
    dlg.strFileTypes = "Supported Files|*.gph;*.tst;*.iso|RPG Toolkit TileSet (*.tst)|*.tst|RPG Toolkit Tile (*.gph)|*.gph|RPG Toolkit Isometric TileSet (*.iso)|*.iso|All files(*.*)|*.*"
    
    Dim antiPath As String
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename(1) = dlg.strSelectedFile
        antiPath = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If

    Call ChDir(currentDir$)


    If filename(1) = "" Then Exit Sub
    Call FileCopy(filename(1), projectPath & tilePath & antiPath)
    Dim whichType As String
    whichType = GetExt(filename(1))

    If UCase(whichType) = "ISO" Then
        'Set the mode to isometric.
        tkMainForm.tileIsoCheck.value = 1
    Else
        tkMainForm.tileIsoCheck.value = 0
    End If

    If UCase(whichType) = "TST" Or UCase(whichType) = "ISO" Then      'Yipes! we've selected an archive!
        tstnum = 0
        tstFile = antiPath
        configfile.lastTileset = tstFile
        
        ignoreDeactivate = True
        Call tilesetform.Show(vbModal)
        If setFilename$ <> "" Then
        
            Call openFromTileSet(projectPath$ + tilePath$ + tilesetFilename(setFilename$), getTileNum(setFilename$))
            
            If detail = 2 Or detail = 4 Or detail = 6 Then
                'only 32x32 tiles allowed
                Call increaseDetail
            End If
            Call color_16million
            Call highRedraw
            openTileEditorDocs(indice).tileName = setFilename
            Caption = LoadStringLoc(801, "Tile Editor") + "  (" + setFilename$ + ")"
        End If
    Else
        Call openTile2(filename$(1))
        Call highRedraw
        openTileEditorDocs(indice).tileName = antiPath$
        Caption = LoadStringLoc(801, "Tile Editor") + "  (" + antiPath$ + ")"
    End If
    Call tileGrid(tkMainForm.tileGrid.value)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

'========================================================================
' File Menu
'========================================================================

'New Project
Private Sub mnunewproject_Click()
    On Error Resume Next
    Call tkMainForm.newprojectmnu_Click
End Sub

'New Tile
Private Sub mnunewtile_Click()
    On Error Resume Next
    Call tkMainForm.newtilemnu_Click
End Sub

'New Animated Tile
Private Sub mnunewanimatedtile_Click()
    On Error Resume Next
    Call tkMainForm.newanimtilemnu_Click
End Sub

'New Board
Private Sub mnunewboard_Click()
    On Error Resume Next
    Call tkMainForm.newboardmnu_Click
End Sub

'New Player
Private Sub mnunewplayer_Click()
    On Error Resume Next
    Call tkMainForm.newplayermnu_Click
End Sub

'New Item
Private Sub mnunewitem_Click()
    On Error Resume Next
    Call tkMainForm.newitemmnu_Click
End Sub

'New Enemy
Private Sub mnunewenemy_Click()
    On Error Resume Next
    Call tkMainForm.newenemymnu_Click
End Sub

'New RpgCode Program
Private Sub mnunewrpgcodeprogram_Click()
    On Error Resume Next
    Call tkMainForm.newrpgcodemnu_Click
End Sub

'New Fight Background
Private Sub mnuNewFightBackground_Click()
    On Error Resume Next
    Call tkMainForm.mnuNewFightBackground_Click
End Sub

'New Special Move
Private Sub mnunewspecialmove_Click()
    On Error Resume Next
    Call tkMainForm.newspecialmovemnu_Click
End Sub

'New Status Effect
Private Sub mnunewstatuseffect_Click()
    On Error Resume Next
    Call tkMainForm.newstatuseffectmnu_Click
End Sub

'New Animation
Private Sub mnunewanimation_Click()
    On Error Resume Next
    Call tkMainForm.newanimationmnu_Click
End Sub

'New Tile Bitmap
Private Sub mnunewtilebitmap_Click()
    On Error Resume Next
    Call tkMainForm.newtilebitmapmnu_Click
End Sub

'Open Project
Private Sub mnuOpenProject_Click()
    On Error Resume Next
    Call tkMainForm.mnuOpenProject_Click
End Sub

'Open File
Private Sub mnuopen_Click()
    On Error Resume Next
    Call tkMainForm.openmnu_Click
End Sub

'Save Tile
Private Sub savenoquestions_Click()
    On Error GoTo ErrorHandler
    
    'If this in an new (untitled) tile.
    If openTileEditorDocs(indice).tileName = "" Then
        savetile2_Click                 'The "Save Tile As..." sub.
        Exit Sub
    End If
    
    'Else, the tile was opened, so update the file.
    Call saveTile(projectPath$ + tilePath$ + openTileEditorDocs(indice).tileName)
    openTileEditorDocs(indice).tileNeedUpdate = False
    
    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

'=======================================================================================
'File -> Save Tile As...
'=======================================================================================
Private Sub savetile2_Click(): On Error Resume Next
    ChDir (currentDir$)
    
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + tilePath$
    dlg.strTitle = "Save Tile As"
    
    'New support for isometric tilesets, .iso.
    
    If openTileEditorDocs(indice).isometric Then
        'If the global control boolean is set in the tile editor.
    
        dlg.strDefaultExt = "iso"
        'An isometric single tile has not been defined.
        dlg.strFileTypes = "Supported Types|*.iso|RPG Toolkit Isometric TileSet (*.iso)|All files(*.*)|*.*"
    Else
        dlg.strDefaultExt = "tst"
        dlg.strFileTypes = "Supported Types|*.tst;*.gph|RPG Toolkit TileSet (*.tst)|*.tst|RPG Toolkit Tile (*.gph)|*.gph|All files(*.*)|*.*"
    End If
    
    If SaveFileDialog(dlg, Me.hwnd) Then
        filename$(1) = dlg.strSelectedFile
        Dim antiPath As String
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub            'User pressed cancel.
    End If
    
    ChDir (currentDir$)
    openTileEditorDocs(indice).tileNeedUpdate = False
    
    If filename$(1) = "" Then Exit Sub
    
    'Shall we see if it's an archive?
    'whichType$ = extention(filename$(1))
    
    Dim whichType As String
    whichType$ = GetExt(filename$(1))   'Fix... wasn't working for me (Delano).
    
    If UCase$(whichType$) = "TST" Or UCase$(whichType$) = "ISO" Then      'Yipes! we've selected an archive!
        
        tstnum = 0
        'Altered to handle isometric.
        Dim a As Integer
        a = tilesetInfo(filename$(1))
        
        
        If a = TSTTYPE Or a = ISOTYPE Then
            Dim aa As Long
            aa = addToTileSet(filename(1))
            If aa > 0 Then
                'MsgBox LoadStringLoc(2019, "Your tile has been added to the tileset")
                MsgBox ("Your tile has been added to the tileset: tile number " & aa & " in " & chr$(13) & filename(1) & ".")
                openTileEditorDocs(indice).tileName = antiPath$ + toString(aa)
                Caption = LoadStringLoc(801, "Tile Editor") + " (" + openTileEditorDocs(indice).tileName + ")"
            End If
        Else
            'Note new argument!
            aa = createNewTileSet(filename$(1), openTileEditorDocs(indice).isometric)
            If aa > 0 Then
                'MsgBox LoadStringLoc(2019, "Your tile has been added to the tileset")
                MsgBox ("A new tileset has been created: " & chr$(13) & filename$(1) & chr$(13) & " and the first tile added.")
                openTileEditorDocs(indice).tileName = antiPath$ + "1"
                Caption = LoadStringLoc(801, "Tile Editor") + " (" + openTileEditorDocs(indice).tileName + ")"
            End If
        End If
        
    Else
    
        '.gph
        If fileExists(filename(1)) Then
            Dim bb As VbMsgBoxResult
            bb = MsgBox(LoadStringLoc(949, "That file exists.  Are you sure you want to overwrite it?"), vbYesNo)
            If bb = vbNo Then Exit Sub
        End If
        Call saveTile(filename(1))
        openTileEditorDocs(indice).tileName = antiPath
        Caption = LoadStringLoc(801, "Tile Editor") + " (" + antiPath$ + ")"
        
    End If 'tst, iso.
    
    Call tkMainForm.fillTree("", projectPath)
End Sub

'==========================================================================================
'File -> Save into tileset
'==========================================================================================
Private Sub mnusts_Click(): On Error Resume Next
    ChDir (currentDir$)
    
    
    'Set up the save dialog window
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + tilePath$
    dlg.strTitle = "Save Into Tileset"
    
    If openTileEditorDocs(indice).isometric Then
        dlg.strDefaultExt = "iso"
        dlg.strFileTypes = "Supported Types|*.iso|RPG Toolkit Isometric TileSet (*.iso)|*.iso|All files(*.*)|*.*"
    Else
        dlg.strDefaultExt = "tst"
        dlg.strFileTypes = "Supported Types|*.tst|RPG Toolkit TileSet (*.tst)|*.tst|All files(*.*)|*.*"
    End If
    
    If SaveFileDialog(dlg, Me.hwnd) Then
        filename$(1) = dlg.strSelectedFile
        Dim antiPath As String
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub    'user pressed cancel
    End If
    
    ChDir (currentDir$)
    
    openTileEditorDocs(indice).tileNeedUpdate = False
    
    If filename$(1) = "" Then Exit Sub
    
    'Shouldn't need all this since the dialog window won't allow you to save as anything
    'other than the default type.
    
    tstnum = 0
    'Altered to handle isometric.
    Dim a As Long
    a = tilesetInfo(filename$(1))
    
    If a = TSTTYPE Or a = ISOTYPE Then
        'The header could be read.
    
        tstFile$ = antiPath$
        configfile.lastTileset$ = tstFile$
        
        openTileEditorDocs(indice).bAllowExtraTst = True    'Allow insertion onto end of tileset.
        ignoreDeactivate = True
        
        tilesetform.Show vbModal
        openTileEditorDocs(indice).bAllowExtraTst = False
        
        If setFilename$ = "" Then Exit Sub

        Dim tNum As Long
        tNum = getTileNum(setFilename$)     'Extract the number from the end of the set.
        
        If tNum > tileset.tilesInSet Then
            'If the selected tile is greater than the last tile number, add to end.
        
            Dim aa As Long
            aa = addToTileSet(filename$(1))
            'MsgBox "Your tile has been added to the tileset", , "Save into tileset"
            openTileEditorDocs(indice).tileName = antiPath$ + toString(tNum)
            Caption = LoadStringLoc(801, "Tile Editor") + " (" + openTileEditorDocs(indice).tileName$ + ")"
            
        Else
            'Insert at the position indicated - overwrite the tile at that position!
            
            Dim result As VbMsgBoxResult
            result = MsgBox("Warning! This will overwrite the tile at that position!", vbOKCancel)
            If result = vbCancel Then Exit Sub
            openTileEditorDocs(indice).tileName$ = setFilename$
            Call insertIntoTileSet(projectPath$ + tilePath$ + tilesetFilename(setFilename$), getTileNum(setFilename$))
            Caption = LoadStringLoc(801, "Tile Editor") + " (" + openTileEditorDocs(indice).tileName$ + ")"
        End If
        
    Else
        'Header couldn't be read - set doesn't exist.
    
        aa = createNewTileSet(filename$(1), openTileEditorDocs(indice).isometric)
        If aa > 0 Then
            'MsgBox LoadStringLoc(2019, "Your tile has been added to the tileset")
            MsgBox ("A new tileset has been created: " & chr$(13) & filename$(1) & chr$(13) & " and the first tile added.")
            openTileEditorDocs(indice).tileName = antiPath$ + "1"
            Caption = LoadStringLoc(801, "Tile Editor") + " (" + openTileEditorDocs(indice).tileName$ + ")"
        End If
        
    End If

End Sub

'Save All
Private Sub mnusaveall_Click()
    On Error Resume Next
    Call tkMainForm.saveallmnu_Click
End Sub

'Close
Private Sub exit_Click()
    On Error GoTo ErrorHandler
    Call Hide

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

'Exit
Private Sub mnuexit_Click()
    On Error Resume Next
    Call tkMainForm.exitmnu_Click
End Sub

'========================================================================
' Edit Menu
'========================================================================

'Undo
Private Sub undotilemenu_Click()
    Call getUndo
End Sub

'Cut Corner
Private Sub cutcornermnu_Click()
    On Error GoTo ErrorHandler
    ignoreDeactivate = True
    cutcorner.Show vbModal ', me

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

'Skew
Private Sub mnuSkew_Click()
    On Error GoTo ErrorHandler
    ignoreDeactivate = True
    Skew.Show vbModal ', me

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

'Clear
Private Sub cmdClear_Click()
    'Undo
    Call setUndo

    Dim X As Integer, Y As Integer
    For X = 1 To xRange
        For Y = 1 To 32
            tileMem(X, Y) = -1
        Next Y
    Next X

    'Redraw
    Call tileRedraw

End Sub

'Rotate Left
Private Sub mnuRotate90CCW_Click()
    Rotate Left
End Sub

'Rotate Right
Private Sub mnuRotate90CW_Click()
    Rotate Right
End Sub

'Rotate 180
Private Sub mnuRotate180_Click()
    Rotate OneHundredEighty
End Sub

'Flip Horizontal
Private Sub mnuFlipHor_Click()
    Flip Horizontal
End Sub

'Flip Vertical
Private Sub mnuFlipVer_Click()
    Flip Vertical
End Sub

'========================================================================
' Image Menu
'========================================================================
'Import
Public Sub convert_Click()
    On Error GoTo ErrorHandler
    ignoreDeactivate = True
    import.Show vbModal ', me

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

'Layer Tile
Private Sub layer_Click()
    On Error GoTo ErrorHandler
    ignoreDeactivate = True
    layertile.Show vbModal ', me

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

'Grab Tile
Private Sub gtilemnu_Click()
    On Error GoTo ErrorHandler
    ignoreDeactivate = True
    grab.Show vbModal ', me

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

'Color
Public Sub scolormnu_Click()
    On Error GoTo ErrorHandler
    openTileEditorDocs(indice).currentColor = ColorDialog()
    Call vbPicFillRect(tkMainForm.selectedcolor, 0, 0, 100, 100, openTileEditorDocs(indice).currentColor)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

'DOS Color
Public Sub mnuDOS_Click()
    On Error GoTo ErrorHandler
    ignoreDeactivate = True
    Version1Palette.Show vbModal

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

'Shade Tile
Public Sub shadetle_Click()
    On Error GoTo ErrorHandler
    ignoreDeactivate = True
    RGBDefine.Show vbModal

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

'Grayscale
Public Sub gryscle_Click()
    On Error Resume Next
   
    'Undo
    Call setUndo
   
    Dim X As Integer, Y As Integer
    Dim rr As Long, gg As Long, bb As Long, newavg As Long

    'Start converting
    For X = 1 To xRange
        For Y = 1 To 32
            If tileMem(X, Y) <> -1 Then
                rr = red(tileMem(X, Y))
                gg = green(tileMem(X, Y))
                bb = blue(tileMem(X, Y))
                newavg = (rr + gg + bb) / 3
                If newavg > 255 Then newavg = 255
                If newavg < 0 Then newavg = 0
                tileMem(X, Y) = RGB(newavg, newavg, newavg)
            End If
        Next Y
    Next X
    'Redraw
    Call tileRedraw
End Sub

'========================================================================
' Draw Menu
'========================================================================

'Grid
Private Sub mnuGrid_Click()
    If tkMainForm.tileGrid.value = 0 Then tkMainForm.tileGrid.value = 1 Else tkMainForm.tileGrid.value = 0
    Call tileGrid(tkMainForm.tileGrid.value)
End Sub

'Pencil
Private Sub mnuPencil_Click()
    openTileEditorDocs(indice).tileMode = 0
    Call ToolSet(openTileEditorDocs(indice).tileMode)
End Sub

'Color Capture
Private Sub mnuColorCap_Click()
    openTileEditorDocs(indice).tileMode = 1
    Call ToolSet(openTileEditorDocs(indice).tileMode)
End Sub

'Flood Fill
Private Sub mnuFloodfill_Click()
    openTileEditorDocs(indice).tileMode = 2
    Call ToolSet(openTileEditorDocs(indice).tileMode)
End Sub

'Eraser
Private Sub mnuEraser_Click()
    openTileEditorDocs(indice).tileMode = 3
    Call ToolSet(openTileEditorDocs(indice).tileMode)
End Sub

'========================================================================
' Effects Menu
'========================================================================

'Blur
Private Sub blurmnu_Click()
    On Error GoTo ErrorHandler
    
    'Undo
    Call setUndo
    
    Dim X, Y As Integer
    Dim aa As Long
    Dim r As Long, g As Long, b As Long
    Dim r2 As Long, g2 As Long, b2 As Long
    Dim nr As Long, ng As Long, nb As Long
    'Start blurring
    For X = 1 To xRange
        For Y = 1 To 32
        
            aa = tileMem(X, Y)
            If aa = -1 Then aa = vbQBColor(15)
            r = red(aa) / 2
            aa = tileMem(X, Y)
            If aa = -1 Then aa = vbQBColor(15)
            g = green(aa) / 2
            aa = tileMem(X, Y)
            If aa = -1 Then aa = vbQBColor(15)
            b = blue(aa) / 2
            If X = xRange Then
                aa = tileMem(1, Y)
                If aa = -1 Then aa = vbQBColor(15)
            Else
                aa = tileMem(X + 1, Y)
                If aa = -1 Then aa = vbQBColor(15)
            End If
            r2 = red(aa) / 2
            If X = xRange Then
                aa = tileMem(1, Y)
                If aa = -1 Then aa = vbQBColor(15)
            Else
                aa = tileMem(X + 1, Y)
                If aa = -1 Then aa = vbQBColor(15)
            End If
            g2 = green(aa) / 2
            If X = xRange Then
                aa = tileMem(1, Y)
                If aa = -1 Then aa = vbQBColor(15)
            Else
                aa = tileMem(X + 1, Y)
                If aa = -1 Then aa = vbQBColor(15)
            End If
            b2 = blue(aa) / 2
            nr = inBounds(r + r2, 0, 255)
            ng = inBounds(g + g2, 0, 255)
            nb = inBounds(b + b2, 0, 255)
            If X = xRange Then
                tileMem(1, Y) = RGB(nr, ng, nb)
            Else
                tileMem(X + 1, Y) = RGB(nr, ng, nb)
            End If
        Next Y
    Next X
    'Redraw
    Call tileRedraw

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

'Light Source
Private Sub lsrc_Click()
    On Error GoTo ErrorHandler
    ignoreDeactivate = True
    light.Show vbModal ', me

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

'Texturize
Public Sub mnuTexturize_Click()
    On Error GoTo ErrorHandler
    ignoreDeactivate = True
    tiletexturize.Show vbModal

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

'Translucentize
Private Sub mnuTranslucentize_Click()
    On Error GoTo ErrorHandler
    ignoreDeactivate = True
    tileTranslucentize.Show vbModal

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

'========================================================================
' Toolkit Menu
'========================================================================

'Test Game
Private Sub mnutestgame_Click()
    On Error Resume Next
    tkMainForm.testgamemnu_Click
End Sub

'Select Language
Private Sub mnuselectlanguage_Click()
    On Error Resume Next
    Call tkMainForm.selectlanguagemnu_Click
End Sub

'Install Upgrade
Private Sub mnuinstallupgrade_Click()
    On Error Resume Next
    Call tkMainForm.installupgrademnu_Click
End Sub

'========================================================================
' Build Menu
'========================================================================

'Pakfile
Private Sub mnucreatepakfile_Click()
    On Error Resume Next
    Call tkMainForm.createpakfilemnu_Click
End Sub

'EXE
Private Sub mnumakeexe_Click()
    On Error Resume Next
    Call tkMainForm.makeexemnu_Click
End Sub

'Setup
Private Sub mnucreatesetup_Click()
    On Error Resume Next
    Call tkMainForm.createsetupmnu_Click
End Sub

'========================================================================
' Window Menu
'========================================================================

'Show/Hide Tools
Private Sub mnushowtools_Click()
    On Error Resume Next
    Call tkMainForm.showtoolsmnu_Click
End Sub

'Show/Hide Project List
Private Sub mnushowprojectlist_Click()
    On Error Resume Next
    Call tkMainForm.showprojectlistmnu_Click
End Sub

'Tile Horizontally
Private Sub mnutilehorizontally_Click()
    On Error Resume Next
    Call tkMainForm.tilehorizonatllymnu_Click
End Sub

'Tile Vertically
Private Sub mnutilevertically_Click()
    On Error Resume Next
    Call tkMainForm.tileverticallymnu_Click
End Sub

'Cascade
Private Sub mnuCascade_Click()
    On Error Resume Next
    Call tkMainForm.cascademnu_Click
End Sub

'Arrange Icons
Private Sub mnuArrangeIcons_Click()
    On Error Resume Next
    Call tkMainForm.arrangeiconsmnu_Click
End Sub

'========================================================================
' Help Menu
'========================================================================

'Users Guide
Private Sub mnuusersguide_Click()
    On Error Resume Next
    Call tkMainForm.usersguidemnu_Click
End Sub

'RpgCode Primer
Private Sub mnuRPGCodePrimer_Click()
    On Error Resume Next
    Call tkMainForm.rpgcodeprimermnu_Click
End Sub

'RpgCode Reference
Private Sub mnurpgcodereference_Click()
    On Error Resume Next
    Call tkMainForm.rpgcodereferencemnu_Click
End Sub

'Tutorial
Private Sub mnuTutorial_Click()
    On Error Resume Next
    Call tkMainForm.tutorialmnu_Click
End Sub

'History.txt
Private Sub mnuHistorytxt_Click()
    On Error Resume Next
    Call tkMainForm.historytxtmnu_Click
End Sub

'Registration Info
Private Sub mnuRegistrationInfo_Click()
    On Error Resume Next
    Call tkMainForm.registrationinfomnu_Click
End Sub

'About
Private Sub mnuAbout_Click()
    On Error Resume Next
    Call tkMainForm.aboutmnu_Click
End Sub

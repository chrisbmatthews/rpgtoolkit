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
'Option Explicit

'//===================================================
'// Additions for new isometric tilesets.
'// Delano 20/06/04 for 3.0.4
'
'  Buftile(32,32) is the temporary buffer for tile deforming. The tilemem
'       is transferred to buftile, the transformation made, then buftile
'       transferred to the tilemem.
'
'Public isIsoTile As Boolean

'Private yRange As Integer
Private xMod As Byte     '= 2 for isometric, 1 for 2D
                        
'       Changes are required or have been made in the following subs.
'       Filetype updates:
'   openFile            - no changes
'   mnusts_Click        - no changes
'   opentile_Click
'   savetile2_Click
'   savetile_Click      - needs updating for tsts?

'       Drawing updates:
'   form_load, _activate, _deactivate, _resize
'   highredraw
'   drawGrid
'   tileform_mousedown, _mousemove, _mouseup
'   fillTile
'   tileaddfill         - this doesn't appear to be used in the project
'   tileAddFilledRect
'   tileAddRect
'   tileAddLine

'========================================================================
' variable declaration
'========================================================================

'publictile.grid, On or Off?
Private GridOff As Boolean

'Have we begun dragging?
Private bDragBegin As Boolean

'Same as bDragBegin, but only used for a few tools
Private bDragBeginPaint As Boolean

'Initial x and y coords if drag
Private dragX1 As Integer, dragY1 As Integer

'Last tool selected.
Private lastTool As Integer

'Stored data
Private theData As tileDoc

'Ignore reactivation action
Public ignoreDeactivate As Boolean

'!NEW! For the changecolor function
Private bchangecolor As Integer

'========================================================================
' Enum declaration [KSNiloc]
'========================================================================

Private Enum FLIP_TYPE
    Horizontal = 1
    Vertical = 2
End Enum

Private Enum ROTATE_TYPE
    Left = 1
    Right = 2
    OneHunderdEighty = 3
End Enum

Private fromActivate As Boolean

'========================================================================
' Identify type of form
'========================================================================
Public Function formType() As Long
    On Error Resume Next
    formType = FT_TILE
End Function
'========================================================================
' Change the tile editor to isometric mode (NEW for 3.0.4 by Delano)
'========================================================================
Public Sub isoChange(ByVal isoCheck As Boolean)
    On Error Resume Next
    
    'Here we change from normal to isometric mode.
    'If we have a .iso open, will drop into isometric mode.
    'If a .tst/.gph is open, will drop into normal mode.
    'Changing .iso -> .tst calls an error msg - not possible!
    If fromActivate And isoCheck = theData.isometric Then Exit Sub

    If isoCheck Then
        If publicTile.tileneedupdate Then
            Dim result As Byte
            result = MsgBox("Conversion to a .iso isometric tile is permanent! Note you can still use .tst tiles" _
                & " on isometric boards without having to convert to .iso. Do you wish to continue?", vbOKCancel + vbExclamation, "Isometric Mode")
            If result = vbCancel Then
                tkMainForm.tileIsoCheck.value = 0
                Exit Sub
            End If
        End If
        
        'Clear the tilename.
        publicTile.tileName$ = ""
        activeTile.Caption = LoadStringLoc(801, "Tile Editor") + "  (Untitled)"
        
        'Isometric check button is depressed - isometric mode.
        isIsoTile = True        'Control boolean.
        xRange = 64             'Loop ranger.
        theData.isometric = True
        xMod = 2
        
        'Convert the tilemem to isometric through the rotation code, and store it
        'in the buffer tile.
        Call tstToIsometric
        
        'Copy the buffer tile into tilemem.
        Dim X As Integer, Y As Integer
        For X = 0 To 64
            For Y = 0 To 32
                tilemem(X + 1, Y + 1) = buftile(X, Y)
            Next Y
        Next X
        
        tkMainForm.isoMirror.BorderStyle = 0
        'Unenable some stuff
        mnuRotate.Enabled = False
        cutcornermnu.Enabled = False
        mnuSkew.Enabled = False
        convert.Enabled = False
        layer.Enabled = False
        lsrc.Enabled = False
        tkMainForm.cmdImport.Enabled = False
        tkMainForm.Command15.Enabled = False
        tkMainForm.Command16.Enabled = False
        tkMainForm.Command18.Enabled = False
        tkMainForm.Command19.Enabled = False
        'Make the normal tile preview picturebox in TkMainForm white
        Call vbPicFillRect(tkMainForm.mirror, 0, 0, 100, 100, vbQBColor(15))
    Else
        'isoCheck = 0
        If publicTile.tileneedupdate Then
            result = MsgBox("Conversion from isometric to 2D is not possible. The current tile will be erased. Do you wish to continue?", vbOKCancel + vbExclamation, "Isometric Mode")
            If result = vbCancel Then
                tkMainForm.tileIsoCheck.value = 1
                Exit Sub
            End If
        End If
        
        'Clear the tilemem data.
        For X = 0 To 64
            For Y = 0 To 32
                tilemem(X, Y) = -1
            Next Y
        Next X
        
        'Clear the tilename.
        publicTile.tileName$ = ""
        activeTile.Caption = LoadStringLoc(801, "Tile Editor") + "  (Untitled)"
        
        isIsoTile = False
        xRange = 32
        theData.isometric = False
        xMod = 1
        
        tkMainForm.isoMirror.BorderStyle = 1
        'Enable some stuff
        mnuRotate.Enabled = True
        cutcornermnu.Enabled = True
        mnuSkew.Enabled = True
        convert.Enabled = True
        layer.Enabled = True
        lsrc.Enabled = True
        tkMainForm.cmdImport.Enabled = True
        tkMainForm.Command15.Enabled = True
        tkMainForm.Command16.Enabled = True
        tkMainForm.Command18.Enabled = True
        tkMainForm.Command19.Enabled = True
        'MsgBox "Here"
        tkMainForm.isoMirror.cls
    End If
    'Re-draw/size
    Call Form_Resize
End Sub
'========================================================================
' This sets the color to transparant
'========================================================================
Public Sub Command1_Click()
    On Error GoTo ErrorHandler
    'Set the current color to transparent
    publicTile.currentColor = -1
    'Draw the transparent thingy
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
' Scroll (NEW for 3.0.4 by Woozy)
'========================================================================
Public Sub Scroll(how As Integer): On Error Resume Next
    'How: 1 - North
    '     2 - East
    '     3 - South
    '     4 - West
    'Use new undo
    'Call SetUndo
    
    Dim xx As Integer, yy As Integer
    
    Select Case how
        Case 1 'North
            For xx = 1 To xRange
                For yy = 1 To 32 - 1
                    buftile(xx, yy) = tilemem(xx, yy + 1)
                Next yy
            Next xx
        
            For xx = 1 To xRange
                buftile(xx, 32) = tilemem(xx, 1)
            Next xx
        Case 2 'East
            For xx = 1 To xRange
                For yy = 1 To 32
                    buftile(xx, yy) = tilemem(xx - 1, yy)
                Next yy
            Next xx
            
            For yy = 1 To 32
                buftile(1, yy) = tilemem(xRange, yy)
            Next yy
        Case 3 'South
            For xx = 1 To xRange
                For yy = 1 To 32
                    buftile(xx, yy) = tilemem(xx, yy - 1)
                Next yy
            Next xx
        
            For xx = 1 To xRange
                buftile(xx, 1) = tilemem(xx, 32)
            Next xx
        Case 4 'West
            For xx = 1 To xRange - 1
                For yy = 1 To 32
                    buftile(xx, yy) = tilemem(xx + 1, yy)
                Next yy
            Next xx
            
            For yy = 1 To 32
                buftile(xRange, yy) = tilemem(1, yy)
            Next yy
    End Select
    
    'Change the tile
    For xx = 1 To xRange
        For yy = 1 To 32
            tilemem(xx, yy) = buftile(xx, yy)
        Next yy
    Next xx
    
    'Redraw
    Call tileRedraw
End Sub
'========================================================================
' Rotates the tile, I've edited this sub for the new rotate's, and
' renamed the sub (EDIT for 3.0.4 by Woozy)
'========================================================================
'KSNiloc: Enum please
Private Sub Rotate(ByVal how As ROTATE_TYPE)
   
    'Use new undo
    Call SetUndo

    'KSNiloc: No evil variants, please
    Dim X As Integer, Y As Integer, xx As Integer, yy As Integer
   
    'Buff it
    For X = 1 To 32
        For Y = 1 To 32
            buftile(X, Y) = tilemem(X, Y)
        Next Y
    Next X
   
    'Reset variables
    yy = 1: xx = 1
   
    'Start changing the tiles
    Select Case how
        Case Left 'KSNiloc
            For X = 1 To 32
                For Y = 32 To 1 Step -1
                    tilemem(X, Y) = buftile(xx, yy)
                    xx = xx + 1
                Next Y
                xx = 1
                yy = yy + 1
            Next X
        Case Right 'KSNiloc
            For X = 32 To 1 Step -1
                For Y = 1 To 32
                    tilemem(X, Y) = buftile(xx, yy)
                    xx = xx + 1
                Next Y
                xx = 1
                yy = yy + 1
            Next X
        Case OneHundredEighty 'KSNiloc
            For Y = 32 To 1 Step -1
                For X = 32 To 1 Step -1
                    tilemem(X, Y) = buftile(xx, yy)
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
' Flips the tile, I've edited this sub for the new flip, and renamed
' the sub (EDIT for 3.0.4 by Woozy)
'========================================================================
'KSNiloc: Enum please
Private Sub Flip(ByVal how As FLIP_TYPE)
   
    'Use new undo
    Call SetUndo
   
    'KSNiloc: No evil variants, please
    Dim X As Integer, Y As Integer
   
    For X = 1 To 32
        For Y = 1 To 32
            'Edited for the new flip
            If how = Horizontal Then '[KSNiloc]
                buftile(X, Y) = tilemem(32 - X + 1, Y)
            Else 'Vertical
                buftile(X, Y) = tilemem(X, 32 - Y + 1)
            End If
        Next Y
    Next X
   
    For X = 1 To 32
        For Y = 1 To 32
            tilemem(X, Y) = buftile(X, Y)
        Next Y
    Next X
   
    'Redraw
    Call tileRedraw
End Sub
'========================================================================
' Put the tile in the good undo (NEW for 3.0.4 by Woozy)
' Planning to edit this later on for multiple undo's - I had already done
' this for 3.0.4, but they were giving to much problems and I couldn't find
' the time to fix this for 3.0.4. It'll be here in 3.0.5 (or 3.1, hopefully =P)
'========================================================================
Public Sub SetUndo()
    Dim X As Integer, Y As Integer
    
    For X = 1 To xRange
        For Y = 1 To 32
            publicTile.Undotile(X, Y) = tilemem(X, Y)
        Next Y
    Next X
End Sub
'========================================================================
' This gets the info from the undo and changes the tile back (NEW for 3.0.4 by Woozy)
'(Taken out for now. The sub is used, but only for 1 undo (like before))
'========================================================================
Public Sub GetUndo()
    'ReDim the variable
    ReDim bufundo(64, 32)
    Dim X As Integer, Y As Integer
    
    For X = 1 To xRange
        For Y = 1 To 32
            bufundo(X, Y) = tilemem(X, Y)
            tilemem(X, Y) = publicTile.Undotile(X, Y)
            publicTile.Undotile(X, Y) = bufundo(X, Y)
        Next Y
    Next X

    'Redraw
    Call tileRedraw
End Sub
'========================================================================
' Tile Tools
'========================================================================
'Fill (EDIT for 3.0.4 by Delano)
Private Sub fillTile(ByVal X As Long, ByVal Y As Long, ByVal crColor As Long, Optional ByVal lastX As Long = -1, Optional ByVal lastY As Long = -1)
'//== xRange in all (4) check directions.
    On Error Resume Next
    
    Dim replaceCol As Long
    replaceCol = tilemem(X, Y)              'Colour at the location.
    
    If replaceCol = crColor Then
        Exit Sub
    End If

    tilemem(X, Y) = crColor                 'Set the new colour.
    
    Dim x2 As Long, y2 As Long
    
    'Check right (east).
    x2 = X + 1
    y2 = Y
    If (x2 <= xRange And y2 <= 32 And x2 >= 1 And y2 >= 1 And (x2 <> lastX Or y2 <> lastY)) Then '<-- Edit
        If tilemem(x2, y2) = replaceCol Then
            Call fillTile(x2, y2, crColor, X, Y)
        End If
    End If
    
    'Check up (north).
    x2 = X
    y2 = Y - 1
    If (x2 <= xRange And y2 <= 32 And x2 >= 1 And y2 >= 1 And (x2 <> lastX Or y2 <> lastY)) Then '<-- Edit
        If tilemem(x2, y2) = replaceCol Then
            Call fillTile(x2, y2, crColor, X, Y)
        End If
    End If
    
    'Check left (west).
    x2 = X - 1
    y2 = Y
    If (x2 <= xRange And y2 <= 32 And x2 >= 1 And y2 >= 1 And (x2 <> lastX Or y2 <> lastY)) Then '<-- Edit
        If tilemem(x2, y2) = replaceCol Then
            Call fillTile(x2, y2, crColor, X, Y)
        End If
    End If
    
    'Check down (south).
    x2 = X
    y2 = Y + 1
    If (x2 <= xRange And y2 <= 32 And x2 >= 1 And y2 >= 1 And (x2 <> lastX Or y2 <> lastY)) Then '<-- Edit
        If tilemem(x2, y2) = replaceCol Then
            Call fillTile(x2, y2, crColor, X, Y)
        End If
    End If
    
End Sub
'Others (NEW for 3.0.4 by Delano & Woozy)
'All the shape tools are in this 1 sub - there used to be 5 different subs for them
Sub tileAddShape(ByVal x1 As Integer, ByVal y1 As Integer, ByVal x2 As Integer, ByVal y2 As Integer, ByVal how As Integer)
    On Error Resume Next
    'How: 1 - Filled Rectangle
    '     2 - Rectangle
    '     3 - Filled Ellipse
    '     4 - Ellipse
    '     5 - Line
    
    'Use new undo
    Call SetUndo
    
    Dim X As Integer, Y As Integer
    Dim Canv As Long, tc As Long, p As Long
    'Create an offscreen canvas, and test it.
    Canv = CreateCanvas(xRange, 32)
    tc = RGB(255, 100, 50)                              'Transparent colour.
    Call CanvasSetPixel(Canv, 0, 0, tc)
    tc = CanvasGetPixel(Canv, 0, 0)
    
    'Copy the tilemem to the offscreen canvas.
    If detail = 1 Or detail = 2 Then                    'High (24bit) detail.
        For X = 1 To xRange
            For Y = 1 To 32
                If tilemem(X, Y) <> -1 Then
                    Call CanvasSetPixel(Canv, X - 1, Y - 1, tilemem(X, Y))
                Else
                    'Set tc (from above) as the transparent colour.
                    Call CanvasSetPixel(Canv, X - 1, Y - 1, tc)
                    p = CanvasGetPixel(Canv, X - 1, Y - 1)
                End If
            Next Y
        Next X
        
        Select Case how
            Case 1 'Filled Rectangle
                If publicTile.currentColor <> -1 Then
                    Call CanvasFillBox(Canv, x1 - 1, y1 - 1, x2 - 1, y2 - 1, publicTile.currentColor)
                Else
                    Call CanvasFillBox(Canv, x1 - 1, y1 - 1, x2 - 1, y2 - 1, tc)
                End If
            Case 2 'Rectangle
                If publicTile.currentColor <> -1 Then
                    Call CanvasBox(Canv, x1 - 1, y1 - 1, x2 - 1, y2 - 1, publicTile.currentColor)
                Else
                    Call CanvasBox(Canv, x1 - 1, y1 - 1, x2 - 1, y2 - 1, tc)
                End If
            Case 3 'Filled Ellipse
                If publicTile.currentColor <> -1 Then
                    Call CanvasDrawFilledEllipse(Canv, x1 - 1, y1 - 1, x2 - 1, y2 - 1, publicTile.currentColor)
                Else
                    Call CanvasDrawFilledEllipse(Canv, x1 - 1, y1 - 1, x2 - 1, y2 - 1, tc)
                End If
            Case 4 'Ellipse
                If publicTile.currentColor <> -1 Then
                    Call CanvasDrawEllipse(Canv, x1 - 1, y1 - 1, x2 - 1, y2 - 1, publicTile.currentColor)
                Else
                    Call CanvasDrawEllipse(Canv, x1 - 1, y1 - 1, x2 - 1, y2 - 1, tc)
                End If
            Case 5 'Line
                If publicTile.currentColor <> -1 Then
                    Call CanvasDrawLine(Canv, x1 - 1, y1 - 1, x2 - 1, y2 - 1, publicTile.currentColor)
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
                    tilemem(X, Y) = -1
                Else
                    tilemem(X, Y) = p
                End If
            Next Y
        Next X
    End If
    
    'Destroy the Canvas
    Call DestroyCanvas(Canv)
    
    'Redraw
    Call tileRedraw
End Sub
'========================================================================
' Depress tool index, and unpress the others
'========================================================================
Sub ToolSet(Index As Integer)
    On Error Resume Next
    
    ignore = 1
    
    Dim t As Integer
    
    'Go through the tools
    For t = 0 To 8
        If t = Index Then
            tkMainForm.tileTool(t).value = 1
        Else
            tkMainForm.tileTool(t).value = 0
        End If
    Next t
    
    ignore = 0
End Sub
'========================================================================
' !NEW! Changes one color to another color in the editor (EDIT for 3.0.4 by Woozy)
'========================================================================
Public Sub changeColor()
    'If the user has choosen the color he wants to change, we go through this loop
    Dim X As Integer, Y As Integer
    If bchangecolor = 2 Then
        For X = 1 To xRange                            '<-- Edit
            For Y = 1 To 32
                If tilemem(X, Y) = publicTile.changeColor Then
                    tilemem(X, Y) = publicTile.currentColor
                End If
            Next Y
        Next X
        'Redraw the tile
        activeTile.tileRedraw
        'Reset the function
        bchangecolor = 0
    Else
        MsgBox "Select the color you want to change.", vbOKOnly + vbQuestion
        'Set the variable to 1 so the tileform_MouseDown() sub will get back to
        'this function again. Then the variable "bchangecolor" will be 2, so it
        'will go to the topper part.
        bchangecolor = 1
        'Selects the eyedropper.
        Call ToolSet(1)
    End If
End Sub
'========================================================================
' Form_Activate (EDIT for 3.0.4 by Delano)
'========================================================================
Private Sub Form_Activate()
    On Error GoTo ErrorHandler
    filename$(2) = ""
    
    Set activeTile = Me
    Set activeForm = Me
    
    Dim X As Integer, Y As Integer                                 '<-- New
    
    If Not (ignoreDeactivate) Then
        'Refresh data
        For X = 0 To 64                                 '<-- Edit
            For Y = 0 To 32
                tilemem(X, Y) = theData.tilemem(X, Y)
            Next Y
        Next X
        detail = theData.detail
        publicTile = theData
    End If
    
    ignoreDeactivate = False
    
    'Set ISO or not (NEW)
    
    If theData.isometric Then
        tkMainForm.tileIsoCheck.value = 1
        xRange = 64
        xMod = 2
        isIsoTile = True
    Else
        tkMainForm.tileIsoCheck.value = 0
        xRange = 32
        xMod = 1
        isIsoTile = False
    End If
    
    tkMainForm.isoMirror.cls
    Call tileRedraw                                     '<-- New
    
    fromActivate = True
    Call isoChange(theData.isometric)                   '<-- New
    fromActivate = False
    
    'Set the current tool
    Call ToolSet(theData.tilemode)
    'Set the selected color
    Call vbPicFillRect(tkMainForm.selectedcolor, 0, 0, 1000, 1000, theData.currentColor)
    
    'Hide tools/extra's
    Call hideAllTools                                   '<-- Edit
    'Show the ones we need
    tkMainForm.bottomFrame.Visible = True
    tkMainForm.tileExtras.Visible = True
    tkMainForm.tileTools.Visible = True
    tkMainForm.tileTools.Top = tkMainForm.toolTop       '<-- New
    
    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub
'========================================================================
' Form_Deactivate (EDIT for 3.0.4 by Delano)
'========================================================================
Private Sub Form_Deactivate()
    On Error Resume Next
    
    'Store the data
    theData = publicTile
    
    Dim X As Integer, Y As Integer                                     '<-- New
    
    'Refresh data
    For X = 0 To xRange                                     '<-- Edit
        For Y = 0 To 32
            theData.tilemem(X, Y) = tilemem(X, Y)
        Next Y
    Next X
    theData.detail = detail
    theData.isometric = tkMainForm.tileIsoCheck.value       '<-- New
End Sub
'========================================================================
' Form_KeyPress
'========================================================================
Private Sub Form_KeyPress(KeyAscii As Integer)
    On Error GoTo ErrorHandler
    If UCase$(chr$(KeyAscii)) = "L" Then
        If lastTileset$ = "" Then
            Call opentile_Click
            Exit Sub
        End If
        If lastTileset$ <> "" Then
            tstFile$ = lastTileset$
            ignoreDeactivate = True
            tilesetform.Show vbModal ', me
            'MsgBox setFilename$
            If setFilename$ = "" Then Exit Sub
            Call opentile2(projectPath$ + tilepath$ + setFilename$)
            Call activeTile.highredraw
            publicTile.tileName = setFilename$
            activeTile.Caption = LoadStringLoc(801, "Tile Editor") + "  (" + setFilename$ + ")"
            Exit Sub
        End If
    End If
    
    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub
'========================================================================
' Form_Load (EDIT for 3.0.4 by Delano & Woozy)
'========================================================================
Private Sub Form_Load()
    On Error GoTo ErrorHandler
    
    Call LocalizeForm(Me)

    Set activeTile = Me
    
    'Initial (non)isometric settings. (NEW for 3.0.4 by Delano)
    
    isIsoTile = True
    xRange = 32
    theData.isometric = False
    xMod = 1

    'Refresh data...
    Dim X As Integer, Y As Integer                                 '<-- New
    
    For X = 0 To 64                                     '<-- Edit
        For Y = 0 To 32
            theData.tilemem(X, Y) = -1
        Next Y
    Next X
    
    theData.detail = 1
    
    filename$(2) = ""
    Call vbPicAutoRedraw(tileform, True)
    
    'Only redraw the preview picturebox in tkMainForm if we aren't on ISO mode
    If Not isIsoTile Then Call vbPicAutoRedraw(tkMainForm.mirror, True) '<-- Edit
    
    Call vbPicAutoRedraw(tkMainForm.selectedcolor, True)
    publicTile.grid = 0
    
    'Make the current tool the pen tool
    Call ToolSet(0)
        
    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub
'========================================================================
' Form_Resize (EDIT for 3.0.4 by Delano & Woozy)
' This is called on resizing, and on tileIsoCheck_Click.
' xMod is the multiplyer for isometrics, = 2 .iso, = 1 .tst
'========================================================================
Private Sub Form_Resize()
    'Only change the width/height when the form is in normal state
    If Me.Width < (6070 * xMod) And Me.WindowState = 0 Then Me.Width = 6070 * xMod
    If Me.height < 6070 And Me.WindowState = 0 Then Me.height = 6070

    'Variable used for calculating the tileform height and width (NEW for 3.0.4 by Woozy)
    Dim need, wwidth, hheight As Integer
    
    'Little math thing to calculate the width (EDIT for 3.0.4 by Woozy)
    wwidth = Round(((Me.Width - 300) / Screen.TwipsPerPixelX) / 32) * 32
    need = (wwidth / 32) / 2
    wwidth = Round((wwidth + need) * Screen.TwipsPerPixelX - 50, 0)
    
    'Little math thing to calculate the height (EDIT for 3.0.4 by Woozy)
    hheight = Round(((Me.height - 1200) / Screen.TwipsPerPixelX) / 32) * 32
    need = (hheight / 32) / 2
    hheight = Round((hheight + need) * Screen.TwipsPerPixelY - 50, 0)
    
    'Set the height/width
    If wwidth < hheight Then
        tileform.Width = wwidth
        tileform.height = hheight
    Else
        tileform.Width = hheight
        tileform.height = hheight
    End If

    'NEW for 3.0.4 by Delano
    tileform.Width = tileform.height * xMod  'Twips
    
    'NEW for 3.0.4 by Woozy
    If (tileform.Width > Me.Width - 200) Then
        tileform.Width = tileform.Width - 900
    End If
    tileform.Left = (Me.Width - tileform.Width) / 2
    
    'Changed so it the tile editor is centered
    tileform.Top = ((Me.height - tileform.height) / 2) / 2
    
    'Redraw
    Call tileRedraw
End Sub
'========================================================================
' Form_Unload
'========================================================================
Private Sub Form_Unload(Cancel As Integer)
    On Error Resume Next
    'Hide all tools
    Call hideAllTools
End Sub

'========================================================================
' When you click in the tile editor (EDIT for 3.0.4 by Delano & Woozy)
'========================================================================
Private Sub tileform_MouseDown(button As Integer, Shift As Integer, X As Single, Y As Single)
    On Error Resume Next
    publicTile.tileneedupdate = True
    
    'Get the current color
    Dim coloruse As Long                                    '<-- New
    coloruse = publicTile.currentColor

    If detail <> 1 And detail <> 2 Then
        If publicTile.currentColor = -1 Then coloruse = -1 Else coloruse = GFXGetDOSColor(publicTile.currentColor)
    End If
   
    'Tileform size in pixels.
    Dim wwidth As Integer, hheight As Integer                          '<-- New
    wwidth = (activeTile.tileform.Width) / Screen.TwipsPerPixelX
    hheight = (activeTile.tileform.height) / Screen.TwipsPerPixelY

    'Size of a pixel on the tile.
    Dim pixelWidth As Integer, pixelHeight As Integer
    pixelWidth = (wwidth / xRange)                          '<-- Edit
    pixelHeight = (hheight / 32)
    
    'Tile pixel co-ordinates (which pixel selected).
    Dim xx As Integer, yy As Integer
    xx = Int(X / pixelWidth)
    yy = Int(Y / pixelHeight)
    
    'If a rouge pixel has been selected.
    If xx > (xRange - 1) Or yy > 31 Then Exit Sub           '<-- Edit
    
    'Exit sub if there's clicked in the not-available part
    If isoMaskBmp(xx + 1, yy + 1) <> vbQBColor(0) And isIsoTile Then Exit Sub '<-- New
    
    Select Case publicTile.tilemode
        Case 0, 3: '0 = draw, 3 = erase.
            'Use New Undo
            Call SetUndo                                    '<-- Edit
            
            'Set erase colour.
            If publicTile.tilemode = 3 Then
                coloruse = -1
            End If
            
            Dim newX, newY As Integer                       '<-- New
            newX = (xx * pixelWidth) + 1
            newY = (yy * pixelHeight) + 1

            If (isIsoTile And isoMaskBmp(xx + 1, yy + 1) = vbQBColor(0)) Or Not (isIsoTile) Then
                If coloruse = -1 Then
                    'Transparent.
                
                    Call vbPicFillRect(activeTile.tileform, newX, newY, newX + (pixelWidth - 1), newY + (pixelHeight - 1), vbQBColor(15))
                    Call vbPicFillRect(activeTile.tileform, newX, newY, newX + (pixelWidth / 2), newY + (pixelHeight / 2), vbQBColor(7))
                    Call vbPicFillRect(activeTile.tileform, newX + (pixelWidth / 2), newY + (pixelHeight / 2), newX + (pixelWidth - 1), newY + (pixelHeight - 1), vbQBColor(7))
                                       
                    If Not (GridOff) Then
                        Call vbPicRect(activeTile.tileform, newX - 1, newY - 1, newX + (pixelWidth - 1), newY + (pixelHeight - 1), vbQBColor(1))
                    End If
                    
                    tilemem(xx + 1, yy + 1) = coloruse
                    
                    coloruse = RGB(255, 255, 255)
                Else
                    'Solid pixel.
                
                    Call vbPicFillRect(activeTile.tileform, newX, newY, newX + (pixelWidth - 1), newY + (pixelHeight - 1), coloruse)
                    
                    If Not (GridOff) Then
                        Call vbPicRect(activeTile.tileform, newX - 1, newY - 1, newX + (pixelWidth - 1), newY + (pixelHeight - 1), vbQBColor(1))
                    End If
                    
                    tilemem(xx + 1, yy + 1) = coloruse
                End If
            End If 'isIsoTile
            
            '//==Draw the pixels in the mirrors.
            If isIsoTile And isoMaskBmp(xx + 1, yy + 1) = vbQBColor(0) Then
                'Isometric.
                Call vbPicPSet(tkMainForm.isoMirror, xx, yy, coloruse)
            ElseIf Not (isIsoTile) Then
                '2D
                Call vbPicPSet(tkMainForm.mirror, xx, yy, coloruse)
                Call vbPicPSet(tkMainForm.isoMirror, getIsoX(xx, yy), getIsoY(xx, yy), coloruse)
            End If
            '//==
            
        Case 1: 'Eye Dropper
            '!NEW! If we are in the "changecolor" process, it saves the info in
            'another variable
            If bchangecolor = 1 Then
                publicTile.changeColor = tilemem(xx + 1, yy + 1)
                bchangecolor = 2
                Call changeColor
            Else
                publicTile.currentColor = tilemem(xx + 1, yy + 1)
            End If
            
            'Update the selected color picturebox in tkMainForm
            Call vbPicFillRect(tkMainForm.selectedcolor, 0, 0, 100, 100, publicTile.currentColor)
            
            'Update the variable with the current color
            If detail <> 1 And detail <> 2 Then
                If detail = 3 Or detail = 4 Then
                    publicTile.currentColor = tocolor(publicTile.currentColor, "256")
                End If
                If detail = 5 Or detail = 6 Then
                    publicTile.currentColor = tocolor(publicTile.currentColor, "16")
                End If
                Call vbPicFillRect(tkMainForm.selectedcolor, 0, 0, 100, 100, GFXGetDOSColor(publicTile.currentColor))
            End If
            
            'Change the selected tool
            publicTile.tilemode = 0
            Call ToolSet(publicTile.tilemode)
        Case 2:
            'Fill!
            
            'Use New Undo
            Call SetUndo                                        '<-- Edit
            
            Call fillTile(xx + 1, yy + 1, coloruse)
            
            'Redraw
            Call tileRedraw
    End Select
End Sub
'========================================================================
' When you move the mouse in the tile editor (EDIT for 3.0.4 by Delano & Woozy)
'========================================================================
Private Sub tileform_MouseMove(button As Integer, Shift As Integer, X As Single, Y As Single)
    On Error Resume Next
    
    'Tileform size in pixels.
    Dim wwidth As Integer, hheight As Integer                      '<-- New
    wwidth = (activeTile.tileform.Width) / Screen.TwipsPerPixelX
    hheight = (activeTile.tileform.height) / Screen.TwipsPerPixelY
    
    'Size of a pixel on the tile.
    Dim pixelWidth As Integer, pixelHeight As Integer
    pixelWidth = (wwidth / xRange)                      '<- Edit
    pixelHeight = (hheight / 32)
    
    'Tile pixel co-ordinates (which pixel selected).
    Dim xx As Integer, yy As Integer
    xx = Int(X / pixelWidth)
    yy = Int(Y / pixelHeight)
    
    'If pixel is out of the tile's range.
    If xx > (xRange - 1) Or yy > 31 Then Exit Sub       '<-- Edit
    If xx < 0 Or yy < 0 Then Exit Sub
    
    'Update Co-ordinate label
    tkMainForm.coords.Caption = "(" + toString(xx + 1) + "," + toString(yy + 1) + ")"
    
    If ignore = 1 Then
        ignore = 0
        Exit Sub
    End If
    
    'Added: don't need the following code if the button is not depressed - we're not using
    'a tool! Co-ordinate caption will now update faster too.
    If button = 0 Then Exit Sub                         '<-- New
    
    xx = xx * pixelWidth + (pixelWidth / 2)
    yy = yy * pixelHeight + (pixelHeight / 2)
    
    Dim x1 As Integer, y1 As Integer                               '<-- New
    x1 = Int(dragX1 / pixelWidth) * pixelWidth + (pixelWidth / 2)
    y1 = Int(dragY1 / pixelHeight) * pixelHeight + (pixelHeight / 2)
    
    'Get the current color
    Dim coluse As Long
    coluse = publicTile.currentColor
    If coluse = -1 Then coluse = 0
    
    Call vbPicRefresh(tileform)
    
    Select Case publicTile.tilemode
        Case 4:
            'Line
            If button = 1 And bDragBegin Then
                'Call tileRedraw
                Call vbPicAutoRedraw(tileform, False)
                Call vbPicLine(tileform, x1, y1, xx, yy, coluse)
                Call vbPicAutoRedraw(tileform, True)
                'tileform.Refresh
                Exit Sub
            End If
        Case 5, 6:
            'Ellipse
            Dim Temp As Integer                         '<-- New
            If xx < x1 Then
                Temp = x1
                x1 = xx
                xx = Temp
            End If
            If yy < y1 Then
                Temp = y1
                y1 = yy
                yy = Temp
            End If
            Dim cx As Integer, cy As Integer, rx As Integer
            Dim ry As Integer, rad As Integer, asp As Integer     '<-- New
            cx = x1 + ((xx - x1) / 2)
            cy = y1 + ((yy - y1) / 2)
            rx = xx - cx
            ry = yy - cy
            rad = rx
            asp = ry / rx
            'If rx > ry Then rad = rx Else rad = ry
            'If rx > ry Then asp = ry / rx Else asp = rx / ry
            If button = 1 And bDragBegin Then
                'Call tileRedraw
                Call vbPicAutoRedraw(tileform, False)
                If asp > 1 Then
                    Call vbPicCircle(tileform, cx, cy, rad * asp, coluse, -1, -1, asp)
                Else
                    Call vbPicCircle(tileform, cx, cy, rad, coluse, -1, -1, asp)
                End If
                Call vbPicAutoRedraw(tileform, True)
                'tileform.Refresh
                Exit Sub
            End If
        Case 7, 8:
            'Rectangle tools (outline and fill).
            If button = 1 And bDragBegin Then
                'Call tileRedraw
                Call vbPicAutoRedraw(tileform, False)
                Call vbPicRect(tileform, x1, y1, xx, yy, coluse)
                'tileform.Refresh
                Call vbPicAutoRedraw(tileform, True)
                Exit Sub
            End If
    End Select
    
    If button = 1 Then
        Call tileform_MouseDown(button, Shift, X, Y)
        bDragBegin = True
        dragX1 = X
        dragY1 = Y
    End If
End Sub
'========================================================================
' When you release the mouse in the tile editor (EDIT for 3.0.4 by Woozy)
'========================================================================
Private Sub tileform_MouseUp(button As Integer, Shift As Integer, X As Single, Y As Single)
    On Error Resume Next
    
    Dim wwidth As Integer, hheight As Integer                      '<-- New
    wwidth = (activeTile.tileform.Width) / Screen.TwipsPerPixelX
    hheight = (activeTile.tileform.height) / Screen.TwipsPerPixelY
    
    Dim pixelWidth As Integer, pixelHeight As Integer
    pixelWidth = (wwidth / xRange)                      '<-- Edit
    pixelHeight = (hheight / 32)
    
    Dim x2 As Integer, y2 As Integer
    Dim x1 As Integer, y1 As Integer                       '<-- New
    x2 = Int(X / pixelWidth)
    y2 = Int(Y / pixelHeight)
    x1 = Int(dragX1 / pixelWidth)
    y1 = Int(dragY1 / pixelHeight)

    If bDragBegin Then
        bDragBegin = False
        Select Case publicTile.tilemode
            Case 4 'Line
                Call tileAddShape(x1 + 1, y1 + 1, x2 + 1, y2 + 1, 5) '<-- Edit
            Case 5 'Ellipse
                Call tileAddShape(x1 + 1, y1 + 1, x2 + 1, y2 + 1, 4) '<-- Edit
            Case 6 'Filled Ellipse
                Call tileAddShape(x1 + 1, y1 + 1, x2 + 1, y2 + 1, 3) '<-- Edit
            Case 7 'Rectangle
                Call tileAddShape(x1 + 1, y1 + 1, x2 + 1, y2 + 1, 2) '<-- Edit
            Case 8 'Filled Rectangle
                Call tileAddShape(x1 + 1, y1 + 1, x2 + 1, y2 + 1, 1) '<-- Edit
        End Select
    End If
End Sub
'========================================================================
' Draw the Grid (EDIT for 3.0.4 by Delano)
'========================================================================
Sub drawGrid()
    On Error Resume Next
    
    If GridOff = True Then Exit Sub
    
    'Size of form in pixels.
    Dim wwidth As Integer, hheight As Integer                      '<-- New
    wwidth = (activeTile.tileform.Width) / Screen.TwipsPerPixelX
    hheight = (activeTile.tileform.height) / Screen.TwipsPerPixelY
    
    If wwidth = 0 Or hheight = 0 Then Exit Sub

    'Size of a pixel on the tile.
    Dim pixelWidth, pixelHeight As Integer
    pixelWidth = (wwidth / xRange)                      '<-- Edit
    pixelHeight = (hheight / 32)
    
    Dim X As Integer, Y As Integer                                 '<-- New
    If detail = 1 Then
        For X = 0 To wwidth Step pixelWidth
            Call vbPicLine(tileform, X, 0, X, hheight, vbQBColor(1))
        Next X
        For Y = 0 To hheight Step pixelHeight
            Call vbPicLine(tileform, 0, Y, wwidth, Y, vbQBColor(1))
        Next Y
        Call vbPicPSet(tileform, wwidth, hheight, vbQBColor(1))
    End If
End Sub
'========================================================================
' Redraws the picturebox you paint on...
'========================================================================
Sub highredraw()
    On Error GoTo ErrorHandler
    
    'Update thingys in tkMainForm
    Call vbPicFillRect(activeTile.tileform, 0, 0, 1000, 1000, vbQBColor(15))
    Call vbPicFillRect(tkMainForm.mirror, 0, 0, 100, 100, vbQBColor(15))

    'Pixel size of the tileform.
    Dim wwidth, hheight As Integer                      '<-- New
    wwidth = (activeTile.tileform.Width) / Screen.TwipsPerPixelX
    hheight = (activeTile.tileform.height) / Screen.TwipsPerPixelY
    
    Dim pixelWidth As Integer, pixelHeight As Integer
    pixelWidth = (wwidth / xRange)                      '<-- Edit
    pixelHeight = (hheight / 32)
    
    If detail = 3 Or detail = 5 Then
        Call color_16million
    End If
    
    Dim X As Integer, Y As Integer
    Dim xx As Integer, yy As Integer                         '<-- New

    For X = 1 To xRange                                                     '//==
        For Y = 1 To 32
            xx = (X * pixelWidth) - (pixelWidth - 1)
            yy = (Y * pixelHeight) - (pixelHeight - 1)
            
            If isoMaskBmp(X, Y) <> vbQBColor(0) And isIsoTile Then
                'draw white pixels at the corners if this tile is isometric.
                Call vbPicFillRect(activeTile.tileform, xx, yy, xx + (pixelWidth - 1), yy + (pixelHeight - 1), Me.BackColor)
                Call vbPicPSet(tkMainForm.isoMirror, X - 1, Y - 1, Me.BackColor)
                
                'Clear the tilemem entry.
                tilemem(X, Y) = -1
                
            
            ElseIf tilemem(X, Y) <> -1 Then
                'If the pixel isn't transparent and isn't masked - both isometric and 2D.
                    
                Call vbPicFillRect(activeTile.tileform, xx, yy, xx + (pixelWidth - 1), yy + (pixelHeight - 1), tilemem(X, Y))
                
                If isIsoTile Then
                    'Draw the isomirror here (moved from tileRedraw.) Don't draw the 2D mirror.
                    Call vbPicPSet(tkMainForm.isoMirror, X - 1, Y - 1, tilemem(X, Y))
                Else
                    'Draw the 2D mirror - isomirror drawn in tileRedraw.
                    Call vbPicPSet(tkMainForm.mirror, X - 1, Y - 1, tilemem(X, Y))
                End If
                
            Else
                'Transparent.
            
                Call vbPicFillRect(activeTile.tileform, xx, yy, xx + pixelWidth / 2, yy + pixelHeight / 2, vbQBColor(7))
                Call vbPicFillRect(activeTile.tileform, xx + pixelWidth / 2, yy + pixelHeight / 2, xx + (pixelWidth - 1), yy + (pixelHeight - 1), vbQBColor(7))
            End If
        Next Y
    Next X
    publicTile.grid = 0
    
    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub
'========================================================================
' Check if the file has changed an it needs to be saved...
'========================================================================
Public Sub checkSave()
    On Error GoTo ErrorHandler
    If publicTile.tileneedupdate = True Then
        Dim aa As Integer
        aa = MsgBox(LoadStringLoc(939, "Would you like to save your changes to the current file?"), vbYesNo)
        If aa = 6 Then
            'yes-- save
            Call saveFile
        End If
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
Public Sub saveFile()
    On Error GoTo ErrorHandler
    
    filename$(2) = publicTile.tileName
    publicTile.tileneedupdate = False
    If filename$(2) = "" Then
        Me.Show
        Call savenoquestions_Click
        Exit Sub
    End If
    'Save the tile
    Call savetile(projectPath$ + tilepath$ + filename$(2))

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub
'========================================================================
' Opens the file
' Called by OpenFile in tkMainForm, etc.
' Alterations for isometrics 3.0.4 - added "ISO" comparison.
'========================================================================
Public Sub openFile(ByVal file As String): On Error Resume Next
    
    activeTile.Show
    
    ChDir (currentdir$)
    
    Call checkSave      'Check if a tile is already open and needs saving.
    publicTile.tileneedupdate = False
    
    filename$(1) = file$
    antiPath$ = absNoPath(file$)
    
    FileCopy filename$(1), projectPath$ + tilepath$ + antiPath$
    
    whichType$ = GetExt(filename$(1))
    
    If UCase$(whichType$) = "ISO" Then
        'Set the mode to isometric.
        tkMainForm.tileIsoCheck.value = 1
    Else
        tkMainForm.tileIsoCheck.value = 0
    End If
    
    If UCase$(whichType$) = "TST" Or UCase$(whichType$) = "ISO" Then
        'Yipes! we've selected an archive!
    
        tstnum = 0
        'FileCopy filename$(1), projectPath$ + tilepath$ + antiPath$
        
        lastTileset$ = antiPath$
        tstFile$ = antiPath$
        
        ignoreDeactivate = True
        
        tilesetform.Show vbModal            'Show the tileset browser.
        
        'setFilename$ created in tilesetform. Contains the tilenumber.
        If setFilename$ = "" Then Exit Sub
        
        Call openFromTileSet(projectPath$ + tilepath$ + tilesetFilename(setFilename$), getTileNum(setFilename$))
        
        If detail = 2 Or detail = 4 Or detail = 6 Then
            'only 32x32 tiles allowed
            Call increasedetail
        End If
        Call color_16million
        
        'Now we need to rearrange the pixels in the tilemem from 32x32 to 62x32
        
        If UCase$(whichType$) = "ISO" Then
            Dim xCount As Byte, yCount As Byte, X As Integer, Y As Integer
            xCount = 1: yCount = 1
        
            'Now we need to form the 32x32 tile into a 64x32 in tilemem:
            
            'Temporarily hold tilemem in the buffer.
            For xx = 1 To 32
                For yy = 1 To 32
                    buftile(xx, yy) = tilemem(xx, yy)
                Next yy
            Next xx
            
            For xx = 1 To 64
                For yy = 1 To 32
                                
                    If isoMaskBmp(xx, yy) <> RGB(0, 0, 0) Then
                        'Masked pixel.
                        tilemem(xx, yy) = -1
                    Else
                        'Unmasked pixel.
                        tilemem(xx, yy) = buftile(xCount, yCount)
                                            
                        'Increment the tilemem entry.
                        yCount = yCount + 1
                        If yCount > 32 Then
                            xCount = xCount + 1
                            yCount = 1
                        End If
                    End If
                    
                    'Call traceString("tilemem(" & xx & ", " & yy & ") = " & tilemem(xx, yy))
                    
                Next yy
            Next xx
        End If '(whichtype$ = "ISO")
        
        
        Call activeTile.highredraw
        
        publicTile.tileName$ = setFilename$
        activeTile.Caption = LoadStringLoc(801, "Tile Editor") + "  (" + setFilename$ + ")"
        
    Else
        '.gph
        
        Call opentile2(filename$(1))
        Call activeTile.highredraw
        publicTile.tileName$ = antiPath$
        activeTile.Caption = LoadStringLoc(801, "Tile Editor") + "  (" + antiPath$ + ")"
        
    End If
    
    Call tileGrid(tkMainForm.tileGrid.value)
    
End Sub
'========================================================================
' Tool -- Grid
'========================================================================
Public Sub tileGrid(ByVal value As Integer)
    On Error GoTo ErrorHandler
    
    If value = 0 Then
        GridOff = True
    Else
        GridOff = False
    End If
    
    'Redraw
    Call tileRedraw
    
    'Draw Grid
    Call drawGrid
    
    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub
'========================================================================
' Tool -- Redraw (EDIT for 3.0.4 by Delano)
'========================================================================
Public Sub tileRedraw()
    On Error GoTo ErrorHandler
    Call activeTile.highredraw
    Call drawGrid
    'tkMainForm.isoMirror.cls
    
    If isIsoTile Then
        'Draw the tile isometrically. Send a different value to the function.
        'Moved to highRedraw.
    Else
        Call tileDrawIso(tkMainForm.isoMirror, 0, 0, 3)
    End If
    
    Call vbPicRefresh(tkMainForm.isoMirror)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub
'========================================================================
' Tools
'========================================================================
Public Sub tileTool(Index As Integer)
    'tools
    On Error Resume Next
    
    If ignore = 1 Then Exit Sub
    
    If Index >= 4 Then
        '16 or 256 color...
        If detail >= 3 Then
            MsgBox LoadStringLoc(996, "This tool can only be used in 16.7 million color mode.")
            Index = lastTool
        End If
    End If
    
    Call ToolSet(Index)
    lastTool = publicTile.tilemode
    publicTile.tilemode = Index
    
    bDragBegin = False
End Sub
'========================================================================
' Grid (on/off)
'========================================================================
Private Sub gridonoffmenu_Click()
    On Error GoTo ErrorHandler
    Call tileGrid(tkMainForm.tileGrid.value)
    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub
'========================================================================
' When you click in the color picker in TkMainform
'========================================================================
Public Sub palettebox_MouseDown(button As Integer, Shift As Integer, X As Single, Y As Single)
    On Error GoTo ErrorHandler
    'Set the current color
    publicTile.currentColor = vbFrmPoint(tkMainForm.palettebox, X, Y)
    
    'Update selected color picturebox in tkMainForm
    Call vbPicFillRect(tkMainForm.selectedcolor, 0, 0, 100, 100, publicTile.currentColor)
    
    If detail <> 1 And detail <> 2 Then
        If detail = 3 Or detail = 4 Then
          publicTile.currentColor = tocolor(vbFrmPoint(tkMainForm.palettebox, X, Y), "256")
        End If
        If detail = 5 Or detail = 6 Then
          publicTile.currentColor = tocolor(vbFrmPoint(tkMainForm.palettebox, X, Y), "16")
        End If
        Call vbPicFillRect(tkMainForm.selectedcolor, 0, 0, 100, 100, GFXGetDOSColor(publicTile.currentColor))
    End If

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub
'========================================================================
' Opens a tile... (EDIT for 3.0.4 by Delano)
'========================================================================
Public Sub opentile_Click()

'//==Delano

    On Error Resume Next
    ignore = 1
    ChDir (currentdir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + tilepath$
    
    If UCase$(whichType$) = "ISO" Then
        'Set the mode to isometric.
        tkMainForm.tileIsoCheck.value = 1
    Else
        tkMainForm.tileIsoCheck.value = 0
    End If

    dlg.strTitle = "Open Tile"
    dlg.strDefaultExt = "tst"
    dlg.strFileTypes = "Supported Files|*.gph;*.tst;*.iso|RPG Toolkit TileSet (*.tst)|*.tst|RPG Toolkit Tile (*.gph)|*.gph|RPG Toolkit Isometric TileSet (*.iso)|*.iso|All files(*.*)|*.*"
    
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentdir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + tilepath$ + antiPath$
    whichType$ = GetExt(filename$(1))
    
    
    
    If UCase$(whichType$) = "TST" Or UCase$(whichType$) = "ISO" Then      'Yipes! we've selected an archive!
        tstnum = 0
        'FileCopy filename$(1), projectPath$ + tilepath$ + antiPath$
        tstFile$ = antiPath$
        lastTileset$ = tstFile$
        
        ignoreDeactivate = True
        tilesetform.Show vbModal ', me
        'MsgBox setFilename$
        If setFilename$ <> "" Then
        
            Call openFromTileSet(projectPath$ + tilepath$ + tilesetFilename(setFilename$), getTileNum(setFilename$))
            
            If detail = 2 Or detail = 4 Or detail = 6 Then
                'only 32x32 tiles allowed
                Call increasedetail
            End If
            Call color_16million
            
            Call activeTile.highredraw
            publicTile.tileName$ = setFilename$
            activeTile.Caption = LoadStringLoc(801, "Tile Editor") + "  (" + setFilename$ + ")"
        End If
    Else
        Call opentile2(filename$(1))
        Call activeTile.highredraw
        publicTile.tileName$ = antiPath$
        activeTile.Caption = LoadStringLoc(801, "Tile Editor") + "  (" + antiPath$ + ")"
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
    If publicTile.tileName = "" Then
        savetile2_Click                 'The "Save Tile As..." sub.
        Exit Sub
    End If
    
    'Else, the tile was opened, so update the file.
    Call savetile(projectPath$ + tilepath$ + publicTile.tileName)
    publicTile.tileneedupdate = False
    
    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub
'=======================================================================================
'File -> Save Tile As...
'Alterations for isometrics, 3.0.4
'Called by savenoquestions_click only, and through the menu.
'=======================================================================================
Private Sub savetile2_Click(): On Error Resume Next

    ignore = 1
    ChDir (currentdir$)
    
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + tilepath$
    dlg.strTitle = "Save Tile As"
    
    'New support for isometric tilesets, .iso.
    
    If isIsoTile Then
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
    
    ChDir (currentdir$)
    publicTile.tileneedupdate = False
    
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
            aa = addToTileSet(filename$(1))
            If aa > 0 Then
                'MsgBox LoadStringLoc(2019, "Your tile has been added to the tileset")
                MsgBox ("Your tile has been added to the tileset: tile number " & aa & " in " & chr$(13) & filename(1) & ".")
                
                publicTile.tileName = antiPath$ + toString(aa)
                activeTile.Caption = LoadStringLoc(801, "Tile Editor") + " (" + publicTile.tileName + ")"
            End If
        Else
            'Note new argument!
            aa = createNewTileSet(filename$(1), isIsoTile)
            If aa > 0 Then
                'MsgBox LoadStringLoc(2019, "Your tile has been added to the tileset")
                MsgBox ("A new tileset has been created: " & chr$(13) & filename$(1) & chr$(13) & " and the first tile added.")
                
                publicTile.tileName = antiPath$ + "1"
                activeTile.Caption = LoadStringLoc(801, "Tile Editor") + " (" + publicTile.tileName + ")"
            End If
        End If
        
    Else
    
        '.gph
        aa = FileExist(filename$(1))
        If aa = 1 Then
            bb = MsgBox(LoadStringLoc(949, "That file exists.  Are you sure you want to overwrite it?"), vbYesNo)
            If bb = vbNo Then Exit Sub
        End If
        Call savetile(filename$(1))
        publicTile.tileName = antiPath$
        activeTile.Caption = LoadStringLoc(801, "Tile Editor") + " (" + antiPath$ + ")"
        
    End If 'tst, iso.
    
    Call tkMainForm.fillTree("", projectPath$)
End Sub
'==========================================================================================
'File -> Save into tileset
'Alterations for isometrics, 3.0.4
'==========================================================================================
Private Sub mnusts_Click(): On Error Resume Next

    ignore = 1
    ChDir (currentdir$)
    
    
    'Set up the save dialog window
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + tilepath$
    dlg.strTitle = "Save Into Tileset"
    
    If isIsoTile Then
        dlg.strDefaultExt = "iso"
        dlg.strFileTypes = "Supported Types|*.iso|RPG Toolkit Isometric TileSet (*.iso)|*.iso|All files(*.*)|*.*"
    Else
        dlg.strDefaultExt = "tst"
        dlg.strFileTypes = "Supported Types|*.tst|RPG Toolkit TileSet (*.tst)|*.tst|All files(*.*)|*.*"
    End If
    
    If SaveFileDialog(dlg, Me.hwnd) Then
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub    'user pressed cancel
    End If
    
    ChDir (currentdir$)
    
    publicTile.tileneedupdate = False
    
    If filename$(1) = "" Then Exit Sub
    
    'Shouldn't need all this since the dialog window won't allow you to save as anything
    'other than the default type.
    
    tstnum = 0
    'Altered to handle isometric.
    a = tilesetInfo(filename$(1))
    
    If a = TSTTYPE Or a = ISOTYPE Then
        'The header could be read.
    
        tstFile$ = antiPath$
        lastTileset$ = tstFile$
        
        publicTile.bAllowExtraTst = True    'Allow insertion onto end of tileset.
        ignoreDeactivate = True
        
        tilesetform.Show vbModal
        publicTile.bAllowExtraTst = False
        
        If setFilename$ = "" Then Exit Sub

        tnum = getTileNum(setFilename$)     'Extract the number from the end of the set.
        
        If tnum > tileset.tilesInSet Then
            'If the selected tile is greater than the last tile number, add to end.
        
            aa = addToTileSet(filename$(1))
            'MsgBox "Your tile has been added to the tileset", , "Save into tileset"
            publicTile.tileName = antiPath$ + toString(tnum)
            activeTile.Caption = LoadStringLoc(801, "Tile Editor") + " (" + publicTile.tileName$ + ")"
            
        Else
            'Insert at the position indicated - overwrite the tile at that position!
            
            result = MsgBox("Warning! This will overwrite the tile at that position!", vbOKCancel)
            If result = vbCancel Then Exit Sub
                    
            publicTile.tileName$ = setFilename$
            Call insertIntoTileSet(projectPath$ + tilepath$ + tilesetFilename(setFilename$), getTileNum(setFilename$))
            activeTile.Caption = LoadStringLoc(801, "Tile Editor") + " (" + publicTile.tileName$ + ")"
        End If
        
    Else
        'Header couldn't be read - set doesn't exist.
    
        aa = createNewTileSet(filename$(1), isIsoTile)
        If aa > 0 Then
            'MsgBox LoadStringLoc(2019, "Your tile has been added to the tileset")
            MsgBox ("A new tileset has been created: " & chr$(13) & filename$(1) & chr$(13) & " and the first tile added.")
        
            publicTile.tileName = antiPath$ + "1"
            activeTile.Caption = LoadStringLoc(801, "Tile Editor") + " (" + publicTile.tileName$ + ")"
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
    activeTile.Hide

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
'Undo (EDIT for 3.0.4 by Woozy)
Private Sub undotilemenu_Click()
    Call GetUndo                                        '<-- Edit
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
'Clear (NEW for 3.0.4 by Woozy)
Private Sub cmdClear_Click()
    'Use new undo
    Call SetUndo
    
    Dim X As Integer, Y As Integer
    For X = 1 To xRange
        For Y = 1 To 32
            tilemem(X, Y) = -1
        Next Y
    Next X
    'Redraw
    Call tileRedraw
End Sub
'Rotate Left (NEW for 3.0.4 by Woozy)
Private Sub mnuRotate90CCW_Click()
    Rotate Left 'KSNiloc
End Sub
'Rotate Right (NEW for 3.0.4 by Woozy)
Private Sub mnuRotate90CW_Click()
    Rotate Right 'KSNiloc
End Sub
'Rotate 180 (NEW for 3.0.4 by Woozy)
Private Sub mnuRotate180_Click()
    Rotate OneHunderdEighty 'KSNiloc
End Sub
'Flip Horizontal (NEW for 3.0.4 by Woozy)
Private Sub mnuFlipHor_Click()
    Flip Horizontal 'KSNiloc
End Sub
'Flip Vertical (NEW for 3.0.4 by Woozy)
Private Sub mnuFlipVer_Click()
    Flip Vertical  'KSNiloc
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
    publicTile.currentColor = ColorDialog()
    Call vbPicFillRect(tkMainForm.selectedcolor, 0, 0, 100, 100, publicTile.currentColor)

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
    Version1Palette.Show vbModal ', me

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
    RGBDefine.Show vbModal ', me

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub
'Grayscale (EDIT for 3.0.4 by Woozy)
Public Sub gryscle_Click()
    On Error Resume Next
   
    'Use new undo
    Call SetUndo                                                   '<-- Edit
   
    'KSNiloc: NO MORE VARIANTS, darnit =)
    Dim X As Integer, Y As Integer                                 '<-- New
    Dim rr As Long, gg As Long, bb As Long, newavg As Long         '<-- New

    'Start converting
    For X = 1 To xRange
        For Y = 1 To 32
            If tilemem(X, Y) <> -1 Then
                rr = red(tilemem(X, Y))
                gg = green(tilemem(X, Y))
                bb = blue(tilemem(X, Y))
                newavg = (rr + gg + bb) / 3
                If newavg > 255 Then newavg = 255
                If newavg < 0 Then newavg = 0
                tilemem(X, Y) = RGB(newavg, newavg, newavg)
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
'Pencil (NEW for 3.0.4 by Woozy)
Private Sub mnuPencil_Click()
    publicTile.tilemode = 0
    Call ToolSet(publicTile.tilemode)
End Sub
'Color Capture
Private Sub mnuColorCap_Click()
    publicTile.tilemode = 1
    Call ToolSet(publicTile.tilemode)
End Sub
'Flood Fill
Private Sub mnuFloodfill_Click()
    publicTile.tilemode = 2
    Call ToolSet(publicTile.tilemode)
End Sub
'Eraser
Private Sub mnuEraser_Click()
    publicTile.tilemode = 3
    Call ToolSet(publicTile.tilemode)
End Sub
'========================================================================
' Effects Menu
'========================================================================
'Blur (EDIT for 3.0.4 by Woozy)
Private Sub blurmnu_Click()
    On Error GoTo ErrorHandler
    
    'Use new undo
    Call SetUndo
    
    Dim X, Y As Integer                                 '<-- New
    Dim aa As Long                                      '<-- New
    Dim r As Long, g As Long, b As Long                 '<-- New
    Dim r2 As Long, g2 As Long, b2 As Long              '<-- New
    Dim nr As Long, ng As Long, nb As Long              '<-- New
    'Start blurring
    For X = 1 To xRange                                 '<-- Edit
        For Y = 1 To 32
        
            aa = tilemem(X, Y)
            If aa = -1 Then aa = vbQBColor(15)
            r = red(aa) / 2
            aa = tilemem(X, Y)
            If aa = -1 Then aa = vbQBColor(15)
            g = green(aa) / 2
            aa = tilemem(X, Y)
            If aa = -1 Then aa = vbQBColor(15)
            b = blue(aa) / 2
            If X = xRange Then                          '<-- Edit
                aa = tilemem(1, Y)
                If aa = -1 Then aa = vbQBColor(15)
            Else
                aa = tilemem(X + 1, Y)
                If aa = -1 Then aa = vbQBColor(15)
            End If
            r2 = red(aa) / 2
            If X = xRange Then                          '<-- Edit
                aa = tilemem(1, Y)
                If aa = -1 Then aa = vbQBColor(15)
            Else
                aa = tilemem(X + 1, Y)
                If aa = -1 Then aa = vbQBColor(15)
            End If
            g2 = green(aa) / 2
            If X = xRange Then                          '<-- Edit
                aa = tilemem(1, Y)
                If aa = -1 Then aa = vbQBColor(15)
            Else
                aa = tilemem(X + 1, Y)
                If aa = -1 Then aa = vbQBColor(15)
            End If
            b2 = blue(aa) / 2
            nr = inbounds(r + r2, 0, 255)
            ng = inbounds(g + g2, 0, 255)
            nb = inbounds(b + b2, 0, 255)
            If X = xRange Then                          '<-- Edit
                tilemem(1, Y) = RGB(nr, ng, nb)
            Else
                tilemem(X + 1, Y) = RGB(nr, ng, nb)
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
'Texturize (NEW for 3.0.4 by Woozy)
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
'Translucentize (NEW for 3.0.4 by Woozy)
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

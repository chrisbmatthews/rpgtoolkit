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
   Begin VB.PictureBox tileForm 
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
Private Declare Function ExtFloodFill Lib "gdi32" (ByVal hdc As Long, ByVal x As Long, ByVal y As Long, ByVal crColor As Long, ByVal wFillType As Long) As Long

'Create a solid brush object of the color passed in
Private Declare Function CreateSolidBrush Lib "gdi32" (ByVal crColor As Long) As Long

'Assign an object to a device context
Private Declare Function SelectObject Lib "gdi32" (ByVal hdc As Long, ByVal hObject As Long) As Long

'Delete an object
Private Declare Function DeleteObject Lib "gdi32" (ByVal hObject As Long) As Long

'========================================================================
' Variable declaration
'========================================================================

'Main data
Private theData As tileDoc

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
    OneHunderdEighty = 3
End Enum

'========================================================================
' Change the mode to normal/ISO
'========================================================================
Public Sub isoChange( _
                        ByVal isoCheck As Boolean, _
                        Optional ByVal doNotDealWithImport As Boolean _
                                                                        )

    On Error Resume Next

    'Exit sub if the mode is already the called mode
    If isoCheck = publicTile.isometric Then Exit Sub

    If isoCheck Then
        If publicTile.tileneedupdate Then
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
        Dim x As Integer, y As Integer
        For x = 0 To 64
            For y = 0 To 32
                tileMem(x + 1, y + 1) = buftile(x, y)
            Next y
        Next x
        
        xMod = 2
        xRange = 64
        
        'Delete border of the isomirror in TkMainForm
        tkMainForm.isoMirror.BorderStyle = 0
        'Clear mirror in TkMainForm
        Call vbPicFillRect(tkMainForm.mirror, 0, 0, 100, 100, vbQBColor(15))
    Else
        If publicTile.tileneedupdate Then
            If MsgBox("Conversion from isometric to 2D is not possible. The" _
                       & " current tile will be erased. Do you wish to continue?", vbOKCancel + vbExclamation, "Isometric Mode") = vbCancel Then
                tkMainForm.tileIsoCheck.value = 1
                Exit Sub
            End If
        End If
        
        For x = 0 To 64
            For y = 0 To 32
                tileMem(x, y) = -1
            Next y
        Next x
        xMod = 1
        xRange = 32
        
        'Show border of the isomirror in TkMainForm
        tkMainForm.isoMirror.BorderStyle = 1
        tkMainForm.isoMirror.cls
    End If
    
    mnuRotate.Enabled = Not isoCheck
    cutcornermnu.Enabled = Not isoCheck
    mnuSkew.Enabled = Not isoCheck
    convert.Enabled = Not isoCheck
    layer.Enabled = Not isoCheck
    lsrc.Enabled = Not isoCheck
    If Not doNotDealWithImport Then tkMainForm.cmdImport.Enabled = Not isoCheck
    tkMainForm.Command15.Enabled = Not isoCheck
    tkMainForm.Command16.Enabled = Not isoCheck
    tkMainForm.Command18.Enabled = Not isoCheck
    tkMainForm.Command19.Enabled = Not isoCheck
    
    'Update ISO variable
    publicTile.isometric = isoCheck
    'Update tilename
    publicTile.tileName = ""
    'Update caption
    Me.Caption = LoadStringLoc(801, "Tile Editor") + "  (Untitled)"
    
    'Resize/Redraw
    Call Form_Resize
End Sub
'========================================================================
' Set the color to transparant
'========================================================================
Public Sub Command1_Click(): On Error GoTo ErrorHandler
    'Set the current color to transparent
    publicTile.currentColor = -1
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
Public Sub palettebox_MouseDown(button As Integer, Shift As Integer, x As Single, y As Single): On Error GoTo ErrorHandler
    'Set the current color
    publicTile.currentColor = vbFrmPoint(tkMainForm.palettebox, x, y)
    
    'Update selected color picturebox in tkMainForm
    Call vbPicFillRect(tkMainForm.selectedcolor, 0, 0, 100, 100, publicTile.currentColor)
    
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
    If value = 0 Then publicTile.grid = False Else publicTile.grid = True
    'Redraw
    Call tileRedraw
End Sub
'========================================================================
' Scroll
'========================================================================
Public Sub Scroll(ByVal how As SCROLL_TYPE): On Error Resume Next
    'Undo
    Call SetUndo
    
    Dim xx As Integer, yy As Integer
    
    Select Case how
        Case North
            For xx = 1 To 32
                For yy = 1 To 32 - 1
                    buftile(xx, yy) = tileMem(xx, yy + 1)
                Next yy
            Next xx
        
            For xx = 1 To 32
                buftile(xx, 32) = tileMem(xx, 1)
            Next xx
        Case East
            For xx = 1 To 32
                For yy = 1 To 32
                    buftile(xx, yy) = tileMem(xx - 1, yy)
                Next yy
            Next xx
            
            For yy = 1 To 32
                buftile(1, yy) = tileMem(32, yy)
            Next yy
        Case South
            For xx = 1 To 32
                For yy = 1 To 32
                    buftile(xx, yy) = tileMem(xx, yy - 1)
                Next yy
            Next xx
        
            For xx = 1 To 32
                buftile(xx, 1) = tileMem(xx, 32)
            Next xx
        Case West
            For xx = 1 To 32 - 1
                For yy = 1 To 32
                    buftile(xx, yy) = tileMem(xx + 1, yy)
                Next yy
            Next xx
            
            For yy = 1 To 32
                buftile(32, yy) = tileMem(1, yy)
            Next yy
    End Select
    
    'Change the tile
    For xx = 1 To 32
        For yy = 1 To 32
            tileMem(xx, yy) = buftile(xx, yy)
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
    Call SetUndo

    Dim x As Integer, y As Integer, xx As Integer, yy As Integer
   
    'Buff it
    For x = 1 To 32
        For y = 1 To 32
            buftile(x, y) = tileMem(x, y)
        Next y
    Next x
   
    'Reset variables
    yy = 1: xx = 1

    'Start changing the tiles
    Select Case how
        Case Left
            For x = 1 To 32
                For y = 32 To 1 Step -1
                    tileMem(x, y) = buftile(xx, yy)
                    xx = xx + 1
                Next y
                xx = 1
                yy = yy + 1
            Next x
        Case Right
            For x = 32 To 1 Step -1
                For y = 1 To 32
                    tileMem(x, y) = buftile(xx, yy)
                    xx = xx + 1
                Next y
                xx = 1
                yy = yy + 1
            Next x
        Case OneHundredEighty
            For y = 32 To 1 Step -1
                For x = 32 To 1 Step -1
                    tileMem(x, y) = buftile(xx, yy)
                    xx = xx + 1
                Next x
                xx = 1
                yy = yy + 1
            Next y
    End Select
    'Redraw
    Call tileRedraw
End Sub
'========================================================================
' Flips the tile
'========================================================================
Private Sub Flip(ByVal how As FLIP_TYPE)
    'Undo
    Call SetUndo
   
    Dim x As Integer, y As Integer
   
    For x = 1 To 32
        For y = 1 To 32
            If how = Horizontal Then
                buftile(x, y) = tileMem(32 - x + 1, y)
            Else 'Vertical
                buftile(x, y) = tileMem(x, 32 - y + 1)
            End If
        Next y
    Next x
   
    For x = 1 To 32
        For y = 1 To 32
            tileMem(x, y) = buftile(x, y)
        Next y
    Next x

    'Redraw
    Call tileRedraw
End Sub
'========================================================================
' Put the tile in the good undo
'========================================================================
Public Sub SetUndo()
    Dim x As Integer, y As Integer
    
    For x = 1 To xRange
        For y = 1 To 32
            publicTile.Undotile(x, y) = tileMem(x, y)
        Next y
    Next x
End Sub
'========================================================================
' This gets the info from the undo and changes the tile back
'========================================================================
Public Sub GetUndo()
    'ReDim the variable
    ReDim bufundo(64, 32)
    Dim x As Integer, y As Integer
    
    For x = 1 To xRange
        For y = 1 To 32
            bufundo(x, y) = tileMem(x, y)
            tileMem(x, y) = publicTile.Undotile(x, y)
            publicTile.Undotile(x, y) = bufundo(x, y)
        Next y
    Next x

    'Redraw
    Call tileRedraw
End Sub
'========================================================================
' Changes one color to another color in the editor
'========================================================================
Public Sub changeColor()
    'If the user has choosen the color he wants to change, we go through this loop
    If bChangeColor = 2 Then
        Dim x As Integer, y As Integer
        For x = 1 To xRange                            '<-- Edit
            For y = 1 To 32
                If tileMem(x, y) = publicTile.changeColor Then
                    tileMem(x, y) = publicTile.currentColor
                End If
            Next y
        Next x
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
                        ByVal x As Long, _
                        ByVal y As Long, _
                        ByVal crColor As Long _
                                                )

    '========================================================================
    'Re-written by KSNiloc
    '
    ' + Now uses GDI
    ' + Much, much, much faster
    '========================================================================

    On Error Resume Next

    'Make this 'undoable'
    Call SetUndo

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
    Call ExtFloodFill(hdc, x, y, CanvasGetPixel(cnv, x, y), 1)

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
    Call SetUndo
    
    Dim x As Integer, y As Integer
    Dim Canv As Long
    Dim tc As Long, p As Long
    'Create an offscreen canvas, and test it
    Canv = CreateCanvas(xRange, 32)
    tc = RGB(255, 100, 50)
    Call CanvasSetPixel(Canv, 0, 0, tc)
    tc = CanvasGetPixel(Canv, 0, 0)
    
    'Copy the tilemem to the offscreen canvas.
    For x = 1 To xRange
        For y = 1 To 32
            If tileMem(x, y) <> -1 Then
                Call CanvasSetPixel(Canv, x - 1, y - 1, tileMem(x, y))
            Else
                'Set tc (from above) as the transparent color
                Call CanvasSetPixel(Canv, x - 1, y - 1, tc)
                p = CanvasGetPixel(Canv, x - 1, y - 1)
            End If
        Next y
    Next x
        
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
    For x = 1 To xRange
        For y = 1 To 32
            p = CanvasGetPixel(Canv, x - 1, y - 1)
            If p = tc Then
                'Transparent colour.
                tileMem(x, y) = -1
            Else
                tileMem(x, y) = p
            End If
        Next y
    Next x
    
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
    
    Dim x As Integer, y As Integer

    If Not (ignoreDeactivate) Then
        'Refresh data
        For x = 0 To 64
            For y = 0 To 32
                tileMem(x, y) = theData.tileMem(x, y)
            Next y
        Next x
        publicTile = theData
    End If
    
    filename(2) = ""
    ignoreDeactivate = False
    
    'Set mode
    Call isoChange(publicTile.isometric, True)
    If publicTile.isometric Then
        tkMainForm.tileIsoCheck.value = 1
        xRange = 64
        xMod = 2
        isIsoTile = True
        tkMainForm.cmdImport.Enabled = False
    Else
        tkMainForm.tileIsoCheck.value = 0
        xRange = 32
        xMod = 1
        isIsoTile = False
        tkMainForm.cmdImport.Enabled = True
    End If
    
    'Redraw
    Call tileRedraw
    
    'Set the current tool
    Call ToolSet(publicTile.tilemode)
    
    'Set the selected color
    Call vbPicFillRect(tkMainForm.selectedcolor, 0, 0, 1000, 1000, publicTile.currentColor)
    
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
    'Store the data
    theData = publicTile
    
    Dim x As Integer, y As Integer
    
    'Refresh data
    For x = 0 To xRange
        For y = 0 To 32
            theData.tileMem(x, y) = tileMem(x, y)
        Next y
    Next x

    'theData.Isometric = tkMainForm.tileIsoCheck.value
End Sub
'========================================================================
' Form_KeyPress
'========================================================================
Private Sub Form_KeyPress(KeyAscii As Integer): On Error GoTo ErrorHandler
    If UCase(chr(KeyAscii)) = "L" Then
        If lastTileset = "" Then
            Call opentile_Click
            Exit Sub
        End If
        tstFile = lastTileset
        ignoreDeactivate = True
        Call tilesetform.Show(vbModal)
        If setFilename = "" Then Exit Sub

        'Open tile
        Call openTile2(projectPath & tilePath & setFilename)
        
        'Redraw tile
        Call activeTile.highRedraw
        
        'Update filename
        publicTile.tileName = setFilename
        
        'Update caption
        activeTile.Caption = LoadStringLoc(801, "Tile Editor") & "  (" & setFilename & ")"
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
    Dim x As Integer, y As Integer
    For x = 1 To 64
        For y = 1 To 32
            theData.tileMem(x, y) = -1
        Next y
    Next x
    
    'Set some variables for ISO
    xMod = 1
    xRange = 32
    
    theData.grid = True
    
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
    If tfWidth <> tileForm.Width And tfHeight <> tileForm.height Then
        'Set size
        If tfWidth < tfHeight Then
            tileForm.Width = tfWidth
            tileForm.height = tfWidth
        Else
            tileForm.Width = tfHeight
            tileForm.height = tfHeight
        End If
    End If
    
    tileForm.Width = tileForm.height * xMod
    
    'Reduce the width if it's bigger then the tileform
    If (tileForm.Width > Me.Width - 200) Then tileForm.Width = tileForm.Width - 900
    
    'Set location
    tileForm.Left = ((Me.Width - tileForm.Width) / 2) - Screen.TwipsPerPixelX * 4
    tileForm.Top = (Me.height - tileForm.height) / 2 / 2 + Screen.TwipsPerPixelX * 3
    
    'Redraw
    Call tileRedraw
End Sub
'========================================================================
' Form_Unload
'========================================================================
Private Sub Form_Unload(Cancel As Integer): On Error Resume Next
    'Hide all tools
    Call hideAllTools
End Sub
'========================================================================
' Depress tool index, and unpress the others
'========================================================================
Public Sub ToolSet(ByVal Index As Byte): On Error Resume Next
    'If this sub is called during this sub, Exit Sub
    If ignore = 1 Then Exit Sub
    
    ignore = 1
    
    'Update current tool variable
    publicTile.tilemode = Index
    
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
Private Sub highRedraw(): On Error GoTo ErrorHandler
    'Clear tileform and mirrors in TkMainForm
    Call tileForm.cls
    Call tkMainForm.mirror.cls
    Call tkMainForm.isoMirror.cls
    
    'Tileform size in pixels
    Dim wwidth As Integer, hheight As Integer
    wwidth = (tileForm.Width) / Screen.TwipsPerPixelX
    hheight = (tileForm.height) / Screen.TwipsPerPixelY
    
    'Size of a pixel on the tileform
    Dim pixelWidth As Integer, pixelHeight As Integer
    pixelWidth = (wwidth / xRange)
    pixelHeight = (hheight / 32)
    
    Dim x As Integer, y As Integer
    Dim xx As Integer, yy As Integer
    
    For x = 1 To xRange
        For y = 1 To 32
            xx = (x * pixelWidth) - (pixelWidth - 1)
            yy = (y * pixelHeight) - (pixelHeight - 1)
            
            If isoMaskBmp(x, y) <> vbQBColor(0) And publicTile.isometric Then
                'Draw background color pixels at the corners if this tile is isometric
                Call vbPicFillRect(tileForm, xx, yy, xx + (pixelWidth - 1), yy + (pixelHeight - 1), Me.BackColor)
                Call vbPicPSet(tkMainForm.isoMirror, x - 1, y - 1, Me.BackColor)
                
                'Clear the tilemem entry
                tileMem(x, y) = -1
            ElseIf tileMem(x, y) <> -1 Then
                'If the pixel isn't transparent and isn't masked - both isometric and 2D
                    
                Call vbPicFillRect(tileForm, xx - 1, yy - 1, xx + (pixelWidth - 1) - 2, yy + (pixelHeight - 1) - 2, tileMem(x, y))
                
                If publicTile.isometric Then
                    'Draw the isomirror here (moved from tileRedraw.) Don't draw the 2D mirror
                    Call vbPicPSet(tkMainForm.isoMirror, x - 1, y - 1, tileMem(x, y))
                Else
                    'Draw the 2D mirror - isomirror drawn in tileRedraw
                    Call vbPicPSet(tkMainForm.mirror, x - 1, y - 1, tileMem(x, y))
                End If
                
            Else
                'Transparent.
                Call vbPicFillRect(tileForm, xx - 1, yy - 1, xx + pixelWidth / 2 - 2, yy + pixelHeight / 2 - 2, vbQBColor(7))
                Call vbPicFillRect(tileForm, xx + pixelWidth / 2 - 1, yy + pixelHeight / 2 - 1, xx + (pixelWidth - 1) - 2, yy + (pixelHeight - 1) - 2, vbQBColor(7))
            End If
        Next y
    Next x
    
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
    If Not publicTile.grid Then Exit Sub
    
    'Size of form in pixels.
    Dim tfWidth As Integer, tfHeight As Integer
    tfWidth = (tileForm.Width) / Screen.TwipsPerPixelX
    tfHeight = (tileForm.height) / Screen.TwipsPerPixelY

    'Size of a pixel on the tileform
    Dim pixelWidth, pixelHeight As Integer
    pixelWidth = (tfWidth / xRange)
    pixelHeight = (tfHeight / 32)
    
    Dim x As Integer, y As Integer
    'Vertical Lines
    For x = -1 To tfWidth Step pixelWidth
            Call vbPicLine(tileForm, x, -1, x, tfHeight, vbQBColor(1))
    Next x
    'Horizontal Lines
    For y = -1 To tfHeight Step pixelHeight
            Call vbPicLine(tileForm, -1, y, tfWidth, y, vbQBColor(1))
    Next y
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
'========================================================================
' When you click in the Tile Editor
'========================================================================
Private Sub tileform_MouseDown(button As Integer, Shift As Integer, x As Single, y As Single): On Error Resume Next
    publicTile.tileneedupdate = True
        
    'Get current color
    Dim coloruse As Long
    coloruse = publicTile.currentColor
        
    'Tileform size in pixels
    Dim tfWidth As Integer, tfHeight As Integer
    tfWidth = (tileForm.Width) / Screen.TwipsPerPixelX
    tfHeight = (tileForm.height) / Screen.TwipsPerPixelY
        
    'Size of a pixel on the tileform
    Dim pixelWidth, pixelHeight As Integer
    pixelWidth = (tfWidth / xRange)
    pixelHeight = (tfHeight / 32)
        
    'Tile pixel co-ordinates (which pixel selected)
    Dim mouseX As Integer, mouseY As Integer
    mouseX = Int(x / pixelWidth)
    mouseY = Int(y / pixelHeight)
        
    'If a rouge pixel has been selected, Exit Sub
    If mouseX > (xRange - 1) Or mouseY > 31 Then Exit Sub
        
    'If there's clicked in the not-available part, Exit Sub
    If isoMaskBmp(mouseX + 1, mouseY + 1) <> vbQBColor(0) And publicTile.isometric Then Exit Sub
        
    Select Case publicTile.tilemode
        Case 0, 3
                
            'Undo
            Call SetUndo
                
            'If the user wants to erase, set colorUse to -1 (Transparent)
            If publicTile.tilemode = 3 Then
                coloruse = -1
            End If
                
            'Tile pixel co-ordinates (which pixel selected)
            Dim newX, newY As Integer
            newX = (mouseX * pixelWidth) + 1
            newY = (mouseY * pixelHeight) + 1
            
            If (publicTile.isometric And isoMaskBmp(mouseX + 1, mouseY + 1) = vbQBColor(0)) Or Not (publicTile.isometric) Then
                If coloruse = -1 Then
                    'Transparent; Erase
                    Call vbPicFillRect(tileForm, newX - 1, newY - 1, newX + (pixelWidth - 1) - 2, newY + (pixelHeight - 1) - 2, vbQBColor(15))
                    Call vbPicFillRect(tileForm, newX - 1, newY - 1, newX + (pixelWidth / 2) - 2, newY + (pixelHeight / 2) - 2, vbQBColor(7))
                    Call vbPicFillRect(tileForm, newX + (pixelWidth / 2) - 1, newY + (pixelHeight / 2) - 1, newX + (pixelWidth - 1) - 2, newY + (pixelHeight - 1) - 2, vbQBColor(7))
                                           
                    'Draw grid around the tile
                    If publicTile.grid Then
                        Call vbPicRect(tileForm, newX - 1, newY - 1, newX + (pixelWidth - 1), newY + (pixelHeight - 1), vbQBColor(1))
                    End If
                        
                    'Store pixel color
                    tileMem(mouseX + 1, mouseY + 1) = coloruse
                        
                    'Set colorUse to white for the mirrors in TkMainForm
                    coloruse = RGB(255, 255, 255)
                Else
                    'Solid; Paint
                    Call vbPicFillRect(tileForm, newX - 1, newY - 1, newX + (pixelWidth - 2), newY + (pixelHeight - 2), coloruse)
    
                    'Draw grid around the tile
                    If publicTile.grid Then
                        Call vbPicRect(tileForm, newX - 2, newY - 2, newX + (pixelWidth - 1) - 1, newY + (pixelHeight - 1) - 1, vbQBColor(1))
                    End If
    
                    tileMem(mouseX + 1, mouseY + 1) = coloruse
                End If
            End If
            
            'Draw the pixels on the mirrors
            If publicTile.isometric And isoMaskBmp(mouseX + 1, mouseY + 1) = vbQBColor(0) Then
                'Isometric; update isoMirror only
                Call vbPicPSet(tkMainForm.isoMirror, mouseX, mouseY, coloruse)
            ElseIf Not (publicTile.isometric) Then
                '2D; update both mirrors
                Call vbPicPSet(tkMainForm.mirror, mouseX, mouseY, coloruse)
                Call vbPicPSet(tkMainForm.isoMirror, getIsoX(mouseX, mouseY), getIsoY(mouseX, mouseY), coloruse)
            End If
        Case 1 'Eye Dropper
            If bChangeColor = 1 Then
                publicTile.changeColor = tileMem(mouseX + 1, mouseY + 1)
                bChangeColor = 2
                Call changeColor
                Exit Sub
            End If
            
            publicTile.currentColor = tileMem(mouseX + 1, mouseY + 1)
            
            'Update the selected color picturebox in TkMainForm
            Call vbPicFillRect(tkMainForm.selectedcolor, 0, 0, 100, 100, publicTile.currentColor)
            
            'Change the selected tool
            publicTile.tilemode = 0
            Call ToolSet(publicTile.tilemode)
        Case 2 'Fill
            'Undo
            Call SetUndo

            'Fill
            Call fillTile(mouseX + 1, mouseY + 1, coloruse)
    End Select
End Sub
'========================================================================
' When you move the mouse in the Tile Editor
'========================================================================
Private Sub tileform_MouseMove(button As Integer, Shift As Integer, x As Single, y As Single): On Error Resume Next
    'Get current color
    Dim coloruse As Long
    coloruse = publicTile.currentColor
    
    'Tileform size in pixels
    Dim tfWidth As Integer, tfHeight As Integer
    tfWidth = (tileForm.Width) / Screen.TwipsPerPixelX
    tfHeight = (tileForm.height) / Screen.TwipsPerPixelY
        
    'Size of a pixel on the tileform
    Dim pixelWidth, pixelHeight As Integer
    pixelWidth = (tfWidth / xRange)
    pixelHeight = (tfHeight / 32)
        
    'Tile pixel co-ordinates (which pixel selected)
    Dim mouseX As Integer, mouseY As Integer
    mouseX = Int(x / pixelWidth)
    mouseY = Int(y / pixelHeight)
        
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
    
    Dim x1 As Integer, y1 As Integer
    x1 = Int(dragX1 / pixelWidth) * pixelWidth + (pixelWidth / 2)
    y1 = Int(dragY1 / pixelHeight) * pixelHeight + (pixelHeight / 2)
    
    Call vbPicRefresh(tileForm)
    
    'Get the current color
    Dim colUse As Long
    colUse = publicTile.currentColor
    If colUse = -1 Then colUse = 0
    
    Select Case publicTile.tilemode
        Case 4:
            'Line
            If bDragBegin Then
                tileForm.AutoRedraw = False
                Call vbPicLine(tileForm, x1, y1, mouseX, mouseY, colUse)
                tileForm.AutoRedraw = True
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
                tileForm.AutoRedraw = False
                If asp > 1 Then
                    Call vbPicCircle(tileForm, cx, cy, rad * asp, colUse, -1, -1, asp)
                Else
                    Call vbPicCircle(tileForm, cx, cy, rad, colUse, -1, -1, asp)
                End If
                tileForm.AutoRedraw = True
                Exit Sub
            End If
        Case 7, 8:
            '(Filled) Rectangle
            If bDragBegin Then
                tileForm.AutoRedraw = False
                Call vbPicRect(tileForm, x1, y1, mouseX, mouseY, colUse)
                tileForm.AutoRedraw = True
                Exit Sub
            End If
    End Select
    
    Call tileform_MouseDown(button, Shift, x, y)
    bDragBegin = True
    dragX1 = x
    dragY1 = y
End Sub
'========================================================================
' When you release the mouse in the Tile Editor
'========================================================================
Private Sub tileform_MouseUp(button As Integer, Shift As Integer, x As Single, y As Single): On Error Resume Next
    Dim tfWidth As Integer, tfHeight As Integer
    tfWidth = (tileForm.Width) / Screen.TwipsPerPixelX
    tfHeight = (tileForm.height) / Screen.TwipsPerPixelY
    
    Dim pixelWidth As Integer, pixelHeight As Integer
    pixelWidth = (tfWidth / xRange)
    pixelHeight = (tfHeight / 32)
    
    Dim x2 As Integer, y2 As Integer
    Dim x1 As Integer, y1 As Integer
    x2 = Int(x / pixelWidth)
    y2 = Int(y / pixelHeight)
    x1 = Int(dragX1 / pixelWidth)
    y1 = Int(dragY1 / pixelHeight)
    
    If bDragBegin Then
        bDragBegin = False
        Select Case publicTile.tilemode
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
    If publicTile.tileneedupdate = True Then
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
    
    filename$(2) = publicTile.tileName
    publicTile.tileneedupdate = False
    If filename$(2) = "" Then
        Me.Show
        Call savenoquestions_Click
        Exit Sub
    End If
    'Save the tile
    Call saveTile(projectPath$ + tilePath$ + filename$(2))

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
    
    activeTile.Show
    
    ChDir (currentDir$)
    
    Call checkSave      'Check if a tile is already open and needs saving.
    publicTile.tileneedupdate = False
    
    filename$(1) = file$
    antiPath$ = absNoPath(file$)
    
    FileCopy filename$(1), projectPath$ + tilePath$ + antiPath$
    
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
        
        Call openFromTileSet(projectPath$ + tilePath$ + tilesetFilename(setFilename$), getTileNum(setFilename$))
        
        If detail = 2 Or detail = 4 Or detail = 6 Then
            'only 32x32 tiles allowed
            Call increaseDetail
        End If
        Call color_16million
        
        'Now we need to rearrange the pixels in the tilemem from 32x32 to 62x32
        
        If UCase$(whichType$) = "ISO" Then
            Dim xCount As Byte, yCount As Byte, x As Integer, y As Integer
            xCount = 1: yCount = 1
        
            'Now we need to form the 32x32 tile into a 64x32 in tilemem:
            
            'Temporarily hold tilemem in the buffer.
            For xx = 1 To 32
                For yy = 1 To 32
                    buftile(xx, yy) = tileMem(xx, yy)
                Next yy
            Next xx
            
            For xx = 1 To 64
                For yy = 1 To 32
                                
                    If isoMaskBmp(xx, yy) <> RGB(0, 0, 0) Then
                        'Masked pixel.
                        tileMem(xx, yy) = -1
                    Else
                        'Unmasked pixel.
                        tileMem(xx, yy) = buftile(xCount, yCount)
                                            
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
        
        
        Call activeTile.highRedraw
        
        publicTile.tileName$ = setFilename$
        activeTile.Caption = LoadStringLoc(801, "Tile Editor") + "  (" + setFilename$ + ")"
        
    Else
        '.gph
        
        Call openTile2(filename$(1))
        Call activeTile.highRedraw
        publicTile.tileName$ = antiPath$
        activeTile.Caption = LoadStringLoc(801, "Tile Editor") + "  (" + antiPath$ + ")"
        
    End If
    
    Call tileGrid(tkMainForm.tileGrid.value)
End Sub
'========================================================================
' Opens a tile... (EDIT for 3.0.4 by Delano)
'========================================================================
Public Sub opentile_Click(): On Error Resume Next
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + tilePath$
    
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
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    FileCopy filename$(1), projectPath$ + tilePath$ + antiPath$
    whichType$ = GetExt(filename$(1))

    If UCase$(whichType$) = "TST" Or UCase$(whichType$) = "ISO" Then      'Yipes! we've selected an archive!
        tstnum = 0
        tstFile = antiPath
        lastTileset = tstFile
        
        ignoreDeactivate = True
        Call tilesetform.Show(vbModal)
        If setFilename <> "" Then
        
            Call openFromTileSet(projectPath$ + tilePath$ + tilesetFilename(setFilename$), getTileNum(setFilename$))
            
            If detail = 2 Or detail = 4 Or detail = 6 Then
                'only 32x32 tiles allowed
                Call increaseDetail
            End If
            Call color_16million
            
            Call activeTile.highRedraw
            publicTile.tileName$ = setFilename$
            activeTile.Caption = LoadStringLoc(801, "Tile Editor") + "  (" + setFilename$ + ")"
        End If
    Else
        Call openTile2(filename$(1))
        Call activeTile.highRedraw
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
    Call saveTile(projectPath$ + tilePath$ + publicTile.tileName)
    publicTile.tileneedupdate = False
    
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
    
    If publicTile.isometric Then
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
            aa = createNewTileSet(filename$(1), publicTile.isometric)
            If aa > 0 Then
                'MsgBox LoadStringLoc(2019, "Your tile has been added to the tileset")
                MsgBox ("A new tileset has been created: " & chr$(13) & filename$(1) & chr$(13) & " and the first tile added.")
                
                publicTile.tileName = antiPath$ + "1"
                activeTile.Caption = LoadStringLoc(801, "Tile Editor") + " (" + publicTile.tileName + ")"
            End If
        End If
        
    Else
    
        '.gph
        If fileExists(filename(1)) Then
            bb = MsgBox(LoadStringLoc(949, "That file exists.  Are you sure you want to overwrite it?"), vbYesNo)
            If bb = vbNo Then Exit Sub
        End If
        Call saveTile(filename$(1))
        publicTile.tileName = antiPath$
        activeTile.Caption = LoadStringLoc(801, "Tile Editor") + " (" + antiPath$ + ")"
        
    End If 'tst, iso.
    
    Call tkMainForm.fillTree("", projectPath$)
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
    
    If publicTile.isometric Then
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
    
    ChDir (currentDir$)
    
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
            Call insertIntoTileSet(projectPath$ + tilePath$ + tilesetFilename(setFilename$), getTileNum(setFilename$))
            activeTile.Caption = LoadStringLoc(801, "Tile Editor") + " (" + publicTile.tileName$ + ")"
        End If
        
    Else
        'Header couldn't be read - set doesn't exist.
    
        aa = createNewTileSet(filename$(1), publicTile.isometric)
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
'Undo
Private Sub undotilemenu_Click()
    Call GetUndo
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
    Call SetUndo
    
    Dim x As Integer, y As Integer
    For x = 1 To xRange
        For y = 1 To 32
            tileMem(x, y) = -1
        Next y
    Next x
    
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
    Rotate OneHunderdEighty
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
'Grayscale
Public Sub gryscle_Click()
    On Error Resume Next
   
    'Undo
    Call SetUndo
   
    Dim x As Integer, y As Integer
    Dim rr As Long, gg As Long, bb As Long, newavg As Long

    'Start converting
    For x = 1 To xRange
        For y = 1 To 32
            If tileMem(x, y) <> -1 Then
                rr = red(tileMem(x, y))
                gg = green(tileMem(x, y))
                bb = blue(tileMem(x, y))
                newavg = (rr + gg + bb) / 3
                If newavg > 255 Then newavg = 255
                If newavg < 0 Then newavg = 0
                tileMem(x, y) = RGB(newavg, newavg, newavg)
            End If
        Next y
    Next x
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
'Blur
Private Sub blurmnu_Click()
    On Error GoTo ErrorHandler
    
    'Undo
    Call SetUndo
    
    Dim x As Integer, y As Integer
    Dim aa As Long
    Dim r As Long, g As Long, b As Long
    Dim r2 As Long, g2 As Long, b2 As Long
    Dim nr As Long, ng As Long, nb As Long
    'Start blurring
    For x = 1 To xRange
        For y = 1 To 32
        
            aa = tileMem(x, y)
            If aa = -1 Then aa = vbQBColor(15)
            r = red(aa) / 2
            aa = tileMem(x, y)
            If aa = -1 Then aa = vbQBColor(15)
            g = green(aa) / 2
            aa = tileMem(x, y)
            If aa = -1 Then aa = vbQBColor(15)
            b = blue(aa) / 2
            If x = xRange Then
                aa = tileMem(1, y)
                If aa = -1 Then aa = vbQBColor(15)
            Else
                aa = tileMem(x + 1, y)
                If aa = -1 Then aa = vbQBColor(15)
            End If
            r2 = red(aa) / 2
            If x = xRange Then
                aa = tileMem(1, y)
                If aa = -1 Then aa = vbQBColor(15)
            Else
                aa = tileMem(x + 1, y)
                If aa = -1 Then aa = vbQBColor(15)
            End If
            g2 = green(aa) / 2
            If x = xRange Then
                aa = tileMem(1, y)
                If aa = -1 Then aa = vbQBColor(15)
            Else
                aa = tileMem(x + 1, y)
                If aa = -1 Then aa = vbQBColor(15)
            End If
            b2 = blue(aa) / 2
            nr = inBounds(r + r2, 0, 255)
            ng = inBounds(g + g2, 0, 255)
            nb = inBounds(b + b2, 0, 255)
            If x = xRange Then
                tileMem(1, y) = RGB(nr, ng, nb)
            Else
                tileMem(x + 1, y) = RGB(nr, ng, nb)
            End If
        Next y
    Next x
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
    Call light.Show(vbModal)

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
    Call tiletexturize.Show(vbModal)

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
    Call tileTranslucentize.Show(vbModal)

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
    Call tkMainForm.testgamemnu_Click
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

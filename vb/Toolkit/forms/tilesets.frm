VERSION 5.00
Begin VB.Form tilesetForm 
   Caption         =   "Tiles"
   ClientHeight    =   3375
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4875
   Icon            =   "tilesets.frx":0000
   LinkTopic       =   "Form2"
   ScaleHeight     =   3375
   ScaleWidth      =   4875
   StartUpPosition =   1  'CenterOwner
   Tag             =   "1834"
   Begin VB.VScrollBar tilesetBrowserScroll 
      Height          =   2415
      Left            =   4440
      TabIndex        =   1
      TabStop         =   0   'False
      Top             =   360
      Width           =   255
   End
   Begin VB.PictureBox tiles 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BackColor       =   &H8000000C&
      ForeColor       =   &H80000008&
      Height          =   2415
      Left            =   120
      ScaleHeight     =   159
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   287
      TabIndex        =   0
      Top             =   360
      Width           =   4335
   End
   Begin VB.Frame toolFrame 
      BorderStyle     =   0  'None
      Height          =   615
      Left            =   0
      TabIndex        =   3
      Top             =   2760
      Width           =   4815
      Begin VB.CheckBox iso 
         Height          =   375
         Left            =   360
         Picture         =   "tilesets.frx":0CCA
         Style           =   1  'Graphical
         TabIndex        =   4
         ToolTipText     =   "Isometric View"
         Top             =   120
         Width           =   375
      End
      Begin VB.CheckBox drawGridCheck 
         Height          =   375
         Left            =   0
         Picture         =   "tilesets.frx":1994
         Style           =   1  'Graphical
         TabIndex        =   5
         Tag             =   "1227"
         ToolTipText     =   "Grid on/off"
         Top             =   120
         Value           =   1  'Checked
         Width           =   375
      End
      Begin VB.Label Label1 
         Caption         =   "Note: You can hit the 'L' key to open up the last tileset you were using."
         ForeColor       =   &H00808080&
         Height          =   495
         Left            =   1440
         TabIndex        =   6
         Tag             =   "1835"
         Top             =   120
         Width           =   3255
      End
   End
   Begin VB.Label Info 
      Caption         =   "Label1"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   120
      TabIndex        =   2
      Tag             =   "1836"
      Top             =   0
      Width           =   3495
   End
End
Attribute VB_Name = "tilesetForm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'==============================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'==============================================================================

'==============================================================================
'Pop-up tileset browser (from keypress "L", or for saving into tst)
'==============================================================================

Option Explicit

Private Sub drawTstGrid(): On Error Resume Next
'==============================================================================
'draws openTileEditorDocs(activeTile.indice).grid around tileset tiles
'==============================================================================
    Dim x As Integer, y As Integer, tilesWide As Integer, tilesHigh As Integer
    
    If drawGridCheck.value = 0 Then Exit Sub
    
    tilesHigh = Int((tiles.height / Screen.TwipsPerPixelY) / 32)
    tilesWide = Int((tiles.width / Screen.TwipsPerPixelX) / 32)
    
    'Draw vertical lines.
    If iso.value = 0 Then
        'Not isometric
        For x = 0 To tilesWide * 32 Step 32
            Call vbPicLine(tiles, x, 0, x, tilesHigh * 32, vbQBColor(1))
        Next x
    Else
        For x = 0 To tilesWide * 32 Step 64
            Call vbPicLine(tiles, x, 0, x, tilesHigh * 32, vbQBColor(1))
        Next x
        
    End If
    
    'Draw horizontal lines.
    For y = 0 To (tilesHigh + 1) * 32 Step 32
        Call vbPicLine(tiles, 0, y, tilesWide * 32, y, vbQBColor(1))
    Next y
    
End Sub

Private Sub redraw(): On Error Resume Next
'==============================================================================
'Draws the tileset. Note all calls are autoRefresh = True
'==============================================================================
    Dim tilesWide As Integer, tilesHigh As Integer, isoFormat As Long
    
    If tstFile = "" Then Exit Sub
    If tstnum = 0 Then tstnum = 1
    
    tiles.AutoRedraw = True
    
    Call GFXInitScreen(640, 480)
    
    'Calculate the number of visible tiles.
    If iso.value = 0 Then
        tilesWide = Int((tiles.width / Screen.TwipsPerPixelX) / 32)
    Else
        tilesWide = Int((tiles.width / Screen.TwipsPerPixelX) / 64)
    End If
    tilesHigh = Int((tiles.height / Screen.TwipsPerPixelY) / 32)
    
    isoFormat = iso.value
    If UCase$(GetExt(tstFile)) = "ISO" And Not (iso.Enabled) Then isoFormat = 2
    
    'This export requires isoformat = 2 for .iso tiles.
    'tstnum is the tile to start drawing at.
    Call GFXdrawTstWindow(projectPath & tilePath & tstFile, tiles.hdc, tstnum, tilesWide, tilesHigh, isoFormat)

    Call drawTstGrid
    
    tiles.Refresh

End Sub

Private Sub drawGridCheck_Click(): On Error Resume Next
'==============================================================================
'Draw grid check button.
'==============================================================================
    Call redraw
End Sub

Private Sub Form_Load(): On Error Resume Next
'==============================================================================
'Entry point.
'==============================================================================
    Dim x As Integer, y As Integer, setType As Integer
    
    Call LocalizeForm(Me)
    
    setFilename = ""
    If tstnum = 0 Then tstnum = 1
    
    'Put the current tilemem into the buffer.
    For x = 1 To 32
        For y = 1 To 32
            bufTile(x, y) = tileMem(x, y)
        Next y
    Next x
    
    'Get the type and header of the selected set.
    setType = tilesetInfo(projectPath & tilePath & tstFile)
    If setType = TSTTYPE Or setType = ISOTYPE Then
        'tilesetInfo now returns 2 for isometric tilesets. Set type constants introduced.
    
        Info.Caption = LoadStringLoc(2035, "Tileset") & " " & tstFile & LoadStringLoc(2036, ": Contains") & str(tileset.tilesInSet) & " Tiles"
        
        'If we've selected a .iso, disable the iso button. Or check?
        If setType = ISOTYPE Then
            iso.value = 1
            iso.Enabled = False
        Else
            iso.value = 0
            iso.Enabled = True
        End If
        
        Dim tilesWide As Integer, tilesHigh As Integer
        
        'Set the scroller depending on the tileset type.
        If setType = ISOTYPE Then
            tilesWide = (tiles.width / Screen.TwipsPerPixelY) / 64
        Else
            tilesWide = (tiles.width / Screen.TwipsPerPixelY) / 32
        End If
        tilesHigh = (tiles.height / Screen.TwipsPerPixelY) / 32
        
        'This will return the number of wholly occupied rows + 1.
        tilesetBrowserScroll.max = (Int(tileset.tilesInSet / tilesWide)) - tilesHigh + 1
        
        If tilesetBrowserScroll.max < 1 Then
            'If all the tiles are contained in the window.
            tilesetBrowserScroll.Enabled = False
        Else
            'Clicking the bar (not button). Scrolls to the last row (last row becomes top row).
            tilesetBrowserScroll.LargeChange = tilesHigh - 1
            tilesetBrowserScroll.Enabled = True
        End If

        'Jump to the previously row.
        tilesetBrowserScroll.value = tstnum \ tilesWide
        
        tiles.AutoRedraw = False
        
        Call redraw
    End If

End Sub

Private Sub Form_Resize(): On Error Resume Next
'==============================================================================
'Resize (maximize or drag)
'==============================================================================
   
    Dim pixelWidth As Single, pixelHeight As Single
    Dim tilesWide As Integer, tilesHigh As Integer
    
    'New form width in pixels
    pixelWidth = Me.width / Screen.TwipsPerPixelX
    pixelHeight = Me.height / Screen.TwipsPerPixelY
    
    'Size the tile picture box can be. Take off border allowances (32px x, 64px y).
    If iso.value = 1 Then
        tilesWide = Int(pixelWidth / 64) - 1
    Else
        tilesWide = Int(pixelWidth / 32) - 1
    End If
    tilesHigh = Int(pixelHeight / 32) - 2
    
    'If the height of the components is greater than the form, reduce the number of tile rows.
    If (tilesHigh * 32 * Screen.TwipsPerPixelY + tiles.Top + toolFrame.height + 250 > Me.height) Then
        tilesHigh = tilesHigh - 1
    End If

    'Set the size of the tiles picture box.
    If iso.value = 1 Then
        tiles.width = tilesWide * 64 * Screen.TwipsPerPixelX
    Else
        tiles.width = tilesWide * 32 * Screen.TwipsPerPixelX
    End If
    tiles.height = tilesHigh * 32 * Screen.TwipsPerPixelY
    
    'Align the scroller to the tile window.
    tilesetBrowserScroll.Left = tiles.Left + tiles.width
    tilesetBrowserScroll.height = tiles.height
    
    'Align the tools frame (under the tile box).
    toolFrame.Top = tiles.Top + tiles.height

    tilesetBrowserScroll.max = (Int(tileset.tilesInSet / tilesWide)) - tilesHigh + 1
    
    If tilesetBrowserScroll.max < 1 Then
        'If all the tiles are contained in the window.
        tilesetBrowserScroll.Enabled = False
    Else
        'Clicking the bar (not button). Scrolls to the last row (last row becomes top row).
        tilesetBrowserScroll.LargeChange = tilesHigh - 1
        tilesetBrowserScroll.Enabled = True
    End If

    Call tilesetBrowserScroll_Change

End Sub

Private Sub Form_Unload(Cancel As Integer): On Error Resume Next
'==============================================================================
'Unload - restore tilemem from the buffer.
'==============================================================================
    Dim x As Byte, y As Byte
    
    For x = 1 To 32
        For y = 1 To 32
            tileMem(x, y) = bufTile(x, y)
        Next y
    Next x

End Sub

Private Sub iso_Click(): On Error Resume Next
'==============================================================================
'Isometric check button.
'==============================================================================
    tilesetBrowserScroll.value = 0
    Call Form_Resize
    
End Sub

Private Sub tiles_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single): On Error Resume Next
'==============================================================================
'Mouse down on the tile area. Sets the global SetFilename$
'which is used for opening tiles in the tile editor.
'==============================================================================
    Dim tX As Integer, tY As Integer, xx As Integer, yy As Integer, num As Integer
    
    'Calculate the number of tiles that will fit on the form.
    If iso.value = 0 Then
        tX = Int((tiles.width / Screen.TwipsPerPixelX) / 32)
    Else
        tX = Int((tiles.width / Screen.TwipsPerPixelX) / 64)
    End If
    tY = Int((tiles.height / Screen.TwipsPerPixelY) / 32)
    
    'Determine the tile that has been clicked on by considering the
    'size of the form, the position of the scroller, and the type of
    'tileset.
    
    If iso.value = 0 Then
        xx = Int(x / 32)
    Else
        xx = Int(x / 64)
    End If
    yy = Int(y / 32)
    
    num = yy * tX + xx
    num = num + tilesetBrowserScroll.value * tX + 1
    
    'Check we've not selected a tile that isn't in the set.
    If openTileEditorDocs(activeTile.indice).bAllowExtraTst = True Then
        'When selecting "Save Into Tileset..." from the tile editor menu, the tilesetform is
        'called to allow selection of the position to insert the tile.
        If num > tileset.tilesInSet + 1 Then Exit Sub
    Else
        If num > tileset.tilesInSet Then Exit Sub
    End If
    
    setFilename = tstFile & CStr(num)         'Set the tile name for opening in tileedit.
    ignore = 1
    
    Unload tilesetForm

End Sub

Private Sub tilesetBrowserScroll_Change(): On Error Resume Next
'==============================================================================
'Scroll the set.
'==============================================================================
    Dim tilesWide As Integer, tilesHigh As Integer
    
    If tstFile = "" Then Exit Sub
    If tstnum = 0 Then tstnum = 1
    
    tiles.AutoRedraw = False
    
    'Calculate the first tile to show.
    
    If iso.value = 0 Then
        'Not isometric.
        tilesWide = Int((tiles.width / Screen.TwipsPerPixelX) / 32)
    Else
        tilesWide = Int((tiles.width / Screen.TwipsPerPixelX) / 64)
    End If
    tilesHigh = Int((tiles.height / Screen.TwipsPerPixelY) / 32)
    
    tstnum = (tilesetBrowserScroll.value * tilesWide) + 1      '.value is now the row.

    Call tiles.cls
    Call redraw
End Sub

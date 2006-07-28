VERSION 5.00
Begin VB.UserControl ctlTilesetToolbar 
   ClientHeight    =   6360
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   4800
   ScaleHeight     =   424
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   320
   Begin VB.CommandButton cmdOpen 
      Height          =   375
      Left            =   4320
      Picture         =   "ctlTilesetToolbar.ctx":0000
      Style           =   1  'Graphical
      TabIndex        =   6
      Top             =   360
      Width           =   375
   End
   Begin VB.CommandButton cmdClose 
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   220
      Left            =   4560
      Picture         =   "ctlTilesetToolbar.ctx":038A
      Style           =   1  'Graphical
      TabIndex        =   3
      Top             =   0
      Width           =   220
   End
   Begin VB.CheckBox chkGrid 
      Height          =   375
      Left            =   3960
      Picture         =   "ctlTilesetToolbar.ctx":04D4
      Style           =   1  'Graphical
      TabIndex        =   2
      Top             =   360
      Width           =   375
   End
   Begin VB.PictureBox picTileset 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BackColor       =   &H00808080&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   5535
      Left            =   60
      ScaleHeight     =   369
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   288
      TabIndex        =   1
      Top             =   720
      Width           =   4320
   End
   Begin VB.VScrollBar hsbTileset 
      Height          =   5535
      Left            =   4470
      TabIndex        =   0
      TabStop         =   0   'False
      Top             =   720
      Width           =   255
   End
   Begin VB.Label lblCurrentTileset 
      BackColor       =   &H00808080&
      Caption         =   "Current Tileset"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000F&
      Height          =   225
      Left            =   0
      TabIndex        =   5
      Top             =   0
      Width           =   4800
   End
   Begin VB.Label lblTileset 
      Caption         =   "Current tileset"
      Height          =   255
      Left            =   0
      TabIndex        =   4
      Top             =   390
      Width           =   4335
   End
End
Attribute VB_Name = "ctlTilesetToolbar"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'========================================================================
'All contents copyright 2006 Jonathan D. Hughes
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'========================================================================

Option Explicit

Private Declare Function GFXdrawTileset Lib "actkrt3.dll" (ByVal file As String, ByVal hdc As Long, ByVal startIdx As Long, ByVal pxWidth As Long, ByVal pxHeight As Long, ByVal isometric As Boolean) As Long
Private Declare Function BRDRoundToTile Lib "actkrt3.dll" (ByRef x As Double, ByRef y As Double, ByVal bIsometric As Boolean, ByVal bAddBasePoint As Boolean) As Long

Private m_isometric As Boolean
Private m_ignoreResize As Boolean
Private m_tsHeader As tilesetHeader

'============================================================================
'Open tileset button at the top of the flyout tileset viewer.
'============================================================================
Private Sub cmdOpen_Click(): On Error Resume Next
    
    'Set up the dialog window for opening the tileset.
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath & tilePath
    dlg.strTitle = "Select Tileset"
    dlg.strDefaultExt = "tst"
    dlg.strFileTypes = "Supported Types|*.tst;*.iso|RPG Toolkit TileSet (*.tst)|*.tst|RPG Toolkit Isometric TileSet (*.iso)|*.iso|All files(*.*)|*.*"
    
    If Not OpenFileDialog(dlg, tkMainForm.hwnd) Then Exit Sub
    
    If LenB(dlg.strSelectedFileNoPath) = 0 Then Exit Sub
    
    'Globals
    configfile.lastTileset = dlg.strSelectedFileNoPath
    tstFile = dlg.strSelectedFileNoPath
    tstnum = 0
    
    Call resize
End Sub

Private Sub cmdclose_Click(): On Error Resume Next
    tkMainForm.popButton(2).value = 0
End Sub

'============================================================================
' Current tileset browser draw grid check button.
'============================================================================
Private Sub chkGrid_Click(): On Error Resume Next
    Call resize
End Sub

Private Sub draw(): On Error Resume Next

    If LenB(configfile.lastTileset) = 0 Then Exit Sub
    If tstnum = 0 Then tstnum = 1
    
    picTileset.Cls
    Call GFXdrawTileset( _
        projectPath & tilePath & configfile.lastTileset, _
        picTileset.hdc, _
        tstnum, _
        picTileset.width, _
        picTileset.Height, _
        m_isometric _
    )
    
    'Hijack some board code.
    If chkGrid.value Then
        Dim pCEd As New CBoardEditor
        pCEd.topY = 16
        Call modBoard.gridDraw( _
            picTileset, _
            pCEd, _
            m_isometric, _
            IIf(m_isometric, 64, 32), _
            IIf(m_isometric, 32, 32) _
        )
    End If
        
    picTileset.Refresh
    
End Sub

Public Sub resize(Optional ByVal visible As Boolean = True): On Error Resume Next
    
    Dim setType As Long
            
    'Prevent the scroller changing for this sub.
    m_ignoreResize = True
    
    picTileset.Height = UserControl.ScaleHeight - picTileset.Top
    picTileset.Height = picTileset.Height - (picTileset.Height Mod 32)
    picTileset.width = UserControl.ScaleWidth - hsbTileset.width
    picTileset.width = picTileset.width - (picTileset.width Mod 32)
    hsbTileset.Height = picTileset.Height
    hsbTileset.Left = picTileset.Left + picTileset.width
        
    If LenB(configfile.lastTileset) Then
    
        'Load the tileset details via the global 'tileset'.
        setType = tilesetInfo(projectPath & tilePath & configfile.lastTileset)
        If setType <> TSTTYPE And setType <> ISOTYPE Then Exit Sub
        
        m_tsHeader = tileset
        m_isometric = (setType = ISOTYPE)
        
        'Override the isometric setting for isometric boards.
        If Not (tkMainForm.activeForm Is Nothing) Then
            If tkMainForm.activeForm.formType = FT_BOARD Then
                If activeBoard.isIsometric Then m_isometric = True
            End If
        End If
        
        lblTileset.Caption = configfile.lastTileset & " (0 /" & CStr(m_tsHeader.tilesInSet) & ")"

        'Set the scroller depending on the tileset type.
        Dim tWidth As Long, tHeight As Long
        If m_isometric Then
            tWidth = picTileset.width / 32 - 1
            tHeight = picTileset.Height / 32
        Else
            tWidth = picTileset.width / 32
            tHeight = picTileset.Height / 32
        End If
        
        'This will return the number of rows. Negative signs make use of
        'Int's handling of negative numbers to always round *down*.
        'Now we have the number of rows, but we want to stop when the last row
        'is at the bottom of the window. Take off the viewable number of rows.
        
        hsbTileset.max = (-Int(m_tsHeader.tilesInSet / (-tWidth))) - tHeight
                    
        If hsbTileset.max < 1 Then
            'If all the tiles are contained in the window.
            hsbTileset.Enabled = False
        Else
            'Clicking the bar (not button). Scrolls to the last row (last row becomes top row).
            hsbTileset.LargeChange = tHeight - 1
            hsbTileset.Enabled = True
        End If
                
        hsbTileset.value = 0
        
        If visible Then Call draw
    
    Else
        'No tileset has been previously opened.
        hsbTileset.Enabled = False
    End If
    
    cmdOpen.Left = hsbTileset.Left - (cmdOpen.width - hsbTileset.width)
    chkGrid.Left = cmdOpen.Left - chkGrid.width
    cmdClose.Left = tkMainForm.tilesetBar.ScaleWidth - cmdClose.width
    lblCurrentTileset.width = tkMainForm.tilesetBar.ScaleWidth
    
    'Activate the scroller.
    m_ignoreResize = False
End Sub

Private Sub picTileset_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single): On Error Resume Next

    Dim idx As Long, formType As Long, filename As String
    
    If LenB(configfile.lastTileset) = 0 Then Exit Sub

    idx = getTileIndex(x, y)
    
    filename = configfile.lastTileset & CStr(idx)
    
    'Assign the global
    setFilename = filename
    
    'Inform the system that the set filename has changed. For loading into whichever editor is active.
    formType = activeForm.formType
    Select Case formType
        Case FT_BOARD, FT_ANIMATION, FT_TILEBITMAP, FT_TILEANIM
            'These editors have specific uses for the tileset browser.
            Call activeForm.changeSelectedTile(filename)
            
        Case Else
            'It's not a form that uses the tile browser, so load it in the tile editor.
            Dim newTile As New tileedit
            Set activeTile = newTile
            activeTile.Show
            Call activeTile.openFile(projectPath & tilePath & filename)
            
    End Select

End Sub

Private Sub hsbTileset_Change(): On Error Resume Next
    Dim tWidth As Long
    
    If Not m_ignoreResize Then
        Call picTileset.SetFocus
        
        'global - tstnum is the first tile to draw (tile in top lefthand corner).
        If m_isometric Then
            tWidth = picTileset.width / 32 - 1
            tstnum = (hsbTileset.value * tWidth) + 1
        Else
            tWidth = picTileset.width / 32
            tstnum = (hsbTileset.value * tWidth) + 1
        End If
        
        Call draw
    End If
End Sub

Private Sub picTileset_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
    Dim idx As Long
    idx = getTileIndex(x, y)
    lblTileset.Caption = configfile.lastTileset & " (" & CStr(idx) & " /" & CStr(m_tsHeader.tilesInSet) & ")"
End Sub

Private Function getTileIndex(ByVal x As Double, ByVal y As Double) As Long ':on error resume next
    
    Dim tWidth As Long, startIdx As Long, idx As Long, row As Long
    If m_isometric Then
        
        tWidth = picTileset.width / 32 - 1
        startIdx = (hsbTileset.value * tWidth) + 1
        
        'Round to the centre of the tile (top corner is +16 compared to boards)
        y = y + 16
        Call BRDRoundToTile(x, y, True, False)
        y = y - 16
        
        'Left-staggered row or right-staggered?
        If y Mod 32 = 16 Then
            'Upper / left
            idx = (x + 32) / 64
        Else
            'Lower / right
            'Add the number of tiles in the left-staggered row.
            idx = x / 64 + Fix((tWidth + 0.5) / 2)
        End If
        
        'Row number (left + right = 1 row)
        row = Fix((y + 16) / 32) - 1
        idx = idx + tWidth * row + startIdx - 1
        
    Else
    
        tWidth = picTileset.width / 32
        startIdx = (hsbTileset.value * tWidth) + 1
        idx = tWidth * Fix(y / 32) + Fix(x / 32) + startIdx
        
    End If
    
    If idx > m_tsHeader.tilesInSet Then idx = m_tsHeader.tilesInSet
    If idx < 1 Then idx = 1
    getTileIndex = idx
End Function

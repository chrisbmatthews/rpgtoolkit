VERSION 5.00
Begin VB.UserControl ctlTilesetToolbar 
   ClientHeight    =   4035
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   4800
   ScaleHeight     =   269
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   320
   Begin VB.CommandButton cmdOpen 
      Height          =   375
      Left            =   4320
      Picture         =   "ctlTilesetToolbar.ctx":0000
      Style           =   1  'Graphical
      TabIndex        =   4
      Top             =   0
      Width           =   375
   End
   Begin VB.CheckBox chkGrid 
      Height          =   375
      Left            =   3960
      Picture         =   "ctlTilesetToolbar.ctx":038A
      Style           =   1  'Graphical
      TabIndex        =   2
      Top             =   0
      Width           =   375
   End
   Begin VB.PictureBox picTileset 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BackColor       =   &H00808080&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   3495
      Left            =   60
      ScaleHeight     =   233
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   288
      TabIndex        =   1
      Top             =   360
      Width           =   4320
   End
   Begin VB.VScrollBar hsbTileset 
      Height          =   3495
      Left            =   4440
      TabIndex        =   0
      TabStop         =   0   'False
      Top             =   360
      Width           =   255
   End
   Begin VB.Label lblTileset 
      Caption         =   "Current tileset"
      Height          =   255
      Left            =   0
      TabIndex        =   3
      Top             =   30
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

Private m_extraTile As Boolean
Private m_isometric As Boolean
Private m_ignoreResize As Boolean
Private m_tsHeader As tilesetHeader
Private m_filename As String

'============================================================================
'Enable or disable all controls.
'============================================================================
Public Property Let Enabled(ByVal enable As Boolean): On Error Resume Next
    Dim ctl As Control
    For Each ctl In UserControl
        ctl.Enabled = enable
    Next ctl
    If enable Then
        Call draw
    Else
        picTileset.Cls
    End If
End Property

'============================================================================
'Open tileset button at the top of the flyout tileset viewer.
'============================================================================
Private Sub cmdOpen_Click(): On Error Resume Next
    Dim file As String, fileTypes As String
    fileTypes = "Supported Types|*.tst;*.iso|RPG Toolkit TileSet (*.tst)|*.tst|RPG Toolkit Isometric TileSet (*.iso)|*.iso|All files(*.*)|*.*"
    
    If browseFileDialog(tkMainForm.hwnd, projectPath & tilePath, "Select tileset", "tst", fileTypes, m_filename) Then
        'Globals
        configfile.lastTileset = m_filename
        tstFile = m_filename
        tstnum = 1
        Call resize(m_filename, m_extraTile)
    End If
End Sub

'============================================================================
' Current tileset browser draw grid check button.
'============================================================================
Private Sub chkGrid_Click(): On Error Resume Next
    Call resize(m_filename, m_extraTile)
End Sub

Private Sub draw(): On Error Resume Next

    If LenB(m_filename) = 0 Then Exit Sub
    If tstnum = 0 Then tstnum = 1
    
    picTileset.Cls
    Call GFXdrawTileset( _
        projectPath & tilePath & m_filename, _
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

Public Sub resize(ByVal filename As String, Optional ByVal allowExtraTile As Boolean, Optional ByVal visible As Boolean = True): On Error Resume Next
    
    Dim setType As Long
            
    'Prevent the scroller changing for this sub.
    m_ignoreResize = True
    'Allow 1 + last tile to be selected for saving into tileset.
    m_extraTile = allowExtraTile
    m_filename = filename
    
    picTileset.Height = UserControl.ScaleHeight - picTileset.Top
    picTileset.Height = picTileset.Height - (picTileset.Height Mod 32)
    picTileset.width = UserControl.ScaleWidth - hsbTileset.width
    picTileset.width = picTileset.width - (picTileset.width Mod 32)
    hsbTileset.Height = picTileset.Height
    hsbTileset.Left = picTileset.Left + picTileset.width
        
    If LenB(m_filename) Then
    
        'Load the tileset details via the global 'tileset'.
        setType = tilesetInfo(projectPath & tilePath & m_filename)
        If setType <> TSTTYPE And setType <> ISOTYPE Then Exit Sub
        
        m_tsHeader = tileset
        m_isometric = (setType = ISOTYPE)
        
        'Override the isometric setting for isometric boards.
        If Not (activeForm Is Nothing) Then
            If activeForm.formType = FT_BOARD Then
                If activeBoard.isIsometric Then m_isometric = True
            End If
        End If
        
        lblTileset.Caption = m_filename & " (0 / " & CStr(m_tsHeader.tilesInSet) & ")"

        'Set the scroller depending on the tileset type.
        Dim tWidth As Long, tHeight As Long
        If m_isometric Then
            tWidth = picTileset.width / 32 - 1
            tHeight = picTileset.Height / 32 - 1
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
        tstnum = 1
        
        If visible Then Call draw
    
    Else
        'No tileset has been previously opened.
        hsbTileset.Enabled = False
    End If
    
    cmdOpen.Left = hsbTileset.Left - (cmdOpen.width - hsbTileset.width)
    chkGrid.Left = cmdOpen.Left - chkGrid.width
    
    'Activate the scroller.
    m_ignoreResize = False
End Sub

Private Sub picTileset_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single): On Error Resume Next

    Dim idx As Long, formType As Long
    
    If LenB(m_filename) = 0 Then Exit Sub

    idx = getTileIndex(x, y)
    
    'Assign the global
    setFilename = m_filename & CStr(idx)
    
    Call UserControl.Parent.ctlTilesetMouseDown(m_filename & CStr(idx))

End Sub

Private Sub picTileset_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single): On Error Resume Next

    Dim idx As Long, formType As Long
    
    If LenB(m_filename) = 0 Then Exit Sub

    idx = getTileIndex(x, y)
    
    'Assign the global
    setFilename = m_filename & CStr(idx)
    
    Call UserControl.Parent.ctlTilesetMouseUp(m_filename & CStr(idx))

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
    lblTileset.Caption = m_filename & " (" & CStr(idx) & " / " & CStr(m_tsHeader.tilesInSet) & ")"
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
    
    Dim max As Long
    max = m_tsHeader.tilesInSet + IIf(m_extraTile, 1, 0)
    
    If idx > max Then idx = max
    If idx < 1 Then idx = 1
    
    getTileIndex = idx
End Function

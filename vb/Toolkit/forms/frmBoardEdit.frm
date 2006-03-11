VERSION 5.00
Begin VB.Form frmBoardEdit 
   Caption         =   "frmBoardEdit"
   ClientHeight    =   6465
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   10200
   LinkTopic       =   "Form1"
   MDIChild        =   -1  'True
   ScaleHeight     =   480
   ScaleMode       =   0  'User
   ScaleWidth      =   640
   Begin VB.VScrollBar vScroll 
      Height          =   5775
      Left            =   9360
      SmallChange     =   32
      TabIndex        =   2
      TabStop         =   0   'False
      Top             =   120
      Width           =   255
   End
   Begin VB.HScrollBar hScroll 
      Height          =   255
      Left            =   120
      SmallChange     =   32
      TabIndex        =   1
      TabStop         =   0   'False
      Top             =   5880
      Width           =   9255
   End
   Begin VB.PictureBox picBoard 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   5775
      Left            =   120
      ScaleHeight     =   385
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   617
      TabIndex        =   0
      Top             =   120
      Width           =   9255
      Begin VB.Line lineSelection 
         BorderStyle     =   2  'Dash
         DrawMode        =   6  'Mask Pen Not
         Index           =   3
         Visible         =   0   'False
         X1              =   128
         X2              =   128
         Y1              =   64
         Y2              =   128
      End
      Begin VB.Line lineSelection 
         BorderStyle     =   2  'Dash
         DrawMode        =   6  'Mask Pen Not
         Index           =   2
         Visible         =   0   'False
         X1              =   32
         X2              =   32
         Y1              =   64
         Y2              =   128
      End
      Begin VB.Line lineSelection 
         BorderStyle     =   2  'Dash
         DrawMode        =   6  'Mask Pen Not
         Index           =   1
         Visible         =   0   'False
         X1              =   32
         X2              =   128
         Y1              =   128
         Y2              =   128
      End
      Begin VB.Line lineSelection 
         BorderStyle     =   2  'Dash
         DrawMode        =   6  'Mask Pen Not
         Index           =   0
         Visible         =   0   'False
         X1              =   32
         X2              =   128
         Y1              =   64
         Y2              =   64
      End
      Begin VB.Line lineGrid 
         DrawMode        =   6  'Mask Pen Not
         Index           =   0
         Visible         =   0   'False
         X1              =   32
         X2              =   128
         Y1              =   32
         Y2              =   32
      End
   End
End
Attribute VB_Name = "frmBoardEdit"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'========================================================================
'All contents copyright 2006 Jonathan D. Hughes
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'========================================================================
'Note to self: wip = temporary additions to old code.

Option Explicit

Private Declare Function ExtFloodFill Lib "gdi32" (ByVal hdc As Long, ByVal x As Long, ByVal y As Long, ByVal crColor As Long, ByVal wFillType As Long) As Long
Private Declare Function CreateSolidBrush Lib "gdi32" (ByVal crColor As Long) As Long
Private Declare Function SelectObject Lib "gdi32" (ByVal hdc As Long, ByVal hObject As Long) As Long
Private Declare Function DeleteObject Lib "gdi32" (ByVal hObject As Long) As Long

Private Declare Function BRDRender Lib "actkrt3.dll" (ByVal pEditorData As Long, ByVal hdcCompat As Long, Optional ByVal layer As Long = 0) As Long
Private Declare Function BRDDraw Lib "actkrt3.dll" (ByVal pEditorData As Long, ByVal hdc As Long, ByVal destX As Long, ByVal destY As Long, ByVal brdX As Long, ByVal brdY As Long, ByVal width As Long, ByVal Height As Long, ByVal zoom As Double) As Long
Private Declare Function BRDFree Lib "actkrt3.dll" (ByVal pCBoard As Long) As Long
Private Declare Function BRDRenderTile Lib "actkrt3.dll" (ByVal pCBoard As Long, ByVal pData As Long, ByVal hdcCompat As Long, ByVal x As Long, ByVal y As Long, ByVal z As Long) As Long
Private Declare Function BRDNewCBoard Lib "actkrt3.dll" (ByVal projectPath As String) As Long

Private m_editorData As TKBoardEditorData

'=========================================================================
'=========================================================================
Private Sub initializeEditor(ByRef ed As TKBoardEditorData) ': On Error Resume Next
    ' Assign default values.
    Call resetEditor(ed)
    With ed
        .zoom = 1
        If (.pCBoard) Then Call BRDFree(.pCBoard)
        .pCBoard = BRDNewCBoard(projectPath)
        .bRevertToDraw = True
        .currentLayer = 1
    End With
End Sub
'=========================================================================
'=========================================================================
Private Sub resetEditor(ByRef ed As TKBoardEditorData) ': On Error Resume Next
    With ed
        Dim i As Integer '.bLayerOccupied assigned in openBoard()
        ReDim .bLayerVisible(.board.bSizeL + 1)
        For i = 1 To UBound(.bLayerVisible)
            .bLayerVisible(i) = True
        Next i
        Call resetLayerCombos
    End With
End Sub

'========================================================================
' change selected tile {from tkMainForm: currentTilesetForm_MouseDown}
'========================================================================
Public Sub changeSelectedTile(ByVal file As String): On Error Resume Next

    If (LenB(file) = 0) Then Exit Sub

    ' update tileset filename
    m_editorData.selectedTile = file
    
    ' change setting/tool to tile/draw
    If m_editorData.optSetting <> BS_TILE Then
        m_editorData.optSetting = BS_TILE
        m_editorData.optTool = BT_DRAW
        tkMainForm.brdOptSetting(m_editorData.optSetting).value = True
        tkMainForm.brdOptTool(m_editorData.optTool).value = True
    End If
    
    'draw tile... see boardedit.changeselectedtile
End Sub

'========================================================================
' identify type of form
'========================================================================
Public Property Get formType() As Long: On Error Resume Next
    On Error Resume Next
    formType = FT_BOARD
End Property
Private Sub Form_Activate() ':on error resume next
    Set activeBoard = Me
    Set activeForm = Me
        
    'Show tools.
    hideAllTools
    tkMainForm.popButton(3).Visible = True              'Board toolbar
    tkMainForm.boardTools.Visible = True                'Lefthand tools
    tkMainForm.boardTools.Top = tkMainForm.toolTop
    'tkMainForm.bBar.Visible = True                      'Bottom bar
    tkMainForm.frmBoardExtras.Visible = True
    
    tkMainForm.brdOptSetting(m_editorData.optSetting).value = True
    tkMainForm.brdOptTool(m_editorData.optTool).value = True
    tkMainForm.brdChkGrid.value = Abs(m_editorData.bGrid)
    tkMainForm.brdChkIso.value = Abs(isIsometric(m_editorData.board))
    tkMainForm.brdChkAutotile.value = Abs(m_editorData.bAutotiler)
    
    Call resetLayerCombos
    
    'tkMainForm.boardToolbar.Display.Refresh
   
    'Tick the flood option if entry made.
    'mnuRecursiveFlooding.Checked = False
    'If GetSetting("RPGToolkit3", "Settings", "Recursive Flooding", "0") = "1" Then mnuRecursiveFlooding.Checked = True
    
    ' if open, refresh board objects bar
    'If tkMainForm.popButton(3).value = 1 Then tkMainForm.boardToolbar.Objects.Populate (activeBoardIndex)
    
    Call Form_Resize
    
    Exit Sub
    
    'Redraw the selected tile.
    tkMainForm.currenttile.Cls
    tkMainForm.currenttileIso.Cls
    tkMainForm.bFrame(2).Caption = "Current Tile - None" & "       "
    'Call changeSelectedTile(boardList(activeBoardIndex).selectedTile)
    'tkMainForm.animTileTimer.Enabled = m_bAnimating

End Sub
Private Sub Form_Deactivate() ':on error resume next
    'Clear co-ordinate panel.
    tkMainForm.StatusBar1.Panels(3).Text = vbNullString
    'Reset visible layers list.
    Call setVisibleLayersByCombo
End Sub
Private Sub Form_Load() ':on error resume next
    Set activeBoard = Me
        
    'Initialise the board first.
    Call BoardClear(m_editorData.board)
    Call BoardSetSize(10, 10, 4, m_editorData)
    'Initialise the editor settings second.
    Call initializeEditor(m_editorData)
    
    'testing purposes
#If (0) Then
    Call openBoard("game\demo\boards\iso8x21.brd", m_editorData.board, m_editorData)
    ReDim m_editorData.bLayerVisible(m_editorData.board.bSizeL + 1)
    m_editorData.bLayerVisible(1) = True
    m_editorData.bLayerVisible(2) = True
    m_editorData.currentLayer = 2
    m_editorData.board.brdColor = RGB(255, 0, 0)
#End If
    'With m_editorData.board.bkgImage
    '    .file = "bitmap\bkg.jpg"
    '    .bounds.Right = 640
    '    .bounds.Bottom = 480
    'End With
    '
    'ReDim m_editorData.board.Images(1)
    'With m_editorData.board.Images(0)
    '    .file = "bitmap\test1.png"
    '    .bounds.Left = 96
    '    .bounds.Top = 64
    '    .bounds.Right = 96 + 224
    '    .bounds.Bottom = 64 + 206
    '    .layer = 1
    '    .transpcolor = 16711935
    'End With
    
    picBoard.currentX = 50
    picBoard.currentY = 50
    picBoard.font = "arial"
    picBoard.FontSize = 10
    picBoard.ForeColor = RGB(255, 255, 255)
    
    Call BRDRender(VarPtr(m_editorData), picBoard.hdc)
    
    'Pixel scaling
    activeBoard.ScaleMode = 3
    picBoard.ScaleMode = 3
      
    Call Form_Resize
End Sub
Private Sub Form_Resize() ':on error resume next
        
    Dim brdWidth As Integer, brdHeight As Integer
    
    picBoard.Top = 0
    picBoard.Left = 0
    
    brdWidth = relWidth(m_editorData)
    brdHeight = relHeight(m_editorData)
    
    ' Available space.
    picBoard.width = activeBoard.ScaleWidth - vScroll.width
    picBoard.Height = activeBoard.ScaleHeight - hScroll.Height
       
    If brdWidth > picBoard.width Then
        picBoard.width = picBoard.width - (picBoard.width Mod scrollUnitWidth(m_editorData))
        hScroll.Visible = True
        hScroll.Left = picBoard.Left
        hScroll.width = picBoard.width
        hScroll.max = brdWidth - picBoard.width
        hScroll.LargeChange = picBoard.width - scrollUnitWidth(m_editorData)
    Else
         hScroll.Visible = False
         picBoard.width = brdWidth
         m_editorData.topX = 0
    End If
         
    If brdHeight > picBoard.Height Then
        picBoard.Height = picBoard.Height - (picBoard.Height Mod scrollUnitHeight(m_editorData))
        vScroll.Visible = True
        vScroll.Top = picBoard.Top
        vScroll.Left = picBoard.width
        vScroll.Height = picBoard.Height
        vScroll.max = brdHeight - picBoard.Height
        vScroll.LargeChange = picBoard.Height - scrollUnitHeight(m_editorData)
    Else
         vScroll.Visible = False
         picBoard.Height = brdHeight
         m_editorData.topY = 0
    End If
    ' Update for changes in above if()
    hScroll.Top = picBoard.Height
    
    Call drawAll(True)
End Sub
Private Sub Form_Unload(Cancel As Integer) ': On Error Resume Next
    Call BRDFree(m_editorData.pCBoard)
    Call hideAllTools
    'tbc
End Sub

'========================================================================
'========================================================================
Private Sub hScroll_Change() ': On Error Resume Next
    ' exit if opening board
    'If bOpeningBoard Then Exit Sub
    
    m_editorData.topX = hScroll.value
    Call drawAll(isIsometric(m_editorData.board))
End Sub

'========================================================================
'========================================================================
Public Sub openFile(ByVal file As String) ': On Error Resume Next

    Call activeBoard.Show
    Call checkSave
    
    ' copy board to directory
    ' Call FileCopy(filename(1), projectPath & brdPath & antiPath)
    
    Call openBoard(file, m_editorData)
    Call resetEditor(m_editorData)
    Call BRDRender(VarPtr(m_editorData), picBoard.hdc)
    
    m_editorData.boardName = RemovePath(file)
    activeBoard.Caption = "Board Editor (" & m_editorData.boardName & ")"
    
    Call Form_Resize
End Sub
Public Sub saveFile() ':on error resume next

End Sub
Private Sub checkSave(): On Error Resume Next
    If m_editorData.bNeedUpdate Then
        If MsgBox("Would you like to save your changes to the current board?", vbYesNo, "Save board") = vbYes Then
            Call saveFile
        End If
    End If
End Sub

'========================================================================
'========================================================================
Private Sub picBoard_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single) ': On Error Resume Next
    
    Dim pxCoord As POINTAPI
    pxCoord = screenToBoardPixel(x, y, m_editorData)
    
    'Process tools common to all settings.
    Select Case m_editorData.optTool
        Case BT_SELECT
            If Button = vbLeftButton And m_editorData.optSetting <> BS_GENERAL Then
                'Making a selection.
                If m_editorData.selectStatus <> SS_DRAWING Then
                    m_editorData.selectStatus = SS_DRAWING
                    '.selection stores board pixel coordinate.
                    m_editorData.selection.Left = pxCoord.x: m_editorData.selection.Top = pxCoord.y
                    m_editorData.selection.Right = pxCoord.x: m_editorData.selection.Bottom = pxCoord.y
                Else
                    m_editorData.selection.Right = pxCoord.x: m_editorData.selection.Bottom = pxCoord.y
                    Call selectionDraw(m_editorData.selection)
                End If
            Else
                'Clear selection.
                Call selectionClear
            End If
            Exit Sub
    End Select
    
    Select Case m_editorData.optSetting
        Case BS_GENERAL
            'Move the board by dragging
        Case BS_TILE
            Call tileSettingMouseDown(Button, Shift, x, y)
    End Select
End Sub
Private Sub picBoard_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single) ': On Error Resume Next
    
    Dim pxCoord As POINTAPI, tileCoord As POINTAPI
    pxCoord = screenToBoardPixel(x, y, m_editorData)
    tileCoord = boardPixelToTile(pxCoord.x, pxCoord.y, m_editorData.board)
    tkMainForm.StatusBar1.Panels(3).Text = str(tileCoord.x) & ", " & str(tileCoord.y)
    
    If Button <> 0 Then
        If (m_editorData.optTool = BT_SELECT) And m_editorData.selectStatus = SS_DRAWING Then
            'Scroll the board to expand selection.
            If x > picBoard.width - 8 And hScroll.value <> hScroll.max And hScroll.Visible Then hScroll.value = hScroll.value + hScroll.SmallChange
            If x < 8 And hScroll.value <> hScroll.min Then hScroll.value = hScroll.value - hScroll.SmallChange
            If y > picBoard.Height - 8 And vScroll.value <> vScroll.max And vScroll.Visible Then vScroll.value = vScroll.value + vScroll.SmallChange
            If y < 8 And vScroll.value <> vScroll.min Then vScroll.value = vScroll.value - vScroll.SmallChange
        End If
        Call picBoard_MouseDown(Button, Shift, x, y)
    End If
End Sub
Private Sub picBoard_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single) ':on error resume next
         
    Select Case m_editorData.optSetting
        Case BS_GENERAL
            'Move the board by dragging
        Case BS_TILE
            Call tileSettingMouseUp(Button, Shift, x, y)
    End Select
End Sub

'========================================================================
' x,y as tileCoord
'========================================================================
Private Sub placeTile(file As String, x As Long, y As Long) ': On Error Resume Next

    'Get board pixel _drawing_ coordinate from tile.
    Dim brdPt As POINTAPI, scrPt As POINTAPI
    brdPt = tileToBoardPixel(x, y, m_editorData.board, True)
    scrPt = boardPixelToScreen(brdPt.x, brdPt.y, m_editorData)
    
    'Check if this tile is already inserted.
    If BoardGetTile(x, y, m_editorData.currentLayer, m_editorData.board) = file Then Exit Sub
    
    'Insert the selected tile into the board array.
    Call BoardSetTile( _
        x, y, _
        m_editorData.currentLayer, _
        file, _
        m_editorData.board _
    )
    ' set ambient details
    m_editorData.board.ambientRed(x, y, m_editorData.currentLayer) = m_editorData.ambientR
    m_editorData.board.ambientGreen(x, y, m_editorData.currentLayer) = m_editorData.ambientG
    m_editorData.board.ambientBlue(x, y, m_editorData.currentLayer) = m_editorData.ambientB
    
    ' set tiletype details (tbd:?)
    m_editorData.board.tiletype(x, y, m_editorData.currentLayer) = m_editorData.currentTileType
    
    'Render the tile to actkrt's layer canvas.
    Call BRDRenderTile( _
        m_editorData.pCBoard, _
        VarPtr(m_editorData.board), _
        picBoard.hdc, _
        x, y, _
        m_editorData.currentLayer _
    )
    'Redraw all board layers at this position.
    Call BRDDraw( _
        VarPtr(m_editorData), _
        picBoard.hdc, _
        scrPt.x, scrPt.y, _
        brdPt.x, brdPt.y, _
        tileWidth(m_editorData), _
        tileHeight(m_editorData), _
        m_editorData.zoom _
    )
    picBoard.Refresh
End Sub

'========================================================================
'========================================================================
Private Sub tileSettingMouseDown(Button As Integer, Shift As Integer, x As Single, y As Single) ': On Error Resume Next

    Dim tileCoord As POINTAPI, pxCoord As POINTAPI
    pxCoord = screenToBoardPixel(x, y, m_editorData)
    tileCoord = boardPixelToTile(pxCoord.x, pxCoord.y, m_editorData.board)

    Select Case m_editorData.optTool
        Case BT_DRAW
            If LenB(m_editorData.selectedTile) = 0 Then Exit Sub
            
            m_editorData.bLayerOccupied(0) = True
            m_editorData.bLayerOccupied(m_editorData.currentLayer) = True
                
            If (commonRoutines.extention(tilePath & m_editorData.selectedTile) <> "TBM") Then
                
                Dim eo As Long
                eo = 0 'TBD: isometric even-odd
                If m_editorData.bAutotiler Then
                    Call autoTilerPutTile( _
                        m_editorData.selectedTile, _
                        tileCoord.x, tileCoord.y, _
                        m_editorData.board.coordType, eo, _
                        ((Shift And vbShiftMask) = vbShiftMask) _
                    )
                Else
                    Call placeTile(m_editorData.selectedTile, tileCoord.x, tileCoord.y)
                End If
            Else
                'Tile bitmap!
                'TBD: test this; do isometrics. Possible overdraw at edges of picBoard.
                Dim i As Long, j As Long, width As Long, Height As Long, tbm As TKTileBitmap
                Call OpenTileBitmap(tilePath & m_editorData.selectedTile, tbm)
                width = UBound(tbm.tiles, 1)
                Height = UBound(tbm.tiles, 2)
                
                'Lose any tiles that go off the board.
                If (m_editorData.board.bSizeX - 1) < width Then width = (m_editorData.board.bSizeX - 1)
                If (m_editorData.board.bSizeY - 1) < Height Then Height = (m_editorData.board.bSizeY - 1)
                                   
                For i = 0 To width
                    For j = 0 To Height
                        Call placeTile(tbm.tiles(i, j), tileCoord.x + i, tileCoord.y + j)
                    Next j
                Next i
            End If ' .selectedTile <> "TBM"
            
        Case BT_SELECT
            ' Code is common to settings.
    
        Case BT_FLOOD
            If m_editorData.bAutotiler Then
                'fill disabled in autotiler mode (unless someone wants to code it)
                MsgBox "The Fill tool is disabled in AutoTiler mode!"
            Else
                'Use gdi version as recursive routine crashes on large boards (3.0.6)
                If GetSetting("RPGToolkit3", "Settings", "Recursive Flooding", "0") = "1" Then
                    'User has enabled recursive flooding - when gdi doesn't work.
                    Call floodRecursive(tileCoord.x, tileCoord.y, m_editorData.currentLayer, m_editorData.selectedTile)
                Else
                    'Use gdi if no setting exists (default).
                    Call floodGdi(tileCoord.x, tileCoord.y, m_editorData.currentLayer, m_editorData.selectedTile)
                End If
            End If
            If (m_editorData.bRevertToDraw) Then
                m_editorData.optTool = BT_DRAW
                tkMainForm.brdOptTool(m_editorData.optTool).value = True
            End If
            
            Call BRDRender(VarPtr(m_editorData), picBoard, m_editorData.currentLayer)
            Call drawBoard
            
        Case BT_ERASE
            eo = 0 'TBD: isometric even-odd
            If m_editorData.bAutotiler Then
                Call autoTilerPutTile("", tileCoord.x, tileCoord.y, m_editorData.board.coordType, eo, ((Shift And vbShiftMask) = vbShiftMask))
            Else
                Call placeTile("", tileCoord.x, tileCoord.y)
            End If
            
        Case BT_MOVE
    
    End Select
End Sub
Private Sub tileSettingMouseUp(Button As Integer, Shift As Integer, x As Single, y As Single) ': On Error Resume Next

    Select Case m_editorData.optTool
        Case BT_SELECT
            'Expand to grid
            If Button = vbLeftButton Then
                m_editorData.selectStatus = SS_FINISHED
                Call selectionExpandToGrid(m_editorData.selection)
                Call selectionDraw(m_editorData.selection)
            End If
    End Select
End Sub

'========================================================================
'========================================================================
Private Sub vScroll_Change() ': On Error Resume Next
    ' exit if opening board
    'If bOpeningBoard Then Exit Sub
    
    m_editorData.topY = vScroll.value
    Call drawAll(isIsometric(m_editorData.board))
End Sub

'========================================================================
'========================================================================
Private Sub zoom(ByVal direction As Integer) ': On Error Resume Next

    'Record the old zoom.
    Dim oldZoom As Double
    oldZoom = m_editorData.zoom

    If direction > 0 Then
        m_editorData.zoom = m_editorData.zoom + IIf(m_editorData.zoom >= 1, 0.5, 0.25)
        If m_editorData.zoom > 2 Then m_editorData.zoom = 2: Exit Sub
    Else
        m_editorData.zoom = m_editorData.zoom - IIf(m_editorData.zoom > 1, 0.5, 0.25)
        If m_editorData.zoom < 0.25 Then m_editorData.zoom = 0.25: Exit Sub
    End If
        
    hScroll.SmallChange = modBoard.scrollUnitWidth(m_editorData)
    vScroll.SmallChange = modBoard.scrollUnitHeight(m_editorData)
    
    'Scale topX,Y via true values using oldZoom.
    m_editorData.topX = (m_editorData.topX / oldZoom) * m_editorData.zoom
    m_editorData.topY = (m_editorData.topY / oldZoom) * m_editorData.zoom
    Call Form_Resize
    hScroll.value = m_editorData.topX
    vScroll.value = m_editorData.topY

End Sub

'========================================================================
'========================================================================
Private Sub drawBoard() ': On Error Resume Next
    picBoard.AutoRedraw = True
    Call BRDDraw( _
        VarPtr(m_editorData), _
        picBoard.hdc, _
        0, 0, _
        screenToBoardPixel(0, 0, m_editorData).x, _
        screenToBoardPixel(0, 0, m_editorData).y, _
        CLng(picBoard.width), _
        CLng(picBoard.Height), _
        m_editorData.zoom _
    )
    picBoard.Refresh
End Sub

'========================================================================
'========================================================================
Public Sub mdiOptSetting(ByVal index As Integer) ': On Error Resume Next
    m_editorData.optSetting = index
    Call selectionClear
End Sub
Public Sub mdiOptTool(ByVal index As Integer) ': On Error Resume Next
    m_editorData.optTool = index
    If index <> BT_MOVE Then Call selectionClear
End Sub
Public Sub mdiCmdZoom(ByVal Button As Integer) ': On Error Resume Next
    zoom (IIf(Button = vbLeftButton, 1, -1))
End Sub
Public Sub mdiChkGrid(ByVal value As Integer) ': On Error Resume Next
    m_editorData.bGrid = value
    Call gridDraw(False)
End Sub
Public Sub mdiChkHideLayers(ByVal value As Integer, ByVal bRedraw As Boolean) ':on error resume next
    Dim i As Integer
    If value Then
        For i = 1 To m_editorData.board.bSizeL
            If i <> m_editorData.currentLayer Then m_editorData.bLayerVisible(i) = False
        Next i
        tkMainForm.brdChkShowLayers.value = 0
        m_editorData.bShowAllLayers = False
        m_editorData.bHideAllLayers = True
    Else
        'Revert to combo list.
         Call setVisibleLayersByCombo
    End If
    If bRedraw Then Call drawBoard
End Sub
Public Sub mdiChkShowLayers(ByVal value As Integer, ByVal bRedraw As Boolean) ':on error resume next
    Dim i As Integer
    If value Then
        For i = 1 To m_editorData.board.bSizeL
            m_editorData.bLayerVisible(i) = True
        Next i
        tkMainForm.brdChkHideLayers.value = 0
        m_editorData.bHideAllLayers = False
        m_editorData.bShowAllLayers = True
   Else
         'Revert to combo list.
         Call setVisibleLayersByCombo
    End If
    If bRedraw Then Call drawBoard
End Sub
Public Sub mdiCmbCurrentLayer(ByVal layer As Long) ':on error resume next
    m_editorData.currentLayer = layer
End Sub
Public Sub mdiCmbVisibleLayers() ':on error resume next
    'Invert the selected layer.
    Dim Text As String, i As Integer, layer As String
    With tkMainForm.brdCmbVisibleLayers
        If (.ListIndex >= 0) Then
            Text = .list(.ListIndex)
            layer = Right$(Text, 1)
            i = IIf(.ListIndex > 0, CInt(val(layer)), 0)
            If (Left$(Text, 1) = "*" And i <> m_editorData.currentLayer) Then
                'Do not disable current layer.
                .list(.ListIndex) = layer
                m_editorData.bLayerVisible(i) = False
            Else
                .list(.ListIndex) = "* " & layer
                m_editorData.bLayerVisible(i) = True
            End If
        End If
        .ListIndex = -1
    End With
    Call drawBoard
End Sub

'=========================================================================
'=========================================================================
Private Sub setVisibleLayersByCombo() ':on error resume next
    Dim i As Integer, layer As Integer, Text As String
    For i = 1 To tkMainForm.brdCmbVisibleLayers.ListCount
        'Zeroth list entry is the background.
        Text = tkMainForm.brdCmbVisibleLayers.list(i)
        layer = CInt(val(Right$(Text, 1)))
        m_editorData.bLayerVisible(layer) = (Left$(Text, 1) = "*")
    Next i
End Sub

'=========================================================================
'=========================================================================
Private Sub resetLayerCombos() ':on error resume next
    tkMainForm.brdCmbCurrentLayer.Clear
    tkMainForm.brdCmbVisibleLayers.Clear
    Call tkMainForm.brdCmbVisibleLayers.AddItem("* B", 0)
    Dim i As Integer, Text As String
    For i = 1 To m_editorData.board.bSizeL
        Call tkMainForm.brdCmbVisibleLayers.AddItem(IIf(m_editorData.bLayerVisible(i), "* " & i, i))
        Call tkMainForm.brdCmbCurrentLayer.AddItem(i)
    Next i
    'Combo box is zero-indexed.
    tkMainForm.brdCmbCurrentLayer.ListIndex = m_editorData.currentLayer - 1
    Call mdiChkShowLayers(Abs(m_editorData.bHideAllLayers), False)
    Call mdiChkShowLayers(Abs(m_editorData.bShowAllLayers), False)
End Sub

'========================================================================
' Board AutoTiler functions
'   +Added by Shao, 09/24/2004
'========================================================================
'   +autoTileset:
'returns the index of an autotst, or -1 if invalid
'if its not presently an autotst, make it one now
Private Function autoTileset(ByVal tileset As String, Optional ByVal allowAdd As Boolean = True) As Long
    On Error Resume Next
    Dim i As Long, ub As Long ', sGrpCode As String

    ub = UBound(autoTilerSets)

    autoTileset = -1

    If UCase(Left(tileset, 10)) <> "AUTOTILES_" Then Exit Function
    
    'insert check for proper tile count here

    For i = 0 To ub
        If autoTilerSets(i) = tileset Then
            'if the autotileset is recognized, return its index
            autoTileset = i
            Exit Function
        End If
    Next i

    'add as autotileset
    If (allowAdd) And (autoTileset = -1) Then
        'known issue: first element is skipped, doesn't seem to be a big problem
        autoTileset = ub + 1
        ReDim Preserve autoTilerSets(autoTileset)
        autoTilerSets(autoTileset) = tileset
    End If
End Function
'========================================================================
'   +autoTilerPutTile
'change a tile and update surrounding autotiles to match it
'========================================================================
Private Sub autoTilerPutTile(ByVal tst As String, ByVal tileX As Long, ByVal tileY As Long, Optional ByVal coordType As Long, Optional ByVal eo As Boolean = False, Optional ByVal ignoreOthers As Boolean = False)
    On Error Resume Next
    Dim ix As Long, iy As Long, morphTileIndex As Byte, currentTileset As String, currentAutotileset As Long, thisAutoTileset As Long
    Dim brdWidth As Long, brdHeight As Long, startY As Long, endY As Long, startX As Long, endX As Long

    currentTileset = tilesetFilename(tst)
    
    'TBD: check this still works.
     
    If autoTileset(currentTileset, True) = -1 Then
        'not an autotileset! set it down to close off surrounding autotiles
'        If tst <> "" Then
        Call placeTile(tst, tileX, tileY)
    Else
        'valid autotileset! set down tile 51 (arbitrary) to link to surrounding autotiles
        Call placeTile(currentTileset & CStr(51), tileX, tileY)
    End If
    
    brdWidth = m_editorData.board.bSizeX
    brdHeight = m_editorData.board.bSizeY
    
    currentAutotileset = autoTileset(tilesetFilename(BoardGetTile(tileX, tileY, m_editorData.currentLayer, m_editorData.board)))
    
    If coordType = ISO_STACKED Then
        'iso board [ISO_STACKED only]
        'loop through each surrounding tile to check if it should be morphed
        'known issue: this loop has a few unneeded iterations
        
        startY = tileY - 2: If startY < 1 Then startY = 1
        endY = tileY + 2: If endY > brdHeight Then endY = brdHeight
        
        startX = tileX - 1: If startX < 1 Then startX = 1
        endX = tileX + 1: If endX > brdWidth Then endX = brdWidth
        
        For iy = startY To endY
            For ix = startX To endX
                thisAutoTileset = autoTileset(tilesetFilename(BoardGetTile(ix, iy, m_editorData.currentLayer, m_editorData.board)))
                
                'if shift is held down, override updating of other autotiles
                If (ignoreOthers) And (thisAutoTileset <> currentAutotileset) Then thisAutoTileset = -1
                
                'the 8 bits in this byte represent the 8 directions it can link to
                morphTileIndex = 0
    
                If thisAutoTileset <> -1 Then
                    'check if the tile should link to the cardinal directions
                    If iy Mod 2 = 0 Then
                        'even row
                        If (ix > 1) And (iy > 1) And (autoTileset(tilesetFilename(BoardGetTile(ix - 1, iy - 1, m_editorData.currentLayer, m_editorData.board))) = thisAutoTileset) Then morphTileIndex = morphTileIndex Or TD_W
                        If (ix > 1) And (iy < brdHeight) And (autoTileset(tilesetFilename(BoardGetTile(ix - 1, iy + 1, m_editorData.currentLayer, m_editorData.board))) = thisAutoTileset) Then morphTileIndex = morphTileIndex Or TD_S
                        If (iy > 1) And (autoTileset(tilesetFilename(BoardGetTile(ix, iy - 1, m_editorData.currentLayer, m_editorData.board))) = thisAutoTileset) Then morphTileIndex = morphTileIndex Or TD_N
                        If (iy < brdHeight) And (autoTileset(tilesetFilename(BoardGetTile(ix, iy + 1, m_editorData.currentLayer, m_editorData.board))) = thisAutoTileset) Then morphTileIndex = morphTileIndex Or TD_E
                    Else
                        'odd row
                        If (iy > 1) And (autoTileset(tilesetFilename(BoardGetTile(ix, iy - 1, m_editorData.currentLayer, m_editorData.board))) = thisAutoTileset) Then morphTileIndex = morphTileIndex Or TD_W
                        If (iy < brdHeight) And (autoTileset(tilesetFilename(BoardGetTile(ix, iy + 1, m_editorData.currentLayer, m_editorData.board))) = thisAutoTileset) Then morphTileIndex = morphTileIndex Or TD_S
                        If (ix < brdWidth) And (iy > 1) And (autoTileset(tilesetFilename(BoardGetTile(ix + 1, iy - 1, m_editorData.currentLayer, m_editorData.board))) = thisAutoTileset) Then morphTileIndex = morphTileIndex Or TD_N
                        If (ix < brdWidth) And (iy < brdHeight) And (autoTileset(tilesetFilename(BoardGetTile(ix + 1, iy + 1, m_editorData.currentLayer, m_editorData.board))) = thisAutoTileset) Then morphTileIndex = morphTileIndex Or TD_E
                    End If
                    
                    'check the intercardinal directions, but only link if both cardinal directions are also present to prevent unsupported combinations
                    If (ix > 1) And (autoTileset(tilesetFilename(BoardGetTile(ix - 1, iy, m_editorData.currentLayer, m_editorData.board))) = thisAutoTileset) And ((morphTileIndex And TD_W) = TD_W) And ((morphTileIndex And TD_S) = TD_S) Then morphTileIndex = morphTileIndex Or TD_SW
                    If (iy > 2) And (autoTileset(tilesetFilename(BoardGetTile(ix, iy - 2, m_editorData.currentLayer, m_editorData.board))) = thisAutoTileset) And ((morphTileIndex And TD_W) = TD_W) And ((morphTileIndex And TD_N) = TD_N) Then morphTileIndex = morphTileIndex Or TD_NW
                    If (iy < brdHeight - 1) And (autoTileset(tilesetFilename(BoardGetTile(ix, iy + 2, m_editorData.currentLayer, m_editorData.board))) = thisAutoTileset) And ((morphTileIndex And TD_E) = TD_E) And ((morphTileIndex And TD_S) = TD_S) Then morphTileIndex = morphTileIndex Or TD_SE
                    If (ix < brdWidth) And (autoTileset(tilesetFilename(BoardGetTile(ix + 1, iy, m_editorData.currentLayer, m_editorData.board))) = thisAutoTileset) And ((morphTileIndex And TD_E) = TD_E) And ((morphTileIndex And TD_N) = TD_N) Then morphTileIndex = morphTileIndex Or TD_NE
                
                    'draw and set the new tile
                    Call placeTile(autoTilerSets(thisAutoTileset) & CStr(tileMorphs(morphTileIndex)), ix, iy)
                End If
            Next ix
        Next iy
    
    Else
        '2d board/ ISO_ROTATED [unchecked]
        'loop through each surrounding tile to check if it should be morphed
        
        startY = tileY - 1: If startY < 1 Then startY = 1
        endY = tileY + 1: If endY > brdHeight Then endY = brdHeight
        
        startX = tileX - 1: If startX < 1 Then startX = 1
        endX = tileX + 1: If endX > brdWidth Then endX = brdWidth
        
        For iy = startY To endY
            For ix = startX To endX
                thisAutoTileset = autoTileset(tilesetFilename(BoardGetTile(ix, iy, m_editorData.currentLayer, m_editorData.board)))
                
                'if shift is held down, override updating of other autotiles
                If (ignoreOthers) And (thisAutoTileset <> currentAutotileset) Then thisAutoTileset = -1
                
                'the 8 bits in this byte represent the 8 directions it can link to
                morphTileIndex = 0
    
                If thisAutoTileset <> -1 Then
                    'check if the tile should link to the cardinal directions
                    If (ix > 1) And autoTileset(tilesetFilename(BoardGetTile(ix - 1, iy, m_editorData.currentLayer, m_editorData.board))) = thisAutoTileset Then morphTileIndex = morphTileIndex Or TD_W
                    If (iy > 1) And autoTileset(tilesetFilename(BoardGetTile(ix, iy - 1, m_editorData.currentLayer, m_editorData.board))) = thisAutoTileset Then morphTileIndex = morphTileIndex Or TD_N
                    If (iy < brdHeight) And autoTileset(tilesetFilename(BoardGetTile(ix, iy + 1, m_editorData.currentLayer, m_editorData.board))) = thisAutoTileset Then morphTileIndex = morphTileIndex Or TD_S
                    If (ix < brdWidth) And autoTileset(tilesetFilename(BoardGetTile(ix + 1, iy, m_editorData.currentLayer, m_editorData.board))) = thisAutoTileset Then morphTileIndex = morphTileIndex Or TD_E
                     
                    'check the intercardinal directions, but only link if both cardinal directions are also present to prevent unsupported combinations
                    If (ix > 1) And (iy > 1) And (autoTileset(tilesetFilename(BoardGetTile(ix - 1, iy - 1, m_editorData.currentLayer, m_editorData.board))) = thisAutoTileset) And ((morphTileIndex And TD_W) = TD_W) And ((morphTileIndex And TD_N) = TD_N) Then morphTileIndex = morphTileIndex Or TD_NW
                    If (ix > 1) And (iy < brdHeight) And (autoTileset(tilesetFilename(BoardGetTile(ix - 1, iy + 1, m_editorData.currentLayer, m_editorData.board))) = thisAutoTileset) And ((morphTileIndex And TD_W) = TD_W) And ((morphTileIndex And TD_S) = TD_S) Then morphTileIndex = morphTileIndex Or TD_SW
                    If (ix < brdWidth) And (iy > 1) And (autoTileset(tilesetFilename(BoardGetTile(ix + 1, iy - 1, m_editorData.currentLayer, m_editorData.board))) = thisAutoTileset) And ((morphTileIndex And TD_E) = TD_E) And ((morphTileIndex And TD_N) = TD_N) Then morphTileIndex = morphTileIndex Or TD_NE
                    If (ix < brdWidth) And (iy < brdHeight) And (autoTileset(tilesetFilename(BoardGetTile(ix + 1, iy + 1, m_editorData.currentLayer, m_editorData.board))) = thisAutoTileset) And ((morphTileIndex And TD_E) = TD_E) And ((morphTileIndex And TD_S) = TD_S) Then morphTileIndex = morphTileIndex Or TD_SE
                    
                    'draw and set the new tile
                    Call placeTile(autoTilerSets(thisAutoTileset) & CStr(tileMorphs(morphTileIndex)), ix, iy)
                End If
            Next ix
        Next iy
    End If
    
    Call boardform.Refresh
End Sub
'========================================================================
' End of Board AutoTiler functions
'   +Added by Shao, 09/24/2004
'========================================================================

'==============================================================================
' Fill board with selected tile
' Optional from 3.0.6: crashes on large boards (>~ 100 x 100) - use gdi instead!
' Menu options in tile / board editor
'==============================================================================
Private Sub floodRecursive(ByVal x As Long, ByVal y As Long, ByVal l As Long, ByVal tileFile As String, Optional ByVal lastX As Long = -1, Optional ByVal lastY As Long = -1): On Error Resume Next
    
    Dim replaceTile As Long, newTile As Long
    replaceTile = m_editorData.board.board(x, y, l)
    newTile = BoardTileInLUT(tileFile, m_editorData.board)
    
    ' check if old and new tile are the same.
    ' also compare rgb ambient levels, in case we're flooding a different shade.
    If replaceTile = newTile _
        And m_editorData.board.ambientRed(x, y, l) = m_editorData.ambientR _
        And m_editorData.board.ambientGreen(x, y, l) = m_editorData.ambientG _
        And m_editorData.board.ambientBlue(x, y, l) = m_editorData.ambientB _
        Then Exit Sub
    
    ' enter the tile data of the copying tile.
    m_editorData.board.board(x, y, l) = newTile
    m_editorData.board.tiletype(x, y, l) = m_editorData.currentTileType
    m_editorData.board.ambientRed(x, y, l) = m_editorData.ambientR
    m_editorData.board.ambientGreen(x, y, l) = m_editorData.ambientG
    m_editorData.board.ambientBlue(x, y, l) = m_editorData.ambientB
    
    Dim sizex As Long, sizey As Long, x2 As Long, y2 As Long
    sizex = m_editorData.board.bSizeX
    sizey = m_editorData.board.bSizeY
    
    'new x and y position
    x2 = x + 1: y2 = y
    
    ' check against boundries of board
    If (x2 <= sizex And y2 <= sizey And x2 >= 1 And y2 >= 1 And (x2 <> lastX Or y2 <> lastY)) Then
        ' if old tile is the same as replaced tile
        If m_editorData.board.board(x2, y2, l) = replaceTile Then Call fillBoard(x2, y2, l, tileFile, x, y)
    End If
    
    x2 = x: y2 = y - 1
    If (x2 <= sizex And y2 <= sizey And x2 >= 1 And y2 >= 1 And (x2 <> lastX Or y2 <> lastY)) Then
        If m_editorData.board.board(x2, y2, l) = replaceTile Then Call fillBoard(x2, y2, l, tileFile, x, y)
    End If
    
    x2 = x - 1: y2 = y
    If (x2 <= sizex And y2 <= sizey And x2 >= 1 And y2 >= 1 And (x2 <> lastX Or y2 <> lastY)) Then
        If m_editorData.board.board(x2, y2, l) = replaceTile Then Call fillBoard(x2, y2, l, tileFile, x, y)
    End If
    
    x2 = x: y2 = y + 1
    If (x2 <= sizex And y2 <= sizey And x2 >= 1 And y2 >= 1 And (x2 <> lastX Or y2 <> lastY)) Then
        If m_editorData.board.board(x2, y2, l) = replaceTile Then Call fillBoard(x2, y2, l, tileFile, x, y)
    End If
    
End Sub

'========================================================================
' Fill board with selected tile - using gdi (added for 3.0.6)
'========================================================================
Private Sub floodGdi(ByVal xLoc As Long, ByVal yLoc As Long, ByVal layer As Long, ByVal tileFilename As String): On Error Resume Next

    Const MAGIC_NUMBER = 32768
                
    With m_editorData.board
    
        Dim curIdx As Long, newIdx As Long
        'The tile we clicked to flood and the tile we want to flood it with.
        curIdx = .board(xLoc, yLoc, layer)
        newIdx = BoardTileInLUT(tileFilename, m_editorData.board)
        
        If curIdx = newIdx Then
            'We're flooding the same tile, but does it have the same attributes?
            If .ambientRed(xLoc, yLoc, layer) = m_editorData.ambientR And _
                .ambientGreen(xLoc, yLoc, layer) = m_editorData.ambientG And _
                .ambientBlue(xLoc, yLoc, layer) = m_editorData.ambientB And _
                .tiletype(xLoc, yLoc, layer) = m_editorData.currentTileType Then
                    Exit Sub
            Else
                'Give the new tile a different "colour" so these tiles get flooded.
                'The magic number... there aren't going to be this many different tiles on a
                'board so this is safe.
                newIdx = MAGIC_NUMBER
            End If
        End If
        
        'Draw the board onto a canvas.
        'We use a different "colour" for each tile, by its LUT entry.
        
        Dim cnv As Long
        cnv = createCanvas(.bSizeX + 1, .bSizeY + 1)
        
        Dim x As Long, y As Long
        For x = 1 To .bSizeX
            For y = 1 To .bSizeY
                'Set a pixel per tile, an empty tile is represented as 0 (black).
                Call canvasSetPixel(cnv, x, y, .board(x, y, layer))
            Next y
        Next x
        
        'Perform the flood...
        
        Dim hdc As Long, brush As Long
        hdc = canvasOpenHDC(cnv)                        'Open the canvas device context.
        brush = CreateSolidBrush(newIdx)                'Create a brush.
        
        Call SelectObject(hdc, brush)                   'Assign the brush to the device context.
        Call ExtFloodFill(hdc, xLoc, yLoc, curIdx, 1)   'Process the flood fill on the device context.
        
        Call DeleteObject(brush)                        'Destroy the brush.
        Call canvasCloseHDC(cnv, hdc)                   'Close the device context.
            
        For x = 1 To .bSizeX
            For y = 1 To .bSizeY
                'Copy the flooded image back to the board.
                
                If .board(x, y, layer) <> canvasGetPixel(cnv, x, y) Then
                    'This tile has been flooded, copy attributes across.
                    .board(x, y, layer) = canvasGetPixel(cnv, x, y)
                    
                    If newIdx = MAGIC_NUMBER Then
                        'The magic number - this was the same tile, so change it back.
                        .board(x, y, layer) = curIdx
                    End If
                    
                    'Set attributes.
                    .tiletype(x, y, layer) = m_editorData.currentTileType
                    .ambientRed(x, y, layer) = m_editorData.ambientR
                    .ambientGreen(x, y, layer) = m_editorData.ambientG
                    .ambientBlue(x, y, layer) = m_editorData.ambientB
                    
                End If
            Next y
        Next x
        
        Call destroyCanvas(cnv)                         'Destroy the canvas.
        
    End With
End Sub

'========================================================================
'========================================================================
Private Sub gridDraw(ByVal bResize As Boolean): On Error Resume Next
    
    Dim color As Long, offsetY As Long, x As Long, y As Long, i As Integer
    color = m_editorData.gridColor
    
    If bResize Xor m_editorData.bGrid = False Then
        'Unable to unload without crashing ("unable to unload within this context")
        'Do While lineGrid.count > 1
        '   Unload lineGrid(i)
        'Loop
        For i = 1 To lineGrid.count - 1
            lineGrid(i).Visible = False
        Next i
    End If
    i = 1
    
    If m_editorData.bGrid = True Then
        If isIsometric(m_editorData.board) Then
        
            offsetY = IIf(m_editorData.topY Mod 32 = 0, 0, 16)
            
            ' Top right to bottom left.
            Do While y < picBoard.width / 2 + picBoard.Height
                'Call vbPicLine(picBoard, 0, y + offsetY, x + offsetY * 2, 0, color)
                If i > lineGrid.count - 1 Then Load lineGrid(i)
                lineGrid(i).x1 = 0: lineGrid(i).x2 = x + offsetY * 2: lineGrid(i).y1 = y + offsetY: lineGrid(i).y2 = 0
                lineGrid(i).Visible = True
                x = x + 64:  y = y + 32: i = i + 1
            Loop

            ' Top left to bottom right.
            x = 0
            y = picBoard.Height
            Do While y > -picBoard.Height
                'Call vbPicLine(picBoard, 0, y + offsetY, x, picBoard.Height + offsetY, color)
                If i > lineGrid.count - 1 Then Load lineGrid(i)
                lineGrid(i).x1 = 0: lineGrid(i).x2 = x: lineGrid(i).y1 = y + offsetY: lineGrid(i).y2 = picBoard.Height + offsetY
                lineGrid(i).Visible = True
                x = x + 64:  y = y - 32: i = i + 1
            Loop
        Else
            Do While x < picBoard.width
                'Call vbPicLine(picBoard, x, 0, x, picBoard.height, color)
                If i > lineGrid.count - 1 Then Load lineGrid(i)
                lineGrid(i).x1 = x: lineGrid(i).x2 = x: lineGrid(i).y1 = 0: lineGrid(i).y2 = picBoard.Height
                lineGrid(i).Visible = True
                x = x + 32: i = i + 1
            Loop
            Do While y < picBoard.Height
                'Call vbPicLine(picBoard, 0, y, picBoard.width, y, color)
                If i > lineGrid.count - 1 Then Load lineGrid(i)
                lineGrid(i).x1 = 0: lineGrid(i).x2 = picBoard.width: lineGrid(i).y1 = y: lineGrid(i).y2 = y
                lineGrid(i).Visible = True
                y = y + 32: i = i + 1
            Loop
        End If 'isIsometric
    End If 'bGrid
End Sub

'=========================================================================
'=========================================================================
Private Sub selectionDraw(ByRef pxBrdCoord As RECT) ':on error resume next
    If m_editorData.selectStatus <> SS_NONE Then
        'Call vbPicRect(picBoard, pxBrdCoord.Left, pxBrdCoord.Top, pxBrdCoord.Right, pxBrdCoord.Bottom, m_editorData.selectionColor)
        Dim pt1 As POINTAPI, pt2 As POINTAPI, i As Integer
        pt1 = boardPixelToScreen(pxBrdCoord.Left, pxBrdCoord.Top, m_editorData)
        pt2 = boardPixelToScreen(pxBrdCoord.Right, pxBrdCoord.Bottom, m_editorData)
        
        lineSelection(0).x1 = pt1.x: lineSelection(0).x2 = pt2.x: lineSelection(0).y1 = pt1.y: lineSelection(0).y2 = pt1.y
        lineSelection(1).x1 = pt1.x: lineSelection(1).x2 = pt2.x: lineSelection(1).y1 = pt2.y: lineSelection(1).y2 = pt2.y
        lineSelection(2).x1 = pt1.x: lineSelection(2).x2 = pt1.x: lineSelection(2).y1 = pt1.y: lineSelection(2).y2 = pt2.y
        lineSelection(3).x1 = pt2.x: lineSelection(3).x2 = pt2.x: lineSelection(3).y1 = pt1.y: lineSelection(3).y2 = pt2.y
    
        For i = 0 To 3
            lineSelection(i).Visible = True
        Next i
    End If
End Sub
Private Sub selectionExpandToGrid(ByRef pxBrdCoord As RECT) ':on error resume next
    With pxBrdCoord
        Dim dx As Integer, dy As Integer, pt As POINTAPI
        'Is the end point in front of the start point? tbd: isometrics!
        If .Left > .Right Then dx = 1
        If .Top > .Bottom Then dy = 1
        
        pt = boardPixelToTile(.Left, .Top, m_editorData.board)
        pt = tileToBoardPixel(pt.x + dx, pt.y + dy, m_editorData.board)
        .Left = pt.x: .Top = pt.y
        
        pt = boardPixelToTile(.Right, .Bottom, m_editorData.board)
        pt = tileToBoardPixel(pt.x + Abs(dx - 1), pt.y + Abs(dy - 1), m_editorData.board)
        .Right = pt.x: .Bottom = pt.y
    End With
End Sub
Private Sub selectionClear() ':on error resume next
    Dim i As Integer
    m_editorData.selectStatus = SS_NONE
    For i = 0 To lineSelection.count - 1
        lineSelection(i).Visible = False
    Next i
End Sub

'=========================================================================
'=========================================================================
Private Sub drawAll(Optional ByVal bShiftGrid As Boolean = False) ':on error resume next
    Call drawBoard
    
    'Update line controls.
    Call gridDraw(bShiftGrid)
    Call selectionDraw(m_editorData.selection)
End Sub

VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CBoardRender"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'=========================================================================
'All contents copyright 2004, Colin James Fitzpatrick (KSNiloc)
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=========================================================================

'=========================================================================
' Board render class (used to render board)
'=========================================================================

Option Explicit

'=========================================================================
' Public variables
'=========================================================================
Public canvas As Long
Public canvasMask As Long
Public topX As Double
Public topY As Double

'=========================================================================
' Member variables
'=========================================================================
Private m_file As String
Private m_tilesX As Long
Private m_tilesY As Long
Private m_shadeR As Long
Private m_shadeG As Long
Private m_shadeB As Long
Private m_isometric As Long

'=========================================================================
' Get filename
'=========================================================================
Public Property Get file() As String
    file = m_file
End Property

'=========================================================================
' Get x dimension
'=========================================================================
Public Property Get tilesX() As Long
    tilesX = m_tilesX
End Property

'=========================================================================
' Get y dimension
'=========================================================================
Public Property Get tilesY() As Long
    tilesY = m_tilesY
End Property

'=========================================================================
' Get red shade
'=========================================================================
Public Property Get shadeR() As Long
    shadeR = m_shadeR
End Property

'=========================================================================
' Get blue shade
'=========================================================================
Public Property Get shadeB() As Long
    shadeB = m_shadeB
End Property

'=========================================================================
' Get green shade
'=========================================================================
Public Property Get shadeG() As Long
    shadeG = m_shadeG
End Property

'=========================================================================
' Board is isometric?
'=========================================================================
Public Property Get isometric() As Long
    isometric = m_isometric
End Property

'=========================================================================
' Render this object!
'=========================================================================
Public Sub Render()

    On Error Resume Next

    'first, get the shade color of the board
    Call getAmbientLevel(m_shadeR, m_shadeB, m_shadeG)

    'With the board to render
    With boardList(activeBoardIndex).theData

        'Is the board isometric?
        m_isometric = CLng(.isIsometric)

        'Get number of tiles in the scroll cache
        m_tilesX = scTilesX
        m_tilesY = scTilesY

        'Get filename of board to render
        m_file = brdPath & RemovePath(currentBoard)

        'Fill canvases with the transparent color
        'If canvasMask <> -1 Then
        '    Call CanvasFill(canvas, TRANSP_COLOR_ALT)
        '    Call CanvasFill(canvasMask, TRANSP_COLOR)
        'Else
            Call CanvasFill(canvas, TRANSP_COLOR)
        'End If

        ' If board is isometric, render twice as much
        If (boardList(activeBoardIndex).theData.isIsometric = 1) Then
            m_tilesY = m_tilesY * 2
            topY = topY * 2
        End If

        'Change directory
        If pakFileRunning Then
            Call ChangeDir(PakTempPath)
        Else
            Call ChangeDir(projectPath)
        End If

        'Draw the board
        Call GFXDrawBoardCNV( _
                                canvas, _
                                canvasMask, _
                                0, _
                                topX, _
                                topY, _
                                m_tilesX, _
                                m_tilesY, _
                                .bSizeX, _
                                .bSizeY, _
                                .bSizeL, _
                                m_shadeR, _
                                m_shadeG, _
                                m_shadeB, _
                                m_isometric _
                                              )

    End With

    'Return to old directory
    Call ChangeDir(currentDir)

End Sub

'=========================================================================
' Was this the same render as another object?
'=========================================================================
Public Function equal(ByRef anotherBoardRender As CBoardRender) As Boolean
    On Error Resume Next
    With anotherBoardRender
        equal = ( _
             .canvas = canvas _
             And .canvasMask = canvasMask _
             And .file = m_file _
             And .isometric = m_isometric _
             And .shadeB = m_shadeB _
             And .shadeG = m_shadeG _
             And .shadeR = m_shadeR _
             And .tilesX = m_tilesX _
             And .tilesY = m_tilesY _
             And .topX = topX _
             And .topY = topY _
             )
    End With
End Function

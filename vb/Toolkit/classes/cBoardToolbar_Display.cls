VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "cBoardToolbar_Display"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'========================================================================
' BOARD TOOLBAR > DISPLAY v1.0
' DESIGNED AND CODED BY PHIL CARTY (AKA VAMPZ)
'========================================================================
' The toolbar allows users to manage programs, items, and warps on the
' board they are editing. Allowing them to edit, remove and even open
' the object to edit.
'
' If you'd like to discuss the tool, feel free to post on the open source
' forum at TKZ.
'========================================================================

Option Explicit

'========================================================================
' LOCAL VARIABLES
'========================================================================
Private mDisplay(4) As Integer

Public Enum eDisplay
    eRedrawAll = 0
    eShowPrograms
    eShowItems
    eShowWarps
    eShowGraphics
End Enum

'========================================================================
' PUBLIC PROPERTIES
'========================================================================
Public Property Get Setting(ByVal id As eDisplay) As Integer
    Setting = mDisplay(id)
End Property
Public Property Let Update(ByVal id As Integer, ByVal newValue As Integer)
    mDisplay(id) = newValue
    Select Case id
        Case 0: activeBoard.drawLayers
        Case 1: If newValue = 1 Then Call activeBoard.drawPrograms Else Call activeBoard.boardRedraw
        Case 2: If newValue = 1 Then Call activeBoard.drawItems Else Call activeBoard.boardRedraw
        Case 3: If newValue = 1 Then Call activeBoard.drawWarps Else Call activeBoard.boardRedraw
    End Select
End Property

'========================================================================
' REFRESH - Refresh control values
'========================================================================
Public Sub Refresh()
    Dim i As Integer
    For i = 0 To 4
        tkMainForm.bTools_Display_Option(i).value = mDisplay(i)
    Next i
End Sub

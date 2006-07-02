VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "cBoardToolbar"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'========================================================================
' BOARD TOOLBAR v1.0
' DESIGNED AND CODED BY PHIL CARTY (AKA VAMPZ)
'========================================================================
' The toolbar allows for quick managing of various aspects of the board
' such as handling programs and items or setting additional configurations.
'
' If you'd like to discuss the tool, feel free to post on the open source
' forum at TKZ.
'========================================================================

Option Explicit

'========================================================================
' LOCAL VARIABLES
'========================================================================
Private mObjects As New cBoardToolbar_Objects
Private mDisplay As New cBoardToolbar_Display

'========================================================================
' PUBLIC PROPERTIES
'========================================================================
Property Get Objects() As cBoardToolbar_Objects
    Set Objects = mObjects
End Property
Property Set Objects(ByRef newValue As cBoardToolbar_Objects)
    Set mObjects = newValue
End Property

Property Get Display() As cBoardToolbar_Display
    Set Display = mDisplay
End Property
Property Set Display(ByRef newValue As cBoardToolbar_Display)
    Set mDisplay = newValue
End Property

Public Function editListView(ByRef lv As ListView, ByVal keyCode As Integer) As Boolean ':on error resume next
    Dim i As Long
    i = val(lv.tag)
    If i = 0 And keyCode = vbKeyDelete Then
        'Whole row selected - delete the point.
        lv.ListItems.Remove lv.SelectedItem.index
        editListView = True
    End If
    If i <> 1 And i <> 2 Then Exit Function
        
    Select Case keyCode
        Case vbKeyBack, vbKeyDelete
            lv.SelectedItem.SubItems(i) = vbNullString
        Case vbKeyReturn
            editListView = True
        Case vbKey0 To vbKey9
            lv.SelectedItem.SubItems(i) = lv.SelectedItem.SubItems(i) & chr(keyCode)
        Case vbKeyNumpad0 To vbKeyNumpad9
            keyCode = keyCode - (vbKeyNumpad0 - vbKey0)
            lv.SelectedItem.SubItems(i) = lv.SelectedItem.SubItems(i) & chr(keyCode)
        Case vbKeyAdd
            lv.SelectedItem.SubItems(i) = str(val(lv.SelectedItem.SubItems(i)) + 32)
             editListView = True
       Case vbKeySubtract
            lv.SelectedItem.SubItems(i) = str(val(lv.SelectedItem.SubItems(i)) - 32)
            editListView = True
       Case vbKeyRight
            'Switch columns.
            If i = 1 Then lv.tag = "2": editListView = True
       Case vbKeyLeft
            If i = 2 Then lv.tag = "1": editListView = True
    End Select
End Function

Public Sub hide() ':on error resume next
    tkMainForm.popButton(3).Visible = False
    tkMainForm.pTools.Visible = False
End Sub


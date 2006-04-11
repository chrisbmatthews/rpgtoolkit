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

Public Sub Populate(ByRef vectors() As CVector) ':on error resume next
    Call vectorPopulate(vectors)
End Sub

Private Sub vectorPopulate(ByRef vectors() As CVector) ':on error resume next
    Dim i As Long, j As Long, k As Long, tileString(TT_STAIRS) As String, tileCount(TT_STAIRS) As Long
    tileString(TT_SOLID) = "Solid "
    tileString(TT_UNDER) = "Under "
    tileString(TT_UNIDIRECTIONAL) = "Unidirectional "
    tileString(TT_STAIRS) = "Stairs "
    
    tkMainForm.bTools_Tabs.Height = tkMainForm.pTools.Height - tkMainForm.bTools_Tabs.Top
    
    tkMainForm.bTools_VectorFrame.Height = tkMainForm.bTools_Tabs.Height - tkMainForm.bTools_VectorFrame.Top - 256
    tkMainForm.bTools_VectorLv.Height = tkMainForm.bTools_VectorFrame.Height - tkMainForm.bTools_VectorLv.Top - 256
    
    'Preserve selected vector.
    k = tkMainForm.bTools_VectorCombo.ListIndex
    tkMainForm.bTools_VectorCombo.clear
    
    For i = 0 To UBound(vectors)
        If Not vectors(i) Is Nothing Then
            If vectors(i).tiletype <> TT_NULL Then
                tkMainForm.bTools_VectorCombo.AddItem tileString(vectors(i).tiletype) & str(tileCount(vectors(i).tiletype))
                tileCount(vectors(i).tiletype) = tileCount(vectors(i).tiletype) + 1
                tkMainForm.bTools_VectorCombo.ItemData(j) = i
                j = j + 1
            End If
        End If
    Next i
    If j > 0 Then
        'Preserve selected vector.
        tkMainForm.bTools_VectorCombo.ListIndex = IIf(k < j And k <> -1, k, 0)
    Else
        'Clear details.
        Dim void As New CVector
        void.tbPopulate
    End If
End Sub

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


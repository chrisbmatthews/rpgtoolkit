Attribute VB_Name = "CommonRPGCodeDoc"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

Option Explicit

Public Type RPGCodeDoc
    prgName As String         'filename
    prgNeedUpdate As Boolean
    prgText As String         'saved text
    Ifont As String           'initial font
    IfontSize As Integer        'font size
    Imwin As String           'init message window gfx
    Ichar(4) As String        'initial chars (0-4)
    Iboard As String          'initial board

End Type


'array of rpgcode programs used in the MDI children
Public rpgcodeList() As RPGCodeDoc
Public rpgcodeListOccupied() As Boolean


Sub VectRPGCodeKillSlot(ByVal idx As Long)
    On Error Resume Next
    'free up memory in the special move list vector
    specialMoveListOccupied(idx) = False
End Sub

Function VectRPGCodeNewSlot() As Long
    On Error GoTo vecterr
       
    'test size of array
    Dim test As Long, t As Long, oldSize As Long, newSize As Long
    test = UBound(rpgcodeList)
    
    'find a new slot in the list of boards and return an index we can use
    For t = 0 To UBound(rpgcodeList)
        If rpgcodeListOccupied(t) = False Then
            rpgcodeListOccupied(t) = True
            VectRPGCodeNewSlot = t
            Exit Function
        End If
    Next t
    
    'must resize the vector...
    oldSize = UBound(rpgcodeList)
    newSize = UBound(rpgcodeList) * 2
    ReDim Preserve rpgcodeList(newSize)
    ReDim Preserve rpgcodeListOccupied(newSize)
    
    rpgcodeListOccupied(oldSize + 1) = True
    VectRPGCodeNewSlot = oldSize + 1
    
    Exit Function

vecterr:
    ReDim rpgcodeList(1)
    ReDim rpgcodeListOccupied(1)
    Resume Next
    
End Function


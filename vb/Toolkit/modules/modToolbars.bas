Attribute VB_Name = "modToolbars"
'============================================================================
'YOU MAY NOT REMOVE THIS NOTICE
'============================================================================
'Dockable/Undockable Toolbars
'Designed, Programmed, and Copyrighted by Colin James Fitzpatrick, 2004
'============================================================================
'YOU MAY NOT REMOVE THIS NOTICE
'============================================================================

'============================================================================
'This module enables toolbars to be docked/undocked
'============================================================================
'============================================================================
'Depends on CUnDock.cls
'============================================================================

Option Explicit

'An array to remember which toolbars are docked
Private docked() As TK_DOCK_DATA

Public Type TK_UNDOCK_DATA
 n As Boolean
 S As Boolean
 W As Boolean
 E As Boolean
End Type

Private Type TK_DOCK_DATA
 obj As Object              'The object that was docked
 cls As New CUnDock         'The class being used to 'power' this dock
 unDock As TK_UNDOCK_DATA   'Where can this bar be unDocked?
End Type

Public Sub unDock(ByRef objFrom As Object, ByVal Caption As String, _
 unDockable As TK_UNDOCK_DATA)
 
 'This sub-routine un-docks a toolbar...

 On Error Resume Next

 'Declarations...
 Dim ctl As Control
 Dim parent As Form
 
 Set parent = objFrom.parent

 'For Each ctl In parent.Controls
 ' If (Not ctl.Visible) Then
 '  'Since the visibility of a control won't be maintained,
 '  'move it way to the left...
 '  ctl.Left = ctl.Left - 9999
 ' End If
 'Next ctl

 'Make sure our array is dimensioned...
 On Error GoTo dimDocked
 Dim testArray As Long
 testArray = UBound(docked)
 On Error Resume Next
 
 'Redimension the Docked() array...
 ReDim Preserve docked(UBound(docked) + 1)

 'Working with the newly created array element...
 With docked(UBound(docked))
 
  'Record the object we're docking...
  Set .obj = objFrom
  
  'Jot down where we can unDock this bar for later use...
  .unDock = unDockable

  'Make it happen!
  .cls.unDock objFrom.hwnd, True, Caption
  
  'Now move them all back...
  'For Each ctl In parent.Controls
  ' If (Not ctl.Visible) Then
  '  ctl.Left = ctl.Left + 9999
  ' End If
  'Next ctl

  'Make the tool window a child of the MDI form...
  SetParent .cls.MyForm.hwnd, tkMainForm.hwnd
  If .cls.MyForm.Left < 10 Then .cls.MyForm.Left = 10
  If .cls.MyForm.Top < 10 Then .cls.MyForm.Top = 10

  'If objFrom = tkMainForm.TreeView1 Then
  ' .cls.MyForm.BorderStyle = 5
  'End If
    
  'Show the correct tools...
  hideAllTools
  tkMainForm.activeForm.SetFocus

 End With

 Exit Sub
dimDocked:
 ReDim docked(0)
 Resume

End Sub

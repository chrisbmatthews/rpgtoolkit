Attribute VB_Name = "mEnumChildWindows"
Option Explicit


Public Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" (pDest As Any, pSrc As Any, ByVal ByteLen As Long)
Private Declare Function GetClassName Lib "user32" Alias "GetClassNameA" (ByVal hWnd As Long, ByVal lpClassName As String, ByVal nMaxCount As Long) As Long

Public Function enumChildWindowProc( _
      ByVal hWnd As Long, _
      ByVal lParam As Long _
    ) As Long
Dim sBuf As String
Dim sClass As String
Dim iPos As Long
   
   ' valid call?
   If Not lParam = 0 Then
      ' ok
      sBuf = String$(261, 0)
      GetClassName hWnd, sBuf, 260
      iPos = InStr(sBuf, vbNullChar)
      If iPos > 1 Then
         sClass = left$(sBuf, iPos - 1)
         If InStr(sClass, "Form") > 0 Then
            ' add to calling object:
            Dim ctlTab As cMDITabs
            Dim oT As Object
            CopyMemory oT, lParam, 4
            Set ctlTab = oT
            CopyMemory oT, 0&, 4
            ctlTab.addChildWindow hWnd
         End If
      End If
      ' get more windows:
      enumChildWindowProc = 1
   End If
   
End Function


VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsImages"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'All contents copyright 2004, Colin James Fitzpatrick
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'Used to load common images

'Depends on frmCommonImages

Option Explicit
Dim i As New frmCommonImages

Public Function Bullet() As Object
    On Error Resume Next
    Set Bullet = i.picNormal.Picture
End Function

Public Function BulletMouseOver() As Object
    On Error Resume Next
    Set BulletMouseOver = i.picMouseOver.Picture
End Function

Public Function MouseLink() As Object
    On Error Resume Next
    Set MouseLink = i.picNormal.MouseIcon
End Function

Public Function CloseX() As Object
    On Error Resume Next
    Set CloseX = i.CloseX.Picture
End Function

Public Function Corner() As Object
    On Error Resume Next
    Set Corner = i.Corner.Picture
End Function

Private Sub Class_Terminate()
    On Error Resume Next
    Unload i
End Sub

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
 Set Bullet = i.picNormal.Picture
End Function

Public Function BulletMouseOver() As Object
 Set BulletMouseOver = i.picMouseOver.Picture
End Function

Public Function MouseLink() As Object
 Set MouseLink = i.picNormal.MouseIcon
End Function

Public Function CloseX() As Object
 Set CloseX = i.CloseX.Picture
End Function

Public Function Corner() As Object
 Set Corner = i.Corner.Picture
End Function

Private Sub Class_Terminate()
 Unload i
End Sub

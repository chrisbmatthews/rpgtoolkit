VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CImages"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'========================================================================
' The RPG Toolkit, Version 3
' This file copyright (C) 2007 Colin James Fitzpatrick
'========================================================================
'
' This program is free software; you can redistribute it and/or
' modify it under the terms of the GNU General Public License
' as published by the Free Software Foundation; either version 2
' of the License, or (at your option) any later version.
'
' This program is distributed in the hope that it will be useful,
' but WITHOUT ANY WARRANTY; without even the implied warranty of
' MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
' GNU General Public License for more details.
'
'========================================================================

Option Explicit

Dim i As New frmCommonImages

Public Function Bullet() As Object
    On Error Resume Next
    Set Bullet = i.picNormal.picture
End Function

Public Function BulletMouseOver() As Object
    On Error Resume Next
    Set BulletMouseOver = i.picMouseOver.picture
End Function

Public Function MouseLink() As Object
    On Error Resume Next
    Set MouseLink = i.picNormal.MouseIcon
End Function

Public Function CloseX() As Object
    On Error Resume Next
    Set CloseX = i.CloseX.picture
End Function

Public Function Corner() As Object
    On Error Resume Next
    Set Corner = i.Corner.picture
End Function

Private Sub Class_Terminate()
    On Error Resume Next
    Unload i
End Sub

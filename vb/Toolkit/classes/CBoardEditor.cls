VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CBoardEditor"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'========================================================================
' The RPG Toolkit, Version 3
' This file copyright (C) 2007 Jonathan D. Hughes
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

Public topX As Long                          'top x coord (scaled pixels)
Public topY As Long                          'top y coord (scaled pixels)
Public zoom As Double                        'scaling factor

Public Sub screenToBoardPixel(ByRef x As Long, ByRef y As Long)
    x = (x + topX) / zoom
    y = (y + topY) / zoom
End Sub
Public Sub boardPixelToScreen(ByRef x As Long, ByRef y As Long)
    x = x * zoom - topX
    y = y * zoom - topY
End Sub
Private Sub Class_Initialize()
    zoom = 1
End Sub

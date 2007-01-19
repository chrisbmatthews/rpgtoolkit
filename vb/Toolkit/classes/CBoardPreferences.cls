VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CBoardPreferences"
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

Public bShowBackColor As Boolean             'tbd:show background colour in editor
Public bRevertToDraw As Boolean              'After flooding revert to draw tool
Public bShowVectorIndices As Boolean
Public bUseRecursiveFlooding As Boolean
Public bShowNewBoardDialog As Boolean

Private vectorColors(TT_WAYPOINT) As Long
Public programColor As Long
Public highlightColor As Long                'Sprite, image highligther.
Public pStartColor As Long                   'Player start location colour.
Public lightsColor As Long                   'Lighting object vector colour.

Option Explicit

Public Property Get vectorColor(ByVal tt As eTileType) As Long: On Error Resume Next
    vectorColor = vectorColors(tt)
End Property
Public Property Let vectorColor(ByVal tt As eTileType, ByVal color As Long): On Error Resume Next
    vectorColors(tt) = color
End Property

'========================================================================
' Load key data
'========================================================================
Private Sub Class_Initialize(): On Error Resume Next

    bRevertToDraw = (GetSetting("RPGToolkit3", "BRD Editor", "RevertToDraw", "False") = "True")
    bShowVectorIndices = (GetSetting("RPGToolkit3", "BRD Editor", "ShowVectorIndices", "True") = "True")
    bUseRecursiveFlooding = (GetSetting("RPGToolkit3", "BRD Editor", "UseRecursiveFlooding", "False") = "True")
    bShowNewBoardDialog = (GetSetting("RPGToolkit3", "BRD Editor", "ShowNewBoardDialog", "True") = "True")

    vectorColors(TT_SOLID) = val(GetSetting("RPGToolkit3", "BRD Editor", "Color vector-solid", "-1"))
    If vectorColors(TT_SOLID) = -1 Then vectorColors(TT_SOLID) = RGB(255, 255, 255)
    
    vectorColors(TT_UNDER) = val(GetSetting("RPGToolkit3", "BRD Editor", "Color vector-under", "-1"))
    If vectorColors(TT_UNDER) = -1 Then vectorColors(TT_UNDER) = RGB(0, 255, 0)
    
'    vectorColors(TT_UNIDIRECTIONAL) = val(GetSetting("RPGToolkit3", "BRD Editor", "Color vector-unidir", "-1"))
'    If vectorColors(TT_UNIDIRECTIONAL) = -1 Then vectorColors(TT_UNIDIRECTIONAL) = RGB(255, 128, 0)
    
    vectorColors(TT_STAIRS) = val(GetSetting("RPGToolkit3", "BRD Editor", "Color vector-unidir", "-1"))
    If vectorColors(TT_STAIRS) = -1 Then vectorColors(TT_STAIRS) = RGB(0, 255, 255)
    
    vectorColors(TT_WAYPOINT) = val(GetSetting("RPGToolkit3", "BRD Editor", "Color vector-waypoint", "-1"))
    If vectorColors(TT_WAYPOINT) = -1 Then vectorColors(TT_WAYPOINT) = RGB(255, 0, 0)
    
    programColor = val(GetSetting("RPGToolkit3", "BRD Editor", "Color program", "-1"))
    If programColor = -1 Then programColor = RGB(255, 255, 0)
    
    highlightColor = val(GetSetting("RPGToolkit3", "BRD Editor", "Color highlight", "-1"))
    If highlightColor = -1 Then highlightColor = RGB(255, 255, 255)
    
    pStartColor = val(GetSetting("RPGToolkit3", "BRD Editor", "Color player-start", "-1"))
    If pStartColor = -1 Then pStartColor = RGB(255, 255, 255)
    
    lightsColor = val(GetSetting("RPGToolkit3", "BRD Editor", "Color lights", "-1"))
    If lightsColor = -1 Then lightsColor = RGB(255, 255, 192)
    
End Sub

Private Sub Class_Terminate(): On Error Resume Next
    
    Call SaveSetting("RPGToolkit3", "BRD Editor", "RevertToDraw", CStr(bRevertToDraw))
    Call SaveSetting("RPGToolkit3", "BRD Editor", "ShowVectorIndices", CStr(bShowVectorIndices))
    Call SaveSetting("RPGToolkit3", "BRD Editor", "UseRecursiveFlooding", CStr(bUseRecursiveFlooding))
    Call SaveSetting("RPGToolkit3", "BRD Editor", "ShowNewBoardDialog", CStr(bShowNewBoardDialog))
    
    Call SaveSetting("RPGToolkit3", "BRD Editor", "Color vector-solid", CStr(vectorColors(TT_SOLID)))
    Call SaveSetting("RPGToolkit3", "BRD Editor", "Color vector-under", CStr(vectorColors(TT_UNDER)))
'    Call SaveSetting("RPGToolkit3", "BRD Editor", "Color vector-unidir", CStr(vectorColors(TT_UNIDIRECTIONAL)))
    Call SaveSetting("RPGToolkit3", "BRD Editor", "Color vector-stairs", CStr(vectorColors(TT_STAIRS)))
    Call SaveSetting("RPGToolkit3", "BRD Editor", "Color vector-waypoint", CStr(vectorColors(TT_WAYPOINT)))
    Call SaveSetting("RPGToolkit3", "BRD Editor", "Color program", CStr(programColor))
    Call SaveSetting("RPGToolkit3", "BRD Editor", "Color highlight", CStr(highlightColor))
    Call SaveSetting("RPGToolkit3", "BRD Editor", "Color player-start", CStr(pStartColor))
    Call SaveSetting("RPGToolkit3", "BRD Editor", "Color lights", CStr(lightsColor))

End Sub

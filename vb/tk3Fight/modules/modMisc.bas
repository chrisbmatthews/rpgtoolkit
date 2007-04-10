Attribute VB_Name = "modMisc"
'====================================================================================
' The RPG Toolkit Version 3 Default Battle System
' This file copyright (C) 2004-2007 Colin James Fitzpatrick
'====================================================================================
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
'====================================================================================

'====================================================================================
'Misc Functions
'====================================================================================

Option Explicit

Public Sub Plugin_Initialize()
    resX = CBGetGeneralNum(GEN_RESX, 0, 0)
    resY = CBGetGeneralNum(GEN_RESY, 0, 0)
    g_lngTranspColor = CBGetGeneralNum(GEN_TRANSPARENTCOLOR, 0, 0)
    Dim i As Long
    For i = 0 To 4
        g_cnvProfiles(i) = CBCreateCanvas(75, 75)
    Next i
End Sub

Public Sub Plugin_Terminate()
    Dim i As Long
    For i = 0 To 4
        Call CBDestroyCanvas(g_cnvProfiles(i))
    Next i
End Sub

Public Function Plugin_Version() As String
    Plugin_Version = "2.0.0"
End Function

Public Function Plugin_Description() As String
    Plugin_Description = "Fully featured TK3 battle system"
End Function

Public Function plugType(ByVal request As Long) As Boolean
    If request = PT_FIGHT Then plugType = True
End Function

Public Function getGamePath() As String
    'Returns the path this game is running from
    'IE: C:\Program Files\Toolkit3\Game\MyGame
    getGamePath = Replace(App.Path & "-", "\plugin-", "", , , vbTextCompare)
End Function

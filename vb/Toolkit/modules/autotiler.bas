Attribute VB_Name = "modAutoTiler"
'========================================================================
' The RPG Toolkit, Version 3
' This file copyright (C) 2007 Shao Xiang
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

'=========================================================================
' AutoTiler initialization and constants
'=========================================================================

Public Const TD_N As Byte = 1
Public Const TD_S As Byte = 2
Public Const TD_W As Byte = 4
Public Const TD_E As Byte = 8
Public Const TD_NW As Byte = 16
Public Const TD_NE As Byte = 32
Public Const TD_SW As Byte = 64
Public Const TD_SE As Byte = 128

Public tileMorphs() As Long         'each possible combination, most are unused
Public autoTilerSets() As String    'autotiler tilesets currently used

'=========================================================================
' Initiate the auto tiler
'=========================================================================
Public Sub setupAutoTiler()
    On Error GoTo reDimArray
    ReDim autoTilerSets(0)
    ReDim tileMorphs(0)
    tileMorphs(TD_N Or TD_S Or TD_W Or TD_E Or TD_NE Or TD_SW Or TD_SE) = 1
    tileMorphs(TD_N Or TD_S Or TD_W Or TD_E Or TD_NW Or TD_SW Or TD_SE) = 2
    tileMorphs(TD_N Or TD_S Or TD_W Or TD_E Or TD_SW Or TD_SE) = 3
    tileMorphs(TD_N Or TD_S Or TD_W Or TD_E Or TD_NW Or TD_NE Or TD_SW) = 4
    tileMorphs(TD_N Or TD_S Or TD_W Or TD_E Or TD_NE Or TD_SW) = 5
    tileMorphs(TD_N Or TD_S Or TD_W Or TD_E Or TD_NW Or TD_SW) = 6
    tileMorphs(TD_N Or TD_S Or TD_W Or TD_E Or TD_SW) = 7
    tileMorphs(TD_N Or TD_S Or TD_W Or TD_E Or TD_NW Or TD_NE Or TD_SE) = 8
    tileMorphs(TD_N Or TD_S Or TD_W Or TD_E Or TD_NE Or TD_SE) = 10
    tileMorphs(TD_N Or TD_S Or TD_W Or TD_E Or TD_NW Or TD_SE) = 11
    tileMorphs(TD_N Or TD_S Or TD_W Or TD_E Or TD_SE) = 12
    tileMorphs(TD_N Or TD_S Or TD_W Or TD_E Or TD_NW Or TD_NE) = 13
    tileMorphs(TD_N Or TD_S Or TD_W Or TD_E Or TD_NE) = 14
    tileMorphs(TD_N Or TD_S Or TD_W Or TD_E Or TD_NW) = 15
    tileMorphs(TD_N Or TD_S Or TD_W Or TD_E) = 16
    tileMorphs(TD_N Or TD_S Or TD_NE Or TD_SE Or TD_E) = 17
    tileMorphs(TD_N Or TD_S Or TD_SE Or TD_E) = 19
    tileMorphs(TD_N Or TD_S Or TD_NE Or TD_E) = 20
    tileMorphs(TD_N Or TD_S Or TD_E) = 21
    tileMorphs(TD_S Or TD_SW Or TD_SE Or TD_W Or TD_E) = 22
    tileMorphs(TD_S Or TD_SW Or TD_W Or TD_E) = 23
    tileMorphs(TD_S Or TD_SE Or TD_W Or TD_E) = 24
    tileMorphs(TD_S Or TD_W Or TD_E) = 25
    tileMorphs(TD_N Or TD_S Or TD_SW Or TD_NW Or TD_W) = 26
    tileMorphs(TD_N Or TD_S Or TD_NW Or TD_W) = 28
    tileMorphs(TD_N Or TD_S Or TD_SW Or TD_W) = 29
    tileMorphs(TD_N Or TD_S Or TD_W) = 30
    tileMorphs(TD_N Or TD_NW Or TD_NE Or TD_W Or TD_E) = 31
    tileMorphs(TD_N Or TD_NE Or TD_W Or TD_E) = 32
    tileMorphs(TD_N Or TD_NW Or TD_W Or TD_E) = 33
    tileMorphs(TD_N Or TD_E Or TD_W) = 34
    tileMorphs(TD_N Or TD_S) = 35
    tileMorphs(TD_E Or TD_W) = 37
    tileMorphs(TD_S Or TD_SE Or TD_E) = 38
    tileMorphs(TD_S Or TD_E) = 39
    tileMorphs(TD_S Or TD_SW Or TD_W) = 40
    tileMorphs(TD_S Or TD_W) = 41
    tileMorphs(TD_N Or TD_NW Or TD_W) = 42
    tileMorphs(TD_N Or TD_W) = 43
    tileMorphs(TD_N Or TD_NE Or TD_E) = 44
    tileMorphs(TD_N Or TD_E) = 46
    tileMorphs(TD_S) = 47
    tileMorphs(TD_E) = 48
    tileMorphs(TD_N) = 49
    tileMorphs(TD_W) = 50
    tileMorphs(0) = 51
    tileMorphs(TD_N Or TD_S Or TD_W Or TD_E Or TD_NW Or TD_NE Or TD_SW Or TD_SE) = 52
    Exit Sub
reDimArray:
    ReDim Preserve tileMorphs(UBound(tileMorphs) + 1)
    Resume
End Sub

Attribute VB_Name = "modAutoTiler"
'========================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'========================================================================

Option Explicit

'=========================================================================
' AutoTiler initialization and constants, added by Shao, 09/24/2004
'=========================================================================

Public Const TD_N As Byte = 1
Public Const TD_S As Byte = 2
Public Const TD_W As Byte = 4
Public Const TD_E As Byte = 8
Public Const TD_NW As Byte = 16
Public Const TD_NE As Byte = 32
Public Const TD_SW As Byte = 64
Public Const TD_SE As Byte = 128

Public TileMorphs(0 To 255) As Integer 'each possible combination, most are unused

Public autoTilerSets() As String 'autotiler tilesets currently used

Public Sub SetupAutoTiler()
    ReDim autoTilerSets(0)
    TileMorphs(TD_N Or TD_S Or TD_W Or TD_E Or TD_NE Or TD_SW Or TD_SE) = 1
    TileMorphs(TD_N Or TD_S Or TD_W Or TD_E Or TD_NW Or TD_SW Or TD_SE) = 2
    TileMorphs(TD_N Or TD_S Or TD_W Or TD_E Or TD_SW Or TD_SE) = 3
    TileMorphs(TD_N Or TD_S Or TD_W Or TD_E Or TD_NW Or TD_NE Or TD_SW) = 4
    TileMorphs(TD_N Or TD_S Or TD_W Or TD_E Or TD_NE Or TD_SW) = 5
    TileMorphs(TD_N Or TD_S Or TD_W Or TD_E Or TD_NW Or TD_SW) = 6
    TileMorphs(TD_N Or TD_S Or TD_W Or TD_E Or TD_SW) = 7
    TileMorphs(TD_N Or TD_S Or TD_W Or TD_E Or TD_NW Or TD_NE Or TD_SE) = 8
    TileMorphs(TD_N Or TD_S Or TD_W Or TD_E Or TD_NE Or TD_SE) = 10
    TileMorphs(TD_N Or TD_S Or TD_W Or TD_E Or TD_NW Or TD_SE) = 11
    TileMorphs(TD_N Or TD_S Or TD_W Or TD_E Or TD_SE) = 12
    TileMorphs(TD_N Or TD_S Or TD_W Or TD_E Or TD_NW Or TD_NE) = 13
    TileMorphs(TD_N Or TD_S Or TD_W Or TD_E Or TD_NE) = 14
    TileMorphs(TD_N Or TD_S Or TD_W Or TD_E Or TD_NW) = 15
    TileMorphs(TD_N Or TD_S Or TD_W Or TD_E) = 16
    TileMorphs(TD_N Or TD_S Or TD_NE Or TD_SE Or TD_E) = 17
    TileMorphs(TD_N Or TD_S Or TD_SE Or TD_E) = 19
    TileMorphs(TD_N Or TD_S Or TD_NE Or TD_E) = 20
    TileMorphs(TD_N Or TD_S Or TD_E) = 21
    TileMorphs(TD_S Or TD_SW Or TD_SE Or TD_W Or TD_E) = 22
    TileMorphs(TD_S Or TD_SW Or TD_W Or TD_E) = 23
    TileMorphs(TD_S Or TD_SE Or TD_W Or TD_E) = 24
    TileMorphs(TD_S Or TD_W Or TD_E) = 25
    TileMorphs(TD_N Or TD_S Or TD_SW Or TD_NW Or TD_W) = 26
    TileMorphs(TD_N Or TD_S Or TD_NW Or TD_W) = 28
    TileMorphs(TD_N Or TD_S Or TD_SW Or TD_W) = 29
    TileMorphs(TD_N Or TD_S Or TD_W) = 30
    TileMorphs(TD_N Or TD_NW Or TD_NE Or TD_W Or TD_E) = 31
    TileMorphs(TD_N Or TD_NE Or TD_W Or TD_E) = 32
    TileMorphs(TD_N Or TD_NW Or TD_W Or TD_E) = 33
    TileMorphs(TD_N Or TD_E Or TD_W) = 34
    TileMorphs(TD_N Or TD_S) = 35
    TileMorphs(TD_E Or TD_W) = 37
    TileMorphs(TD_S Or TD_SE Or TD_E) = 38
    TileMorphs(TD_S Or TD_E) = 39
    TileMorphs(TD_S Or TD_SW Or TD_W) = 40
    TileMorphs(TD_S Or TD_W) = 41
    TileMorphs(TD_N Or TD_NW Or TD_W) = 42
    TileMorphs(TD_N Or TD_W) = 43
    TileMorphs(TD_N Or TD_NE Or TD_E) = 44
    TileMorphs(TD_N Or TD_E) = 46
    TileMorphs(TD_S) = 47
    TileMorphs(TD_E) = 48
    TileMorphs(TD_N) = 49
    TileMorphs(TD_W) = 50
    TileMorphs(0) = 51
    TileMorphs(TD_N Or TD_S Or TD_W Or TD_E Or TD_NW Or TD_NE Or TD_SW Or TD_SE) = 52
End Sub

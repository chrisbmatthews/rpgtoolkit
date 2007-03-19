Attribute VB_Name = "Commontkgfx"
'========================================================================
' The RPG Toolkit, Version 3
' This file copyright (C) 2007 Christopher Matthews & contributors
'
' Contributors:
'    - Colin James Fitzpatrick
'    - Jonathan D. Hughes
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

'=========================================================================
' Interface with actkrt.dll :: graphics
'=========================================================================

Option Explicit

'=========================================================================
' Integral variables
'=========================================================================

Private lastAnm As TKTileAnm    'last opened anm file
Private lastAnmFile As String   'last opened anm file name

'=========================================================================
' Delcarations for actkrt3.dll graphic exports
'=========================================================================
Public Declare Function GFXFunctionPtr Lib "actkrt3.dll" (ByVal functionAddr As Long) As Long
Public Declare Function GFXInit Lib "actkrt3.dll" (cbArray As Long, ByVal cbArrayCount As Long) As Long
Public Declare Function GFXKill Lib "actkrt3.dll" () As Long
Public Declare Function GFXAbout Lib "actkrt3.dll" () As Long
Public Declare Function GFXdrawpixel Lib "actkrt3.dll" (ByVal hdc As Long, ByVal x As Long, ByVal y As Long, ByVal col As Long) As Long
Public Declare Function GFXInitScreen Lib "actkrt3.dll" (ByVal screenX As Long, ByVal screenY As Long) As Long
Public Declare Function GFXdrawtile Lib "actkrt3.dll" (ByVal fName As String, ByVal x As Double, ByVal y As Double, ByVal rRed As Long, ByVal gGreen As Long, ByVal bBlue As Long, ByVal hdc As Long, ByVal nIsometric As Long, Optional ByVal isoEvenOdd As Long = 0) As Long
Public Declare Function GFXdrawtilemask Lib "actkrt3.dll" (ByVal fName As String, ByVal x As Double, ByVal y As Double, ByVal rRed As Long, ByVal gGreen As Long, ByVal bBlue As Long, ByVal hdc As Long, ByVal nDirectBlt As Long, ByVal nIsometric As Long, ByVal isoEvenOdd As Long) As Long
Public Declare Function GFXdrawboard Lib "actkrt3.dll" (ByVal pBrd As Long, ByVal hdc As Long, ByVal maskhdc As Long, ByVal layer As Long, ByVal nTopx As Long, ByVal nTopy As Long, ByVal nTilesx As Long, ByVal nTilesy As Long, ByVal nBsizex As Long, ByVal nBsizey As Long, ByVal nBsizel As Long, ByVal ar As Long, ByVal ag As Long, ByVal ab As Long, ByVal nIsometric As Long) As Long
Public Declare Function GFXdrawTstWindow Lib "actkrt3.dll" (ByVal fName As String, ByVal hdc As Long, ByVal start As Long, ByVal tX As Long, ByVal tY As Long, ByVal nIsometric As Long) As Long
Public Declare Function GFXBitBltTransparent Lib "actkrt3.dll" (ByVal hdcDest As Long, ByVal xDest As Long, ByVal yDest As Long, ByVal width As Long, ByVal Height As Long, ByVal hdcSrc As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal transRed As Long, ByVal transGreen As Long, ByVal transBlue As Long) As Long
Public Declare Function GFXBitBltTranslucent Lib "actkrt3.dll" (ByVal hdcDest As Long, ByVal xDest As Long, ByVal yDest As Long, ByVal width As Long, ByVal Height As Long, ByVal hdcSrc As Long, ByVal xSrc As Long, ByVal ySrc As Long) As Long
Public Declare Function GFXBitBltAdditive Lib "actkrt3.dll" (ByVal hdcDest As Long, ByVal xDest As Long, ByVal yDest As Long, ByVal width As Long, ByVal Height As Long, ByVal hdcSrc As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal nPercent As Long) As Long
Public Declare Function GFXClearTileCache Lib "actkrt3.dll" () As Long
Public Declare Function GFXdeleteTileFromCache Lib "actkrt3.dll" (ByVal filename As String) As Long
Public Declare Function GFXGetDOSColor Lib "actkrt3.dll" (ByVal idx As Long) As Long
Public Declare Function TKInit Lib "actkrt3.dll" () As Long
Public Declare Function TKClose Lib "actkrt3.dll" () As Long
Public Declare Function GFXDrawTileCNV Lib "actkrt3.dll" (ByVal fName As String, ByVal x As Double, ByVal y As Double, ByVal rRed As Long, ByVal gGreen As Long, ByVal bBlue As Long, ByVal cnvHandle As Long, ByVal nIsometric As Long, Optional ByVal isoEvenOdd As Long = 0) As Long
Public Declare Function GFXDrawTileMaskCNV Lib "actkrt3.dll" (ByVal fName As String, ByVal x As Double, ByVal y As Double, ByVal rRed As Long, ByVal gGreen As Long, ByVal bBlue As Long, ByVal cnvHandle As Long, ByVal nDirectBlt As Long, ByVal nIsometric As Long, ByVal isoEvenOdd As Long) As Long
Public Declare Function GFXDrawBoardCNV Lib "actkrt3.dll" (ByVal pBrd As Long, ByVal cnv As Long, ByVal layer As Long, ByVal nTopx As Long, ByVal nTopy As Long, ByVal nTilesx As Long, ByVal nTilesy As Long, ByVal nBsizex As Long, ByVal nBsizey As Long, ByVal nBsizel As Long, ByVal ar As Long, ByVal ag As Long, ByVal ab As Long, ByVal nIsometric As Long) As Long

'=========================================================================
' Draw a tile
'=========================================================================
Public Sub drawTile(ByVal dc As Long, ByVal file As String, ByVal x As Double, ByVal y As Double, ByVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal bMask As Boolean, Optional ByVal bNonTransparentMask As Boolean = True, Optional ByVal bIsometric As Boolean = False, Optional ByVal isoEvenOdd As Boolean = False)

    On Error Resume Next
    
    Dim anm As TKTileAnm, iso As Long, of As String, Temp As String, ex As String, ff As String

    'Don't draw the tile if there isn't one!
    If (LenB(RemovePath(file)) = 0) Then Exit Sub

    If bIsometric Then
        iso = 1
    Else
        iso = 0
    End If

    Dim isoEO As Long
    If isoEvenOdd Then
        isoEO = 0
    Else
        isoEO = 1
    End If
   
    #If isToolkit = 0 Then
   
        If pakFileRunning Then
            'do check for pakfile system
            of$ = file$
            Temp$ = RemovePath(file$)
            ex$ = GetExt(Temp$)
            If UCase$(ex$) = "TST" Then
                'numof = getTileNum(temp$)
                Temp$ = tilesetFilename(Temp$)
            End If
            file$ = PakLocate(tilePath & Temp$)
        
            If UCase$(ex$) = "TAN" Then
                ff$ = RemovePath(Temp$)
                Call openTileAnm(projectPath & tilePath & ff$, anm)
                file$ = TileAnmGet(anm, 0)
            End If
        
            ChangeDir (PakTempPath$)
            ff$ = RemovePath(of$)
            If Not (bMask) Then
                Call GFXdrawtile(ff$, x, y, r, g, b, dc, iso, isoEO)
            Else
                If bNonTransparentMask Then
                    Call GFXdrawtilemask(ff$, x, y, r, g, b, dc, 1, iso, isoEO)
                Else
                    Call GFXdrawtilemask(ff$, x, y, r, g, b, dc, 0, iso, isoEO)
                End If
            End If
            ChangeDir (currentDir$)
    #Else
        If 1 = 0 Then
    #End If
    Else
        ex$ = GetExt(file$)
        If UCase$(ex$) = "TAN" Then
            ff$ = RemovePath(file$)
            Call openTileAnm(projectPath & tilePath & ff$, anm)
            file$ = projectPath & tilePath & TileAnmGet(anm, 0)
        End If
        Call ChDir(projectPath)
        ff$ = RemovePath(file$)
        If Not (bMask) Then
            Call GFXdrawtile(ff$, x, y, r, g, b, dc, iso, isoEO)
        Else
            If bNonTransparentMask Then
                Call GFXdrawtilemask(ff$, x, y, r, g, b, dc, 1, iso, isoEO)
            Else
                Call GFXdrawtilemask(ff$, x, y, r, g, b, dc, 0, iso, isoEO)
            End If
        End If
        Call ChDir(currentDir)
    End If
    
End Sub

'=========================================================================
' Draw a tile onto a canvas
'=========================================================================
Public Sub drawTileCnv(ByVal cnv As Long, ByVal file As String, ByVal x As Double, ByVal y As Double, ByVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal bMask As Boolean, Optional ByVal bNonTransparentMask As Boolean = True, Optional ByVal bIsometric As Boolean = False, Optional ByVal isoEvenOdd As Boolean = False)

    On Error GoTo ErrorHandler
    
    Dim anm As TKTileAnm, iso As Long, of As String, Temp As String, ex As String, ff As String
    
    'Don't draw the tile if there isn't one!
    If (LenB(RemovePath(file)) = 0) Then Exit Sub
    
    If bIsometric Then
        iso = 1
    Else
        iso = 0
    End If
    
    Dim isoEO As Long
    If isoEvenOdd Then
        isoEO = 0
    Else
        isoEO = 1
    End If
            
    #If isToolkit = 0 Then
            
        If pakFileRunning Then
            'do check for pakfile system
            of$ = file$
            Temp$ = RemovePath(file$)
            ex$ = GetExt(Temp$)
            If UCase$(ex$) = "TST" Then
                'numof = getTileNum(temp$)
                Temp$ = tilesetFilename(Temp$)
            End If
            file$ = PakLocate(tilePath & Temp$)
        
            If UCase$(ex$) = "TAN" Then
                ff$ = RemovePath(Temp$)
                Call openTileAnm(projectPath & tilePath & ff$, anm)
                file$ = TileAnmGet(anm, 0)
            End If
        
            ChangeDir (PakTempPath$)
            ff$ = RemovePath(of$)
            If Not (bMask) Then
                Call GFXDrawTileCNV(ff$, x, y, r, g, b, cnv, iso, isoEO)
            Else
                If bNonTransparentMask Then
                    Call GFXDrawTileMaskCNV(ff$, x, y, r, g, b, cnv, 1, iso, isoEO)
                Else
                    Call GFXDrawTileMaskCNV(ff$, x, y, r, g, b, cnv, 0, iso, isoEO)
                End If
            End If
            ChangeDir (currentDir$)
    #Else
        If 1 = 0 Then
    #End If
    Else
        ex$ = GetExt(file$)
        If UCase$(ex$) = "TAN" Then
            ff$ = RemovePath(file$)
            Call openTileAnm(projectPath & tilePath & ff$, anm)
            file$ = projectPath & tilePath & TileAnmGet(anm, 0)
        End If
        ChDir (projectPath$)
        ff$ = RemovePath(file$)
        If Not (bMask) Then
            Call GFXDrawTileCNV(ff$, x, y, r, g, b, cnv, iso, isoEO)
        Else
            If bNonTransparentMask Then
                Call GFXDrawTileMaskCNV(ff$, x, y, r, g, b, cnv, 1, iso, isoEO)
            Else
                Call GFXDrawTileMaskCNV(ff$, x, y, r, g, b, cnv, 0, iso, isoEO)
            End If
        End If
        ChDir (currentDir$)
    End If
    
    Exit Sub
'Begin error handling code:
ErrorHandler:
    
    Resume Next
End Sub

'=========================================================================
' Initiates the runtime libraries
'=========================================================================
Public Function initRuntime() As Boolean
    On Error GoTo rtErr
    Call TKInit
    initRuntime = True
rtErr:
End Function

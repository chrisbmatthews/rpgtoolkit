Attribute VB_Name = "Commontkgfx"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'Requires Commonboard.bas
'requires CommonTileAnm.bas
Option Explicit

Private lastAnm As TKTileAnm    'last opened anm file
Private lastAnmFile As String   'last opened anm file name

Declare Function GFXFunctionPtr Lib "actkrt3.dll" (ByVal functionAddr As Long) As Long

Declare Function GFXInit Lib "actkrt3.dll" (cbArray As Long, ByVal cbArrayCount As Long) As Long

Declare Function GFXKill Lib "actkrt3.dll" () As Long

Declare Function GFXAbout Lib "actkrt3.dll" () As Long

Declare Function GFXdrawpixel Lib "actkrt3.dll" (ByVal hdc As Long, _
                                                                     ByVal x As Long, _
                                                                     ByVal y As Long, _
                                                                     ByVal col As Long) As Long
Declare Function GFXInitScreen Lib "actkrt3.dll" (ByVal screenX As Long, _
                                                ByVal screenY As Long) As Long


Declare Function GFXdrawtile Lib "actkrt3.dll" (ByVal fName As String, _
                                                ByVal x As Double, _
                                                ByVal y As Double, _
                                                ByVal rred As Long, _
                                                ByVal ggreen As Long, _
                                                ByVal bblue As Long, _
                                                ByVal hdc As Long, ByVal nIsometric As Long, Optional ByVal isoEvenOdd As Long = 0) As Long

Declare Function GFXdrawtilemask Lib "actkrt3.dll" (ByVal fName As String, _
                                                ByVal x As Double, _
                                                ByVal y As Double, _
                                                ByVal rred As Long, _
                                                ByVal ggreen As Long, _
                                                ByVal bblue As Long, _
                                                ByVal hdc As Long, ByVal nDirectBlt As Long, ByVal nIsometric As Long, ByVal isoEvenOdd As Long) As Long

Declare Function GFXdrawboard Lib "actkrt3.dll" (ByVal hdc As Long, _
                                                ByVal maskhdc As Long, _
                                                ByVal layer As Long, _
                                                ByVal nTopx As Long, _
                                                ByVal nTopy As Long, _
                                                ByVal nTilesx As Long, _
                                                ByVal nTilesy As Long, _
                                                ByVal nBsizex As Long, _
                                                ByVal nBsizey As Long, _
                                                ByVal nBsizel As Long, _
                                                ByVal ar As Long, _
                                                ByVal ag As Long, _
                                                ByVal ab As Long, _
                                                ByVal nIsometric As Long) As Long

Declare Function GFXdrawTstWindow Lib "actkrt3.dll" (ByVal fName As String, _
                                                    ByVal hdc As Long, _
                                                    ByVal start As Long, ByVal tX As Long, ByVal tY As Long, ByVal nIsometric As Long) As Long


Declare Function GFXBitBltTransparent Lib "actkrt3.dll" (ByVal hdcDest As Long, _
                                                        ByVal xDest As Long, _
                                                        ByVal yDest As Long, _
                                                        ByVal Width As Long, _
                                                        ByVal height As Long, _
                                                        ByVal hdcSrc As Long, _
                                                        ByVal xsrc As Long, _
                                                        ByVal ysrc As Long, _
                                                        ByVal transRed As Long, _
                                                        ByVal transGreen As Long, _
                                                        ByVal transBlue As Long) As Long

Declare Function GFXBitBltTranslucent Lib "actkrt3.dll" (ByVal hdcDest As Long, _
                                                        ByVal xDest As Long, _
                                                        ByVal yDest As Long, _
                                                        ByVal Width As Long, _
                                                        ByVal height As Long, _
                                                        ByVal hdcSrc As Long, _
                                                        ByVal xsrc As Long, _
                                                        ByVal ysrc As Long) As Long

Declare Function GFXBitBltAdditive Lib "actkrt3.dll" (ByVal hdcDest As Long, _
                                                        ByVal xDest As Long, _
                                                        ByVal yDest As Long, _
                                                        ByVal Width As Long, _
                                                        ByVal height As Long, _
                                                        ByVal hdcSrc As Long, _
                                                        ByVal xsrc As Long, _
                                                        ByVal ysrc As Long, _
                                                        ByVal nPercent As Long) As Long


Declare Function GFXSetCurrentTileString Lib "actkrt3.dll" (ByVal stringToSet As String) As Long

Declare Function GFXClearTileCache Lib "actkrt3.dll" () As Long

Declare Function GFXGetDOSColor Lib "actkrt3.dll" (ByVal idx As Long) As Long

Declare Function TKInit Lib "actkrt3.dll" () As Long

Declare Function TKClose Lib "actkrt3.dll" () As Long

Declare Function GFXDrawTileCNV Lib "actkrt3.dll" (ByVal fName As String, _
                                                ByVal x As Double, _
                                                ByVal y As Double, _
                                                ByVal rred As Long, _
                                                ByVal ggreen As Long, _
                                                ByVal bblue As Long, _
                                                ByVal cnvHandle As Long, ByVal nIsometric As Long, Optional ByVal isoEvenOdd As Long = 0) As Long

Declare Function GFXDrawTileMaskCNV Lib "actkrt3.dll" (ByVal fName As String, _
                                                ByVal x As Double, _
                                                ByVal y As Double, _
                                                ByVal rred As Long, _
                                                ByVal ggreen As Long, _
                                                ByVal bblue As Long, _
                                                ByVal cnvHandle As Long, ByVal nDirectBlt As Long, ByVal nIsometric As Long, ByVal isoEvenOdd As Long) As Long

Declare Function GFXDrawBoardCNV Lib "actkrt3.dll" (ByVal cnv As Long, _
                                                ByVal cnvMask As Long, _
                                                ByVal layer As Long, _
                                                ByVal nTopx As Long, _
                                                ByVal nTopy As Long, _
                                                ByVal nTilesx As Long, _
                                                ByVal nTilesy As Long, _
                                                ByVal nBsizex As Long, _
                                                ByVal nBsizey As Long, _
                                                ByVal nBsizel As Long, _
                                                ByVal ar As Long, _
                                                ByVal ag As Long, _
                                                ByVal ab As Long, _
                                                ByVal nIsometric As Long) As Long

Sub drawtile(ByVal dc As Long, ByVal file$, ByVal x As Double, ByVal y As Double, ByVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal bMask As Boolean, Optional ByVal bNonTransparentMask As Boolean = True, Optional ByVal bIsometric As Boolean = False, Optional ByVal isoEvenOdd As Boolean = False)
    'draw a tile, or optionally its mask...
    'isEvenOdd - of the tile is in board coords at an odd y coord, then this will be flase, else true
    On Error GoTo ErrorHandler
    
    Dim anm As TKTileAnm
    
    Dim iso As Long, of As String, Temp As String, ex As String, ff As String, A As Long
    If bIsometric Then
        iso = 1
    Else
        iso = 0
    End If
    
    Dim isoeo As Long
    If isoEvenOdd Then
        isoeo = 0
    Else
        isoeo = 1
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
            file$ = PakLocate(tilePath$ + Temp$)
        
            If UCase$(ex$) = "TAN" Then
                ff$ = RemovePath(Temp$)
                Call openTileAnm(projectPath$ + tilePath$ + ff$, anm)
                file$ = TileAnmGet(anm, 0)
            End If
        
            ChangeDir (PakTempPath$)
            ff$ = RemovePath(of$)
            If Not (bMask) Then
                A = GFXdrawtile(ff$, x, y, r, g, b, dc, iso, isoeo)
            Else
                If bNonTransparentMask Then
                    A = GFXdrawtilemask(ff$, x, y, r, g, b, dc, 1, iso, isoeo)
                Else
                    A = GFXdrawtilemask(ff$, x, y, r, g, b, dc, 0, iso, isoeo)
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
            Call openTileAnm(projectPath$ + tilePath$ + ff$, anm)
            file$ = projectPath$ + tilePath$ + TileAnmGet(anm, 0)
        End If
        ChDir (projectPath$)
        ff$ = RemovePath(file$)
        If Not (bMask) Then
            A = GFXdrawtile(ff$, x, y, r, g, b, dc, iso, isoeo)
        Else
            If bNonTransparentMask Then
                A = GFXdrawtilemask(ff$, x, y, r, g, b, dc, 1, iso, isoeo)
            Else
                A = GFXdrawtilemask(ff$, x, y, r, g, b, dc, 0, iso, isoeo)
            End If
        End If
        ChDir (currentDir$)
    End If
    
    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Sub drawtileCNV(ByVal cnv As Long, ByVal file$, ByVal x As Double, ByVal y As Double, ByVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal bMask As Boolean, Optional ByVal bNonTransparentMask As Boolean = True, Optional ByVal bIsometric As Boolean = False, Optional ByVal isoEvenOdd As Boolean = False)
    'draw a tile, or optionally its mask...
    'isEvenOdd - of the tile is in board coords at an odd y coord, then this will be flase, else true
    On Error GoTo ErrorHandler
    
    Dim anm As TKTileAnm
    
    Dim iso As Long, of As String, Temp As String, ex As String, ff As String, A As Long
    If bIsometric Then
        iso = 1
    Else
        iso = 0
    End If
    
    Dim isoeo As Long
    If isoEvenOdd Then
        isoeo = 0
    Else
        isoeo = 1
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
            file$ = PakLocate(tilePath$ + Temp$)
        
            If UCase$(ex$) = "TAN" Then
                ff$ = RemovePath(Temp$)
                Call openTileAnm(projectPath$ + tilePath$ + ff$, anm)
                file$ = TileAnmGet(anm, 0)
            End If
        
            ChangeDir (PakTempPath$)
            ff$ = RemovePath(of$)
            If Not (bMask) Then
                A = GFXDrawTileCNV(ff$, x, y, r, g, b, cnv, iso, isoeo)
            Else
                If bNonTransparentMask Then
                    A = GFXDrawTileMaskCNV(ff$, x, y, r, g, b, cnv, 1, iso, isoeo)
                Else
                    A = GFXDrawTileMaskCNV(ff$, x, y, r, g, b, cnv, 0, iso, isoeo)
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
            Call openTileAnm(projectPath$ + tilePath$ + ff$, anm)
            file$ = projectPath$ + tilePath$ + TileAnmGet(anm, 0)
        End If
        ChDir (projectPath$)
        ff$ = RemovePath(file$)
        If Not (bMask) Then
            A = GFXDrawTileCNV(ff$, x, y, r, g, b, cnv, iso, isoeo)
        Else
            If bNonTransparentMask Then
                A = GFXDrawTileMaskCNV(ff$, x, y, r, g, b, cnv, 1, iso, isoeo)
            Else
                A = GFXDrawTileMaskCNV(ff$, x, y, r, g, b, cnv, 0, iso, isoeo)
            End If
        End If
        ChDir (currentDir$)
    End If
    
    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Function GFXBoardTile(ByVal x As Long, ByVal y As Long, ByVal l As Long) As Long
    'get tile name on the board...
    On Error Resume Next
    Dim res As String
    Dim Length As Long
    
    res = BoardGetTile(x, y, l, boardList(activeBoardIndex).theData)
    
    If GetExt(UCase$(res)) = "TAN" Then
        'it's an animated tile-- pass back the first frame
        If UCase$(lastAnmFile) <> UCase$(res) Then
            Call openTileAnm(tilePath$ + res, lastAnm)
            lastAnmFile = res
        End If
        res = TileAnmGet(lastAnm, 0)
    End If
   
    'send result back to actkrt3.dll
    Call GFXSetCurrentTileString(res)
    
    GFXBoardTile = Len(res)
End Function

Function GFXBoardRed(ByVal x As Long, ByVal y As Long, ByVal l As Long) As Long
    'get red tile on the board...
    On Error Resume Next
    GFXBoardRed = boardList(activeBoardIndex).theData.ambientred(x, y, l)
End Function

Function GFXBoardGreen(ByVal x As Long, ByVal y As Long, ByVal l As Long) As Long
    'get red tile on the board...
    On Error Resume Next
    GFXBoardGreen = boardList(activeBoardIndex).theData.ambientgreen(x, y, l)
End Function

Function GFXBoardBlue(ByVal x As Long, ByVal y As Long, ByVal l As Long) As Long
    'get blue tile on the board...
    On Error Resume Next
    GFXBoardBlue = boardList(activeBoardIndex).theData.ambientblue(x, y, l)
End Function

Function InitRuntime() As Boolean
    'init runtime dll
    On Error GoTo rterr
    
    Dim A As Long
    A = TKInit()
    InitRuntime = True
    Exit Function
rterr:
    InitRuntime = False
End Function

Sub InitTkGfx()
    'init graphic engine (set up callbacks)
    Dim cblist(10) As Long
    
    cblist(0) = GFXFunctionPtr(AddressOf GFXBoardTile)
    cblist(1) = GFXFunctionPtr(AddressOf GFXBoardRed)
    cblist(2) = GFXFunctionPtr(AddressOf GFXBoardGreen)
    cblist(3) = GFXFunctionPtr(AddressOf GFXBoardBlue)
    
    Dim aa As Long
    aa = GFXInit(cblist(0), 4)
End Sub

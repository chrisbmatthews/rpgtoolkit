Attribute VB_Name = "Commontkgfx"
'=========================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=========================================================================

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
Public Declare Function GFXdrawtile Lib "actkrt3.dll" (ByVal fName As String, ByVal x As Double, ByVal y As Double, ByVal rred As Long, ByVal ggreen As Long, ByVal bblue As Long, ByVal hdc As Long, ByVal nIsometric As Long, Optional ByVal isoEvenOdd As Long = 0) As Long
Public Declare Function GFXdrawtilemask Lib "actkrt3.dll" (ByVal fName As String, ByVal x As Double, ByVal y As Double, ByVal rred As Long, ByVal ggreen As Long, ByVal bblue As Long, ByVal hdc As Long, ByVal nDirectBlt As Long, ByVal nIsometric As Long, ByVal isoEvenOdd As Long) As Long
Public Declare Function GFXdrawboard Lib "actkrt3.dll" (ByVal hdc As Long, ByVal maskhdc As Long, ByVal layer As Long, ByVal nTopx As Long, ByVal nTopy As Long, ByVal nTilesx As Long, ByVal nTilesy As Long, ByVal nBsizex As Long, ByVal nBsizey As Long, ByVal nBsizel As Long, ByVal ar As Long, ByVal ag As Long, ByVal ab As Long, ByVal nIsometric As Long) As Long
Public Declare Function GFXdrawTstWindow Lib "actkrt3.dll" (ByVal fName As String, ByVal hdc As Long, ByVal start As Long, ByVal tX As Long, ByVal tY As Long, ByVal nIsometric As Long) As Long
Public Declare Function GFXBitBltTransparent Lib "actkrt3.dll" (ByVal hdcDest As Long, ByVal xDest As Long, ByVal yDest As Long, ByVal Width As Long, ByVal height As Long, ByVal hdcSrc As Long, ByVal xsrc As Long, ByVal ysrc As Long, ByVal transRed As Long, ByVal transGreen As Long, ByVal transBlue As Long) As Long
Public Declare Function GFXBitBltTranslucent Lib "actkrt3.dll" (ByVal hdcDest As Long, ByVal xDest As Long, ByVal yDest As Long, ByVal Width As Long, ByVal height As Long, ByVal hdcSrc As Long, ByVal xsrc As Long, ByVal ysrc As Long) As Long
Public Declare Function GFXBitBltAdditive Lib "actkrt3.dll" (ByVal hdcDest As Long, ByVal xDest As Long, ByVal yDest As Long, ByVal Width As Long, ByVal height As Long, ByVal hdcSrc As Long, ByVal xsrc As Long, ByVal ysrc As Long, ByVal nPercent As Long) As Long
Public Declare Function GFXSetCurrentTileString Lib "actkrt3.dll" (ByVal stringToSet As String) As Long
Public Declare Function GFXClearTileCache Lib "actkrt3.dll" () As Long
Public Declare Function GFXGetDOSColor Lib "actkrt3.dll" (ByVal idx As Long) As Long
Public Declare Function TKInit Lib "actkrt3.dll" () As Long
Public Declare Function TKClose Lib "actkrt3.dll" () As Long
Public Declare Function GFXDrawTileCNV Lib "actkrt3.dll" (ByVal fName As String, ByVal x As Double, ByVal y As Double, ByVal rred As Long, ByVal ggreen As Long, ByVal bblue As Long, ByVal cnvHandle As Long, ByVal nIsometric As Long, Optional ByVal isoEvenOdd As Long = 0) As Long
Public Declare Function GFXDrawTileMaskCNV Lib "actkrt3.dll" (ByVal fName As String, ByVal x As Double, ByVal y As Double, ByVal rred As Long, ByVal ggreen As Long, ByVal bblue As Long, ByVal cnvHandle As Long, ByVal nDirectBlt As Long, ByVal nIsometric As Long, ByVal isoEvenOdd As Long) As Long
Public Declare Function GFXDrawBoardCNV Lib "actkrt3.dll" (ByVal cnv As Long, ByVal cnvMask As Long, ByVal layer As Long, ByVal nTopx As Long, ByVal nTopy As Long, ByVal nTilesx As Long, ByVal nTilesy As Long, ByVal nBsizex As Long, ByVal nBsizey As Long, ByVal nBsizel As Long, ByVal ar As Long, ByVal ag As Long, ByVal ab As Long, ByVal nIsometric As Long) As Long

'=========================================================================
' Draw a tile
'=========================================================================
Public Sub drawTile(ByVal dc As Long, ByVal file As String, ByVal x As Double, ByVal y As Double, ByVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal bMask As Boolean, Optional ByVal bNonTransparentMask As Boolean = True, Optional ByVal bIsometric As Boolean = False, Optional ByVal isoEvenOdd As Boolean = False)

    On Error Resume Next
    
    Dim anm As TKTileAnm, iso As Long, of As String, Temp As String, ex As String, ff As String

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
Public Sub drawTileCNV(ByVal cnv As Long, ByVal file As String, ByVal x As Double, ByVal y As Double, ByVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal bMask As Boolean, Optional ByVal bNonTransparentMask As Boolean = True, Optional ByVal bIsometric As Boolean = False, Optional ByVal isoEvenOdd As Boolean = False)

    On Error GoTo errorhandler
    
    Dim anm As TKTileAnm
    
    Dim iso As Long, of As String, Temp As String, ex As String, ff As String
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
errorhandler:
    
    Resume Next
End Sub

'=========================================================================
' Get the tile at x,y,z
'=========================================================================
Public Function GFXBoardTile(ByVal x As Long, ByVal y As Long, ByVal z As Long) As Long

    On Error Resume Next

    Dim res As String
    Dim Length As Long
    
    res = BoardGetTile(x, y, z, boardList(activeBoardIndex).theData)
    
    If GetExt(UCase$(res)) = "TAN" Then
        'it's an animated tile-- pass back the first frame
        If UCase$(lastAnmFile) <> UCase$(res) Then
            Call openTileAnm(tilePath & res, lastAnm)
            lastAnmFile = res
        End If
        res = TileAnmGet(lastAnm, 0)
    End If
   
    'send result back to actkrt3.dll
    Call GFXSetCurrentTileString(res)
    
    GFXBoardTile = Len(res)
End Function

'=========================================================================
' Get ambient red a x,y,l
'=========================================================================
Public Function GFXBoardRed(ByVal x As Long, ByVal y As Long, ByVal l As Long) As Long
    On Error Resume Next
    GFXBoardRed = boardList(activeBoardIndex).theData.ambientRed(x, y, l)
End Function

'=========================================================================
' Get ambient green at x,y,l
'=========================================================================
Public Function GFXBoardGreen(ByVal x As Long, ByVal y As Long, ByVal l As Long) As Long
    On Error Resume Next
    GFXBoardGreen = boardList(activeBoardIndex).theData.ambientGreen(x, y, l)
End Function

'=========================================================================
' Get ambient blue at x,y,l
'=========================================================================
Public Function GFXBoardBlue(ByVal x As Long, ByVal y As Long, ByVal l As Long) As Long
    On Error Resume Next
    GFXBoardBlue = boardList(activeBoardIndex).theData.ambientBlue(x, y, l)
End Function

'=========================================================================
' Initiates the runtime libraries
'=========================================================================
Public Function InitRuntime() As Boolean
    On Error GoTo rtErr
    Call TKInit
    InitRuntime = True
rtErr:
End Function

'=========================================================================
' Initiate graphic callbacks
'=========================================================================
Public Sub InitTkGfx()
    Dim cbList(3) As Long
    cbList(0) = GFXFunctionPtr(AddressOf GFXBoardTile)
    cbList(1) = GFXFunctionPtr(AddressOf GFXBoardRed)
    cbList(2) = GFXFunctionPtr(AddressOf GFXBoardGreen)
    cbList(3) = GFXFunctionPtr(AddressOf GFXBoardBlue)
    Call GFXInit(cbList(0), 4)
End Sub

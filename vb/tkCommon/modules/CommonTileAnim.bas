Attribute VB_Name = "CommonTileAnim"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'Animated tile
Option Explicit

''''''''''''''''''''''tile anim data'''''''''''''''''''''''''

Type TKTileAnm
    animTileFrames As Long 'total number of frames
    animTileFrame() As String  'filenames of each image in animation
    animTilePause As Long   'Frames per second for animation (15 is fast)
    animTileCurrentFrame As Long    'current frame for insertion/animation
    
    'volatile-- for animation routines
    timerFrame As Long  'this number will be 0 to 29 to indicate how many times the timer has clicked.
    currentAnmFrame As Long 'currently animating frame
End Type

Type tileAnmDoc
    animTileFile As String
    animTileNeedUpdate As Boolean
    
    'data
    theData As TKTileAnm
End Type

Sub saveTileAnm(ByVal file As String, ByRef theAnm As TKTileAnm)
    'save animated tile
    On Error Resume Next
    Dim num As Long, t As Long
    num = FreeFile
    If (LenB(file) = 0) Then Exit Sub
    
    #If isToolkit = 1 Then
        tileAnmList(activeTileAnmIndex).animTileNeedUpdate = False
    #End If
    
    Dim cnt As Long
    cnt = TileAnmFrameCount(theAnm)
    
    Kill file
    Open file$ For Binary As #num
        Call BinWriteString(num, "RPGTLKIT TILEANIM")    'Filetype
        Call BinWriteInt(num, 2)               'Version
        Call BinWriteInt(num, 0)                'Minor version
        
        Call BinWriteLong(num, theAnm.animTilePause)
        Call BinWriteLong(num, cnt)     'number of frames
        For t = 0 To cnt - 1
            Call BinWriteString(num, theAnm.animTileFrame(t))
        Next t
    Close #num
End Sub

Sub openTileAnm(ByVal file As String, ByRef theAnm As TKTileAnm)
    'save animated tile
    On Error Resume Next
    
    If (LenB(file) = 0) Then Exit Sub
        
    Call TileAnmClear(theAnm)
    file = PakLocate(file)

    #If isToolkit = 1 Then
        tileAnmList(activeTileAnmIndex).animTileNeedUpdate = False
    #End If
    
    Dim cnt As Long
    
    Dim num As Long, fileHeader As String, majorVer As Long, minorVer As Long, t As Long
    num = FreeFile
    
    Open file$ For Binary As #num
        fileHeader$ = BinReadString(num)      'Filetype
        If fileHeader$ <> "RPGTLKIT TILEANIM" Then Close #num: MsgBox "Unrecognised File Format! " + file$, , "Open Animated Tile": Exit Sub
        majorVer = BinReadInt(num)         'Version
        minorVer = BinReadInt(num)         'Minor version (ie 2.0)
        If majorVer <> major Then MsgBox "This Move was created with an unrecognised version of the Toolkit", , "Unable to open Animated Tile": Close #num: Exit Sub
        
        theAnm.animTilePause = BinReadLong(num)
        cnt = BinReadLong(num)     'number of frames
        For t = 0 To cnt - 1
            Call TileAnmInsert(BinReadString(num), theAnm, t)
        Next t
    Close #num
End Sub

Function TileAnmFrameCount(ByRef theAnm As TKTileAnm) As Long
    'determine frame count
    
    On Error Resume Next
    
    Dim t As Long
    Dim cnt As Long
        
    For t = 0 To UBound(theAnm.animTileFrame)
        If (LenB(TileAnmGet(theAnm, t)) <> 0) Then
            cnt = t
        End If
    Next t
    
    TileAnmFrameCount = cnt + 1
    
End Function

Sub TileAnmClear(ByRef theAnm As TKTileAnm)
    On Error Resume Next

    theAnm.animTileFrames = 0
    ReDim theAnm.animTileFrame(10)
    theAnm.animTilePause = 1
    theAnm.animTileCurrentFrame = 0
    theAnm.timerFrame = 0
    theAnm.currentAnmFrame = 0
End Sub

Sub TileAnmDrawNextFrame(ByRef theAnm As TKTileAnm, ByVal hdc As Long, ByVal x As Double, ByVal y As Double, ByVal r As Long, ByVal g As Long, ByVal b As Long, Optional ByVal advanceFrame As Boolean = True, Optional ByVal DrawFrame As Boolean = True, Optional ByVal drawMask As Boolean = False, Optional ByVal hdcIso As Long = -1)
    'draw next frame
    'if drawFrame is false, it will not draw it, but it will advance the counter
    'if hdcIso <> -1 then we also draw it isometricall to the isoHdc
    
    On Error Resume Next
    If DrawFrame Then
        Call drawTile(hdc, projectPath & tilePath & TileAnmGet(theAnm, theAnm.currentAnmFrame), x, y, r, g, b, drawMask, False)
        
        If hdcIso <> -1 Then
            Call drawTile(hdcIso, projectPath & tilePath & TileAnmGet(theAnm, theAnm.currentAnmFrame), x, y + 1, r, g, b, drawMask, False, True, True)
        End If
    End If
    
    If advanceFrame Then
        theAnm.currentAnmFrame = theAnm.currentAnmFrame + 1
        If theAnm.currentAnmFrame > TileAnmFrameCount(theAnm) - 1 Then
            theAnm.currentAnmFrame = 0
        End If
    End If
End Sub

Sub TileAnmDrawNextFrameCNV(ByRef theAnm As TKTileAnm, ByVal cnv As Long, ByVal x As Double, ByVal y As Double, ByVal r As Long, ByVal g As Long, ByVal b As Long, Optional ByVal advanceFrame As Boolean = True, Optional ByVal DrawFrame As Boolean = True, Optional ByVal drawMask As Boolean = False, Optional ByVal cnvIso As Long = -1)
    'draw next frame
    'if drawFrame is false, it will not draw it, but it will advance the counter
    'if cnvIso <> -1 then we also draw it isometricall to the isoCnv
    
    On Error Resume Next
    If DrawFrame Then
        Call drawTileCNV(cnv, projectPath & tilePath & TileAnmGet(theAnm, theAnm.currentAnmFrame), x, y, r, g, b, drawMask, False)
        
        If cnvIso <> -1 Then
            Call drawTileCNV(cnvIso, projectPath & tilePath & TileAnmGet(theAnm, theAnm.currentAnmFrame), x, y + 1, r, g, b, drawMask, False, True, True)
        End If
    End If
    
    If advanceFrame Then
        theAnm.currentAnmFrame = theAnm.currentAnmFrame + 1
        If theAnm.currentAnmFrame > TileAnmFrameCount(theAnm) - 1 Then
            theAnm.currentAnmFrame = 0
        End If
    End If
End Sub

Function TileAnmGet(ByRef theAnm As TKTileAnm, ByVal nFrameNum As Long) As String
    'get the filename of a tile at frame number nFrameNum
    On Error Resume Next
    
    If (nFrameNum > theAnm.animTileFrames) Then
        TileAnmGet = vbNullString
        Exit Function
    Else
        TileAnmGet = theAnm.animTileFrame(nFrameNum)
    End If
End Function

Sub TileAnmInsert(ByVal theFile As String, ByRef theAnm As TKTileAnm, ByVal nFrameNum As Long)
    'insert a tile into the animation.
    'it will be inserted at nFrameNum
    On Error Resume Next
    
    'insert at a specific frame
    If nFrameNum > UBound(theAnm.animTileFrame) - 1 Then
        'resize
        Dim newSize As Long
        newSize = nFrameNum * 2
        ReDim Preserve theAnm.animTileFrame(newSize)
        theAnm.animTileFrames = nFrameNum + 1
    End If
    
    theAnm.animTileFrame(nFrameNum) = theFile
    
    If (nFrameNum > theAnm.animTileFrames) Then
        theAnm.animTileFrames = nFrameNum + 1
    End If
    
    #If isToolkit = 0 Then
        If (LenB(theFile) <> 0) And pakFileRunning Then
            'do check for pakfile system
            Dim ex As String
            Dim Temp As String
            Temp = theFile
            ex$ = GetExt(Temp$)
            If Left$(UCase$(ex$), 3) = "TST" Then
                Temp$ = tilesetFilename(Temp$)
            End If
            Call PakLocate(tilePath & Temp$)
        End If
    #End If

End Sub

Function TileAnmShouldDrawFrame(ByRef theAnm As TKTileAnm) As Boolean
    'this routine assumes it will be called by a timer every 5 ms (that's 200 times per second (200 fps))
    'based upon the fps for the tile (the pause length), the current frame will be advanced
    'or it won't be advanced.
    
    'this will return true if it's time to draw this frame again.
    'it will return false otherwise, but will advance the timer counter
    
    On Error Resume Next
    
    Dim toRet As Boolean
    toRet = False
    
    Dim interval As Long
    interval = 200 / theAnm.animTilePause
    
    If theAnm.timerFrame Mod interval = 0 Then
        toRet = True
    End If
    
    theAnm.timerFrame = theAnm.timerFrame + 1
    
    TileAnmShouldDrawFrame = toRet
End Function

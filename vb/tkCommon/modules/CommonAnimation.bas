Attribute VB_Name = "CommonAnimation"
'========================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'========================================================================

'=========================================================================
' RPGToolkit animation file format (*.anm)
'=========================================================================

'=========================================================================
'EDITED [KSNiloc] [September 2, 2004]
'------------------------------------
' + New binary animation format
'=========================================================================

Option Explicit

'========================================================================
' Definition of a Tk Animation
'========================================================================
Type TKAnimation
    animSizeX As Integer            'width
    animSizeY As Integer            'height
    animFrames As Integer           'total number of frames
    animFrame(50) As String         'filenames of each image in animation
    animTransp(50) As Long          'Transparent color for frame
    animSound(50) As String         'sounds for each frame
    animPause As Double             'Pause length (sec) between each frame
    animCurrentFrame As Long        'current frame we are editing
    animGetTransp As Boolean        'currently getting transparent color?
    timerFrame As Long              'This number will be 0 to 29 to indicate how many
                                    'times the timer has clicked
    currentAnmFrame As Long         'currently animating frame
    animFile As String              'filename (no path)
    loop As Boolean                 'should this animation loop?
End Type

'========================================================================
' The stored data
'========================================================================
Type animationDoc
    animFile As String              'filename
    animNeedUpdate As Boolean       'Needs to be updated?
    theData As TKAnimation          'Stored Data
End Type

'========================================================================
' One frame of an animation
'========================================================================
Private Type AnimationFrame
    cnv As Long                     'Canvas of frame
    file As String                  'Animation filename
    frame As Long                   'Frame number
End Type

'========================================================================
' Other variables
'========================================================================

'array of animations that can be created by a plugin
Public anmList() As animationDoc
Public anmListOccupied() As Boolean

'Cache of animation frames
Private anmCache(250) As AnimationFrame
'Next index for animation cache
Private nextAnmCacheIdx As Long

Declare Function TransparentBlt Lib "msimg32" (ByVal hdcDest As Long, _
                                               ByVal nXOriginDest As Long, _
                                               ByVal nYOriginDest As Long, _
                                               ByVal nWidthDest As Long, _
                                               ByVal nHeightDest As Long, _
                                               ByVal hdcSrc As Long, _
                                               ByVal nXOriginSrc As Long, _
                                               ByVal nYOriginSrc As Long, _
                                               ByVal nWidthSrc As Long, _
                                               ByVal nHeightSrc As Long, _
                                               ByVal crTransparent As Long) As Long

Private Const FILE_HEADER = "RPGTLKIT ANIM"

'========================================================================
' Open the animation
'========================================================================
Public Sub openAnimation(ByVal file As String, ByRef theAnim As TKAnimation)

    On Error Resume Next

    'Get ready to read the animation
    If Not fileExists(file) Then Exit Sub
    Call AnimationClear(theAnim)
    file = PakLocate(file)
#If isToolkit = 1 Then
    animationList(activeAnimationIndex).animNeedUpdate = False
#End If

    Dim num As Long         'file position
    Dim frameIdx As Long    'frame index
    Dim majorVer As Long    'major version of TK

    num = FreeFile()

    With theAnim

        Open file For Binary Access Read As num
            If (BinReadString(num) = FILE_HEADER) Then
                'Binary mode!
                Call BinReadInt(num)
                If (BinReadInt(num) = 3) Then
                    'New binary animation format
                    .animSizeX = BinReadLong(num)
                    .animSizeY = BinReadLong(num)
                    .animFrames = BinReadLong(num)
                    For frameIdx = 0 To (.animFrames)
                        .animFrame(frameIdx) = BinReadString(num)
                        .animTransp(frameIdx) = BinReadLong(num)
                        .animSound(frameIdx) = BinReadString(num)
                    Next frameIdx
                    .animPause = BinReadDouble(num)
                Else
                    Call MsgBox("This is not a valid animaton file. " & file)
                End If
            Else
                'Not in binary mode!
                Close num
                Open file For Input Access Read As num
                If fread(num) <> FILE_HEADER Then
                    Close num
                    Call MsgBox("This is not a valid animaton file. " & file)
                    Exit Sub
                End If
                majorVer = fread(num)
                Call fread(num)
                If majorVer <> major Then
                    Call MsgBox("This animation was created with an unrecognised" _
                                & " version of the Toolkit", , "Unable to open animation")
                    Close num
                    Exit Sub
                End If
                .animSizeX = fread(num)
                .animSizeY = fread(num)
                .animFrames = fread(num)
                For frameIdx = 0 To 50
                    .animFrame(frameIdx) = fread(num)
                    .animTransp(frameIdx) = fread(num)
                    .animSound(frameIdx) = fread(num)
                Next frameIdx
                .animPause = fread(num)
            End If
        Close num

        .animFile = RemovePath(file)

    End With

End Sub

'========================================================================
' Clear animation
'========================================================================
Public Sub AnimationClear(ByRef theAnim As TKAnimation)
    On Error Resume Next

    theAnim.animSizeX = 64                  'X-size
    theAnim.animSizeY = 64                  'Y-size
    theAnim.animFrames = 0                  'Total number of frames
    Dim t As Long
    For t = 0 To UBound(theAnim.animFrame)  'Clears the frames
        theAnim.animFrame(t) = vbNullString
        theAnim.animTransp(t) = 0
        theAnim.animSound(t) = vbNullString
    Next t
    theAnim.animPause = 0                   'Pause length (sec) between each frame

    theAnim.animCurrentFrame = 0            'Currentframe
    theAnim.animGetTransp = False           'Currently getting transparent color?
End Sub

'========================================================================
' Get the frame count of animation at idx
'========================================================================
Public Function AnimationIndexMaxFrames(ByVal idx As Long) As Long
    On Error Resume Next
    If anmListOccupied(idx) Then
        AnimationIndexMaxFrames = animGetMaxFrame(anmList(idx).theData)
    End If
End Function

'========================================================================
' Delays for x numbers of seconds
'========================================================================
Public Sub animDelay(ByVal seconds As Double): On Error Resume Next
    
    Dim StartTime As Double
    StartTime = Timer
    
    Do While Timer - StartTime < seconds
    
        'This loop is the "delay", during this loop nothing happens.
        'Process user input for trans3.
#If isToolkit = 0 Then
        Call processEvent
#End If
        
    Loop

End Sub

'========================================================================
' Animate at xx, yy (Animation is presumed to be loaded)
'========================================================================
Public Sub AnimateAt(ByRef theAnim As TKAnimation, ByVal xx As Long, ByVal yy As Long, ByVal pixelsMaxX As Long, ByVal pixelsMaxY As Long, ByRef pic As PictureBox)
    On Error Resume Next
    
    'Initialize
    Dim allPurposeC2 As Long, apHDC As Long
    allPurposeC2 = CreateCanvas(pixelsMaxX, pixelsMaxY)
    apHDC = CanvasOpenHDC(allPurposeC2)
    Call BitBlt(apHDC, _
               0, _
               0, _
               theAnim.animSizeX, _
               theAnim.animSizeY, _
               vbPicHDC(pic), _
               xx, _
               yy, _
               &HCC0020)
    Call CanvasCloseHDC(allPurposeC2, apHDC)
    
    Dim frames As Long
    Dim aXX As Long, aYY As Long, t As Long
    frames = animGetMaxFrame(theAnim)
    aXX = xx
    aYY = yy
    
    'Go through the frames
    For t = 0 To frames '+ 1
        apHDC = CanvasOpenHDC(allPurposeC2)
        Call BitBlt(apHDC, _
               0, _
               0, _
               theAnim.animSizeX, _
               theAnim.animSizeY, _
               pic.hdc, _
               xx, _
               yy, _
               &HCC0020)
        Call CanvasCloseHDC(allPurposeC2, apHDC)
        Call AnimDrawFrame(theAnim, t, aXX, aYY, vbPicHDC(pic))
        Call vbPicRefresh(pic)
        Call animDelay(theAnim.animPause)
        apHDC = CanvasOpenHDC(allPurposeC2)
        Call BitBlt(vbPicHDC(pic), _
               xx, _
               yy, _
               theAnim.animSizeX, _
               theAnim.animSizeY, _
               apHDC, _
               0, _
               0, _
               &HCC0020)
        Call CanvasCloseHDC(allPurposeC2, apHDC)
    Next t
    Call DestroyCanvas(allPurposeC2)

End Sub

Public Sub AnimDrawFrame(ByRef theAnim As TKAnimation, ByVal framenum As Long, ByVal x As Long, ByVal y As Long, ByVal hdc As Long, Optional ByVal playSound As Boolean = True)
'================================================
'draw the frame referenced by framenum
'loads a file into a picture box and resizes it.
'Called by:
'================================================

    On Error Resume Next

    Dim ex As String, f As String, a As Long
    
    ex$ = GetExt(theAnim.animFrame(framenum))
    If fileExists(projectPath$ & bmpPath$ & theAnim.animFrame(framenum)) Or Left$(UCase$(ex), 3) = "TST" Then
        If UCase$(ex$) = "TBM" Then
            #If isToolkit = 0 Then
                If pakFileRunning Then
                    f$ = PakLocate(bmpPath & theAnim.animFrame(framenum))
                    Call DrawSizedImage(f$, x, y, theAnim.animSizeX, theAnim.animSizeY, hdc)
            #Else
                If 1 = 0 Then
            #End If
            Else
                Call DrawSizedImage(projectPath$ & bmpPath$ & theAnim.animFrame(framenum), x, y, theAnim.animSizeX, theAnim.animSizeY, hdc)
            End If
        ElseIf Left$(UCase$(ex), 3) = "TST" Or UCase$(ex) = "GPH" Then
            Dim tbm As TKTileBitmap
            Call TileBitmapSize(tbm, 1, 1)
            tbm.tiles(0, 0) = theAnim.animFrame(framenum)
            Call DrawSizedTileBitmap(tbm, 0, 0, theAnim.animSizeX, theAnim.animSizeY, hdc)
        Else
            Dim backBuffer As Long, cnv As Long, transp As Long, bufHDC As Long
            backBuffer = CreateCanvas(theAnim.animSizeX, theAnim.animSizeY)
            #If isToolkit = 0 Then
                If pakFileRunning Then
                    f$ = PakLocate(bmpPath & theAnim.animFrame(framenum))
                    Call CanvasLoadSizedPicture(allPurposeCanvas, f$)
            #Else
                If 1 = 0 Then
            #End If
            Else
                Call CanvasLoadSizedPicture(backBuffer, projectPath$ & bmpPath$ & theAnim.animFrame(framenum))
            End If

            'Blt it on
            bufHDC = CanvasOpenHDC(backBuffer)
            Call TransparentBlt(hdc, _
                                x, _
                                y, _
                                theAnim.animSizeX - 1, _
                                theAnim.animSizeY - 1, _
                                bufHDC, _
                                0, _
                                0, _
                                theAnim.animSizeX - 1, _
                                theAnim.animSizeY - 1, _
                                theAnim.animTransp(framenum))
            Call CanvasCloseHDC(backBuffer, bufHDC)
            Call DestroyCanvas(backBuffer)
           
        End If
            
    End If

    If (playSound) And (LenB(theAnim.animSound(framenum)) <> 0) Then
        #If isToolkit = 0 Then
            If pakFileRunning Then
                Call sndPlaySound(PakLocate(mediaPath$ & theAnim.animSound(framenum)), SND_ASYNC Or SND_NODEFAULT)
        #Else
            If 1 = 0 Then
        #End If
        Else
            Call sndPlaySound(projectPath$ & mediaPath$ & theAnim.animSound(framenum), SND_ASYNC Or SND_NODEFAULT)
        End If
    End If

End Sub

Public Function animGetMaxFrame(ByRef theAnim As TKAnimation) As Long
    On Error Resume Next
    animGetMaxFrame = -1
    Dim frameIdx As Long
    For frameIdx = 0 To UBound(theAnim.animFrame)
        If LenB(theAnim.animFrame(frameIdx)) <> 0 Then
            animGetMaxFrame = animGetMaxFrame + 1
        End If
    Next frameIdx
End Function

#If (isToolkit = 0) Then

'========================================================================
' Get the current frame of animation at idx
'========================================================================
Public Function AnimationIndexCurrentFrame(ByVal idx As Long) As Long
    On Error Resume Next
    If anmListOccupied(idx) Then
        AnimationIndexCurrentFrame = anmList(idx).theData.currentAnmFrame
    End If
End Function

Public Sub clearAnmCache(): On Error Resume Next
'===============================================
'Added by Delano.
'To ensure sprites are redrawn with ambient
'effects when entering boards.
'Called from TestLink, Send(RPG)
'===============================================

    Dim i As Long
    
    For i = 0 To UBound(anmCache)
    
        Call DestroyCanvas(anmCache(i).cnv)
        anmCache(i).cnv = 0
        anmCache(i).file = vbNullString
        anmCache(i).frame = 0

    Next i

End Sub

'========================================================================
' Shutdown animation system
'========================================================================
Public Sub AnimationShutdown()
    On Error Resume Next
    Dim t As Long
    For t = 0 To UBound(anmCache)
        Call DestroyCanvas(anmCache(t).cnv)
    Next t
End Sub

'========================================================================
' Render an animation frame at canvas cnv, file if the animation filename,
' frame is the frame. Checks through the animation cache for previous
' renderings of this frame, if not found, it is rendered here and copied
' to the animation cache.
'========================================================================
Public Sub renderAnimationFrame(ByVal cnv As Long, ByVal file As String, ByVal frame As Long, ByVal x As Long, ByVal y As Long)
    
    Dim anm As TKAnimation
    
    If (LenB(file) <> 0) Then
        'Only if it exists, we can open it.
        
        Call openAnimation(projectPath & miscPath & file, anm)
        
        Dim maxF As Long
        'Get number of frames.
        maxF = animGetMaxFrame(anm)
        If maxF = 0 Then
            frame = 0
        Else
            '+ 1 here *not* in animGetMaxFrame. Frames run from 0 to x, but here maxF needs
            'to be the total number of frames.
            frame = frame Mod (maxF + 1)
        End If
    Else
        Exit Sub
    End If
    
    'First check sprite cache...
    Dim t As Long
    For t = 0 To UBound(anmCache)
    
        If UCase$(anmCache(t).file) = UCase$(file) And _
            anmCache(t).frame = frame Then
            'Found a match!
            
            'Resize target canvas, if required...
            If GetCanvasWidth(cnv) <> GetCanvasWidth(anmCache(t).cnv) Or _
                GetCanvasHeight(cnv) <> GetCanvasHeight(anmCache(t).cnv) Then
                Call SetCanvasSize(cnv, GetCanvasWidth(anmCache(t).cnv), GetCanvasHeight(anmCache(t).cnv))
            End If
            
            'Blt contents over...
            Call Canvas2CanvasBlt(anmCache(t).cnv, cnv, x, y, SRCCOPY)
            
            'All done!
            Exit Sub
        End If
    Next t
    
    'Not found in cache, we need to render the frame!
    
    If (LenB(file) <> 0) Then
        'The animation for the sprite's stance exists...
        'Open animation file...
        
        Dim frameFile As String
        frameFile = anm.animFrame(frame)
        
        'Now we have the filename of the frame...
        Dim ext As String
        Dim hdc As Long
        Dim cnvTbm As Long, cnvMaskTbm As Long
        Dim tbm As TKTileBitmap
        
        ext = GetExt(frameFile)
        If (LenB(frameFile) <> 0) Or Left$(UCase$(ext), 3) = "TST" Then

            'We can draw the frame!
            
            'Get the ambient level here. Must be done before opening the DC,
            'otherwise trans3 *will* crash on Win9x
            Call getAmbientLevel(addOnR, addOnB, addOnG)
            
            'Resize the canvas if needed.
            Dim W As Long
            Dim h As Long
            W = GetCanvasWidth(cnv)
            h = GetCanvasHeight(cnv)
            
            If W <> anm.animSizeX Or h <> anm.animSizeY Then
                Call SetCanvasSize(cnv, anm.animSizeX, anm.animSizeY)
            End If
            
            Call CanvasFill(cnv, TRANSP_COLOR)

            If UCase$(ext) = "TBM" Then
            
                'You *must* load a tile bitmap before opening an hdc
                'because it'll lock up on windows 98 if you don't.
                
                Call OpenTileBitmap(projectPath$ & bmpPath$ & frameFile, tbm)
                
                
                'DrawSizedTileBitmap moved to here. The following lines must be
                'done in this order! Don't do *anything* whilst the DC is open!
                
                    cnvTbm = CreateCanvas(tbm.sizex * 32, tbm.sizey * 32)
                    cnvMaskTbm = CreateCanvas(tbm.sizex * 32, tbm.sizey * 32)
                    Call DrawTileBitmapCNV(cnvTbm, cnvMaskTbm, 0, 0, tbm)

                    hdc = CanvasOpenHDC(cnv)
                    Call CanvasMaskBltStretch(cnvTbm, cnvMaskTbm, 0, 0, anm.animSizeX, anm.animSizeY, hdc)
                    Call CanvasCloseHDC(cnv, hdc)
                    
                    Call DestroyCanvas(cnvTbm)
                    Call DestroyCanvas(cnvMaskTbm)
                    
                'Done.
                
            ElseIf Left$(UCase$(ext), 3) = "TST" Or UCase$(ext) = "GPH" Then
            
                'Set the tbm to a single tile.
                Call TileBitmapClear(tbm)
                Call TileBitmapSize(tbm, 1, 1)
                tbm.tiles(0, 0) = frameFile
                
                'DrawSizedTileBitmap code moved to here. The following lines must be
                'done in this order! Don't do *anything* whilst the DC is open!
                
                    cnvTbm = CreateCanvas(tbm.sizex * 32, tbm.sizey * 32)
                    cnvMaskTbm = CreateCanvas(tbm.sizex * 32, tbm.sizey * 32)
                    Call DrawTileBitmapCNV(cnvTbm, cnvMaskTbm, 0, 0, tbm)

                    hdc = CanvasOpenHDC(cnv)
                    Call CanvasMaskBltStretch(cnvTbm, cnvMaskTbm, 0, 0, anm.animSizeX, anm.animSizeY, hdc)
                    Call CanvasCloseHDC(cnv, hdc)
                    
                    Call DestroyCanvas(cnvTbm)
                    Call DestroyCanvas(cnvMaskTbm)
                    
                'Done.
                
            Else
            
                'Have to blt it across from an image...
                Dim c2 As Long
                
                c2 = CreateCanvas(anm.animSizeX, anm.animSizeY)
                Call CanvasLoadSizedPicture(c2, projectPath$ & bmpPath$ & frameFile)
                Call Canvas2CanvasBltTransparent(c2, cnv, x, y, anm.animTransp(frame))
                Call DestroyCanvas(c2)
                
            End If

            'Now place this frame in the sprite cache...
            t = nextAnmCacheIdx
            If GetCanvasWidth(cnv) <> GetCanvasWidth(anmCache(t).cnv) Or _
                GetCanvasHeight(cnv) <> GetCanvasHeight(anmCache(t).cnv) Then
                
                If anmCache(t).cnv <> 0 Then
                    Call SetCanvasSize(anmCache(t).cnv, GetCanvasWidth(cnv), GetCanvasHeight(cnv))
                Else
                    'Create the canvas...
                    anmCache(t).cnv = CreateCanvas(GetCanvasWidth(cnv), GetCanvasHeight(cnv))
                End If
                
            End If
            
            Call Canvas2CanvasBlt(cnv, anmCache(nextAnmCacheIdx).cnv, 0, 0, SRCCOPY)
            anmCache(nextAnmCacheIdx).file = UCase$(file)
            anmCache(nextAnmCacheIdx).frame = frame
            nextAnmCacheIdx = nextAnmCacheIdx + 1
            
            If nextAnmCacheIdx > UBound(anmCache) Then
                nextAnmCacheIdx = 0
            End If
            
        End If
    End If
    
End Sub

'========================================================================
' Get the frame image filename of animation at idx
'========================================================================
Public Function AnimationIndexFrameImage(ByVal idx As Long, ByVal frame As Long) As String
    On Error Resume Next
    If anmListOccupied(idx) Then
        AnimationIndexFrameImage = anmList(idx).theData.animFrame(frame)
    End If
End Function

'========================================================================
' This routine assumes it will be called by a timer every 5 ms (that's
' 200 times per second (200 fps)) based upon the fps for the tile (the
' pause length), the current frame will be advanced or it won't be advanced.
' This will return true if it's time to draw this frame again. It will
' return false otherwise, but will advance the timer counter.
'========================================================================
Public Function AnimationShouldDrawFrame(ByRef theAnm As TKAnimation) As Boolean
    On Error Resume Next
    
    Dim toRet As Boolean
    toRet = False
    
    Dim interval As Long
    interval = 80 * theAnm.animPause
    
    If theAnm.timerFrame Mod interval = 0 Then
        toRet = True
    End If
    
    theAnm.timerFrame = theAnm.timerFrame + 1
    
    AnimationShouldDrawFrame = toRet
End Function

Public Sub DrawAnimationIndex(ByVal idx As Long, ByVal x As Long, ByVal y As Long, ByVal hdc As Long)
    'draw an animation from the anmList array
    'call this every 5ms and it'll draw it accroding to the animation speed
    'it will only advance the frame when required.  neato
    On Error Resume Next
    If anmListOccupied(idx) Then
        
        Dim theAnm As TKAnimation
        theAnm = anmList(idx).theData
        
        Dim playSound As Boolean
        
        If AnimationShouldDrawFrame(theAnm) Or anmList(idx).theData.currentAnmFrame = -1 Then
            'draw the next frame and make the sound...
            theAnm.currentAnmFrame = theAnm.currentAnmFrame + 1
            If theAnm.currentAnmFrame > animGetMaxFrame(theAnm) Then
                theAnm.currentAnmFrame = 0
            End If
            playSound = True
        Else
            'draw the current frame again...
            playSound = False
        End If
        Call AnimDrawFrame(theAnm, theAnm.currentAnmFrame, x, y, hdc, playSound)
    End If
End Sub

Public Sub AnimDrawFrameCanvas(ByRef theAnim As TKAnimation, ByVal framenum As Long, ByVal x As Long, ByVal y As Long, ByVal cnv As Long, Optional ByVal playSound As Boolean = True)
    'draw the frame referenced by framenum
    'loads a file into a canvas and resizes it.
    On Error Resume Next
    
    Dim cnvTemp As Long
    cnvTemp = CreateCanvas(32, 32)
    
    Call renderAnimationFrame(cnvTemp, theAnim.animFile, framenum, 0, 0)
    Call Canvas2CanvasBltTransparent(cnvTemp, cnv, x, y, TRANSP_COLOR)
    Call DestroyCanvas(cnvTemp)
    
    If playSound And ((LenB(theAnim.animSound(framenum))) <> 0) Then
        Const wFlags As Integer = SND_ASYNC Or SND_NODEFAULT
        If pakFileRunning Then
            Call sndPlaySound(PakLocate(mediaPath & theAnim.animSound(framenum)), wFlags%)
        Else
            Call sndPlaySound(projectPath$ & mediaPath$ & theAnim.animSound(framenum), wFlags%)
        End If
    End If
End Sub

Public Sub DrawAnimationIndexCanvas(ByVal idx As Long, ByVal x As Long, ByVal y As Long, ByVal cnv As Long, Optional ByVal forceDraw As Boolean = False, Optional ByVal forceTranspFill As Boolean = False)
    'draw an animation from the anmList array to a canvas
    'call this every 5ms and it'll draw it accroding to the animation speed
    'it will only advance the frame when required.  neato
    'if forceTraw is true, it will redraw the frame, even if it was lareayd drawn.  else it will not draw it again
    'if forceTranspFill is true, we'll fill the cnavas with the transparent color before drawing the frame
    On Error Resume Next
    If anmListOccupied(idx) Then
        
        Dim theAnm As TKAnimation
        
        Dim playSound As Boolean
        
        If AnimationShouldDrawFrame(anmList(idx).theData) Or anmList(idx).theData.currentAnmFrame = -1 Then
            'draw the next frame and make the sound...
            anmList(idx).theData.currentAnmFrame = anmList(idx).theData.currentAnmFrame + 1
            If anmList(idx).theData.currentAnmFrame > animGetMaxFrame(anmList(idx).theData) Then
                anmList(idx).theData.currentAnmFrame = 0
            End If
            playSound = True
            If forceTranspFill Then
                Call CanvasFill(cnv, TRANSP_COLOR)
            End If
            Call AnimDrawFrameCanvas(anmList(idx).theData, anmList(idx).theData.currentAnmFrame, x, y, cnv, playSound)
        Else
            'draw the current frame again...
            playSound = False
            If forceDraw Then
                If forceTranspFill Then
                    Call CanvasFill(cnv, TRANSP_COLOR)
                End If
                Call AnimDrawFrameCanvas(anmList(idx).theData, anmList(idx).theData.currentAnmFrame, x, y, cnv, playSound)
            End If
        End If
    End If
End Sub

Public Sub DrawAnimationIndexCanvasFrame(ByVal idx As Long, ByVal frame As Long, ByVal x As Long, ByVal y As Long, ByVal cnv As Long, Optional ByVal forceTranspFill As Boolean = False)
    'draw an animation from the anmList array to a canvas
    'if forceTranspFill is true, we'll fill the cnavas with the transparent color before drawing the frame
    On Error Resume Next
    If anmListOccupied(idx) Then
        
        Dim theAnm As TKAnimation
        
        Dim oldFrame As Long
        anmList(idx).theData.currentAnmFrame = frame
        If anmList(idx).theData.currentAnmFrame > animGetMaxFrame(anmList(idx).theData) Then
            anmList(idx).theData.currentAnmFrame = 0
        End If
        If forceTranspFill Then
            Call CanvasFill(cnv, TRANSP_COLOR)
        End If
        Call AnimDrawFrameCanvas(anmList(idx).theData, anmList(idx).theData.currentAnmFrame, x, y, cnv, False)
        
    End If
End Sub

Public Sub DestroyAnimation(ByVal idx As Long)
    On Error Resume Next
    'free up memory in the ste list vector
    anmListOccupied(idx) = False
End Sub

Public Function CreateAnimation(ByVal file As String) As Long
    On Error GoTo vecterr
    'create an animation and return the index into the anmList array
       
    'test size of array
    Dim test As Long
    Dim oldSize As Long, newSize As Long, t As Long
    test = UBound(anmList)
    
    'find a new slot in the list of boards and return an index we can use
    For t = 0 To UBound(anmList)
        If anmListOccupied(t) = False Then
            anmListOccupied(t) = True
            Call openAnimation(file, anmList(t).theData)
            anmList(t).animFile = RemovePath(file)
            anmList(t).theData.currentAnmFrame = -1
            CreateAnimation = t
            Exit Function
        End If
    Next t
    
    'must resize the vector...
    oldSize = UBound(anmList)
    newSize = UBound(anmList) * 2
    ReDim Preserve anmList(newSize)
    ReDim Preserve anmListOccupied(newSize)
    
    anmListOccupied(oldSize + 1) = True
    Call openAnimation(file, anmList(oldSize + 1).theData)
    anmList(oldSize + 1).animFile = RemovePath(file)
    anmList(oldSize + 1).theData.currentAnmFrame = -1
    CreateAnimation = oldSize + 1
    
    Exit Function

vecterr:
    ReDim anmList(1)
    ReDim anmListOccupied(1)
    Resume Next
    
End Function
#End If

Public Sub saveAnimation(ByVal file As String, ByRef theAnim As TKAnimation)

    On Error Resume Next

    'Get ready to write the file
    Call Kill(file)
    #If isToolkit = 1 Then
        animationList(activeAnimationIndex).animNeedUpdate = False
    #End If

    Dim num As Long, frameIdx As Long

    num = FreeFile()

    With theAnim
        Open file For Binary Access Write As num
            Call BinWriteString(num, FILE_HEADER)
            Call BinWriteInt(num, major)
            Call BinWriteInt(num, 3)
            Call BinWriteLong(num, .animSizeX)
            Call BinWriteLong(num, .animSizeY)
            Call BinWriteLong(num, UBound(.animFrame))
            For frameIdx = 0 To (UBound(.animFrame))
                Call BinWriteString(num, .animFrame(frameIdx))
                Call BinWriteLong(num, .animTransp(frameIdx))
                Call BinWriteString(num, .animSound(frameIdx))
            Next frameIdx
            Call BinWriteDouble(num, .animPause)
        Close num
    End With

End Sub

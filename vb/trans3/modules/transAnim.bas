Attribute VB_Name = "transAnim"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'module for displaying rpg toolkit animation file (*.anm)
Option Explicit

'Added by KSNiloc...
Public GS_ANIMATING As Boolean
Public multitaskAnimations() As TKAnimation
Public multitaskAnimationX() As Long
Public multitaskAnimationY() As Long
Public multitaskAnimationFrame() As Long
Public multitaskCurrentlyAnimating As Long
Public multitaskAnimationPersistent() As Boolean

Sub TransAnimateAt(ByVal xx As Long, ByVal yy As Long)
    'animate at xx, yy (animation is presumed to be loaded)
    On Error GoTo errorhandler
    
    Call AnimateAtCanvas(animationMem, xx, yy, tilesX * 32, tilesY * 32, cnvRPGCodeScreen)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub AnimateAtCanvas(ByRef theAnim As TKAnimation, ByVal xx As Long, ByVal yy As Long, ByVal pixelsMaxX As Long, ByVal pixelsMaxY As Long, ByVal cnv As Long)
    'animate at xx, yy (animation is presumed to be loaded)
    'work on a canvas
    On Error GoTo errorhandler
    
    Dim allPurposeC2 As Long
    allPurposeC2 = CreateCanvas(pixelsMaxX, pixelsMaxY)
    Call Canvas2CanvasBlt(cnv, allPurposeC2, 0, 0)
    
    Dim frames As Long, aXX As Long, aYY As Long, t As Long
    
    frames = animGetMaxFrame(theAnim)
    aXX = xx
    aYY = yy
    For t = 0 To frames '+ 1
        Call Canvas2CanvasBlt(allPurposeC2, cnv, 0, 0)
        
        Call AnimDrawFrameCanvas(theAnim, t, aXX, aYY, cnv)
        
        'Assumption: cnv is actually the rpgcode canvas
        Call renderCanvas(cnv)
        
        Call animDelay(theAnim.animPause)
    Next t
    Call DestroyCanvas(allPurposeC2)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

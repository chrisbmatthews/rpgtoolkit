Attribute VB_Name = "transAnim"
'=========================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=========================================================================

'=========================================================================
' Procedures for displaying toolkit animations (*.anm)
'=========================================================================

Option Explicit

'=========================================================================
' Integral variables
'=========================================================================

Public GS_ANIMATING As Boolean                    'are we animating in the main loop?
Public multitaskAnimations() As TKAnimation       'loaded animations
Public multitaskAnimationX() As Long              'x position of these animations
Public multitaskAnimationY() As Long              'y position of these animations
Public multitaskAnimationFrame() As Long          'current frame of these animations
Public multitaskCurrentlyAnimating As Long        'current index in array
Public multitaskAnimationPersistent() As Boolean  'are these animations persistent?

'=========================================================================
' Plays the loaded animation at xx, yy
'=========================================================================
Public Sub TransAnimateAt(ByVal xx As Long, ByVal yy As Long)
    On Error Resume Next
    Call AnimateAtCanvas(animationMem, xx, yy, tilesX * 32, tilesY * 32, cnvRPGCodeScreen)
End Sub

'=========================================================================
' Plays an animation on a canvas
'=========================================================================
Public Sub AnimateAtCanvas(ByRef theAnim As TKAnimation, ByVal xx As Long, ByVal yy As Long, ByVal pixelsMaxX As Long, ByVal pixelsMaxY As Long, ByVal cnv As Long)

    On Error Resume Next
    
    Dim allPurposeC2 As Long
    allPurposeC2 = CreateCanvas(pixelsMaxX, pixelsMaxY)
    Call Canvas2CanvasBlt(cnv, allPurposeC2, 0, 0)
    
    Dim frames As Long, aXX As Long, aYY As Long, t As Long
    
    frames = animGetMaxFrame(theAnim)
    aXX = xx
    aYY = yy
    For t = 0 To frames
        Call Canvas2CanvasBlt(allPurposeC2, cnv, 0, 0)
        
        Call AnimDrawFrameCanvas(theAnim, t, aXX, aYY, cnv)
        
        'Assumption: cnv is actually the rpgcode canvas
        Call renderCanvas(cnv)
        
        Call animDelay(theAnim.animPause)
    Next t
    Call DestroyCanvas(allPurposeC2)

End Sub

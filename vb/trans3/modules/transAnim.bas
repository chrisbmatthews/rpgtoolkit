Attribute VB_Name = "transAnim"
'=========================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=========================================================================

'=========================================================================
' Procedures for displaying toolkit animations during RPGCode programs
' Status: A+
'=========================================================================

Option Explicit

'=========================================================================
' Plays the loaded animation at x, y
'=========================================================================
Public Sub TransAnimateAt(ByVal x As Long, ByVal y As Long)
    On Error Resume Next
    Call CanvasGetScreen(cnvRPGCodeScreen)
    Call AnimateAtCanvas( _
                            animationMem, _
                            x, _
                            y, _
                            tilesX * 32, _
                            tilesY * 32, _
                            cnvRPGCodeScreen _
                                               )
End Sub

'=========================================================================
' Plays an animation on a canvas
'=========================================================================
Private Sub AnimateAtCanvas( _
                               ByRef theAnim As TKAnimation, _
                               ByVal x As Long, _
                               ByVal y As Long, _
                               ByVal pixelsMaxX As Long, _
                               ByVal pixelsMaxY As Long, _
                               ByVal cnv As Long _
                                                   )

    On Error Resume Next

    'Save the screen
    Dim oldScreen As Long
    oldScreen = CreateCanvas(globalCanvasWidth, globalCanvasHeight)
    Call CanvasGetScreen(oldScreen)

    'Create a temp canvas a blt the canvas passed in onto it
    Dim cnvTemp As Long
    cnvTemp = CreateCanvas(pixelsMaxX, pixelsMaxY)
    Call Canvas2CanvasBlt(cnv, cnvTemp, 0, 0)

    Dim frames As Long          'frames in animation
    Dim currentFrame As Long    'current frame in animation

    'Get max frames
    frames = animGetMaxFrame(theAnim)

    'For each frame
    For currentFrame = 0 To frames

        'Draw the frame
        Call Canvas2CanvasBlt(cnvTemp, cnv, 0, 0)
        Call AnimDrawFrameCanvas(theAnim, currentFrame, x, y, cnv)

        'Render the screen
        If (cnv = cnvRPGCodeScreen) Then
            Call DXDrawCanvas(cnvRPGCodeScreen, 0, 0)
            Call renderRPGCodeScreen
        Else
            Call renderCanvas(cnv)
        End If

        'Delay
        Call animDelay(theAnim.animPause)

    Next currentFrame

    'Restore screen
    Call Canvas2CanvasBlt(oldScreen, cnv, 0, 0)
    If (cnv = cnvRPGCodeScreen) Then
        Call renderRPGCodeScreen
    Else
        Call renderCanvas(cnv)
    End If

    'Destroy the temp canvas
    Call DestroyCanvas(cnvTemp)
    Call DestroyCanvas(oldScreen)

End Sub

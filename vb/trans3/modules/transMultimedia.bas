Attribute VB_Name = "transMultimedia"
'=========================================================================
' All contents copyright 2003, 2004, 2005 Christopher Matthews or Contributors
' All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
' Read LICENSE.txt for licensing info
'=========================================================================

'=========================================================================
' TK Multimedia Engine
'=========================================================================

Option Explicit

'=========================================================================
' Declarations
'=========================================================================
Private Declare Sub TKAudiereInit Lib "actkrt3.dll" ()
Private Declare Sub TKAudiereKill Lib "actkrt3.dll" ()
Private Declare Function TKAudierePlay Lib "actkrt3.dll" (ByVal handle As Long, ByVal filename As String, ByVal streamYN As Long, ByVal autoRepeatYN As Long) As Long
Private Declare Function TKAudiereIsPlaying Lib "actkrt3.dll" (ByVal handle As Long) As Long
Private Declare Sub TKAudiereStop Lib "actkrt3.dll" (ByVal handle As Long)
Private Declare Sub TKAudiereRestart Lib "actkrt3.dll" (ByVal handle As Long)
Private Declare Sub TKAudiereDestroyHandle Lib "actkrt3.dll" (ByVal handle As Long)
Private Declare Function TKAudiereCreateHandle Lib "actkrt3.dll" () As Long
Private Declare Function TKAudiereGetPosition Lib "actkrt3.dll" (ByVal handle As Long) As Long
Private Declare Sub TKAudiereSetPosition Lib "actkrt3.dll" (ByVal handle As Long, ByVal pos As Long)

'=========================================================================
' Public variables
'=========================================================================
Public musicPlaying As String            ' Current song playing
Public fgDevice As Long                  ' Foreground music device

'=========================================================================
' Member variables
'=========================================================================
Private bkgDevice As Long                ' Background music device (audiere)
Private m_dm As CDirectMusic             ' DirectMusic object

'=========================================================================
' Member constants
'=========================================================================
Private Const SFX_DEVICE = "sfxDevive"   ' Sound effect device (MCI)
Private Const MID_DEVICE = "midDevice"   ' Music device (MCI)
Private Const WS_CHILD = &H40000000      ' DirectShow window settings
Private Const WS_CLIPSIBLINGS = &H4000000
Private Const WS_CLIPCHILDREN = &H2000000


'=========================================================================
' Expose DirectMusic
'=========================================================================
Public Property Get getDirectMusic() As CDirectMusic
    ' Return a reference to our member
    Set getDirectMusic = m_dm
End Property

'=========================================================================
' Checks to make sure the correct music is playing
'=========================================================================
Public Sub checkMusic(Optional ByVal forceNow As Boolean)

    On Error Resume Next

    If Not (forceNow) Then
        If (waitingForInput()) Then Exit Sub
    End If

    Dim boardMusic As String
    boardMusic = UCase$(boardList(activeBoardIndex).theData.boardMusic)

    If (LenB(boardMusic) = 0) Then

        If (LenB(musicPlaying)) Then

            Call stopMedia
            musicPlaying = vbNullString

        End If

    Else

        boardMusic = UCase$(projectPath & mediaPath) & boardMusic

        If (boardMusic = musicPlaying) Then

            If Not (isMediaPlaying(boardMusic)) Then
                Call playMedia(boardMusic)
            End If

        Else

            Call playMedia(boardMusic)
            musicPlaying = boardMusic

        End If

    End If

End Sub

'=========================================================================
' Sets up audiere
'=========================================================================
Public Sub initMedia()

    On Error Resume Next

    Call TKAudiereInit
    Set m_dm = New CDirectMusic
    bkgDevice = TKAudiereCreateHandle()
    fgDevice = TKAudiereCreateHandle()

End Sub

'=========================================================================
' Checks if media is playing
'=========================================================================
Public Function isMediaPlaying(ByRef file As String) As Boolean

    On Error Resume Next

    ' Get extension
    Dim ext As String
    ext = UCase$(GetExt(file))

    If (isPlayedByDX(ext)) Then
        isMediaPlaying = m_dm.isPlaying()

    ElseIf (isPlayedByMCI(ext)) Then
        isMediaPlaying = IsPlayingMCI(MID_DEVICE)

    ElseIf (isPlayedByAudiere(ext)) Then
        isMediaPlaying = TKAudiereIsPlaying(bkgDevice)

    End If

End Function

'=========================================================================
' Kill Audiere
'=========================================================================
Public Sub killMedia()

    On Error Resume Next

    Call TKAudiereDestroyHandle(bkgDevice)
    Call TKAudiereDestroyHandle(fgDevice)
    Call TKAudiereKill
    Set m_dm = Nothing

End Sub

'=========================================================================
' Play a media file
'=========================================================================
Public Sub playMedia(ByRef file As String)

    On Error Resume Next

    ' Stop everything
    Call stopMedia

    ' Make sure it exists
    If Not (fileExists(file)) Then Exit Sub

    ' Get extension
    Dim ext As String
    ext = UCase$(GetExt(file))

    If (isPlayedByDX(ext)) Then
        Call m_dm.playMidi(file)
        Do Until (m_dm.isPlaying())
            ' Do not proceed until MIDI has fully loaded
        Loop

    ElseIf (isPlayedByMCI(ext)) Then
        Call PlayMCI(file, MID_DEVICE)

    ElseIf (isPlayedByAudiere(ext)) Then
        ' Set to autorepeat
        Call TKAudierePlay(bkgDevice, file, 1, 1)

    End If

End Sub

'=========================================================================
' Check if MCI supports a format
'=========================================================================
Private Function isPlayedByMCI(ByRef ext As String) As Boolean
    Select Case ext
        Case "MID", "MIDI", "RMI", "MPL"
            ' MCI plays this
            isPlayedByMCI = True
    End Select
End Function

'=========================================================================
' Check if DirectMusic supports a format
'=========================================================================
Private Function isPlayedByDX(ByRef ext As String) As Boolean
    Select Case ext
        Case "MID", "MIDI", "RMI", "MPL"
            ' DirectMusic plays this
            isPlayedByDX = True
    End Select
End Function

'=========================================================================
' Check if audiere supports a format
'=========================================================================
Private Function isPlayedByAudiere(ByRef ext As String) As Boolean
    On Error Resume Next
    Select Case ext
        Case "MP3", "MOD", "IT", "XM", "S3M", "669", "AMF", "AMS", "DBM", "DSM", "FAR", "MED", "MDL", "MTM", "NST", "OKT", "PTM", "STM", "ULT", "UMX", "WOW", "WAV", "MLP", "OOG", "OGG"
            ' Audiere plays this
            isPlayedByAudiere = True
    End Select
End Function

'=========================================================================
' Play a sound effect
'=========================================================================
Public Sub playSoundFX(ByVal file As String)

    On Error Resume Next

    If Not (fileExists(file)) Then
        'Can't play it if it doesn't exist!
        Exit Sub
    End If

    'Stop sounds
    Call stopSFX

    'Get extension
    Dim ext As String
    ext = UCase$(GetExt(file))

    If (isPlayedByMCI(ext)) Then
        Call PlayMCI(file, SFX_DEVICE)

    ElseIf (isPlayedByAudiere(ext)) Then
        Call TKAudierePlay(bkgDevice, file, 1, 0)

    End If

End Sub

'=========================================================================
' Stop all multimedia
'=========================================================================
Public Sub stopMedia()

    On Error Resume Next

    Call StopMCI(MID_DEVICE)
    Call StopMCI(SFX_DEVICE)
    Call TKAudiereStop(fgDevice)
    Call TKAudiereStop(bkgDevice)
    Set m_dm = New CDirectMusic

End Sub

'=========================================================================
' Play a video file (DirectShow supports .avi, .mpg, .mov)
' Called by PlayAviRPG, PlayAviSmallRPG only.
'=========================================================================
Public Sub playVideo(ByVal file As String, Optional ByVal windowed As Boolean): On Error Resume Next

    Dim quartz As FilgraphManager
    Dim video As IVideoWindow
    Dim pos As IMediaPosition

    'Set the interfaces to quartz.
    Set quartz = New FilgraphManager
    Set video = quartz
    Set pos = quartz

    'Render the movie (do not run it yet).
    Call quartz.RenderFile(file)

    'Setup the window information.
    Call video.HideCursor(True)
    video.Owner = host.hwnd
    'Window style using standard styles.
    video.WindowStyle = WS_CHILD Or WS_CLIPSIBLINGS Or WS_CLIPCHILDREN
    
    'Set the size and position of the image, relative to the host.
    If windowed And _
       host.width / Screen.TwipsPerPixelX >= video.width And _
       host.height / Screen.TwipsPerPixelY >= video.height Then
        'Centre video (PlayAviSmall).
        video.Left = (host.width / Screen.TwipsPerPixelX - video.width) \ 2
        video.Top = (host.height / Screen.TwipsPerPixelY - video.height) \ 2
    Else
        'Stretch to the dimensions (not fullscreen it!) if requested or if video is bigger than screen.
        'PlayAvi or PlayAviSmall with a large video res.
        Call video.SetWindowPosition(0, 0, host.width \ Screen.TwipsPerPixelX, host.height \ Screen.TwipsPerPixelY)
    End If

    'Finally run the video!
    Call quartz.run

    'Hold trans3 until the video ends.
    Do Until (pos.CurrentPosition >= pos.Duration)
        Call processEvent
    Loop
    
    'Clean up.
    Call quartz.Stop
    video.Visible = False
    video.Owner = Null
    Set pos = Nothing
    Set video = Nothing
    Set quartz = Nothing

End Sub

'=========================================================================
' Wait for all sound effects to finish
'=========================================================================
Public Sub waitOnSFX()
    Do Until (Not (IsPlayingMCI(SFX_DEVICE))) And (TKAudiereIsPlaying(fgDevice) = 0)
        Call processEvent
    Loop
End Sub

'=========================================================================
' Stop all sound effects
'=========================================================================
Public Sub stopSFX()
    Call StopMCI(SFX_DEVICE)
    Call TKAudiereStop(fgDevice)
End Sub

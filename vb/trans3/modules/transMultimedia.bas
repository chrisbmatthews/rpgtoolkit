Attribute VB_Name = "transMultimedia"
'=========================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=========================================================================

'=========================================================================
' TK Multimedia Engine
'=========================================================================

'=========================================================================
'EDITED [KSNiloc] [Augest 31, 2004]
'----------------------------------
' + Remove dependencies on forms
' + Added support for video
' + Privatized some things
'=========================================================================

Option Explicit

'=========================================================================
' Public variables
'=========================================================================
Public musicPlaying As String            'current song playing
Public fgDevice As Long                  'foreground music device

'=========================================================================
' Member variables
'=========================================================================
Private bkgDevice As Long                'background music device (audiere)

'=========================================================================
' Member constants
'=========================================================================
Private Const SFX_DEVICE = "sfxDevive"   'sound effect device (MCI)
Private Const MID_DEVICE = "midDevice"   'music device (MCI)

'=========================================================================
' Checks to make sure the correct music is playing
'=========================================================================
Public Sub checkMusic(Optional ByVal forceNow As Boolean)
    
    On Error Resume Next

    If Not (forceNow) Then
        If bWaitingForInput Then Exit Sub
    End If

    Dim boardMusic As String
    boardMusic = projectPath & mediaPath & boardList(activeBoardIndex).theData.boardMusic

    If boardMusic = "" Then

        Call stopMedia
        musicPlaying = ""

    ElseIf UCase(boardMusic) = UCase(musicPlaying) Then

        If Not isMediaPlaying(boardMusic) Then
            Call playMedia(boardMusic)
        End If

    Else

        Call playMedia(boardMusic)
        musicPlaying = boardMusic

    End If

End Sub

'=========================================================================
' Sets up audiere
'=========================================================================
Public Sub initMedia()

    On Error Resume Next
    
    Call TKAudiereInit
    bkgDevice = TKAudiereCreateHandle()
    fgDevice = TKAudiereCreateHandle()

End Sub

'=========================================================================
' Checks if media is playing
'=========================================================================
Public Function isMediaPlaying(ByVal file As String) As Boolean

    On Error Resume Next

    Dim ex As String
    Dim pos As Long
    Dim le As Long

    ex = UCase(GetExt(file))
    
    Select Case ex

        Case "MID" Or "MIDI" Or "WAV" Or "MLP"
            'Ask MCI
            isMediaPlaying = IsPlayingMCI(MID_DEVICE)

        Case "MP3" Or "MOD" Or "IT" Or "XM" Or "S3M" Or "669" Or "AMF" Or "AMS" Or "DBM" Or "DSM" Or "FAR" Or "MED" Or "MDL" Or "MTM" Or "NST" Or "OKT" Or "PTM" Or "STM" Or "ULT" Or "UMX" Or "WOW" Or "MID" Or "MIDI" Or "WAV" Or "MLP"
            'Ask Audiere
            If (TKAudiereIsPlaying(bkgDevice)) Then
                isMediaPlaying = True
            End If

    End Select

End Function

'=========================================================================
' Kill Audiere
'=========================================================================
Public Sub killMedia()

    On Error Resume Next
    
    Call TKAudiereDestroyHandle(bkgDevice)
    Call TKAudiereDestroyHandle(fgDevice)
    Call TKAudiereKill
    
End Sub

'=========================================================================
' Play a media file
'=========================================================================
Public Sub playMedia(ByVal file As String)

    On Error Resume Next

    'stop everything
    Call stopMedia

    file = PakLocate(file)

    Dim ex As String
    ex = GetExt(UCase(file))

    Select Case ex

        Case "MID" Or "MIDI" Or "MPL"
            'Play through MCI
            Call PlayMCI(file, MID_DEVICE)

        Case "MP3" Or "MOD" Or "IT" Or "XM" Or "S3M" Or "669" Or "AMF" Or "AMS" Or "DBM" Or "DSM" Or "FAR" Or "MED" Or "MDL" Or "MTM" Or "NST" Or "OKT" Or "PTM" Or "STM" Or "ULT" Or "UMX" Or "WOW" Or "MID" Or "MIDI" Or "WAV" Or "MLP"
            'play through audiere
            Call TKAudierePlay(bkgDevice, file, 1, 0)
            
    End Select

End Sub

'=========================================================================
' Play a sound effect
'=========================================================================
Public Sub playSoundFX(ByVal file As String)

    On Error Resume Next

    file = PakLocate(file)
    If Not fileExists(file) Then Exit Sub

    Dim extension As String
    extension = UCase(extension)

    Call StopMCI(SFX_DEVICE)

    Select Case extension

        Case "MID" Or "MIDI" Or "MPL"
            'play through MCI
            Call PlayMCI(file, SFX_DEVICE)

        Case "MP3" Or "MOD" Or "IT" Or "XM" Or "S3M" Or "669" Or "AMF" Or "AMS" Or "DBM" Or "DSM" Or "FAR" Or "MED" Or "MDL" Or "MTM" Or "NST" Or "OKT" Or "PTM" Or "STM" Or "ULT" Or "UMX" Or "WOW" Or "MID" Or "MIDI" Or "WAV" Or "MLP"
            'play through audiere
            Call TKAudierePlay(fgDevice, file, 0, 0)

    End Select

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

End Sub

'=========================================================================
' Play a video file
'=========================================================================
Public Sub playVideo(ByVal file As String, Optional ByVal windowed As Boolean)

    On Error Resume Next

    Dim quartz As New FilgraphManager
    Dim video As IVideoWindow
    Dim pos As IMediaPosition

    'Set the interfaces to quartz
    Set video = quartz
    Set pos = quartz

    'Render the movie
    Call quartz.RenderFile(file)

    With video
        .FullScreenMode = Not windowed
        .Owner = host.hwnd
    End With

    Call quartz.run
    Dim windowStateNow As Long
    windowStateNow = video.WindowState

    Do Until (pos.CurrentPosition = pos.StopTime) Or (video.WindowState <> windowStateNow)
        Call processEvent
    Loop

    video.Visible = False
    Call Unload(video)
    Set video = Nothing
    Set pos = Nothing
    Set quartz = Nothing

End Sub

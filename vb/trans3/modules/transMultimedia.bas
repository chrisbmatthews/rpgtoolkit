Attribute VB_Name = "transMultimedia"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'============================================================
'TK Multimedia Engine
'============================================================

Option Explicit

Public musicPlaying As String    'current song playing
Public fgDevice As Long          'foreground music device
Private bkgDevice As Long        'background music device

Public Sub checkMusic(Optional ByVal forceNow As Boolean)

    '============================================================
    'Checks to make sure the correct music is playing
    '============================================================

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

Public Sub initMedia()

    '============================================================
    'Sets up audiere
    '============================================================

    On Error Resume Next
    
    Call TKAudiereInit
    bkgDevice = TKAudiereCreateHandle()
    fgDevice = TKAudiereCreateHandle()

End Sub

Public Function isMediaPlaying(ByVal file As String) As Boolean

    '============================================================
    'Checks if media is playing
    '============================================================

    On Error Resume Next

    Dim ex As String
    Dim pos As Long
    Dim le As Long

    ex = UCase(GetExt(file))
    
    Select Case ex

        Case "MID" Or "MIDI" Or "WAV" Or "MLP"
            pos = mediaContainer.media.Position
            le = mediaContainer.media.Length
            If pos < le Then
                isMediaPlaying = True
            End If

        Case "MP3" Or "MOD" Or "IT" Or "XM" Or "S3M" Or "669" Or "AMF" Or "AMS" Or "DBM" Or "DSM" Or "FAR" Or "MED" Or "MDL" Or "MTM" Or "NST" Or "OKT" Or "PTM" Or "STM" Or "ULT" Or "UMX" Or "WOW"
            If (TKAudiereIsPlaying(bkgDevice)) Then
                isMediaPlaying = True
            End If

    End Select

End Function

Public Sub killMedia()

    '============================================================
    'Kill Audiere
    '============================================================

    On Error Resume Next
    
    Call TKAudiereDestroyHandle(bkgDevice)
    Call TKAudiereDestroyHandle(fgDevice)
    Call TKAudiereKill
    
End Sub

Public Sub playMedia(ByVal file As String)

    '============================================================
    'Play a media file
    '============================================================

    On Error Resume Next

    'stop everything...
    Call stopMedia

    file = PakLocate(file)

    Dim ex As String
    ex = GetExt(UCase(file))

    Select Case ex

        Case "MID" Or "MIDI" Or "MPL"
            'use mm control
            With mediaContainer.media
                .Notify = False
                .Wait = True
                .Shareable = False
                .filename = file
                .Command = "Open"
                .Command = "Play"
            End With

        Case "MP3" Or "MOD" Or "IT" Or "XM" Or "S3M" Or "669" Or "AMF" Or "AMS" Or "DBM" Or "DSM" Or "FAR" Or "MED" Or "MDL" Or "MTM" Or "NST" Or "OKT" Or "PTM" Or "STM" Or "ULT" Or "UMX" Or "WOW"
            'play through audiere
            Call TKAudierePlay(bkgDevice, file, 1, 0)
            
    End Select

End Sub

Public Sub playSoundFX(ByVal file As String)

    '============================================================
    'Play a sound effect
    '============================================================

    On Error Resume Next

    file = PakLocate(file)
    If Not fileExists(file) Then Exit Sub

    Dim extension As String
    extension = UCase(extension)

    With mediaContainer.soundfx

        .Notify = False
        .Wait = True
        .Shareable = False
        .Command = "stop"
        .Command = "close"

        Select Case extension

            Case "MID" Or "MIDI" Or "MPL"
                'use mm control
                .filename = file
                .Command = "Open"
                .Command = "Play"

            Case "MP3" Or "MOD" Or "IT" Or "XM" Or "S3M" Or "669" Or "AMF" Or "AMS" Or "DBM" Or "DSM" Or "FAR" Or "MED" Or "MDL" Or "MTM" Or "NST" Or "OKT" Or "PTM" Or "STM" Or "ULT" Or "UMX" Or "WOW"
                'play through audiere
                Call TKAudierePlay(fgDevice, file, 0, 0)

        End Select

    End With

End Sub

Public Sub stopMedia()

    '============================================================
    'Stop all multimedia
    '============================================================

    On Error Resume Next

    With mediaContainer.media
        .Command = "Stop"
        .Command = "Close"
    End With

    Call TKAudiereStop(fgDevice)
    Call TKAudiereStop(bkgDevice)

End Sub

Public Sub playVideo(ByVal file As String, Optional ByVal windowed As Boolean)

    '============================================================
    'Play a video file
    '============================================================

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

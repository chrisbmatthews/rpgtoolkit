Attribute VB_Name = "transMultimedia"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'multimedia control...
Option Explicit

Public musicPlaying As String    'current song playing

Private bkgDevice As Long   'background music device
Public fgDevice As Long   'foreground music device

Sub checkMusic(Optional ByVal forceNow As Boolean = False)
    'mainForm.Label1.Caption = boardmusic$ + " " + musicplaying$ + " " + Str$(bwaitingforfinput)
    On Error GoTo errorhandler
    Dim isplay As Boolean
    
    If Not (forceNow) Then
        If bWaitingForInput Then Exit Sub   'if we are waiting for a keypress or joystick, get out!
    End If
    
    If boardList(activeBoardIndex).theData.boardMusic$ = "" Then
        'stop playing the music!
        Call StopMedia
        musicPlaying$ = ""
        Exit Sub
    End If
    If UCase$(boardList(activeBoardIndex).theData.boardMusic$) = UCase$(musicPlaying$) Then
        'the media file is supposedly already playing...
        'check if it is...
        isplay = IsMediaPlaying(projectPath$ + mediaPath$ + boardList(activeBoardIndex).theData.boardMusic$)
        If isplay = False Then
            'hmmm.  looks like it stopped playing....
            'restart the music!
            Call PlayMedia(projectPath$ + mediaPath$ + boardList(activeBoardIndex).theData.boardMusic$)
            Exit Sub
        End If
    Else
        'If the music that should be playing isn't playing
        'we will stop the current song and start the other
        Call StopMedia
        Call PlayMedia(projectPath$ + mediaPath$ + boardList(activeBoardIndex).theData.boardMusic$)
        musicPlaying$ = boardList(activeBoardIndex).theData.boardMusic$
        Exit Sub
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Sub InitMedia()
    'create bkg music device
    On Error Resume Next
    
    Call TKAudiereInit
    bkgDevice = TKAudiereCreateHandle()
    fgDevice = TKAudiereCreateHandle()
End Sub

Function IsMediaPlaying(file As String) As Boolean
    'determine if the media file is still playing...
    On Error GoTo errorhandler
    Dim ex As String
    Dim pos As Long
    Dim le As Long
    
    ex$ = GetExt(file)
    ex$ = UCase$(ex$)
    
    Select Case ex$
        Case "MID", "MIDI", "WAV", "MLP":
            'check mm control...
            pos = mediaContainer.media.Position
            le = mediaContainer.media.Length
            If pos < le Then
                IsMediaPlaying = True
            Else
                IsMediaPlaying = False
            End If
            Exit Function
            
            'IsMediaPlaying = IsPlayingMCI("bgmusic")
            Exit Function
            
        Case "MP3":
            If (TKAudiereIsPlaying(bkgDevice)) Then
                IsMediaPlaying = True
            Else
                IsMediaPlaying = False
            End If
            
            'If registered = 1 Then
            '    'use mm control...
            '    'pos = mediacontainer.media.position
            '    'le = mediacontainer.media.Length
            '    'If pos < le Then
            '    '    IsMediaPlaying = True
            '    'Else
            '    '    IsMediaPlaying = False
            '    'End If
            '
            '    IsMediaPlaying = mp3.mp3.GetSliderPosition() <= 95''

                'IsMediaPlaying = mp3.mp3.IsPlaying()
            'Else
            '    'use OLE...
            '    'your guess is as good as mine...
            '    IsMediaPlaying = False
            'End If
            Exit Function
        
        Case "MOD", "IT", "XM", "S3M", "669", "AMF", "AMS", "DBM", "DSM", "FAR", "MED", "MDL", "MTM", "NST", "OKT", "PTM", "STM", "ULT", "UMX", "WOW":
            'use modplug...
            'IsMediaPlaying = ModPlugPlaying()
            If (TKAudiereIsPlaying(bkgDevice)) Then
                IsMediaPlaying = True
            Else
                IsMediaPlaying = False
            End If
            Exit Function
            
        Case Else:
            'use OLE...
            'your guess is as good as mine...
            IsMediaPlaying = False
            Exit Function
    End Select

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Function



Sub KillMedia()
    'shut down bkg device and media system
    On Error Resume Next
    
    Call TKAudiereDestroyHandle(bkgDevice)
    Call TKAudiereDestroyHandle(fgDevice)
    Call TKAudiereKill
End Sub

Sub PlayMedia(file As String)
    'play a multimedia file...
    On Error GoTo errorhandler
    
    Dim bm As String
    
    'stop everything...
    Call StopMedia
    
    Dim f As String
    f$ = PakLocate(file)
    
    Dim ex As String
    ex$ = GetExt(f$)
    ex$ = UCase$(ex$)
    
    Select Case ex$
        Case "MID", "MIDI":
            'use mm control...
            mediaContainer.media.Notify = False
            mediaContainer.media.Wait = True
            mediaContainer.media.Shareable = False
            mediaContainer.media.filename = f$
            mediaContainer.media.Command = "Open"
            mediaContainer.media.Command = "Play"
            Exit Sub
            
            'Call PlayMCI(file, "bgmusic")
            'Exit Sub
            
        Case "MLP":
            'midi file--looped!
            bm$ = Mid$(f$, 1, Len(file) - 3) + "mid"
            mediaContainer.media.Notify = False
            mediaContainer.media.Wait = True
            mediaContainer.media.Shareable = False
            mediaContainer.media.filename = bm$
            mediaContainer.media.Command = "Open"
            mediaContainer.media.Command = "Play"
            Exit Sub
            
            'bm$ = Mid$(F$, 1, Len(file) - 3) + "mid"
            'Call PlayMCI(bm$, "bgmusic")
            'Exit Sub
            
        'Case "MP3":
        '    'use mm control...
        '    'mediacontainer.media.Notify = False
        '    'mediacontainer.media.Wait = True
        '    'mediacontainer.media.Shareable = False
        '    'mediacontainer.media.filename = file
        '    'mediacontainer.media.Command = "Open"
        '    'mediacontainer.media.Command = "Play"
        '
        '    Call mp3.mp3.OpenMP3(f$)
        '    Call mp3.mp3.PlayMP3
        '
        '    Exit Sub
       
        Case Else:
            'use modplug...
            'Call ModPlugPlay(f$)
            Call TKAudierePlay(bkgDevice, f$, 1, 0)
            Exit Sub
            
    End Select
    

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Sub PlaySoundFX(file As String)
    '=========================================
    'EDITED: [Delano - 20/05/04]
    'Checked to see if the file exists - could cause subsequent commands to fail (eg. cursorDelay)
    'Renamed variables: ex, bm >> extension, trackName
    '=========================================
    'Called by mp3PauseRPG, wavRPG, ShowPromptDialog, ShowFileDialog, SelectionBox, CursorMapRun, CBPlaySound
    'Receives the filename with the extension.
    
    'Called *regardless* of whether the file exists or not!!
    'Needs to check if file exists - could cause subsequent commands to fail.
    
    'Play a multimedia file as background soundFX...
    
    On Error GoTo errorhandler
    
    Dim extension As String, trackName As String
       
    file = PakLocate(file)          'Does nothing if pakfile not running. Returns unaltered string.
    
    extension$ = GetExt(file)       'Searches for an extension; i.e. a "." in the string.
    If extension$ = "" Then Exit Sub
                                    'GetExt returns nothing if an extension (ie. a file) is not found
    extension$ = UCase$(extension$)
    
    'stop soundfx control...
    mediaContainer.soundfx.Notify = False
    mediaContainer.soundfx.Wait = True
    mediaContainer.soundfx.Shareable = False
    mediaContainer.soundfx.Command = "stop"
    mediaContainer.soundfx.Command = "close"
    
    'Call StopMCI("soundfx")
    
    
    Select Case extension$
        Case "MID", "MIDI":
            'use mm control...
            mediaContainer.soundfx.filename = file
            mediaContainer.soundfx.Command = "Open"
            mediaContainer.soundfx.Command = "Play"
            Exit Sub
                        
            'Call PlayMCI(file, "soundfx")
            'Exit Sub
                        
        Case "MLP":
            'midi file--looped!
            trackName$ = Mid$(file, 1, Len(file) - 3) + "mid"
            mediaContainer.soundfx.filename = trackName$
            mediaContainer.soundfx.Command = "Open"
            mediaContainer.soundfx.Command = "Play"
            Exit Sub
            
            'bm$ = Mid$(file, 1, Len(file) - 3) + "mid"
            'Call PlayMCI(bm$, "soundfx")
            'Exit Sub
            
        Case Else:
            'play thru audiere...
            Dim device As Long
            Call TKAudierePlay(fgDevice, file, 0, 0)
    End Select

    Exit Sub
    
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
    
End Sub

Sub StopMedia()
    'stop all multimedia
    On Error GoTo errorhandler
    
    'stop everything else
    mediaContainer.media.Command = "Stop"
    mediaContainer.media.Command = "Close"
    
    'Call StopMCI("soundfx")
    'Call StopMCI("bgmusic")
    
    Call TKAudiereStop(fgDevice)
    
    Call TKAudiereStop(bkgDevice)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Public Sub playVideo(ByVal file As String, Optional ByVal windowed As Boolean)

    '============================================================
    'Plays a video file [Colin]
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
        .FullScreenMode = True
        .Owner = host.hwnd
    End With
    
    Call quartz.run
    
    Do Until pos.CurrentPosition = pos.StopTime
        DoEvents
    Loop
    
    video.Visible = False
    Set video = Nothing
    Set pos = Nothing
    Set quartz = Nothing
    
End Sub

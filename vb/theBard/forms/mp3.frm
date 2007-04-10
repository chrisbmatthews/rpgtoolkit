VERSION 5.00
Begin VB.Form mp3player 
   Appearance      =   0  'Flat
   BackColor       =   &H00000000&
   BorderStyle     =   0  'None
   Caption         =   "RPG MP3"
   ClientHeight    =   2865
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   4335
   Icon            =   "mp3.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Picture         =   "mp3.frx":038A
   ScaleHeight     =   2865
   ScaleWidth      =   4335
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Tag             =   "1718"
   Begin VB.Timer Timer1 
      Interval        =   1000
      Left            =   3840
      Top             =   480
   End
   Begin VB.ListBox playlist 
      BackColor       =   &H00000000&
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   900
      Left            =   120
      TabIndex        =   8
      Top             =   1800
      Width           =   4095
   End
   Begin VB.CheckBox Check1 
      Height          =   255
      Left            =   3960
      Picture         =   "mp3.frx":2E03
      Style           =   1  'Graphical
      TabIndex        =   13
      Tag             =   "1719"
      ToolTipText     =   "Randomize playlist"
      Top             =   1560
      Width           =   255
   End
   Begin VB.CommandButton Command8 
      Height          =   255
      Left            =   3720
      Picture         =   "mp3.frx":36CD
      Style           =   1  'Graphical
      TabIndex        =   12
      Tag             =   "1720"
      ToolTipText     =   "Save playlist"
      Top             =   1560
      Width           =   255
   End
   Begin VB.CommandButton Command7 
      BackColor       =   &H00000000&
      Height          =   255
      Left            =   3480
      MaskColor       =   &H00FFFFFF&
      Picture         =   "mp3.frx":3F97
      Style           =   1  'Graphical
      TabIndex        =   11
      Tag             =   "1721"
      ToolTipText     =   "New playlist"
      Top             =   1560
      Width           =   255
   End
   Begin VB.CommandButton Command6 
      Height          =   255
      Left            =   1320
      Picture         =   "mp3.frx":4861
      Style           =   1  'Graphical
      TabIndex        =   10
      Tag             =   "1722"
      ToolTipText     =   "Forward"
      Top             =   1200
      Width           =   255
   End
   Begin VB.CommandButton Command4 
      Height          =   255
      Left            =   1080
      Picture         =   "mp3.frx":512B
      Style           =   1  'Graphical
      TabIndex        =   9
      Tag             =   "1723"
      ToolTipText     =   "Back"
      Top             =   1200
      Width           =   255
   End
   Begin VB.HScrollBar pos 
      Height          =   135
      Left            =   240
      Max             =   100
      TabIndex        =   7
      Top             =   960
      Width           =   3855
   End
   Begin VB.CommandButton Command2 
      Height          =   255
      Left            =   720
      Picture         =   "mp3.frx":59F5
      Style           =   1  'Graphical
      TabIndex        =   1
      Tag             =   "1724"
      ToolTipText     =   "Stop"
      Top             =   1200
      Width           =   255
   End
   Begin VB.CommandButton Command5 
      Height          =   255
      Left            =   480
      Picture         =   "mp3.frx":62BF
      Style           =   1  'Graphical
      TabIndex        =   6
      Tag             =   "1725"
      ToolTipText     =   "Pause"
      Top             =   1200
      Width           =   255
   End
   Begin VB.CommandButton play 
      Height          =   255
      Left            =   240
      Picture         =   "mp3.frx":6B89
      Style           =   1  'Graphical
      TabIndex        =   5
      Tag             =   "1726"
      ToolTipText     =   "Play"
      Top             =   1200
      Width           =   255
   End
   Begin VB.CommandButton Command3 
      Height          =   135
      Left            =   4200
      TabIndex        =   4
      Top             =   0
      Width           =   135
   End
   Begin VB.PictureBox analyser 
      AutoRedraw      =   -1  'True
      BackColor       =   &H00000000&
      Height          =   495
      Left            =   120
      ScaleHeight     =   29
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   85
      TabIndex        =   3
      Top             =   120
      Width           =   1335
   End
   Begin VB.PictureBox out 
      AutoRedraw      =   -1  'True
      BackColor       =   &H00000000&
      Height          =   495
      Left            =   1560
      ScaleHeight     =   29
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   85
      TabIndex        =   2
      Top             =   120
      Width           =   1335
   End
   Begin VB.CommandButton Command1 
      Height          =   255
      Left            =   1680
      Picture         =   "mp3.frx":7453
      Style           =   1  'Graphical
      TabIndex        =   0
      Tag             =   "1727"
      ToolTipText     =   "Open"
      Top             =   1200
      Width           =   495
   End
   Begin VB.Label playtime 
      BackStyle       =   0  'Transparent
      Caption         =   "00:00:00"
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Left            =   3000
      TabIndex        =   14
      Tag             =   "1728"
      Top             =   360
      Width           =   735
   End
End
Attribute VB_Name = "mp3player"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'========================================================================
' The RPG Toolkit, Version 3
' This file copyright (C) 2007 Christopher B. Matthews
'========================================================================
'
' This program is free software; you can redistribute it and/or
' modify it under the terms of the GNU General Public License
' as published by the Free Software Foundation; either version 2
' of the License, or (at your option) any later version.
'
' This program is distributed in the hope that it will be useful,
' but WITHOUT ANY WARRANTY; without even the implied warranty of
' MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
' GNU General Public License for more details.
'
'========================================================================

Private outputlevels(100) As Long
Public levelsPosition As Integer

Public bIgnore As Boolean

Public bRandom As Boolean   'play random?

Private playlistfiles(1000) As String
Public clist As Integer     'count of playlist
Public currentMp3 As String    'current song

Public mp3x As Integer      'old location of window
Public mp3y As Integer      'old location of window

Public modTime As Integer   'total time of mod file
Public modPlaying As Boolean    'is a mod playing?

Public bardIsPaused As Boolean 'is the player paused?

Private pausePos As Long    'position paused at
Private pauseFile As String 'file paused on

'API added by KSNiloc...
Private Declare Function MoveWindow Lib "user32" _
                (ByVal hwnd As Long, ByVal x As Long, _
                ByVal y As Long, ByVal nWidth As Long, _
                ByVal nHeight As Long, ByVal bRepaint As Long) As Long

Private Declare Function GetParent Lib "user32" _
                (ByVal hwnd As Long) As Long
               
Private Declare Function SetParent Lib "user32" _
                (ByVal hWndChild As Long, _
                ByVal hWndNewParent As Long) As Long

Public bkgDevice As Long    'audiere device

Private myParent As Long

Private Sub BWMP31_SelectedWaveOut(WaveOutDeviceName As String)
    On Error GoTo errorhandler


    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub



Sub openWinampPlaylist(file$)
    'opens a winamp playlist
    On Error Resume Next
    playlist.Clear
    
    pt$ = GetPath(file$)
    num = FreeFile
    clist = 0
    Open file$ For Input As #num
        Do While Not EOF(num)
            Line Input #num, t$
            part$ = Mid$(t$, 1, 1)
            If part$ <> "#" Then
                p$ = GetPath(t$)
                If p$ = "" Then
                    playlistfiles(clist) = pt$ + t$
                Else
                    playlistfiles(clist) = t$
                End If
                playlist.AddItem (RemovePath(t$))
                clist = clist + 1
            End If
        Loop
    Close #num
End Sub

Public Sub playSong(file$)
    On Error GoTo errorhandler
    currentMp3 = file$
    Call play_Click

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub saveWinampPlaylist(file$)
    'saves the playlist as a winamp playlist...
    On Error Resume Next
    
    num = FreeFile
    idx = playlist.ListCount
    If idx = -1 Then Exit Sub
    
    Open file$ For Output As #num
        For t = 0 To clist - 1
            Print #num, playlistfiles(t)
        Next t
    Close #num
End Sub

Public Sub stopMusic()
    'stops the music...
    On Error GoTo errorhandler
    Call Command2_Click

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Check1_Click()
    On Error GoTo errorhandler
    If Check1.Value = 0 Then
        bRandom = False
    Else
        bRandom = True
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command1_Click()
    'prompts for a button filename.
    On Error Resume Next
    Dim filename As String
    Dim antipath As String
    
'    ChDir (currentdir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = mp3Path$
    
    dlg.strTitle = "Select Filename"
    dlg.strDefaultExt = "mp3"
    dlg.strFileTypes = strFileDialogFilterMediaPlayList
    
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename = dlg.strSelectedFile
        antipath = dlg.strSelectedFileNoPath
        mp3Path$ = GetPath(filename)
    Else
        'getImageFilename = ""
        Exit Sub
    End If
    ex$ = GetExt(antipath)
    If UCase$(ex$) = "M3U" Then
        Call openWinampPlaylist(filename)
    Else
        playlist.AddItem (RemovePath(filename))
        playlistfiles(clist) = filename
        clist = clist + 1
        ex$ = GetExt(filename)
        If UCase$(ex$) = "MP3" Or UCase$(ex$) = "WAV" Or UCase$(ex$) = "MID" Then
            'mp3.OpenMP3 (filename)
            'mp3.PlayMP3
            Call StopMCI
            Call PlayMCI(filename)
            'MMControl1.Command = "stop"
            'MMControl1.Command = "close"
            'MMControl1.filename = filename
            'MMControl1.Command = "open"
            'MMControl1.Command = "play"
        Else
            Call TKAudierePlay(bkgDevice, filename, 1, 0)
        End If
        currentMp3 = filename
    End If
    ChDir (currentDir$)
End Sub


Private Sub Command2_Click()
    On Error GoTo errorhandler
    bardIsPaused = False
    modPlaying = False
    'mp3.StopMP3
    'mp3.CloseMP3
    Call StopMCI
    Call TKAudiereStop(bkgDevice)
    'MMControl1.Command = "stop"
    'MMControl1.Command = "close"

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Private Sub Command3_Click()
'Update 7/3/04: Music stops when Bard closes (by Compugeek)
    On Error GoTo errorhandler
    Call Command2_Click     'press stop to halt playback
    End
    mp3player.Hide

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command4_Click()
    On Error GoTo errorhandler
    bardIsPaused = False
    idx = playlist.ListIndex
    If idx = -1 Then Exit Sub
    cnt = playlist.ListCount
    If idx - 1 < 0 Then
        idx = 0
    Else
        idx = idx - 1
    End If
    If idx < 0 Then idx = playlist.ListCount - 1
    playlist.ListIndex = idx
    currentMp3 = playlistfiles(idx)
    Call play_Click

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command5_Click()
    On Error GoTo errorhandler
    If bardIsPaused Then
        bardIsPaused = False
        ex$ = GetExt(currentMp3)
        If UCase$(ex$) = "MP3" Or UCase$(ex$) = "WAV" Or UCase$(ex$) = "MID" Then
            'mp3.ResumeMP3
            'MMControl1.Command = "play"
            Call PlayMCI(pauseFile)
            Call SetPositionMCI(pausePos)
        Else
            Exit Sub
        End If
    Else
        'modPlaying = False
        'bardIsPaused = True
        'Call ModPlugStop    'pause mod
        'mp3.PauseMP3        'pause mp3
        
        pausePos = GetPositionMCI()
        pauseFile = currentMp3
        Call StopMCI
        'modPlaying = False
        bardIsPaused = True
        'MMControl1.Command = "stop"
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command6_Click()
    On Error GoTo errorhandler
    bardIsPaused = False
    idx = playlist.ListIndex
    If idx = -1 Then Exit Sub
    cnt = playlist.ListCount
    If idx + 1 >= cnt Then
        idx = 0
    Else
        If bRandom = True Then
            idx = Int(Rnd(1) * cnt - 1) + 1
        Else
            idx = idx + 1
        End If
    End If
    playlist.ListIndex = idx
    currentMp3 = playlistfiles(idx)
    Call play_Click

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command7_Click()
    On Error GoTo errorhandler
    playlist.Clear
    For t = 0 To 1000
        playlistfiles(t) = ""
    Next t
    clist = 0

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command8_Click()
    'prompts for a button filename.
    On Error Resume Next
    Dim filename As String
    Dim antipath As String
    
'    ChDir (currentdir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = mp3Path$
    
    dlg.strTitle = "Select Filename"
    dlg.strDefaultExt = "m3u"
    dlg.strFileTypes = "Winamp Playlist (*.m3u)|*.m3u|All files(*.*)|*.*"
    
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename = dlg.strSelectedFile
        antipath = dlg.strSelectedFileNoPath
        mp3Path$ = GetPath(filename)
    Else
        'getImageFilename = ""
        Exit Sub
    End If
    Call saveWinampPlaylist(filename)
End Sub

Private Sub Form_Activate()
    myParent = GetParent(Me.hwnd)
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
    On Error GoTo errorhandler
    k$ = Chr$(KeyCode)
    k$ = UCase$(k$)
    
    If k$ = "Z" Then
        'previous
        Call Command4_Click
    End If
    If k$ = "X" Then
        'play
        Call play_Click
    End If
    If k$ = "C" Then
        'pause
        Call Command5_Click
    End If
    If k$ = "V" Then
        'stop
        Call Command2_Click
    End If
    If k$ = "B" Then
        'next
        Call Command6_Click
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Form_Load()
    On Error GoTo errorhandler
    
    mp3x = mp3y = -1
    out.Width = 80 * Screen.TwipsPerPixelX
    out.Height = 30 * Screen.TwipsPerPixelY
    analyser.Width = 80 * Screen.TwipsPerPixelX
    analyser.Height = 30 * Screen.TwipsPerPixelY
    
    Call TKAudiereInit
    bkgDevice = TKAudiereCreateHandle()

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Form_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
    On Error GoTo errorhandler
    If Button = 1 Then
        If mp3x = 0 Then
            mp3x = x: mp3y = y
            Exit Sub
        Else
            dx = x - mp3x
            dy = y - mp3y
            mp3player.Top = mp3player.Top + (dy / Screen.TwipsPerPixelY)
            mp3player.Left = mp3player.Left + (dx / Screen.TwipsPerPixelX)
            If Not GetParent(Me.hwnd) = myParent Then _
                SetParent Me.hwnd, myParent
        End If
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Form_Unload(Cancel As Integer)
    'mp3.StopMP3
    'mp3.CloseMP3
    On Error GoTo errorhandler
    Call StopMCI
    Call TKAudiereKill
    'MMControl1.Command = "stop"
    'MMControl1.Command = "close"

    'Make closing this window end the program... [KSNiloc]
    End

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub mp3_PlaybackPosition(Position As Long, TimePosition As String)
    On Error GoTo errorhandler
    playtime.Caption = TimePosition

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub mp3_ProgressPosition(NewValue As Long)
    On Error GoTo errorhandler
    bIgnore = True
    pos.Value = NewValue
    If NewValue = 100 Then
        Call Command6_Click
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub mp3_SetMP3OutputLevel(NewValue As Long)
    On Error GoTo errorhandler
    outputlevels(levelsPosition) = NewValue
    
    ReDim levs(76) As Integer
    st = 0
    For t = levelsPosition To 75
        levs(st) = outputlevels(t)
        st = st + 1
    Next t
    For t = 0 To levelsPosition
        levs(st) = outputlevels(t)
        st = st + 1
    Next t
    
    x = 0
    Call vbPicCls(analyser)
    For t = 5 To 35 Step 5
       For l = 0 To levs(t) / 4
            Call vbPicLine(analyser, x, -l + 25, x + 5, -l + 25, RGB(l * 20, 0, 255 - l * 10))
        Next l
        x = x + 6
    Next t
    For t = 30 To 5 Step -5
       For l = 0 To levs(t) / 4
            Call vbPicLine(analyser, x, -l + 25, x + 5, -l + 25, RGB(l * 20, 0, 255 - l * 10))
        Next l
        x = x + 6
    Next t
    
    'volume levels...
    x = 0
    Call vbPicCls(out)
    For t = 0 To 75
        For l = 0 To levs(t) / 4
            'out.Cls
            Call vbPicPSet(out, x, -l + 25, RGB(l * 20, l * 20, 255 - l * 10))
            'out.Refresh
        Next l
        'out.Line (x, 0)-(x, outputlevels(t) / 4), vbqbcolor(4)
        x = x + 1
    Next t
    
    levelsPosition = levelsPosition + 1
    If levelsPosition > 75 Then levelsPosition = 0
    

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Private Sub play_Click()
    On Error GoTo errorhandler
    modPlaying = False
    bIgnore = True
    If bardIsPaused Then
        bardIsPaused = False
        ex$ = GetExt(currentMp3)
        Select Case UCase$(ex$)
            Case "MP3", "WAV", "MID":
                'mp3.ResumeMP3
                'MMControl1.Command = "play"
                Call PlayMCI(pauseFile)
                Call SetPositionMCI(pausePos)
            
            Case Else
                Exit Sub
                'modPlaying = True
                'Call ModPlugPlay(currentMp3)
        End Select
    Else
        modPlaying = False
        'mp3.StopMP3
        'mp3.CloseMP3
        'MMControl1.Command = "stop"
        'MMControl1.Command = "close"
        Call StopMCI
        Call TKAudiereStop(bkgDevice)
        ex$ = GetExt(currentMp3)
        Select Case UCase$(ex$)
            Case "MP3", "WAV", "MID":
                'mp3.OpenMP3 (currentMp3)
                'mp3.PlayMP3
                Call StopMCI
                Call PlayMCI(currentMp3)
                'MMControl1.Command = "stop"
                'MMControl1.Command = "close"
                'MMControl1.filename = currentMp3
                'MMControl1.Command = "open"
                'MMControl1.Command = "play"
                
            Case Else:
                modPlaying = True
                Call TKAudierePlay(bkgDevice, currentMp3, 1, 0)
        End Select
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub playlist_DblClick()
    On Error GoTo errorhandler
    modTime = 0
    idx = playlist.ListIndex
    currentMp3 = playlistfiles(idx)
    Call play_Click
    'mp3.OpenMP3 (playlistfiles(idx))
    'mp3.PlayMP3

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Private Sub pos_Change()
    On Error GoTo errorhandler
    If bIgnore = True Then
        bIgnore = False
    Else
        If currentMp3 <> "" Then
            ex$ = GetExt(currentMp3)
            Select Case UCase$(ex$)
                Case "MP3", "WAV", "MID":
                    Call SetPositionMCI(pos.Value)
                    bIgnore = True
                Case Else
                    modPlaying = True
                    Call TKAudiereSetPosition(bkgDevice, pos.Value)
                    bIgnore = True
            End Select
            
            'If UCase$(ex$) = "MP3" Then
            '    'mp3.SetSliderPosition (pos.Value)
            '
            'Else
            '    modPlaying = True
            '    Call ModPlugSetPosition(pos.Value)
            'End If
        End If
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Private Sub Timer1_Timer()
    On Error GoTo errorhandler
    If currentMp3 <> "" Then
        ex$ = GetExt(currentMp3)
        If UCase$(ex$) = "MP3" Or UCase$(ex$) = "WAV" Or UCase$(ex$) = "MID" Then
            'le = MMControl1.length
            'po = MMControl1.Position
            le = GetLengthMCI()
            po = GetPositionMCI()
            If le = 0 Then Exit Sub
            perc = Int((po / le) * 100)
            bIgnore = True
            pos.Value = perc
        Else
            modTime = modTime + 1
            bIgnore = True
            pos.Value = TKAudiereGetPosition(bkgDevice)
            If modPlaying = True Then
                If Not (TKAudiereIsPlaying(bkgDevice)) Then
                    'mod has finished!
                    'advance playlist...
                    Call Command6_Click
                End If
            End If
        End If
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Public Sub HandleError()
    'Void.
End Sub

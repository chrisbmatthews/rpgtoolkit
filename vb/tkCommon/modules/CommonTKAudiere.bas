Attribute VB_Name = "CommonTKAudiere"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'audiere interface

Option Explicit

#If isToolkit = 0 Then
    Public Declare Sub TKAudiereInit Lib "actkrt3.dll" ()
    Public Declare Sub TKAudiereKill Lib "actkrt3.dll" ()
    Public Declare Function TKAudierePlay Lib "actkrt3.dll" (ByVal handle As Long, ByVal filename As String, ByVal streamYN As Long, ByVal autoRepeatYN As Long) As Long
    Public Declare Function TKAudiereIsPlaying Lib "actkrt3.dll" (ByVal handle As Long) As Long
    Public Declare Sub TKAudiereStop Lib "actkrt3.dll" (ByVal handle As Long)
    Public Declare Sub TKAudiereRestart Lib "actkrt3.dll" (ByVal handle As Long)
    Public Declare Sub TKAudiereDestroyHandle Lib "actkrt3.dll" (ByVal handle As Long)
    Public Declare Function TKAudiereCreateHandle Lib "actkrt3.dll" () As Long
    Public Declare Function TKAudiereGetPosition Lib "actkrt3.dll" (ByVal handle As Long) As Long
    Public Declare Sub TKAudiereSetPosition Lib "actkrt3.dll" (ByVal handle As Long, ByVal pos As Long)
#End If

Public Const strFileDialogFilterMedia = "Sound Files|*.mid;*.midi;*.wav;*.mod;*.s3m;*.it;*.xm;*.mp3;*.mp1;*.mp2;*.669;*.amf;*.ams;*.dbm;*.dsm;*.far;*.med;*.mdl;*.mtm;*.nst;*.okt;*.ptm;*.stm;*.ult;*.umx;*.wow|MIDI Sequence (*.mid)|*.mid;*.midi|MPEG (*.mp3, *.mp2, *.mp1)|*.mp1;*.mp2;*.mp3|WAV Waveform Audio(*.wav)|*.wav|ProTracker Module (*.mod)|*.mod|UNIS 669 Composer (*.669)|*.669|Asylum/DSMI (*.amf)|*.amf|Velvet Studio (*.ams)|*.ams|DigiBooster Pro (*.dbm)|*.dbm|DSIK Internal (*.dsm)|*.dsm|Farandole Composer (*.far)|*.far|Impulse Tracker (*.it)|*.it|OctaMed (*.med)|*.med|DigiTracker 1.x (*.mdl)|*.mdl|MultiTracker (*.mtm)|*.mtm|NoiseTracker (*.nst)|*.nst|OktaLyser (*.okt)|*.okt|PolyTracker (*.ptm)|*.ptm|ScreamTracker III (*.s3m)|*.s3m|ScreamTracker II (*.stm)|*.stm|UltraTracker (*.ult)|*.ult|Unreal Music (*.umx)|*.umx|Grave Composer (*.wow)|*.wow|FastTracker (*.xm)|*.xm|All files(*.*)|*.*"
Public Const strFileDialogFilterMediaPlayList = "Sound Files|*.m3u;*.mid;*.midi;*.wav;*.mod;*.s3m;*.it;*.xm;*.mp3;*.mp1;*.mp2;*.669;*.amf;*.ams;*.dbm;*.dsm;*.far;*.med;*.mdl;*.mtm;*.nst;*.okt;*.ptm;*.stm;*.ult;*.umx;*.wow|Winamp Playlist (*.m3u)|*.m3u|MIDI Sequence (*.mid)|*.mid;*.midi|MPEG (*.mp3, *.mp2, *.mp1)|*.mp1;*.mp2;*.mp3|WAV Waveform Audio(*.wav)|*.wav|ProTracker Module (*.mod)|*.mod|UNIS 669 Composer (*.669)|*.669|Asylum/DSMI (*.amf)|*.amf|Velvet Studio (*.ams)|*.ams|DigiBooster Pro (*.dbm)|*.dbm|DSIK Internal (*.dsm)|*.dsm|Farandole Composer (*.far)|*.far|Impulse Tracker (*.it)|*.it|OctaMed (*.med)|*.med|DigiTracker 1.x (*.mdl)|*.mdl|MultiTracker (*.mtm)|*.mtm|NoiseTracker (*.nst)|*.nst|OktaLyser (*.okt)|*.okt|PolyTracker (*.ptm)|*.ptm|ScreamTracker III (*.s3m)|*.s3m|ScreamTracker II (*.stm)|*.stm|UltraTracker (*.ult)|*.ult|Unreal Music (*.umx)|*.umx|Grave Composer (*.wow)|*.wow|FastTracker (*.xm)|*.xm|All files(*.*)|*.*"

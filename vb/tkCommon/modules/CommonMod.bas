Attribute VB_Name = "CommonMod"
'modplug stuff
Option Explicit

'* 1.75+ *
Declare Function ModPlug_CreateEx Lib "npmod32.dll" (ByVal lpszArgs As String) As Long
Declare Function ModPlug_Destroy Lib "npmod32.dll" (ByVal pPlugin As Long) As Integer
Declare Function ModPlug_SetWindow Lib "npmod32.dll" (ByVal pPlugin As Long, ByVal hwnd As Long) As Integer
Declare Function ModPlug_Load Lib "npmod32.dll" (ByVal pPlugin As Long, ByVal lpszFileName As String) As Integer
Declare Function ModPlug_Play Lib "npmod32.dll" (ByVal pPlugin As Long) As Integer
Declare Function ModPlug_Stop Lib "npmod32.dll" (ByVal pPlugin As Long) As Integer

'* 1.80+ *
Declare Function ModPlug_SetCurrentPosition Lib "npmod32.dll" (ByVal plugin As Long, ByVal nPos As Long) As Integer
Declare Function ModPlug_GetCurrentPosition Lib "npmod32.dll" (ByVal plugin As Long) As Long
Declare Function ModPlug_GetVersion Lib "npmod32.dll" () As Long
Declare Function ModPlug_IsPlaying Lib "npmod32.dll" (ByVal plugin As Long) As Integer
Declare Function ModPlug_IsReady Lib "npmod32.dll" (ByVal plugin As Long) As Integer
Declare Function ModPlug_GetMaxPosition Lib "npmod32.dll" (ByVal plugin As Long) As Long

'* 1.91+ *
Declare Function ModPlug_SetVolume Lib "npmod32.dll" (ByVal plugin As Long, ByVal vol As Long) As Long
Declare Function ModPlug_GetVolume Lib "npmod32.dll" (ByVal plugin As Long) As Long

Public modPlugID As Long   'id of mod player
Public modPlugInitialized As Boolean    'has the mod player been initialized?

Public Const strFileDialogFilterMedia = "Sound Files|*.mid;*.midi;*.wav;*.mod;*.s3m;*.it;*.xm;*.mp3;*.mp1;*.mp2;*.669;*.amf;*.ams;*.dbm;*.dsm;*.far;*.med;*.mdl;*.mtm;*.nst;*.okt;*.ptm;*.stm;*.ult;*.umx;*.wow|MIDI Sequence (*.mid)|*.mid;*.midi|MPEG (*.mp3, *.mp2, *.mp1)|*.mp1;*.mp2;*.mp3|WAV Waveform Audio(*.wav)|*.wav|ProTracker Module (*.mod)|*.mod|UNIS 669 Composer (*.669)|*.669|Asylum/DSMI (*.amf)|*.amf|Velvet Studio (*.ams)|*.ams|DigiBooster Pro (*.dbm)|*.dbm|DSIK Internal (*.dsm)|*.dsm|Farandole Composer (*.far)|*.far|Impulse Tracker (*.it)|*.it|OctaMed (*.med)|*.med|DigiTracker 1.x (*.mdl)|*.mdl|MultiTracker (*.mtm)|*.mtm|NoiseTracker (*.nst)|*.nst|OktaLyser (*.okt)|*.okt|PolyTracker (*.ptm)|*.ptm|ScreamTracker III (*.s3m)|*.s3m|ScreamTracker II (*.stm)|*.stm|UltraTracker (*.ult)|*.ult|Unreal Music (*.umx)|*.umx|Grave Composer (*.wow)|*.wow|FastTracker (*.xm)|*.xm|All files(*.*)|*.*"
Public Const strFileDialogFilterMediaPlayList = "Sound Files|*.m3u;*.mid;*.midi;*.wav;*.mod;*.s3m;*.it;*.xm;*.mp3;*.mp1;*.mp2;*.669;*.amf;*.ams;*.dbm;*.dsm;*.far;*.med;*.mdl;*.mtm;*.nst;*.okt;*.ptm;*.stm;*.ult;*.umx;*.wow|Winamp Playlist (*.m3u)|*.m3u|MIDI Sequence (*.mid)|*.mid;*.midi|MPEG (*.mp3, *.mp2, *.mp1)|*.mp1;*.mp2;*.mp3|WAV Waveform Audio(*.wav)|*.wav|ProTracker Module (*.mod)|*.mod|UNIS 669 Composer (*.669)|*.669|Asylum/DSMI (*.amf)|*.amf|Velvet Studio (*.ams)|*.ams|DigiBooster Pro (*.dbm)|*.dbm|DSIK Internal (*.dsm)|*.dsm|Farandole Composer (*.far)|*.far|Impulse Tracker (*.it)|*.it|OctaMed (*.med)|*.med|DigiTracker 1.x (*.mdl)|*.mdl|MultiTracker (*.mtm)|*.mtm|NoiseTracker (*.nst)|*.nst|OktaLyser (*.okt)|*.okt|PolyTracker (*.ptm)|*.ptm|ScreamTracker III (*.s3m)|*.s3m|ScreamTracker II (*.stm)|*.stm|UltraTracker (*.ult)|*.ult|Unreal Music (*.umx)|*.umx|Grave Composer (*.wow)|*.wow|FastTracker (*.xm)|*.xm|All files(*.*)|*.*"

Sub DestroyModPlug()
    'shuts down modplug
    'Stop the plugin.
    On Error Resume Next
    Dim x As Long
    x = ModPlug_Stop(modPlugID)

    'Now, destroy the plugin window...

    x = ModPlug_Destroy(modPlugID)
    
    Unload modplugdummy
    
    modPlugInitialized = False
End Sub


Sub InitModPlug()
    'initializes modplug.
    On Error Resume Next
    
    ' In order to get a MOD playing, you have to
    ' first create the plugin.  Note that this
    ' does not actually display the plugin.  However,
    ' this returned value is so important that we give
    ' it variable RetVal.
    modPlugID = ModPlug_CreateEx("loop|false")

    ' This next step gives the newly-created plugin
    ' a window hWnd to use.  This return value
    ' isn't important; therefore, we give it variable
    ' x.
    modplugdummy.Show
    modplugdummy.Hide
    Dim x As Long
    x = ModPlug_SetWindow(modPlugID, modplugdummy.hwnd)
    'modPlugID = CreateModStream()
    
    modPlugInitialized = True
End Sub

Function CreateModStream() As Long
    'create a modplug stream modplug.
    On Error Resume Next
    
    ' In order to get a MOD playing, you have to
    ' first create the plugin.  Note that this
    ' does not actually display the plugin.  However,
    ' this returned value is so important that we give
    ' it variable RetVal.
    Dim id As Long
    id = ModPlug_CreateEx("loop|false")

    ' This next step gives the newly-created plugin
    ' a window hWnd to use.  This return value
    ' isn't important; therefore, we give it variable
    ' x.
    'Dim frm As Form
    'Set frm = New modplugdummy
    'frm.Show
    'frm.Hide
    modplugdummy.Show
    modplugdummy.Hide
    Dim x As Long
    x = ModPlug_SetWindow(modPlugID, modplugdummy.hwnd)
    
    CreateModStream = id
End Function


Function ModPlugGetPosition() As Long
    'returns current position of song (in percentage)
    On Error Resume Next
    If modPlugInitialized = False Then
        Exit Function
    End If
    Dim cp As Long, mp As Long, perc As Long
    cp = ModPlug_GetCurrentPosition(modPlugID)
    mp = ModPlug_GetMaxPosition(modPlugID)
    perc = Int((cp / mp) * 100)
    ModPlugGetPosition = perc
End Function

Function ModPlugGetVol() As Integer
    'returns volume of song (in percentage)
    On Error Resume Next
    If modPlugInitialized = False Then
        Exit Function
    End If
    ModPlugGetVol = ModPlug_GetVolume(modPlugID)
End Function

Sub ModPlugPlay(file$)
    'play a filename
    On Error Resume Next
    If modPlugInitialized = False Then
        Call InitModPlug
    End If
    Dim x As Long
    x = ModPlug_Load(modPlugID, file$)

    'If all goes well, you can now play the MOD.
    x = ModPlug_Play(modPlugID)
End Sub


Function ModPlugPlaying() As Boolean
    'tells us if the mod is playing.
    On Error Resume Next
    If modPlugInitialized = False Then
        ModPlugPlaying = False
        Exit Function
    End If
    Dim a As Long
    a = ModPlug_IsPlaying(modPlugID)
    If a = 1 Then
        ModPlugPlaying = True
    Else
        ModPlugPlaying = False
    End If
End Function

Sub ModPlugSetPosition(pos As Integer)
    'sets the position in the mod file
    'pos is a percentage
    On Error Resume Next
    If modPlugInitialized = False Then
        Exit Sub
    End If
    Dim mp As Long, newPos As Long, aa As Long
    mp = ModPlug_GetMaxPosition(modPlugID)
    newPos = Int((pos * mp) / 100)
    aa = ModPlug_SetCurrentPosition(modPlugID, newPos)
End Sub

Sub ModPlugSetVol(newlevel As Integer)
    'sets volume of song (in percentage)
    On Error Resume Next
    If modPlugInitialized = False Then
        Exit Sub
    End If
    Dim aa As Long
    aa = ModPlug_SetVolume(modPlugID, newlevel)
End Sub

Sub ModPlugStop()
    'stops the mod
    '(does not destroy mod plug instance)
    'Stop the plugin.
    On Error Resume Next
    Dim x As Long
    x = ModPlug_Stop(modPlugID)
End Sub


Sub ModPlugStopWithFadeOut()
    'stops mod with fadeout
    On Error Resume Next
    Dim t As Integer
    Dim lev As Integer
    lev = ModPlugGetVol()
    For t = lev To 0 Step -1
        Call ModPlugSetVol(t)
        Dim ll As Long
        ll = Timer
        Do While Timer - ll < 1E-28
        Loop
    Next t
    Call ModPlugStop
    Call ModPlugSetVol(lev)

End Sub



Attribute VB_Name = "CommonMedia"
'=========================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=========================================================================

'=========================================================================
' Common media functions
'=========================================================================

'=========================================================================
'NOTE
' + This file is not redundant! Audiere does *not* play WAV, or MIDI
'=========================================================================

Option Explicit

'=========================================================================
' Member Win32 declarations
'=========================================================================
Private Declare Function GetShortPathName Lib "kernel32" Alias "GetShortPathNameA" (ByVal lpszLongPath As String, ByVal lpszShortPath As String, ByVal cchBuffer As Long) As Long
Private Declare Function mciGetErrorString Lib "winmm.dll" Alias "mciGetErrorStringA" (ByVal dwError As Long, ByVal lpstrBuffer As String, ByVal uLength As Long) As Long
Private Declare Function mciSendString Lib "winmm.dll" Alias "mciSendStringA" (ByVal lpstrCommand As String, ByVal lpstrReturnString As String, ByVal uReturnLength As Long, ByVal hwndCallback As Long) As Long

'=========================================================================
' Public Win32 declarations
'=========================================================================
Public Declare Function sndPlaySound Lib "winmm" Alias "sndPlaySoundA" (ByVal lpSound As String, ByVal lpType As Long) As Long

'=========================================================================
' Public constants
'=========================================================================
Public Const SND_SYNC = &H0
Public Const SND_ASYNC = &H1
Public Const SND_NODEFAULT = &H2
Public Const SND_LOOP = &H8
Public Const SND_NOSTOP = &H10

'=========================================================================
' File types the TK supports
'=========================================================================
Public Const strFileDialogFilterMedia = "Sound Files|*.mid;*.midi;*.wav;*.mod;*.s3m;*.it;*.xm;*.mp3;*.mp1;*.mp2;*.669;*.amf;*.ams;*.dbm;*.dsm;*.far;*.med;*.mdl;*.mtm;*.nst;*.okt;*.ptm;*.stm;*.ult;*.umx;*.wow|MIDI Sequence (*.mid)|*.mid;*.midi|MPEG (*.mp3, *.mp2, *.mp1)|*.mp1;*.mp2;*.mp3|WAV Waveform Audio(*.wav)|*.wav|ProTracker Module (*.mod)|*.mod|UNIS 669 Composer (*.669)|*.669|Asylum/DSMI (*.amf)|*.amf|Velvet Studio (*.ams)|*.ams|DigiBooster Pro (*.dbm)|*.dbm|DSIK Internal (*.dsm)|*.dsm|Farandole Composer (*.far)|*.far|Impulse Tracker (*.it)|*.it|OctaMed (*.med)|*.med|DigiTracker 1.x (*.mdl)|*.mdl|MultiTracker (*.mtm)|*.mtm|NoiseTracker (*.nst)|*.nst|OktaLyser (*.okt)|*.okt|PolyTracker (*.ptm)|*.ptm|ScreamTracker III (*.s3m)|*.s3m|ScreamTracker II (*.stm)|*.stm|UltraTracker (*.ult)|*.ult|Unreal Music (*.umx)|*.umx|Grave Composer (*.wow)|*.wow|FastTracker (*.xm)|*.xm|All files(*.*)|*.*"
Public Const strFileDialogFilterMediaPlayList = "Sound Files|*.m3u;*.mid;*.midi;*.wav;*.mod;*.s3m;*.it;*.xm;*.mp3;*.mp1;*.mp2;*.669;*.amf;*.ams;*.dbm;*.dsm;*.far;*.med;*.mdl;*.mtm;*.nst;*.okt;*.ptm;*.stm;*.ult;*.umx;*.wow|Winamp Playlist (*.m3u)|*.m3u|MIDI Sequence (*.mid)|*.mid;*.midi|MPEG (*.mp3, *.mp2, *.mp1)|*.mp1;*.mp2;*.mp3|WAV Waveform Audio(*.wav)|*.wav|ProTracker Module (*.mod)|*.mod|UNIS 669 Composer (*.669)|*.669|Asylum/DSMI (*.amf)|*.amf|Velvet Studio (*.ams)|*.ams|DigiBooster Pro (*.dbm)|*.dbm|DSIK Internal (*.dsm)|*.dsm|Farandole Composer (*.far)|*.far|Impulse Tracker (*.it)|*.it|OctaMed (*.med)|*.med|DigiTracker 1.x (*.mdl)|*.mdl|MultiTracker (*.mtm)|*.mtm|NoiseTracker (*.nst)|*.nst|OktaLyser (*.okt)|*.okt|PolyTracker (*.ptm)|*.ptm|ScreamTracker III (*.s3m)|*.s3m|ScreamTracker II (*.stm)|*.stm|UltraTracker (*.ult)|*.ult|Unreal Music (*.umx)|*.umx|Grave Composer (*.wow)|*.wow|FastTracker (*.xm)|*.xm|All files(*.*)|*.*"

'=========================================================================
' Convert a pointer to a null-terminated string to a VB string
'=========================================================================
Private Function APIString2VBString(ByVal str As String) As String
    On Error Resume Next
    Dim part As String, stringPos As Integer
    For stringPos = 0 To Len(str)
        part = Mid(str, stringPos, 1)
        If part = Chr(0) Then
            Exit For
        Else
            APIString2VBString = APIString2VBString & part
        End If
    Next stringPos
End Function

'=========================================================================
' Get the length of the file that is playing
'=========================================================================
Public Function GetLengthMCI(Optional ByVal strIdentifier As String = "defDevice") As Long
    On Error Resume Next
    Dim returnStr As String * 255
    Call mciSendString("status " & strIdentifier & " length", returnStr, 255, 0)
    GetLengthMCI = CLng(APIString2VBString(returnStr))
End Function

'=========================================================================
' Get the position in the currently playing file
'=========================================================================
Public Function GetPositionMCI(Optional ByVal strIdentifier As String = "defDevice") As Long
    On Error Resume Next
    Dim returnStr As String * 255
    Call mciSendString("status " & strIdentifier & " position", returnStr, 255, 0)
    GetPositionMCI = CLng(APIString2VBString(returnStr))
End Function

'=========================================================================
' Determine if a file is playing
'=========================================================================
Public Function IsPlayingMCI(Optional ByVal strIdentifier As String = "defDevice") As Boolean
    On Error Resume Next
    Dim returnStr As String * 255
    Call mciSendString("status " & strIdentifier & " mode", returnStr, 255, 0)
    IsPlayingMCI = (Not (Left(returnStr, 7) = "stopped"))
End Function

'=========================================================================
' Play a file
'=========================================================================
Public Sub PlayMCI(DriveDirFile As String, Optional ByVal strIdentifier As String = "defDevice")
    On Error Resume Next
    Dim returnStr As String * 255, returnLen As Long
    Dim shortPath As String
    shortPath = space(Len(DriveDirFile))
    returnLen = GetShortPathName(DriveDirFile, shortPath, Len(shortPath))
    If returnLen > Len(DriveDirFile) Then 'not a long filename
        shortPath = DriveDirFile
    Else                          'it is a long filename
        shortPath = Left(shortPath, returnLen) 'x is the length of the return buffer
    End If
    Call mciSendString("close " & strIdentifier, returnStr, 255, 0) 'just in case
    Call mciSendString("open " & Chr(34) & shortPath & Chr(34) & " alias " & strIdentifier, returnStr, 255, 0)
    Call mciSendString("play " & strIdentifier, returnStr, 255, 0)
End Sub

'=========================================================================
' Set the file to a certain position
'=========================================================================
Public Sub SetPositionMCI(ByVal newPos As Long, Optional ByVal strIdentifier As String = "defDevice")
    On Error Resume Next
    Dim returnStr As String * 255, theLen As Long
    theLen = GetLengthMCI(strIdentifier)
    If newPos > theLen Then
        newPos = theLen
    End If
    Call mciSendString("status " & strIdentifier & " mode", returnStr, 255, 0)
    If Left(returnStr, 7) = "playing" Then
        Call mciSendString("stop " & strIdentifier, returnStr, 255, 0)
    End If
    Call mciSendString("seek " & strIdentifier & " to " & CStr(newPos), returnStr, 0, 0)
    Call mciSendString("play " & strIdentifier, returnStr, 255, 0)
End Sub

'=========================================================================
' Stop the playing file
'=========================================================================
Public Sub StopMCI(Optional ByVal strIdentifier As String = "defDevice")
    On Error Resume Next
    Dim returnStr As String * 255
    Call mciSendString("status " & strIdentifier & " mode", returnStr, 255, 0)
    If Left(returnStr, 7) = "playing" Then
        Call mciSendString("stop " & strIdentifier, returnStr, 255, 0)
    End If
    returnStr = space(255)
    Call mciSendString("status " & strIdentifier & " mode", returnStr, 255, 0)
    If Left(returnStr, 7) = "stopped" Then
        Call mciSendString("close " & strIdentifier, returnStr, 255, 0)
    End If
End Sub

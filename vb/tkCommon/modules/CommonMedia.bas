Attribute VB_Name = "CommonMedia"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'Multimedia system
'replaces MCI OCX control
'should do midi and wav for sure
'can also do mp3 if codec is installed
Option Explicit

Declare Function GetShortPathName Lib "kernel32" Alias "GetShortPathNameA" (ByVal lpszLongPath As String, ByVal lpszShortPath As String, ByVal cchBuffer As Long) As Long
Declare Function mciGetErrorString Lib "winmm.dll" Alias "mciGetErrorStringA" (ByVal dwError As Long, ByVal lpstrBuffer As String, ByVal uLength As Long) As Long
Declare Function mciSendString Lib "winmm.dll" Alias "mciSendStringA" (ByVal lpstrCommand As String, ByVal lpstrReturnString As String, ByVal uReturnLength As Long, ByVal hwndCallback As Long) As Long

Declare Function sndPlaySound Lib "winmm" Alias "sndPlaySoundA" (ByVal lpSound As String, ByVal flag As Long) As Long

Global Const SND_SYNC = &H0
Global Const SND_ASYNC = &H1
Global Const SND_NODEFAULT = &H2
Global Const SND_LOOP = &H8
Global Const SND_NOSTOP = &H10

Private Function APIString2VBString(ByVal str As String) As String
    'convert a null terminated string into a vb string
    On Error Resume Next
    
    Dim toRet As String
    Dim part As String
    Dim t As Integer
    For t = 0 To Len(str)
        part = Mid$(str, t, 1)
        If part = Chr$(0) Then
            Exit For
        Else
            toRet = toRet + part
        End If
    Next t
    
    APIString2VBString = toRet
End Function



Public Function GetLengthMCI(Optional ByVal strIdentifier As String = "defDevice") As Long
    On Error Resume Next
    'check if media is playing
    'strIdentifier is the identifier of the file you are playing
    
    Dim returnStr As String * 255
    Dim x&
    
    x = mciSendString("status " + strIdentifier + " length", returnStr, 255, 0)
    If x <> 0 Then
        GetLengthMCI = 0
        Exit Function 'StopMIDI() was pressed or error
    End If
    
    Dim theLen As String
    theLen$ = APIString2VBString(returnStr)
    GetLengthMCI = val(theLen$)
End Function



Public Function GetPositionMCI(Optional ByVal strIdentifier As String = "defDevice") As Long
    On Error Resume Next
    'check position of media file
    'strIdentifier is the identifier of the file you are playing
    
    Dim returnStr As String * 255
    Dim x&
    
    x = mciSendString("status " + strIdentifier + " position", returnStr, 255, 0)
    If x <> 0 Then
        GetPositionMCI = 0
        Exit Function 'StopMIDI() was pressed or error
    End If
    
    Dim theLen As String
    theLen$ = APIString2VBString(returnStr)
    GetPositionMCI = val(theLen$)
End Function




Public Function IsPlayingMCI(Optional ByVal strIdentifier As String = "defDevice") As Boolean
    On Error Resume Next
    'check if media is playing
    'strIdentifier is the identifier of the file you are playing
    
    Dim returnStr As String * 255
    Dim x&
    
    x = mciSendString("status " + strIdentifier + " mode", returnStr, 255, 0)
    If x <> 0 Then
        IsPlayingMCI = False
        Exit Function 'StopMIDI() was pressed or error
    End If
    
    If Left$(returnStr, 7) = "stopped" Then
        'x = mciSendString("play yada from 1", returnStr, 255, 0)
        IsPlayingMCI = False
    Else
        IsPlayingMCI = True
    End If

End Function


Public Function PlayMCI(DriveDirFile As String, Optional ByVal strIdentifier As String = "defDevice") As String
    'play a media file
    'optionally identify it with strIdentifier
    
    On Error Resume Next
    

    Dim returnStr As String * 255
    Dim Shortpath$, x&
    Shortpath = Space(Len(DriveDirFile))
    
    x = GetShortPathName(DriveDirFile, Shortpath, Len(Shortpath))
    
    If x > Len(DriveDirFile) Then 'not a long filename
      Shortpath = DriveDirFile
    Else                          'it is a long filename
      Shortpath = Left$(Shortpath, x) 'x is the length of the return buffer
    End If
    
    x = mciSendString("close " + strIdentifier, returnStr, 255, 0) 'just in case
    x = mciSendString("open " & Chr(34) & Shortpath & Chr(34) & " alias " + strIdentifier, returnStr, 255, 0)
    
    If x <> 0 Then GoTo theEnd  'invalid filename or path
    
    x = mciSendString("play " + strIdentifier, returnStr, 255, 0)
    
    If x <> 0 Then GoTo theEnd  'device busy or not ready
     
    Exit Function

theEnd:  'MIDI errorhandler
    returnStr = Space(255)
    x = mciGetErrorString(x, returnStr, 255)
    'MsgBox Trim(returnStr), vbExclamation 'error message
    x = mciSendString("close " + strIdentifier, returnStr, 255, 0)
    Exit Function

End Function

Sub SetPositionMCI(ByVal newPos As Long, Optional ByVal strIdentifier As String = "defDevice")
    'set the media file to a new positon.
    On Error Resume Next
    
    Dim returnStr As String * 255
    Dim x&
    
    Dim theLen As Long
    theLen = GetLengthMCI(strIdentifier)
    If newPos > theLen Then
        newPos = theLen
    End If
    
    x = mciSendString("status " + strIdentifier + " mode", returnStr, 255, 0)
    If Left$(returnStr, 7) = "playing" Then
        x = mciSendString("stop " + strIdentifier, returnStr, 255, 0)
    End If
    
    x = mciSendString("seek " + strIdentifier + " to " + str$(newPos), returnStr, 0, 0)
    
    x = mciSendString("play " + strIdentifier, returnStr, 255, 0)
    
End Sub

Public Function StopMCI(Optional ByVal strIdentifier As String = "defDevice") As String
    'play a media file
    'optionally identify it with strIdentifier
    
    On Error Resume Next
    
    Dim x&
    Dim returnStr As String * 255
       
    x = mciSendString("status " + strIdentifier + " mode", returnStr, 255, 0)
    If Left$(returnStr, 7) = "playing" Then
        x = mciSendString("stop " + strIdentifier, returnStr, 255, 0)
    End If
    
    returnStr = Space(255)
    
    x = mciSendString("status " + strIdentifier + " mode", returnStr, 255, 0)
    If Left$(returnStr, 7) = "stopped" Then
        x = mciSendString("close " + strIdentifier, returnStr, 255, 0)
    End If
End Function


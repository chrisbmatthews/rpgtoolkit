Attribute VB_Name = "mod"
'modplug stuff

'* 1.75+ *
Declare Function ModPlug_CreateEx Lib "npmod32.dll" (ByVal lpszArgs As String) As Long
Declare Function ModPlug_Destroy Lib "npmod32.dll" (ByVal pPlugin As Long) As Integer
Declare Function ModPlug_SetWindow Lib "npmod32.dll" (ByVal pPlugin As Long, ByVal hwnd As Integer) As Integer
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
Declare Function ModPlug_GetVolume Lib "npmod32.dll" (ByVal plugin As Long, ByVal vol As Long) As Long

Global modPlugID    'id of mod player
Global modPlugInitialized As Boolean    'has the mod player been initialized?
Sub DestroyModPlug()
    'shuts down modplug
    'Stop the plugin.
    On Error Goto errorhandler
    x = ModPlug_Stop(modPlugID)

    'Now, destroy the plugin window...

    x = ModPlug_Destroy(modPlugID)
    
    Unload modplugdummy
    
    modPlugInitialized = False

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError()
    Resume Next
End Sub


Sub InitModPlug()
    'initializes modplug.
    On Error Goto errorhandler
    
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
    x = ModPlug_SetWindow(modPlugID, modplugdummy.hwnd)
    
    modPlugInitialized = True

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError()
    Resume Next
End Sub


Sub ModPlugPlay(file$)
    'play a filename
    On Error Goto errorhandler
    If modPlugInitialized = False Then
        Call InitModPlug
    End If
    x = ModPlug_Load(modPlugID, file$)

    'If all goes well, you can now play the MOD.
    x = ModPlug_Play(modPlugID)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError()
    Resume Next
End Sub


Function ModPlugPlaying() As Boolean
    'tells us if the mod is playing.
    On Error Goto errorhandler
    If modPlugInitialized = False Then
        ModPlugPlaying = False
        Exit Function
    End If
    a = ModPlug_IsPlaying(modPlugID)
    If a = 1 Then
        ModPlugPlaying = True
    Else
        ModPlugPlaying = False
    End If

    Exit Function

'Begin error handling code:
errorhandler:
    Call HandleError()
    Resume Next
End Function

Sub ModPlugStop()
    'stops the mod
    '(does not destroy mod plug instance)
    'Stop the plugin.
    On Error Goto errorhandler
    x = ModPlug_Stop(modPlugID)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError()
    Resume Next
End Sub



Attribute VB_Name = "transEvents"
'=========================================================================
'All contents copyright 2004, Colin James Fitzpatrick (KSNiloc)
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=========================================================================

'=========================================================================
' Interface with actkrt3.dll :: event processor
' Status: A+
'=========================================================================

Option Explicit

'=========================================================================
' Public declarations
'=========================================================================
Public Declare Sub endProgram Lib "actkrt3.dll" ()
Public Declare Sub processEvent Lib "actkrt3.dll" ()

'=========================================================================
' Member declarations
'=========================================================================
Private Declare Sub TKShowEndForm Lib "actkrt3.dll" Alias "showEndForm" (ByVal endFormBackHdc As Long, ByVal x As Long, ByVal y As Long, ByVal hIcon As Long, ByVal hInstance As Long)
Private Declare Sub createEventCallbacks Lib "actkrt3.dll" (ByVal forceRender As Long, ByVal closeSystems As Long, ByVal setAsciiKeyState As Long, ByVal keyDownEvent As Long, ByVal mouseMoveEvent As Long, ByVal mouseDownEvent As Long, ByVal isShuttingDown As Long, ByVal getGameState As Long, ByVal setGameState As Long)

'=========================================================================
' Public variables
'=========================================================================
Public bShowEndForm As Boolean      'Show the end form?

'=========================================================================
' Initiate the event processor
'=========================================================================
Public Sub initEventProcessor()
    On Error GoTo failed
    Call createEventCallbacks( _
                                 AddressOf forceRender, _
                                 AddressOf closeSystems, _
                                 AddressOf setAsciiKeyState, _
                                 AddressOf keyDownEvent, _
                                 AddressOf mouseMoveEvent, _
                                 AddressOf mouseDownEvent, _
                                 AddressOf isShuttingDown, _
                                 AddressOf getGameState, _
                                 AddressOf setGameState _
                                                          )
    Exit Sub
failed:
    Call MsgBox("Failed to initiate the trans3 event processor! Make sure you have the latest actkrt3.dll file! (September 17, 2004)")
    End
End Sub

'=========================================================================
' Allows actkrt3.dll to force a render
'=========================================================================
Private Sub forceRender()
    Call DXRefresh
End Sub

'=========================================================================
' Allows actkrt3.dll to check if we're shutting down
'=========================================================================
Private Function isShuttingDown() As Long
    If (gShuttingDown) Then isShuttingDown = 1
End Function

'=========================================================================
' Allows actkrt3.dll to get the game state
'=========================================================================
Private Function getGameState() As Long
    getGameState = gGameState
End Function

'=========================================================================
' Allows actkrt3.dll to set the game state
'=========================================================================
Private Sub setGameState(ByVal newState As Long)
    gGameState = newState
End Sub

'=========================================================================
' Show the end form
'=========================================================================
Public Sub showEndForm(Optional ByVal endProgram As Boolean = True)

    On Error Resume Next

    If (bShowEndForm) Then
        'Show the end form
        Call TKShowEndForm( _
                              endFormBackgroundHDC, _
                              ((Screen.width - (340 * Screen.TwipsPerPixelX)) \ 2) \ Screen.TwipsPerPixelX, _
                              ((Screen.height - (140 * Screen.TwipsPerPixelY)) \ 2) \ Screen.TwipsPerPixelY, _
                              statusBar.Icon.handle, _
                              App.hInstance _
                                              )
    End If

    If (endProgram) Then
        'End the program!
        Call DeleteDC(endFormBackgroundHDC)
        End
    End If

End Sub

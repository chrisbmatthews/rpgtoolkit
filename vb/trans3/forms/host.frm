VERSION 5.00
Begin VB.Form host 
   BorderStyle     =   0  'None
   ClientHeight    =   2085
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   2850
   Icon            =   "host.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   139
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   190
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.Timer redraw 
      Enabled         =   0   'False
      Interval        =   1
      Left            =   720
      Top             =   480
   End
End
Attribute VB_Name = "host"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

Option Explicit

Private Sub Form_GotFocus()
    '! ADDED BY KSNiloc !
    gGameState = gPrevGameState
    If globalCanvasWidth <> 0 Then
        renderNow
    End If
    redraw.Enabled = False
End Sub

Private Sub Form_KeyDown(keyCode As Integer, Shift As Integer)
    On Error Resume Next
    Call keyDownEvent(keyCode, Shift)
End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)
    keyAsciiState = KeyAscii
End Sub

Private Sub Form_LostFocus()
    '! ADDED BY KSNiloc !
    gPrevGameState = gGameState
    gGameState = GS_PAUSE
    redraw.Enabled = True
End Sub

Private Sub Form_MouseDown(button As Integer, Shift As Integer, X As Single, Y As Single)
    Call mouseDownEvent(X, Y, Shift, button)
End Sub

Private Sub Form_MouseMove(button As Integer, Shift As Integer, X As Single, Y As Single)
    Call mouseMoveEvent(X, Y)
End Sub

Private Sub Form_Resize()
    On Error Resume Next
    If gGameState <> GS_PAUSE Then
        'minimizing...
        gPrevGameState = gGameState
        gGameState = GS_PAUSE
    Else
        'restoring...
        gGameState = gPrevGameState
        Form_GotFocus
    End If
End Sub

Private Sub Form_Unload(Cancel As Integer)
    On Error Resume Next
    gGameState = GS_QUIT

    If (Not (gShuttingDown)) Then
        Call closeSystems
        host.Visible = False
        endform.Show 1
        End
    End If
    
    'If isFightInProgress() Or bInMenu Then
    '    Call closeSystems
    '    endform.Show 1
    '    End
    'End If
End Sub

Private Sub redraw_Timer()
    renderNow
End Sub

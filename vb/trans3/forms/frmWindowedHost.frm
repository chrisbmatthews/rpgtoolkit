VERSION 5.00
Begin VB.Form frmWindowedHost 
   BorderStyle     =   4  'Fixed ToolWindow
   Caption         =   "Windowed Host"
   ClientHeight    =   2085
   ClientLeft      =   45
   ClientTop       =   285
   ClientWidth     =   2850
   Icon            =   "frmWindowedHost.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   139
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   190
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
End
Attribute VB_Name = "frmWindowedHost"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

Option Explicit

Private Sub Form_GotFocus()
    gGameState = gPrevGameState
End Sub

Private Sub Form_KeyDown(keyCode As Integer, Shift As Integer)
    Call keyDownEvent(keyCode, Shift)
End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)
    keyAsciiState = KeyAscii
End Sub

Private Sub Form_LostFocus()
    gPrevGameState = gGameState
    gGameState = GS_PAUSE
End Sub

Private Sub Form_MouseDown(button As Integer, Shift As Integer, X As Single, Y As Single)
    Call mouseDownEvent(X, Y, Shift, button)
End Sub

Private Sub Form_MouseMove(button As Integer, Shift As Integer, X As Single, Y As Single)
    Call mouseMoveEvent(X, Y)
End Sub

Private Sub Form_Resize()
    Call hostFormResize
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Call hostFormUnload(Cancel)
End Sub


VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CBoardEditor"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'========================================================================
'All contents copyright 2006 Jonathan D. Hughes
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'========================================================================
Option Explicit

Public topX As Long                          'top x coord (scaled pixels)
Public topY As Long                          'top y coord (scaled pixels)
Public zoom As Double                        'scaling factor

Public Sub screenToBoardPixel(ByRef x As Long, ByRef y As Long)
    x = (x + topX) / zoom
    y = (y + topY) / zoom
End Sub
Public Sub boardPixelToScreen(ByRef x As Long, ByRef y As Long)
    x = x * zoom - topX
    y = y * zoom - topY
End Sub
Private Sub Class_Initialize()
    zoom = 1
End Sub

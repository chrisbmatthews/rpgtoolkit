Attribute VB_Name = "transClock"
'=========================================================================
'All contents copyright 2004, Colin James Fitzpatrick (KSNiloc)
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=========================================================================

'=========================================================================
' Trans clock sync procedures
'=========================================================================

Option Explicit

'=========================================================================
' Member declarations
'=========================================================================
Private Declare Function GetTickCount Lib "kernel32" () As Long

'=========================================================================
' Member variables
'=========================================================================
Private m_clock As Double

'=========================================================================
' Start the clock
'=========================================================================
Public Sub clockStart()
    'Get the tick count
    m_clock = GetTickCount()
End Sub

'=========================================================================
' Sync clock to certain fps
'=========================================================================
Public Sub clockSync()
    Do While (GetTickCount() - m_clock) < (1000 / RENDER_FPS)
        'This is a nothing loop; we are NOT going
        'to process events in this loop because it
        'has to be very accurate
    Loop
End Sub

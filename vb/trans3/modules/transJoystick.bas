Attribute VB_Name = "transJoystick"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'jostick scanning functions
Option Explicit

Public Const MAXPNAMELEN = 32

' The JOYINFOEX user-defined type contains extended information about the joystick position,
' point-of-view position, and button state.
Type JOYINFOEX
   dwSize As Long                      ' size of structure
   dwFlags As Long                     ' flags to indicate what to return
   dwXpos As Long                      ' x position
   dwYpos As Long                      ' y position
   dwZpos As Long                      ' z position
   dwRpos As Long                      ' rudder/4th axis position
   dwUpos As Long                      ' 5th axis position
   dwVpos As Long                      ' 6th axis position
   dwButtons As Long                   ' button states
   dwButtonNumber As Long              ' current button number pressed
   dwPOV As Long                       ' point of view state
   dwReserved1 As Long                 ' reserved for communication between winmm driver
   dwReserved2 As Long                 ' reserved for future expansion
End Type

' The JOYCAPS user-defined type contains information about the joystick capabilities
Type JOYCAPS
   wMid As Integer                     ' Manufacturer identifier of the device driver for the MIDI output device
                                       ' For a list of identifiers, see the Manufacturer Indentifier topic in the
                                       ' Multimedia Reference of the Platform SDK.
   
   wPid As Integer                     ' Product Identifier Product of the MIDI output device. For a list of
                                       ' product identifiers, see the Product Identifiers topic in the Multimedia
                                       ' Reference of the Platform SDK.
   szPname As String * MAXPNAMELEN     ' Null-terminated string containing the joystick product name
   wXmin As Long                       ' Minimum X-coordinate.
   wXmax As Long                       ' Maximum X-coordinate.
   wYmin As Long                       ' Minimum Y-coordinate
   wYmax As Long                       ' Maximum Y-coordinate
   wZmin As Long                       ' Minimum Z-coordinate
   wZmax As Long                       ' Maximum Z-coordinate
   wNumButtons As Long                 ' Number of joystick buttons
   wPeriodMin As Long                  ' Smallest polling frequency supported when captured by the joySetCapture function.
   wPeriodMax As Long                  ' Largest polling frequency supported when captured by the joySetCapture function.
   wRmin As Long                       ' Minimum rudder value. The rudder is a fourth axis of movement.
   wRmax As Long                       ' Maximum rudder value. The rudder is a fourth axis of movement.
   wUmin As Long                       ' Minimum u-coordinate (fifth axis) values.
   wUmax As Long                       ' Maximum u-coordinate (fifth axis) values.
   wVmin As Long                       ' Minimum v-coordinate (sixth axis) values.
   wVmax As Long                       ' Maximum v-coordinate (sixth axis) values.
   wCaps As Long                       ' Joystick capabilities as defined by the following flags
                                       '     JOYCAPS_HASZ-     Joystick has z-coordinate information.
                                       '     JOYCAPS_HASR-     Joystick has rudder (fourth axis) information.
                                       '     JOYCAPS_HASU-     Joystick has u-coordinate (fifth axis) information.
                                       '     JOYCAPS_HASV-     Joystick has v-coordinate (sixth axis) information.
                                       '     JOYCAPS_HASPOV-   Joystick has point-of-view information.
                                       '     JOYCAPS_POV4DIR-  Joystick point-of-view supports discrete values (centered, forward, backward, left, and right).
                                       '     JOYCAPS_POVCTS Joystick point-of-view supports continuous degree bearings.
   wMaxAxes As Long                    ' Maximum number of axes supported by the joystick.
   wNumAxes As Long                    ' Number of axes currently in use by the joystick.
   wMaxButtons As Long                 ' Maximum number of buttons supported by the joystick.
   szRegKey As String * MAXPNAMELEN    ' String containing the registry key for the joystick.
End Type

Declare Function joyGetPosEx Lib "winmm.dll" (ByVal uJoyID As Long, pji As JOYINFOEX) As Long
' This function queries a joystick for its position and button status. The function
' requires the following parameters;
'     uJoyID-  integer identifying the joystick to be queried. Use the constants
'              JOYSTICKID1 or JOYSTICKID2 for this value.
'     pji-     user-defined type variable that stores extended position information
'              and button status of the joystick. The information returned from
'              this function depends on the flags you specify in dwFlags member of
'              the user-defined type variable.
'
' The function returns the constant JOYERR_NOERROR if successful or one of the
' following error values:
'     MMSYSERR_NODRIVER-      The joystick driver is not present.
'     MMSYSERR_INVALPARAM-    An invalid parameter was passed.
'     MMSYSERR_BADDEVICEID-   The specified joystick identifier is invalid.
'     JOYERR_UNPLUGGED-       The specified joystick is not connected to the system.

Declare Function joyGetDevCaps Lib "winmm.dll" Alias "joyGetDevCapsA" (ByVal id As Long, lpCaps As JOYCAPS, ByVal uSize As Long) As Long
' This function queries a joystick to determine its capabilities. The function requires
' the following parameters:
'     uJoyID-  integer identifying the joystick to be queried. Use the contstants
'              JOYSTICKID1 or JOYSTICKID2 for this value.
'     pjc-     user-defined type variable that stores the capabilities of the joystick.
'     cbjc-    Size, in bytes, of the pjc variable. Use the Len function for this value.
' The function returns the constant JOYERR_NOERROR if a joystick is present or one of
' the following error values:
'     MMSYSERR_NODRIVER-   The joystick driver is not present.
'     MMSYSERR_INVALPARAM- An invalid parameter was passed.


Public Const JOYSTICKID1 = 0
Public Const JOYSTICKID2 = 1
Public Const JOY_RETURNBUTTONS = &H80&
Public Const JOY_RETURNCENTERED = &H400&
Public Const JOY_RETURNPOV = &H40&
Public Const JOY_RETURNR = &H8&
Public Const JOY_RETURNU = &H10
Public Const JOY_RETURNV = &H20
Public Const JOY_RETURNX = &H1&
Public Const JOY_RETURNY = &H2&
Public Const JOY_RETURNZ = &H4&
Public Const JOY_RETURNALL = (JOY_RETURNX Or JOY_RETURNY Or JOY_RETURNZ Or JOY_RETURNR Or JOY_RETURNU Or JOY_RETURNV Or JOY_RETURNPOV Or JOY_RETURNBUTTONS)
Public Const JOYCAPS_HASZ = &H1&
Public Const JOYCAPS_HASR = &H2&
Public Const JOYCAPS_HASU = &H4&
Public Const JOYCAPS_HASV = &H8&
Public Const JOYCAPS_HASPOV = &H10&
Public Const JOYCAPS_POV4DIR = &H20&
Public Const JOYCAPS_POVCTS = &H40&
Public Const JOYERR_BASE = 160
Public Const JOYERR_UNPLUGGED = (JOYERR_BASE + 7)

Public Const JOY_BUTTON1 = &H1
Public Const JOY_BUTTON10 = &H200&
Public Const JOY_BUTTON11 = &H400&
Public Const JOY_BUTTON12 = &H800&
Public Const JOY_BUTTON13 = &H1000&
Public Const JOY_BUTTON14 = &H2000&
Public Const JOY_BUTTON15 = &H4000&
Public Const JOY_BUTTON16 = &H8000&
Public Const JOY_BUTTON17 = &H10000
Public Const JOY_BUTTON18 = &H20000
Public Const JOY_BUTTON19 = &H40000
Public Const JOY_BUTTON1CHG = &H100
Public Const JOY_BUTTON2 = &H2
Public Const JOY_BUTTON20 = &H80000
Public Const JOY_BUTTON22 = &H200000
Public Const JOY_BUTTON21 = &H100000
Public Const JOY_BUTTON23 = &H400000
Public Const JOY_BUTTON24 = &H800000
Public Const JOY_BUTTON25 = &H1000000
Public Const JOY_BUTTON26 = &H2000000
Public Const JOY_BUTTON27 = &H4000000
Public Const JOY_BUTTON28 = &H8000000
Public Const JOY_BUTTON29 = &H10000000
Public Const JOY_BUTTON2CHG = &H200
Public Const JOY_BUTTON3 = &H4
Public Const JOY_BUTTON30 = &H20000000
Public Const JOY_BUTTON31 = &H40000000
Public Const JOY_BUTTON32 = &H80000000
Public Const JOY_BUTTON3CHG = &H400
Public Const JOY_BUTTON4 = &H8
Public Const JOY_BUTTON4CHG = &H800
Public Const JOY_BUTTON5 = &H10&
Public Const JOY_BUTTON6 = &H20&
Public Const JOY_BUTTON7 = &H40&
Public Const JOY_BUTTON8 = &H80&
Public Const JOY_BUTTON9 = &H100&


'for getting the os version...
Public Declare Function GetVersionExA Lib "kernel32" _
            (lpVersionInformation As OSVERSIONINFO) As Integer

Public Type OSVERSIONINFO
   dwOSVersionInfoSize As Long
   dwMajorVersion As Long
   dwMinorVersion As Long
   dwBuildNumber As Long
   dwPlatformId As Long
   szCSDVersion As String * 128
End Type

Public Const WINVER_NT_PLATFORM = 2

Public Function getWinVersion() As String
    Dim osinfo As OSVERSIONINFO
    Dim retvalue As Integer

    osinfo.dwOSVersionInfoSize = 148
    osinfo.szCSDVersion = space$(128)
    retvalue = GetVersionExA(osinfo)

    With osinfo
        Select Case .dwPlatformId
            Case 1
                If .dwMinorVersion = 0 Then
                    getWinVersion = "Windows 95"
                ElseIf .dwMinorVersion = 10 Then
                    getWinVersion = "Windows 98"
                End If
            Case 2
                If .dwMajorVersion = 3 Then
                    getWinVersion = "Windows NT 3.51"
                ElseIf .dwMajorVersion = 4 Then
                    getWinVersion = "Windows NT 4.0"
                ElseIf .dwMajorVersion = 5 Then
                    getWinVersion = "Windows 2000"
                End If
            Case Else
                 getWinVersion = "Failed"
        End Select
    End With
End Function

Function joyDirection(ByRef buttonOnOff() As Boolean) As Integer
    'gets joystick direction state.
    'returns:
    '0 no direction
    '1-e
    '2-ne
    '3-n
    '4-nw
    '5-w
    '6-sw
    '7-s
    '8-se
    'also sets button on/off array to true if button idx is pressed.
    On Error GoTo errorhandler
    
    Dim ji As JOYINFOEX     ' joystick state buffer
    Dim caps As JOYCAPS     ' joystick capabilities
    Dim rc As Long          ' return code
    Dim i As Long           ' index
    Dim mask As Long        ' bitmask
    Dim numAxes As Long     ' number of axes added to form
    Dim axisY As Long       ' Y value for current axis control being added
    Const ySpacingFactor = 1.4  ' spacing between controls
   
    ' Initialize struct
    ji.dwSize = Len(ji)
    ji.dwFlags = JOY_RETURNALL
   
    ' Get the current joystick data
    rc = joyGetPosEx(JOYSTICKID1, ji)
   
    ' Display the status
    If (rc) Then
        useJoystick = False
        Exit Function
    End If
         
    'get button info:
    
    Dim masks() As Long
    masks(0) = JOY_BUTTON1
    masks(1) = JOY_BUTTON2
    masks(2) = JOY_BUTTON3
    masks(3) = JOY_BUTTON4
    For mask = 0 To 3
        buttonOnOff(mask) = (ji.dwButtons And masks(mask))
    Next mask
    
    Dim toReturn As Long
    Dim xaxis As Long
    Dim yaxis As Long
    
    toReturn = 0
    joyDirection = toReturn
    'get direction info:
    xaxis = ji.dwXpos
    yaxis = ji.dwYpos
       
    If (numWithin(xaxis, 60000, 67000)) _
        And numWithin(yaxis, 30000, 37000) Then
        'e
        toReturn = 1
    End If
    If (numWithin(xaxis, 60000, 67000)) _
        And numWithin(yaxis, 0, 1000) Then
        'ne
        toReturn = 2
    End If
    If (numWithin(xaxis, 30000, 37000)) _
        And numWithin(yaxis, 0, 1000) Then
        'n
        toReturn = 3
    End If
    If (numWithin(xaxis, 0, 1000)) _
        And numWithin(yaxis, 0, 1000) Then
        'nw
        toReturn = 4
    End If
    If (numWithin(xaxis, 0, 1000)) _
        And numWithin(yaxis, 30000, 37000) Then
        'w
        toReturn = 5
    End If
    If (numWithin(xaxis, 0, 1000)) _
        And numWithin(yaxis, 60000, 67000) Then
        'sw
        toReturn = 6
    End If
    If (numWithin(xaxis, 30000, 37000)) _
        And numWithin(yaxis, 60000, 67000) Then
        's
        toReturn = 7
    End If
    If (numWithin(xaxis, 60000, 67000)) _
        And numWithin(yaxis, 60000, 67000) Then
        'se
        toReturn = 8
    End If
    joyDirection = toReturn

    Exit Function

'Begin error handling code:
errorhandler:
    
    Resume Next
End Function


Function JoyTest() As Boolean
    'see if we can setup joystick...
        
    'check if we're running windows nt...
    Dim osinfo As OSVERSIONINFO
    Dim retvalue As Integer
    
    osinfo.dwOSVersionInfoSize = 148
    osinfo.szCSDVersion = space$(128)
    retvalue = GetVersionExA(osinfo)
    
    With osinfo
    Select Case .dwPlatformId
       Case 2
            'windows nt...
            'JoyTest = False
            'Exit Function
    End Select
    End With
    
    ' Get capabilities of joystick1
    Dim caps As JOYCAPS     ' joystick capabilities
    Dim rc As Long
    rc = joyGetDevCaps(JOYSTICKID1, caps, Len(caps))
    JoyTest = (rc = 0)

End Function

Function numWithin(ByVal num1 As Double, ByVal low As Double, ByVal high As Double) As Boolean
    'returns true or false if number is withing
    'certain bounds.
    On Error GoTo errorhandler
    If num1 >= low And num1 <= high Then
        numWithin = True
        Exit Function
    End If
    numWithin = False

    Exit Function

'Begin error handling code:
errorhandler:
    
    Resume Next
End Function



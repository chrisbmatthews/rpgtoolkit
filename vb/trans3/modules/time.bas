Attribute VB_Name = "transTime"
'=========================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=========================================================================

'=========================================================================
' Procedures for controlling day and night
'=========================================================================

'=========================================================================
' Night begins to set at 4pm
' Night sets at 8pm
' At that point, it is really nighttime
' Day begins to rise at 4am
' Day arrives at 8am
' From 8pm-4am it is as dark as it can be
' From 8am-4am is is as light as it can be
'=========================================================================

Option Explicit

'=========================================================================
' Declarations
'=========================================================================
Public Declare Function GetTickCount Lib "kernel32" () As Long

'=========================================================================
' Integral variables
'=========================================================================
Public addTime As Long      ' Time to add onto mainForm timer (for continued games)
Public initTime As Long     ' Time at start of game

'=========================================================================
' Return the light level
'=========================================================================
Public Function DetermineLightLevel() As Integer

    On Error GoTo errorhandler

    Dim theTime As Long
    
    Dim tod As Long
    tod = TimeOfDay()
    
    theTime = tod \ 60 \ 60
    
    'if it's before 4am, it's really dark out...
    If theTime <= 4 Then
        DetermineLightLevel = -100
        Exit Function
    End If
    
    'if it's after 8pm, it's really dark out...
    If theTime >= 20 Then
        DetermineLightLevel = -100
        Exit Function
    End If
    
    'if it's between 8am and 4pm, it's really light out...
    If theTime >= 8 And theTime <= 16 Then
        DetermineLightLevel = 0
        Exit Function
    End If
    
    'if it's between 4am and 8 am, it's becoming gradually lighter...
    If theTime >= 4 And theTime <= 8 Then
        DetermineLightLevel = Int(0.007 * tod - 200)
        Exit Function
    End If
    
    'if it's between 4pm and 8pm, it's becoming gradually darker...
    If theTime >= 16 And theTime <= 20 Then
        DetermineLightLevel = Int(-0.007 * tod + 400)
        Exit Function
    End If
    
    Exit Function
'Begin error handling code:
errorhandler:
    
    Resume Next
End Function

'=========================================================================
' Returns whether it is night
'=========================================================================
Public Function IsNight() As Boolean

    Dim theTime As Long
    
    theTime = TimeOfDay()
    theTime = theTime \ 60 \ 60
    If theTime > 20 Then
        IsNight = True
        Exit Function
    End If
    
    If theTime < 8 Then
        IsNight = True
        Exit Function
    End If
    
    IsNight = False
End Function

'=========================================================================
' Returns the time of day in seconds
'=========================================================================
Public Function TimeOfDay() As Long

    Dim secondsInADay As Long
    Dim dayTime As Long
    
    If mainMem.mainDayNightType = 0 Then
        'linked to the real world
        TimeOfDay = Timer()
    Else
        'based upon an n-minute day
        If mainMem.mainDayLength > 0 Then
            secondsInADay = mainMem.mainDayLength * 60
            dayTime = gameTime Mod secondsInADay
            dayTime = (dayTime / secondsInADay) * 86400
            TimeOfDay = dayTime
        Else
            TimeOfDay = Timer()
        End If
    End If
End Function

'=========================================================================
' Update length of game
'=========================================================================
Public Sub updateGameTime()
    On Error Resume Next
    gameTime = (Timer() - initTime) + addTime
End Sub

Attribute VB_Name = "time"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'functions for day and night
'night begins to set at 4pm
'night sets at 8pm
'at that point, it is really nighttime
'day begins to rise at 4am
'day arrives at 8am
'from 8pm-4am it is as dark as it can be
'from 8am-4am is is as light as it can be

Option Explicit

Public addTime As Long          'time to add onto mainForm timer (for continued games)
Public initTime As Long         'time at start of game

Function DetermineLightLevel() As Integer
    'returns a value between -255 and 0 to indicate how light/dark it is
    'based upon the time of day.
    On Error GoTo errorhandler
    Dim theTime As Long
    
    Dim tod As Long
    tod = TimeOfDay()
    
    theTime = tod / 60 / 60
    
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
    Call HandleError
    Resume Next
End Function

Function IsNight() As Boolean
    'determines if it is after 8pm and before 8am
    Dim theTime As Long
    
    theTime = TimeOfDay()
    theTime = theTime / 60 / 60
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

Function TimeOfDay() As Long
    'return the 'time of day' in seconds.
    'this time is based upon:
    '1- the actual time, if the mainForm file indicates that day and night are linked to the real world
    '2- the time based upon an x-minute long day, where x is the length of a day indicated in the mainForm file

    Dim secondsInADay As Long
    Dim dayTime As Long
    
    If mainMem.mainDayNightType = 0 Then
        'linked to the real world
        TimeOfDay = Timer
    Else
        'based upon an n-minute day
        If mainMem.mainDayLength > 0 Then
            secondsInADay = mainMem.mainDayLength * 60
            dayTime = gameTime Mod secondsInADay
            dayTime = (dayTime / secondsInADay) * 86400
            TimeOfDay = dayTime
        Else
            TimeOfDay = Timer
        End If
    End If
End Function


Sub updateGameTime()
    On Error Resume Next
    'update count of game length
    gameTime = (Timer - initTime) + addTime
End Sub



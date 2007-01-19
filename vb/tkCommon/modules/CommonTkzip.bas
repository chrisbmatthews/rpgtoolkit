Attribute VB_Name = "Commontkzip"
'========================================================================
' The RPG Toolkit, Version 3
' This file copyright (C) 2007 Christopher Matthews & contributors
'
' Contributors:
'    - Colin James Fitzpatrick
'========================================================================
'
' This program is free software; you can redistribute it and/or
' modify it under the terms of the GNU General Public License
' as published by the Free Software Foundation; either version 2
' of the License, or (at your option) any later version.
'
' This program is distributed in the hope that it will be useful,
' but WITHOUT ANY WARRANTY; without even the implied warranty of
' MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
' GNU General Public License for more details.
'
'========================================================================

'=========================================================================
' Interface with actkrt3.dll :: zip files
'=========================================================================

Option Explicit

'=========================================================================
' Declarations for actkrt3.dll's zip exports
'=========================================================================
Private Declare Function ZIPTest Lib "actkrt3.dll" () As Long
Public Declare Function ZIPClose Lib "actkrt3.dll" () As Long

'=========================================================================
' Initiate the PAK file system
'=========================================================================
Public Function PAKTestSystem() As Boolean
    'test pakfile system
    On Error GoTo pakErr
    
    Call ZIPTest
    PAKTestSystem = True
    Exit Function
    
pakErr:
    Call MsgBox("The file tkzip.dll could not be initialised.  You likely need to download the MFC runtimes.  You can get them at http://rpgtoolkit.com")

End Function

'=========================================================================
' Return the location of a file in a PAK file
'=========================================================================
Public Function PakLocate(ByVal file As String) As String

    On Error Resume Next

    #If isToolkit = 1 Then
        Dim pakFileRunning As Boolean
    #End If

    If Not (pakFileRunning) Then
        'hup! We're not even mounted onto a pakfile!
        '(we're running straight off the disk)
        PakLocate = file
        Exit Function
    End If

    'first, look for the file in the cache.
    'if it's found in the cache, return it's location.
    'else, obtain it from the pakfile, put it in the cache and
    'return its location

    #If isToolkit = 0 Then
        PakLocate = PakTempPath & file
    #End If

End Function

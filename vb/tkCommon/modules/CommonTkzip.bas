Attribute VB_Name = "Commontkzip"
'=========================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=========================================================================

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
    Call MsgBox("The file tkzip.dll could not be initialised.  You likely need to download the MFC runtimes.  You can get then at http://rpgtoolkit.com")

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
    
        If fileExists(PakTempPath & file) Then
            PakLocate = PakTempPath & file
        Else
            Call ZIPExtract(file, PakTempPath & file)
            PakLocate = PakTempPath & file
        End If
        
    #End If

End Function

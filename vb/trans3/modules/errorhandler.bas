Attribute VB_Name = "errorhandler"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

Option Explicit

'KSNiloc says...
Public handleErrors As Boolean

Sub HandleError()
    'universal runtime error handler!
    'On Error GoTo errorhandler
    'call tracestring("A Runtime error has occurred... " + _
            "Code:" + str$(Err.number) + _
            " Description: " + Err.description)
    'If Err.number = 0 Then
    '    Exit Sub
    'End If

    'KSNiloc says...
    'If Not handleErrors Then Exit Sub
    'If debugYN = 0 Or errorBranch <> "" Then Exit Sub
    
    'Call MsgBox("A Runtime error has occurred..." + chr$(13) + chr$(10) + _
            "Code:" + str$(Err.number) + chr$(13) + chr$(10) + _
            "Description: " + Err.Description + chr$(13) + chr$(10) + _
            chr$(13) + chr$(10) + _
            "You can continue working without any problems.  But, you may wish to report this bug at http://rpgtoolkit.com", , _
            "RPG Toolkit Safety Net")

    'If Err.number = 7 Then
    '    'out of memory-- bail
    '    gGameState = GS_QUIT
    'End If
    'Exit Sub
'Begin error handling code:
'errorhandler:
'
'    Resume Next
End Sub



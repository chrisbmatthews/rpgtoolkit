Attribute VB_Name = "errorhandler"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

Option Explicit

'=======================================================
'Cleaned up a bit, 3.0.4 by KSNiloc
'
' ---What is done
' + Option Explicit added
' + &s used rather than +s for strings
'
'=======================================================

Public Sub HandleError()
    'universal runtime error handler!
    Call traceString("A Runtime error has occurred... " & _
            "Code:" & str$(Err.number) & _
            " Description: " & Err.description)
End Sub

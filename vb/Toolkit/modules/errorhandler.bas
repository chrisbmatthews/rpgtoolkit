Attribute VB_Name = "errorhandler"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Sub HandleError()
    'universal runtime error handler!
    Call traceString("A Runtime error has occurred... " + _
            "Code:" + str$(Err.number) + _
            " Description: " + Err.Description)
    'Call MsgBox("A Runtime error has occurred..." + Chr$(13) + Chr$(10) + _
            "Code:" + Str$(Err.number) + Chr$(13) + Chr$(10) + _
            "Description: " + Err.description + Chr$(13) + Chr$(10) + _
            Chr$(13) + Chr$(10) + _
            "You can continue working without any problems.  But, you may wish to report this bug at http://rpgtoolkit.com" + Chr$(13) + Chr$(10) + Chr$(13) + Chr$(10) + _
            "Please provide a detailed description of how you produced this bug along with the error code and description.", , _
            "RPG Toolkit Safety Net")
End Sub



Attribute VB_Name = "modMisc"
'====================================================================================
'RPGToolkit3 Default Battle System
'====================================================================================
'All contents copyright 2004, Colin James Fitzpatrick
'====================================================================================
'YOU MAY NOT REMOVE THIS NOTICE!
'====================================================================================

'====================================================================================
'Misc Functions
'====================================================================================

Option Explicit

Public Sub Plugin_Initialize()
    resX = CBGetGeneralNum(GEN_RESX, 0, 0)
    resY = CBGetGeneralNum(GEN_RESY, 0, 0)
End Sub

Public Function Plugin_Version() As String
    Plugin_Version = "2.0.0"
End Function

Public Function Plugin_Description() As String
    Plugin_Description = "Fully featured TK3 battle system"
End Function

Public Function plugType(ByVal request As Long) As Boolean
    If request = PT_FIGHT Then plugType = True
End Function

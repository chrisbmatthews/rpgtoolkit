Attribute VB_Name = "CommonTKAudiere"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'audiere interface

Option Explicit

Public Declare Sub TKAudiereInit Lib "actkrt3.dll" ()
Public Declare Sub TKAudiereKill Lib "actkrt3.dll" ()
Public Declare Function TKAudierePlay Lib "actkrt3.dll" (ByVal handle As Long, ByVal filename As String, ByVal streamYN As Long, ByVal autoRepeatYN As Long) As Long
Public Declare Function TKAudiereIsPlaying Lib "actkrt3.dll" (ByVal handle As Long) As Long
Public Declare Sub TKAudiereStop Lib "actkrt3.dll" (ByVal handle As Long)
Public Declare Sub TKAudiereRestart Lib "actkrt3.dll" (ByVal handle As Long)
Public Declare Sub TKAudiereDestroyHandle Lib "actkrt3.dll" (ByVal handle As Long)
Public Declare Function TKAudiereCreateHandle Lib "actkrt3.dll" () As Long
Public Declare Function TKAudiereGetPosition Lib "actkrt3.dll" (ByVal handle As Long) As Long
Public Declare Sub TKAudiereSetPosition Lib "actkrt3.dll" (ByVal handle As Long, ByVal pos As Long)

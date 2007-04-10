Attribute VB_Name = "CommonTKAudiere"
'========================================================================
' The RPG Toolkit, Version 3
' This file copyright (C) 2007 Christopher B. Matthews
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

Attribute VB_Name = "CommonXpStyles"
'========================================================================
' The RPG Toolkit, Version 3
' This file copyright (C) 2007 Colin James Fitzpatrick
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
' Windows XP Styles
'=========================================================================

Option Explicit

'=======================================================================
' Declarations
'=======================================================================
Private Declare Function InitCommonControlsEx Lib "comctl32.dll" (ByRef iccex As tagInitCommonControlsEx) As Boolean

'=======================================================================
' Common controls structure
'=======================================================================
Private Type tagInitCommonControlsEx
   lngSize As Long
   lngICC As Long
End Type

'=======================================================================
' Constants
'=======================================================================
Private Const ICC_USEREX_CLASSES = &H200

'=======================================================================
' Initiate the common controls
'=======================================================================
Public Function initCommonControls() As Boolean
    On Error Resume Next
    Dim iccex As tagInitCommonControlsEx
    iccex.lngSize = LenB(iccex)
    iccex.lngICC = ICC_USEREX_CLASSES
    Call InitCommonControlsEx(iccex)
    initCommonControls = (err.number = 0)
End Function

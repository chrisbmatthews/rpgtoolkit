Attribute VB_Name = "CommonXpStyles"
'=========================================================================
' All contents copyright 2005, Colin James Fitzpatrick
' All rights reserved. YOU MAY NOT REMOVE THIS NOTICE
' Read LICENSE.txt for licensing info
'=========================================================================

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
    initCommonControls = (Err.number = 0)
End Function

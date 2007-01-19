VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CBoardSprite"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'========================================================================
' The RPG Toolkit, Version 3
' This file copyright (C) 2007 Jonathan D. Hughes
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

Option Explicit
    
Public filename As String                    'Sprite filename (inc. path from project path).
Public x As Long                             'Location.
Public y As Long
Public layer As Long
Public activate As Long                      'SPR_ACTIVE - always active.
                                             'SPR_CONDITIONAL - conditional activation.
Public initialVar As String                  'Activation variable.
Public finalVar As String                    'Activation variable at end of activation prg.
Public initialValue As String                'Initial value of activation variable.
Public finalValue As String                  'Value of variable after activation prg runs.
Public loadingVar As String                  'Variable checked before showing item on board.
Public loadingValue As String                'Value loadingVar must be to show item.
Public activationType As Long                'Activation type: SPR_STEP
                                             '                 SPR_KEYPRESS
Public prgActivate As String                 'Program to run when sprite is activated.
Public prgMultitask As String                'Multitask program for sprite.
 
'Public boardPath As CVector                 'Path from the board that the sprite is moving along.
                                             '(see SPR_BRDPATH, trans3)

'=========================================================================
' Copy "constructor"
'=========================================================================
Public Sub copy(ByRef rhs As CBoardSprite) ':on error resume next
    
    rhs.activate = activate
    rhs.activationType = activationType
    rhs.x = x
    rhs.y = y
    Call activeBoard.spriteUpdateImageData(rhs, filename, False)
    rhs.filename = filename
    rhs.finalValue = finalValue
    rhs.finalVar = finalVar
    rhs.initialValue = initialValue
    rhs.initialVar = initialVar
    rhs.loadingValue = loadingValue
    rhs.loadingVar = loadingVar
    rhs.layer = layer
    rhs.prgActivate = prgActivate
    rhs.prgMultitask = prgMultitask
    
End Sub

Public Sub moveBy(ByVal dx As Long, ByVal dy As Long): On Error Resume Next
    x = x + dx
    y = y + dy
    Call activeBoard.spriteUpdateImageData(Me, filename, True)
End Sub

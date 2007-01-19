VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CBoardProgram"
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

Public filename As String                    'Board program filename.
Public layer As Long                         'Layer.
Public graphic As String                     'Associated graphic tbd: depreciate?
Public activate As Long                      'PRG_ACTIVE - always active.
                                             'PRG_CONDITIONAL - conditional activation.
Public initialVar As String                  'Activation variable.
Public finalVar As String                    'Activation variable at end of prg.
Public initialValue As String                'Initial value of activation variable.
Public finalValue As String                  'Value of variable after program runs.
Public activationType As Long                'Activation type (PRG_ flags).

Public vBase As New CVector                  'The activation area.
Public distanceRepeat As Long                'Distance to travel between activations within the vector.

Public Sub draw(ByRef pic As PictureBox, ByRef pCEd As CBoardEditor, ByVal color As Long, ByVal bShowIndices As Boolean) ': on error resume next
    Dim p1 As POINTAPI, p2 As POINTAPI, oldColor As Long

    oldColor = pic.ForeColor
    pic.ForeColor = color
    Call vBase.draw(pic, pCEd, color, bShowIndices)
    
    'Centre filename in middle of vector area.
    If filename <> vbNullString Then
        Call vBase.getBounds(p1.x, p1.y, p2.x, p2.y)
        Call pCEd.boardPixelToScreen(p1.x, p1.y)
        Call pCEd.boardPixelToScreen(p2.x, p2.y)
        pic.currentX = (p1.x + p2.x - pic.TextWidth(filename)) / 2
        pic.currentY = (p1.y + p2.y - pic.TextHeight(filename)) / 2
        pic.Print filename
    End If
    pic.ForeColor = oldColor
    
End Sub

'=========================================================================
' Copy "constructor"
'=========================================================================
Public Sub copy(ByRef rhs As CBoardProgram) ':on error resume next

    rhs.filename = filename
    rhs.activate = activate
    rhs.activationType = activationType
    rhs.distanceRepeat = distanceRepeat
    rhs.finalValue = finalValue
    rhs.finalVar = finalVar
    rhs.initialValue = initialValue
    rhs.initialVar = initialVar
    rhs.layer = layer
    Set rhs.vBase = New CVector
    Call vBase.copy(rhs.vBase)

End Sub

Public Sub setSelection(ByRef sel As CBoardSelection): On Error Resume Next
    Call vBase.setSelection(sel)
End Sub
Public Sub moveSelectionBy(ByVal dx As Long, ByVal dy As Long): On Error Resume Next
    Call vBase.moveSelectionBy(dx, dy)
End Sub
Public Sub moveBy(ByVal dx As Long, ByVal dy As Long): On Error Resume Next
    Call vBase.moveSelectionBy(dx, dy, True)
End Sub

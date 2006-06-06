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
'All contents copyright 2006 Jonathan D. Hughes
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
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

Public Sub draw(ByRef pic As PictureBox, ByRef pCEd As CBoardEditor, ByVal color As Long) ': on error resume next
    Dim p1 As POINTAPI, p2 As POINTAPI

    Call vBase.draw(pic, pCEd, color)
    
    'Centre filename in middle of vector area.
    If filename <> vbNullString Then
        Call vBase.getBounds(p1.x, p1.y, p2.x, p2.y)
        Call pCEd.boardPixelToScreen(p1.x, p1.y)
        Call pCEd.boardPixelToScreen(p2.x, p2.y)
        pic.currentX = (p1.x + p2.x - pic.TextWidth(filename)) / 2
        pic.currentY = (p1.y + p2.y - pic.TextHeight(filename)) / 2
        pic.Print filename
    End If
    
End Sub

Public Sub tbApply(ByRef ctl As ctlBrdProgram) ':on error resume next
    
    filename = ctl.getTxtFilename.Text
    layer = val(ctl.getTxtLayer.Text)
    activate = Abs(ctl.getOptConditionallyActive(PRG_CONDITIONAL).value)
    initialVar = ctl.getTxtConditionVars(0).Text
    initialValue = ctl.getTxtConditionVars(1).Text
    finalVar = ctl.getTxtConditionVars(2).Text
    finalValue = ctl.getTxtConditionVars(3).Text
    activationType = Abs(ctl.getOptActivationType(PRG_KEYPRESS).value)
    If ctl.getChkRepeatTrigger.value Then activationType = activationType Or PRG_REPEAT
    If ctl.getChkActivationStopsMove.value Then activationType = activationType Or PRG_STOPS_MOVEMENT
    distanceRepeat = val(ctl.getTxtRepeatTrigger)
    Call vBase.lvApply(ctl.getLvPoints)
    
End Sub

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

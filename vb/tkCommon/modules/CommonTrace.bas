Attribute VB_Name = "CommonTrace"
'========================================================================
' The RPG Toolkit, Version 3
' This file copyright (C) 2007 Christopher Matthews & contributors
'
' Contributors:
'    - Colin James Fitzpatrick
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
' All-purpose program flow tracer
'=========================================================================

Option Explicit

'=========================================================================
' Integral variables
'=========================================================================

#Const enableTracer = False         'tracer is enabled?

#If (enableTracer) Then
Private traceFile As String         'file to save to
Private isTracing As Boolean        'are we tracing?
#End If

'=========================================================================
' Begin tracing to the file passed in
'=========================================================================
Public Sub StartTracing(ByVal file As String)

    On Error Resume Next

#If (enableTracer) Then
    traceFile = file
    isTracing = True
    Call Kill(traceFile)
    Dim tf As Long
    tf = FreeFile()
    Open traceFile For Append As #tf
    Print #tf, "Tracing..."
    Close #tf
#End If

End Sub

'=========================================================================
' Stop tracing
'=========================================================================
Public Sub StopTracing()
    On Error Resume Next
#If (enableTracer) Then
    If isTracing Then
        isTracing = False
    End If
#End If
End Sub

'=========================================================================
' Write the text passed in to the tracing file
'=========================================================================
Public Sub traceString(ByVal Text As String)
    On Error Resume Next
#If (enableTracer) Then
    If isTracing Then
        Dim tf As Long
        tf = FreeFile()
        Open traceFile For Append As #tf
        Print #tf, Text
        Close #tf
    End If
#End If
End Sub

'=========================================================================
' Save data in prg for analizing
'=========================================================================
#If (isToolkit = 0) And (enableTracer) Then
Public Sub traceProgram(ByRef prg As RPGCodeProgram, ByVal file As String)

    Dim line As String
    Dim ff As Long
    Dim a As Long

    ff = FreeFile()
    Open file For Output As ff
        For a = 0 To UBound(prg.program)
            line = prg.program(a)
            If a = prg.programPos Then line = line & "  ** Current Line"
            Print #ff, line
        Next a
        Print #ff, vbNullString
        Print #ff, prg.programPos
    Close ff

End Sub
#End If

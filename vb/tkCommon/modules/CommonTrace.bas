Attribute VB_Name = "CommonTrace"
'=========================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=========================================================================

'=========================================================================
' All-purpose program flow tracer
'=========================================================================

Option Explicit

'=========================================================================
' Integral variables
'=========================================================================

#Const enableTracer = True         'tracer is enabled?

#If (enableTracer) Then
    Private traceFile As String     'file to save to
    Private isTracing As Boolean    'are we tracing?
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
    Public Sub traceProgram(ByRef prg As RPGCodeProgram, ByVal file As String, ByVal silent As Boolean)

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
            Print #ff, ""
            Print #ff, prg.programPos
        Close ff

        If Not silent Then MsgBox "Program traced successfully saved in " & file & "."

    End Sub
#End If

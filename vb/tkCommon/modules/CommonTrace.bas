Attribute VB_Name = "CommonTrace"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'trace routines for tracing flow of program for debugging
'dumps results into trace.txt

Option Explicit

#Const enableTracer = 0

#If enableTracer = 1 Then
    Private traceFile As String
    Private isTracing As Boolean
#End If

Public Sub StartTracing(ByVal file As String)

    On Error Resume Next
    
    #If enableTracer = 1 Then
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

Public Sub StopTracing()
    On Error Resume Next
    #If enableTracer = 1 Then
        If isTracing Then
            isTracing = False
        End If
    #End If
End Sub

Public Sub traceString(ByVal Text As String)
    'write text to the trace file
    On Error Resume Next
    #If enableTracer = 1 Then
        If isTracing Then
            Dim tf As Long
            tf = FreeFile()
            Open traceFile For Append As #tf
            Print #tf, Text
            Close #tf
        End If
    #End If
End Sub

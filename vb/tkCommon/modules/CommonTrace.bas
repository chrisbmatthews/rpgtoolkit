Attribute VB_Name = "CommonTrace"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'trace routines for tracing flow of program for debugging
'dumps results into trace.txt
Option Explicit

Private traceFile As String   'trace file id
Private isTracing As Boolean

Private Const enableTracer As Boolean = False
Sub StartTracing(ByVal file As String)
    On Error Resume Next
    
    If enableTracer Then
        traceFile = file
        isTracing = True
        
        Kill traceFile
        
        Dim tf As Long
        tf = FreeFile
        Open traceFile For Append As #tf
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
        Print #tf, "Tracing..."
        Close #tf
    End If
End Sub


Sub StopTracing()
    On Error Resume Next
    If enableTracer Then
        If isTracing Then
            'Close #traceFile
            isTracing = False
        End If
    End If
End Sub


Sub traceString(ByVal text As String)
    'write text to the trace file
    On Error Resume Next
    If enableTracer Then
        If isTracing Then
            'Print #traceFile, text
        
            Dim tf As Long
            tf = FreeFile
            Open traceFile For Append As #tf
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
            Print #tf, text
            Close #tf
        End If
    End If
End Sub



Attribute VB_Name = "trace"
'trace routines for tracing flow of program for debugging
'dumps results into trace.txt

Private traceFile As String   'trace file id
Private isTracing As Boolean

Private Const enableTracer As Boolean = False
Sub StartTracing(ByVal file As String)
    On Error Resume Next
    
    If enableTracer Then
        traceFile = file
        isTracing = True
        
        Kill traceFile
        
        tf = FreeFile
        Open traceFile For Append As #tf
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


Function traceString(ByVal text As String)
    'write text to the trace file
    On Error Resume Next
    If enableTracer Then
        If isTracing Then
            'Print #traceFile, text
        
            tf = FreeFile
            Open traceFile For Append As #tf
            Print #tf, text
            Close #tf
        End If
    End If
End Function



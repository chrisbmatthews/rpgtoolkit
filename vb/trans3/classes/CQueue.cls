VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CQueue"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'=========================================================================
' All contents copyright 2005, Colin James Fitzpatrick
' All rights reserved. YOU MAY NOT REMOVE THIS NOTICE.
' Read LICENSE.txt for licensing info
'=========================================================================

'=========================================================================
' Queue
'=========================================================================

Option Explicit

'=========================================================================
' Declarations
'=========================================================================
Private Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" (ByRef lpVoidDest As Any, ByRef lpVoidSource As Any, ByVal lngByteLength As Long)

'=========================================================================
' Members
'=========================================================================
Private m_queue() As Long   ' The queue
Private m_len As Long       ' Length of queue

'=========================================================================
' Constructor
'=========================================================================
Private Sub Class_Initialize(): On Error Resume Next

    ' Make a huge array
    ReDim m_queue(64)

End Sub

'=========================================================================
' Clear the queue
'=========================================================================
Public Sub clear(): On Error Resume Next
    ' Just redim again
    ReDim m_queue(64)
    m_len = 0
End Sub

'=========================================================================
' Queue a value
'=========================================================================
Public Sub queue(ByVal lngQueue As Long): On Error Resume Next
    On Error GoTo error
    m_queue(m_len) = lngQueue
    m_len = m_len + 1
    Exit Sub
error:
    ReDim m_queue(m_len + 64)
    Resume
End Sub

'=========================================================================
' Dequeue a value
'=========================================================================
Public Function dequeue() As Long: On Error Resume Next
    If (m_len) Then
        m_len = m_len - 1
        dequeue = m_queue(m_len)
        m_queue(m_len) = 0
        If (m_len) Then
            Call CopyMemory(m_queue(0), m_queue(1), 4 * m_len)
        End If
    End If
End Function

'=========================================================================
' Obtain the top value
'=========================================================================
Public Function Top() As Long: On Error Resume Next
    Top = m_queue(m_len - 1)
End Function

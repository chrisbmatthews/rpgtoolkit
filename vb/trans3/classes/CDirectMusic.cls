VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CDirectMusic"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'=========================================================================
' All contents copyright 2004, Colin James Fitzpatrick
' All rights reserved. YOU MAY NOT REMOVE THIS NOTICE.
' Read LICENSE.txt for licensing info
'=========================================================================

'=========================================================================
' CDirectMusic - Encapuslates DirectMusic
'=========================================================================

Option Explicit

'=========================================================================
' Members
'=========================================================================
Private m_performance As DirectMusicPerformance       ' A performance
Private m_segment As DirectMusicSegment               ' A segment
Private m_segmentState As DirectMusicSegmentState     ' A segment state
Private m_loader As DirectMusicLoader                 ' Loads files

'=========================================================================
' Constructor
'=========================================================================
Private Sub Class_Initialize()

    ' Create a DirectX object
    Dim dx7 As DirectX7
    Set dx7 = New DirectX7

    ' Create a loader
    Set m_loader = dx7.DirectMusicLoaderCreate()

    ' Create a performance
    Set m_performance = dx7.DirectMusicPerformanceCreate()

    ' Initiate the performance
    Call m_performance.Init(Nothing, 0)

    ' Set to the default port
    Call m_performance.SetPort(-1, 80)

    ' Set to automatically download instruments
    Call m_performance.SetMasterAutoDownload(True)

End Sub

'=========================================================================
' Set volume
'=========================================================================
Public Sub setVolume(ByVal lngPercent As Long)

    ' Make sure the volume is a real percent
    If (lngPercent < 0) Then lngPercent = 0
    If (lngPercent > 100) Then lngPercent = 100

    ' Set the volume
    Call m_performance.SetMasterVolume(lngPercent * 42 - 3000)

End Sub

'=========================================================================
' Play a MIDI
'=========================================================================
Public Sub playMidi(ByRef strFilename As String, Optional ByVal bLoopMidi As Boolean = True)

    ' Use the loader to create a segment
    Set m_segment = m_loader.LoadSegment(strFilename)

    ' Set the format to MIDI
    Call m_segment.SetStandardMidiFile

    ' If we should loop
    If (bLoopMidi) Then

        ' Set it to loop
        Call m_segment.SetRepeats(2147483647) ' [ Infinite repeats ]

    End If

    ' Play the segment
    Set m_segmentState = m_performance.PlaySegment(m_segment, 0, 0)

End Sub

'=========================================================================
' Stop a MIDI
'=========================================================================
Public Sub stopMidi()

    ' If a MIDI is loaded
    If Not (m_segment Is Nothing) Then

        ' Stop the segment
        Call m_performance.Stop(m_segment, m_segmentState, 0, 0)

        Do While (m_performance.isPlaying(m_segment, m_segmentState))
            ' Do not proceed until segment has fully stopped
        Loop

        ' Kill the segment
        Call m_segment.Unload(m_performance)

    End If

End Sub

'=========================================================================
' Determine if DirectMusic is playing a MIDI
'=========================================================================
Public Function isPlaying() As Boolean

    ' If a MIDI is loaded
    If Not (m_segment Is Nothing) Then

        ' Return whether it's playing
        isPlaying = m_performance.isPlaying(m_segment, m_segmentState)

    End If

End Function

'=========================================================================
' Deconstructor
'=========================================================================
Private Sub Class_Terminate()

    ' Close down the performance
    Call m_performance.CloseDown

End Sub

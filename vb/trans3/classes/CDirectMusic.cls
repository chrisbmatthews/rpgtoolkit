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
' A DirectMusic structure
'=========================================================================
Private Type DIRECT_MUSIC
    dx7 As DirectX7                             ' A DirectX object
    performance As DirectMusicPerformance       ' A performance
    segment As DirectMusicSegment               ' A segment
    segmentState As DirectMusicSegmentState     ' A segment state
    loader As DirectMusicLoader                 ' Loads files
End Type

'=========================================================================
' Members
'=========================================================================
Private m_directMusic As DIRECT_MUSIC           ' DirectMusic stuff

'=========================================================================
' Constructor
'=========================================================================
Private Sub Class_Initialize()

    ' Create the main DirectX object
    Set m_directMusic.dx7 = New DirectX7

    ' Create a loader
    Set m_directMusic.loader = m_directMusic.dx7.DirectMusicLoaderCreate()

    ' Create a performance
    Set m_directMusic.performance = m_directMusic.dx7.DirectMusicPerformanceCreate()

    ' Initiate the performance
    Call m_directMusic.performance.Init(Nothing, 0)

    ' Set to the default port
    Call m_directMusic.performance.SetPort(-1, 80)

    ' Set to automatically download instruments
    Call m_directMusic.performance.SetMasterAutoDownload(True)

End Sub

'=========================================================================
' Set volume
'=========================================================================
Public Sub setVolume(ByVal lngPercent As Long)

    ' Make sure the volume is a real percent
    If (lngPercent < 0) Then lngPercent = 0
    If (lngPercent > 100) Then lngPercent = 100

    ' Set the volume
    Call m_directMusic.performance.SetMasterVolume(lngPercent * 42 - 3000)

End Sub

'=========================================================================
' Play a MIDI
'=========================================================================
Public Sub playMidi(ByRef strFilename As String, Optional ByVal bLoopMidi As Boolean = True)

    ' Use the loader to create a segment
    Set m_directMusic.segment = m_directMusic.loader.LoadSegment(strFilename)

    ' Set the format to MIDI
    Call m_directMusic.segment.SetStandardMidiFile

    ' If we should loop
    If (bLoopMidi) Then

        ' Set it to loop
        Call m_directMusic.segment.SetRepeats(2147483647) ' [ Infinite repeats ]

    End If

    ' Play the segment
    Set m_directMusic.segmentState = _
        m_directMusic.performance.PlaySegment(m_directMusic.segment, 0, 0)

End Sub

'=========================================================================
' Stop a MIDI
'=========================================================================
Public Sub stopMidi()

    ' If a MIDI is loaded
    If Not (m_directMusic.segment Is Nothing) Then

        ' Stop the segment
        Call m_directMusic.performance.Stop( _
            m_directMusic.segment, m_directMusic.segmentState, 0, 0)

        ' Kill the segment
        Set m_directMusic.segment = Nothing

    End If

End Sub

'=========================================================================
' Determine if DirectMusic is playing a MIDI
'=========================================================================
Public Function isPlaying() As Boolean

    ' If a MIDI is loaded
    If Not (m_directMusic.segment Is Nothing) Then

        ' Return whether it's playing
        isPlaying = m_directMusic.performance.isPlaying( _
            m_directMusic.segment, m_directMusic.segmentState)

    End If

End Function

'=========================================================================
' Deconstructor
'=========================================================================
Private Sub Class_Terminate()

    ' Close down the performance
    Call m_directMusic.performance.CloseDown

End Sub

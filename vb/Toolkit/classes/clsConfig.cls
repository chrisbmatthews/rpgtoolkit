VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsConfig"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'=========================================================================
'All contents copyright 2004, Colin James Fitzpatrick
'All rights reserved  YOU MAY NOT REMOVE THIS NOTICE
'Read LICENSEtxt for licensing info
'=========================================================================

'=========================================================================
' Toolkit configuration file format
'=========================================================================

'=========================================================================
' VB option settings
'=========================================================================
Option Compare Binary
Option Explicit
Option Base 0

'=========================================================================
' Public variables
'=========================================================================
Public tipsOnOff As Integer
Public tipFile As String
Public tipNum As Long
Public commandsDocked As Integer
Public filesDocked As Integer
Public lastProject As String
Public wallpaper As String
Public tutCurrentLesson As Integer
Public lastTileset As String

'=========================================================================
' Member variables
'=========================================================================
Private m_quickEnabled(4) As Integer
Private m_quickTarget(4) As String
Private m_quickIcon(4) As String

'=========================================================================
' Private constants
'=========================================================================
Private Const FILE_HEADER = "RPGToolkit3 Configuration File"
Private Const CONFIG_FILE = "toolkit.cfg"

'=========================================================================
' Public properties
'=========================================================================

Public Property Get quickEnabled(ByVal pos As Long) As Integer
    quickEnabled = m_quickEnabled(pos)
End Property
Public Property Let quickEnabled(ByVal pos As Long, ByVal newVal As Integer)
    m_quickEnabled(pos) = newVal
End Property

Public Property Get quickTarget(ByVal pos As Long) As String
    quickTarget = m_quickTarget(pos)
End Property
Public Property Let quickTarget(ByVal pos As Long, ByVal newVal As String)
    m_quickTarget(pos) = newVal
End Property

Public Property Get quickIcon(ByVal pos As Long) As String
    quickIcon = m_quickIcon(pos)
End Property
Public Property Let quickIcon(ByVal pos As Long, ByVal newVal As String)
    m_quickIcon(pos) = newVal
End Property

'=========================================================================
' Open the config file passed in
'=========================================================================
Private Sub openConfig(Optional ByVal file As String = CONFIG_FILE)

    On Error Resume Next
    
    Dim num As Long, a As Long
    num = FreeFile()
    m_LangFile = ""

    Open file For Binary Access Read As num
        If BinReadString(num) = FILE_HEADER Then
            tipsOnOff = BinReadInt(num)
            tipFile = BinReadString(num)
            tipNum = BinReadLong(num)
            commandsDocked = BinReadInt(num)
            filesDocked = BinReadInt(num)
            lastProject = BinReadString(num)
            mp3Path = BinReadString(num)
            wallpaper = BinReadString(num)
            For a = 0 To 4
                m_quickEnabled(a) = BinReadInt(num)
                m_quickTarget(a) = BinReadString(num)
                m_quickIcon(a) = BinReadString(num)
            Next a
            tutCurrentLesson = BinReadInt(num)
            m_LangFile = BinReadString(num)
            lastTileset = BinReadString(num)
        Else
            Close num
            Open file For Input As num
            Call fread(num)
            tipsOnOff = fread(num)
            tipFile = fread(num)
            tipNum = fread(num)
            Call fread(num)
            commandsDocked = fread(num)
            filesDocked = fread(num)
            lastProject = fread(num)
            mp3Path = fread(num)
            wallpaper = fread(num)
            For a = 0 To 4
                m_quickEnabled(a) = fread(num)
                m_quickTarget(a) = fread(num)
                m_quickIcon(a) = fread(num)
            Next a
            tutCurrentLesson = fread(num)
            m_LangFile = fread(num)
        End If
    Close num

    If wallpaper = "" Then
        wallpaper = "bkg.jpg"
    ElseIf wallpaper = "NONE" Then
        wallpaper = ""
    End If

End Sub

'=========================================================================
' Save up the config file
'=========================================================================
Public Sub saveConfig(Optional ByVal file As String = CONFIG_FILE)

    On Error Resume Next

    Dim num As Long
    num = FreeFile()
    
    If wallpaper = "" Then
        wallpaper = "NONE"
    End If

    Call Kill(file)
    Open file For Binary Access Write As num
        Call BinWriteString(num, FILE_HEADER)
        Call BinWriteInt(num, tipsOnOff)
        Call BinWriteString(num, tipFile)
        Call BinWriteLong(num, tipNum)
        Call BinWriteInt(num, commandsDocked)
        Call BinWriteInt(num, filesDocked)
        Call BinWriteString(num, lastProject)
        Call BinWriteString(num, mp3Path)
        Call BinWriteString(num, wallpaper)
        Dim a As Long
        For a = 0 To 4
            Call BinWriteInt(num, m_quickEnabled(a))
            Call BinWriteString(num, m_quickTarget(a))
            Call BinWriteString(num, m_quickIcon(a))
        Next a
        Call BinWriteInt(num, tutCurrentLesson)
        Call BinWriteString(num, m_LangFile)
        Call BinWriteString(num, lastTileset)
    Close num

End Sub

'=========================================================================
' Class constructor
'=========================================================================
Private Sub Class_Initialize()
    'Open the config file
    Call openConfig
End Sub

'=========================================================================
' Class deconstructor
'=========================================================================
Private Sub Class_Terminate()
    'Save up the config file
    Call saveConfig
End Sub

Attribute VB_Name = "CommonTKPlugin"
'=========================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=========================================================================

'=========================================================================
' Plugin routines
'=========================================================================

Option Explicit

'=========================================================================
' C++ plugin manager
'=========================================================================
Public Declare Function PLUGInitSystem Lib "actkrt3.dll" (cbArray As Long, ByVal cbArrayCount As Long) As Long
Public Declare Function PLUGShutdownSystem Lib "actkrt3.dll" () As Long
Public Declare Sub PLUGBegin Lib "actkrt3.dll" (ByVal plugFilename As String)
Public Declare Function PLUGQuery Lib "actkrt3.dll" (ByVal plugFilename As String, ByVal commandQuery As String) As Long
Public Declare Function PLUGExecute Lib "actkrt3.dll" (ByVal plugFilename As String, ByVal commandToExecute As String) As Long
Public Declare Sub PLUGEnd Lib "actkrt3.dll" (ByVal plugFilename As String)
Public Declare Function PLUGVersion Lib "actkrt3.dll" (ByVal plugFilename As String) As Long
Public Declare Function PLUGDescription Lib "actkrt3.dll" (ByVal plugFilename As String, ByVal strBuffer As String, ByVal bufferSize As Long) As Long
Public Declare Function plugType Lib "actkrt3.dll" Alias "PLUGType" (ByVal plugFilename As String, ByVal requestedFeature As Long) As Long
Public Declare Function PLUGMenu Lib "actkrt3.dll" (ByVal plugFilename As String, ByVal requestedMenu As Long) As Long
Public Declare Function PLUGFight Lib "actkrt3.dll" (ByVal plugFilename As String, ByVal enemyCount As Long, ByVal skilllevel As Long, ByVal backgroundFile As String, ByVal canrun As Long) As Long
Public Declare Function PLUGFightInform Lib "actkrt3.dll" (ByVal plugFilename As String, ByVal sourcePartyIndex As Long, ByVal sourceFighterIndex As Long, ByVal targetPartyIndex As Long, ByVal targetFighterIndex As Long, ByVal sourceHPLost As Long, ByVal sourceSMPLost As Long, ByVal targetHPLost As Long, ByVal targetSMPLost As Long, ByVal strMessage As String, ByVal attackCode As Long) As Long
Public Declare Function PLUGInputRequested Lib "actkrt3.dll" (ByVal plugFilename As String, ByVal inputCode As Long) As Long
Public Declare Function PLUGEventInform Lib "actkrt3.dll" (ByVal plugFilename As String, ByVal keyCode As Long, ByVal x As Long, ByVal Y As Long, ByVal Button As Long, ByVal Shift As Long, ByVal strKey As String, ByVal inputCode As Long) As Long

'=========================================================================
' Win32 APIs
'=========================================================================
Private Declare Function CreateProcessA Lib "kernel32" (ByVal lpApplicationName As Long, ByVal lpCommandLine As String, ByVal lpProcessAttributes As Long, ByVal lpThreadAttributes As Long, ByVal bInheritHandles As Long, ByVal dwCreationFlags As Long, ByVal lpEnvironment As Long, ByVal lpCurrentDirectory As Long, lpStartupInfo As STARTUPINFO, lpProcessInformation As PROCESS_INFORMATION) As Long
Private Declare Function CloseHandle Lib "kernel32" (ByVal hObject As Long) As Long
Private Declare Function WaitForSingleObject Lib "kernel32" (ByVal hHandle As Long, ByVal dwMilliseconds As Long) As Long
Private Declare Function GetExitCodeProcess Lib "kernel32" (ByVal hProcess As Long, lpExitCode As Long) As Long

'=========================================================================
' Plugin constants
'=========================================================================
Public Const PT_RPGCODE = 1                   'plugin type rpgcode
Public Const PT_MENU = 2                      'plugin type menu
Public Const PT_FIGHT = 4                     'plugin type battle system
Public Const MNU_MAIN = 1                     'main menu requested
Public Const MNU_INVENTORY = 2                'inventory menu requested
Public Const MNU_EQUIP = 4                    'equip menu requested
Public Const MNU_ABILITIES = 8                'abilities menu requested
Public Const INFORM_REMOVE_HP = 0             'hp was removed
Public Const INFORM_REMOVE_SMP = 1            'smp was removed
Public Const INFORM_SOURCE_ATTACK = 2         'source attacks
Public Const INFORM_SOURCE_SMP = 3            'source does special move
Public Const INFORM_SOURCE_ITEM = 4           'source uses item
Public Const INFORM_SOURCE_CHARGED = 5        'source is charged
Public Const INFORM_SOURCE_DEAD = 6           'source has died
Public Const INFORM_SOURCE_PARTY_DEFEATED = 7 'source party is all dead
Public Const INPUT_KB = 0                     'keyboard input code
Public Const INPUT_MOUSEDOWN = 1              'mouse down input code
Public Const FIGHT_RUN_AUTO = 0               'Player party ran - have trans apply the running progrma for us
Public Const FIGHT_RUN_MANUAL = 1             'Player party ran - tell trans that the plugin has already executed the run prg
Public Const FIGHT_WON_AUTO = 2               'Player party won - have trans apply the rewards for us
Public Const FIGHT_WON_MANUAL = 3             'Player party won - tell trans that the plugin has already given rewards
Public Const FIGHT_LOST = 4                   'Player party lost

'=========================================================================
' Win32 constants
'=========================================================================
Private Const NORMAL_PRIORITY_CLASS = &H20&
Private Const INFINITE = -1&

'=========================================================================
' Win32 startup info structure
'=========================================================================
Private Type STARTUPINFO
   cb As Long
   lpReserved As String
   lpDesktop As String
   lpTitle As String
   dwX As Long
   dwY As Long
   dwXSize As Long
   dwYSize As Long
   dwXCountChars As Long
   dwYCountChars As Long
   dwFillAttribute As Long
   dwFlags As Long
   wShowWindow As Integer
   cbReserved2 As Integer
   lpReserved2 As Long
   hStdInput As Long
   hStdOutput As Long
   hStdError As Long
End Type

'=========================================================================
' Win32 process information structure
'=========================================================================
Private Type PROCESS_INFORMATION
   hProcess As Long
   hThread As Long
   dwProcessID As Long
   dwThreadID As Long
End Type

'=========================================================================
' VB plugins manager
'=========================================================================
Public vbPlugins() As New CVbPlugin

'=========================================================================
' Get description of a plugin
'=========================================================================
Public Function pluginDescription(ByVal plugFile As String) As String

    On Error Resume Next

    If isVBPlugin(plugFile) Then
        pluginDescription = VBPlugin(plugFile).description
    Else
        Dim ret As String * 1025
        Dim le As Long
        le = PLUGDescription(plugFile, ret, 1025)
        pluginDescription = Mid(ret, 1, le)
    End If

End Function

'=========================================================================
' Get version of a plugin
'=========================================================================
Public Function pluginVersion(ByVal plugFile As String) As Long

    On Error Resume Next
    
    If isVBPlugin(plugFile) Then
        pluginVersion = VBPlugin(plugFile).version
    Else
        pluginVersion = PLUGVersion(plugFile)
    End If

End Function

'=========================================================================
' Setup a VB plugin
'=========================================================================
Public Sub setupVBPlugin(ByVal plugName As String)

    On Error Resume Next

    'Get the upper bound
    Dim ub As Long
    ub = UBound(vbPlugins)
    ub = ub + 1

    'Enlarge the array
    ReDim Preserve vbPlugins(ub)

    With vbPlugins(ub)

        'Create the object
        Set .obj = CreateObject(getObjectFromFile(plugName))

        'Setup the callbacks
        .obj.setCallbacks = New CVbPlugin

        'Record the filename
        .filename = plugName

    End With

End Sub

'=========================================================================
' Access a VB plugin by name (rather than index)
'=========================================================================
Public Function VBPlugin(ByVal plugName As String) As CVbPlugin

    On Error GoTo skipError

    Set VBPlugin = Nothing

    Dim a As Long
    For a = 0 To UBound(vbPlugins)
        If vbPlugins(a).filename = plugName Then
            Set VBPlugin = vbPlugins(a)
            Exit Function
        End If
    Next a

skipError:
End Function

'=========================================================================
' Determine if the plugin passed in is a VB plugin (true) or C++ (false)
'=========================================================================
Public Function isVBPlugin(ByVal plugName As String) As Boolean

    On Error Resume Next

    'See if it's already setup
    If Not VBPlugin(plugName) Is Nothing Then
        'Already setup!
        isVBPlugin = True
        Exit Function
    End If

    'See if we can create an object from this file
    Dim obj As Object
    Set obj = CreateObject(getObjectFromFile(plugName))

    'Do we have something?
    If Not obj Is Nothing Then
        Call setupVBPlugin(plugName)
        isVBPlugin = True
    End If

End Function

'=========================================================================
' Make a class from a filename
'=========================================================================
Private Function getObjectFromFile(ByVal filename As String) As String

    On Error Resume Next

    #If isToolkit = 1 Then
        'First (try to) register the file
        Call ExecCmd("regsvr32 /s " & filename)
    #End If

    'Remove the path from the file
    filename = RemovePath(filename)

    'Remove the extension
    getObjectFromFile = Left(filename, Len(filename) - 4)

    'Attach a class
    getObjectFromFile = getObjectFromFile & ".cls" & getObjectFromFile

End Function

'=========================================================================
' Wait for a command to finish
'=========================================================================
Public Sub ExecCmd(ByVal cmdline As String)

    Dim proc As PROCESS_INFORMATION
    Dim start As STARTUPINFO
    Dim ret As Long

    'Initialize the STARTUPINFO structure:
    start.cb = Len(start)

    'Start the shelled application:
    ret = CreateProcessA(0, cmdline, 0, 0, 1, _
    NORMAL_PRIORITY_CLASS, 0, 0, start, proc)

    'Wait for the shelled application to finish:
    ret = WaitForSingleObject(proc.hProcess, INFINITE)
    Call GetExitCodeProcess(proc.hProcess, ret)
    Call CloseHandle(proc.hThread)
    Call CloseHandle(proc.hProcess)

End Sub

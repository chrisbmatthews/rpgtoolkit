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
' Declarations
'=========================================================================
Public Declare Function PLUGInitSystem Lib "actkrt3.dll" (ByRef cbArray As Long, ByVal cbArrayCount As Long) As Long
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
Public Declare Function PLUGEventInform Lib "actkrt3.dll" (ByVal plugFilename As String, ByVal keyCode As Long, ByVal x As Long, ByVal y As Long, ByVal Button As Long, ByVal Shift As Long, ByVal strKey As String, ByVal inputCode As Long) As Long
Private Declare Function CallWindowProc Lib "user32" Alias "CallWindowProcA" (ByVal lpPrevWndFunc As Long, ByVal hWnd As Any, ByVal Msg As Any, ByVal wParam As Any, ByVal lParam As Any) As Long
Private Declare Function LoadLibrary Lib "kernel32" Alias "LoadLibraryA" (ByVal lpLibFileName As String) As Long
Private Declare Function FreeLibrary Lib "kernel32" (ByVal hLibModule As Long) As Long
Private Declare Function GetProcAddress Lib "kernel32" (ByVal hModule As Long, ByVal lpProcName As String) As Long

'=========================================================================
' Plugin constants
'=========================================================================
Public Const PT_RPGCODE = 1                   ' plugin type rpgcode
Public Const PT_MENU = 2                      ' plugin type menu
Public Const PT_FIGHT = 4                     ' plugin type battle system
Public Const MNU_MAIN = 1                     ' main menu requested
Public Const MNU_INVENTORY = 2                ' inventory menu requested
Public Const MNU_EQUIP = 4                    ' equip menu requested
Public Const MNU_ABILITIES = 8                ' abilities menu requested
Public Const INFORM_REMOVE_HP = 0             ' hp was removed
Public Const INFORM_REMOVE_SMP = 1            ' smp was removed
Public Const INFORM_SOURCE_ATTACK = 2         ' source attacks
Public Const INFORM_SOURCE_SMP = 3            ' source does special move
Public Const INFORM_SOURCE_ITEM = 4           ' source uses item
Public Const INFORM_SOURCE_CHARGED = 5        ' source is charged
Public Const INFORM_SOURCE_DEAD = 6           ' source has died
Public Const INFORM_SOURCE_PARTY_DEFEATED = 7 ' source party is all dead
Public Const INPUT_KB = 0                     ' keyboard input code
Public Const INPUT_MOUSEDOWN = 1              ' mouse down input code
Public Const FIGHT_RUN_AUTO = 0               ' Player party ran - have trans apply the running progrma for us
Public Const FIGHT_RUN_MANUAL = 1             ' Player party ran - tell trans that the plugin has already executed the run prg
Public Const FIGHT_WON_AUTO = 2               ' Player party won - have trans apply the rewards for us
Public Const FIGHT_WON_MANUAL = 3             ' Player party won - tell trans that the plugin has already given rewards
Public Const FIGHT_LOST = 4                   ' Player party lost

'=========================================================================
' Members
'=========================================================================
Private m_comPlugins() As CComPlugin

'=========================================================================
' Register or unregister a COM server
'=========================================================================
Public Sub registerServer(ByRef strServer As String, ByVal hWnd As Long, Optional ByVal bRegister As Boolean = True)

    ' First, make sure the file exists
    If (GetAttr(strServer) And vbDirectory) Then Exit Sub

    ' Load the server
    Dim pServer As Long
    pServer = LoadLibrary(strServer)

    ' Obtain the procedure address we want
    Dim pProc As Long
    pProc = GetProcAddress(pServer, IIf(bRegister, "DllRegisterServer", "DllUnregisterServer"))

    ' Call the procedure
    Call CallWindowProc(pProc, hWnd, 0&, 0&, 0&)

    ' Unload the server
    Call FreeLibrary(pServer)

End Sub

'=========================================================================
' Get description of a plugin
'=========================================================================
Public Function pluginDescription(ByVal plugFile As String) As String

    On Error Resume Next

    If (isComPlugin(plugFile)) Then
        pluginDescription = comPlugin(plugFile).description
    Else
        Dim ret As String * 1025
        Dim le As Long
        le = PLUGDescription(plugFile, ret, 1025)
        pluginDescription = Mid$(ret, 1, le)
    End If

End Function

'=========================================================================
' Decrement reference count on all COM plugins (set to nothing)
'=========================================================================
Public Sub releaseComPlugins()

    On Error GoTo skip

    ' Iterate over each plugin
    Dim idx As Long
    For idx = 0 To UBound(m_comPlugins)

        ' If there's an object here
        If Not (m_comPlugins(idx) Is Nothing) Then

            ' Release the plugin
            Set m_comPlugins(idx).obj = Nothing
            Set m_comPlugins(idx) = Nothing

        End If

    Next idx

skip:

    ' Redimension the plugins array
    ReDim m_comPlugins(0)

End Sub

'=========================================================================
' Get version of a plugin
'=========================================================================
Public Function pluginVersion(ByVal plugFile As String) As Long

    On Error Resume Next
    
    If (isComPlugin(plugFile)) Then
        pluginVersion = CLng(comPlugin(plugFile).version) ' Discard letters for now
    Else
        pluginVersion = PLUGVersion(plugFile)
    End If

End Function

'=========================================================================
' Setup a COM plugin
'=========================================================================
Public Sub setupComPlugin(ByVal plugName As String, Optional ByVal vendorIndependentId As String = vbNullString)

    On Error Resume Next

    ' Get the upper bound
    Dim ub As Long
    ub = UBound(m_comPlugins) + 1

    ' Enlarge the array
    ReDim Preserve m_comPlugins(ub)

    ' Create the object
    Set m_comPlugins(ub) = New CComPlugin

    With m_comPlugins(ub)

        ' Create the object
        If Not (IsMissing(vendorIndependentId)) Then
            Set .obj = CreateObject(vendorIndependentId)
        Else
            Set .obj = CreateObject(getObjectFromFile(plugName))
        End If

        ' Setup the callbacks
        .obj.setCallbacks = m_comPlugins(ub)

        ' Record the filename
        .filename = plugName

    End With

End Sub

'=========================================================================
' Access a COM plugin by name (rather than index)
'=========================================================================
Public Function comPlugin(ByVal plugName As String) As CComPlugin

    ' Bail on error: too risky to resume
    On Error GoTo skipError

    ' Default to returning nothing
    Set comPlugin = Nothing

    ' Iterate over each loaded COM plugin
    Dim idx As Long
    For idx = 0 To UBound(m_comPlugins)

        ' If this object is not NULL
        If Not (m_comPlugins(idx) Is Nothing) Then

            ' Check if it's the file we're looking for
            If (m_comPlugins(idx).filename = plugName) Then

                ' Return said object
                Set comPlugin = m_comPlugins(idx)
                Exit Function

            End If

        End If

    Next idx

skipError:
End Function

'=========================================================================
' Determine if the plugin passed in is a COM plugin
'=========================================================================
Public Function isComPlugin(ByVal plugName As String) As Boolean

    On Error Resume Next

    ' See if it's already setup
    If Not (comPlugin(plugName) Is Nothing) Then
        ' Already setup!
        isComPlugin = True
        Exit Function
    End If

    ' See if we can create an object from this file
    Dim obj As Object, vidid As String
    vidid = getObjectFromFile(plugName)
    Set obj = CreateObject(vidid)

    ' Do we have something?
    If Not (obj Is Nothing) Then
        Call setupComPlugin(plugName, vidid)
        isComPlugin = True
    End If

End Function

'=========================================================================
' Make a class from a filename
'=========================================================================
Private Function getObjectFromFile(ByVal filename As String) As String

    On Error Resume Next

    #If (isToolkit = 1) Then
        ' First (try to) register the file
        Call registerServer(filename, tkMainForm.hWnd, True)
    #End If

    ' Remove the path from the file
    filename = RemovePath(filename)

    ' Remove the extension
    getObjectFromFile = Left$(filename, Len(filename) - 4)

    ' Attach a class
    getObjectFromFile = getObjectFromFile & ".cls" & getObjectFromFile

End Function

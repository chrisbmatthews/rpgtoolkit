Attribute VB_Name = "CommonTKPlugin"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'routines for loading and talking to plugins
Option Explicit

'VERSION 3...

'APIs for the C++ plugin manager...
Declare Function PLUGInitSystem Lib "actkrt3.dll" (cbArray As Long, ByVal cbArrayCount As Long) As Long
Declare Function PLUGShutdownSystem Lib "actkrt3.dll" () As Long
Declare Sub PLUGBegin Lib "actkrt3.dll" (ByVal plugFilename As String)
Declare Function PLUGQuery Lib "actkrt3.dll" (ByVal plugFilename As String, ByVal commandQuery As String) As Long
Declare Function PLUGExecute Lib "actkrt3.dll" (ByVal plugFilename As String, ByVal commandToExecute As String) As Long
Declare Sub PLUGEnd Lib "actkrt3.dll" (ByVal plugFilename As String)
Declare Function PLUGVersion Lib "actkrt3.dll" (ByVal plugFilename As String) As Long
Declare Function PLUGDescription Lib "actkrt3.dll" (ByVal plugFilename As String, ByVal strBuffer As String, ByVal bufferSize As Long) As Long
Declare Function PLUGType Lib "actkrt3.dll" (ByVal plugFilename As String, ByVal requestedFeature As Long) As Long
Declare Function PLUGMenu Lib "actkrt3.dll" (ByVal plugFilename As String, ByVal requestedMenu As Long) As Long
Declare Function PLUGFight Lib "actkrt3.dll" (ByVal plugFilename As String, ByVal enemyCount As Long, ByVal skillLevel As Long, ByVal backgroundFile As String, ByVal canrun As Long) As Long
Declare Function PLUGFightInform Lib "actkrt3.dll" (ByVal plugFilename As String, ByVal sourcePartyIndex As Long, ByVal sourceFighterIndex As Long, ByVal targetPartyIndex As Long, ByVal targetFighterIndex As Long, ByVal sourceHPLost As Long, ByVal sourceSMPLost As Long, ByVal targetHPLost As Long, ByVal targetSMPLost As Long, ByVal strMessage As String, ByVal attackCode As Long) As Long
Declare Function PLUGInputRequested Lib "actkrt3.dll" (ByVal plugFilename As String, ByVal inputCode As Long) As Long
Declare Function PLUGEventInform Lib "actkrt3.dll" (ByVal plugFilename As String, ByVal keyCode As Long, ByVal x As Long, ByVal y As Long, ByVal button As Long, ByVal shift As Long, ByVal strKey As String, ByVal inputCode As Long) As Long

Public Const PT_RPGCODE = 1           'plugin type rpgcode
Public Const PT_MENU = 2         'plugin type menu
Public Const PT_FIGHT = 4         'plugin type battle system

Public Const MNU_MAIN = 1         'main menu requested
Public Const MNU_INVENTORY = 2     'inventory menu requested
Public Const MNU_EQUIP = 4         'equip menu requested
Public Const MNU_ABILITIES = 8     'abilities menu requested

Public Const INFORM_REMOVE_HP = 0   'hp was removed
Public Const INFORM_REMOVE_SMP = 1   'smp was removed
Public Const INFORM_SOURCE_ATTACK = 2   'source attacks
Public Const INFORM_SOURCE_SMP = 3   'source does special move
Public Const INFORM_SOURCE_ITEM = 4   'source uses item
Public Const INFORM_SOURCE_CHARGED = 5   'source is charged
Public Const INFORM_SOURCE_DEAD = 6 'source has died
Public Const INFORM_SOURCE_PARTY_DEFEATED = 7 'source party is all dead

Public Const INPUT_KB = 0   'keyboard input code
Public Const INPUT_MOUSEDOWN = 1   'mouse down input code

Public Const FIGHT_RUN_AUTO = 0                   'Player party ran - have trans apply the running progrma for us
Public Const FIGHT_RUN_MANUAL = 1                 'Player party ran - tell trans that the plugin has already executed the run prg
Public Const FIGHT_WON_AUTO = 2                   'Player party won - have trans apply the rewards for us
Public Const FIGHT_WON_MANUAL = 3                 'Player party won - tell trans that the plugin has already given rewards
Public Const FIGHT_LOST = 4                       'Player party lost

Function pluginDescription(ByVal plugFile As String) As String
    On Error Resume Next
    Dim ret As String * 1025
    Dim le As Long
    le = PLUGDescription(plugFile, ret, 1025)
    pluginDescription = Mid$(ret, 1, le)
End Function



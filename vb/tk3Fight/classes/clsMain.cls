VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsTk3Fight"
Attribute VB_GlobalNameSpace = True
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
'====================================================================================
'RPGToolkit3 Default Battle System
'====================================================================================
'All contents copyright 2004, Colin James Fitzpatrick
'====================================================================================
'YOU MAY NOT REMOVE THIS NOTICE!
'====================================================================================

'====================================================================================
'Main plugin entry point
'====================================================================================

Option Explicit

Public Sub Plugin_Initialize()
    modMisc.Plugin_Initialize
End Sub

Public Sub Plugin_Terminate()
    Call modMisc.Plugin_Terminate
End Sub

Public Function Plugin_Version() As String
    Plugin_Version = modMisc.Plugin_Version
End Function

Public Function Plugin_Description() As String
    Plugin_Description = modMisc.Plugin_Description
End Function

Public Function plugType(ByVal request As Long) As Boolean
    plugType = modMisc.plugType(request)
End Function

Public Function RPGCode_Query(ByVal commandName As String) As Boolean
    RPGCode_Query = False
End Function

Public Function RPGCode_Execute(ByVal commandLine As String, ByRef retValDT As Long, ByRef retValLit As String, ByRef retValNum As Double, ByVal usingReturnData As Boolean) As Boolean
    RPGCode_Execute = True
End Function

Public Function Menu(ByVal request As Long) As Long
    Menu = 0
End Function

Public Function fight( _
                         ByVal enemyCount As Long, _
                         ByVal skillLevel As Long, _
                         ByVal backgroundFile As String, _
                         ByVal canrun As Long _
                                                ) As Long
    fight = modBattleSystem.fight( _
                                     enemyCount, _
                                     skillLevel, _
                                     backgroundFile, _
                                     canrun _
                                              )
End Function

Public Function fightInform( _
                               ByVal sourcePartyIndex As Long, _
                               ByVal sourceFighterIndex As Long, _
                               ByVal targetPartyIndex As Long, _
                               ByVal targetFighterIndex As Long, _
                               ByVal sourceHPLost As Long, _
                               ByVal sourceSMPLost As Long, _
                               ByVal targetHPLost As Long, _
                               ByVal targetSMPLost As Long, _
                               ByVal strMessage As String, _
                               ByVal attackCode As Long _
                                                          ) As Long
    fightInform = modBattleSystem.fightInform( _
                                                 sourcePartyIndex, _
                                                 sourceFighterIndex, _
                                                 targetPartyIndex, _
                                                 targetFighterIndex, _
                                                 sourceHPLost, _
                                                 sourceSMPLost, _
                                                 targetHPLost, _
                                                 targetSMPLost, _
                                                 strMessage, _
                                                 attackCode _
                                                              )
End Function

Public Property Let setCallbacks(ByRef obj As Object)
    Set transPlugin = obj
End Property

Attribute VB_Name = "transMenu"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'run internal menu system
'depends on the menu plugin having been initialized

Option Explicit

Public bInMenu As Boolean   'currently running a menu?

Public Sub showMenu(Optional ByVal requestedMenu As Long = MNU_MAIN)
    'show menu system
    'version 3 menus run through plugins :)
    On Error Resume Next
   
    'quit if we're already shpwing the menu...
    If bInMenu Then Exit Sub
    If fightInProgress Then Exit Sub
   
    If mainMem.menuPlugin <> "" Then
        Dim aa As Long
       
        Dim plugName As String
        plugName = PakLocate(projectPath$ + pluginPath$ + mainMem.menuPlugin)
       
        ' ! MODIFIED BY KSNiloc...
        If isVBPlugin(plugName) Then
            aa = VBPlugin(plugName).PLUGType(PT_MENU)
        Else
            aa = PLUGType(plugName, PT_MENU)
        End If
       
        If aa = 1 Then
            Dim a As Long
            bInMenu = True
           
            ' ! MODIFIED BY KSNiloc...
            If isVBPlugin(plugName) Then
                a = VBPlugin(plugName).Menu(requestedMenu)
            Else
                a = PLUGMenu(plugName, requestedMenu)
            End If
           
            bInMenu = False
        End If
    End If
End Sub

Public Sub startMenuPlugin()
    'init menu plugin
    'InitPlugins must have been called first
    On Error Resume Next
    If mainMem.menuPlugin <> "" Then
        Dim plugName As String
        plugName = PakLocate(projectPath$ + pluginPath$ + mainMem.menuPlugin)
        ' ! MODIFIED BY KSNiloc...
        If isVBPlugin(plugName) Then
            VBPlugin(plugName).Initialize
        Else
            PLUGBegin plugName
        End If
    End If
End Sub

Public Sub stopMenuPlugin()
    'end menu plugin
    'InitPlugins must have been called first
    On Error Resume Next
    If mainMem.menuPlugin <> "" Then
        Dim plugName As String
        plugName = PakLocate(projectPath$ + pluginPath$ + mainMem.menuPlugin)
        ' ! MODIFIED BY KSNiloc...
        If isVBPlugin(plugName) Then
            VBPlugin(plugName).Terminate
        Else
            PLUGEnd plugName
        End If
    End If
End Sub

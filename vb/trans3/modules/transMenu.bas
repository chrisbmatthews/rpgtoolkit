Attribute VB_Name = "transMenu"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'run internal menu system
'depends on the menu plugin having been initialized

Option Explicit

Public bInMenu As Boolean   'currently running a menu?

Sub showMenu(Optional ByVal requestedMenu As Long = MNU_MAIN)
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
        
        aa = PLUGType(plugName, PT_MENU)
        If aa = 1 Then
            Dim a As Long
            bInMenu = True
            a = PLUGMenu(plugName, requestedMenu)
            bInMenu = False
            'Call WaitForKey
        End If
    End If
    'mainmenu.Show 1
End Sub


Sub startMenuPlugin()
    'init menu plugin
    'InitPlugins must have been called first
    On Error Resume Next
    If mainMem.menuPlugin <> "" Then
        Dim plugName As String
        plugName = PakLocate(projectPath$ + pluginPath$ + mainMem.menuPlugin)
        Call PLUGBegin(plugName)
    End If
End Sub

Sub stopMenuPlugin()
    'end menu plugin
    'InitPlugins must have been called first
    On Error Resume Next
    If mainMem.menuPlugin <> "" Then
        Dim plugName As String
        plugName = PakLocate(projectPath$ + pluginPath$ + mainMem.menuPlugin)
        Call PLUGEnd(plugName)
    End If
End Sub


Attribute VB_Name = "transMenu"
'=========================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=========================================================================

'=========================================================================
' Interface with menu plugin
' Status: A+
'=========================================================================

Option Explicit

'=========================================================================
' Globals
'=========================================================================

' Currently running a menu?
Public bInMenu As Boolean

'=========================================================================
' Shows the menu passed in
'=========================================================================
Public Sub showMenu(Optional ByVal requestedMenu As Long = MNU_MAIN)

    On Error Resume Next

    ' Quit if we're already showing the menu
    If ((bInMenu) Or (fightInProgress)) Then Exit Sub

    If LenB(mainMem.menuPlugin) <> 0 Then
    
        Dim isMenuPlugin As Long
        Dim plugName As String
        plugName = PakLocate(projectPath & plugPath & mainMem.menuPlugin)

        ' Determine if we have a menu plugin
        If isComPlugin(plugName) Then
            isMenuPlugin = comPlugin(plugName).plugType(PT_MENU)
        Else
            isMenuPlugin = plugType(plugName, PT_MENU)
        End If

        ' Yep-- we do
        If isMenuPlugin = 1 Then
            bInMenu = True
            If isComPlugin(plugName) Then
                Call comPlugin(plugName).menu(requestedMenu)
            Else
                Call PLUGMenu(plugName, requestedMenu)
            End If
            bInMenu = False
        End If
        
        Call renderNow(-1, True)

    End If

End Sub

'=========================================================================
' Initiates the menu plugin
'=========================================================================
Public Sub startMenuPlugin()
    On Error Resume Next
    If LenB(mainMem.menuPlugin) <> 0 Then
        Dim plugName As String
        plugName = PakLocate(projectPath & plugPath & mainMem.menuPlugin)
        If isComPlugin(plugName) Then
            Call comPlugin(plugName).Initialize
        Else
            Call PLUGBegin(plugName)
        End If
    End If
End Sub

'=========================================================================
' Terminates the menu plugin
'=========================================================================
Public Sub stopMenuPlugin()
    On Error Resume Next
    If (LenB(mainMem.menuPlugin) <> 0) Then
        Dim plugName As String
        plugName = PakLocate(projectPath & plugPath & mainMem.menuPlugin)
        If isComPlugin(plugName) Then
            Call comPlugin(plugName).Terminate
        Else
            Call PLUGEnd(plugName)
        End If
    End If
End Sub

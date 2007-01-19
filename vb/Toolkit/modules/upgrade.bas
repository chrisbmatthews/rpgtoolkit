Attribute VB_Name = "upgrade"
'========================================================================
' The RPG Toolkit, Version 3
' This file copyright (C) 2007 Christopher Matthews & contributors
'
' Contributors:
'    - Colin James Fitzpatrick
'    - Jonathan D. Hughes
'========================================================================
'
' This program is free software; you can redistribute it and/or
' modify it under the terms of the GNU General Public License
' as published by the Free Software Foundation; either version 2
' of the License, or (at your option) any later version.
'
' This program is distributed in the hope that it will be useful,
' but WITHOUT ANY WARRANTY; without even the implied warranty of
' MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
' GNU General Public License for more details.
'
'========================================================================

'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Function checkForArcPath() As Boolean
    On Error GoTo ErrorHandler
    tt$ = Dir(path$ + "*.", vbDirectory)
    t = 0
    Do While tt$ <> ""
        If UCase$(tt$) = "ARCHIVES" Then
            checkForArcPath = True
            Exit Function
        End If
        tt$ = Dir
    Loop
    checkForArcPath = False

    Exit Function

'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Function


Sub CopyDir(Source$, dest$)
    'copies files in directory source$ into dest$
On Error GoTo errcopy
    f$ = Dir$(Source$ + "*.*")
    Do While f$ <> ""
        FileCopy Source$ + f$, dest$ + f$
        f$ = Dir$
    Loop
    Exit Sub

errcopy:
End Sub

Sub DeleteOldFiles()
    'deletes files in old directory structure...
    On Error GoTo ErrorHandler
    Call KillDir(tilePath$)
    Call KillDir(brdPath$)
    Call KillDir(temPath$)
    Call KillDir(spcPath$)
    Call KillDir(bkgPath$)
    Call KillDir(mediaPath$)
    Call KillDir(prgPath$)
    Call KillDir(fontPath$)
    Call KillDir(itmPath$)
    Call KillDir(enePath$)
    Call KillDir(bmpPath$)
    Call KillDir("Archives\")

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Sub KillDir(thepath$)
    'deletes directory and all files in it.
On Error GoTo errkill
    f$ = Dir$(thepath$ + "*.*")
    Do While f$ <> ""
        Kill thepath$ + f$
        f$ = Dir$
    Loop
    RmDir (thepath$)
    Exit Sub

errkill:
End Sub

Sub moveFilesInto(thepath$)
    'moves all game files into a project path...
    'first, make the destination folders...
On Error Resume Next
    MkDir (thepath$)
    Call makeFolders(thepath$)
    'now to propogate the files into the new folders...
    upgradeform.status.Caption = "Upgrading " + tilePath$
    DoEvents
    Call CopyDir(tilePath$, thepath$ + tilePath$)
    upgradeform.status.Caption = "Upgrading " + brdPath$
    DoEvents
    Call CopyDir(brdPath$, thepath$ + brdPath$)
    upgradeform.status.Caption = "Upgrading " + temPath$
    DoEvents
    Call CopyDir(temPath$, thepath$ + temPath$)
    upgradeform.status.Caption = "Upgrading " + spcPath$
    DoEvents
    Call CopyDir(spcPath$, thepath$ + spcPath$)
    upgradeform.status.Caption = "Upgrading " + bkgPath$
    DoEvents
    Call CopyDir(bkgPath$, thepath$ + bkgPath$)
    upgradeform.status.Caption = "Upgrading " + mediaPath$
    DoEvents
    Call CopyDir(mediaPath$, thepath$ + mediaPath$)
    upgradeform.status.Caption = "Upgrading " + prgPath$
    DoEvents
    Call CopyDir(prgPath$, thepath$ + prgPath$)
    upgradeform.status.Caption = "Upgrading " + fontPath$
    DoEvents
    Call CopyDir(fontPath$, thepath$ + fontPath$)
    upgradeform.status.Caption = "Upgrading " + itmPath$
    DoEvents
    Call CopyDir(itmPath$, thepath$ + itmPath$)
    upgradeform.status.Caption = "Upgrading " + enePath$
    DoEvents
    Call CopyDir(enePath$, thepath$ + enePath$)
    upgradeform.status.Caption = "Upgrading " + bmpPath$
    DoEvents
    Call CopyDir(bmpPath$, thepath$ + bmpPath$)
    upgradeform.status.Caption = ""
   
    'mainoption.fileTree1.setPath (thepath$)
    'mainoption.fileTree1.pathRefresh

    oldpath$ = currentDir$ + "\" + projectPath$
    'mainoption.Dir1.path = currentdir$ + "\" + projectPath$
    Call tkMainForm.tvReset
End Sub



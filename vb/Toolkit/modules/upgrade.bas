Attribute VB_Name = "upgrade"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Function checkForArcPath() As Boolean
    On Error GoTo errorhandler
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
errorhandler:
    Call HandleError
    Resume Next
End Function


Sub CopyDir(source$, dest$)
    'copies files in directory source$ into dest$
On Error GoTo errcopy
    f$ = Dir$(source$ + "*.*")
    Do While f$ <> ""
        FileCopy source$ + f$, dest$ + f$
        f$ = Dir$
    Loop
    Exit Sub

errcopy:
End Sub

Sub DeleteOldFiles()
    'deletes files in old directory structure...
    On Error GoTo errorhandler
    Call KillDir(tilepath$)
    Call KillDir(brdpath$)
    Call KillDir(tempath$)
    Call KillDir(spcpath$)
    Call KillDir(bkgpath$)
    Call KillDir(mediapath$)
    Call KillDir(prgpath$)
    Call KillDir(fontpath$)
    Call KillDir(itmpath$)
    Call KillDir(enepath$)
    Call KillDir(bmppath$)
    Call KillDir("Archives\")

    Exit Sub
'Begin error handling code:
errorhandler:
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
    upgradeform.status.caption = "Upgrading " + tilepath$
    DoEvents
    Call CopyDir(tilepath$, thepath$ + tilepath$)
    upgradeform.status.caption = "Upgrading " + brdpath$
    DoEvents
    Call CopyDir(brdpath$, thepath$ + brdpath$)
    upgradeform.status.caption = "Upgrading " + tempath$
    DoEvents
    Call CopyDir(tempath$, thepath$ + tempath$)
    upgradeform.status.caption = "Upgrading " + spcpath$
    DoEvents
    Call CopyDir(spcpath$, thepath$ + spcpath$)
    upgradeform.status.caption = "Upgrading " + bkgpath$
    DoEvents
    Call CopyDir(bkgpath$, thepath$ + bkgpath$)
    upgradeform.status.caption = "Upgrading " + mediapath$
    DoEvents
    Call CopyDir(mediapath$, thepath$ + mediapath$)
    upgradeform.status.caption = "Upgrading " + prgpath$
    DoEvents
    Call CopyDir(prgpath$, thepath$ + prgpath$)
    upgradeform.status.caption = "Upgrading " + fontpath$
    DoEvents
    Call CopyDir(fontpath$, thepath$ + fontpath$)
    upgradeform.status.caption = "Upgrading " + itmpath$
    DoEvents
    Call CopyDir(itmpath$, thepath$ + itmpath$)
    upgradeform.status.caption = "Upgrading " + enepath$
    DoEvents
    Call CopyDir(enepath$, thepath$ + enepath$)
    upgradeform.status.caption = "Upgrading " + bmppath$
    DoEvents
    Call CopyDir(bmppath$, thepath$ + bmppath$)
    upgradeform.status.caption = ""
   
    'mainoption.fileTree1.setPath (thepath$)
    'mainoption.fileTree1.pathRefresh

    oldpath$ = currentdir$ + "\" + projectPath$
    'mainoption.Dir1.path = currentdir$ + "\" + projectPath$
    Call mainoption.TreeView1.Nodes.Clear
    Call tkMainForm.fillTree("", projectPath$)
End Sub



Attribute VB_Name = "CommonBackground"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'Fight background
Option Explicit

''''''''''''''''''''''bkg data'''''''''''''''''''''''''

Type TKBackground
    image As String         'image to use on background
    bkgMusic As String      'music to play
    bkgSelWav As String     'wav to play when moving on the menu
    bkgChooseWav As String  'wav to play when player chooses from menu
    bkgReadyWav As String   'wav to play when player is ready
    bkgCantDoWav As String  'wav to play when you can't do something
End Type


Type bkgDoc
    filename As String
    needUpdate As Boolean
    
    'data
    theData As TKBackground
End Type

Sub BackgroundClear(ByRef theBkg As TKBackground)
    'clear fight background
    On Error Resume Next

    theBkg.image = ""
    theBkg.bkgMusic = ""
    theBkg.bkgSelWav = ""
    theBkg.bkgChooseWav = ""
    theBkg.bkgReadyWav = ""
    theBkg.bkgCantDoWav = ""
End Sub

Sub DrawBackground(ByRef theBkg As TKBackground, ByVal X As Long, ByVal Y As Long, ByVal Width As Long, ByVal height As Long, ByVal hdc As Long)
    On Error Resume Next
    'draw the fight background
    Dim file As String
    file = projectPath$ + bmpPath$ + theBkg.image
    file = PakLocate(file)
    If fileExists(file) Then
        Call DrawSizedImage(file, X, Y, Width, height, hdc)
    End If
End Sub

Sub saveBackground(ByVal file As String, ByRef theBkg As TKBackground)
    'save bkg file
    On Error Resume Next
    Dim num As Long
    num = FreeFile
    If file$ = "" Then Exit Sub
    
    #If isToolkit = 1 Then
        bkgList(activeBkgIndex).needUpdate = False
    #End If

    Call Kill(file)
    
    Open file For Binary Access Write As num
        Call BinWriteString(num, "RPGTLKIT BKG")        'Filetype
        Call BinWriteInt(num, major)                    'Version
        Call BinWriteInt(num, 3)                        '2.3 == version 3 background
        Call BinWriteString(num, theBkg.image)
        Call BinWriteString(num, theBkg.bkgMusic)       'music to play
        Call BinWriteString(num, theBkg.bkgSelWav)      'wav to play when moving on the menu
        Call BinWriteString(num, theBkg.bkgChooseWav)   'wav to play when player chooses from menu
        Call BinWriteString(num, theBkg.bkgReadyWav)    'wav to play when player is ready
        Call BinWriteString(num, theBkg.bkgCantDoWav)   'wav to play when you can't do something
    Close num

End Sub

Sub openBackground(ByVal file As String, ByRef theBkg As TKBackground)
    'open background
    On Error Resume Next
    Dim num As Long
    Dim fileHeader As String, majorVer As Long, minorVer As Long
    
    num = FreeFile
    If file$ = "" Then Exit Sub
    #If isToolkit = 1 Then
        bkgList(activeBkgIndex).needUpdate = False
    #End If
    
    Call BackgroundClear(theBkg)
    
    file = PakLocate(file)
       
    num = FreeFile
    Open file$ For Binary As #num
        Dim b As Byte
        Get #num, 13, b
        If b <> 0 Then
            Close #num
            GoTo ver2bkg
        End If
    Close #num

    Open file$ For Binary As #num
        fileHeader$ = BinReadString(num)      'Filetype
        If fileHeader$ <> "RPGTLKIT BKG" Then Close #num: MsgBox "Unrecognised File Format! " + file$, , "Open Background": Exit Sub
        majorVer = BinReadInt(num)         'Version
        minorVer = BinReadInt(num)         'Minor version (ie 2.3 == 3.0 background)
        If majorVer <> major Then MsgBox "This Background was created with an unrecognised version of the Toolkit", , "Unable to open Background": Close #num: Exit Sub
    
        theBkg.image = BinReadString(num)
        theBkg.bkgMusic = BinReadString(num)
        theBkg.bkgSelWav = BinReadString(num)
        theBkg.bkgChooseWav = BinReadString(num)
        theBkg.bkgReadyWav = BinReadString(num)
        theBkg.bkgCantDoWav = BinReadString(num)
    Close #num

    Exit Sub
ver2bkg:
    'open background (ver 2)
        
    Dim X As Long, Y As Long, user As Long
    
    Dim tbm As TKTileBitmap
    Call TileBitmapClear(tbm)
    Call TileBitmapResize(tbm, 19, 11)
    
    num = FreeFile
    
    Open file$ For Input As #num
        fileHeader$ = fread(num)      'Filetype
        If fileHeader$ <> "RPGTLKIT BKG" Then Close #num: Exit Sub
        majorVer = fread(num)
        minorVer = fread(num)
        If majorVer <> major Then MsgBox "This Background was created with an unrecognised version of the Toolkit", , "Unable to open Background": Close #num: Exit Sub
        If minorVer <> minor Then
            user = MsgBox("This Background was created using Version " + str$(majorVer) + "." + str$(minorVer) + ".  You have version " + currentVersion + ". Opening this file may not work.  Continue?", 4, "Different Version")
            If user = 7 Then Close #num: Exit Sub     'selected no
        End If
        For X = 1 To 19
            For Y = 1 To 11
                tbm.tiles(X - 1, Y - 1) = fread(num)
            Next Y
        Next X
        theBkg.bkgMusic = fread(num)
        theBkg.bkgSelWav = fread(num)
        theBkg.bkgChooseWav = fread(num)
        theBkg.bkgReadyWav = fread(num)
        theBkg.bkgCantDoWav = fread(num)
        Call fread(num) 'dummy
        
        For X = 1 To 19
            For Y = 1 To 11
                tbm.redS(X - 1, Y - 1) = fread(num)
                tbm.greenS(X - 1, Y - 1) = fread(num)
                tbm.blueS(X - 1, Y - 1) = fread(num)
            Next Y
        Next X
    
        Dim tbmName As String
        tbmName$ = replace(RemovePath(file$), ".", "_") + ".tbm"
        theBkg.image = tbmName
        tbmName$ = projectPath$ + bmpPath$ + tbmName$
        Call SaveTileBitmap(tbmName, tbm)
    Close #num
End Sub

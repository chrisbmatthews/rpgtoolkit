Attribute VB_Name = "CommonBackground"
'=========================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=========================================================================

'=========================================================================
' RPGToolkit fight background (*.bkg)
'=========================================================================

Option Explicit

'=========================================================================
' An RPGToolkit background
'=========================================================================
Public Type TKBackground    'background structure
    image As String         '  image to use on background
    bkgMusic As String      '  music to play
    bkgSelWav As String     '  wav to play when moving on the menu
    bkgChooseWav As String  '  wav to play when player chooses from menu
    bkgReadyWav As String   '  wav to play when player is ready
    bkgCantDoWav As String  '  wav to play when you can't do something
End Type

'=========================================================================
' A background document
'=========================================================================
Public Type bkgDoc          'background document structure
    filename As String      '  filename of background
    needUpdate As Boolean   '  changed made?
    theData As TKBackground '  the data in the file
End Type

'=========================================================================
' Clear a background structure
'=========================================================================
Public Sub BackgroundClear(ByRef theBkg As TKBackground)
    On Error Resume Next
    With theBkg
        .image = ""
        .bkgMusic = ""
        .bkgSelWav = ""
        .bkgChooseWav = ""
        .bkgReadyWav = ""
        .bkgCantDoWav = ""
    End With
End Sub

'=========================================================================
' Draw a background
'=========================================================================
Public Sub DrawBackground(ByRef theBkg As TKBackground, ByVal x As Long, ByVal y As Long, ByVal width As Long, ByVal height As Long, ByVal hdc As Long)
    On Error Resume Next
    Dim file As String
    file = PakLocate(projectPath & bmpPath & theBkg.image)
    If fileExists(file) Then
        Call DrawSizedImage(file, x, y, width, height, hdc)
    End If
End Sub

'=========================================================================
' Save a background
'=========================================================================
Public Sub saveBackground(ByVal file As String, ByRef theBkg As TKBackground)

    On Error Resume Next

    If file$ = "" Then Exit Sub
    
    #If isToolkit = 1 Then
        bkgList(activeBkgIndex).needUpdate = False
    #End If

    Dim num As Long
    num = FreeFile()

    Call Kill(file)
    
    Open file For Binary Access Write As num
        Call BinWriteString(num, "RPGTLKIT BKG")      'Filetype
        Call BinWriteInt(num, major)                  'Version
        Call BinWriteInt(num, 3)                      '2.3 == version 3 background
        With theBkg
            Call BinWriteString(num, .image)
            Call BinWriteString(num, .bkgMusic)       'music to play
            Call BinWriteString(num, .bkgSelWav)      'wav to play when moving on the menu
            Call BinWriteString(num, .bkgChooseWav)   'wav to play when player chooses from menu
            Call BinWriteString(num, .bkgReadyWav)    'wav to play when player is ready
            Call BinWriteString(num, .bkgCantDoWav)   'wav to play when you can't do something
        End With
    Close num

End Sub

'=========================================================================
' Open a background
'=========================================================================
Public Sub openBackground(ByVal file As String, ByRef theBkg As TKBackground)

    On Error Resume Next

    Dim num As Long, fileHeader As String, majorVer As Long, minorVer As Long

    num = FreeFile
    If file$ = "" Then Exit Sub
    #If isToolkit = 1 Then
        bkgList(activeBkgIndex).needUpdate = False
    #End If

    Call BackgroundClear(theBkg)

    file = PakLocate(file)

    num = FreeFile()

    Open file$ For Binary Access Read As num
        Dim b As Byte
        Get num, 13, b
        If b <> 0 Then
            Close num
            GoTo ver2bkg
        End If
    Close num

    With theBkg

        Open file For Binary Access Read As num
            fileHeader$ = BinReadString(num)      'Filetype
            If fileHeader$ <> "RPGTLKIT BKG" Then Close #num: MsgBox "Unrecognised File Format! " + file$, , "Open Background": Exit Sub
            majorVer = BinReadInt(num)         'Version
            minorVer = BinReadInt(num)         'Minor version (ie 2.3 == 3.0 background)
            If majorVer <> major Then MsgBox "This Background was created with an unrecognised version of the Toolkit", , "Unable to open Background": Close #num: Exit Sub
            .image = BinReadString(num)
            .bkgMusic = BinReadString(num)
            .bkgSelWav = BinReadString(num)
            .bkgChooseWav = BinReadString(num)
            .bkgReadyWav = BinReadString(num)
            .bkgCantDoWav = BinReadString(num)
        Close num

        Exit Sub

ver2bkg:
        'open background (ver 2)

        Dim x As Long, y As Long, user As Long

        Dim tbm As TKTileBitmap

        Call TileBitmapClear(tbm)
        Call TileBitmapResize(tbm, 19, 11)

        Open file$ For Input Access Read As num
            fileHeader$ = fread(num)      'Filetype
            If fileHeader$ <> "RPGTLKIT BKG" Then Close num: Exit Sub
            majorVer = fread(num)
            minorVer = fread(num)
            If majorVer <> major Then MsgBox "This Background was created with an unrecognised version of the Toolkit", , "Unable to open Background": Close #num: Exit Sub
            If minorVer <> minor Then
                user = MsgBox("This Background was created using Version " + CStr(majorVer) + "." + CStr(minorVer) + ".  You have version " + currentVersion + ". Opening this file may not work.  Continue?", 4, "Different Version")
                If user = 7 Then Close num: Exit Sub     'selected no
            End If
            For x = 1 To 19
                For y = 1 To 11
                    tbm.tiles(x - 1, y - 1) = fread(num)
                Next y
            Next x

            .bkgMusic = fread(num)
            .bkgSelWav = fread(num)
            .bkgChooseWav = fread(num)
            .bkgReadyWav = fread(num)
            .bkgCantDoWav = fread(num)

            Dim theBack As String
            theBack = fread(num)
            If (theBack <> "") Then
                .image = theBack
                Close num
                Exit Sub
            End If

            For x = 1 To 19
                For y = 1 To 11
                    tbm.redS(x - 1, y - 1) = fread(num)
                    tbm.greenS(x - 1, y - 1) = fread(num)
                    tbm.blueS(x - 1, y - 1) = fread(num)
                Next y
            Next x

            Dim tbmName As String
            tbmName$ = replace(RemovePath(file$), ".", "_") + ".tbm"
            theBkg.image = tbmName
            tbmName$ = projectPath & bmpPath & tbmName$
            Call SaveTileBitmap(tbmName, tbm)

        Close num

    End With

End Sub

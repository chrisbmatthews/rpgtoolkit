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

'array used in the MDI children
Public bkgList() As bkgDoc
Public bkgListOccupied() As Boolean


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


Sub DrawBackground(ByRef theBkg As TKBackground, ByVal x As Long, ByVal y As Long, ByVal Width As Long, ByVal height As Long, ByVal hdc As Long)
    On Error Resume Next
    'draw the fight background
    Dim file As String
    file = projectPath$ + bmpPath$ + theBkg.image
    file = PakLocate(file)
    If FileExists(file) Then
        Call DrawSizedImage(file, x, y, Width, height, hdc)
    End If
End Sub

Sub saveBackground(ByVal file As String, ByRef theBkg As TKBackground)
    'save bkg file
    On Error Resume Next
    Dim num As Long
    num = FreeFile
    If file$ = "" Then Exit Sub
    
    bkgList(activeBkgIndex).needUpdate = False
    
    Kill file
    
    Open file For Binary As #num
        Call BinWriteString(num, "RPGTLKIT BKG")    'Filetype
        Call BinWriteInt(num, Major)               'Version
        Call BinWriteInt(num, 3)                   '2.3 == version 3 background
        Call BinWriteString(num, theBkg.image)
        Call BinWriteString(num, theBkg.bkgMusic$)        'music to play
        Call BinWriteString(num, theBkg.bkgSelWav$)      'wav to play when moving on the menu
        Call BinWriteString(num, theBkg.bkgChooseWav$)   'wav to play when player chooses from menu
        Call BinWriteString(num, theBkg.bkgReadyWav$)    'wav to play when player is ready
        Call BinWriteString(num, theBkg.bkgCantDoWav$)   'wav to play when you can't do something
    Close #num
End Sub


Sub openBackground(ByVal file As String, ByRef theBkg As TKBackground)
    'open background
    On Error Resume Next
    Dim num As Long
    Dim fileHeader As String, majorVer As Long, minorVer As Long
    
    num = FreeFile
    If file$ = "" Then Exit Sub
    bkgList(activeBkgIndex).needUpdate = False
    
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
        If majorVer <> Major Then MsgBox "This Background was created with an unrecognised version of the Toolkit", , "Unable to open Background": Close #num: Exit Sub
    
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
        
    Dim x As Long, y As Long, user As Long
    
    Dim tbm As TKTileBitmap
    Call TileBitmapClear(tbm)
    Call TileBitmapResize(tbm, 19, 11)
    
    num = FreeFile
    
    Open file$ For Input As #num
        fileHeader$ = fread(num)      'Filetype
        If fileHeader$ <> "RPGTLKIT BKG" Then Close #num: Exit Sub
        majorVer = fread(num)
        minorVer = fread(num)
        If majorVer <> Major Then MsgBox "This Background was created with an unrecognised version of the Toolkit", , "Unable to open Background": Close #num: Exit Sub
        If minorVer <> Minor Then
            user = MsgBox("This Background was created using Version " + str$(majorVer) + "." + str$(minorVer) + ".  You have version " + CurrentVersion + ". Opening this file may not work.  Continue?", 4, "Different Version")
            If user = 7 Then Close #num: Exit Sub     'selected no
        End If
        For x = 1 To 19
            For y = 1 To 11
                tbm.tiles(x - 1, y - 1) = fread(num)
            Next y
        Next x
        theBkg.bkgMusic = fread(num)
        theBkg.bkgSelWav = fread(num)
        theBkg.bkgChooseWav = fread(num)
        theBkg.bkgReadyWav = fread(num)
        theBkg.bkgCantDoWav = fread(num)
        Call fread(num) 'dummy
        
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
        tbmName$ = projectPath$ + bmpPath$ + tbmName$
        Call SaveTileBitmap(tbmName, tbm)
    Close #num
End Sub


Sub VectBackgroundKillSlot(ByVal idx As Long)
    On Error Resume Next
    'free up memory in the ste list vector
    bkgListOccupied(idx) = False
End Sub

Function VectBackgroundNewSlot() As Long
    On Error GoTo vecterr
       
    'test size of array
    Dim test As Long
    Dim oldSize As Long, newSize As Long, t As Long
    test = UBound(bkgList)
    
    'find a new slot in the list of boards and return an index we can use
    For t = 0 To UBound(bkgList)
        If bkgListOccupied(t) = False Then
            bkgListOccupied(t) = True
            VectBackgroundNewSlot = t
            Exit Function
        End If
    Next t
    
    'must resize the vector...
    oldSize = UBound(bkgList)
    newSize = UBound(bkgList) * 2
    ReDim Preserve bkgList(newSize)
    ReDim Preserve bkgListOccupied(newSize)
    
    bkgListOccupied(oldSize + 1) = True
    VectBackgroundNewSlot = oldSize + 1
    
    Exit Function

vecterr:
    ReDim bkgList(1)
    ReDim bkgListOccupied(1)
    Resume Next
    
End Function


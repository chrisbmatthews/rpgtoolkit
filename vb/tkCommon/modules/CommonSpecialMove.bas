Attribute VB_Name = "CommonSpecialMove"
'=========================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=========================================================================

'========================================================================='
' RPGToolkit special move file format (*.spc)
'=========================================================================

'=========================================================================
'EDITED [KSNiloc] [Augest 31, 2004]
'----------------------------------
' + Improvement: openSpecialMove --> function
'=========================================================================

Option Explicit

'=========================================================================
' Integral variables
'=========================================================================

Public Type TKSpecialMove                    'special move structure
    smname As String                         '  name
    smFP As Long                             '  fp
    smSMP As Long                            '  smp consumption
    smPrg As String                          '  program filename
    smtargSMP As Long                        '  smp to remove from target
    smBattle As Byte                         '  can use in battle? 0- yes, 1- no
    smMenu As Byte                           '  can use on menu? 0-yes, 1-no
    smStatusEffect As String                 '  status effect cast
    smAnimation As String                    '  animation
    smDescription As String                  '  description
End Type

Public Type specialMoveDoc                   'special move MDI document structure
    smFile As String                         '  filename
    smNeedUpdate As Boolean                  '  changes made?
    theData As TKSpecialMove                 '  data of the document
End Type

'=========================================================================
' Open a special move
'=========================================================================
Public Function openSpecialMove(ByVal file As String) As TKSpecialMove

    On Error Resume Next
    
    If file$ = "" Then Exit Function
    
    Dim theMove As TKSpecialMove
    
    Call SpecialMoveClear(theMove)
    file$ = PakLocate(file$)
    
    #If isToolkit = 1 Then
        specialMoveList(activeSpecialMoveIndex).smNeedUpdate = False
    #End If
    
    Dim num As Long, fileHeader As String, minorVer As Long, majorVer As Long
    num = FreeFile
    Open file For Binary Access Read As num
        Dim b As Byte
        Get num, 17, b
        If b <> 0 Then
            Close #num
            GoTo ver2oldmove
        End If
    Close num
    
    Open file For Binary Access Read As num
        fileHeader$ = BinReadString(num)      'Filetype
        If fileHeader$ <> "RPGTLKIT SPLMOVE" Then Close #num: MsgBox "Unrecognised File Format! " + file$, , "Open Special Move": Exit Function
        majorVer = BinReadInt(num)         'Version
        minorVer = BinReadInt(num)         'Minor version (ie 2.0)
        If majorVer <> major Then MsgBox "This Move was created with an unrecognised version of the Toolkit", , "Unable to open Special Move": Close #num: Exit Function
    
        theMove.smname$ = BinReadString(num)     'name
        theMove.smFP = BinReadLong(num)      'fp
        theMove.smSMP = BinReadLong(num)     'smp consumption
        theMove.smPrg$ = BinReadString(num)    'program filename
        theMove.smtargSMP = BinReadLong(num)  'smp to remove from target
        theMove.smBattle = BinReadByte(num)
        theMove.smMenu = BinReadByte(num)
        theMove.smStatusEffect$ = BinReadString(num) 'status effect cast
        theMove.smAnimation$ = BinReadString(num)
        theMove.smDescription$ = BinReadString(num)
    Close #num
    openSpecialMove = theMove
    Exit Function
    
ver2oldmove:
    Open file$ For Input As #num
        Input #num, fileHeader$        'Filetype
        If fileHeader$ <> "RPGTLKIT SPLMOVE" Then Close #num: Exit Function
        Input #num, majorVer           'Version
        Input #num, minorVer           'Minor version (ie 2.0)
        If majorVer <> major Then MsgBox "This Special Move was created with an unrecognised version of the Toolkit", , "Unable to open Special Move": Close #num: Exit Function
        If minorVer <> minor Then
            Dim user As Long
            user = MsgBox("This file was created using Version " + CStr(majorVer) + "." + CStr(minorVer) + ".  You have version " + currentVersion + ". Opening this file may not work.  Continue?", 4, "Different Version")
            If user = 7 Then Close #num: Exit Function 'selected no
        End If
        theMove.smname$ = fread(num)   'name
        theMove.smFP = fread(num)        'fp
        theMove.smSMP = fread(num)       'smp consumption
        theMove.smPrg$ = fread(num)      'program filename
        theMove.smtargSMP = fread(num)        'smp to remove from target
        theMove.smBattle = fread(num)
        theMove.smMenu = fread(num)
        theMove.smStatusEffect$ = fread(num)  'status effect cast
        theMove.smAnimation$ = fread(num)
        theMove.smDescription$ = fread(num)
    Close #num
    openSpecialMove = theMove
End Function

'=========================================================================
' Save a special move
'=========================================================================
Public Sub saveSpecialMove(ByVal file As String, ByRef theMove As TKSpecialMove)

    On Error Resume Next

    Dim num As Long
    num = FreeFile()

    If file = "" Then Exit Sub
    
    #If isToolkit = 1 Then
        specialMoveList(activeSpecialMoveIndex).smNeedUpdate = False
    #End If
    
    Call Kill(file)
    Open file For Binary Access Write As num
        Call BinWriteString(num, "RPGTLKIT SPLMOVE")    'Filetype
        Call BinWriteInt(num, major)               'Version
        Call BinWriteInt(num, 2)                'Minor version
        Call BinWriteString(num, theMove.smname)     'name
        Call BinWriteLong(num, theMove.smFP)        'fp
        Call BinWriteLong(num, theMove.smSMP)       'smp consumption
        Call BinWriteString(num, theMove.smPrg)      'program filename
        Call BinWriteLong(num, theMove.smtargSMP)    'smp to remove from target
        Call BinWriteByte(num, theMove.smBattle)
        Call BinWriteByte(num, theMove.smMenu)
        Call BinWriteString(num, theMove.smStatusEffect) 'status effect cast
        Call BinWriteString(num, theMove.smAnimation)
        Call BinWriteString(num, theMove.smDescription)
    Close num

End Sub

'=========================================================================
' Clear a special move
'=========================================================================
Public Sub SpecialMoveClear(ByRef theMove As TKSpecialMove)
    theMove.smname = ""
    theMove.smFP = 0
    theMove.smSMP = 0
    theMove.smPrg = ""
    theMove.smtargSMP = 0
    theMove.smBattle = 0
    theMove.smMenu = 0
    theMove.smStatusEffect = ""
    theMove.smAnimation = ""
    theMove.smDescription = ""
End Sub

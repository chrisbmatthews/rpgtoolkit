Attribute VB_Name = "CommonStatusEffect"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'status effect routines
Option Explicit
''''''''''''''''''''''status effect data'''''''''''''''''''''''''

Type TKStatusEffect
    statusName As String          'name of status effect
    statusRounds As Integer  'rounds until effect is removed (0= until end of fight)
    'effects:  1=y, 0=n
    nStatusSpeed As Integer  'speed charge time y/n
    nStatusSlow As Integer   'slow charge time y/n
    nStatusDisable As Integer 'disbale target y/n
    nStatusHP As Integer     'remove hp y/n
    nStatusHPAmount As Integer   'amount of hp
    nStatusSMP As Integer    'remove smp y/n
    nStatusSMPAmount As Integer   'amount of smp
    nStatusRPGCode As Integer 'run rpgcode y/n
    sStatusRPGCode As String      'rpgcode program to run
End Type


Type statusEffectDoc
    statusFile As String          'filename
    statusNeedUpdate As Boolean
    
    theData As TKStatusEffect
End Type

Public Type FighterStatus
    statusFile As String
    roundsLeft As Long
End Type

Sub openStatus(ByVal file As String, ByRef theEffect As TKStatusEffect)
    'open status effect file
    On Error Resume Next
    
    If (LenB(file$) = 0) Then Exit Sub
    
    Call StatusClear(theEffect)
    file$ = PakLocate(file$)
    
#If isToolkit = 1 Then
    statusEffectList(activeStatusEffectIndex).statusNeedUpdate = False
#End If
    
    Dim num As Long, fileHeader As String, majorVer As Long, minorVer As Long
    num = FreeFile
    Open file$ For Binary As #num
        Dim b As Byte
        Get #num, 17, b
        If (b) Then
            Close #num
            GoTo ver2oldstatus
        End If
    Close #num

    Open file$ For Binary As #num
        fileHeader$ = BinReadString(num)      'Filetype
        If fileHeader$ <> "RPGTLKIT STATUSE" Then Close #num: MsgBox "Unrecognised File Format! " + file$, , "Open Status Effect": Exit Sub
        majorVer = BinReadInt(num)         'Version
        minorVer = BinReadInt(num)         'Minor version (ie 2.0)
        If majorVer <> major Then MsgBox "This Status Effect was created with an unrecognised version of the Toolkit", , "Unable to open Status Effect": Close #num: Exit Sub
    
        theEffect.statusName = BinReadString(num)
        theEffect.statusRounds = BinReadInt(num)
        theEffect.nStatusSpeed = BinReadInt(num)
        theEffect.nStatusSlow = BinReadInt(num)
        theEffect.nStatusDisable = BinReadInt(num)
        theEffect.nStatusHP = BinReadInt(num)
        theEffect.nStatusHPAmount = BinReadInt(num)
        theEffect.nStatusSMP = BinReadInt(num)
        theEffect.nStatusSMPAmount = BinReadInt(num)
        theEffect.nStatusRPGCode = BinReadInt(num)
        theEffect.sStatusRPGCode = BinReadString(num)
    Close #num
    
    Exit Sub
    
ver2oldstatus:
    Open file$ For Input As #num
        Input #num, fileHeader$        'Filetype
        If fileHeader$ <> "RPGTLKIT STATUSE" Then
            MsgBox "This is not a valid status effect file!", , "Invalid file format"
            Close #num
            Exit Sub
        End If
        Input #num, majorVer           'Version
        Input #num, minorVer           'Minor version (ie 2.0)
        If majorVer <> major Then MsgBox "This Status Effect was created with an unrecognised version of the Toolkit", , "Unable to open": Close #num: Exit Sub
        If minorVer <> minor Then
            Dim user As Long
            user = MsgBox("This file was created using Version " + CStr(majorVer) + "." + CStr(minorVer) + ".  You have version " + currentVersion + ". Opening this file may not work.  Continue?", 4, "Different Version")
            If user = 7 Then Close #num: Exit Sub     'selected no
        End If
        theEffect.statusName = fread(num)
        theEffect.statusRounds = fread(num)
        theEffect.nStatusSpeed = fread(num)
        theEffect.nStatusSlow = fread(num)
        theEffect.nStatusDisable = fread(num)
        theEffect.nStatusHP = fread(num)
        theEffect.nStatusHPAmount = fread(num)
        theEffect.nStatusSMP = fread(num)
        theEffect.nStatusSMPAmount = fread(num)
        theEffect.nStatusRPGCode = fread(num)
        theEffect.sStatusRPGCode$ = fread(num)
    Close #num

End Sub


Sub saveStatus(ByVal file As String, ByRef theEffect As TKStatusEffect)
    'save status effect to file
    On Error Resume Next
    Dim num As Long
    num = FreeFile
    If (LenB(file) = 0) Then Exit Sub
    
#If isToolkit = 1 Then
    statusEffectList(activeStatusEffectIndex).statusNeedUpdate = False
#End If
    
    Kill file
    Open file$ For Binary Access Write As #num
        Call BinWriteString(num, "RPGTLKIT STATUSE")    'Filetype
        Call BinWriteInt(num, major)               'Version
        Call BinWriteInt(num, 2)                'Minor version
    
        Call BinWriteString(num, theEffect.statusName)
        Call BinWriteInt(num, theEffect.statusRounds)
        Call BinWriteInt(num, theEffect.nStatusSpeed)
        Call BinWriteInt(num, theEffect.nStatusSlow)
        Call BinWriteInt(num, theEffect.nStatusDisable)
        Call BinWriteInt(num, theEffect.nStatusHP)
        Call BinWriteInt(num, theEffect.nStatusHPAmount)
        Call BinWriteInt(num, theEffect.nStatusSMP)
        Call BinWriteInt(num, theEffect.nStatusSMPAmount)
        Call BinWriteInt(num, theEffect.nStatusRPGCode)
        Call BinWriteString(num, theEffect.sStatusRPGCode)
    Close #num
End Sub


Sub StatusClear(ByRef theEffect As TKStatusEffect)
    'clear the status effect
    On Error Resume Next
    theEffect.statusName = vbNullString         'name of status effect
    theEffect.statusRounds = 0 'rounds until effect is removed (0= until end of fight)
    'effects:  1=y, 0=n
    theEffect.nStatusSpeed = 0 'speed charge time y/n
    theEffect.nStatusSlow = 0  'slow charge time y/n
    theEffect.nStatusDisable = 0 'disbale target y/n
    theEffect.nStatusHP = 0    'remove hp y/n
    theEffect.nStatusHPAmount = 0  'amount of hp
    theEffect.nStatusSMP = 0   'remove smp y/n
    theEffect.nStatusSMPAmount = 0  'amount of smp
    theEffect.nStatusRPGCode = 0 'run rpgcode y/n
    theEffect.sStatusRPGCode = vbNullString    'rpgcode program to run
End Sub



Attribute VB_Name = "CommonEnemy"
'=========================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=========================================================================

'=========================================================================
' RPGToolkit enemy file format (*.ene)
'=========================================================================

Option Explicit

'=========================================================================
' Member constants
'=========================================================================
Private Const FILE_HEADER = "RPGTLKIT ENEMY"

'=========================================================================
' Public constants
'=========================================================================
Public Const ENE_REST = 0
Public Const ENE_FIGHT = 1
Public Const ENE_DEFEND = 2
Public Const ENE_SPC = 3
Public Const ENE_DIE = 4

'=========================================================================
' An RPGToolkit enemy
'=========================================================================
Public Type TKEnemy
    eneName As String              'Name
    eneHP As Long                  'HP
    eneSMP As Long                 'SMP
    eneFP As Long                  'FP
    eneDP As Long                  'DP
    eneRun As Byte                 'can you run from enemy? 0-no, 1- yes
    eneSneakChances As Integer     'chances of sneaking up on enemy
    eneSneakUp As Integer          'chances of enemy sneaking up on you
    eneSizeX As Byte               'size horizontally
    eneSizeY As Byte               'size vertically
    enemyGraphic(19, 7) As String  'Enemy graphics filenames
    eneSpecialMove() As String     'list of 101 special moves
    eneWeakness() As String        'list of 101 weaknesses
    eneStrength() As String        'list of 101 strengths
    eneAI As Byte                  'AI level 0-low, 1- medium, 3- high, 4- very high
    eneUseRPGCode As Byte          'use rpgcode for tactics 0- no, 1-yes
    eneRPGCode As String           'rpgcode to run as tactic.
    eneExp As Long                 'experience the enmy gives you
    eneGP As Long                  'GP you get
    eneWinPrg As String            'prg to run when you beat enemy
    eneRunPrg As String            'prg to run when player runs away
    eneSwipeSound As String        'sound of sword swipe
    eneSMSound As String           'sound of sm useage
    eneHitSound As String          'sound to play when enemy is hit
    eneDieSound As String          'sound to play when enemy dies.
    eneFightAnm As String          'anm file for fight
    eneDefAnm As String            'anm file for defense
    eneSPCAnm As String            'anm file for sm
    eneDieAnm As String            'anm file for death
    gfx(5) As String               'filenames of standard animations for graphics
    customGfx() As String          'customized animations
    customGfxNames() As String     'customized animations (handles)
    eneMaxHP As Long               'max hp
    eneMaxSMP As Long              'max smp
    eneFileName As String          'filename
    status(10) As FighterStatus    'status effects on this enemy
    x As Long                      'x pos of enemy in a fight
    y As Long                      'y pos of enemy in a fight
End Type

'=========================================================================
' An RPGToolkit enemy document
'=========================================================================
Public Type enemyDoc
    eneFile As String              'filename
    eneNeedUpdate As Boolean       'needs saving?
    enemyTile As String            'currently selected tile
    theData As TKEnemy             'the enemy
End Type

'=========================================================================
' Clear all status effects
'=========================================================================
Public Sub EnemyClearAllStatus(ByRef theEnemy As TKEnemy)
    On Error Resume Next
    Dim t As Long
    For t = 0 To UBound(theEnemy.status)
        theEnemy.status(t).roundsLeft = 0
        theEnemy.status(t).statusFile = vbNullString
    Next t
End Sub

'=========================================================================
' Inflict a status effect
'=========================================================================
Public Sub EnemyAddStatus(ByVal statusFile As String, ByRef theEnemy As TKEnemy)

    On Error Resume Next
    
    'open the status effect...
    Dim theEffect As TKStatusEffect
    Call openStatus(projectPath & statusPath & statusFile, theEffect)
    
    Dim t As Long
    Dim clearSlot As Long
    clearSlot = -1
    'check if the fighter already has this status effect...
    For t = 0 To UBound(theEnemy.status)
        If UCase$(theEnemy.status(t).statusFile) = UCase$(statusFile) Then
            'already have it...
            'just reset the rounds left...
            theEnemy.status(t).roundsLeft = theEffect.statusRounds
            Exit Sub
        End If
        If (LenB(theEnemy.status(t).statusFile) = 0) Then
            If clearSlot = -1 Then
                clearSlot = t
            End If
        End If
    Next t
        
    'fighter does't have effect...
    'add it..
    If clearSlot <> -1 Then
        theEnemy.status(clearSlot).statusFile = statusFile
        theEnemy.status(clearSlot).roundsLeft = theEffect.statusRounds
    End If
End Sub

'=========================================================================
' Remove a status effect
'=========================================================================
Public Sub EnemyRemoveStatus(ByVal statusFile As String, ByRef theEnemy As TKEnemy)

    On Error Resume Next
    
    Dim t As Long
    'check if the fighter already has this status effect...
    For t = 0 To UBound(theEnemy.status)
        If UCase$(theEnemy.status(t).statusFile) = UCase$(statusFile) Then
            'already have it...
            theEnemy.status(t).roundsLeft = 0
            theEnemy.status(t).statusFile = vbNullString
            Exit Sub
        End If
    Next t
End Sub

'=========================================================================
' Get the filename for an enemy stance
'=========================================================================
Public Function enemyGetStanceAnm(ByVal stance As String, ByRef theEnemy As TKEnemy) As String

    On Error Resume Next

    Dim toRet As String
    
    stance = UCase$(stance)
    If (LenB(stance) = 0) Then stance = "REST"

    Select Case stance
        Case "FIGHT", "ATTACK":
            toRet = theEnemy.gfx(ENE_FIGHT)
        Case "DEFEND":
            toRet = theEnemy.gfx(ENE_DEFEND)
        Case "SPC", "SPECIAL MOVE":
            toRet = theEnemy.gfx(ENE_SPC)
        Case "DIE":
            toRet = theEnemy.gfx(ENE_DIE)
        Case "REST":
            toRet = theEnemy.gfx(ENE_REST)
        Case Else:
            'it's a custom stance
            'search the custom stances...
            Dim t As Long
            For t = 0 To UBound(theEnemy.customGfxNames)
                If UCase$(theEnemy.customGfxNames(t)) = stance Then
                    toRet = theEnemy.customGfx(t)
                End If
            Next t
    End Select
    enemyGetStanceAnm = toRet
End Function

'=========================================================================
' Add a custom animation
'=========================================================================
Public Sub enemyAddCustomGfx(ByRef theEnemy As TKEnemy, ByVal handle As String, ByVal anim As String)

    On Error Resume Next
    
    'search for empty slot...
    Dim t As Long, tt As Long
    For t = 0 To UBound(theEnemy.customGfxNames)
        If (LenB(theEnemy.customGfxNames(t)) = 0) Then
            theEnemy.customGfxNames(t) = handle
            theEnemy.customGfx(t) = anim
            Exit Sub
        End If
    Next t
    
    'didn't find an empty slot...
    'resize the arrays...
    tt = UBound(theEnemy.customGfxNames)
    ReDim Preserve theEnemy.customGfx(tt * 2)
    ReDim Preserve theEnemy.customGfxNames(tt * 2)
    
    theEnemy.customGfx(tt + 1) = anim
    theEnemy.customGfxNames(tt + 1) = handle
End Sub

'=========================================================================
' Get the idx-th custom stance handle
'=========================================================================
Public Function enemyGetCustomHandleIdx(ByRef theEnemy As TKEnemy, ByVal idx As Long) As Long

    On Error Resume Next
    
    Dim cnt As Long
    Dim t As Long
    
    For t = 0 To UBound(theEnemy.customGfxNames)
        If (LenB(theEnemy.customGfxNames(t))) Then
            If cnt = idx Then
                enemyGetCustomHandleIdx = t
                Exit Function
            Else
                cnt = cnt + 1
            End If
        End If
    Next t
End Function

'=========================================================================
' Save an enemy
'=========================================================================
Public Sub saveEnemy(ByVal file As String, ByRef theEnemy As TKEnemy)

    On Error Resume Next

    Dim num As Long, x As Long, y As Long, t As Long
    num = FreeFile()
    If (LenB(file) = 0) Then Exit Sub

    Open file For Binary Access Write As num
        Call BinWriteString(num, FILE_HEADER)   'Filetype
        Call BinWriteInt(num, 2)               'Version
        Call BinWriteInt(num, 1)               'Minor version (ie 2.1 = Version 3.0 file  2.0-- version 2 file)
        Call BinWriteString(num, theEnemy.eneName$)    'Name
        Call BinWriteLong(num, theEnemy.eneHP)       'HP
        Call BinWriteLong(num, theEnemy.eneSMP)           'SMP
        Call BinWriteLong(num, theEnemy.eneFP)            'FP
        Call BinWriteLong(num, theEnemy.eneDP)            'DP
        Call BinWriteByte(num, theEnemy.eneRun)           'can you run from enemy? 0-no, 1- yes
        Call BinWriteInt(num, theEnemy.eneSneakChances)   'chances of sneaking up on enemy
        Call BinWriteInt(num, theEnemy.eneSneakUp)        'chances of enemy sneaking up on you
        Call BinWriteInt(num, UBound(theEnemy.eneSpecialMove))
        For t = 0 To UBound(theEnemy.eneSpecialMove)
            Call BinWriteString(num, theEnemy.eneSpecialMove$(t)) 'list of special moves
        Next t
        Call BinWriteInt(num, UBound(theEnemy.eneWeakness))
        For t = 0 To UBound(theEnemy.eneWeakness)
            Call BinWriteString(num, theEnemy.eneWeakness$(t))   'list of weaknesses
        Next t
        Call BinWriteInt(num, UBound(theEnemy.eneStrength))
        For t = 0 To UBound(theEnemy.eneStrength)
            Call BinWriteString(num, theEnemy.eneStrength(t))   'list of stengths
        Next t
        Call BinWriteByte(num, theEnemy.eneAI)            'AI level 0-low, 1- medium, 3- high, 4- very high
        Call BinWriteByte(num, theEnemy.eneUseRPGCode)    'use rpgcode for tactics 0- no, 1-yes
        Call BinWriteString(num, theEnemy.eneRPGCode$)      'rpgcode to run as tactic.
        Call BinWriteLong(num, theEnemy.eneExp)           'experience the enmy gives you
        Call BinWriteLong(num, theEnemy.eneGP)            'GP you get
        Call BinWriteString(num, theEnemy.eneWinPrg$)       'prg to run when you beat enemy.
        Call BinWriteString(num, theEnemy.eneRunPrg$)       'prg to run when player runs away.
        Call BinWriteInt(num, UBound(theEnemy.gfx))
        For t = 0 To UBound(theEnemy.gfx)
            Call BinWriteString(num, theEnemy.gfx(t))
        Next t
        Dim sz As Long
        sz = UBound(theEnemy.customGfxNames)
        Call BinWriteLong(num, sz)
        For t = 0 To sz
            Call BinWriteString(num, theEnemy.customGfx(t))
            Call BinWriteString(num, theEnemy.customGfxNames(t))
        Next t
    Close #num
End Sub

'=========================================================================
' Open an enemy
'=========================================================================
Public Function openEnemy(ByVal file As String) As TKEnemy

    On Error Resume Next

    Dim num As Long, x As Long, y As Long, t As Long, user As Long
    Dim fileHeader As String, majorVer As Long, minorVer As Long

    Dim theEnemy As TKEnemy

    num = FreeFile()
    If (LenB(file$) = 0) Then Exit Function
#If isToolkit = 1 Then
    enemylist(activeEnemyIndex).eneNeedUpdate = False
#End If

    Call EnemyClear(theEnemy)

    With theEnemy

        .eneFileName = file
        file = PakLocate(file)
       
        Open file For Binary Access Read As num
            Dim b As Byte
            Get num, 15, b
            If (b) Then
                Close num
                GoTo ver2oldEnemy
            End If
        Close num

        Open file For Binary Access Read As num
            fileHeader$ = BinReadString(num)      'Filetype
            If fileHeader$ <> FILE_HEADER Then Close #num: MsgBox "Unrecognised File Format! " + file$, , "Open Enemy": Exit Function
            majorVer = BinReadInt(num)         'Version
            minorVer = BinReadInt(num)         'Minor version (ie 2.0)
            If majorVer <> major Then MsgBox "This Enemy was created with an unrecognised version of the Toolkit", , "Unable to open Enemy": Close #num: Exit Function
            .eneName$ = BinReadString(num)
            .eneHP = BinReadLong(num)
            .eneSMP = BinReadLong(num)
            .eneFP = BinReadLong(num)
            .eneDP = BinReadLong(num)
            .eneRun = BinReadByte(num)
            .eneSneakChances = BinReadInt(num)
            .eneSneakUp = BinReadInt(num)
            Dim sz As Long
            sz = BinReadInt(num)
            ReDim .eneSpecialMove(sz)
            For t = 0 To sz
                .eneSpecialMove$(t) = BinReadString(num)
            Next t
            sz = BinReadInt(num)
            ReDim .eneWeakness(sz)
            For t = 0 To sz
                .eneWeakness$(t) = BinReadString(num)
            Next t
            sz = BinReadInt(num)
            ReDim .eneStrength(sz)
            For t = 0 To sz
                .eneStrength(t) = BinReadString(num)
            Next t
            .eneAI = BinReadByte(num)
            .eneUseRPGCode = BinReadByte(num)
            .eneRPGCode$ = BinReadString(num)
            .eneExp = BinReadLong(num)
            .eneGP = BinReadLong(num)
            .eneWinPrg$ = BinReadString(num)
            .eneRunPrg$ = BinReadString(num)
            sz = BinReadInt(num)
            For t = 0 To sz
                .gfx(t) = BinReadString(num)
            Next t
            sz = BinReadInt(num)
            ReDim .customGfxNames(sz)
            ReDim .customGfx(sz)
            For t = 0 To sz
                .customGfx(t) = BinReadString(num)
                .customGfxNames(t) = BinReadString(num)
            Next t
        Close num
    
        .eneMaxHP = .eneHP
        .eneMaxSMP = .eneSMP
    
        openEnemy = theEnemy

        Exit Function
    
ver2oldEnemy:

        Open file For Input Access Read As num

            fileHeader$ = fread(num)
            If fileHeader$ <> FILE_HEADER Then
                Close num
                MsgBox "Unrecognised File Format! " & file, , "Open Enemy"
                Exit Function
            End If

            majorVer = CDbl(fread(num))         'Version
            minorVer = CDbl(fread(num))         'Minor version (ie 2.0)

            If majorVer <> major Then
                MsgBox "This Enemy was created with an unrecognised version of the Toolkit " & file$, , "Unable to open Enemy"
                Close num
                Exit Function
            End If

            If minorVer <> minor Then
                user = MsgBox("This Enemy was created using Version " & CStr(majorVer) & "." & CStr(minorVer) & ".  You have version " & currentVersion & ". Opening this file may not work.  Continue?", 4, "Different Version")
                If user = 7 Then
                    Close num
                    Exit Function
                End If
            End If

            .eneName = fread(num)
            .eneHP = fread(num)
            .eneSMP = fread(num)
            .eneFP = fread(num)
            .eneDP = fread(num)
            .eneRun = fread(num)
            .eneSneakChances = fread(num)
            .eneSneakUp = fread(num)
        
            'convert enemy graphic to animation...
            ReDim enemyGraphic(19, 7) As String
            Dim eneSizeX As Long, eneSizeY As Long
            eneSizeX = fread(num)       'size horizontally
            eneSizeY = fread(num)       'size vertically
            For x = 1 To 19
                For y = 1 To 7
                    enemyGraphic$(x, y) = fread(num) 'Enemy graphics filenames
                Next y
            Next x
            'create tile bitmap...
            Dim tbmName As String, anmName As String
            tbmName$ = replace(RemovePath(file$), ".", "_") & "_rest" & ".tbm"
            tbmName$ = projectPath & bmpPath & tbmName$
            Dim tbm As TKTileBitmap
            Call TileBitmapClear(tbm)
            Call TileBitmapResize(tbm, eneSizeX, eneSizeY)
            For x = 1 To eneSizeX
                For y = 1 To eneSizeY
                    tbm.tiles(x - 1, y - 1) = enemyGraphic(x, y)
                Next y
            Next x
            Call SaveTileBitmap(tbmName$, tbm)
            anmName = replace(RemovePath(file), ".", "_") & "_rest" & ".anm"
            anmName = projectPath & miscPath & anmName
            Dim anm As TKAnimation
            Call AnimationClear(anm)
            anm.animSizeX = eneSizeX * 32
            anm.animSizeY = eneSizeY * 32
            anm.animPause = 0.167
            anm.animFrame(0) = RemovePath(tbmName$)
            anm.animTransp(0) = RGB(255, 255, 255)
            Call saveAnimation(anmName$, anm)
            .gfx(ENE_REST) = RemovePath(anmName$)
            ReDim .eneSpecialMove(100)
            ReDim .eneWeakness(100)
            ReDim .eneStrength(100)
            For t = 0 To 100
                .eneSpecialMove(t) = fread(num)
                .eneWeakness(t) = fread(num)
            Next t
            .eneAI = fread(num)
            .eneUseRPGCode = fread(num)
            .eneRPGCode$ = fread(num)
            .eneExp = fread(num)
            .eneGP = fread(num)
            .eneWinPrg$ = fread(num)
            .eneRunPrg$ = fread(num)
            Call fread(num)
            Call fread(num)
            Call fread(num)
            Call fread(num)
            .gfx(ENE_FIGHT) = fread(num)
            .gfx(ENE_DEFEND) = fread(num)
            .gfx(ENE_SPC) = fread(num)
            .gfx(ENE_DIE) = fread(num)
        Close #num
        .eneMaxHP = .eneHP
        .eneMaxSMP = .eneSMP
        openEnemy = theEnemy

    End With

End Function

'=========================================================================
' Clear a TKEnemy structure
'=========================================================================
Public Sub EnemyClear(ByRef theEnemy As TKEnemy)

    On Error Resume Next

    theEnemy.eneName = vbNullString
    theEnemy.eneHP = 0
    theEnemy.eneSMP = 0
    theEnemy.eneFP = 0
    theEnemy.eneDP = 0
    theEnemy.eneRun = 0
    theEnemy.eneSneakChances = 0
    theEnemy.eneSneakUp = 0
    theEnemy.eneSizeX = 1
    theEnemy.eneSizeY = 1
    Dim x As Long, y As Long
    For x = 0 To 19
        For y = 0 To 7
            theEnemy.enemyGraphic(x, y) = vbNullString
        Next y
    Next x
    ReDim theEnemy.eneSpecialMove(100)
    ReDim theEnemy.eneWeakness(100)
    ReDim theEnemy.eneStrength(100)
    For x = 0 To 100
        theEnemy.eneSpecialMove(x) = vbNullString
        theEnemy.eneWeakness(x) = vbNullString
        theEnemy.eneStrength(x) = vbNullString
    Next x
    theEnemy.eneAI = 0
    theEnemy.eneUseRPGCode = 0
    theEnemy.eneRPGCode = vbNullString
    theEnemy.eneExp = 0
    theEnemy.eneGP = 0
    theEnemy.eneWinPrg = vbNullString
    theEnemy.eneRunPrg = vbNullString
    theEnemy.eneSwipeSound = vbNullString
    theEnemy.eneSMSound = vbNullString
    theEnemy.eneHitSound = vbNullString
    theEnemy.eneDieSound = vbNullString
    theEnemy.eneFightAnm = vbNullString
    theEnemy.eneDefAnm = vbNullString
    theEnemy.eneSPCAnm = vbNullString
    theEnemy.eneDieAnm = vbNullString

    Dim t As Long
    For t = 0 To UBound(theEnemy.gfx)
        theEnemy.gfx(t) = vbNullString
    Next t
    For t = 0 To UBound(theEnemy.customGfx)
        theEnemy.customGfx(t) = vbNullString
    Next t
    ReDim theEnemy.customGfx(5)
    ReDim theEnemy.customGfxNames(5)
    
    theEnemy.eneMaxHP = 0
    theEnemy.eneMaxSMP = 0

    Call EnemyClearAllStatus(theEnemy)
End Sub

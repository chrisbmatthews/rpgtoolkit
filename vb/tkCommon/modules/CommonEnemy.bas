Attribute VB_Name = "CommonEnemy"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'enemy routines
Option Explicit
''''''''''''''''''''''enemy data'''''''''''''''''''''''''

'enemy graphic indices
Public Const ENE_REST = 0
Public Const ENE_FIGHT = 1
Public Const ENE_DEFEND = 2
Public Const ENE_SPC = 3
Public Const ENE_DIE = 4


Type TKEnemy
    eneName As String        'Name
    eneHP As Long            'HP
    eneSMP As Long           'SMP
    eneFP As Long            'FP
    eneDP As Long            'DP
    eneRun As Byte           'can you run from enemy? 0-no, 1- yes
    eneSneakChances As Integer  'chances of sneaking up on enemy
    eneSneakUp As Integer       'chances of enemy sneaking up on you
    eneSizeX As Byte         'size horizontally
    eneSizeY As Byte        'size vertically
    enemyGraphic(19, 7) As String  'Enemy graphics filenames
    eneSpecialMove() As String 'list of 101 special moves
    eneWeakness() As String    'list of 101 weaknesses
    eneStrength() As String    'list of 101 strengths
    eneAI As Byte            'AI level 0-low, 1- medium, 3- high, 4- very high
    eneUseRPGCode As Byte    'use rpgcode for tactics 0- no, 1-yes
    eneRPGCode As String      'rpgcode to run as tactic.
    eneExp As Long           'experience the enmy gives you
    eneGP As Long            'GP you get
    eneWinPrg As String       'prg to run when you beat enemy.
    eneRunPrg As String       'prg to run when player runs away.
    eneSwipeSound As String   'sound of sword swipe
    eneSMSound As String      'sound of sm useage
    eneHitSound As String     'sound to play when enemy is hit
    eneDieSound As String     'sound to play when enemy dies.
    eneFightAnm As String    'anm file for fight
    eneDefAnm As String      'anm file for defense
    eneSPCAnm As String      'anm file for sm
    eneDieAnm As String      'anm file for death
    
    gfx(5) As String         'filenames of standard animations for graphics
    customGfx() As String   'customized animations
    customGfxNames() As String   'customized animations (handles)
    
    'not stored in the file-- used by trans3 only
    eneMaxHP As Long        'max hp
    eneMaxSMP As Long       'max smp
    eneFileName As String   'filename
    status(10) As FighterStatus
    x As Long
    y As Long    'x and y location in fight
End Type

Type enemyDoc
    eneFile As String         'filename
    eneNeedUpdate As Boolean
    enemyTile As String       'currently selected tile
    
    theData As TKEnemy
End Type

'array of enemies used in the MDI children
Public enemylist() As enemyDoc
Public enemyListOccupied() As Boolean

Sub EnemyClearAllStatus(ByRef theEnemy As TKEnemy)
    'clear all status effect
    On Error Resume Next
    Dim t As Long
    For t = 0 To UBound(theEnemy.status)
        theEnemy.status(t).roundsLeft = 0
        theEnemy.status(t).statusFile = ""
    Next t
End Sub

Sub EnemyAddStatus(ByVal statusFile As String, ByRef theEnemy As TKEnemy)
    'add a status effect to a fighter
    On Error Resume Next
    
    'open the status effect...
    Dim theEffect As TKStatusEffect
    Call openStatus(projectPath$ + statusPath$ + statusFile, theEffect)
    
    Dim t As Long
    Dim clearSlot As Long
    clearSlot = -1
    'check if the fighter already has this status effect...
    For t = 0 To UBound(theEnemy.status)
        If UCase(theEnemy.status(t).statusFile) = UCase(statusFile) Then
            'already have it...
            'just reset the rounds left...
            theEnemy.status(t).roundsLeft = theEffect.statusRounds
            Exit Sub
        End If
        If theEnemy.status(t).statusFile = "" Then
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

Sub EnemyRemoveStatus(ByVal statusFile As String, ByRef theEnemy As TKEnemy)
    'remove status effect
    On Error Resume Next
    
    Dim t As Long
    'check if the fighter already has this status effect...
    For t = 0 To UBound(theEnemy.status)
        If UCase(theEnemy.status(t).statusFile) = UCase(statusFile) Then
            'already have it...
            theEnemy.status(t).roundsLeft = 0
            theEnemy.status(t).statusFile = ""
            Exit Sub
        End If
    Next t
End Sub





Public Function enemyGetStanceAnm(ByVal stance As String, ByRef theEnemy As TKEnemy) As String
    'obtain the animation filename of a specific stance
    'built-in stances:
    'FIGHT
    'DEFEND
    'SPC
    'DIE
    'REST
    'Also searches custom stances
    On Error Resume Next
    Dim toRet As String
    
    stance = UCase$(stance)
    If stance = "" Then stance = "REST"
    Select Case stance
        Case "FIGHT":
            toRet = theEnemy.gfx(ENE_FIGHT)
        Case "DEFEND":
            toRet = theEnemy.gfx(ENE_DEFEND)
        Case "SPC":
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

Sub enemyAddCustomGfx(ByRef theEnemy As TKEnemy, ByVal handle As String, ByVal anim As String)
    'add a custom animation to the enemy
    On Error Resume Next
    
    'search for empty slot...
    Dim t As Long, tt As Long
    For t = 0 To UBound(theEnemy.customGfxNames)
        If theEnemy.customGfxNames(t) = "" Then
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


Function enemyGetCustomHandleIdx(ByRef theEnemy As TKEnemy, ByVal idx As Long) As Long
    'return the handle of the idx-th custom gfx (not counting ones with "" as their handles)
    On Error Resume Next
    
    Dim cnt As Long
    Dim t As Long
    
    For t = 0 To UBound(theEnemy.customGfxNames)
        If theEnemy.customGfxNames(t) <> "" Then
            If cnt = idx Then
                enemyGetCustomHandleIdx = t
                Exit Function
            Else
                cnt = cnt + 1
            End If
        End If
    Next t
End Function

Sub VectEnemyKillSlot(ByVal idx As Long)
    On Error Resume Next
    'free up memory in the enemy list vector
    enemyListOccupied(idx) = False
End Sub

Function VectEnemyNewSlot() As Long
    On Error GoTo vecterr
       
    'test size of array
    Dim test As Long, oldSize As Long, newSize As Long, t As Long
    test = UBound(enemylist)
    
    'find a new slot in the list of boards and return an index we can use
    For t = 0 To UBound(enemylist)
        If enemyListOccupied(t) = False Then
            enemyListOccupied(t) = True
            VectEnemyNewSlot = t
            Exit Function
        End If
    Next t
    
    'must resize the vector...
    oldSize = UBound(enemylist)
    newSize = UBound(enemylist) * 2
    ReDim Preserve enemylist(newSize)
    ReDim Preserve enemyListOccupied(newSize)
    
    enemyListOccupied(oldSize + 1) = True
    VectEnemyNewSlot = oldSize + 1
    
    Exit Function

vecterr:
    ReDim enemylist(1)
    ReDim enemyListOccupied(1)
    Resume Next
    
End Function

Sub saveEnemy(ByVal file As String, ByRef theEnemy As TKEnemy)
    'saves enemy in memory.
    On Error Resume Next
    
    Dim num As Long, x As Long, y As Long, t As Long
    num = FreeFile
    If file = "" Then Exit Sub
    
    Open file For Binary As #num
        Call BinWriteString(num, "RPGTLKIT ENEMY")   'Filetype
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


Sub openEnemy(ByVal file As String, ByRef theEnemy As TKEnemy)
    '========================================================
    'EDITED: [Delano - 11/05/04]
    'Fixed bug where enemies die in one hit: eneMaxHP was not assigned for TK3 enemies.
    '========================================================
    'Loads an enemy into memory.
    'Called by loadEnemy, CBLoadEnemy, CBSetGeneralString.
    
    On Error Resume Next
    
    Dim num As Long, x As Long, y As Long, t As Long, user As Long
    Dim fileHeader As String, majorVer As Long, minorVer As Long
    
    num = FreeFile
    If file$ = "" Then Exit Sub
    enemylist(activeEnemyIndex).eneNeedUpdate = False
    
    Call EnemyClear(theEnemy)
    
    theEnemy.eneFileName = file
    file = PakLocate(file)
       
    num = FreeFile
    Open file$ For Binary As #num
        Dim b As Byte
        Get #num, 15, b
        If b <> 0 Then
            Close #num
            GoTo ver2oldenemy
        End If
    Close #num

    Open file$ For Binary As #num
        fileHeader$ = BinReadString(num)      'Filetype
        If fileHeader$ <> "RPGTLKIT ENEMY" Then Close #num: MsgBox "Unrecognised File Format! " + file$, , "Open Enemy": Exit Sub
        majorVer = BinReadInt(num)         'Version
        minorVer = BinReadInt(num)         'Minor version (ie 2.0)
        If majorVer <> major Then MsgBox "This Enemy was created with an unrecognised version of the Toolkit", , "Unable to open Enemy": Close #num: Exit Sub
        
        theEnemy.eneName$ = BinReadString(num)
        theEnemy.eneHP = BinReadLong(num)
        theEnemy.eneSMP = BinReadLong(num)
        theEnemy.eneFP = BinReadLong(num)
        theEnemy.eneDP = BinReadLong(num)
        theEnemy.eneRun = BinReadByte(num)
        theEnemy.eneSneakChances = BinReadInt(num)
        theEnemy.eneSneakUp = BinReadInt(num)
        Dim sz As Long
        sz = BinReadInt(num)
        ReDim theEnemy.eneSpecialMove(sz)
        For t = 0 To sz
            theEnemy.eneSpecialMove$(t) = BinReadString(num)
        Next t
        sz = BinReadInt(num)
        ReDim theEnemy.eneWeakness(sz)
        For t = 0 To sz
            theEnemy.eneWeakness$(t) = BinReadString(num)
        Next t
        sz = BinReadInt(num)
        ReDim theEnemy.eneStrength(sz)
        For t = 0 To sz
            theEnemy.eneStrength(t) = BinReadString(num)
        Next t
        theEnemy.eneAI = BinReadByte(num)
        theEnemy.eneUseRPGCode = BinReadByte(num)
        theEnemy.eneRPGCode$ = BinReadString(num)
        theEnemy.eneExp = BinReadLong(num)
        theEnemy.eneGP = BinReadLong(num)
        theEnemy.eneWinPrg$ = BinReadString(num)
        theEnemy.eneRunPrg$ = BinReadString(num)
        sz = BinReadInt(num)
        For t = 0 To sz
            theEnemy.gfx(t) = BinReadString(num)
        Next t
        sz = BinReadInt(num)
        ReDim theEnemy.customGfxNames(sz)
        ReDim theEnemy.customGfx(sz)
        For t = 0 To sz
            theEnemy.customGfx(t) = BinReadString(num)
            theEnemy.customGfxNames(t) = BinReadString(num)
        Next t
    Close #num
    
    'Bug fix: these values were not assigned upon opening a TK3 enemy.
    theEnemy.eneMaxHP = theEnemy.eneHP
    theEnemy.eneMaxSMP = theEnemy.eneSMP
    
    Exit Sub
    
ver2oldenemy:
    Open file For Input As #num
        fileHeader$ = fread(num)      'Filetype
        If fileHeader$ <> "RPGTLKIT ENEMY" Then Close #num: MsgBox "Unrecognised File Format! " + file$, , "Open Enemy": Exit Sub
        majorVer = val(fread(num))         'Version
        minorVer = val(fread(num))         'Minor version (ie 2.0)
        If majorVer <> major Then MsgBox "This Enemy was created with an unrecognised version of the Toolkit " + file$, , "Unable to open Enemy": Close #num: Exit Sub
        If minorVer <> minor Then
            user = MsgBox("This Enemy was created using Version " + str$(majorVer) + "." + str$(minorVer) + ".  You have version " + currentVersion + ". Opening this file may not work.  Continue?", 4, "Different Version")
            If user = 7 Then Close #num: Exit Sub     'selected no
        End If
        theEnemy.eneName$ = fread(num)  'Name
        theEnemy.eneHP = fread(num)     'HP
        theEnemy.eneSMP = fread(num)         'SMP
        theEnemy.eneFP = fread(num)          'FP
        theEnemy.eneDP = fread(num)          'DP
        theEnemy.eneRun = fread(num)         'can you run from enemy? 0-no, 1- yes
        theEnemy.eneSneakChances = fread(num) 'chances of sneaking up on enemy
        theEnemy.eneSneakUp = fread(num)     'chances of enemy sneaking up on you
        
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
        tbmName$ = replaceChar(RemovePath(file$), ".", "_") + "_rest" + ".tbm"
        tbmName$ = projectPath$ + bmpPath$ + tbmName$
        Dim tbm As TKTileBitmap
        Call TileBitmapClear(tbm)
        Call TileBitmapResize(tbm, eneSizeX, eneSizeY)
        For x = 1 To eneSizeX
            For y = 1 To eneSizeY
                tbm.tiles(x - 1, y - 1) = enemyGraphic(x, y)
            Next y
        Next x
        Call SaveTileBitmap(tbmName$, tbm)
        'create animation...
        anmName$ = replaceChar(RemovePath(file$), ".", "_") + "_rest" + ".anm"
        anmName$ = projectPath$ + miscPath$ + anmName$
        Dim anm As TKAnimation
        Call AnimationClear(anm)
        anm.animSizeX = eneSizeX * 32
        anm.animSizeY = eneSizeY * 32
        anm.animPause = 0.167
        anm.animFrame(0) = RemovePath(tbmName$)
        Call saveAnimation(anmName$, anm)
        
        theEnemy.gfx(ENE_REST) = RemovePath(anmName$)
                
        ReDim theEnemy.eneSpecialMove(100)
        ReDim theEnemy.eneWeakness(100)
        ReDim theEnemy.eneStrength(100)
        For t = 0 To 100
            theEnemy.eneSpecialMove$(t) = fread(num) 'list of 101 special moves
            theEnemy.eneWeakness$(t) = fread(num) 'list of 101 weaknesses
        Next t
        theEnemy.eneAI = fread(num)          'AI level 0-low, 1- medium, 3- high, 4- very high
        theEnemy.eneUseRPGCode = fread(num)  'use rpgcode for tactics 0- no, 1-yes
        theEnemy.eneRPGCode$ = fread(num)    'rpgcode to run as tactic.
        theEnemy.eneExp = fread(num)         'experience the enmy gives you
        theEnemy.eneGP = fread(num)          'GP you get
        theEnemy.eneWinPrg$ = fread(num)     'prg to run when you beat enemy.
        theEnemy.eneRunPrg$ = fread(num)     'prg to run when player runs away.
        
        Dim swipeSound As String, smSound As String, hitSound As String, dieSound As String
        swipeSound$ = fread(num) 'sound of sword swipe
        smSound$ = fread(num)    'sound of sm useage
        hitSound$ = fread(num)   'sound to play when enemy is hit
        dieSound$ = fread(num)   'sound to play when enemy dies.
        theEnemy.gfx(ENE_FIGHT) = fread(num)  'anm file for fight
        theEnemy.gfx(ENE_DEFEND) = fread(num)    'anm file for defense
        theEnemy.gfx(ENE_SPC) = fread(num)    'anm file for sm
        theEnemy.gfx(ENE_DIE) = fread(num)    'anm file for death
    Close #num
    theEnemy.eneMaxHP = theEnemy.eneHP
    theEnemy.eneMaxSMP = theEnemy.eneSMP
    
    
Exit Sub
End Sub


Sub EnemyClear(ByRef theEnemy As TKEnemy)
    '========================================================
    'EDITED: [Delano - 11/05/04]
    'Cleared a couple of extra members...might want to clear a few others.
    '========================================================
    'Clear enemy object.
    'Called by openEnemy, CreateParty
    
    On Error Resume Next

    theEnemy.eneName = ""
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
            theEnemy.enemyGraphic(x, y) = ""
        Next y
    Next x
    ReDim theEnemy.eneSpecialMove(100)
    ReDim theEnemy.eneWeakness(100)
    ReDim theEnemy.eneStrength(100)
    For x = 0 To 100
        theEnemy.eneSpecialMove(x) = ""
        theEnemy.eneWeakness(x) = ""
        theEnemy.eneStrength(x) = ""
    Next x
    theEnemy.eneAI = 0
    theEnemy.eneUseRPGCode = 0
    theEnemy.eneRPGCode = ""
    theEnemy.eneExp = 0
    theEnemy.eneGP = 0
    theEnemy.eneWinPrg = ""
    theEnemy.eneRunPrg = ""
    theEnemy.eneSwipeSound = ""
    theEnemy.eneSMSound = ""
    theEnemy.eneHitSound = ""
    theEnemy.eneDieSound = ""
    theEnemy.eneFightAnm = ""
    theEnemy.eneDefAnm = ""
    theEnemy.eneSPCAnm = ""
    theEnemy.eneDieAnm = ""

    Dim t As Long
    For t = 0 To UBound(theEnemy.gfx)
        theEnemy.gfx(t) = ""
    Next t
    For t = 0 To UBound(theEnemy.customGfx)
        theEnemy.customGfx(t) = ""
    Next t
    ReDim theEnemy.customGfx(5)
    ReDim theEnemy.customGfxNames(5)
    
    'Edit: cleared a couple of extra values:
    theEnemy.eneMaxHP = 0
    theEnemy.eneMaxSMP = 0

    Call EnemyClearAllStatus(theEnemy)
End Sub



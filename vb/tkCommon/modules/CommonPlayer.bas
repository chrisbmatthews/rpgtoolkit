Attribute VB_Name = "CommonPlayer"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'player routines
Option Explicit
''''''''''''''''''''''player data'''''''''''''''''''''''''

'indicies of char gfx
Public Const PLYR_WALK_S = 0
Public Const PLYR_WALK_N = 1
Public Const PLYR_WALK_E = 2
Public Const PLYR_WALK_W = 3
Public Const PLYR_WALK_NW = 4
Public Const PLYR_WALK_NE = 5
Public Const PLYR_WALK_SW = 6
Public Const PLYR_WALK_SE = 7
Public Const PLYR_FIGHT = 8
Public Const PLYR_DEFEND = 9
Public Const PLYR_SPC = 10
Public Const PLYR_DIE = 11
Public Const PLYR_REST = 12


Type TKPlayer
    charname As String            'Charactername
    experienceVar As String       'Experience variable
    defenseVar As String          'DP variable
    fightVar As String            'FP variable
    healthVar As String           'HP variable
    maxHealthVar As String        'Max HP var
    nameVar As String             'Character name variable
    smVar As String               'Special Move power variable
    smMaxVar As String            'Sp'l Move maximum variable.
    leVar As String               'Level variable
    initExperience As Long        'Initial Experience Level
    initHealth As Long            'Initial health level
    initMaxHealth As Long         'Initial maximum health level
    initDefense As Long           'Initial DP
    initFight As Long             'Initial FP
    initSm As Long                'Initial SM power
    initSmMax As Long             'Initial Max SM power.
    initLevel As Long             'Initial level
    profilePic As String          'Profilepicture
    smlist(200) As String         'Special Move list (200 in total!)
    spcMinExp(200) As Long        'minimum experience for each move
    spcMinLevel(200) As Long      'min level for each move
    spcVar(200) As String         'conditional variable for each special move
    spcEquals(200) As String      'condition of variable for each special move.
    specialMoveName As String     'Name of special move
    smYN As Byte                  'does he do special moves? 0-Y, 1-N
    accessoryName(10) As String   'Names of 10 accessories.
    armorType(6) As Byte          'Is ARMOURTYPE used (0-N,1-Y).  Armour types are:
                                  '1-head,2-neck,3-lh,4-rh,5-body,6-legs
    levelType As Long             'Initial Level progression
    experienceIncrease As Integer 'Experience increase Factor
    ''
    maxLevel As Long              'Maximum level.
    levelHp As Integer            'HP incrase by % when level increaes
    levelDp As Integer            'dP incrase by % when level increaes
    levelFp As Integer            'fP incrase by % when level increaes
    levelSm As Integer            'smP incrase by % when level increaes
    charLevelUpRPGCode As String  'rpgcode program to run on level up
    charLevelUpType As Byte       'level up type 0- exponential, 1-linear
    charSizeType As Byte          'size type:0- 32x32, 1-64x32
    
    gfx(13) As String         'filenames of standard animations for graphics
    customGfx() As String   'customized animations
    customGfxNames() As String   'customized animations (handles)

    'volatile -- used by trans only
    status(10) As FighterStatus
    nextLevel As Integer
    levelProgression As Integer
End Type


Type playerDoc
    charFile As String            'filename
    charNeedUpdate As Boolean
    specialMoveNumber As Long    'which spc move is selected?
    charLayTile As Boolean   'about to lay a tile?
    
    theData As TKPlayer
End Type

Sub playerAddCustomGfx(ByRef thePlayer As TKPlayer, ByVal handle As String, ByVal anim As String)
    'add a custom animation to the player
    On Error Resume Next
    
    'search for empty slot...
    Dim t As Long, tt As Long
    For t = 0 To UBound(thePlayer.customGfxNames)
        If thePlayer.customGfxNames(t) = "" Then
            thePlayer.customGfxNames(t) = handle
            thePlayer.customGfx(t) = anim
            Exit Sub
        End If
    Next t
    
    'didn't find an empty slot...
    'resize the arrays...
    tt = UBound(thePlayer.customGfxNames)
    ReDim Preserve thePlayer.customGfx(tt * 2)
    ReDim Preserve thePlayer.customGfxNames(tt * 2)
    
    thePlayer.customGfx(tt + 1) = anim
    thePlayer.customGfxNames(tt + 1) = handle
End Sub


Sub PlayerClearAllStatus(ByRef thePlayer As TKPlayer)
    'clear all status effect
    On Error Resume Next
    Dim t As Long
    For t = 0 To UBound(thePlayer.status)
        thePlayer.status(t).roundsLeft = 0
        thePlayer.status(t).statusFile = ""
    Next t
End Sub

Sub PlayerAddStatus(ByVal statusFile As String, ByRef thePlayer As TKPlayer)
    'add a status effect to a fighter
    On Error Resume Next
    
    'open the status effect...
    Dim theEffect As TKStatusEffect
    Call openStatus(projectPath$ + statusPath$ + statusFile, theEffect)
    
    Dim t As Long
    Dim clearSlot As Long
    clearSlot = -1
    'check if the fighter already has this status effect...
    For t = 0 To UBound(thePlayer.status)
        If UCase(thePlayer.status(t).statusFile) = UCase(statusFile) Then
            'already have it...
            'just reset the rounds left...
            thePlayer.status(t).roundsLeft = theEffect.statusRounds
            Exit Sub
        End If
        If thePlayer.status(t).statusFile = "" Then
            If clearSlot = -1 Then
                clearSlot = t
            End If
        End If
    Next t
        
    'fighter does't have effect...
    'add it..
    If clearSlot <> -1 Then
        thePlayer.status(clearSlot).statusFile = statusFile
        thePlayer.status(clearSlot).roundsLeft = theEffect.statusRounds
    End If
End Sub


Sub PlayerRemoveStatus(ByVal statusFile As String, ByRef thePlayer As TKPlayer)
    'remove status effect
    On Error Resume Next
    
    Dim t As Long
    'check if the fighter already has this status effect...
    For t = 0 To UBound(thePlayer.status)
        If UCase(thePlayer.status(t).statusFile) = UCase(statusFile) Then
            'already have it...
            thePlayer.status(t).roundsLeft = 0
            thePlayer.status(t).statusFile = ""
            Exit Sub
        End If
    Next t
End Sub



Function playerGetCustomHandleIdx(ByRef thePlayer As TKPlayer, ByVal idx As Long) As Long
    'return the handle of the idx-th custom gfx (not counting ones with "" as their handles)
    On Error Resume Next
    
    Dim cnt As Long
    Dim t As Long
    
    For t = 0 To UBound(thePlayer.customGfxNames)
        If thePlayer.customGfxNames(t) <> "" Then
            If cnt = idx Then
                playerGetCustomHandleIdx = t
                Exit Function
            Else
                cnt = cnt + 1
            End If
        End If
    Next t
End Function



Public Function playerGetStanceAnm(ByVal stance As String, ByRef thePlayer As TKPlayer) As String
    'obtain the animation filename of a specific stance
    'built-in stances:
    'WALK_S
    'WALK_N
    'WALK_E
    'WALK_W
    'WALK_NW
    'WALK_NE
    'WALK_SW
    'WALK_SE
    'FIGHT
    'DEFEND
    'SPC
    'DIE
    'REST
    'Also searches custom stances
    On Error Resume Next
    Dim toRet As String
    
    stance = UCase$(stance)
    If stance = "" Then stance = "WALK_S"
    Select Case stance
        Case "WALK_S":
            toRet = thePlayer.gfx(PLYR_WALK_S)
        Case "WALK_N":
            toRet = thePlayer.gfx(PLYR_WALK_N)
        Case "WALK_E":
            toRet = thePlayer.gfx(PLYR_WALK_E)
        Case "WALK_W":
            toRet = thePlayer.gfx(PLYR_WALK_W)
        Case "WALK_NW":
            toRet = thePlayer.gfx(PLYR_WALK_NW)
            If toRet = "" Then
                toRet = thePlayer.gfx(PLYR_WALK_W)
            End If
        Case "WALK_NE":
            toRet = thePlayer.gfx(PLYR_WALK_NE)
            If toRet = "" Then
                toRet = thePlayer.gfx(PLYR_WALK_E)
            End If
        Case "WALK_SW":
            toRet = thePlayer.gfx(PLYR_WALK_SW)
            If toRet = "" Then
                toRet = thePlayer.gfx(PLYR_WALK_W)
            End If
        Case "WALK_SE":
            toRet = thePlayer.gfx(PLYR_WALK_SE)
            If toRet = "" Then
                toRet = thePlayer.gfx(PLYR_WALK_E)
            End If
        Case "FIGHT":
            toRet = thePlayer.gfx(PLYR_FIGHT)
        Case "DEFEND":
            toRet = thePlayer.gfx(PLYR_DEFEND)
        Case "SPC":
            toRet = thePlayer.gfx(PLYR_SPC)
        Case "DIE":
            toRet = thePlayer.gfx(PLYR_DIE)
        Case "REST":
            toRet = thePlayer.gfx(PLYR_REST)
        Case Else:
            'it's a custom stance
            'search the custom stances...
            Dim t As Long
            For t = 0 To UBound(thePlayer.customGfxNames)
                If UCase$(thePlayer.customGfxNames(t)) = stance Then
                    toRet = thePlayer.customGfx(t)
                End If
            Next t
    End Select
    playerGetStanceAnm = toRet
End Function

Function FindPlayerHandle(ByVal file As String) As String
    On Error Resume Next
    'determine the handle of a player
    'if a file (with a .tem extension) is specified, the
    'file is opened and we get the handle
    'if no extension is specified, the file will be
    'passed back as if it is the handle
    
    If UCase$(GetExt(file)) = "TEM" Then
        Dim plyr As TKPlayer
        Call openchar(projectPath$ + temPath$ + file, plyr)
        FindPlayerHandle = plyr.charname
    Else
        'this is not a filename!
        FindPlayerHandle = file
    End If
End Function


Sub savechar(ByVal file As String, ByRef thePlayer As TKPlayer)
    'saves character file
    On Error Resume Next
    Dim num As Long, t As Long
    num = FreeFile
    If file = "" Then Exit Sub
    
    Kill file
    
    Open file For Binary As #num
        Call BinWriteString(num, "RPGTLKIT CHAR")   'Filetype
        Call BinWriteInt(num, major)               'Version
        Call BinWriteInt(num, 5)            'Minor version (ie 2.5 = Version 3.0 file  2.3-- binary 2.2-- 64x64 fight gfx, 2.1-- 64x32 chars (2.0== 32x32 chars))
        Call BinWriteString(num, thePlayer.charname$)      'Charactername
        Call BinWriteString(num, thePlayer.experienceVar$)
        Call BinWriteString(num, thePlayer.defenseVar$)
        Call BinWriteString(num, thePlayer.fightVar$)
        Call BinWriteString(num, thePlayer.healthVar$)
        Call BinWriteString(num, thePlayer.maxHealthVar$)
        Call BinWriteString(num, thePlayer.nameVar$)
        Call BinWriteString(num, thePlayer.smVar$)
        Call BinWriteString(num, thePlayer.smMaxVar$)
        Call BinWriteString(num, thePlayer.leVar$)
        Call BinWriteLong(num, thePlayer.initExperience)
        Call BinWriteLong(num, thePlayer.initHealth)
        Call BinWriteLong(num, thePlayer.initMaxHealth)
        Call BinWriteLong(num, thePlayer.initDefense)
        Call BinWriteLong(num, thePlayer.initFight)
        Call BinWriteLong(num, thePlayer.initSm)
        Call BinWriteLong(num, thePlayer.initSmMax)
        Call BinWriteLong(num, thePlayer.initLevel)
        Call BinWriteString(num, thePlayer.profilePic$)
        For t = 0 To 200
            Call BinWriteString(num, thePlayer.smlist(t))
            Call BinWriteLong(num, thePlayer.spcMinExp(t))
            Call BinWriteLong(num, thePlayer.spcMinLevel(t))
            Call BinWriteString(num, thePlayer.spcVar(t))
            Call BinWriteString(num, thePlayer.spcEquals(t))
        Next t
        Call BinWriteString(num, thePlayer.specialMoveName)
        Call BinWriteByte(num, thePlayer.smYN)
        For t = 0 To 10
            Call BinWriteString(num, thePlayer.accessoryName(t))
        Next t
        For t = 0 To 6
            Call BinWriteByte(num, thePlayer.armorType(t))
        Next t
        Call BinWriteLong(num, thePlayer.levelType)
        Call BinWriteInt(num, thePlayer.experienceIncrease)
        Call BinWriteLong(num, thePlayer.maxLevel)
        Call BinWriteInt(num, thePlayer.levelHp)
        Call BinWriteInt(num, thePlayer.levelDp)
        Call BinWriteInt(num, thePlayer.levelFp)
        Call BinWriteInt(num, thePlayer.levelSm)
        Call BinWriteString(num, thePlayer.charLevelUpRPGCode)
        Call BinWriteByte(num, thePlayer.charLevelUpType)
        Call BinWriteByte(num, thePlayer.charSizeType)
        
        For t = 0 To UBound(thePlayer.gfx)
            Call BinWriteString(num, thePlayer.gfx(t))
        Next t
        Dim sz As Long
        sz = UBound(thePlayer.customGfxNames)
        Call BinWriteLong(num, sz)
        For t = 0 To sz
            Call BinWriteString(num, thePlayer.customGfx(t))
            Call BinWriteString(num, thePlayer.customGfxNames(t))
        Next t
    Close #num
End Sub


Sub openchar(ByVal file As String, ByRef thePlayer As TKPlayer)
'opens character file
On Error Resume Next
    'minor ver 4-- version 2.20b character
    'minor ver 5-- 3.0 char
    Dim num As Long, tstName As String
    num = FreeFile
    If file$ = "" Then Exit Sub
    #If isToolkit = 1 Then
        playerList(activePlayerIndex).charNeedUpdate = False
    #End If
    thePlayer.charLevelUpType = 0
    thePlayer.charSizeType = 0
    
    Dim tbm As TKTileBitmap
    Dim anm As TKAnimation
    Dim anmFight As TKAnimation
    Dim anmDef As TKAnimation
    Dim anmSPC As TKAnimation
    Dim anmDead As TKAnimation
    Dim tbmFight As TKTileBitmap
    Dim tbmDef As TKTileBitmap
    Dim tbmSPC As TKTileBitmap
    Dim tbmDead As TKTileBitmap
    
    Dim swipeWav As String
    Dim defendWav As String
    Dim smWav As String
    Dim deadWav As String
    
    Call PlayerClear(thePlayer)
    
    'set us up for conversion of old-style embedded tiles
    'we'll take embedded tiles and spit them out as a tileset.
    'thus making them external...
    Dim X As Long, Y As Long
    For X = 0 To 32
        For Y = 0 To 32
            bufTile(X, Y) = tileMem(X, Y)
        Next Y
    Next X
    Dim oldDetail As Long
    oldDetail = detail
    detail = 1
    tstName$ = replace(RemovePath(file$), ".", "_") + ".tst"
    tstName$ = projectPath$ + tilePath$ + tstName$
    
    file$ = PakLocate(file$)
    
    num = FreeFile
    Open file$ For Binary As #num
        Dim b As Byte
        Get #num, 14, b
        If b <> 0 Then
            Close #num
            GoTo ver2oldchar
        End If
    Close #num
    
    Dim fileHeader As String, majorVer As Long, minorVer As Long
    Open file$ For Binary As #num
        fileHeader$ = BinReadString(num)      'Filetype
        If fileHeader$ <> "RPGTLKIT CHAR" Then Close #num: MsgBox "Unrecognised File Format! " + file$, , "Open Character": Exit Sub
        majorVer = BinReadInt(num)         'Version
        minorVer = BinReadInt(num)         'Minor version (ie 2.0)
        If majorVer <> major Then MsgBox "This Character was created with an unrecognised version of the Toolkit", , "Unable to open Character": Close #num: Exit Sub
        
        thePlayer.charname$ = BinReadString(num)
        thePlayer.experienceVar$ = BinReadString(num)
        thePlayer.defenseVar$ = BinReadString(num)
        thePlayer.fightVar$ = BinReadString(num)
        thePlayer.healthVar$ = BinReadString(num)
        thePlayer.maxHealthVar$ = BinReadString(num)
        thePlayer.nameVar$ = BinReadString(num)
        thePlayer.smVar$ = BinReadString(num)
        thePlayer.smMaxVar$ = BinReadString(num)
        thePlayer.leVar$ = BinReadString(num)
        thePlayer.initExperience = BinReadLong(num)
        thePlayer.initHealth = BinReadLong(num)
        thePlayer.initMaxHealth = BinReadLong(num)
        thePlayer.initDefense = BinReadLong(num)
        thePlayer.initFight = BinReadLong(num)
        thePlayer.initSm = BinReadLong(num)
        thePlayer.initSmMax = BinReadLong(num)
        thePlayer.initLevel = BinReadLong(num)
        thePlayer.profilePic$ = BinReadString(num)
        Dim t As Long
        For t = 0 To 200
            thePlayer.smlist(t) = BinReadString(num)
            thePlayer.spcMinExp(t) = BinReadLong(num)
            thePlayer.spcMinLevel(t) = BinReadLong(num)
            thePlayer.spcVar(t) = BinReadString(num)
            thePlayer.spcEquals(t) = BinReadString(num)
        Next t
        thePlayer.specialMoveName = BinReadString(num)
        thePlayer.smYN = BinReadByte(num)
        For t = 0 To 10
            thePlayer.accessoryName(t) = BinReadString(num)
        Next t
        For t = 0 To 6
            thePlayer.armorType(t) = BinReadByte(num)
        Next t
        If minorVer = 3 Then
            thePlayer.levelType = BinReadByte(num)
        Else
            thePlayer.levelType = BinReadLong(num)
        End If
        thePlayer.experienceIncrease = BinReadInt(num)
        thePlayer.maxLevel = BinReadLong(num)
        thePlayer.levelHp = BinReadInt(num)
        thePlayer.levelDp = BinReadInt(num)
        thePlayer.levelFp = BinReadInt(num)
        thePlayer.levelSm = BinReadInt(num)
        
        If minorVer < 5 Then
            'in version 3, sounds are embedded in the player's animations
            'we'll get the sounds from the version 2 character and embed them in the animations we'll create
            swipeWav = BinReadString(num)
            defendWav = BinReadString(num)
            smWav = BinReadString(num)
            deadWav = BinReadString(num)
        End If
        
        thePlayer.charLevelUpRPGCode = BinReadString(num)
        thePlayer.charLevelUpType = BinReadByte(num)
        thePlayer.charSizeType = BinReadByte(num)
        
        If minorVer >= 5 Then
            'version 3.0 character
            For t = 0 To UBound(thePlayer.gfx)
                thePlayer.gfx(t) = BinReadString(num)
            Next t
            
            Dim cnt As Long
            cnt = BinReadLong(num)
            For t = 0 To cnt
                Dim an As String, handle As String
                an$ = BinReadString(num)
                handle$ = BinReadString(num)
                Call playerAddCustomGfx(thePlayer, handle$, an$)
            Next t
        Else
            'old version 2 char (convert the gfx to animations and tile bitmaps
            ReDim walkGfx(15, 1) As String      'walking graphics filenames (64x32) (xx,0 or 1) 0=top, 1=bottom
            ReDim fightingGfx(3, 1, 1) As String 'fight gfx filenames (64x64) (xx,yy ,0 or 1)
            ReDim defenseGfx(3, 1, 1) As String  'def gfx filenames (64x64) (xx,yy ,0 or 1)
            ReDim specialGfx(3, 1, 1) As String  'special move gfx filenames (64x64) (xx,yy ,0 or 1)
            ReDim deathGfx(3, 1, 1) As String    'death gfx filenames (64x64) (xx,yy ,0 or 1)
            ReDim fightRestGfx(1, 1) As String   'fight at rest gfx (64x64) (xx,yy ,0 or 1)
            ReDim customisedGfx(9, 1) As String  'custom graphics(64x32) (0 or 1) 0=top, 1=bottom
            
            'WALKING GFX
            Call AnimationClear(anm)
            anm.animSizeX = 32
            anm.animSizeY = 64
            anm.animPause = 0.167
                                             
            Dim xx As Long, walkFix As String, anmName As String, tbmName As String
            xx = 0
            walkFix$ = "S"
            For X = 0 To 15
                anmName$ = replace(RemovePath(file$), ".", "_") + "_walk_" + walkFix$ + "_" + ".anm"
                anmName$ = projectPath$ + miscPath$ + anmName$
                
                tbmName$ = replace(RemovePath(file$), ".", "_") + "_walk_" + toString(X) + ".tbm"
                tbmName$ = projectPath$ + bmpPath$ + tbmName$
                
                Call TileBitmapClear(tbm)
                Call TileBitmapResize(tbm, 1, 2)
                For Y = 0 To 1
                    walkGfx(X, Y) = BinReadString(num)
                Next Y
                tbm.tiles(0, 0) = walkGfx(X, 0)
                tbm.tiles(0, 1) = walkGfx(X, 1)
                Call SaveTileBitmap(tbmName$, tbm)
                anm.animFrame(xx) = RemovePath(tbmName$)
                
                If X = 3 Then
                    walkFix$ = "E"
                    Call saveAnimation(anmName$, anm)
                    thePlayer.gfx(PLYR_WALK_S) = RemovePath(anmName$)
                    xx = -1
                End If
                If X = 7 Then
                    walkFix$ = "N"
                    Call saveAnimation(anmName$, anm)
                    thePlayer.gfx(PLYR_WALK_E) = RemovePath(anmName$)
                    xx = -1
                End If
                If X = 11 Then
                    walkFix$ = "W"
                    Call saveAnimation(anmName$, anm)
                    thePlayer.gfx(PLYR_WALK_N) = RemovePath(anmName$)
                    xx = -1
                End If
                If X = 15 Then
                    Call saveAnimation(anmName$, anm)
                    thePlayer.gfx(PLYR_WALK_W) = RemovePath(anmName$)
                    xx = -1
                End If
                xx = xx + 1
            Next X
            
            'FIGHT, DEF, SPC, DEATH GFX (64x64)
            anmFight.animSizeX = 64: anmFight.animSizeY = 64
            anmDef.animSizeX = 64: anmDef.animSizeY = 64
            anmSPC.animSizeX = 64: anmSPC.animSizeY = 64
            anmDead.animSizeX = 64: anmDead.animSizeY = 64
            anmFight.animPause = 0.167
            anmDef.animPause = 0.167
            anmSPC.animPause = 0.167
            anmDead.animPause = 0.167
            For X = 0 To 3
                Call TileBitmapClear(tbmFight)
                Call TileBitmapClear(tbmDef)
                Call TileBitmapClear(tbmSPC)
                Call TileBitmapClear(tbmDead)
                Call TileBitmapResize(tbmFight, 2, 2)
                Call TileBitmapResize(tbmDef, 2, 2)
                Call TileBitmapResize(tbmSPC, 2, 2)
                Call TileBitmapResize(tbmDead, 2, 2)
                
                Dim z As Long
                For Y = 0 To 1
                    For z = 0 To 1
                        fightingGfx(X, Y, z) = BinReadString(num)
                        defenseGfx(X, Y, z) = BinReadString(num)
                        specialGfx(X, Y, z) = BinReadString(num)
                        deathGfx(X, Y, z) = BinReadString(num)
                        
                        tbmFight.tiles(Y, z) = fightingGfx(X, Y, z)
                        tbmDef.tiles(Y, z) = defenseGfx(X, Y, z)
                        tbmSPC.tiles(Y, z) = specialGfx(X, Y, z)
                        tbmDead.tiles(Y, z) = deathGfx(X, Y, z)
                    Next z
                Next Y
                
                'now save those tile bitmaps...
                tbmName$ = replace(RemovePath(file$), ".", "_") + "_fight_" + toString(X) + ".tbm"
                Call SaveTileBitmap(projectPath$ + bmpPath$ + tbmName$, tbmFight)
                anmFight.animFrame(X) = tbmName$
            
                tbmName$ = replace(RemovePath(file$), ".", "_") + "_defense_" + toString(X) + ".tbm"
                Call SaveTileBitmap(projectPath$ + bmpPath$ + tbmName$, tbmDef)
                anmDef.animFrame(X) = tbmName$
            
                tbmName$ = replace(RemovePath(file$), ".", "_") + "_spc_" + toString(X) + ".tbm"
                Call SaveTileBitmap(projectPath$ + bmpPath$ + tbmName$, tbmSPC)
                anmSPC.animFrame(X) = tbmName$
            
                tbmName$ = replace(RemovePath(file$), ".", "_") + "_death_" + toString(X) + ".tbm"
                Call SaveTileBitmap(projectPath$ + bmpPath$ + tbmName$, tbmDead)
                anmDead.animFrame(X) = tbmName$
            Next X
            'now save the animations...
            anmName$ = replace(RemovePath(file$), ".", "_") + "_fight" + ".anm"
            anmFight.animSound(0) = swipeWav
            Call saveAnimation(projectPath$ + miscPath$ + anmName$, anmFight)
            thePlayer.gfx(PLYR_FIGHT) = anmName$
            
            anmName$ = replace(RemovePath(file$), ".", "_") + "_defense" + ".anm"
            anmDef.animSound(0) = defendWav
            Call saveAnimation(projectPath$ + miscPath$ + anmName$, anmDef)
            thePlayer.gfx(PLYR_DEFEND) = anmName$
            
            anmName$ = replace(RemovePath(file$), ".", "_") + "_spc" + ".anm"
            anmSPC.animSound(0) = smWav
            Call saveAnimation(projectPath$ + miscPath$ + anmName$, anmSPC)
            thePlayer.gfx(PLYR_SPC) = anmName$
            
            anmName$ = replace(RemovePath(file$), ".", "_") + "_death" + ".anm"
            anmDead.animSound(0) = deadWav
            Call saveAnimation(projectPath$ + miscPath$ + anmName$, anmDead)
            thePlayer.gfx(PLYR_DIE) = anmName$
            
            'REST GFX
            Call TileBitmapClear(tbm)
            Call TileBitmapResize(tbm, 2, 2)
            Call AnimationClear(anm)
            anm.animSizeX = 64: anm.animSizeY = 64
            For X = 0 To 1
                For Y = 0 To 1
                    fightRestGfx(X, Y) = BinReadString(num)
                    tbm.tiles(X, Y) = fightRestGfx(X, Y)
                Next Y
            Next X
            tbmName$ = replace(RemovePath(file$), ".", "_") + "_rest" + ".tbm"
            Call SaveTileBitmap(projectPath$ + bmpPath$ + tbmName$, tbm)
            anm.animFrame(0) = tbmName$
            anmName$ = replace(RemovePath(file$), ".", "_") + "_rest" + ".anm"
            Call saveAnimation(projectPath$ + miscPath$ + anmName$, anm)
            thePlayer.gfx(PLYR_REST) = anmName$
            
            'CUSTOM GFX
            Call TileBitmapClear(tbm)
            Call TileBitmapResize(tbm, 1, 2)
            Call AnimationClear(anm)
            anm.animSizeX = 32: anm.animSizeY = 64
            For X = 0 To 9
                For Y = 0 To 1
                    customisedGfx(X, Y) = BinReadString(num)
                    tbm.tiles(0, Y) = customisedGfx(X, Y)
                Next Y
                If tbm.tiles(0, 0) = "" And tbm.tiles(0, 1) = "" Then
                    'nothing there
                Else
                    tbmName$ = replace(RemovePath(file$), ".", "_") + "_custom_" + toString(X) + ".tbm"
                    Call SaveTileBitmap(projectPath$ + bmpPath$ + tbmName$, tbm)
                    anm.animFrame(0) = tbmName$
                    anmName$ = replace(RemovePath(file$), ".", "_") + "_custom_" + toString(X) + ".anm"
                    Call saveAnimation(projectPath$ + miscPath$ + anmName$, anm)
                    'thePlayer.customgfx(x) = anmname$
                    Call playerAddCustomGfx(thePlayer, "Custom " + toString(X), anmName$)
                End If
            Next X
        End If
    
    Exit Sub
    
ver2oldchar:
    ReDim walkGfx(15, 1) As String      'walking graphics filenames (64x32) (xx,0 or 1) 0=top, 1=bottom
    ReDim fightingGfx(3, 1, 1) As String 'fight gfx filenames (64x64) (xx,yy ,0 or 1)
    ReDim defenseGfx(3, 1, 1) As String  'def gfx filenames (64x64) (xx,yy ,0 or 1)
    ReDim specialGfx(3, 1, 1) As String  'special move gfx filenames (64x64) (xx,yy ,0 or 1)
    ReDim deathGfx(3, 1, 1) As String    'death gfx filenames (64x64) (xx,yy ,0 or 1)
    ReDim fightRestGfx(1, 1) As String   'fight at rest gfx (64x64) (xx,yy ,0 or 1)
    ReDim customisedGfx(9, 1) As String  'custom graphics(64x32) (0 or 1) 0=top, 1=bottom
    
    Open file$ For Input As #num
        Input #num, fileHeader$        'Filetype
        If fileHeader$ <> "RPGTLKIT CHAR" Then Close #num: GoTo Version1Char
        Input #num, majorVer           'Version
        Input #num, minorVer           'Minor version (ie 2.0)
        If majorVer <> major Then MsgBox "This Character was created with an unrecognised version of the Toolkit", , "Unable to open Character": Close #num: Exit Sub
        thePlayer.charname = fread(num)    'Charactername
        thePlayer.experienceVar$ = fread(num)
        thePlayer.defenseVar$ = fread(num)
        thePlayer.fightVar$ = fread(num)           'FP variable
        thePlayer.healthVar$ = fread(num)          'HP variable
        thePlayer.maxHealthVar$ = fread(num)       'Max HP var
        thePlayer.nameVar$ = fread(num)            'Character name variable
        thePlayer.smVar$ = fread(num)              'Special Move power variable
        thePlayer.smMaxVar$ = fread(num)           'Sp'l Move maximum variable.
        thePlayer.leVar$ = fread(num)              'Level variable
        thePlayer.initExperience = fread(num)      'Initial Experience Level
        thePlayer.initHealth = fread(num)          'Initial health level
        thePlayer.initMaxHealth = fread(num)       'Initial maximum health level
        thePlayer.initDefense = fread(num)         'Initial DP
        thePlayer.initFight = fread(num)           'Initial FP
        thePlayer.initSm = fread(num)               'Initial SM power
        thePlayer.initSmMax = fread(num)            'Initial Max SM power.
        thePlayer.initLevel = fread(num)            'Initial level
        thePlayer.profilePic$ = fread(num)           'Profilepicture
        For t = 0 To 200
            thePlayer.smlist$(t) = fread(num)         'Special Move list (200 in total!)
            thePlayer.spcMinExp(t) = fread(num)      'minimum experience for each move
            thePlayer.spcMinLevel(t) = fread(num)    'min level for each move
            thePlayer.spcVar$(t) = fread(num)        'conditional variable for each special move
            thePlayer.spcEquals$(t) = fread(num)     'condition of variable for each special move.
        Next t
        thePlayer.specialMoveName$ = fread(num)     'Name of special move
        thePlayer.smYN = fread(num)                 'does he do special moves? 0-Y, 1-N
        If minorVer > 0 Then
            thePlayer.charSizeType = fread(num)     'size type:0- 32x32, 1-64x32
        End If
        If thePlayer.charSizeType = 0 Then
            'we don't support charSizeType 0 (32x32) anymore
            'we will extract the embedded gfx and save them as a tileset.
            thePlayer.charSizeType = 1
            
            Dim tstPos As Long
            tstPos = 1
            For X = 1 To 32
                For Y = 1 To 32
                    tileMem(X, Y) = fread(num)
                Next Y
            Next X
            Call createNewTileSet(tstName$)
            'walkGfx32$(0) = RemovePath(tstname$) + toString(tstPos)
            walkGfx$(0, 0) = ""
            walkGfx$(0, 1) = RemovePath(tstName$) + toString(tstPos)
            tstPos = tstPos + 1
            
            For t = 1 To 15
                For X = 1 To 32
                    For Y = 1 To 32
                        tileMem(X, Y) = fread(num)
                    Next Y
                Next X
                Call addToTileSet(tstName$)
                'walkGfx32$(t) = RemovePath$(tstname$) + toString(tstPos)
                walkGfx$(t, 0) = ""
                walkGfx$(t, 1) = RemovePath(tstName$) + toString(tstPos)
                tstPos = tstPos + 1
            Next t
            
            Dim fgfx(32, 32, 4) As Long
            Dim sgfx(32, 32, 4) As Long
            Dim defgfx(32, 32, 4) As Long
            Dim diegfx(32, 32, 4) As Long
            For t = 1 To 4
                For X = 1 To 32
                    For Y = 1 To 32
                        Input #num, fgfx(X, Y, t) 'Character Fighting Graphics
                        Input #num, sgfx(X, Y, t) 'Character Sp'l Move Graphics
                        Input #num, defgfx(X, Y, t) 'Character Defence Graphics
                        Input #num, diegfx(X, Y, t) 'Character Dead Graphics
                    Next Y
                Next X
            Next t
            For t = 1 To 4
                For X = 1 To 32
                    For Y = 1 To 32
                        tileMem(X, Y) = fgfx(X, Y, t)
                    Next Y
                Next X
                Call addToTileSet(tstName$)
                'fightGfx32$(t - 1) = RemovePath$(tstname$) + toString(tstPos)
                fightingGfx$(t - 1, 0, 0) = ""
                fightingGfx$(t - 1, 0, 1) = ""
                fightingGfx$(t - 1, 1, 0) = ""
                fightingGfx$(t - 1, 1, 1) = RemovePath$(tstName$) + toString(tstPos)
                tstPos = tstPos + 1
            Next t
            For t = 1 To 4
                For X = 1 To 32
                    For Y = 1 To 32
                        tileMem(X, Y) = sgfx(X, Y, t)
                    Next Y
                Next X
                Call addToTileSet(tstName$)
                'smGfx32$(t - 1) = RemovePath$(tstname$) + toString(tstPos)
                specialGfx$(t - 1, 0, 0) = ""
                specialGfx$(t - 1, 0, 1) = ""
                specialGfx$(t - 1, 1, 0) = ""
                specialGfx$(t - 1, 1, 1) = RemovePath$(tstName$) + toString(tstPos)
                tstPos = tstPos + 1
            Next t
            For t = 1 To 4
                For X = 1 To 32
                    For Y = 1 To 32
                        tileMem(X, Y) = defgfx(X, Y, t)
                    Next Y
                Next X
                Call addToTileSet(tstName$)
                'defGfx32$(t - 1) = RemovePath$(tstname$) + toString(tstPos)
                defenseGfx$(t - 1, 0, 0) = ""
                defenseGfx$(t - 1, 0, 1) = ""
                defenseGfx$(t - 1, 1, 0) = ""
                defenseGfx$(t - 1, 1, 1) = RemovePath$(tstName$) + toString(tstPos)
                tstPos = tstPos + 1
            Next t
            For t = 1 To 4
                For X = 1 To 32
                    For Y = 1 To 32
                        tileMem(X, Y) = diegfx(X, Y, t)
                    Next Y
                Next X
                Call addToTileSet(tstName$)
                'dieGfx32$(t - 1) = RemovePath$(tstname$) + toString(tstPos)
                deathGfx$(t - 1, 0, 0) = ""
                deathGfx$(t - 1, 0, 1) = ""
                deathGfx$(t - 1, 1, 0) = ""
                deathGfx$(t - 1, 1, 1) = RemovePath$(tstName$) + toString(tstPos)
                tstPos = tstPos + 1
            Next t
            
            For X = 1 To 32
                For Y = 1 To 32
                    tileMem(X, Y) = fread(num)
                Next Y
            Next X
            Call addToTileSet(tstName$)
            'restGfx32$ = RemovePath$(tstname$) + toString(tstPos)
            fightRestGfx$(0, 0) = ""
            fightRestGfx$(0, 1) = ""
            fightRestGfx$(1, 0) = ""
            fightRestGfx$(1, 1) = RemovePath$(tstName$) + toString(tstPos)
            tstPos = tstPos + 1
            
            For t = 0 To 9
                For X = 1 To 32
                    For Y = 1 To 32
                        tileMem(X, Y) = fread(num)
                    Next Y
                Next X
                Call addToTileSet(tstName$)
                customisedGfx$(t, 0) = ""
                customisedGfx$(t, 1) = RemovePath$(tstName$) + toString(tstPos)
                tstPos = tstPos + 1
            Next t
        Else
            'char size =64x32
            Dim u As Long
            For t = 0 To 15
                For u = 0 To 1
                    walkGfx$(t, u) = fread(num)   'walking graphics filenames (64x32) (xx,0 or 1) 0=top, 1=bottom
                Next u
            Next t
            If minorVer = 1 Then
                For u = 0 To 1
                    For t = 0 To 3
                        fightingGfx$(t, 1, u) = fread(num) 'fight gfx filenames (64x32) (xx,0 or 1) o=top, 1=bottom
                        defenseGfx$(t, 1, u) = fread(num) 'def gfx filenames (64x32) (xx,0 or 1) 0=top, 1=bottom
                        specialGfx$(t, 1, u) = fread(num) 'special move gfx filenames (64x32) (xx,0 or 1) 0=top, 1=bottom
                        deathGfx$(t, 1, u) = fread(num)  'death gfx filenames (64x32) (xx,0 or 1) 0=top, 1=bottom
                        fightingGfx$(t, 0, u) = ""
                        defenseGfx$(t, 0, u) = ""
                        specialGfx$(t, 0, u) = ""
                        deathGfx$(t, 0, u) = ""
                    Next t
                Next u
                For u = 0 To 1
                    fightRestGfx$(1, u) = fread(num)     'fight at rest gfx (64x32) (0 or 1) 0=top, 1=bottom
                    fightRestGfx$(0, u) = ""
                Next u
            Else
                'version 2.2-- 64x64 fight gfx
                Dim v As Long
                For u = 0 To 1
                    For v = 0 To 1
                        For t = 0 To 3
                            fightingGfx$(t, u, v) = fread(num) 'fight gfx filenames (64x32) (xx,0 or 1) o=top, 1=bottom
                            defenseGfx$(t, u, v) = fread(num) 'def gfx filenames (64x32) (xx,0 or 1) 0=top, 1=bottom
                            specialGfx$(t, u, v) = fread(num) 'special move gfx filenames (64x32) (xx,0 or 1) 0=top, 1=bottom
                            deathGfx$(t, u, v) = fread(num)  'death gfx filenames (64x32) (xx,0 or 1) 0=top, 1=bottom
                        Next t
                    Next v
                Next u
                For u = 0 To 1
                    For v = 0 To 1
                        fightRestGfx$(u, v) = fread(num)     'fight at rest gfx (64x32) (0 or 1) 0=top, 1=bottom
                    Next v
                Next u
            End If
            For t = 0 To 9
                For u = 0 To 1
                    customisedGfx$(t, u) = fread(num) 'custom graphics(64x32) (0 or 1) 0=top, 1=bottom
                Next u
            Next t
        End If
        For t = 1 To 10
            thePlayer.accessoryName$(t) = fread(num)   'Names of 10 accessories.
        Next t
        For t = 1 To 6
            thePlayer.armorType(t) = fread(num)        'Is ARMOURTYPE used (0-N,1-Y).  Armour types are:
                            '1-head,2-neck,3-lh,4-rh,5-body,6-legs
        Next t
        thePlayer.levelType = fread(num)            'Level progression type:0- quad, 1- linear
        thePlayer.experienceIncrease = fread(num)   'Experience increase Factor
        thePlayer.maxLevel = fread(num)             'Maximum level.
        thePlayer.levelHp = fread(num)             'HP Increases by % on each level up
        thePlayer.levelDp = fread(num)             'dP Increases by % on each level up
        thePlayer.levelFp = fread(num)             'fP Increases by % on each level up
        thePlayer.levelSm = fread(num)             'smP Increases by % on each level up
        swipeWav$ = fread(num)            'filename of swipe wav
        defendWav$ = fread(num)           'filename of def wav
        smWav$ = fread(num)               'filename of sm wav
        deadWav$ = fread(num)              'filename of die wav
        thePlayer.charLevelUpRPGCode$ = fread(num) 'rpgcode level up prg
        thePlayer.charLevelUpType = fread(num)     'level up type
    Close #num
    'now convert the gfx to animations...
    'WALKING GFX
    Call AnimationClear(anm)
    anm.animSizeX = 32
    anm.animSizeY = 64
    anm.animPause = 0.167
                                     
    xx = 0
    walkFix$ = "S"
    For X = 0 To 15
        anmName$ = replace(RemovePath(file$), ".", "_") + "_walk_" + walkFix$ + "_" + ".anm"
        anmName$ = projectPath$ + miscPath$ + anmName$
        
        tbmName$ = replace(RemovePath(file$), ".", "_") + "_walk_" + toString(X) + ".tbm"
        tbmName$ = projectPath$ + bmpPath$ + tbmName$
        
        Call TileBitmapClear(tbm)
        Call TileBitmapResize(tbm, 1, 2)
        tbm.tiles(0, 0) = walkGfx(X, 0)
        tbm.tiles(0, 1) = walkGfx(X, 1)
        Call SaveTileBitmap(tbmName$, tbm)
        anm.animFrame(xx) = RemovePath(tbmName$)
        
        If X = 3 Then
            walkFix$ = "E"
            Call saveAnimation(anmName$, anm)
            thePlayer.gfx(PLYR_WALK_S) = RemovePath(anmName$)
            xx = -1
        End If
        If X = 7 Then
            walkFix$ = "N"
            Call saveAnimation(anmName$, anm)
            thePlayer.gfx(PLYR_WALK_E) = RemovePath(anmName$)
            xx = -1
        End If
        If X = 11 Then
            walkFix$ = "W"
            Call saveAnimation(anmName$, anm)
            thePlayer.gfx(PLYR_WALK_N) = RemovePath(anmName$)
            xx = -1
        End If
        If X = 15 Then
            Call saveAnimation(anmName$, anm)
            thePlayer.gfx(PLYR_WALK_W) = RemovePath(anmName$)
            xx = -1
        End If
        xx = xx + 1
    Next X
    
    'FIGHT, DEF, SPC, DEATH GFX (64x64)
    anmFight.animSizeX = 64: anmFight.animSizeY = 64
    anmDef.animSizeX = 64: anmDef.animSizeY = 64
    anmSPC.animSizeX = 64: anmSPC.animSizeY = 64
    anmDead.animSizeX = 64: anmDead.animSizeY = 64
    anmFight.animPause = 0.167
    anmDef.animPause = 0.167
    anmSPC.animPause = 0.167
    anmDead.animPause = 0.167
    For X = 0 To 3
        Call TileBitmapClear(tbmFight)
        Call TileBitmapClear(tbmDef)
        Call TileBitmapClear(tbmSPC)
        Call TileBitmapClear(tbmDead)
        Call TileBitmapResize(tbmFight, 2, 2)
        Call TileBitmapResize(tbmDef, 2, 2)
        Call TileBitmapResize(tbmSPC, 2, 2)
        Call TileBitmapResize(tbmDead, 2, 2)
        
        For Y = 0 To 1
            For z = 0 To 1
                tbmFight.tiles(Y, z) = fightingGfx(X, Y, z)
                tbmDef.tiles(Y, z) = defenseGfx(X, Y, z)
                tbmSPC.tiles(Y, z) = specialGfx(X, Y, z)
                tbmDead.tiles(Y, z) = deathGfx(X, Y, z)
            Next z
        Next Y
        
        'now save those tile bitmaps...
        tbmName$ = replace(RemovePath(file$), ".", "_") + "_fight_" + toString(X) + ".tbm"
        Call SaveTileBitmap(projectPath$ + bmpPath$ + tbmName$, tbmFight)
        anmFight.animFrame(X) = tbmName$
    
        tbmName$ = replace(RemovePath(file$), ".", "_") + "_defense_" + toString(X) + ".tbm"
        Call SaveTileBitmap(projectPath$ + bmpPath$ + tbmName$, tbmDef)
        anmDef.animFrame(X) = tbmName$
    
        tbmName$ = replace(RemovePath(file$), ".", "_") + "_spc_" + toString(X) + ".tbm"
        Call SaveTileBitmap(projectPath$ + bmpPath$ + tbmName$, tbmSPC)
        anmSPC.animFrame(X) = tbmName$
    
        tbmName$ = replace(RemovePath(file$), ".", "_") + "_death_" + toString(X) + ".tbm"
        Call SaveTileBitmap(projectPath$ + bmpPath$ + tbmName$, tbmDead)
        anmDead.animFrame(X) = tbmName$
    Next X
    'now save the animations...
    anmName$ = replace(RemovePath(file$), ".", "_") + "_fight" + ".anm"
    anmFight.animSound(0) = swipeWav
    Call saveAnimation(projectPath$ + miscPath$ + anmName$, anmFight)
    thePlayer.gfx(PLYR_FIGHT) = anmName$
    
    anmName$ = replace(RemovePath(file$), ".", "_") + "_defense" + ".anm"
    anmDef.animSound(0) = defendWav
    Call saveAnimation(projectPath$ + miscPath$ + anmName$, anmDef)
    thePlayer.gfx(PLYR_DEFEND) = anmName$
    
    anmName$ = replace(RemovePath(file$), ".", "_") + "_spc" + ".anm"
    anmSPC.animSound(0) = smWav
    Call saveAnimation(projectPath$ + miscPath$ + anmName$, anmSPC)
    thePlayer.gfx(PLYR_SPC) = anmName$
    
    anmName$ = replace(RemovePath(file$), ".", "_") + "_death" + ".anm"
    anmDead.animSound(0) = deadWav
    Call saveAnimation(projectPath$ + miscPath$ + anmName$, anmDead)
    thePlayer.gfx(PLYR_DIE) = anmName$
    
    'REST GFX
    Call TileBitmapClear(tbm)
    Call TileBitmapResize(tbm, 2, 2)
    Call AnimationClear(anm)
    anm.animSizeX = 64: anm.animSizeY = 64
    For X = 0 To 1
        For Y = 0 To 1
            tbm.tiles(X, Y) = fightRestGfx(X, Y)
        Next Y
    Next X
    tbmName$ = replace(RemovePath(file$), ".", "_") + "_rest" + ".tbm"
    Call SaveTileBitmap(projectPath$ + bmpPath$ + tbmName$, tbm)
    anm.animFrame(0) = tbmName$
    anmName$ = replace(RemovePath(file$), ".", "_") + "_rest" + ".anm"
    Call saveAnimation(projectPath$ + miscPath$ + anmName$, anm)
    thePlayer.gfx(PLYR_REST) = anmName$
    
    'CUSTOM GFX
    Call TileBitmapClear(tbm)
    Call TileBitmapResize(tbm, 1, 2)
    Call AnimationClear(anm)
    anm.animSizeX = 32: anm.animSizeY = 64
    For X = 0 To 9
        For Y = 0 To 1
            tbm.tiles(0, Y) = customisedGfx(X, Y)
        Next Y
        If tbm.tiles(0, 0) = "" And tbm.tiles(0, 1) = "" Then
            'nothing there
            thePlayer.customGfx(X) = ""
        Else
            tbmName$ = replace(RemovePath(file$), ".", "_") + "_custom_" + toString(X) + ".tbm"
            Call SaveTileBitmap(projectPath$ + bmpPath$ + tbmName$, tbm)
            anm.animFrame(0) = tbmName$
            anmName$ = replace(RemovePath(file$), ".", "_") + "_custom_" + toString(X) + ".anm"
            Call saveAnimation(projectPath$ + miscPath$ + anmName$, anm)
            Call playerAddCustomGfx(thePlayer, "Custom " + toString(X), anmName$)
        End If
    Next X
    
    For X = 0 To 32
        For Y = 0 To 32
            tileMem(X, Y) = bufTile(X, Y)
        Next Y
    Next X

    detail = oldDetail
    
    Exit Sub

Version1Char:
Close #num

End Sub

Sub PlayerClear(ByRef thePlayer As TKPlayer)
    On Error Resume Next

    thePlayer.charname = ""
    thePlayer.experienceVar = ""
    thePlayer.defenseVar = ""
    thePlayer.fightVar = ""
    thePlayer.healthVar = ""
    thePlayer.maxHealthVar = ""
    thePlayer.nameVar = ""
    thePlayer.smVar = ""
    thePlayer.smMaxVar = ""
    thePlayer.leVar = ""
    thePlayer.initExperience = 0
    thePlayer.initHealth = 0
    thePlayer.initMaxHealth = 0
    thePlayer.initDefense = 0
    thePlayer.initFight = 0
    thePlayer.initSm = 0
    thePlayer.initSmMax = 0
    thePlayer.initLevel = 0
    thePlayer.profilePic = ""
    Dim t As Long
    For t = 0 To 200
        thePlayer.smlist(t) = ""
    Next t
    thePlayer.specialMoveName = ""
    thePlayer.smYN = 0
    For t = 0 To 200
        thePlayer.spcMinExp(t) = 0
        thePlayer.spcMinLevel(t) = 0
        thePlayer.spcVar(t) = ""
        thePlayer.spcEquals(t) = ""
    Next t
    For t = 0 To 10
        thePlayer.accessoryName(t) = ""
    Next t
    For t = 0 To 6
        thePlayer.armorType(t) = 0
    Next t
    thePlayer.levelType = 0
    thePlayer.experienceIncrease = 0
    thePlayer.maxLevel = 0
    thePlayer.levelHp = 0
    thePlayer.levelDp = 0
    thePlayer.levelFp = 0
    thePlayer.levelSm = 0
    thePlayer.charLevelUpRPGCode = ""
    thePlayer.charLevelUpType = 0
    thePlayer.charSizeType = 0
    
    For t = 0 To UBound(thePlayer.gfx)
        thePlayer.gfx(t) = ""
    Next t
    For t = 0 To UBound(thePlayer.customGfx)
        thePlayer.customGfx(t) = ""
    Next t
    ReDim thePlayer.customGfx(5)
    ReDim thePlayer.customGfxNames(5)

    Call PlayerClearAllStatus(thePlayer)
End Sub



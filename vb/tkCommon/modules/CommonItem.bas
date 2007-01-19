Attribute VB_Name = "CommonItem"
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

'=========================================================================
' RPGToolkit item file format (*.itm)
'=========================================================================

Option Explicit

'=========================================================================
' Member constants
'=========================================================================
Public Const ITEM_WALK_S = 0
Public Const ITEM_WALK_N = 1
Public Const ITEM_WALK_E = 2
Public Const ITEM_WALK_W = 3
Public Const ITEM_WALK_NW = 4
Public Const ITEM_WALK_NE = 5
Public Const ITEM_WALK_SW = 6
Public Const ITEM_WALK_SE = 7
Public Const ITEM_REST = 8

Private Const ITM_MINOR = 7         'Minor version, 3.0.7 (vectors)

'=========================================================================
' An item
'=========================================================================
Public Type TKItem
    itemName As String              'Item name (handle)
    itmDescription As String        'description of item (one-line string)
    EquipYN As Byte                 'Equipable item? 0- No, 1- yes
    MenuYN As Byte                  'Menu item? 0-No, 1-Y
    BoardYN As Byte                 'Board item? 0-N, 1-Y
    FightYN As Byte                 'Battle item? 0-N, 1-Y
    usedBy As Byte                  'Item used by 0-all 1-defined
    itmChars(50) As String          '50 characters who can use the item
    buyPrice As Long                'price to buy at
    sellPrice As Long               'price to sell at
    keyItem As Byte                 'is it a key item (0-no, 1-yes)
    itemArmor(7) As Byte            'Equip on what body locations? 1-7 (head->accessory)
    accessory As String             'Accessory name
    equipHP As Long                 'Hp increase when equipped
    equipDP As Long                 'dp increase when equipped
    equipFP As Long                 'fp increase when equipped
    equipSM As Long                 'sm increase when equipped
    prgEquip As String              'prg to run when equipped
    prgRemove As String             'prg to run when remobed
    mnuHPup As Long                 'HP increase when used from menu
    mnuSMup As Long                 'SMP increase wjen used from menu
    mnuUse As String                'program to run when used from menu
    fgtHPup As Long                 'HP increase when used from fight
    fgtSMup As Long                 'SMP increase wjen used from fight
    fgtUse As String                'program to run when used from fight
    itmAnimation As String          'animation for battle
    itmPrgOnBoard As String         'Program to run while item is on board
    itmPrgPickUp As String          'Program to run when picked up.
    itmSizeType As Byte             'graphics size type 0=32x32, 1=64x32
    gfx(9) As String                'filenames of standard animations for graphics
    customGfx() As String           'customized animations
    customGfxNames() As String      'customized animations (handles)
    standingGfx(7) As String        'Filenames of the standing animations/graphics
    idleTime As Double              'Seconds to wait proir to switching to
                                    'STAND_ graphics
    speed As Double                 'Speed of this item
    
    loopSpeed As Long               '.speed converted to loops (3.0.5)
    
    vBase As CVector                'Interaction vectors - 3.0.7
    vActivate As CVector
    
#If isToolkit = 0 Then
    bIsActive As Boolean            'is item active?
#End If
End Type

'=========================================================================
' An item document
'=========================================================================
Public Type itemDoc
    itemFile As String        'filename
    itemNeedUpdate As Boolean 'needs saving?
    itmLayTile As Boolean     'about to lay a tile?
    theData As TKItem         'the item data
End Type

'=========================================================================
' Check if an item is equippable
'=========================================================================
Public Function canItemEquip(ByVal file As String) As Boolean
    canItemEquip = (openItem(file$).EquipYN = 1)
End Function

'=========================================================================
' Get an item stance
'=========================================================================
Public Function itemGetStanceAnm(ByVal stance As String, ByRef theItem As TKItem) As String

    On Error Resume Next

    Dim toRet As String
    stance = UCase$(stance)

    With theItem

        Select Case stance

            Case "STAND_S":
                toRet = .standingGfx(ITEM_WALK_S)
                If LenB(toRet) = 0 Then toRet = .gfx(ITEM_WALK_S)
            Case "STAND_N":
                toRet = .standingGfx(ITEM_WALK_N)
                If LenB(toRet) = 0 Then toRet = .gfx(ITEM_WALK_N)
            Case "STAND_E":
                toRet = .standingGfx(ITEM_WALK_E)
                If LenB(toRet) = 0 Then toRet = .gfx(ITEM_WALK_E)
            Case "STAND_W":
                toRet = .standingGfx(ITEM_WALK_W)
                If LenB(toRet) = 0 Then toRet = .gfx(ITEM_WALK_W)
            Case "STAND_NW":
                toRet = .standingGfx(ITEM_WALK_NW)
                If LenB(toRet) = 0 Then
                    toRet = .standingGfx(ITEM_WALK_W)
                End If
                If LenB(toRet) = 0 Then toRet = .gfx(ITEM_WALK_NW)
                If LenB(toRet) = 0 Then toRet = .gfx(ITEM_WALK_W)
            Case "STAND_NE":
                toRet = .standingGfx(ITEM_WALK_NE)
                If LenB(toRet) = 0 Then
                    toRet = .standingGfx(ITEM_WALK_E)
                End If
                If LenB(toRet) = 0 Then toRet = .gfx(ITEM_WALK_NE)
                If LenB(toRet) = 0 Then toRet = .gfx(ITEM_WALK_E)
            Case "STAND_SW":
                toRet = .standingGfx(ITEM_WALK_SW)
                If LenB(toRet) = 0 Then
                    toRet = .standingGfx(ITEM_WALK_W)
                End If
                If LenB(toRet) = 0 Then toRet = .gfx(ITEM_WALK_SW)
                If LenB(toRet) = 0 Then toRet = .gfx(ITEM_WALK_W)
            Case "STAND_SE":
                toRet = .standingGfx(ITEM_WALK_SE)
                If LenB(toRet) = 0 Then
                    toRet = .standingGfx(ITEM_WALK_E)
                End If
                If LenB(toRet) = 0 Then toRet = .gfx(ITEM_WALK_SE)
                If LenB(toRet) = 0 Then toRet = .gfx(ITEM_WALK_E)

            Case "WALK_S":
                toRet = .gfx(ITEM_WALK_S)
            Case "WALK_N":
                toRet = .gfx(ITEM_WALK_N)
            Case "WALK_E":
                toRet = .gfx(ITEM_WALK_E)
            Case "WALK_W":
                toRet = .gfx(ITEM_WALK_W)
            Case "WALK_NW":
                toRet = .gfx(ITEM_WALK_NW)
                If LenB(toRet) = 0 Then
                    toRet = .gfx(ITEM_WALK_W)
                End If
            Case "WALK_NE":
                toRet = .gfx(ITEM_WALK_NE)
                If LenB(toRet) = 0 Then
                    toRet = .gfx(ITEM_WALK_E)
                End If
            Case "WALK_SW":
                toRet = .gfx(ITEM_WALK_SW)
                If LenB(toRet) = 0 Then
                    toRet = .gfx(ITEM_WALK_W)
                End If
            Case "WALK_SE":
                toRet = .gfx(ITEM_WALK_SE)
                If LenB(toRet) = 0 Then
                    toRet = .gfx(ITEM_WALK_E)
                End If
            Case "REST":    'The item stance REST has been depreciated into
                            'the idling stances; old items will be converted
                            'upon opening.

                toRet = .standingGfx(ITEM_WALK_S)
                If LenB(toRet) = 0 Then toRet = .gfx(ITEM_WALK_S)
            Case Else:
                'it's a custom stance
                'search the custom stances...
                Dim t As Long
                For t = 0 To UBound(.customGfxNames)
                    If UCase$(.customGfxNames(t)) = stance Then
                        toRet = .customGfx(t)
                    End If
                Next t
        End Select
    
    End With
    
    itemGetStanceAnm = toRet

End Function

'=========================================================================
' Get the handle of the idx-th custom stance
'=========================================================================
Public Function itemGetCustomHandleIdx(ByRef theItem As TKItem, ByVal idx As Long) As Long
    On Error Resume Next
    Dim cnt As Long, t As Long
    For t = 0 To UBound(theItem.customGfxNames)
        If (LenB(theItem.customGfxNames(t))) Then
            If cnt = idx Then
                itemGetCustomHandleIdx = t
                Exit Function
            Else
                cnt = cnt + 1
            End If
        End If
    Next t
End Function

'=========================================================================
' Add a custom stance
'=========================================================================
Public Sub itemAddCustomGfx(ByRef theItem As TKItem, ByVal handle As String, ByVal anim As String)

    On Error Resume Next
    
    'search for empty slot...
    Dim t As Long
    For t = 0 To UBound(theItem.customGfxNames)
        If (LenB(theItem.customGfxNames(t)) = 0) Then
            theItem.customGfxNames(t) = handle
            theItem.customGfx(t) = anim
            Exit Sub
        End If
    Next t
    
    'didn't find an empty slot...
    'resize the arrays...
    Dim tt As Long
    tt = UBound(theItem.customGfxNames)
    ReDim Preserve theItem.customGfx(tt * 2)
    ReDim Preserve theItem.customGfxNames(tt * 2)
    
    theItem.customGfx(tt + 1) = anim
    theItem.customGfxNames(tt + 1) = handle
End Sub

'=========================================================================
' Get an item's name
'=========================================================================
Public Function getItemName(ByVal file As String) As String
    On Error Resume Next
    getItemName = openItem(file$).itemName
End Function

'=========================================================================
' Clear an item
'=========================================================================
Public Sub ItemClear(ByRef theItem As TKItem)
    On Error Resume Next
    With theItem
        .speed = 0.05
        .idleTime = 3
        .itemName = vbNullString
        .itmDescription = vbNullString
        .EquipYN = 0
        .MenuYN = 0
        .BoardYN = 0
        .FightYN = 0
        .usedBy = 0
        Dim t As Long
        For t = 0 To 50
            .itmChars(t) = vbNullString
        Next t
        .buyPrice = 0
        .sellPrice = 0
        .keyItem = 0
        For t = 0 To 7
            .itemArmor(t) = 0
        Next t
        .accessory = vbNullString
        .equipHP = 0
        .equipDP = 0
        .equipFP = 0
        .equipSM = 0
        .prgEquip = vbNullString
        .prgRemove = vbNullString
        .mnuHPup = 0
        .mnuSMup = 0
        .mnuUse = vbNullString
        .fgtHPup = 0
        .fgtSMup = 0
        .fgtUse = vbNullString
        .itmAnimation = vbNullString
        .itmPrgOnBoard = vbNullString
        .itmPrgPickUp = vbNullString
        .itmSizeType = 1
        For t = 0 To UBound(.gfx)
            .gfx(t) = vbNullString
        Next t
        For t = 0 To UBound(.standingGfx)
            .standingGfx(t) = vbNullString
        Next t
        For t = 0 To UBound(.customGfx)
            .customGfx(t) = vbNullString
        Next t
        ReDim .customGfx(5)
        ReDim .customGfxNames(5)
        
        Set .vBase = New CVector
        Call .vBase.defaultSpriteVector(True, False)
        Set .vActivate = New CVector
        Call .vActivate.defaultSpriteVector(False, False)
    End With
End Sub

'=========================================================================
' Open an item
'=========================================================================
Public Function openItem(ByVal file As String) As TKItem

    'opens item file
    On Error Resume Next
    Dim num As Long
    num = FreeFile()
    If (LenB(file$) = 0) Then Exit Function
    
    Dim theItem As TKItem
    
    Call ItemClear(theItem)
    
#If (isToolkit = 1) Then
    itemList(activeItemIndex).itemNeedUpdate = False
#End If
    theItem.itmAnimation$ = vbNullString
    theItem.itmSizeType = 0
       
    Dim tbm As TKTileBitmap
    Dim anm As TKAnimation
    ReDim itmwalkGfx(15, 1) As String  'walking graphics filenames for 64x32 gfx (x, 0 or 1) 0=top, 1=bottom
    ReDim itmrestGfx(1) As String      'at rest gfx for 64x32 gfx
       
    'set us up for conversion of old-style embedded tiles
    'we'll take embedded tiles and spit them out as a tileset.
    'thus making them external...
    Dim x As Long, y As Long
    For x = 0 To 32
        For y = 0 To 32
            bufTile(x, y) = tileMem(x, y)
        Next y
    Next x
    Dim oldDetail As Long
    oldDetail = detail
    detail = 1
    Dim tstName As String
    tstName$ = replace(RemovePath(file$), ".", "_") + ".tst"
    tstName$ = projectPath & tilePath & tstName$
    
    file$ = PakLocate(file$)
    
    num = FreeFile
    Open file$ For Binary Access Read As #num
        Dim b As Byte
        Get #num, 14, b
        If (b) Then
            Close #num
            GoTo ver2olditem
        End If
    Close #num
    
    Dim fileHeader As String, majorVer As Long, minorVer As Long, t As Long
    Open file$ For Binary Access Read As #num
        fileHeader$ = BinReadString(num)      'Filetype
        If fileHeader$ <> "RPGTLKIT ITEM" Then Close #num: MsgBox "Unrecognised File Format! " + file$, , "Open Item": Exit Function
        majorVer = BinReadInt(num)         'Version
        minorVer = BinReadInt(num)         'Minor version (ie 2.0)
        If majorVer <> major Then MsgBox "This Character was created with an unrecognised version of the Toolkit", , "Unable to open Character": Close #num: Exit Function
        
        theItem.itemName = BinReadString(num)
        theItem.itmDescription = BinReadString(num)
        theItem.EquipYN = BinReadByte(num)
        theItem.MenuYN = BinReadByte(num)
        theItem.BoardYN = BinReadByte(num)
        theItem.FightYN = BinReadByte(num)

        theItem.usedBy = BinReadByte(num)
        For t = 0 To 50
            theItem.itmChars(t) = BinReadString(num)
        Next t
        If minorVer >= 3 Then
            theItem.buyPrice = BinReadLong(num)
            theItem.sellPrice = BinReadLong(num)
        Else
            theItem.buyPrice = BinReadInt(num)
            theItem.sellPrice = BinReadInt(num)
        End If
        theItem.keyItem = BinReadByte(num)

        'Equipable:
        For t = 0 To 7
            theItem.itemArmor(t) = BinReadByte(num)
        Next t
        theItem.accessory = BinReadString(num)
        If minorVer >= 3 Then
            theItem.equipHP = BinReadLong(num)
            theItem.equipDP = BinReadLong(num)
            theItem.equipFP = BinReadLong(num)
            theItem.equipSM = BinReadLong(num)
        Else
            theItem.equipHP = BinReadInt(num)
            theItem.equipDP = BinReadInt(num)
            theItem.equipFP = BinReadInt(num)
            theItem.equipSM = BinReadInt(num)
        End If
        theItem.prgEquip = BinReadString(num)
        theItem.prgRemove = BinReadString(num)
        'Menu-driven:
        If minorVer >= 3 Then
            theItem.mnuHPup = BinReadLong(num)
            theItem.mnuSMup = BinReadLong(num)
        Else
            theItem.mnuHPup = BinReadInt(num)
            theItem.mnuSMup = BinReadInt(num)
        End If
        theItem.mnuUse = BinReadString(num)
        'battle-driven:
        If minorVer >= 3 Then
            theItem.fgtHPup = BinReadLong(num)
            theItem.fgtSMup = BinReadLong(num)
        Else
            theItem.fgtHPup = BinReadInt(num)
            theItem.fgtSMup = BinReadInt(num)
        End If
        theItem.fgtUse = BinReadString(num)
        theItem.itmAnimation = BinReadString(num)
        'board-driven:
        theItem.itmPrgOnBoard = BinReadString(num)
        theItem.itmPrgPickUp = BinReadString(num)
        
        theItem.itmSizeType = BinReadByte(num)
        If minorVer >= 4 Then
            'version 3.0 item
            For t = 0 To UBound(theItem.gfx)
                theItem.gfx(t) = BinReadString(num)
            Next t
            If (minorVer >= 5) Then
                For t = 0 To UBound(theItem.standingGfx)
                    theItem.standingGfx(t) = BinReadString(num)
                Next t
                theItem.speed = BinReadDouble(num)
                theItem.idleTime = BinReadDouble(num)
            End If

            If (minorVer < 6) Then
                'REST has been depreciated-- move REST graphic to STAND_S
                theItem.standingGfx(ITEM_WALK_S) = theItem.gfx(ITEM_REST)
                theItem.gfx(ITEM_REST) = vbNullString
            End If
            
            'Custom animations
            Dim count As Long, animation As String, handle As String
            count = BinReadLong(num)
            For t = 0 To count
                animation = BinReadString(num)
                handle = BinReadString(num)
                Call itemAddCustomGfx(theItem, handle, animation)
            Next t
            
            'Vector bases. Pre-vector version bases loaded in ItemClear()
            If (minorVer >= 7) Then
                Dim i As Long, j As Long, ub As Integer, pts As Integer, vect As CVector
                
                'Provision for directional bases.
                ub = BinReadInt(num)
                For i = 0 To ub
                    Set vect = New CVector
                    pts = BinReadInt(num)
                    For j = 0 To pts
                        x = BinReadLong(num)
                        y = BinReadLong(num)
                        Call vect.addPoint(x, y)
                    Next j
                    
                    vect.bClosed = True
                    If i = 0 Then
                        Set theItem.vBase = vect
                    Else
                        Set theItem.vActivate = vect
                    End If
                    Set vect = Nothing
                Next i
            End If
            
        Else
            'old version 2 item (convert the gfx to animations and tile bitmaps)
            For x = 0 To 15
                For y = 0 To 1
                    itmwalkGfx(x, y) = BinReadString(num)
                Next y
            Next x
            For y = 0 To 1
                itmrestGfx(y) = BinReadString(num)
            Next y
            
            Call AnimationClear(anm)
            anm.animSizeX = 32
            anm.animSizeY = 64
            anm.animPause = 0.167
            Dim xx As Long, walkFix As String
            xx = 0
            walkFix$ = "S"
            For x = 0 To 15
                Dim anmName As String, tbmName As String
                anmName$ = replace(RemovePath(file$), ".", "_") + "_walk_" + walkFix & "_" + ".anm"
                anmName$ = projectPath & miscPath & anmName$
                
                tbmName$ = replace(RemovePath(file$), ".", "_") + "_walk_" + CStr(x) + ".tbm"
                tbmName$ = projectPath & bmpPath & tbmName$
                
                Call TileBitmapClear(tbm)
                Call TileBitmapResize(tbm, 1, 2)
                For y = 0 To 1
                    tbm.tiles(0, y) = itmwalkGfx(x, y)
                Next y
                Call SaveTileBitmap(tbmName$, tbm)
                anm.animFrame(xx) = RemovePath(tbmName$)
                anm.animTransp(xx) = RGB(255, 255, 255)
            
                If x = 3 Then
                    walkFix$ = "E"
                    Call saveAnimation(anmName$, anm)
                    theItem.gfx(ITEM_WALK_S) = RemovePath(anmName$)
                    xx = -1
                End If
                If x = 7 Then
                    walkFix$ = "N"
                    Call saveAnimation(anmName$, anm)
                    theItem.gfx(ITEM_WALK_E) = RemovePath(anmName$)
                    xx = -1
                End If
                If x = 11 Then
                    walkFix$ = "W"
                    Call saveAnimation(anmName$, anm)
                    theItem.gfx(ITEM_WALK_N) = RemovePath(anmName$)
                    xx = -1
                End If
                If x = 15 Then
                    Call saveAnimation(anmName$, anm)
                    theItem.gfx(ITEM_WALK_W) = RemovePath(anmName$)
                    xx = -1
                End If
                xx = xx + 1
            Next x
            
            Call AnimationClear(anm)
            anm.animSizeX = 32
            anm.animSizeY = 64
            anm.animPause = 0.167
            
            anmName$ = replace(RemovePath(file$), ".", "_") + "_rest" + ".anm"
            anmName$ = projectPath & miscPath & anmName$
            
            tbmName$ = replace(RemovePath(file$), ".", "_") + "_rest" + ".tbm"
            tbmName$ = projectPath & bmpPath & tbmName$
            Call TileBitmapClear(tbm)
            Call TileBitmapResize(tbm, 1, 2)
            For y = 0 To 1
                tbm.tiles(0, y) = itmrestGfx(y)
            Next y
            Call SaveTileBitmap(tbmName$, tbm)
            anm.animFrame(0) = RemovePath(tbmName$)
            anm.animTransp(0) = RGB(255, 255, 255)
            Call saveAnimation(anmName$, anm)
            theItem.standingGfx(ITEM_WALK_S) = RemovePath(anmName$)
            
            theItem.itmSizeType = 1
        End If
    Close #num
    openItem = theItem
    Exit Function
    
ver2olditem:
    Open file$ For Input As #num
        Input #num, fileHeader$        'Filetype
        If fileHeader$ <> "RPGTLKIT ITEM" Then Close #num: MsgBox "Unrecognised File Format!", , "Open Item": Exit Function
        Input #num, majorVer           'Version
        Input #num, minorVer           'Minor version (ie 2.0)
        If majorVer <> major Then MsgBox "This Character was created with an unrecognised version of the Toolkit", , "Unable to open Character": Close #num: Exit Function
        theItem.itemName = fread(num)  'Item name (handle)
        theItem.EquipYN = fread(num)      'Equipable item? 0- No, 1- yes
        theItem.MenuYN = fread(num)       'Menu item? 0-No, 1-Y
        theItem.BoardYN = fread(num)      'Board item? 0-N, 1-Y
        theItem.FightYN = fread(num)      'Battle item? 0-N, 1-Y
        For t = 1 To 7
            theItem.itemArmor(t) = fread(num) 'Equip on what body locations? 1-7 (head->accessory)
        Next t
        theItem.accessory = fread(num)   'Accessory name
        theItem.equipHP = fread(num)      'Hp increase when equipped
        theItem.equipDP = fread(num)      'dp increase when equipped
        theItem.equipFP = fread(num)      'fp increase when equipped
        theItem.equipSM = fread(num)      'sm increase when equipped
        theItem.prgEquip = fread(num)    'prg to run when equipped
        theItem.prgRemove = fread(num)   'prg to run when remobed
        theItem.mnuHPup = fread(num)      'HP increase when used from menu
        theItem.mnuSMup = fread(num)      'SMP increase wjen used from menu
        theItem.mnuUse = fread(num)      'program to run when used from menu
        theItem.fgtHPup = fread(num)      'HP increase when used from fight
        theItem.fgtSMup = fread(num)      'SMP increase wjen used from fight
        theItem.fgtUse = fread(num)      'program to run when used from fight
        theItem.itmPrgOnBoard = fread(num) 'Program to run while item is on board
        theItem.itmPrgPickUp = fread(num) 'Program to run when picked up.
        If minorVer = 1 Then
            theItem.itmSizeType = fread(num)
        Else
            theItem.itmSizeType = 0
        End If
        If theItem.itmSizeType = 0 Then
            'we don't support itmSizeType 0 (32x32) anymore
            'we will extract the embedded gfx and save them as a tileset.
            theItem.itmSizeType = 1
            Dim bCreated As Boolean
            Dim tstPos As Long, test As Long
            bCreated = False
            tstPos = 1
            
            For t = 1 To 16
                Input #num, test    'test first byte
                If test = -2 Then
                    'empty item...
                    itmwalkGfx$(t - 1, 0) = vbNullString
                    itmwalkGfx$(t - 1, 1) = vbNullString
                Else
                    For x = 1 To 32
                        For y = 1 To 32
                            If x = 1 And y = 1 Then
                                tileMem(x, y) = test
                            Else
                                tileMem(x, y) = fread(num)
                            End If
                        Next y
                    Next x
                    If Not (bCreated) Then
                        Call createNewTileSet(tstName$)
                        itmwalkGfx$(t - 1, 0) = vbNullString
                        itmwalkGfx$(t - 1, 1) = RemovePath(tstName$) + CStr(tstPos)
                        tstPos = tstPos + 1
                        bCreated = True
                    Else
                        Call addToTileSet(tstName$)
                        itmwalkGfx$(t - 1, 0) = vbNullString
                        itmwalkGfx$(t - 1, 1) = RemovePath(tstName$) + CStr(tstPos)
                        tstPos = tstPos + 1
                    End If
                End If
            Next t
            
            Input #num, test    'test first byte
            If test = -2 Then
                'empty item...
                itmrestGfx$(0) = vbNullString
                itmrestGfx$(1) = vbNullString
            Else
                For x = 1 To 32
                    For y = 1 To 32
                        If x = 1 And y = 1 Then
                            tileMem(x, y) = test
                        Else
                            tileMem(x, y) = fread(num)
                        End If
                    Next y
                Next x
                If Not (bCreated) Then
                    Call createNewTileSet(tstName$)
                    itmrestGfx$(0) = vbNullString
                    itmrestGfx$(1) = RemovePath(tstName$) + CStr(tstPos)
                    tstPos = tstPos + 1
                    bCreated = True
                Else
                    Call addToTileSet(tstName$)
                    itmrestGfx$(0) = vbNullString
                    itmrestGfx$(1) = RemovePath(tstName$) + CStr(tstPos)
                    tstPos = tstPos + 1
                End If
            End If
        Else
            Dim u As Long
            For t = 0 To 15
                For u = 0 To 1
                    itmwalkGfx(t, u) = fread(num)   'walking gfx filenames
                Next u
            Next t
            For u = 0 To 1
                itmrestGfx(u) = fread(num)
            Next u
        End If
        theItem.usedBy = fread(num)           'Item used by 0-all 1-defined
        For t = 1 To 50
            theItem.itmChars(t) = fread(num)    '50 characters who can use the item
        Next t
        theItem.buyPrice = fread(num)
        theItem.sellPrice = fread(num)
        theItem.keyItem = fread(num)             'is it a key item (0-no, 1-yes)
        theItem.itmDescription = fread(num)      'description (one-line)
        theItem.itmAnimation = fread(num)
    
        'create animations...
        Call AnimationClear(anm)
        anm.animSizeX = 32
        anm.animSizeY = 64
        anm.animPause = 0.167
        xx = 0
        walkFix$ = "S"
        For x = 0 To 15
            anmName$ = replace(RemovePath(file$), ".", "_") + "_walk_" + walkFix & "_" + ".anm"
            anmName$ = projectPath & miscPath & anmName$
            
            tbmName$ = replace(RemovePath(file$), ".", "_") + "_walk_" + CStr(x) + ".tbm"
            tbmName$ = projectPath & bmpPath & tbmName$
            
            Call TileBitmapClear(tbm)
            Call TileBitmapResize(tbm, 1, 2)
            For y = 0 To 1
                tbm.tiles(0, y) = itmwalkGfx(x, y)
            Next y
            Call SaveTileBitmap(tbmName$, tbm)
            anm.animFrame(xx) = RemovePath(tbmName$)
            anm.animTransp(xx) = RGB(255, 255, 255)
        
            If x = 3 Then
                walkFix$ = "E"
                Call saveAnimation(anmName$, anm)
                theItem.gfx(ITEM_WALK_S) = RemovePath(anmName$)
                xx = -1
            End If
            If x = 7 Then
                walkFix$ = "N"
                Call saveAnimation(anmName$, anm)
                theItem.gfx(ITEM_WALK_E) = RemovePath(anmName$)
                xx = -1
            End If
            If x = 11 Then
                walkFix$ = "W"
                Call saveAnimation(anmName$, anm)
                theItem.gfx(ITEM_WALK_N) = RemovePath(anmName$)
                xx = -1
            End If
            If x = 15 Then
                Call saveAnimation(anmName$, anm)
                theItem.gfx(ITEM_WALK_W) = RemovePath(anmName$)
                xx = -1
            End If
            xx = xx + 1
        Next x
        
        Call AnimationClear(anm)
        anm.animSizeX = 32
        anm.animSizeY = 64
        anm.animPause = 0.167
        
        anmName$ = replace(RemovePath(file$), ".", "_") + "_rest" + ".anm"
        anmName$ = projectPath & miscPath & anmName$
        
        tbmName$ = replace(RemovePath(file$), ".", "_") + "_rest" + ".tbm"
        tbmName$ = projectPath & bmpPath & tbmName$
        Call TileBitmapClear(tbm)
        Call TileBitmapResize(tbm, 1, 2)
        For y = 0 To 1
            tbm.tiles(0, y) = itmrestGfx(y)
        Next y
        Call SaveTileBitmap(tbmName$, tbm)
        anm.animFrame(0) = RemovePath(tbmName$)
        anm.animTransp(0) = RGB(255, 255, 255)
        Call saveAnimation(anmName$, anm)
        theItem.standingGfx(ITEM_WALK_S) = RemovePath(anmName$)
        
        theItem.itmSizeType = 1
        openItem = theItem
    
    Close #num

    For x = 0 To 32
        For y = 0 To 32
            tileMem(x, y) = bufTile(x, y)
        Next y
    Next x

    detail = oldDetail

End Function

'=========================================================================
' Save an item
'=========================================================================
Public Sub saveItem(ByVal file As String, ByRef theItem As TKItem)

    On Error Resume Next
    
    Dim num As Long, t As Long
    If (LenB(file) = 0) Then Exit Sub
    
    num = FreeFile()
    
    Call Kill(file)
    
    Open file For Binary Access Write As num
        Call BinWriteString(num, "RPGTLKIT ITEM")    'Filetype
        Call BinWriteInt(num, major)
        Call BinWriteInt(num, ITM_MINOR)
        
        Call BinWriteString(num, theItem.itemName)
        Call BinWriteString(num, theItem.itmDescription)
        Call BinWriteByte(num, theItem.EquipYN)
        Call BinWriteByte(num, theItem.MenuYN)
        Call BinWriteByte(num, theItem.BoardYN)
        Call BinWriteByte(num, theItem.FightYN)

        Call BinWriteByte(num, theItem.usedBy)
        For t = 0 To 50
            Call BinWriteString(num, theItem.itmChars(t))
        Next t
        Call BinWriteLong(num, theItem.buyPrice)
        Call BinWriteLong(num, theItem.sellPrice)
        Call BinWriteByte(num, theItem.keyItem)

        'Equipable:
        For t = 0 To 7
            Call BinWriteByte(num, theItem.itemArmor(t))
        Next t
        Call BinWriteString(num, theItem.accessory)
        Call BinWriteLong(num, theItem.equipHP)
        Call BinWriteLong(num, theItem.equipDP)
        Call BinWriteLong(num, theItem.equipFP)
        Call BinWriteLong(num, theItem.equipSM)
        Call BinWriteString(num, theItem.prgEquip)
        Call BinWriteString(num, theItem.prgRemove)
        'Menu-driven:
        Call BinWriteLong(num, theItem.mnuHPup)
        Call BinWriteLong(num, theItem.mnuSMup)
        Call BinWriteString(num, theItem.mnuUse)
        'battle-driven:
        Call BinWriteLong(num, theItem.fgtHPup)
        Call BinWriteLong(num, theItem.fgtSMup)
        Call BinWriteString(num, theItem.fgtUse)
        Call BinWriteString(num, theItem.itmAnimation)
        'board-driven:
        Call BinWriteString(num, theItem.itmPrgOnBoard)
        Call BinWriteString(num, theItem.itmPrgPickUp)
        
        Call BinWriteByte(num, theItem.itmSizeType)
        
        For t = 0 To UBound(theItem.gfx)
            Call BinWriteString(num, theItem.gfx(t))
        Next t
        
        For t = 0 To UBound(theItem.standingGfx)
            Call BinWriteString(num, theItem.standingGfx(t))
        Next t
        
        Call BinWriteDouble(num, theItem.speed)
        Call BinWriteDouble(num, theItem.idleTime)
        
        Dim sz As Long
        sz = UBound(theItem.customGfxNames)
        Call BinWriteLong(num, sz)
        For t = 0 To sz
            Call BinWriteString(num, theItem.customGfx(t))
            Call BinWriteString(num, theItem.customGfxNames(t))
        Next t
        
        'Vectors
        Call BinWriteInt(num, 1)                            'Currently 2 interaction vectors.
            
        'Collision vector
        Call BinWriteInt(num, theItem.vBase.getPoints)
        Dim i As Long, x As Long, y As Long
        For i = 0 To theItem.vBase.getPoints
            Call theItem.vBase.getPoint(i, x, y)
            Call BinWriteLong(num, x)                        'Stored by pixel (Longs)
            Call BinWriteLong(num, y)
        Next i
        
        'Activation vector
        Call BinWriteInt(num, theItem.vActivate.getPoints)
        For i = 0 To theItem.vActivate.getPoints
            Call theItem.vActivate.getPoint(i, x, y)
            Call BinWriteLong(num, x)
            Call BinWriteLong(num, y)
        Next i
        
    Close num

End Sub

Attribute VB_Name = "CommonItem"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'Item Editor:
Option Explicit

''''''''''''''''''''''item data'''''''''''''''''''''''''

'indicies of char gfx
Public Const ITEM_WALK_S = 0
Public Const ITEM_WALK_N = 1
Public Const ITEM_WALK_E = 2
Public Const ITEM_WALK_W = 3
Public Const ITEM_WALK_NW = 4
Public Const ITEM_WALK_NE = 5
Public Const ITEM_WALK_SW = 6
Public Const ITEM_WALK_SE = 7
Public Const ITEM_REST = 8


Type TKItem
    itemName As String            'Item name (handle)
    ITMDescription As String     'description of item (one-line string)
    EquipYN As Byte              'Equipable item? 0- No, 1- yes
    MenuYN As Byte               'Menu item? 0-No, 1-Y
    BoardYN As Byte              'Board item? 0-N, 1-Y
    FightYN As Byte              'Battle item? 0-N, 1-Y

    usedBy As Byte               'Item used by 0-all 1-defined
    itmChars(50) As String       '50 characters who can use the item
    buyPrice As Long          'price to buy at
    sellPrice As Long         'price to sell at
    keyItem As Byte              'is it a key item (0-no, 1-yes)

'Equipable:
    itemarmor(7) As Byte         'Equip on what body locations? 1-7 (head->accessory)
    accessory As String          'Accessory name
    equipHP As Long           'Hp increase when equipped
    equipDP As Long           'dp increase when equipped
    equipFP As Long           'fp increase when equipped
    equipSM As Long           'sm increase when equipped
    prgEquip As String           'prg to run when equipped
    prgRemove As String          'prg to run when remobed
'Menu-driven:
    mnuHPup As Long           'HP increase when used from menu
    mnuSMup As Long           'SMP increase wjen used from menu
    mnuUse As String             'program to run when used from menu
'battle-driven:
    fgtHPup As Long           'HP increase when used from fight
    fgtSMup As Long           'SMP increase wjen used from fight
    fgtUse As String             'program to run when used from fight
    itmAnimation As String       'animation for battle
'board-driven:
    itmPrgOnBoard As String      'Program to run while item is on board
    itmPrgPickUp As String       'Program to run when picked up.
    
    itmSizeType As Byte          'graphics size type 0=32x32, 1=64x32

    gfx(9) As String         'filenames of standard animations for graphics
    customGfx() As String   'customized animations
    customGfxNames() As String   'customized animations (handles)

'Not in file-- used by trans
    bIsActive As Boolean    'is item active?
End Type


Type itemDoc
    itemFile As String        'filename
    itemNeedUpdate As Boolean
    itmLayTile As Boolean   'about to lay a tile?
    
    theData As TKItem
End Type

'array of enemies used in the MDI children
Public itemList() As itemDoc
Public itemListOccupied() As Boolean


Function canItemEquip(ByVal file As String) As Boolean
    'sees if an item is equippable
    'returns true or false
    'opens item file
    On Error Resume Next
    If file$ = "" Then canItemEquip = False: Exit Function
    Dim anItem As TKItem
    anItem = openItem(file$)
    If anItem.EquipYN = 0 Then
        canItemEquip = False
    Else
        canItemEquip = True
    End If
End Function



Public Function itemGetStanceAnm(ByVal stance As String, ByRef theItem As TKItem) As String
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
    'REST
    'Also searches custom stances
    On Error Resume Next
    Dim toRet As String
    
    stance = UCase$(stance)
    Select Case stance
        Case "WALK_S":
            toRet = theItem.gfx(ITEM_WALK_S)
        Case "WALK_N":
            toRet = theItem.gfx(ITEM_WALK_N)
        Case "WALK_E":
            toRet = theItem.gfx(ITEM_WALK_E)
        Case "WALK_W":
            toRet = theItem.gfx(ITEM_WALK_W)
        Case "WALK_NW":
            toRet = theItem.gfx(ITEM_WALK_NW)
            If toRet = "" Then
                toRet = theItem.gfx(ITEM_WALK_W)
            End If
        Case "WALK_NE":
            toRet = theItem.gfx(ITEM_WALK_NE)
            If toRet = "" Then
                toRet = theItem.gfx(ITEM_WALK_E)
            End If
        Case "WALK_SW":
            toRet = theItem.gfx(ITEM_WALK_SW)
            If toRet = "" Then
                toRet = theItem.gfx(ITEM_WALK_W)
            End If
        Case "WALK_SE":
            toRet = theItem.gfx(ITEM_WALK_SE)
            If toRet = "" Then
                toRet = theItem.gfx(ITEM_WALK_E)
            End If
        Case "REST":
            toRet = theItem.gfx(ITEM_REST)
        Case Else:
            'it's a custom stance
            'search the custom stances...
            Dim t As Long
            For t = 0 To UBound(theItem.customGfxNames)
                If UCase$(theItem.customGfxNames(t)) = stance Then
                    toRet = theItem.customGfx(t)
                End If
            Next t
    End Select
    itemGetStanceAnm = toRet
End Function


Function itemGetCustomHandleIdx(ByRef theItem As TKItem, ByVal idx As Long) As Long
    'return the handle of the idx-th custom gfx (not counting ones with "" as their handles)
    On Error Resume Next
    
    Dim cnt As Long, t As Long
    
    For t = 0 To UBound(theItem.customGfxNames)
        If theItem.customGfxNames(t) <> "" Then
            If cnt = idx Then
                itemGetCustomHandleIdx = t
                Exit Function
            Else
                cnt = cnt + 1
            End If
        End If
    Next t
End Function




Sub itemAddCustomGfx(ByRef theItem As TKItem, ByVal handle As String, ByVal anim As String)
    'add a custom animation to the item
    On Error Resume Next
    
    'search for empty slot...
    Dim t As Long
    For t = 0 To UBound(theItem.customGfxNames)
        If theItem.customGfxNames(t) = "" Then
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



Sub VectItemKillSlot(ByVal idx As Long)
    On Error Resume Next
    'free up memory in the item list vector
    itemListOccupied(idx) = False
End Sub

Function VectItemNewSlot() As Long
    On Error GoTo vecterr
       
    'test size of array
    Dim test As Long, t As Long, oldSize As Long, newSize As Long
    test = UBound(itemList)
    
    'find a new slot in the list of boards and return an index we can use
    For t = 0 To UBound(itemList)
        If itemListOccupied(t) = False Then
            itemListOccupied(t) = True
            VectItemNewSlot = t
            Exit Function
        End If
    Next t
    
    'must resize the vector...
    oldSize = UBound(itemList)
    newSize = UBound(itemList) * 2
    ReDim Preserve itemList(newSize)
    ReDim Preserve itemListOccupied(newSize)
    
    itemListOccupied(oldSize + 1) = True
    VectItemNewSlot = oldSize + 1
    
    Exit Function

vecterr:
    ReDim itemList(1)
    ReDim itemListOccupied(1)
    Resume Next
    
End Function

Function getItemName(ByVal file$) As String
    'gets an item name from a filename
    On Error Resume Next
    Dim num As Long
    num = FreeFile
    If file$ = "" Then Exit Function
    
    Dim anItem As TKItem
    anItem = openItem(file$)
    getItemName = anItem.itemName
End Function

Sub ItemClear(ByRef theItem As TKItem)
    'clear the item
    On Error Resume Next
    theItem.itemName = ""
    theItem.ITMDescription = ""
    theItem.EquipYN = 0
    theItem.MenuYN = 0
    theItem.BoardYN = 0
    theItem.FightYN = 0

    theItem.usedBy = 0
    Dim t As Long
    For t = 0 To 50
        theItem.itmChars(t) = ""
    Next t
    theItem.buyPrice = 0
    theItem.sellPrice = 0
    theItem.keyItem = 0

'Equipable:
    For t = 0 To 7
        theItem.itemarmor(t) = 0
    Next t
    theItem.accessory = ""
    theItem.equipHP = 0
    theItem.equipDP = 0
    theItem.equipFP = 0
    theItem.equipSM = 0
    theItem.prgEquip = ""
    theItem.prgRemove = ""
'Menu-driven:
    theItem.mnuHPup = 0
    theItem.mnuSMup = 0
    theItem.mnuUse = ""
'battle-driven:
    theItem.fgtHPup = 0
    theItem.fgtSMup = 0
    theItem.fgtUse = ""
    theItem.itmAnimation = ""
'board-driven:
    theItem.itmPrgOnBoard = ""
    theItem.itmPrgPickUp = ""
    
    theItem.itmSizeType = 1

    For t = 0 To UBound(theItem.gfx)
        theItem.gfx(t) = ""
    Next t
    For t = 0 To UBound(theItem.customGfx)
        theItem.customGfx(t) = ""
    Next t
    ReDim theItem.customGfx(5)
    ReDim theItem.customGfxNames(5)
End Sub


Public Function openItem(ByVal file As String) As TKItem

    'opens item file
    On Error Resume Next
    Dim num As Long
    num = FreeFile
    If file$ = "" Then Exit Function
    
    Dim theItem As TKItem
    
    Call ItemClear(theItem)
    
    itemList(activeItemIndex).itemNeedUpdate = False
    theItem.itmAnimation$ = ""
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
            buftile(x, y) = tilemem(x, y)
        Next y
    Next x
    publicTile.oldDetail = detail
    detail = 1
    Dim tstName As String
    tstName$ = replace(RemovePath(file$), ".", "_") + ".tst"
    tstName$ = projectPath$ + tilePath$ + tstName$
    
    
    file$ = PakLocate(file$)
    
    num = FreeFile
    Open file$ For Binary As #num
        Dim b As Byte
        Get #num, 14, b
        If b <> 0 Then
            Close #num
            GoTo ver2olditem
        End If
    Close #num
    
    Dim fileHeader As String, majorVer As Long, minorVer As Long, t As Long
    Open file$ For Binary As #num
        fileHeader$ = BinReadString(num)      'Filetype
        If fileHeader$ <> "RPGTLKIT ITEM" Then Close #num: MsgBox "Unrecognised File Format! " + file$, , "Open Item": Exit Function
        majorVer = BinReadInt(num)         'Version
        minorVer = BinReadInt(num)         'Minor version (ie 2.0)
        If majorVer <> Major Then MsgBox "This Character was created with an unrecognised version of the Toolkit", , "Unable to open Character": Close #num: Exit Function
        
        theItem.itemName = BinReadString(num)
        theItem.ITMDescription = BinReadString(num)
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
            theItem.itemarmor(t) = BinReadByte(num)
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
            
            Dim cnt As Long
            cnt = BinReadLong(num)
            For t = 0 To cnt
                Dim an As String, handle As String
                an$ = BinReadString(num)
                handle$ = BinReadString(num)
                Call itemAddCustomGfx(theItem, handle$, an$)
            Next t
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
                anmName$ = replace(RemovePath(file$), ".", "_") + "_walk_" + walkFix$ + "_" + ".anm"
                anmName$ = projectPath$ + miscPath$ + anmName$
                
                tbmName$ = replace(RemovePath(file$), ".", "_") + "_walk_" + toString(x) + ".tbm"
                tbmName$ = projectPath$ + bmpPath$ + tbmName$
                
                Call TileBitmapClear(tbm)
                Call TileBitmapResize(tbm, 1, 2)
                For y = 0 To 1
                    tbm.tiles(0, y) = itmwalkGfx(x, y)
                Next y
                Call SaveTileBitmap(tbmName$, tbm)
                anm.animFrame(xx) = RemovePath(tbmName$)
            
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
            anmName$ = projectPath$ + miscPath$ + anmName$
            
            tbmName$ = replace(RemovePath(file$), ".", "_") + "_rest" + ".tbm"
            tbmName$ = projectPath$ + bmpPath$ + tbmName$
            Call TileBitmapClear(tbm)
            Call TileBitmapResize(tbm, 1, 2)
            For y = 0 To 1
                tbm.tiles(0, y) = itmrestGfx(y)
            Next y
            Call SaveTileBitmap(tbmName$, tbm)
            anm.animFrame(0) = RemovePath(tbmName$)
            Call saveAnimation(anmName$, anm)
            theItem.gfx(ITEM_REST) = RemovePath(anmName$)
            
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
        If majorVer <> Major Then MsgBox "This Character was created with an unrecognised version of the Toolkit", , "Unable to open Character": Close #num: Exit Function
        theItem.itemName = fread(num)  'Item name (handle)
        theItem.EquipYN = fread(num)      'Equipable item? 0- No, 1- yes
        theItem.MenuYN = fread(num)       'Menu item? 0-No, 1-Y
        theItem.BoardYN = fread(num)      'Board item? 0-N, 1-Y
        theItem.FightYN = fread(num)      'Battle item? 0-N, 1-Y
        For t = 1 To 7
            theItem.itemarmor(t) = fread(num) 'Equip on what body locations? 1-7 (head->accessory)
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
                    itmwalkGfx$(t - 1, 0) = ""
                    itmwalkGfx$(t - 1, 1) = ""
                Else
                    For x = 1 To 32
                        For y = 1 To 32
                            If x = 1 And y = 1 Then
                                tilemem(x, y) = test
                            Else
                                Input #num, tilemem(x, y) '16 walking graphics
                            End If
                        Next y
                    Next x
                    If Not (bCreated) Then
                        Call createNewTileSet(tstName$)
                        itmwalkGfx$(t - 1, 0) = ""
                        itmwalkGfx$(t - 1, 1) = RemovePath(tstName$) + toString(tstPos)
                        tstPos = tstPos + 1
                        bCreated = True
                    Else
                        Call addToTileSet(tstName$)
                        itmwalkGfx$(t - 1, 0) = ""
                        itmwalkGfx$(t - 1, 1) = RemovePath(tstName$) + toString(tstPos)
                        tstPos = tstPos + 1
                    End If
                End If
            Next t
            
            Input #num, test    'test first byte
            If test = -2 Then
                'empty item...
                itmrestGfx$(0) = ""
                itmrestGfx$(1) = ""
            Else
                For x = 1 To 32
                    For y = 1 To 32
                        If x = 1 And y = 1 Then
                            tilemem(x, y) = test
                        Else
                            Input #num, tilemem(x, y)  'Item rest graphic
                        End If
                    Next y
                Next x
                If Not (bCreated) Then
                    Call createNewTileSet(tstName$)
                    itmrestGfx$(0) = ""
                    itmrestGfx$(1) = RemovePath(tstName$) + toString(tstPos)
                    tstPos = tstPos + 1
                    bCreated = True
                Else
                    Call addToTileSet(tstName$)
                    itmrestGfx$(0) = ""
                    itmrestGfx$(1) = RemovePath(tstName$) + toString(tstPos)
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
        theItem.ITMDescription = fread(num)      'description (one-line)
        theItem.itmAnimation = fread(num)
    
        'create animations...
        Call AnimationClear(anm)
        anm.animSizeX = 32
        anm.animSizeY = 64
        anm.animPause = 0.167
        xx = 0
        walkFix$ = "S"
        For x = 0 To 15
            anmName$ = replace(RemovePath(file$), ".", "_") + "_walk_" + walkFix$ + "_" + ".anm"
            anmName$ = projectPath$ + miscPath$ + anmName$
            
            tbmName$ = replace(RemovePath(file$), ".", "_") + "_walk_" + toString(x) + ".tbm"
            tbmName$ = projectPath$ + bmpPath$ + tbmName$
            
            Call TileBitmapClear(tbm)
            Call TileBitmapResize(tbm, 1, 2)
            For y = 0 To 1
                tbm.tiles(0, y) = itmwalkGfx(x, y)
            Next y
            Call SaveTileBitmap(tbmName$, tbm)
            anm.animFrame(xx) = RemovePath(tbmName$)
        
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
        anmName$ = projectPath$ + miscPath$ + anmName$
        
        tbmName$ = replace(RemovePath(file$), ".", "_") + "_rest" + ".tbm"
        tbmName$ = projectPath$ + bmpPath$ + tbmName$
        Call TileBitmapClear(tbm)
        Call TileBitmapResize(tbm, 1, 2)
        For y = 0 To 1
            tbm.tiles(0, y) = itmrestGfx(y)
        Next y
        Call SaveTileBitmap(tbmName$, tbm)
        anm.animFrame(0) = RemovePath(tbmName$)
        Call saveAnimation(anmName$, anm)
        theItem.gfx(ITEM_REST) = RemovePath(anmName$)
        
        theItem.itmSizeType = 1
        openItem = theItem
    
    Close #num
    For x = 0 To 32
        For y = 0 To 32
            tilemem(x, y) = buftile(x, y)
        Next y
    Next x
    detail = publicTile.oldDetail

End Function


Sub saveitem(ByVal file As String, ByRef theItem As TKItem)
    'saves item file
    On Error Resume Next
    
    Dim num As Long, t As Long
    num = FreeFile
    If file$ = "" Then Exit Sub
    
    Kill file$
    
    Open file$ For Binary As #num
        Call BinWriteString(num, "RPGTLKIT ITEM")    'Filetype
        Call BinWriteInt(num, Major)
        Call BinWriteInt(num, 4)    'Minor version (1= ie 2.1 = 64x32 cgfx allowed 2= binary, 3=longs used instead of ints, 4=Version 3 item-- use animations for gfx)
        
        Call BinWriteString(num, theItem.itemName)
        Call BinWriteString(num, theItem.ITMDescription)
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
            Call BinWriteByte(num, theItem.itemarmor(t))
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
        Dim sz As Long
        sz = UBound(theItem.customGfxNames)
        Call BinWriteLong(num, sz)
        For t = 0 To sz
            Call BinWriteString(num, theItem.customGfx(t))
            Call BinWriteString(num, theItem.customGfxNames(t))
        Next t
    Close #num

End Sub



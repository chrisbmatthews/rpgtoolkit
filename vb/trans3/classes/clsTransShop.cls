VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CShop"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'=========================================================================
'All contents copyright 2004, Colin James Fitzpatrick (KSNiloc)
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=========================================================================

'=========================================================================
' Internal shop [Augest 34, 2004]
' Status: A
'=========================================================================

'=========================================================================
' To use this class, set the saleItems, playerItems, money properties and
' make a call to Show(). Next, retrieve the potentially changed values
' of playerItems and money.
'=========================================================================

'=========================================================================
' Only instanced by RPGCode.CallShopRPG
'=========================================================================

Option Explicit

'=========================================================================
' Public variables
'=========================================================================
Public money As Long                     'amount of GP we can speed at this shop

'=========================================================================
' Member enumerations
'=========================================================================
Private Enum SHOP_TYPE                  'transaction type enum
    Buy = 1                              '  buying from shop
    Sell = 2                             '  selling to shop
End Enum

'=========================================================================
' Member constants
'=========================================================================
Private Const OPTION1 As Double = 3.4   'first option on main menu
Private Const OPTION2 As Double = 4.4   'second option on main menu
Private Const OPTION3 As Double = 6.4   'third option on main menu

'=========================================================================
' Member variables
'=========================================================================
Private m_items As CInventory           'the items this shop sells
Private m_player As CInventory          'the inventory this shop can buy
Private m_oldView As Long               'saved screen of before the shop opened
Private m_commonDisplay As Long         'saved common translucent rectangle
Private m_indices() As Long             'indices that map positions in invs to the menu
Private m_itemStrcutures() As TKItem    'the structures of the items on the menu
Private m_itemInfo As Long              'information about the item

'=========================================================================
' Selection of items to sell
'=========================================================================
Public Property Let saleItems(ByVal inventory As CInventory)
    Set m_items = inventory
End Property
Public Property Set saleItems(ByVal inventory As CInventory)
    m_items = inventory
End Property

'=========================================================================
' Player's inventroy
'=========================================================================
Public Property Let playerItems(ByVal inventory As CInventory)
    Set m_player = inventory
End Property
Public Property Get playerItems() As CInventory
    Set playerItems = m_player
End Property
Public Property Set playerItems(ByVal inventory As CInventory)
    m_player = inventory
End Property

'=========================================================================
' Show the shop
'=========================================================================
Public Sub Show()

    On Error Resume Next

    'Save pre-shop view
    m_oldView = CreateCanvas(globalCanvasWidth, globalCanvasHeight)
    Call CanvasGetScreen(m_oldView)

    'Make sure we have color!
    If shopColors(0) = -1 Then
        shopColors(0) = RGB(0, 0, 150)
        shopColors(1) = RGB(0, 102, 255)
    End If

    'Open the main menu
    Call mainMenuScanKeys

    'Restore pre-shop view
    Call renderCanvas(m_oldView)

    'Clean up
    Call DestroyCanvas(m_oldView)
    Call DestroyCanvas(m_commonDisplay)

End Sub

'=========================================================================
' Create the common display
'=========================================================================
Private Sub createCommonDisplay(ByVal theCanvas As Long)
    Dim cnv As Long
    cnv = CreateCanvas(globalCanvasWidth, globalCanvasHeight)
    If m_commonDisplay = 0 Then
        Dim cnv2 As Long
        cnv2 = CreateCanvas(globalCanvasWidth - 20, globalCanvasHeight - 60)
        Call Canvas2CanvasBlt(m_oldView, cnv, 0, 0)
        Call CanvasDrawText(cnv, "Shop", fontName, 30, 1.4, 1.3, RGB(255, 255, 255), True, False, True, False, False)
        Call CanvasFill(cnv2, 0)
        Call CanvasFillBox(cnv2, 0, 0, globalCanvasWidth - 10, globalCanvasHeight - 10, shopColors(0))
        Call Canvas2CanvasBltTranslucent(cnv2, cnv, 10, 50)
        Call DestroyCanvas(cnv2)
        m_commonDisplay = CreateCanvas(globalCanvasWidth, globalCanvasHeight)
        Call Canvas2CanvasBlt(cnv, m_commonDisplay, 0, 0)
    Else
        Call Canvas2CanvasBlt(m_commonDisplay, cnv, 0, 0)
    End If
    Call Canvas2CanvasBlt(cnv, theCanvas, 0, 0)
    Call DestroyCanvas(cnv)
End Sub

'=========================================================================
' Create the main menu display
'=========================================================================
Private Sub createMainMenuDisplay(ByVal theCanvas As Long, Optional ByVal cursorY As Double = -1)
    On Error Resume Next
    Dim cnv As Long
    cnv = CreateCanvas(globalCanvasWidth, globalCanvasHeight)
    Call createCommonDisplay(cnv)
    Call CanvasDrawText(cnv, "Buy", fontName, 25, 2.7, 3.4, RGB(255, 255, 255))
    Call CanvasDrawText(cnv, "Sell", fontName, 25, 2.7, 4.4, RGB(255, 255, 255))
    Call CanvasDrawText(cnv, "Exit", fontName, 25, 2.7, 6.4, RGB(255, 255, 255))
    Call CanvasDrawText(cnv, money & " GP", fontName, 25, 2, (globalCanvasHeight - 40) / 25 + 1, RGB(255, 255, 255))
    If cursorY <> -1 Then
        Call CBCanvasDrawHand(cnv, 2.7 * 25 - 25, cursorY * 25 - 17)
    End If
    Call Canvas2CanvasBlt(cnv, theCanvas, 0, 0)
    Call DestroyCanvas(cnv)
End Sub

'=========================================================================
' Main menu
'=========================================================================
Private Sub mainMenuScanKeys()

    On Error Resume Next

    Dim cnv As Long, cnv2 As Long
    cnv = CreateCanvas(globalCanvasWidth, globalCanvasHeight)
    cnv2 = CreateCanvas(globalCanvasWidth, globalCanvasHeight)

    Call createMainMenuDisplay(cnv)

    Dim cursorY As Double
    cursorY = OPTION1

    Do
        Call DXDrawCanvas(cnv, 0, 0)
        Call CBDrawHand(2.7 * 25 - 25, cursorY * 25 - 17)
        Call DXRefresh
        If isPressed("UP") Then
            Select Case cursorY
                Case OPTION1: cursorY = OPTION3
                Case OPTION2: cursorY = OPTION1
                Case OPTION3: cursorY = OPTION2
            End Select
            Call cursorDelay
        ElseIf isPressed("DOWN") Then
            Select Case cursorY
                Case OPTION1: cursorY = OPTION2
                Case OPTION2: cursorY = OPTION3
                Case OPTION3: cursorY = OPTION1
            End Select
            Call cursorDelay
        ElseIf isPressed("ESC") Or isPressed("LEFT") Then
            Exit Do
        ElseIf isPressed("ENTER") Or isPressed("SPACE") Or isPressed("RIGHT") Then
            Call CanvasGetScreen(cnv2)
            Select Case cursorY
                Case OPTION1: Call shopMenuScanKeys(cnv2, Buy)
                Case OPTION2: Call shopMenuScanKeys(cnv2, Sell)
                Case OPTION3: Exit Do
            End Select
            Call createMainMenuDisplay(cnv)
            Call cursorDelay
            Call FlushKB
        End If
        Call processEvent
    Loop

    'Clean up
    Call DestroyCanvas(cnv)
    Call DestroyCanvas(cnv2)

End Sub

'=========================================================================
' Create the shop menu display
'=========================================================================
Private Sub createShopMenuDisplay( _
                                     ByVal baseCanvas As Long, _
                                     ByVal destCanvas As Long, _
                                     ByVal theType As SHOP_TYPE _
                                                                  )
    On Error Resume Next
    Dim cnv As Long, cnv2 As Long
    cnv = CreateCanvas(globalCanvasWidth, globalCanvasHeight)
    cnv2 = CreateCanvas(172, 399)
    Call Canvas2CanvasBlt(baseCanvas, cnv, 0, 0)
    Call CanvasFill(cnv2, 0)
    Call CanvasFillBox(cnv2, 0, 0, 172, 399, shopColors(1))
    Call Canvas2CanvasBltTranslucent(cnv2, cnv, 200, 60)
    Call createItemDisplay(cnv2, theType)
    Call Canvas2CanvasBltTranslucent(cnv2, cnv, 410, 60)
    Call Canvas2CanvasBlt(cnv, destCanvas, 0, 0)
    Call DestroyCanvas(cnv)
    Call DestroyCanvas(cnv2)
End Sub

'=========================================================================
' Write down items (and fill in the m_indices array)
'=========================================================================
Private Sub createItemDisplay(ByVal theCanvas As Long, ByVal theType As SHOP_TYPE)
    On Error Resume Next
    Dim itmNum As Long, curLine As Double, Text As String
    With inventory(theType)
        ReDim m_indices(.upperBound())
        ReDim m_itemStrcutures(.upperBound())
        For itmNum = 0 To .upperBound()
            Text = .handles(itmNum)
            If (LenB(Text)) Then
                m_indices(curLine) = itmNum
                m_itemStrcutures(curLine) = openItem(projectPath & itmPath & .fileNames(itmNum))
                curLine = curLine + 1
                If theType = Sell Then Text = Text & " x " & .quantities(itmNum)
                Text = Text & " @ "
                If theType = Buy Then
                    Text = Text & item(curLine - 1).buyPrice
                Else
                    Text = Text & item(curLine - 1).sellPrice
                End If
                Text = Text & " GP"
                Call CanvasDrawText(theCanvas, Text, fontName, 25, 1.1, curLine + 0.1, 0)
            End If
        Next itmNum
    End With
    If curLine < 15 Then curLine = 15
    ReDim Preserve m_indices(curLine - 1)
    ReDim Preserve m_itemStrcutures(curLine - 1)
End Sub

'=========================================================================
' Access the structure of an item (positions mapped to m_indices array)
'=========================================================================
Private Property Get item(ByVal pos As Long) As TKItem
    item = m_itemStrcutures(pos)
End Property

'=========================================================================
' Get an inventory handle (positions mapped to m_indices array)
'=========================================================================
Private Property Get handles(ByVal pos As Long) As String
    handles = item(pos).itemName
End Property

'=========================================================================
' Get an inventory file name (positions mapped to m_indices array)
'=========================================================================
Private Property Get fileNames(ByVal pos As Long, ByVal theType As SHOP_TYPE) As String
    fileNames = inventory(theType).fileNames(m_indices(pos))
End Property

'=========================================================================
' Get an inventory quantity (positions mapped to m_indices array)
'=========================================================================
Private Property Get quantities(ByVal pos As Long, ByVal theType As SHOP_TYPE) As Long
    quantities = inventory(theType).quantities(m_indices(pos))
End Property

'=========================================================================
' Get an inventory
'=========================================================================
Private Property Get inventory(ByVal theType As SHOP_TYPE) As CInventory
    If theType = Buy Then
        Set inventory = m_items
    ElseIf theType = Sell Then
        Set inventory = m_player
    End If
End Property

'=========================================================================
' Update item information
'=========================================================================
Private Sub updateItemInfo(ByVal pos As Long)
    Dim cnv As Long
    cnv = CreateCanvas(172, 399)
    Call CanvasFill(cnv, TRANSP_COLOR)
    With item(pos)
        If (LenB(.itemName)) Then
            Call CanvasDrawText(cnv, .itemName, fontName, 25, 1, 1, 0, , , True)
            Call CanvasDrawText(cnv, .itmDescription, fontName, 20, 1, (3 * 25 - 25) / 20, 0)
            If .MenuYN = 1 Then
                Call CanvasDrawText(cnv, "Item can be used", fontName, 25, 1, 4 - 0.5, 0)
                Call CanvasDrawText(cnv, "from the menu", fontName, 25, 1, 5 - 0.5, 0)
                If .mnuHPup > 0 Then
                    Call CanvasDrawText(cnv, "Restores " & .mnuHPup & " HP", fontName, 25, 1, 7 - 0.5, 0)
                End If
                If .mnuSMup > 0 Then
                    Call CanvasDrawText(cnv, "Restores " & .mnuSMup & " SMP", fontName, 25, 1, 8 - 0.5, 0)
                End If
            Else
                Call CanvasDrawText(cnv, "Item cannot be", fontName, 25, 1, 4 - 0.5, 0)
                Call CanvasDrawText(cnv, "used from the menu", fontName, 25, 1, 5 - 0.5, 0)
            End If
            If .FightYN = 1 Then
                Call CanvasDrawText(cnv, "Item can be used", fontName, 25, 1, 10 - 0.5, 0)
                Call CanvasDrawText(cnv, "in a fight", fontName, 25, 1, 11 - 0.5, 0)
                If .mnuHPup > 0 Then
                    Call CanvasDrawText(cnv, "Restores " & .mnuHPup & " HP", fontName, 25, 1, 13 - 0.5, 0)
                End If
                If .mnuSMup > 0 Then
                    Call CanvasDrawText(cnv, "Restores " & .mnuSMup & " SMP", fontName, 25, 1, 14 - 0.5, 0)
                End If
            Else
                Call CanvasDrawText(cnv, "Item cannot be", fontName, 25, 1, 10 - 0.5, 0)
                Call CanvasDrawText(cnv, "used in a fight", fontName, 25, 1, 11 - 0.5, 0)
            End If
            If .EquipYN = 1 Then
                Call CanvasDrawText(cnv, "Item can be equip", fontName, 25, 1, 16 - 0.5, 0)
            Else
                Call CanvasDrawText(cnv, "Not equippable", fontName, 25, 1, 16 - 0.5, 0)
            End If
        End If
    End With
    Call Canvas2CanvasBlt(cnv, m_itemInfo, 0, 0)
    Call DestroyCanvas(cnv)
End Sub

'=========================================================================
' Process a transaction
'=========================================================================
Private Function processTransaction(ByVal pos As Long, ByVal theType As SHOP_TYPE) As Boolean
    Dim theWord As String, theCost As Long
    With item(pos)
        If theType = Buy Then
            theWord = "buy"
            theCost = .buyPrice
        Else
            theWord = "sell"
            theCost = .sellPrice
        End If
        Call FlushKB
        If MBox("Are you sure you want to " & theWord & " a " & vbLf & .itemName & " for " & theCost & " GP?", "Transaction Confirmation", MBT_YESNO) = MBR_YES Then
            If theType = Buy Then
                If money < theCost Then
                    Call FlushKB
                    Call MBox("You do not have enough GP!", "Transaction Error")
                Else
                    processTransaction = True
                    Call m_player.addItem(fileNames(pos, Buy))
                    money = money - theCost
                End If
            Else
                processTransaction = True
                Call m_player.removeItem(fileNames(pos, Sell))
                money = money + theCost
            End If
        End If
    End With
End Function

'=========================================================================
' Shop menu
'=========================================================================
Private Sub shopMenuScanKeys(ByVal baseCanvas As Long, ByVal theType As SHOP_TYPE)

    On Error Resume Next

    Dim cnv As Long, pos As Long

    Const MAX_ITEMS = 14

    cnv = CreateCanvas(globalCanvasWidth, globalCanvasHeight)
    Call createShopMenuDisplay(baseCanvas, cnv, theType)

    m_itemInfo = CreateCanvas(172, 399)
    Call updateItemInfo(pos)

    Do
        Call DXDrawCanvas(cnv, 0, 0)
        Call DXDrawCanvasTransparent(m_itemInfo, 200, 60, TRANSP_COLOR)
        Call CBDrawHand(411.01, pos + 60.01 + ((pos) * 25) + 12.5)
        Call DXRefresh
        If isPressed("UP") Then
            If pos = 0 Then
                pos = MAX_ITEMS
            Else
                pos = pos - 1
            End If
            Call cursorDelay
            Call updateItemInfo(pos)
        ElseIf isPressed("DOWN") Then
            If pos = MAX_ITEMS Then
                pos = 0
            Else
                pos = pos + 1
            End If
            Call cursorDelay
            Call updateItemInfo(pos)
        ElseIf isPressed("ESC") Or isPressed("LEFT") Then
            Call cursorDelay
            Exit Do
        ElseIf isPressed("ENTER") Or isPressed("SPACE") Or isPressed("RIGHT") Then
            If (LenB(Trim$(handles(pos)))) Then
                If processTransaction(pos, theType) Then
                    Call CanvasFill(cnv, 0)
                    If theType = Buy Then
                        Call createMainMenuDisplay(baseCanvas, OPTION1)
                    Else
                        Call createMainMenuDisplay(baseCanvas, OPTION2)
                    End If
                    Call createShopMenuDisplay(baseCanvas, cnv, theType)
                    Call updateItemInfo(pos)
                End If
                Call cursorDelay
                Call FlushKB
            End If
        End If
        Call processEvent
    Loop

    'Clean up
    Call DestroyCanvas(cnv)
    Call DestroyCanvas(m_itemInfo)

End Sub

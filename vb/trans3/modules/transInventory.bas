Attribute VB_Name = "transInventory"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

Option Explicit
'inventory management routines

Public Type InventoryItem
    file As String  'filename of item in inventory
    handle As String    'handle
    number As Long  'count
End Type

Public Type TKInventory
    item() As InventoryItem 'list of inventory items
End Type

Sub AddItemToList(ByVal file As String, ByRef theInv As TKInventory)
    'Add an item to the inventory
    On Error Resume Next
    'Scan inventory for this item
    Dim lit As String
    lit$ = file$
    Dim theOne As Long
    Dim t As Long
    
    theOne = -1
    Dim done As Boolean
    done = False
    Do While Not (done)
        For t = 0 To UBound(theInv.item)
            If UCase$(theInv.item(t).file) = UCase$(lit$) Then theOne = t
        Next t
        If theOne <> -1 Then
            theInv.item(theOne).number = theInv.item(theOne).number + 1
            Exit Sub
        Else
            theOne = -1
            For t = 0 To UBound(theInv.item)
                If theInv.item(t).file = "" Then
                    theOne = t
                    Exit For
                End If
            Next t
        End If
        If theOne = -1 Then
            'resize inventory...
            Dim sz As Long
            sz = UBound(theInv.item)
            ReDim Preserve theInv.item(sz)
        Else
            done = True
        End If
    Loop
    theInv.item(theOne).file = lit$
    theInv.item(theOne).number = 1
    'Now get item handle:
    file$ = projectPath$ + itmPath$ + lit$
    Dim anItem As TKItem
    Call openitem(file$, anItem)
    
    Dim nameItm As String
    nameItm$ = anItem.itemName
    theInv.item(theOne).handle = nameItm$
End Sub


Sub InitInventory(ByRef theInv As TKInventory)
    'init invenotory list
    On Error Resume Next
    ReDim theInv.item(500)
End Sub

Sub RemoveItemfromList(ByVal file As String, ByRef theInv As TKInventory)
    'Remove item from inventory
    'Scan inventory for this item
    On Error Resume Next
    Dim lit As String, theOne As Long, t As Long
    lit$ = file$
    theOne = -1
    For t = 0 To UBound(theInv.item)
        If UCase$(theInv.item(t).file) = UCase$(lit$) Then theOne = t
    Next t
    
    If theOne <> -1 Then
        theInv.item(theOne).number = theInv.item(theOne).number - 1
        If theInv.item(theOne).number <= 0 Then
            theInv.item(theOne).number = 0
            theInv.item(theOne).file = ""
            theInv.item(theOne).handle = ""
        End If
    End If
End Sub




Attribute VB_Name = "Shop"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'shop
Global itemsforsale$(500)   'filenames of 500 items to sell.
Public itemMap(500) As Long

'FIXIT: Declare 'num' with an early-bound data type                                        FixIT90210ae-R1672-R1B8ZE
Sub shopGiveItems(file$, num)
    'add num items as defined by file$
    On Error GoTo errorhandler
    n$ = getItemName(projectPath$ + itmPath$ + file$)
    file$ = addext(file$, ".itm")

    'Scan inventory for this item
    theOne = -1
    For t = 0 To UBound(inv.item)
        If UCase$(inv.item(t).file) = UCase$(file$) Then theOne = t
    Next t
    If theOne <> -1 Then
        inv.item(theOne).number = inv.item(theOne).number + num
        Exit Sub
    Else
        theOne = -1
        For t = 0 To UBound(inv.item)
            If inv.item(t).file = "" Then theOne = t: t = 500
        Next t
    End If
    If theOne = -1 Then
        Call debugger("Error: Can't give item!  Inventory is full!-- " + text$)
        Exit Sub
    End If
    inv.item(theOne).file = file$
    inv.item(theOne).number = num
    'Now get item handle:
    inv.item(theOne).handle = n$

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

'FIXIT: Declare 'num' with an early-bound data type                                        FixIT90210ae-R1672-R1B8ZE
Sub shopTakeItems(file$, num)
    'take num items as defined by file$
    On Error GoTo errorhandler
    n$ = getItemName(projectPath$ + itmPath$ + file$)
    file$ = addext(file$, ".itm")
    'Scan inventory for this item
    theOne = -1
    For t = 0 To UBound(inv.item)
        If UCase$(inv.item(t).file) = UCase$(file$) Then theOne = t
    Next t
    If theOne <> -1 Then
        inv.item(theOne).number = inv.item(theOne).number - num
        If inv.item(theOne).number <= 0 Then
            inv.item(theOne).file = ""
            inv.item(theOne).number = 0
            inv.item(theOne).handle = ""
        End If
        Exit Sub
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

'FIXIT: Declare 'num' with an early-bound data type                                        FixIT90210ae-R1672-R1B8ZE
Sub summonShop(itemsell$(), num)
    'opens shop window to sell any items in the
    'itemsell$ array (num is size of array)
    On Error GoTo errorhandler

    shopwindow.Show


    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CInventory"
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
' Item management system
' Status: A+
'=========================================================================

Option Explicit

'=========================================================================
' Member structures
'=========================================================================
Private Type invItem
    file As String
    handle As String
    number As Long
End Type

'=========================================================================
' Member variables
'=========================================================================
Private m_items() As invItem
Private m_appendExtension As Boolean
Private m_differentTypes As Long

'=========================================================================
' Item file names
'=========================================================================
Public Property Let fileNames(ByVal pos As Long, ByVal filename As String)
    m_items(pos).file = filename
End Property
Public Property Get fileNames(ByVal pos As Long) As String
    fileNames = m_items(pos).file
End Property

'=========================================================================
' Item handles
'=========================================================================
Public Property Let handles(ByVal pos As Long, ByVal handle As String)
    m_items(pos).handle = handle
End Property
Public Property Get handles(ByVal pos As Long) As String
    handles = m_items(pos).handle
End Property

'=========================================================================
' Item quantities
'=========================================================================
Public Property Let quantities(ByVal pos As Long, ByVal quantity As Long)
    m_items(pos).number = quantity
End Property
Public Property Get quantities(ByVal pos As Long) As Long
    quantities = m_items(pos).number
End Property

'=========================================================================
' Append extension?
'=========================================================================
Public Property Let appendItmExtension(ByVal append As Boolean)
    m_appendExtension = append
End Property

'=========================================================================
' How many different types of items are in this inventory?
'=========================================================================
Public Property Get differentTypes() As Long
    differentTypes = m_differentTypes
End Property

'=========================================================================
' Current size of inventory
'=========================================================================
Public Property Get upperBound() As Long
    upperBound = UBound(m_items)
End Property

'=========================================================================
' Class constructor
'=========================================================================
Private Sub Class_Initialize()
    'Create positions for 501 items (time saver)
    ReDim m_items(500)
    'Add .itm to items passed in
    m_appendExtension = True
End Sub

'=========================================================================
' Add item(s) to the inventory
'=========================================================================
Public Sub addItem( _
                      ByVal file As String, _
                      Optional ByVal quantity As Long = 1 _
                                                           )

    On Error Resume Next

    'Make sure we have a .itm extension on the file
    If m_appendExtension Then file = addExt(file, ".itm")

    Dim theOne As Long  'the position
    Dim itmNum As Long  'current item number

    theOne = -1 'indicate we've yet to find a position

    'See if the player already has one of this item
    For itmNum = 0 To UBound(m_items)
        If UCase(m_items(itmNum).file) = UCase(file) Then
            'Found it!
            theOne = itmNum
            Exit For
        End If
    Next itmNum

    If theOne <> -1 Then
        'Just increase the amount of that item
        m_items(theOne).number = m_items(theOne).number + quantity
    Else

        m_differentTypes = m_differentTypes + 1

        'Find an open position
        For itmNum = 0 To UBound(m_items)
            If m_items(itmNum).file = "" Then
                'Found one!
                theOne = itmNum
                Exit For
            End If
        Next itmNum

        If theOne = -1 Then
            'There were no open position-- enlarge the array!
            ReDim Preserve m_items(UBound(m_items) + 1)
            theOne = UBound(m_items)
        End If

        With m_items(theOne)
            'Add the item to the inventory
            .file = file
            .number = quantity
            .handle = getItemName(projectPath & itmPath & file)
        End With

    End If

End Sub

'=========================================================================
' Take item(s) from the inventory
'=========================================================================
Public Sub removeItem( _
                         ByVal file As String, _
                         Optional ByVal quantity As Long = 1 _
                                                               )

    On Error Resume Next

    'Make sure we have a .itm extension
    If m_appendExtension Then file = addExt(file, ".itm")

    Dim theOne As Long  'the position
    Dim itmNum As Long  'current item number

    theOne = -1 'indicate we've yet to find a position

    'Search for the item in the inventory
    For itmNum = 0 To UBound(m_items)
        If UCase(m_items(itmNum).file) = UCase(file) Then
            'Found it!
            theOne = itmNum
            Exit For
        End If
    Next itmNum

    'If we found it
    If theOne <> -1 Then
        m_differentTypes = m_differentTypes - 1
        With m_items(theOne)
            'Take away the items
            .number = .number - quantity
            'If there are none left, remove all info
            If .number <= 0 Then
                .file = ""
                .number = 0
                .handle = ""
            End If
        End With
    End If

End Sub

'=========================================================================
' Clear the inventory
'=========================================================================
Public Sub clear()
    'Just redimension the array (clearing its contents)
    ReDim m_items(500)
End Sub

VERSION 5.00
Begin VB.Form shopwindow 
   Appearance      =   0  'Flat
   BackColor       =   &H00404040&
   BorderStyle     =   0  'None
   Caption         =   "Shop"
   ClientHeight    =   7200
   ClientLeft      =   375
   ClientTop       =   105
   ClientWidth     =   9600
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H80000008&
   Icon            =   "SHOPWIND.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   7200
   ScaleWidth      =   9600
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Tag             =   "1986"
   Begin VB.VScrollBar sellscroll 
      Height          =   255
      Left            =   8040
      Max             =   98
      TabIndex        =   19
      Top             =   840
      Value           =   98
      Width           =   135
   End
   Begin VB.CommandButton Command5 
      Appearance      =   0  'Flat
      Caption         =   "Info"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   5400
      Style           =   1  'Graphical
      TabIndex        =   16
      Tag             =   "1895"
      Top             =   6120
      Visible         =   0   'False
      Width           =   615
   End
   Begin VB.CommandButton Command4 
      Appearance      =   0  'Flat
      Caption         =   "Info"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   360
      Style           =   1  'Graphical
      TabIndex        =   15
      Tag             =   "1895"
      Top             =   6120
      Visible         =   0   'False
      Width           =   615
   End
   Begin VB.ListBox yourinventory 
      Appearance      =   0  'Flat
      BackColor       =   &H00808080&
      Height          =   4320
      Left            =   5400
      TabIndex        =   11
      Top             =   1800
      Width           =   3615
   End
   Begin VB.ListBox salelist 
      Appearance      =   0  'Flat
      BackColor       =   &H00808080&
      Height          =   4320
      Left            =   360
      TabIndex        =   9
      Top             =   1800
      Width           =   3615
   End
   Begin VB.VScrollBar qscroll 
      Height          =   255
      Left            =   2040
      Max             =   98
      TabIndex        =   5
      Top             =   840
      Value           =   98
      Width           =   135
   End
   Begin VB.CommandButton Command3 
      Appearance      =   0  'Flat
      Caption         =   "Exit"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   7800
      Style           =   1  'Graphical
      TabIndex        =   3
      Tag             =   "1426"
      Top             =   6600
      Width           =   1575
   End
   Begin VB.CommandButton Command2 
      Appearance      =   0  'Flat
      Caption         =   "<--"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   4440
      Style           =   1  'Graphical
      TabIndex        =   2
      Top             =   4200
      Width           =   495
   End
   Begin VB.CommandButton Command1 
      Appearance      =   0  'Flat
      Caption         =   "-->"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   4440
      Style           =   1  'Graphical
      TabIndex        =   1
      Top             =   2880
      Width           =   495
   End
   Begin VB.Line Line2 
      BorderColor     =   &H00FFFFFF&
      X1              =   4680
      X2              =   4680
      Y1              =   600
      Y2              =   6120
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00FFFFFF&
      X1              =   120
      X2              =   9480
      Y1              =   600
      Y2              =   600
   End
   Begin VB.Label sell 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "0"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Left            =   7680
      TabIndex        =   21
      Tag             =   "1251"
      Top             =   1080
      Width           =   1455
   End
   Begin VB.Label qsell 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "1"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Left            =   7680
      TabIndex        =   20
      Tag             =   "1250"
      Top             =   840
      Width           =   495
   End
   Begin VB.Label Label4 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Total Selling Price:"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Index           =   1
      Left            =   5400
      TabIndex        =   18
      Tag             =   "1989"
      Top             =   1080
      Width           =   2175
   End
   Begin VB.Label Label2 
      Appearance      =   0  'Flat
      BackColor       =   &H00FFFFFF&
      BackStyle       =   0  'Transparent
      Caption         =   "Quantity To Sell:"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Index           =   1
      Left            =   5400
      TabIndex        =   17
      Tag             =   "1990"
      Top             =   840
      Width           =   2175
   End
   Begin VB.Label currentgp 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "0"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   11.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Left            =   4560
      TabIndex        =   14
      Tag             =   "1251"
      Top             =   6720
      Width           =   2295
   End
   Begin VB.Label Label5 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Current GP:"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   11.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Left            =   2880
      TabIndex        =   13
      Tag             =   "1991"
      Top             =   6720
      Width           =   1575
   End
   Begin VB.Label Label3 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Your Current Inventory:"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Index           =   1
      Left            =   5400
      TabIndex        =   12
      Tag             =   "1992"
      Top             =   1440
      Width           =   2895
   End
   Begin VB.Label Label3 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Items For Sale:"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Index           =   0
      Left            =   360
      TabIndex        =   10
      Tag             =   "1993"
      Top             =   1440
      Width           =   1815
   End
   Begin VB.Label cost 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "0"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Left            =   1680
      TabIndex        =   8
      Tag             =   "1251"
      Top             =   1080
      Width           =   1335
   End
   Begin VB.Label Label4 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Total Cost:"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Index           =   0
      Left            =   360
      TabIndex        =   7
      Tag             =   "1994"
      Top             =   1080
      Width           =   1215
   End
   Begin VB.Label quantity 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "1"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Left            =   1680
      TabIndex        =   6
      Tag             =   "1250"
      Top             =   840
      Width           =   375
   End
   Begin VB.Label Label2 
      Appearance      =   0  'Flat
      BackColor       =   &H00FFFFFF&
      BackStyle       =   0  'Transparent
      Caption         =   "Quantity:"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Index           =   0
      Left            =   360
      TabIndex        =   4
      Tag             =   "1995"
      Top             =   840
      Width           =   1215
   End
   Begin VB.Label Label1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Shop"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   15.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   375
      Left            =   120
      TabIndex        =   0
      Tag             =   "1986"
      Top             =   120
      Width           =   4455
   End
End
Attribute VB_Name = "shopwindow"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

Private Sub Command1_Click()
    'buy
    On Error GoTo errorhandler
    Dim anItem As TKItem
    
    n = salelist.ListIndex
    selone = 0
    theOne = -1
    For t = 0 To 500
        If itemsforsale$(t) <> "" Then theOne = theOne + 1
        If theOne = n Then selone = t: Exit For
    Next t
    Call openitem(projectPath$ + itmPath$ + itemsforsale$(selone), anItem)
    bp = anItem.buyPrice
    bp = bp * val(quantity.caption)
    cost.caption = str$(bp)
    res = MsgBox(LoadStringLoc(845, "Are you sure you want to buy ") + quantity.caption + " " + anItem.itemName + LoadStringLoc(846, " For ") + cost.caption + LoadStringLoc(847, " GP?"), vbYesNo)
    If res = 6 Then
        'clicked yes.
        'check required gp
        gpreq = val(cost.caption)
        If gpreq > GPCount Then
            'MsgBox "Got here"
            Call MsgBox(LoadStringLoc(849, "Sorry, you don't have enough GP to buy this."), , LoadStringLoc(848, "Buy Item"))
            'MsgBox "Sorry, you don't have enough GP to buy this.", , "Buy Item"
            Exit Sub
        End If
        'MsgBox "maybe here"
        GPCount = GPCount - gpreq
        Call shopGiveItems(itemsforsale$(selone), val(quantity.caption))
        Call infofill
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command2_Click()
    On Error GoTo errorhandler
    
    Dim anItem As TKItem
    
    n = yourinventory.ListIndex
    If n = -1 Then n = 0
    n = itemMap(n)
    If inv.item(n).file <> "" Then
        Call openitem(projectPath$ + itmPath$ + inv.item(n).file, anItem)
        If anItem.keyItem = 1 Then
            Call MsgBox(LoadStringLoc(850, "You cannot sell this item!"), , LoadStringLoc(839, "Key Item"))
            'MsgBox "You cannot sell this item!", , "Key Item"
            Exit Sub
        End If
    End If
    numowned = inv.item(n).number
    If val(qsell.caption) > numowned Then qsell.caption = str$(numowned)
    
    bp = anItem.sellPrice
    bp = bp * val(qsell.caption)
    sell.caption = str$(bp)
    res = MsgBox(LoadStringLoc(851, "Are you sure you want to sell ") + qsell.caption + " " + anItem.itemName + LoadStringLoc(846, " For ") + sell.caption + LoadStringLoc(847, " GP?"), vbYesNo, LoadStringLoc(852, "Sell Item"))
    If res = 6 Then
        'clicked yes.
        'check required gp
        gpreq = val(sell.caption)
        GPCount = GPCount + gpreq
        Call shopTakeItems(inv.item(n).file, val(qsell.caption))
        Call infofill
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command3_Click()
    Unload shopwindow
End Sub

Private Sub Command4_Click()
    On Error GoTo errorhandler
    
    Dim anItem As TKItem
    
    n = salelist.ListIndex
    selone = 0
    theOne = -1
    For t = 0 To 500
        If itemsforsale$(t) <> "" Then theOne = theOne + 1
        If theOne = n Then selone = t: Exit For
    Next t
    Call openitem(projectPath$ + itmPath$ + itemsforsale$(selone), anItem)
    iteminfo.Show   'Show item info.

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command5_Click()
    On Error GoTo errorhandler
    
    Dim anItem As TKItem
    
    n = yourinventory.ListIndex
    If n = -1 Then n = 0
    n = itemMap(n)
    If inv.item(n).file <> "" Then
        Call openitem(projectPath$ + itmPath$ + inv.item(n).file, anItem)
        iteminfo.Show   'Show item info.
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub fillInventory()
    'fills the inventory box
    On Error GoTo errorhandler
    For t = 0 To 500
        itemMap(t) = 0
    Next t
    yourinventory.Clear
    mapnum = 0
    For t = 0 To UBound(inv.item)
        If inv.item(t).handle <> "" Then 'Handles of 500 items in inventory
            If inv.item(t).number <> 0 Then
                textadd$ = inv.item(t).handle + ":" + str$(inv.item(t).number)
                yourinventory.AddItem textadd$
                itemMap(mapnum) = t
                mapnum = mapnum + 1
            End If
        End If
    Next t

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub fillSelling()
    'fills the for sale box.
    On Error GoTo errorhandler
    salelist.Clear
    For t = 1 To UBound(inv.item)
        If itemsforsale$(t) <> "" Then
            n$ = getItemName(projectPath$ + itmPath$ + itemsforsale$(t))
            salelist.AddItem (n$)
        End If
    Next t

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Form_Activate()
    shopwindow.Top = host.Top
    shopwindow.Left = host.Left
End Sub

Private Sub Form_KeyDown(keyCode As Integer, shift As Integer)
    On Error GoTo errorhandler
keyWaitState = keyCode
keyShiftState = shift


    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Form_Load()
    On Error GoTo errorhandler
    Call LocalizeForm(Me)
    shopwindow.BackColor = menuColor
    rr = red(menuColor)
    gg = green(menuColor)
    bb = blue(menuColor)
    salelist.BackColor = RGB(rr + 128, gg + 128, bb + 128)
    yourinventory.BackColor = RGB(rr + 128, gg + 128, bb + 128)
    Call infofill
    shopwindow.Top = host.Top
    shopwindow.Left = host.Left
    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub infofill()
    On Error GoTo errorhandler
    quantity.caption = str$(99 - qscroll.value)
    currentgp.caption = str$(GPCount)
    qsell.caption = str$(99 - sellscroll.value)
    Call fillSelling
    Call fillInventory

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


Private Sub qscroll_Change()
    On Error GoTo errorhandler
    priceperunit = val(cost.caption) / val(quantity.caption)
    quantity.caption = str$(99 - qscroll.value)
    cost.caption = str$(priceperunit * val(quantity.caption))

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub salelist_Click()
    On Error GoTo errorhandler
    
    Dim anItem As TKItem
    
    n = salelist.ListIndex
    selone = 0
    theOne = -1
    For t = 0 To UBound(inv.item)
        If itemsforsale$(t) <> "" Then theOne = theOne + 1
        If theOne = n Then selone = t: Exit For
    Next t
    Call openitem(projectPath$ + itmPath$ + itemsforsale$(selone), anItem)
    bp = anItem.buyPrice
    bp = bp * val(quantity.caption)
    cost.caption = str$(bp)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub sellscroll_Change()
    On Error GoTo errorhandler
    priceperunit = val(sell.caption) / val(qsell.caption)
    qsell.caption = str$(99 - sellscroll.value)
    sell.caption = str$(priceperunit * val(qsell.caption))

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub yourinventory_Click()
    On Error GoTo errorhandler
    Dim anItem As TKItem
    
    n = yourinventory.ListIndex
    If n = -1 Then n = 0
    'n = ItemMap(n)
    If inv.item(n).file <> "" Then
        Call openitem(projectPath$ + itmPath$ + inv.item(n).file, anItem)
        bp = anItem.sellPrice
        bp = bp * val(qsell.caption)
        sell.caption = str$(bp)
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub


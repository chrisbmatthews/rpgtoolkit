VERSION 5.00
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "tabctl32.ocx"
Begin VB.Form tilesetedit 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Tile Set Editor"
   ClientHeight    =   5415
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5655
   Icon            =   "tilesetedit.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   ScaleHeight     =   5415
   ScaleWidth      =   5655
   StartUpPosition =   2  'CenterScreen
   Tag             =   "1564"
   Begin VB.CommandButton cmdOK 
      Caption         =   "OK"
      Height          =   375
      Left            =   120
      TabIndex        =   1
      Top             =   4920
      Width           =   1095
   End
   Begin TabDlg.SSTab SSTab1 
      Height          =   4695
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   5415
      _ExtentX        =   9551
      _ExtentY        =   8281
      _Version        =   393216
      Style           =   1
      Tab             =   1
      TabHeight       =   520
      TabCaption(0)   =   "Manually"
      TabPicture(0)   =   "tilesetedit.frx":0CCA
      Tab(0).ControlEnabled=   0   'False
      Tab(0).Control(0)=   "frmManual"
      Tab(0).Control(0).Enabled=   0   'False
      Tab(0).Control(1)=   "Picture1"
      Tab(0).Control(1).Enabled=   0   'False
      Tab(0).ControlCount=   2
      TabCaption(1)   =   "Visually"
      TabPicture(1)   =   "tilesetedit.frx":0CE6
      Tab(1).ControlEnabled=   -1  'True
      Tab(1).Control(0)=   "frmVisual"
      Tab(1).Control(0).Enabled=   0   'False
      Tab(1).ControlCount=   1
      TabCaption(2)   =   "Advanced"
      TabPicture(2)   =   "tilesetedit.frx":0D02
      Tab(2).ControlEnabled=   0   'False
      Tab(2).ControlCount=   0
      Begin VB.PictureBox Picture1 
         BorderStyle     =   0  'None
         Height          =   975
         Left            =   -74760
         ScaleHeight     =   975
         ScaleWidth      =   4935
         TabIndex        =   13
         Top             =   840
         Width           =   4935
         Begin VB.CommandButton cmdBrowse 
            Caption         =   "Browse"
            Height          =   255
            Left            =   2640
            TabIndex        =   16
            Top             =   250
            Width           =   1335
         End
         Begin VB.TextBox txtGPH 
            Height          =   285
            Left            =   0
            TabIndex        =   15
            Top             =   240
            Width           =   2535
         End
         Begin VB.CommandButton cmdAddFiles 
            Caption         =   "Add Files to Tileset"
            Height          =   255
            Left            =   0
            TabIndex        =   14
            Top             =   600
            Width           =   2535
         End
         Begin VB.Label Label2 
            Caption         =   "Wildcards are allowed (ie. *.gph, c*.gph, etc)."
            Height          =   255
            Left            =   0
            TabIndex        =   17
            Tag             =   "1569"
            Top             =   0
            Width           =   3255
         End
      End
      Begin VB.Frame frmVisual 
         Caption         =   "Visually Add Files"
         Height          =   4095
         Left            =   120
         TabIndex        =   5
         Top             =   480
         Width           =   5175
         Begin VB.PictureBox Picture3 
            BorderStyle     =   0  'None
            Height          =   1095
            Left            =   2040
            ScaleHeight     =   1095
            ScaleWidth      =   735
            TabIndex        =   22
            Top             =   1320
            Width           =   735
            Begin VB.CommandButton cmdAdd 
               Caption         =   "Add ->"
               Height          =   375
               Left            =   0
               TabIndex        =   24
               Tag             =   "1752"
               Top             =   0
               Width           =   735
            End
            Begin VB.CommandButton cmdCopy 
               Caption         =   "<- Copy"
               Height          =   375
               Left            =   0
               TabIndex        =   23
               Tag             =   "1751"
               Top             =   480
               Width           =   735
            End
         End
         Begin VB.PictureBox Picture2 
            BorderStyle     =   0  'None
            Height          =   975
            Left            =   120
            ScaleHeight     =   975
            ScaleWidth      =   4935
            TabIndex        =   18
            Top             =   3000
            Width           =   4935
            Begin VB.CommandButton cmdDelete 
               Caption         =   "Delete Selected File"
               Height          =   345
               Left            =   0
               TabIndex        =   21
               Tag             =   "1749"
               Top             =   120
               Width           =   1575
            End
            Begin VB.CommandButton cmdRemove 
               Caption         =   "Remove Duplicates"
               Height          =   345
               Left            =   0
               TabIndex        =   20
               Tag             =   "1748"
               Top             =   600
               Width           =   1575
            End
            Begin VB.CommandButton cmdStop 
               Caption         =   "Stop!"
               Enabled         =   0   'False
               Height          =   345
               Left            =   3600
               TabIndex        =   19
               Tag             =   "1747"
               Top             =   0
               Width           =   975
            End
         End
         Begin VB.CheckBox chkDelete 
            Caption         =   "Delete file when moved"
            Height          =   255
            Left            =   120
            TabIndex        =   9
            Tag             =   "1750"
            Top             =   2640
            Width           =   2535
         End
         Begin VB.ListBox lstTileset 
            Appearance      =   0  'Flat
            Height          =   1980
            Left            =   2880
            TabIndex        =   8
            Top             =   600
            Width           =   1815
         End
         Begin VB.FileListBox lstFiles 
            Appearance      =   0  'Flat
            Height          =   1980
            Left            =   120
            TabIndex        =   7
            Top             =   600
            Width           =   1815
         End
         Begin VB.PictureBox pcbBrowse 
            Appearance      =   0  'Flat
            AutoRedraw      =   -1  'True
            BackColor       =   &H80000005&
            ForeColor       =   &H80000008&
            Height          =   505
            Left            =   2160
            ScaleHeight     =   32
            ScaleMode       =   3  'Pixel
            ScaleWidth      =   32
            TabIndex        =   6
            Top             =   600
            Width           =   505
         End
         Begin VB.Label lblProgress 
            Height          =   255
            Left            =   2880
            TabIndex        =   12
            Top             =   2640
            Width           =   1815
         End
         Begin VB.Label lblSelected 
            Caption         =   "Selected Tileset"
            Height          =   375
            Left            =   2880
            TabIndex        =   11
            Tag             =   "1753"
            Top             =   360
            Width           =   1815
         End
         Begin VB.Label lblGPH 
            Caption         =   ".GPH Tiles In Directory"
            Height          =   255
            Left            =   120
            TabIndex        =   10
            Tag             =   "1754"
            Top             =   360
            Width           =   2175
         End
      End
      Begin VB.Frame frmManual 
         Caption         =   "Manually Add Files"
         Height          =   2055
         Left            =   -74880
         TabIndex        =   2
         Top             =   480
         Width           =   5175
         Begin VB.PictureBox percdone 
            BackColor       =   &H00FFFFFF&
            Height          =   255
            Left            =   120
            ScaleHeight     =   195
            ScaleMode       =   0  'User
            ScaleWidth      =   93.013
            TabIndex        =   3
            Top             =   1560
            Width           =   3255
         End
         Begin VB.Label cmdProgress 
            Caption         =   "Progress"
            Height          =   255
            Left            =   120
            TabIndex        =   4
            Top             =   1320
            Width           =   615
         End
      End
   End
End
Attribute VB_Name = "tilesetedit"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'========================================================================
'All contents copyright 2003, Christopher Matthews
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'========================================================================
'Option Explicit
'========================================================================
' Browse Button
'========================================================================
Private Sub cmdBrowse_Click()
    Dim dlg As FileDialogInfo
    Dim ex As String 'Extension of the opened file
    
    'Info of the Dialog Box we will open
    ChDir (currentDir$)
    dlg.strDefaultFolder = projectPath$ + tilePath$
    dlg.strTitle = "Select GPH files"
    dlg.strDefaultExt = "gph"
    dlg.strFileTypes = "RPG Toolkit Tile (*.gph)|*.gph|All files(*.*)|*.*"
    
    'Open the Dialog Box
    If OpenFileDialog(dlg, Me.hwnd) Then 'If the user didn't press cancel
        filename$(1) = dlg.strSelectedFile
        'Get the extention
        ex = GetExt(filename$(1))
        If ex = "gph" Then
            txtGPH.Text = RemovePath(filename$(1))
        End If
    End If
End Sub
'========================================================================
' Add Files to Tileset Button
'========================================================================
Private Sub cmdAddFiles_Click()
    On Error GoTo ErrorHandler
    Dim dlg As FileDialogInfo
    'The textbox text
    Dim gph As String
    'The tileset
    Dim file As String
    'Get the text
    gph = txtGPH.Text

    If gph = "" Then 'If it's empty
        MsgBox LoadStringLoc(979, "Please fill something out in the gpher Box (ie *.gph, etc)")
        Exit Sub
    End If
    
    If GetExt(gph) <> "gph" Then  'If the extension of the file is other then .gph
        MsgBox "Wrong filetype. You can only use *.gph files!", vbOKOnly + vbInformation
        Exit Sub
    End If
    
    'Info of the Dialog Box we will open
    ChDir (currentDir$)
    dlg.strDefaultFolder = projectPath$ + tilePath$
    dlg.strTitle = "Save Tileset As"
    dlg.strDefaultExt = "tst"
    dlg.strFileTypes = "RPG Toolkit TileSet (*.tst)|*.tst|All files(*.*)|*.*"
    
    'Open the Dialog Box
    If SaveFileDialog(dlg, Me.hwnd) Then 'If the user didn't press cancel
        'The filename with path
        filename$(1) = dlg.strSelectedFile
        'The filename without path
        Dim antiPath As String
        antiPath = dlg.strSelectedFileNoPath
        ChDir (currentDir$)
        file = filename$(1)
        
        'If file is empty, exit sub
        If file = "" Then Exit Sub
        
        'Textbox text with the full path
        Dim fullgph As String
        fullgph = Dir$(App.path$ + "\" + projectPath$ + tilePath$ + gph)
        
        'Variable for the progress bar, which we will use later on
        Dim dcount As Integer
        dcount = 1
        
        Do While fullgph <> ""
            fullgph = Dir$
            dcount = dcount + 1
        Loop

        Dim a As Integer
        'Get the tileset info
        Call openTile2(file)
        a = tilesetInfo(file)

        If Not (a = 0) Then
            Call createNewTileSet(file)
        End If
        
        fullgph = Dir$(App.path$ + "\" + projectPath$ + tilePath$ + gph)
        
        'Variable for the progress bar, which we will use later on
        Dim vcount As Integer
        vcount = 1
        
        Dim perc As Integer
        
        Do While fullgph <> ""
            Call openTile2(App.path$ + "\" + projectPath$ + tilePath$ + fullgph)
            a = addToTileSet(file)
            fullgph = Dir$
            vcount = vcount + 1
            
            'Calculate the length of the progress picturebox
            perc = Int((vcount / dcount) * 100)
            
            'Redraw the progress picturebox
            Call vbPicFillRect(percdone, 0, 0, perc, 1000, vbQBColor(9))
        Loop
        MsgBox LoadStringLoc(980, "All files added!")
    End If
    
    'Clear the progress picturebox
    Call vbPicFillRect(percdone, 0, 0, 1000, 1000, vbQBColor(15))
    
    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub
'========================================================================
' Add Button, adds a .gph file to the current tileset
'========================================================================
Private Sub cmdAdd_Click()
    On Error Resume Next
    
    'If there isn't a file selected, exit sub
    If lstFiles.ListIndex = -1 Then Exit Sub
    
    'The gph file
    Dim gphfile As String
    gphfile = lstFiles.filename
    
    'The gph file without the path
    Dim gphfilenp As String
    gphfilenp = noPath(gphfile)

    Call openWinTile(projectPath$ + tilePath$ + gphfile)
    Dim a, aa As Byte
    a = tilesetInfo(projectPath$ + tilePath$ + tstFile$)
    
    If a = 0 Then 'If the tileset exists
        aa = addToTileSet(projectPath$ & tilePath$ & tstFile$)
    Else 'If it doesn't exists, create a new one
        Call createNewTileSet(projectPath$ & tilePath$ & tstFile$)
    End If
    
    If chkDelete.value = 1 Then 'If the "Delete file when moved" checkbox is checked
        Kill projectPath$ & tilePath$ & lstFiles.filename
    End If
    
    'Refresh the .gph list
    lstFiles.Refresh
    'For the loop
    Dim tt, ts As Integer
    
    a = tilesetInfo(projectPath$ & tilePath$ & tstFile$)
    ts = tileset.tilesInSet
    'Add the new stuff to the Tileset list
    lstTileset.Clear
    For tt = 1 To ts
       lstTileset.AddItem ("Tile" & str$(tt))
    Next tt
End Sub
'========================================================================
' Copy Button, takes a tile out of the tileset, and make a .gph of it
'========================================================================
Private Sub cmdCopy_Click()
    On Error Resume Next
    
    'If there isn't a tile selected in the listbox, exit sub
    If lstTileset.ListIndex = -1 Then Exit Sub
    
    Dim idx As Integer
    idx = lstTileset.ListIndex + 1
    
    'Info of the Dialog Box we will open
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + tilePath$
    dlg.strTitle = "Save as"
    dlg.strDefaultExt = "gph"
    dlg.strFileTypes = "RPG Toolkit Tile (*.gph)|*.gph|All files(*.*)|*.*"
    
    If OpenFileDialog(dlg, Me.hwnd) Then 'If the user didn't press cancel
        filename$(1) = dlg.strSelectedFile
        Dim antiPath As String
        antiPath = dlg.strSelectedFileNoPath
        ChDir (currentDir$)
        If filename$(1) = "" Then Exit Sub
        
        'For the loop
        Dim x, y As Integer
        
        For x = 1 To 32
            For y = 1 To 32
                bufTile(x, y) = tileMem(x, y)
            Next y
        Next x
        
        Call openFromTileSet(projectPath$ + tilePath$ + tstFile$, idx)
        Call saveTile(filename$(1))
        lstFiles.Refresh
        For x = 1 To 32
            For y = 1 To 32
                tileMem(x, y) = bufTile(x, y)
            Next y
        Next x
    End If
End Sub
'========================================================================
' The Delete Selected File Button
'========================================================================
Private Sub cmdDelete_Click()
    On Error Resume Next
    'If nothing is selected, exit sub
    If lstFiles.ListIndex = -1 Then Exit Sub
    
    'The gph file
    Dim gphfile As String
    gphfile = lstFiles.filename
    
    Kill projectPath$ + tilePath$ + gphfile
    lstFiles.Refresh
End Sub
'========================================================================
' OK button
'========================================================================
Private Sub cmdOK_Click()
    Me.Hide
End Sub


'========================================================================
' Form_Load
'========================================================================
Private Sub Form_Load()
    Call LocalizeForm(Me)
End Sub
'========================================================================
' When you click in the Files list
'========================================================================
Private Sub lstFiles_Click()
    On Error Resume Next
    If lstFiles.ListIndex = -1 Then Exit Sub
    lstTileset.ListIndex = -1
    f$ = lstFiles.filename
    t$ = noPath(f$)
    
    For x = 1 To 32
        For y = 1 To 32
            bufTile(x, y) = tileMem(x, y)
        Next y
    Next x
    
    Call openTile2(projectPath$ + tilePath$ + f$)
    Call vbPicFillRect(pcbBrowse, 0, 0, 100, 100, vbQBColor(15))
    For x = 0 To 31
        For y = 0 To 31
            col = tileMem(x + 1, y + 1)
                If col = -1 Then col = vbQBColor(15)
            Call vbPicPSet(pcbBrowse, x, y, col)
        Next y
    Next x

    For x = 1 To 32
        For y = 1 To 32
            tileMem(x, y) = bufTile(x, y)
        Next y
    Next x
End Sub
'========================================================================
' When you click in the Tileset list
'========================================================================
Private Sub lstTileset_Click()
    On Error Resume Next
    If lstTileset.ListIndex = -1 Then Exit Sub
    lstFiles.ListIndex = -1
    idx = lstTileset.ListIndex + 1
    
    For x = 1 To 32
        For y = 1 To 32
            bufTile(x, y) = tileMem(x, y)
        Next y
    Next x

    Call openFromTileSet(projectPath$ + tilePath$ + tstFile$, idx)
    Call vbPicFillRect(pcbBrowse, 0, 0, 100, 100, vbQBColor(15))
    For x = 0 To 31
        For y = 0 To 31
            col = tileMem(x + 1, y + 1)
            If col = -1 Then col = vbQBColor(15)
            Call vbPicPSet(pcbBrowse, x, y, col)
        Next y
    Next x
    
    For x = 1 To 32
        For y = 1 To 32
            tileMem(x, y) = bufTile(x, y)
        Next y
    Next x
End Sub
'========================================================================
' When the tabs are changed
'========================================================================
Private Sub SSTab1_Click(PreviousTab As Integer)
    If SSTab1.Tab = 1 Then 'If the user clicks on the "Visually" tab
        Dim dlg As FileDialogInfo
        On Error Resume Next
        'Info of the Dialog Box we will open
        ChDir (currentDir$)
        dlg.strDefaultFolder = projectPath$ + tilePath$
        dlg.strTitle = "Tileset To Save To"
        dlg.strDefaultExt = "tst"
        dlg.strFileTypes = "RPG Toolkit TileSet (*.tst)|*.tst|All files(*.*)|*.*"
        
        'Open the Dialog Box
        If OpenFileDialog(dlg, Me.hwnd) Then 'If the user didn't press cancel
            filename$(1) = dlg.strSelectedFile
            Dim antiPath As String
            antiPath = dlg.strSelectedFileNoPath
            
            ChDir (currentDir$)
            
            'If, filename is empty, exit sub
            If filename$(1) = "" Then Exit Sub
            
            'Copy the file
            FileCopy filename$(1), projectPath$ + tilePath$ + antiPath$
            tstFile$ = antiPath$
            
            'Start adding the details to the form
            lstFiles.path = projectPath$ + tilePath$
            lstFiles.Pattern = "*.gph"
            tilesetedit.Caption = LoadStringLoc(2033, "Add to Tileset ") + tstFile$
            a = tilesetInfo(projectPath$ + tilePath$ + tstFile$)
            ts = tileset.tilesInSet
            lstTileset.Clear
            For tt = 1 To ts
                lstTileset.AddItem ("Tile" + str$(tt))
            Next tt
            'Change the caption name
            Me.Caption = "Tile Set Editor - " & tstFile$
        Else 'If cancel was pressed, return to the "Manually" tab
            SSTab1.Tab = 0
        End If
    ElseIf SSTab1.Tab = 2 Then
        Hide
        tilesetadd.Show vbModal
        Show
    End If

    'If we go back the the manually editor, change the caption back
    If PreviousTab = 1 Then Me.Caption = "Tile Set Editor"
End Sub
'========================================================================
' The Remove Duplicates button
'========================================================================
Private Sub cmdRemove_Click()
    On Error GoTo ErrorHandler
    tstStop = 0
    
    a = MsgBox("This will DELETE all duplicated tiles (originals will be kept), continue?", vbOKCancel + vbExclamation)
    
    If a = vbOK Then 'If user pressed OK, start the deleting
        MkDir Mid$(hashPath$, 1, Len(hashPath$) - 1)
        'Enable the stop button
        cmdStop.Enabled = True
        Call removeDuplicates
        RmDir Mid$(hashPath$, 1, Len(hashPath$) - 1)
        MsgBox "Done!", vbOKOnly + vbInformation
        'Refresh files list, since duplicates are now gone
        lstFiles.Refresh
        'Stop button shouldn't be enabled anymore
        cmdStop.Enabled = False
        'Clear the label
        lblProgress.Caption = ""
    End If
        
    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub
'========================================================================
' Scans all .gph files and removes duplicates
'========================================================================
Sub removeDuplicates()
    On Error GoTo ErrorHandler
    
    'Call the functions needed for the deleting
    Call removeHash
    Call createHashTable
    Call compareHash

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub
'========================================================================
' Deletes all hash files
'========================================================================
Sub removeHash()
    On Error GoTo ErrorHandler
    a$ = Dir(hashPath$ + "*.hsd")
    'Go through the files, and delete them
    Do While Not (a$ = "")
        Kill hashPath$ + a$
        a$ = Dir()
    Loop

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub
'========================================================================
' Opens each tile, and assigns it a hash value based upon the first 16
' diag pixels. Saves all results in the file hashed.hsd
'========================================================================
Sub createHashTable()
    On Error GoTo ErrorHandler
    'Backup the tile
    Call backUpTile
    
    nTiles = countTiles()
    If nTiles = 0 Then Exit Sub
    
    num = FreeFile
    Open hashPath$ + "hashed.hsd" For Output As #num
        a$ = Dir(projectPath$ + tilePath$ + "*.gph")
        Do While Not (a$ = "")
            cnt = cnt + 1
            total = 0
            Call openTile2(projectPath$ + tilePath$ + a$)
            For t = 1 To 16
                hv = tileMem(t, t) Mod 11
                total = total + hv
            Next t
            If total < 0 Then total = total * -1
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
            Print #num, a$
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
            Print #num, detail
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
            Print #num, total
            
            num2 = FreeFile
            Open hashPath$ + CStr(total) + ".hsd" For Append As #num2
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
                Print #num2, a$
'FIXIT: Print method has no Visual Basic .NET equivalent and will not be upgraded.         FixIT90210ae-R7593-R67265
                Print #num2, detail
            Close #num2
            
            pdone = Int((cnt / nTiles) * 50)
            lblProgress.Caption = str$(pdone) + "% (Hashing)"
            DoEvents
            a$ = Dir()
        Loop
    Close #num

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub
'========================================================================
' Back ups the tile
'========================================================================
Sub backUpTile()
    On Error GoTo ErrorHandler
    
    For x = 1 To 32
        For y = 1 To 32
            bufTile(x, y) = tileMem(x, y)
        Next y
    Next x
    
    openTileEditorDocs(activeTile.indice).oldDetail = detail

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub
'========================================================================
' Runs through the file hashed.hsd and compares each file to with the
' others. If it finds a match the tile will be loaded and compared.
'========================================================================
Sub compareHash()
    On Error Resume Next
    
    nTiles = countTiles()
    If nTiles = 0 Then Exit Sub
    
    num = FreeFile
    cnt = 0
    Open hashPath$ + "hashed.hsd" For Input As #num
        For l = 1 To nTiles
            If tstStop = 1 Then
                Exit For
            End If
            Line Input #num, fn$
            Input #num, fdet
            Input #num, fhash
            cnt = cnt + 1
            If fileExists(projectPath & tilePath & fn) Then
                'now check the corresponding hash file
                hnum$ = CStr(fhash) & ".hsd"
                num2 = FreeFile
                Open hashPath$ + hnum$ For Input As #num2
                    Do While Not EOF(num2)
                        Line Input #num2, hn$
                        Label4.Caption = "Checking " + fn$ + " and " + hn$
                        Input #num2, hdet
                        If Not (UCase$(hn$) = UCase$(fn$)) Then
                            If hdet = fdet Then
                                'same hash value, may be the same
                                If (compareTiles(fn$, hn$)) Then
                                    'they are the same, delete other
                                    'MsgBox fn$ + " " + hn$
                                    Kill projectPath$ + tilePath$ + hn$
                                End If
                            End If
                        End If
                    Loop
                Close #num2
                pdone = Int((cnt / nTiles) * 50) + 50
                lblProgress.Caption = str$(pdone) + "% (Comparing)"
                DoEvents
            End If
        Next l
    Close #num
    Call removeHash
End Sub
'========================================================================
' Compares 2 tiles, returns True/False
'========================================================================
Function compareTiles(ByVal f1 As String, ByVal f2 As String) As Boolean
    On Error Resume Next
    
    Dim myBuf(32, 32) As Long
    If Not fileExists(projectPath & tilePath & f1) Then
        'f1 doesn't exist
        Exit Function
    End If
    If Not fileExists(projectPath & tilePath & f2) Then
        'f2 doesn't exist
        Exit Function
    End If
    'both files exist.  now compare them
    Call openTile2(projectPath & tilePath & f1)
    For x = 1 To 32
        For y = 1 To 32
            myBuf(x, y) = tileMem(x, y)
        Next y
    Next x
    Call openTile2(projectPath & tilePath & f2$)
    For x = 1 To 32
        For y = 1 To 32
            If Not (myBuf(x, y) = tileMem(x, y)) Then
                'found difference
                Exit Function
            End If
        Next y
    Next x
    compareTiles = True

End Function
'========================================================================
' Count the tiles
'========================================================================                             FixIT90210ae-R1672-R1B8ZE
Function countTiles() As Integer
    On Error GoTo ErrorHandler
    a$ = Dir(projectPath$ + tilePath$ + "*.gph")
    Do While Not (a$ = "")
        cnt = cnt + 1
        a$ = Dir()
    Loop
    countTiles = cnt

    Exit Function

'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Function

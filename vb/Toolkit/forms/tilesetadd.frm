VERSION 5.00
Begin VB.Form tilesetadd 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Edit Tilesets"
   ClientHeight    =   5520
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   8505
   Icon            =   "tilesetadd.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   368
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   567
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Tag             =   "1567"
   Begin VB.CheckBox chkWelcome 
      Caption         =   "Show welcome note"
      Height          =   255
      Left            =   3390
      TabIndex        =   38
      Top             =   5160
      Width           =   1815
   End
   Begin VB.CommandButton cmdSaveAs 
      Height          =   375
      Index           =   1
      Left            =   4590
      Picture         =   "tilesetadd.frx":0CCA
      Style           =   1  'Graphical
      TabIndex        =   37
      Top             =   1755
      Width           =   375
   End
   Begin VB.CommandButton cmdSaveAs 
      Height          =   375
      Index           =   0
      Left            =   3645
      Picture         =   "tilesetadd.frx":1054
      Style           =   1  'Graphical
      TabIndex        =   36
      Top             =   1755
      Width           =   375
   End
   Begin VB.VScrollBar scrVertical 
      Height          =   4350
      Index           =   1
      Left            =   8235
      TabIndex        =   31
      TabStop         =   0   'False
      Top             =   840
      Width           =   255
   End
   Begin VB.PictureBox picTileset 
      Appearance      =   0  'Flat
      BackColor       =   &H8000000C&
      DragIcon        =   "tilesetadd.frx":13DE
      ForeColor       =   &H80000008&
      Height          =   4350
      Index           =   1
      Left            =   5325
      ScaleHeight     =   288
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   192
      TabIndex        =   30
      Top             =   840
      Width           =   2910
   End
   Begin VB.PictureBox picTile 
      Height          =   540
      Index           =   1
      Left            =   4800
      ScaleHeight     =   32
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   32
      TabIndex        =   29
      ToolTipText     =   "Selected tile"
      Top             =   840
      Width           =   540
   End
   Begin VB.CommandButton cmdInsert 
      Enabled         =   0   'False
      Height          =   375
      Index           =   1
      Left            =   4965
      Picture         =   "tilesetadd.frx":16E8
      Style           =   1  'Graphical
      TabIndex        =   9
      ToolTipText     =   "Insert the selected tile from one tileset next to the tile selected in the this tileset"
      Top             =   2880
      Width           =   375
   End
   Begin VB.CommandButton cmdSave 
      Height          =   375
      Index           =   1
      Left            =   4590
      Picture         =   "tilesetadd.frx":1F02
      Style           =   1  'Graphical
      TabIndex        =   2
      ToolTipText     =   "Save the current tileset"
      Top             =   1380
      Width           =   375
   End
   Begin VB.CommandButton cmdMoveDown 
      Enabled         =   0   'False
      Height          =   375
      Index           =   1
      Left            =   4965
      Picture         =   "tilesetadd.frx":248C
      Style           =   1  'Graphical
      TabIndex        =   15
      ToolTipText     =   "Move the selected tile down in the tileset"
      Top             =   4080
      Width           =   375
   End
   Begin VB.CommandButton cmdMoveUp 
      Enabled         =   0   'False
      Height          =   375
      Index           =   1
      Left            =   4965
      Picture         =   "tilesetadd.frx":2CA6
      Style           =   1  'Graphical
      TabIndex        =   13
      ToolTipText     =   "Move the selected tile up in the tileset"
      Top             =   3720
      Width           =   375
   End
   Begin VB.CommandButton cmdDelete 
      Enabled         =   0   'False
      Height          =   375
      Index           =   1
      Left            =   4965
      Picture         =   "tilesetadd.frx":34C0
      Style           =   1  'Graphical
      TabIndex        =   11
      Top             =   3240
      Width           =   375
   End
   Begin VB.CheckBox chkIso 
      Height          =   375
      Index           =   1
      Left            =   4590
      Picture         =   "tilesetadd.frx":418A
      Style           =   1  'Graphical
      TabIndex        =   6
      ToolTipText     =   "Change the view to isometric (doesn't permanently change tiles)"
      Top             =   2130
      Width           =   375
   End
   Begin VB.CommandButton cmdOpen 
      Height          =   375
      Index           =   1
      Left            =   4950
      Picture         =   "tilesetadd.frx":4E54
      Style           =   1  'Graphical
      TabIndex        =   3
      ToolTipText     =   "Open a tileset"
      Top             =   1380
      Width           =   375
   End
   Begin VB.CheckBox chkGrid 
      Height          =   375
      Index           =   1
      Left            =   4950
      Picture         =   "tilesetadd.frx":51DE
      Style           =   1  'Graphical
      TabIndex        =   7
      ToolTipText     =   "Draw a grid around the tiles"
      Top             =   2130
      Width           =   375
   End
   Begin VB.CommandButton cmdInsert 
      Enabled         =   0   'False
      Height          =   375
      Index           =   0
      Left            =   3285
      Picture         =   "tilesetadd.frx":5EA8
      Style           =   1  'Graphical
      TabIndex        =   8
      ToolTipText     =   "Insert the selected tile from one tileset next to the tile selected in the this tileset"
      Top             =   2880
      Width           =   375
   End
   Begin VB.CommandButton cmdSave 
      Height          =   375
      Index           =   0
      Left            =   3645
      Picture         =   "tilesetadd.frx":66C2
      Style           =   1  'Graphical
      TabIndex        =   1
      ToolTipText     =   "Save the current tileset"
      Top             =   1380
      Width           =   375
   End
   Begin VB.CommandButton cmdCancel 
      Caption         =   "Cancel"
      Height          =   255
      Left            =   3390
      TabIndex        =   17
      ToolTipText     =   "Leave  without saving changes"
      Top             =   4800
      Width           =   1815
   End
   Begin VB.CommandButton cmdOK 
      Caption         =   "OK"
      Height          =   255
      Left            =   3390
      TabIndex        =   16
      ToolTipText     =   "Save changes and leave"
      Top             =   4560
      Width           =   1815
   End
   Begin VB.CommandButton cmdMoveDown 
      Enabled         =   0   'False
      Height          =   375
      Index           =   0
      Left            =   3285
      Picture         =   "tilesetadd.frx":6C4C
      Style           =   1  'Graphical
      TabIndex        =   14
      ToolTipText     =   "Move the selected tile down in the tileset"
      Top             =   4080
      Width           =   375
   End
   Begin VB.CommandButton cmdMoveUp 
      Enabled         =   0   'False
      Height          =   375
      Index           =   0
      Left            =   3285
      Picture         =   "tilesetadd.frx":7466
      Style           =   1  'Graphical
      TabIndex        =   12
      ToolTipText     =   "Move the selected tile up in the tileset"
      Top             =   3720
      Width           =   375
   End
   Begin VB.CommandButton cmdDelete 
      Enabled         =   0   'False
      Height          =   375
      Index           =   0
      Left            =   3285
      Picture         =   "tilesetadd.frx":7C80
      Style           =   1  'Graphical
      TabIndex        =   10
      Top             =   3240
      Width           =   375
   End
   Begin VB.CheckBox chkIso 
      Height          =   375
      Index           =   0
      Left            =   3645
      Picture         =   "tilesetadd.frx":894A
      Style           =   1  'Graphical
      TabIndex        =   5
      ToolTipText     =   "Change the view to isometric (doesn't permanently change tiles)"
      Top             =   2130
      Width           =   375
   End
   Begin VB.CommandButton cmdOpen 
      Height          =   375
      Index           =   0
      Left            =   3285
      Picture         =   "tilesetadd.frx":9614
      Style           =   1  'Graphical
      TabIndex        =   0
      ToolTipText     =   "Open a tileset"
      Top             =   1380
      Width           =   375
   End
   Begin VB.CheckBox chkGrid 
      Height          =   375
      Index           =   0
      Left            =   3285
      Picture         =   "tilesetadd.frx":999E
      Style           =   1  'Graphical
      TabIndex        =   4
      ToolTipText     =   "Draw a grid around the tiles"
      Top             =   2130
      Width           =   375
   End
   Begin VB.PictureBox picTile 
      Height          =   540
      Index           =   0
      Left            =   3285
      ScaleHeight     =   32
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   32
      TabIndex        =   20
      ToolTipText     =   "Selected tile"
      Top             =   840
      Width           =   540
   End
   Begin VB.VScrollBar scrVertical 
      Height          =   4350
      Index           =   0
      Left            =   120
      TabIndex        =   19
      TabStop         =   0   'False
      Top             =   840
      Width           =   255
   End
   Begin VB.PictureBox picTileset 
      Appearance      =   0  'Flat
      BackColor       =   &H8000000C&
      DragIcon        =   "tilesetadd.frx":A668
      ForeColor       =   &H80000008&
      Height          =   4350
      Index           =   0
      Left            =   375
      ScaleHeight     =   288
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   192
      TabIndex        =   18
      Top             =   840
      Width           =   2910
   End
   Begin VB.Label lblSelectedTile 
      Caption         =   "Selected tile:"
      Height          =   255
      Index           =   1
      Left            =   4365
      TabIndex        =   35
      Top             =   480
      Width           =   1575
   End
   Begin VB.Label lblFormat 
      Caption         =   "Format:"
      Height          =   255
      Index           =   1
      Left            =   6525
      TabIndex        =   34
      Top             =   120
      Width           =   1815
   End
   Begin VB.Label lblContains 
      Caption         =   "Contains:"
      Height          =   255
      Index           =   1
      Left            =   6525
      TabIndex        =   33
      Top             =   480
      Width           =   1695
   End
   Begin VB.Label lblTileset 
      Caption         =   "Tileset:"
      Height          =   255
      Index           =   1
      Left            =   4365
      TabIndex        =   32
      Top             =   120
      Width           =   2175
   End
   Begin VB.Label lblSelectedTile 
      Caption         =   "Selected tile:"
      Height          =   255
      Index           =   0
      Left            =   2325
      TabIndex        =   28
      Top             =   480
      Width           =   1455
   End
   Begin VB.Label lblInsert 
      Caption         =   "Insert current tile"
      Height          =   255
      Left            =   3690
      TabIndex        =   27
      Top             =   3000
      Width           =   1215
   End
   Begin VB.Label lblFormat 
      Caption         =   "Format:"
      Height          =   255
      Index           =   0
      Left            =   2325
      TabIndex        =   26
      Top             =   120
      Width           =   1935
   End
   Begin VB.Label lblContains 
      Caption         =   "Contains:"
      Height          =   255
      Index           =   0
      Left            =   285
      TabIndex        =   25
      Top             =   480
      Width           =   1695
   End
   Begin VB.Label lblTileset 
      Caption         =   "Tileset:"
      Height          =   255
      Index           =   0
      Left            =   285
      TabIndex        =   24
      Top             =   120
      Width           =   2055
   End
   Begin VB.Label lblMoveDown 
      Caption         =   "Move down"
      Height          =   255
      Left            =   3840
      TabIndex        =   23
      Top             =   4200
      Width           =   885
   End
   Begin VB.Label lblMoveUp 
      Caption         =   "Move up"
      Height          =   255
      Left            =   3960
      TabIndex        =   22
      Top             =   3840
      Width           =   660
   End
   Begin VB.Label lblDelete 
      Alignment       =   2  'Center
      Caption         =   "Delete current tile"
      Height          =   255
      Left            =   3570
      TabIndex        =   21
      Top             =   3360
      Width           =   1455
   End
End
Attribute VB_Name = "tilesetadd"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'=======================================================================
'All contents copyright 2004, Jonathan Hughes (Delano)
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=======================================================================

'==================================================
'"Advanced" tileset editor - by Delano for 3.0.4

'Todo list: Undo option, merge tilesets, localize system. Testing!

Option Explicit

Private Type tilesetEditorInfo
    filename As String              'The original file - not edited until saving.
    workingFilename As String       'Filename of the file that's being edited.
    requireSave As Boolean          'Whether changes have been made to the tileset.
    
    startNumber As Integer          'Tile to start drawing at.
    tileFormat As Byte              '= 2 for isometric, = 0 for 32x32, = 3 for 16x16
    position As Integer
    grid As Boolean                 'Check buttons.
    isometric As Boolean
    
    header As tilesetHeader         'Tileset header from commonTileset.
    
    selectedTileNum As Integer      'Tile in the preview window.
    selectedTile(64, 32) As Long    'Tile in memory.
End Type

Private lastMouseDown As Byte           'The last clicked tileset.
Private tileBlock(3071) As Byte         'The temporary storage of tiles during copying. Has 3072 elements!
Private Const tempTileset As String = "_tst_.tmp"

Private ts(1) As tilesetEditorInfo      'Control array for both sides. 0 = left, 1 = right

Private Sub chkGrid_Click(Index As Integer): On Error Resume Next
'===========================================
'Turn off / on grid.
'===========================================
    Call drawTileset(Index)
End Sub

Private Sub chkIso_Click(Index As Integer): On Error Resume Next
'=======================================================
'Isometric check button - display tileset isometrically.
'=======================================================

    'Clear the picture box.
    Call vbPicAutoRedraw(picTileset(Index), False)
    picTileset(Index).Picture = LoadPicture("")
    Call vbPicAutoRedraw(picTileset(Index), True)
    
    'picTileset(Index).Cls
    picTile(Index).cls
    
    Call drawTileset(Index)
    
    Call vbPicAutoRedraw(picTile(Index), False)
    
    If chkIso(Index).value = 0 Then
        picTile(Index).width = 36                               'Pixel values!
        'Realign the right-hand box.
        If Index = 1 Then picTile(Index).Left = 320
    Else
        picTile(Index).width = 68
        'Realign the right-hand box.
        If Index = 1 Then picTile(Index).Left = 288
    End If
    
    Call vbPicAutoRedraw(picTile(Index), True)
    
    
    Call drawTile(Index)
    
End Sub

Private Sub chkWelcome_Click(): On Error Resume Next
'=============================
'Show the welcome note.
'=============================

    configfile.advTilesetTips = chkWelcome.value

End Sub

Private Sub cmdCancel_Click(): On Error Resume Next
'=======================
'Exit without saving.
'=======================

    Dim answer As VbMsgBoxResult
    answer = vbYes

    If ts(0).filename$ <> "" And ts(1).filename$ <> "" Then
        answer = MsgBox("Exit without saving changes?", vbYesNo + vbExclamation + vbDefaultButton2)
    End If
    
    If answer = vbNo Then Exit Sub
    
    Unload Me

End Sub

Private Sub cmdDelete_Click(Index As Integer): On Error GoTo ErrorHandler
'====================================================
'Delete the currently selected tile from the tileset.
'Creates a temporary tileset and copies tile-by-tile
'from the original, skipping the selected tile.
'====================================================

    Dim Source As String, Destination As String, sourceNum As Integer, destNum As Integer
    Dim byteOffset As Long, position As Long
    Dim result As VbMsgBoxResult
    
    ChDir (currentDir$)
    
    If ts(Index).selectedTileNum = -1 Then Exit Sub
    
    If ts(Index).header.tilesInSet = 1 Then
        'There's only one tile left!
        
        result = MsgBox("Do you want to delete this tileset?", vbYesNo + vbExclamation + vbDefaultButton2)
        
        If result = vbYes Then
            'Delete the tileset.
            
            Kill (projectPath & tilePath & ts(Index).filename)
            Kill (projectPath & ts(Index).workingFilename)
            
            Call clearInfo(Index)  'ts(i) info.
            
            lblTileset(Index).Caption = "Tileset:": lblContains(Index).Caption = "Contains:"
            lblSelectedTile(Index).Caption = "Selected tile:": lblFormat(Index).Caption = "Format:"
    
            'Clear the picture boxes.
            'picTileset(Index).Cls: picTile(Index).Cls
            picTileset(Index).Picture = LoadPicture(""): picTile(Index).Picture = LoadPicture("")
    
            'Deactivate the tool buttons.
            cmdMoveDown(Index).Enabled = False: cmdDelete(Index).Enabled = False
            cmdMoveUp(Index).Enabled = False
    
        End If
        Exit Sub
    End If '.tilesInSet = 1

    'Decrease the tileset count.
    ts(Index).header.tilesInSet = ts(Index).header.tilesInSet - 1

    'Set up the files for writing.
    Source$ = projectPath$ & ts(Index).workingFilename$
    Destination$ = projectPath$ & tempTileset$
    
    sourceNum = FreeFile
    Open Source$ For Binary As #sourceNum
    
    destNum = FreeFile
    Open Destination$ For Binary As #destNum
    
        'Write the new header.
        Put #destNum, 1, ts(Index).header
    
        'Now, read and write the tiles in blocks of 3072 bytes.
        
        DoEvents
        
        For position = 1 To ts(Index).selectedTileNum - 1
            
            'byteOffset = (position - 1) * 3072 + 7              '7 for the header
            byteOffset = calcInsertionPoint(ts(Index).header, position)
            
            Get #sourceNum, byteOffset, tileBlock
            Put #destNum, byteOffset, tileBlock
            
        Next position
        
        'That has written the tiles before the selected tile, now the tiles after.
        
        For position = ts(Index).selectedTileNum + 1 To ts(Index).header.tilesInSet + 1
            'Loop to the tile count + 1, because we decreased it earlier!
        
            'byteOffset = (position - 1) * 3072 + 7
            byteOffset = calcInsertionPoint(ts(Index).header, position)

            Get #sourceNum, byteOffset, tileBlock
            Put #destNum, byteOffset - 3072, tileBlock
            
        Next position
        
    'Done!
    Close #sourceNum
    Close #destNum
    
    'Overwrite the working file.
    ChDir (currentDir$)
    Kill Source$
    Name Destination$ As Source$
    
    ts(Index).selectedTileNum = -1
    lblContains(Index).Caption = "Contains: " & ts(Index).header.tilesInSet & " tiles"
    lblSelectedTile(Index).Caption = "Selected tile:"
    Call drawTileset(Index)
    Call drawTile(Index)
    
    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next

End Sub

Private Sub cmdInsert_Click(Index As Integer): On Error Resume Next
'=================================================================
'Insert the selected tile from the other set into the position in
'front of the selected tile in the Index set.
'Calls insertTile - as with drag-drop events.
'=================================================================

    Dim number As Integer
    
    If ts(Index).selectedTileNum = -1 Then
        'If no tile is selected, add the tile to the end of the set.
        number = ts(Index).header.tilesInSet + 1
    Else
        number = ts(Index).selectedTileNum
    End If
    
    Call insertTile(Index, number)
    
End Sub

Private Sub cmdMoveDown_Click(Index As Integer): On Error Resume Next
'================================================================
'Decreases the tiles' position in the set (moves down one place).
'Calls move tile routine - as used in dragging.
'================================================================

    Dim number As Integer

    'If there is no tile selected or the last tile is selected, or there is only one tile, exit sub.
    If ts(Index).selectedTileNum >= ts(Index).header.tilesInSet _
        Or ts(Index).selectedTileNum = -1 Or ts(Index).header.tilesInSet = 1 Then Exit Sub
        
    number = ts(Index).selectedTileNum + 1          'Move down.
        
    Call moveTile(Index, number)
    
End Sub

Private Sub cmdMoveUp_Click(Index As Integer): On Error Resume Next
'==============================================================
'Increases the tiles' position in the set (moves up one place).
'Calls moveTile - as used in drag-drop.
'==============================================================

    Dim number As Integer

    'If there is no tile selected or the first tile is selected, or there is only one tile, exit sub.
    If ts(Index).selectedTileNum <= 1 Or ts(Index).header.tilesInSet = 1 Then Exit Sub
        
    number = ts(Index).selectedTileNum - 1          'Move up.
        
    Call moveTile(Index, number)

End Sub

Private Sub cmdOK_Click(): On Error Resume Next
'==============================
'Save changes and exit.
'==============================

    Dim Index As Integer
    'Loop over the indices and save the tilesets.
    
    ChDir (currentDir$)
    For Index = 0 To 1
    
        If ts(Index).filename$ <> "" Then
            'Delete the original and copy the working the tileset.
            Kill (projectPath$ + tilePath$ + ts(Index).filename$)
            Call FileCopy(projectPath$ + ts(Index).workingFilename$, projectPath$ + tilePath$ + ts(Index).filename$)
        End If
        
    Next Index
    
    Unload Me

End Sub

Private Sub cmdOpen_Click(Index As Integer): On Error Resume Next
'=========================================================
'Opens a tileset and draws it in the corresponding window.
'=========================================================

    Dim dlg As FileDialogInfo, result As VbMsgBoxResult
    
    ChDir (currentDir$)
    
    'If the open tileset is not saved:
    If ts(Index).requireSave Then
        result = MsgBox("Do you want to save the changes to the open tileset?", vbYesNoCancel + vbExclamation)
        
        If result = vbYes Then Call cmdSave_Click(Index)
        If result = vbCancel Then Exit Sub
        
    End If
    
    
    'Remove the old working tileset. Created in the game directory!!
    Kill (projectPath$ & ts(Index).workingFilename$)
    ts(Index).selectedTileNum = -1
    ts(Index).requireSave = True                        'Might want to change this!
    
    'Set up the dialog window for opening the tileset.
    dlg.strDefaultFolder = projectPath$ + tilePath$
    dlg.strTitle = "Open Tileset"
    dlg.strDefaultExt = "tst"
    dlg.strFileTypes = "Supported Types|*.tst;*.iso|RPG Toolkit TileSet (*.tst)|*.tst|RPG Toolkit Isometric TileSet (*.iso)|*.iso|All files(*.*)|*.*"
    
    If OpenFileDialog(dlg, Me.hwnd) Then
         '= dlg.strSelectedFile      'Filename chosen for opening. (with path)
        ts(Index).filename$ = dlg.strSelectedFileNoPath   'Filename without path.
    Else
        Exit Sub 'user pressed cancel
    End If
    
    If ts(Index).filename$ = "" Then Exit Sub
    
    'Get the header information from the tileset.
    ts(Index).tileFormat = tilesetInfo(ts(Index).filename$)
    ts(Index).header = tileset
    
    'Create the working tileset: _index_original.tst
    ts(Index).workingFilename$ = "_" + str$(Index) + "_" + ts(Index).filename$
    ChDir (currentDir$)
    Call FileCopy(projectPath$ + tilePath$ + ts(Index).filename$, projectPath$ + ts(Index).workingFilename$)
    
    'Initial values for check buttons:
    Select Case ts(Index).tileFormat
        Case ISOTYPE
            chkIso(Index).value = 1
            chkIso(Index).Enabled = False
            lblFormat(Index).Caption = "Format: Isometric 64x32"
        Case TSTTYPE
            chkIso(Index).value = 0
            chkIso(Index).Enabled = True
            lblFormat(Index).Caption = "Format: Standard 32x32"
        Case Else: Exit Sub
    End Select
    
    'Set up the scrollbar:
    
    ts(Index).startNumber = 1                       'Tile to place in the top-left corner.
    scrVertical(Index).value = 0
    
    'Update the labels:
    
    lblTileset(Index).Caption = "Tileset: " & ts(Index).filename$
    lblContains(Index).Caption = "Contains: " & ts(Index).header.tilesInSet & " tiles"
    
    'Clear the picture box.
    Call vbPicAutoRedraw(picTileset(Index), False)
    picTileset(Index).Picture = LoadPicture("")
    Call vbPicAutoRedraw(picTileset(Index), True)
    
    Call vbPicAutoRedraw(picTile(Index), False)
    picTile(Index).Picture = LoadPicture("")
    Call vbPicAutoRedraw(picTile(Index), True)
    
    'picTileset(Index).Cls
    'picTile(Index).Cls
    
    lblSelectedTile(Index).Caption = "Selected tile:"
    
    'Activate the tool buttons:
    cmdInsert(Index).Enabled = True: cmdInsert(Abs(Index - 1)).Enabled = True
    cmdMoveUp(Index).Enabled = True
    cmdMoveDown(Index).Enabled = True
    cmdDelete(Index).Enabled = True

    Call drawTileset(Index)                         'Draw the tileset.
    
End Sub

Private Sub cmdSave_Click(Index As Integer): On Error Resume Next
'=============================================
'Saves the current tileset.
'All changes are made to the working copy,
'this copies the changes back to the original.
'Is not a Save As - yet!
'=============================================

    If ts(Index).filename$ = "" Or ts(Index).filename$ = "untitled" Then Call cmdSaveAs_Click(Index): Exit Sub

    'Delete the original and copy the working the tileset.
    ChDir (currentDir$)
    Kill (projectPath$ & tilePath$ & ts(Index).filename$)
    Call FileCopy(projectPath$ & ts(Index).workingFilename$, projectPath$ & tilePath$ & ts(Index).filename$)

End Sub


Private Sub cmdSaveAs_Click(Index As Integer): On Error Resume Next
'=====================================
'Save As - create dialog and new tile.
'=====================================

    Dim dlg As FileDialogInfo, result As VbMsgBoxResult, newName As String, antiPath As String
    
    If ts(Index).requireSave = False Then Exit Sub
    
    ChDir (currentDir$)

    'Set up the dialog window for opening the tileset.
    dlg.strDefaultFolder = projectPath$ + tilePath$
    dlg.strTitle = "Save Tileset As"
    
    If ts(Index).tileFormat = ISOTYPE Then
        dlg.strDefaultExt = "iso"
        dlg.strFileTypes = "RPG Toolkit Isometric TileSet (*.iso)|*.iso|All files(*.*)|*.*"
    Else
        dlg.strDefaultExt = "tst"
        dlg.strFileTypes = "RPG Toolkit TileSet (*.tst)|*.tst|All files(*.*)|*.*"
    End If
    
    If SaveFileDialog(dlg, Me.hwnd) Then
        newName$ = dlg.strSelectedFile     'Filename chosen for opening. (with path)
        antiPath$ = dlg.strSelectedFileNoPath   'Filename without path.
    Else
        Exit Sub 'user pressed cancel
    End If
    
    If newName$ = "" Then Exit Sub
    
    'Check if the file exists.
    If fileExists(newName$) Then
        result = MsgBox("That file exists. Are you sure you want to overwrite it?", vbYesNo + vbExclamation + vbDefaultButton2)
        If result = vbNo Then Exit Sub
    End If
    
    'Kill the file and copy the working file across.
    ChDir (currentDir$)
    Kill (newName$)
    Call FileCopy(projectPath$ & ts(Index).workingFilename$, newName$)
    
    'Rename the working file.
    newName$ = "_" & str$(Index) & "_" & antiPath$
    Name (projectPath$ & ts(Index).workingFilename$) As (projectPath$ & newName$)

    ts(Index).filename$ = antiPath$
    ts(Index).workingFilename$ = newName$
    
    lblTileset(Index).Caption = "Tileset: " & antiPath$
    

End Sub

Private Sub Form_Load(): On Error Resume Next
'======================
'Form entry point.
'======================

    Dim Index As Integer

    Call LocalizeForm(Me)       'Not done for this form.
    
    Me.Caption = "Advanced Tileset Editor"
    chkWelcome.value = configfile.advTilesetTips
    
    If chkWelcome.value = 1 Then
    
        Call MsgBox("Welcome to the new-look tileset editor, which allows you to easily manage tilesets." _
            & chr$(13) & chr$(13) _
            & "You can move tiles around in their set by using the ""Move"" tools, " _
            & "the ""Up"" and ""Down"" cursor arrows, or by dragging tiles around the window." _
            & chr$(13) & chr$(13) _
            & "You can delete tiles using the ""Delete"" tool or the ""Del"" button." _
            & chr$(13) & chr$(13) _
            & "You can open two sets at once and move tiles between sets using the ""Insert"" tool, " _
            & "the ""Left"" or ""Right"" cursor arrows (the inserted tile appears in front of the selected " _
            & "tile in the other set, or the end if no tile is selected) or you can drag tiles between sets." _
            & chr$(13) & chr$(13) _
            & "You can create a new tileset by inserting a tile into a blank set." _
            & chr$(13) & chr$(13) _
            & "All changes are temporary until you hit the ""Save"" button or the ""OK"" button (which saves and quits)." _
            & chr$(13) & chr$(13) _
            & "Warning! If you have already created boards (or other objects) from sets, rearranging the tiles will alter " _
            & "which tiles appear on the boards! Tiles on boards are referenced by their index in the tileset!" _
            & chr$(13) & chr$(13) _
            & "If you have any problems please report them on the forums at http://www.rpgtoolkit.com.", , _
            "RPGToolkit Tileset Editor")
            
    End If
        
    'Set some initial values.
    For Index = 0 To 1
        ts(Index).selectedTileNum = -1
        ts(Index).requireSave = False
        Call vbPicAutoRedraw(picTileset(Index), True)
    Next Index
    
    Call clearInfo(0)
    Call clearInfo(1)

End Sub

Private Sub Form_Unload(Cancel As Integer): On Error Resume Next
'===========================================
'Exit point - delete the temporary files.
'===========================================

    Dim Index As Integer

    'Delete the temporary files.
    ChDir (currentDir$)
    For Index = 0 To 1
        If ts(Index).workingFilename$ <> "" Then Kill projectPath$ + ts(Index).workingFilename$
    Next Index
    
    tilesetedit.SSTab1.Tab = 0

End Sub

Private Sub drawGrid(ByVal Index As Integer): On Error Resume Next
'===================================================
'Draws the grid on top of the specified picture box.
'===================================================
    
    Dim X As Integer, Y As Integer, tileWidth As Integer, tileHeight As Integer
    
    If chkGrid(Index).value = 0 Then Exit Sub
    
    Call vbPicAutoRedraw(picTileset(Index), False)
    
    tileWidth = 6
    tileHeight = 9
    
    'Draw vertical lines.
    If chkIso(Index).value = 0 Then
        '2D. Vertical lines.
        For X = 0 To tileWidth * 32 Step 32
            Call vbPicLine(picTileset(Index), X, 0, X, tileHeight * 32, vbQBColor(1))
        Next X
    Else
        For X = 0 To tileWidth * 32 Step 64
            Call vbPicLine(picTileset(Index), X, 0, X, tileHeight * 32, vbQBColor(1))
        Next X
        
    End If
    
    'Draw horizontal lines.
    For Y = 0 To (tileHeight + 1) * 32 Step 32
        Call vbPicLine(picTileset(Index), 0, Y, tileWidth * 32, Y, vbQBColor(1))
    Next Y
    
    Call vbPicAutoRedraw(picTileset(Index), True)
    
End Sub

Private Sub drawTileset(ByVal Index As Integer): On Error Resume Next
'===================================================
'Draws the tileset in the corresponding picture box.
'===================================================

    Dim tileWidth As Long, tileHeight As Long, isometric As Long

    isometric = 0               'To be passed to the drawing routine. 0 = draw standard .tst

    'Determine the size of the picture box in tiles.
    tileWidth = 6
    If chkIso(Index).value = 1 Then
        tileWidth = 3
        isometric = 1                                           '1 = draw .tst isometrically.
    End If
    tileHeight = 9
    
    If ts(Index).tileFormat = ISOTYPE Then isometric = 2        '2 = draw .iso
    
    'Set up the scrollbar:
    scrVertical(Index).max = (-Int(ts(Index).header.tilesInSet / (-tileWidth))) - tileHeight
    
    If scrVertical(Index).max < 1 Then
        'If all the tiles are contained in the window.
        scrVertical(Index).Enabled = False
    Else
        'Clicking the bar (not button). Scrolls to the last row (last row becomes top row).
        scrVertical(Index).LargeChange = tileHeight - 1
        scrVertical(Index).Enabled = True
    End If

    ts(Index).startNumber = (scrVertical(Index).value * tileWidth) + 1
    
    Dim a As Long
    Call vbPicAutoRedraw(picTileset(Index), True)
    a = GFXInitScreen(640, 480)
    
    ChDir (currentDir$)
    a = GFXdrawTstWindow(projectPath$ + ts(Index).workingFilename$, vbPicHDC(picTileset(Index)), ts(Index).startNumber, tileWidth, tileHeight, isometric)
    Call vbPicRefresh(picTileset(Index))
    
    
    Call drawGrid(Index)

End Sub

Private Sub drawTile(ByVal Index As Integer): On Error Resume Next
'================================================
'Draws the selected tile in the preview box.
'================================================
    
    Dim X As Integer, Y As Integer, pixel As Long
    
    ChDir (currentDir$)
    
    If ts(Index).selectedTileNum = -1 Then
        picTile(Index).Picture = LoadPicture("")
        'picTile(Index).Cls
        Exit Sub
    End If
    
    'Clear the tilemem:
    For X = 0 To 64
        For Y = 0 To 32
            tileMem(X, Y) = -1
            ts(Index).selectedTile(X, Y) = -1
        Next Y
    Next X
            
    'Load the tile into memory.
    Call openFromTileSet(projectPath$ + ts(Index).workingFilename$, ts(Index).selectedTileNum)
    
    'Copy across from tilemem:
    For X = 0 To 64
        For Y = 0 To 32
            ts(Index).selectedTile(X, Y) = tileMem(X, Y)
        Next Y
    Next X
    
    Call vbPicAutoRedraw(picTile(Index), True)

    'Draw the tile.
    If chkIso(Index).value = 0 Then
        '2D.
        
        For X = 1 To 32
            For Y = 1 To 32
                If ts(Index).selectedTile(X, Y) <> -1 Then
                    Call vbPicPSet(picTile(Index), X - 1, Y - 1, ts(Index).selectedTile(X, Y))
                Else
                    Call vbPicPSet(picTile(Index), X - 1, Y - 1, RGB(255, 255, 255))
                End If
            Next Y
        Next X
        
    Else
        'Isometric.
        
        If ts(Index).tileFormat = ISOTYPE Then
            '.iso isometric.
            Call tileDrawIso(picTile(Index), 0, 0, ISODETAIL)
        Else
            '.tst isometric.
            Call tileDrawIso(picTile(Index), 0, 0, 3)
        End If
        
    End If 'chkIso.value
    
    Call vbPicRefresh(picTile(Index))
    'Call vbPicAutoRedraw(picTile(Index), True)


End Sub



Private Sub picTileset_DragDrop(Index As Integer, Source As Control, X As Single, Y As Single): On Error Resume Next
'====================================================================
'Drag-drop on the tileset picture boxes, i.e. mouseUp after movement.
'====================================================================

    'We want to be able to drag tiles around or between tilesets.
    'We have the selected tile from mouseDown and the selectedTile property.
    'We just need the location to place the tile.
    'If we're moving between tilesets, we're adding a tile.
    'If we're rearranging, we're not adding a tile.

    'Get the tile co-ordinates:
    Dim tileWidth As Integer, tileHeight As Integer, number As Integer
    
    Call vbPicRefresh(picTileset(Index))    'Clear the box highlight.
    
    'Calculate the selected tile.
    If chkIso(Index).value = 0 Then
        X = Int(X / 32)
        tileWidth = 6
    Else
        X = Int(X / 64)
        tileWidth = 3
    End If
    
    Y = Int(Y / 32)
    tileHeight = 9
    
    number = Y * tileWidth + X + 1
    number = number + scrVertical(Index).value * tileWidth
    
    'Work out if we're in the same tileset as we started in.
    If Index = lastMouseDown Then
        'If the "mouse-up" Index is the same as the mouse-down, we're in the same tileset.
        
        'If the tile hasn't moved, exit.
        If number = ts(Index).selectedTileNum Then Exit Sub
        
        Call moveTile(Index, number)
        
    Else
        'We've moved to the other tileset.
        
        If number > ts(Index).header.tilesInSet Then number = ts(Index).header.tilesInSet + 1
        
        Call insertTile(Index, number)
        
    End If


End Sub

Private Sub picTileset_DragOver(Index As Integer, Source As Control, X As Single, Y As Single, State As Integer): On Error Resume Next
'===========================================================
'Drag movement on the tileset picture boxes, i.e. mouseMove.
'===========================================================

    'We want to place a highlight on the drop position during the drag over.
    'We draw a box around the nearest tile.
    
    Dim xPixel As Long, yPixel As Long
    
    'Redraw the tileset (and grid).
    Call vbPicRefresh(picTileset(Index))
    Call vbPicAutoRedraw(picTileset(Index), False)
        
    If State <> vbLeave Then
        
        'Draw the box only if we're not leaving the picture!
        yPixel = Y - Y Mod 32
        If chkIso(Index).value = 0 Then
            '32x32 box.
            xPixel = X - X Mod 32
            Call vbPicRect(picTileset(Index), xPixel, yPixel, xPixel + 32, yPixel + 32, vbQBColor(15))
            Call vbPicRect(picTileset(Index), xPixel - 1, yPixel - 1, xPixel + 33, yPixel + 33, vbQBColor(15))
        Else
            'Isometric 64x32.
            xPixel = X - X Mod 64
            Call vbPicRect(picTileset(Index), xPixel, yPixel, xPixel + 64, yPixel + 32, vbQBColor(15))
            Call vbPicRect(picTileset(Index), xPixel - 1, yPixel - 1, xPixel + 65, yPixel + 33, vbQBColor(15))
        End If
        
    End If
    
    Call vbPicAutoRedraw(picTileset(Index), True)

End Sub

Private Sub picTileset_KeyDown(Index As Integer, keyCode As Integer, Shift As Integer): On Error Resume Next
'=====================================================
'Keyboard shortcuts for some of the tools.
'Only work when the tileset picture box has the focus!
'=====================================================

    Select Case keyCode
        Case 27:
            'Escape. Clear the selected tile.
            ts(Index).selectedTileNum = -1
            lblSelectedTile(Index).Caption = "Selected Tile:"
            Call drawTile(Index)
        Case 37:
            'Left arrow.
            Call cmdInsert_Click(Index)
        Case 38:
            'Up arrow.
            Call cmdMoveUp_Click(Index)
        Case 39:
            'Right arrow.
            Call cmdInsert_Click(Abs(Index - 1))
        Case 40:
            'Down arrow.
            Call cmdMoveDown_Click(Index)
        Case 46:
            'Delete.
            Call cmdDelete_Click(Index)
    End Select
    
End Sub


Private Sub picTileset_MouseDown(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single): On Error Resume Next
'======================================
'Mouse down on the tileset picture box.
'======================================

    Dim tileWidth As Integer, tileHeight As Integer, number As Integer
    
    'Calculate the selected tile.
    If chkIso(Index).value = 0 Then
        X = Int(X / 32)
        tileWidth = 6
    Else
        X = Int(X / 64)
        tileWidth = 3
    End If
    
    Y = Int(Y / 32)
    tileHeight = 9
    
    number = Y * tileWidth + X + 1
    number = number + scrVertical(Index).value * tileWidth
    
    'Assign if is a valid number.
    If number > ts(Index).header.tilesInSet Then
        Exit Sub
    Else
        ts(Index).selectedTileNum = number
    End If
    
    lblSelectedTile(Index).Caption = "Selected tile: " & ts(Index).selectedTileNum
    
    'Assign the last clicked tileset to the current index.
    lastMouseDown = Index
    
    Call drawTile(Index)
    
End Sub

Private Sub picTileset_MouseMove(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single): On Error Resume Next
'===========================
'Mouse move on the tilesets.
'===========================

'Only initiate drag upon movement (and a button held).
If Button <> 0 Then picTileset(Index).Drag

End Sub

Private Sub scrVertical_Change(Index As Integer): On Error Resume Next
'================================================
'Vertical scrollers.
'================================================
    Call drawTileset(Index)
End Sub


Private Sub insertTile(ByVal Index As Integer, ByVal position As Integer): On Error GoTo ErrorHandler
'============================================================================
'Inserts the selected tile from the other set into the position specified.
'Subsequent tiles in the set are shifted down a place.
'Here, "index" refers to the set we are inserting into.
'Called for the insert command button and a drag-drop event between tilesets.
'For the command button, position is the selected tile in the Index set.
'============================================================================

    Dim Source As String, Destination As String, sourceNum As Integer, destNum As Integer
    Dim byteOffset As Long, tileOffset As Long
    Dim X As Integer, Y As Integer
    Dim r As Byte, g As Byte, b As Byte
    Dim element As Long, xCount As Integer, yCount As Integer

    'First check there is a selected tile the origin set.
    If ts(Abs(Index - 1)).selectedTileNum = -1 Then Exit Sub
    
    'Check if we need to create a new set.
    If ts(Index).filename$ = "" Then
        Call createSet(Index)
        position = 1
    End If
    
    'Check we're not trying to insert an isometric tile into a .tst
    If ts(Index).tileFormat <> ISOTYPE And ts(Abs(Index - 1)).tileFormat = ISOTYPE Then
        Call MsgBox("You cannot insert an isometric tile into a 2D tileset.", vbOKOnly + vbInformation)
        Exit Sub
    End If
    
    'If we're inserting a .tst tile into an isometric set, reshape the tile:
    If ts(Index).tileFormat = ISOTYPE And ts(Abs(Index - 1)).tileFormat <> ISOTYPE Then
    
        'First load the tile into tilemem
        For X = 0 To 32
            For Y = 0 To 32
                 tileMem(X, Y) = ts(Abs(Index - 1)).selectedTile(X, Y)
            Next Y
        Next X
        
        'Convert the tile. Operates on tilemem. We now have buftile in an isometric shape!
        Call tstToIsometric
        
        'Write buftile into the tile block.
        element = 0: xCount = 1: yCount = 1
        For X = 1 To 64
            For Y = 1 To 32
            
'Call traceString("buftile(" & x & ", " & y & ") = " & buftile(x, y))

                If isoMaskBmp(X, Y) = RGB(0, 0, 0) Then 'Black. Take pixel.
                
                    'Convert long colour to rgb byte values.
                    If bufTile(X - 1, Y - 1) = -1 Then
                        'Transparent colour.
                        r = 0: g = 1: b = 2
                    Else
                        r = red(bufTile(X - 1, Y - 1))
                        g = green(bufTile(X - 1, Y - 1))
                        b = blue(bufTile(X - 1, Y - 1))
                    End If
                    
                    'Set the bytes in the block.
                    tileBlock(element) = r
                    tileBlock(element + 1) = g
                    tileBlock(element + 2) = b
                    element = element + 3
                    
                    'Set the pixels in the selected tile.
                    ts(Index).selectedTile(xCount, yCount) = bufTile(X - 1, Y - 1)
                    
'Call traceString("selectedtile(" & xCount & ", " & yCount & ") = " & buftile(x - 1, y - 1))

                    
                    yCount = yCount + 1
                    If (yCount > 32) Then
                        xCount = xCount + 1
                        yCount = 1
                    End If
                                        
                End If
            Next Y
        Next X
                             
    Else
    
        'We read the tile straight from memory.
        
        'Load the selected tile in the other set.
        Dim insertNum As Integer, insert As String
        insert$ = projectPath$ + ts(Abs(Index - 1)).workingFilename$
        
        insertNum = FreeFile
        Open insert$ For Binary As #insertNum
        
            byteOffset = calcInsertionPoint(ts(Abs(Index - 1)).header, ts(Abs(Index - 1)).selectedTileNum)
        
            Get #insertNum, byteOffset, tileBlock
            
        Close #insertNum
        
    End If 'tst -> iso.
    
    Source$ = projectPath$ + ts(Index).workingFilename$                 'Create the temporary files in the root!
    Destination$ = projectPath$ + tempTileset$
   
    'First, we copy the working tileset into the temporary file.
    ChDir (currentDir$)
    Call FileCopy(Source$, Destination$)
    
    
    'Open the files for copying.
    sourceNum = FreeFile
    Open Source$ For Binary As #sourceNum
    
    destNum = FreeFile
    Open Destination$ For Binary As #destNum

        'Calculate the byte position to insert the tile.
        byteOffset = calcInsertionPoint(ts(Index).header, position)
        
        'Write the tile:
        Put #destNum, byteOffset, tileBlock
    
        'Now, we add the rest of the tiles to the set after this tile.
        
        For tileOffset = position To ts(Index).header.tilesInSet
        
            'byteOffset = (tileOffset - 1) * 3072 + 7
            byteOffset = calcInsertionPoint(ts(Index).header, tileOffset)
            
            Get #sourceNum, byteOffset, tileBlock
            Put #destNum, byteOffset + 3072, tileBlock
        
        Next tileOffset
        
        'Overwrite the header.
        ts(Index).header.tilesInSet = ts(Index).header.tilesInSet + 1
        Put #destNum, 1, ts(Index).header
        
    'Done!
    Close #sourceNum
    Close #destNum
    
    'Overwrite the working file.
    ChDir (currentDir$)
    Kill Source$
    Name Destination$ As Source$
    
    ts(Index).selectedTileNum = position
    lblSelectedTile(Index).Caption = "Selected tile: " & ts(Index).selectedTileNum
    lblContains(Index).Caption = "Contains: " & ts(Index).header.tilesInSet & " tiles"
    
    Call drawTileset(Index)
    Call drawTile(Index)
   
   
Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next

End Sub


Private Sub moveTile(ByVal Index As Integer, ByVal position As Integer): On Error GoTo ErrorHandler
'=======================================================================
'Moves the selected tile to the position given in it's own tileset.
'Called by the drag-drop event and the move up / down buttons.
'=======================================================================

    Dim X As Integer, Y As Integer, Source As String, Destination As String
    Dim byteOffset As Long, tileOffset As Long, direction As Long
    Dim sourceNum As Integer, destNum As Integer

    'If we're trying to move past the end of the set, put it on the end.
    If position > ts(Index).header.tilesInSet Then position = ts(Index).header.tilesInSet
    
    Source$ = projectPath$ + ts(Index).workingFilename$
    Destination$ = projectPath$ + tempTileset$
    
    'First, we copy the working tileset into the temporary file.
    ChDir (currentDir$)
    Call FileCopy(Source$, Destination$)
    
    sourceNum = FreeFile
    Open Source$ For Binary As #sourceNum
    
    destNum = FreeFile
    Open Destination$ For Binary As #destNum
    
        'Load the selected tile into the block from the source.
        byteOffset = calcInsertionPoint(ts(Index).header, ts(Index).selectedTileNum)
        
        Get #sourceNum, byteOffset, tileBlock
        
        'Calculate the byte position to insert the tile.
        byteOffset = calcInsertionPoint(ts(Index).header, position)
        
        'Write the tile:
        Put #destNum, byteOffset, tileBlock
        
        'Now, shift the position of the intermediate tiles.
        'If we're moving up, we can use a standard incremental for-loop.
        'If we're moving down, we need to shift the tiles *up*.
        'direction will equal 1 or -1
        direction = Sgn(ts(Index).selectedTileNum - position)
        
        For tileOffset = position To ts(Index).selectedTileNum - direction Step direction
        
            byteOffset = calcInsertionPoint(ts(Index).header, tileOffset)
        
            Get #sourceNum, byteOffset, tileBlock
            Put #destNum, byteOffset + 3072 * direction, tileBlock
            
        Next tileOffset

    'Done!
    Close #sourceNum
    Close #destNum
    
    'Overwrite the working file.
    ChDir (currentDir$)
    Kill Source$
    Name Destination$ As Source$
    
    ts(Index).selectedTileNum = position
    lblSelectedTile(Index).Caption = "Selected tile: " & ts(Index).selectedTileNum
    
    Call drawTileset(Index)

Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
    
End Sub

Private Sub createSet(ByVal Index As Integer): On Error GoTo ErrorHandler
'================================================
'Creates a new tileset when a tile is dragged or
'inserted into a blank window.
'New set takes the information of the origin set.
'================================================

    Dim Source As String, sourceNum As Integer
    
    'Set up the information for the set.
    With ts(Index)
    
        .filename = "untitled"
    
        .header.detail = ts(Abs(Index - 1)).header.detail
        .header.version = ts(Abs(Index - 1)).header.version
        .header.tilesInSet = 0
        .tileFormat = ts(Abs(Index - 1)).tileFormat
        If .tileFormat = ISOTYPE Then
            .workingFilename$ = "_" + str$(Index) + "_.iso"
        Else
            .workingFilename$ = "_" + str$(Index) + "_.tst"
        End If
        .requireSave = True
    End With
    
    'Write the header to file.
    ChDir (currentDir$)
    Source$ = projectPath$ + ts(Index).workingFilename$
    
    sourceNum = FreeFile
    Open Source$ For Binary Access Write As #sourceNum
    
        Put #sourceNum, 1, ts(Index).header
    
    Close #sourceNum
    
    'Captions:
    lblTileset(Index).Caption = "Tileset: New"
    lblFormat(Index).Caption = lblFormat(Abs(Index - 1)).Caption
    
    'Buttons:
    cmdMoveUp(Index).Enabled = True
    cmdMoveDown(Index).Enabled = True
    cmdDelete(Index).Enabled = True
    
    chkIso(Index).value = chkIso(Abs(Index - 1)).value
    chkIso(Index).Enabled = chkIso(Abs(Index - 1)).Enabled
    

Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
    
End Sub

Private Sub clearInfo(ByVal Index As Integer): On Error Resume Next
'===========================================
'Clear the tileset information.
'===========================================

    Dim X As Integer, Y As Integer

    ts(Index).filename = ""
    ts(Index).grid = False
    ts(Index).header.detail = 0
    ts(Index).header.tilesInSet = 0
    ts(Index).header.version = -1
    ts(Index).isometric = False
    ts(Index).position = 0
    ts(Index).requireSave = False
    For X = 0 To 64
        For Y = 0 To 32
            ts(Index).selectedTile(X, Y) = 0
        Next Y
    Next X
    ts(Index).selectedTileNum = 0
    ts(Index).tileFormat = 0
    ts(Index).workingFilename = ""
    
End Sub

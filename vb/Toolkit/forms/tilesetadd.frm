VERSION 5.00
Begin VB.Form tilesetadd 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Edit Tilesets"
   ClientHeight    =   5520
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   11460
   Icon            =   "tilesetadd.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   368
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   764
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Tag             =   "1567"
   Begin VB.HScrollBar scrHorizontal 
      Height          =   255
      Index           =   1
      Left            =   6840
      Max             =   9
      Min             =   1
      TabIndex        =   43
      TabStop         =   0   'False
      Top             =   5220
      Value           =   9
      Width           =   495
   End
   Begin VB.HScrollBar scrHorizontal 
      Height          =   255
      Index           =   0
      Left            =   360
      Max             =   9
      Min             =   1
      TabIndex        =   42
      TabStop         =   0   'False
      Top             =   5220
      Value           =   9
      Width           =   495
   End
   Begin VB.CommandButton cmdInsertBlank 
      Enabled         =   0   'False
      Height          =   375
      Index           =   1
      Left            =   6405
      Picture         =   "tilesetadd.frx":0CCA
      Style           =   1  'Graphical
      TabIndex        =   15
      ToolTipText     =   "Insert a blank (transparent) tile"
      Top             =   3375
      Width           =   375
   End
   Begin VB.CommandButton cmdInsertBlank 
      Enabled         =   0   'False
      Height          =   375
      Index           =   0
      Left            =   4725
      Picture         =   "tilesetadd.frx":14E4
      Style           =   1  'Graphical
      TabIndex        =   14
      ToolTipText     =   "Insert a blank (transparent) tile"
      Top             =   3375
      Width           =   375
   End
   Begin VB.CheckBox chkWelcome 
      Caption         =   "Show welcome note"
      Height          =   255
      Left            =   4830
      TabIndex        =   22
      Top             =   5220
      Width           =   1815
   End
   Begin VB.CommandButton cmdSaveAs 
      Height          =   375
      Index           =   1
      Left            =   6030
      Picture         =   "tilesetadd.frx":1CFE
      Style           =   1  'Graphical
      TabIndex        =   5
      ToolTipText     =   "Save Tileset As"
      Top             =   1755
      Width           =   375
   End
   Begin VB.CommandButton cmdSaveAs 
      Height          =   375
      Index           =   0
      Left            =   5085
      Picture         =   "tilesetadd.frx":2088
      Style           =   1  'Graphical
      TabIndex        =   4
      ToolTipText     =   "Save Tileset As"
      Top             =   1755
      Width           =   375
   End
   Begin VB.VScrollBar scrVertical 
      Height          =   4350
      Index           =   1
      Left            =   11160
      TabIndex        =   36
      TabStop         =   0   'False
      Top             =   840
      Width           =   255
   End
   Begin VB.PictureBox picTileset 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BackColor       =   &H8000000C&
      DragIcon        =   "tilesetadd.frx":2412
      ForeColor       =   &H80000008&
      Height          =   4350
      Index           =   1
      Left            =   6780
      ScaleHeight     =   288
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   288
      TabIndex        =   35
      TabStop         =   0   'False
      Top             =   840
      Width           =   4350
   End
   Begin VB.PictureBox picTile 
      Height          =   540
      Index           =   1
      Left            =   6240
      ScaleHeight     =   32
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   32
      TabIndex        =   34
      TabStop         =   0   'False
      ToolTipText     =   "Selected tile"
      Top             =   840
      Width           =   540
   End
   Begin VB.CommandButton cmdInsert 
      Enabled         =   0   'False
      Height          =   375
      Index           =   1
      Left            =   6405
      Picture         =   "tilesetadd.frx":271C
      Style           =   1  'Graphical
      TabIndex        =   11
      ToolTipText     =   "Insert the selected tile from one tileset next to the tile selected in the this tileset"
      Top             =   2640
      Width           =   375
   End
   Begin VB.CommandButton cmdSave 
      Height          =   375
      Index           =   1
      Left            =   6030
      Picture         =   "tilesetadd.frx":2F36
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
      Left            =   6405
      Picture         =   "tilesetadd.frx":34C0
      Style           =   1  'Graphical
      TabIndex        =   19
      ToolTipText     =   "Move the selected tile down in the tileset"
      Top             =   4200
      Width           =   375
   End
   Begin VB.CommandButton cmdMoveUp 
      Enabled         =   0   'False
      Height          =   375
      Index           =   1
      Left            =   6405
      Picture         =   "tilesetadd.frx":3CDA
      Style           =   1  'Graphical
      TabIndex        =   17
      ToolTipText     =   "Move the selected tile up in the tileset"
      Top             =   3840
      Width           =   375
   End
   Begin VB.CommandButton cmdDelete 
      Enabled         =   0   'False
      Height          =   375
      Index           =   1
      Left            =   6405
      Picture         =   "tilesetadd.frx":44F4
      Style           =   1  'Graphical
      TabIndex        =   13
      ToolTipText     =   "Delete the selected tile"
      Top             =   3000
      Width           =   375
   End
   Begin VB.CheckBox chkIso 
      Height          =   375
      Index           =   1
      Left            =   6030
      Picture         =   "tilesetadd.frx":51BE
      Style           =   1  'Graphical
      TabIndex        =   8
      ToolTipText     =   "Change the view to isometric (doesn't permanently change tiles)"
      Top             =   2130
      Width           =   375
   End
   Begin VB.CommandButton cmdOpen 
      Height          =   375
      Index           =   1
      Left            =   6390
      Picture         =   "tilesetadd.frx":5E88
      Style           =   1  'Graphical
      TabIndex        =   3
      ToolTipText     =   "Open a tileset"
      Top             =   1380
      Width           =   375
   End
   Begin VB.CheckBox chkGrid 
      Height          =   375
      Index           =   1
      Left            =   6390
      Picture         =   "tilesetadd.frx":6212
      Style           =   1  'Graphical
      TabIndex        =   9
      ToolTipText     =   "Draw a grid around the tiles"
      Top             =   2130
      Width           =   375
   End
   Begin VB.CommandButton cmdInsert 
      Enabled         =   0   'False
      Height          =   375
      Index           =   0
      Left            =   4725
      Picture         =   "tilesetadd.frx":6EDC
      Style           =   1  'Graphical
      TabIndex        =   10
      ToolTipText     =   "Insert the selected tile from one tileset next to the tile selected in the this tileset"
      Top             =   2640
      Width           =   375
   End
   Begin VB.CommandButton cmdSave 
      Height          =   375
      Index           =   0
      Left            =   5085
      Picture         =   "tilesetadd.frx":76F6
      Style           =   1  'Graphical
      TabIndex        =   1
      ToolTipText     =   "Save the current tileset"
      Top             =   1380
      Width           =   375
   End
   Begin VB.CommandButton cmdCancel 
      Caption         =   "Cancel"
      Height          =   255
      Left            =   4830
      TabIndex        =   21
      ToolTipText     =   "Leave  without saving changes"
      Top             =   4920
      Width           =   1815
   End
   Begin VB.CommandButton cmdOK 
      Caption         =   "OK"
      Height          =   255
      Left            =   4830
      TabIndex        =   20
      ToolTipText     =   "Save changes and leave"
      Top             =   4680
      Width           =   1815
   End
   Begin VB.CommandButton cmdMoveDown 
      Enabled         =   0   'False
      Height          =   375
      Index           =   0
      Left            =   4725
      Picture         =   "tilesetadd.frx":7C80
      Style           =   1  'Graphical
      TabIndex        =   18
      ToolTipText     =   "Move the selected tile down in the tileset"
      Top             =   4200
      Width           =   375
   End
   Begin VB.CommandButton cmdMoveUp 
      Enabled         =   0   'False
      Height          =   375
      Index           =   0
      Left            =   4725
      Picture         =   "tilesetadd.frx":849A
      Style           =   1  'Graphical
      TabIndex        =   16
      ToolTipText     =   "Move the selected tile up in the tileset"
      Top             =   3840
      Width           =   375
   End
   Begin VB.CommandButton cmdDelete 
      Enabled         =   0   'False
      Height          =   375
      Index           =   0
      Left            =   4725
      Picture         =   "tilesetadd.frx":8CB4
      Style           =   1  'Graphical
      TabIndex        =   12
      ToolTipText     =   "Delete the selected tile"
      Top             =   3000
      Width           =   375
   End
   Begin VB.CheckBox chkIso 
      Height          =   375
      Index           =   0
      Left            =   5085
      Picture         =   "tilesetadd.frx":997E
      Style           =   1  'Graphical
      TabIndex        =   7
      ToolTipText     =   "Change the view to isometric (doesn't permanently change tiles)"
      Top             =   2130
      Width           =   375
   End
   Begin VB.CommandButton cmdOpen 
      Height          =   375
      Index           =   0
      Left            =   4725
      Picture         =   "tilesetadd.frx":A648
      Style           =   1  'Graphical
      TabIndex        =   0
      ToolTipText     =   "Open a tileset"
      Top             =   1380
      Width           =   375
   End
   Begin VB.CheckBox chkGrid 
      Height          =   375
      Index           =   0
      Left            =   4725
      Picture         =   "tilesetadd.frx":A9D2
      Style           =   1  'Graphical
      TabIndex        =   6
      ToolTipText     =   "Draw a grid around the tiles"
      Top             =   2130
      Width           =   375
   End
   Begin VB.PictureBox picTile 
      Height          =   540
      Index           =   0
      Left            =   4725
      ScaleHeight     =   32
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   32
      TabIndex        =   25
      TabStop         =   0   'False
      ToolTipText     =   "Selected tile"
      Top             =   840
      Width           =   540
   End
   Begin VB.VScrollBar scrVertical 
      Height          =   4350
      Index           =   0
      Left            =   120
      TabIndex        =   24
      TabStop         =   0   'False
      Top             =   840
      Width           =   255
   End
   Begin VB.PictureBox picTileset 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BackColor       =   &H8000000C&
      DragIcon        =   "tilesetadd.frx":B69C
      ForeColor       =   &H80000008&
      Height          =   4350
      Index           =   0
      Left            =   375
      ScaleHeight     =   288
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   288
      TabIndex        =   23
      TabStop         =   0   'False
      Top             =   840
      Width           =   4350
   End
   Begin VB.Label lblSetWidth 
      Caption         =   "Width"
      Height          =   255
      Index           =   1
      Left            =   7440
      TabIndex        =   45
      Top             =   5250
      Width           =   615
   End
   Begin VB.Label lblSetWidth 
      Caption         =   "Width"
      Height          =   255
      Index           =   0
      Left            =   960
      TabIndex        =   44
      Top             =   5250
      Width           =   495
   End
   Begin VB.Label lblInsertBlank 
      Caption         =   "Insert blank tile"
      Height          =   255
      Left            =   5220
      TabIndex        =   41
      Top             =   3480
      Width           =   1095
   End
   Begin VB.Label lblSelectedTile 
      Caption         =   "Selected tile:"
      Height          =   255
      Index           =   1
      Left            =   6765
      TabIndex        =   40
      Top             =   480
      Width           =   1575
   End
   Begin VB.Label lblFormat 
      Caption         =   "Format:"
      Height          =   255
      Index           =   1
      Left            =   8925
      TabIndex        =   39
      Top             =   120
      Width           =   1815
   End
   Begin VB.Label lblContains 
      Caption         =   "Contains:"
      Height          =   255
      Index           =   1
      Left            =   8925
      TabIndex        =   38
      Top             =   480
      Width           =   1695
   End
   Begin VB.Label lblTileset 
      Caption         =   "Tileset:"
      Height          =   255
      Index           =   1
      Left            =   6765
      TabIndex        =   37
      Top             =   120
      Width           =   2175
   End
   Begin VB.Label lblSelectedTile 
      Caption         =   "Selected tile:"
      Height          =   255
      Index           =   0
      Left            =   2325
      TabIndex        =   33
      Top             =   480
      Width           =   1455
   End
   Begin VB.Label lblInsert 
      Caption         =   "Insert current tile"
      Height          =   255
      Left            =   5130
      TabIndex        =   32
      Top             =   2760
      Width           =   1215
   End
   Begin VB.Label lblFormat 
      Caption         =   "Format:"
      Height          =   255
      Index           =   0
      Left            =   2325
      TabIndex        =   31
      Top             =   120
      Width           =   1935
   End
   Begin VB.Label lblContains 
      Caption         =   "Contains:"
      Height          =   255
      Index           =   0
      Left            =   285
      TabIndex        =   30
      Top             =   480
      Width           =   1695
   End
   Begin VB.Label lblTileset 
      Caption         =   "Tileset:"
      Height          =   255
      Index           =   0
      Left            =   285
      TabIndex        =   29
      Top             =   120
      Width           =   2055
   End
   Begin VB.Label lblMoveDown 
      Caption         =   "Move down"
      Height          =   255
      Left            =   5280
      TabIndex        =   28
      Top             =   4320
      Width           =   885
   End
   Begin VB.Label lblMoveUp 
      Caption         =   "Move up"
      Height          =   255
      Left            =   5400
      TabIndex        =   27
      Top             =   3960
      Width           =   660
   End
   Begin VB.Label lblDelete 
      Alignment       =   2  'Center
      Caption         =   "Delete current tile"
      Height          =   255
      Left            =   5010
      TabIndex        =   26
      Top             =   3120
      Width           =   1455
   End
End
Attribute VB_Name = "tilesetadd"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'==============================================================================
'All contents copyright 2004, Jonathan Hughes (Delano)
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'==============================================================================

'==============================================================================
'"Advanced" tileset editor - by Delano for 3.0.4
'==============================================================================

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

Private Sub chkGrid_Click(index As Integer): On Error Resume Next
'==============================================================================
'Turn off / on grid.
'==============================================================================
    Call drawTileset(index)
End Sub

Private Sub chkIso_Click(index As Integer): On Error Resume Next
'==============================================================================
'Isometric check button - display tileset isometrically.
'==============================================================================
    
    picTile(index).Cls
    
    Call drawTileset(index)
    
    picTile(index).AutoRedraw = False
    
    If chkIso(index).value = 0 Then
        picTile(index).width = 36                               'Pixel values!
        'Realign the right-hand box.
        If index = 1 Then picTile(1).Left = picTileset(1).Left - 36
        scrHorizontal(index).max = picTileset(index).width / 32
    Else
        picTile(index).width = 68
        'Realign the right-hand box.
        If index = 1 Then picTile(1).Left = picTileset(1).Left - 68
        scrHorizontal(index).max = Int(picTileset(index).width \ 64)
    End If
    
    scrHorizontal(index).value = scrHorizontal(index).max
    
    picTile(index).AutoRedraw = True
    
    Call drawTile(index)
    
End Sub

Private Sub chkWelcome_Click(): On Error Resume Next
'==============================================================================
'Show the welcome note.
'==============================================================================
    configfile.advTilesetTips = chkWelcome.value
End Sub

Private Sub cmdCancel_Click(): On Error Resume Next
'==============================================================================
'Exit without saving.
'==============================================================================

    Dim answer As VbMsgBoxResult
    answer = vbYes

    If LenB(ts(0).filename) And LenB(ts(1).filename) Then
        answer = MsgBox("Exit without saving changes?", vbYesNo + vbExclamation + vbDefaultButton2)
    End If
    
    If answer = vbNo Then Exit Sub
    
    Unload Me

End Sub

Private Sub cmdDelete_Click(index As Integer): On Error Resume Next
'==============================================================================
'Delete the currently selected tile from the tileset. Creates a temporary
'tileset and copies tile-by-tile from the original, skipping the selected tile.
'==============================================================================

    Dim Source As String, Destination As String, sourceNum As Integer, destNum As Integer
    Dim byteOffset As Long, position As Long
    Dim result As VbMsgBoxResult
    
    ChDir (currentDir)
    
    If ts(index).selectedTileNum = -1 Then Exit Sub
    
    If ts(index).header.tilesInSet = 1 Then
        'There's only one tile left!
        
        result = MsgBox("Do you want to delete this tileset?", vbYesNo + vbExclamation + vbDefaultButton2)
        
        If result = vbYes Then
            'Delete the tileset.
            
            Kill (projectPath & tilePath & ts(index).filename)
            Kill (projectPath & ts(index).workingFilename)
            
            Call clearInfo(index)  'ts(i) info.
            
            lblTileset(index).Caption = "Tileset:": lblContains(index).Caption = "Contains:"
            lblSelectedTile(index).Caption = "Selected tile:": lblFormat(index).Caption = "Format:"
    
            'Clear the picture boxes.
            picTileset(index).Cls
            picTile(index).Cls
    
            'Deactivate the tool buttons.
            cmdMoveDown(index).Enabled = False: cmdDelete(index).Enabled = False
            cmdMoveUp(index).Enabled = False
    
        End If
        Exit Sub
    End If '.tilesInSet = 1

    'Decrease the tileset count.
    ts(index).header.tilesInSet = ts(index).header.tilesInSet - 1

    'Set up the files for writing.
    Source = projectPath & ts(index).workingFilename
    Destination = projectPath & tempTileset
    
    sourceNum = FreeFile
    Open Source For Binary As #sourceNum
    
    destNum = FreeFile
    Open Destination For Binary As #destNum
    
        'Write the new header.
        Put #destNum, 1, ts(index).header
    
        'Now, read and write the tiles in blocks of 3072 bytes.
        
        DoEvents
        
        For position = 1 To ts(index).selectedTileNum - 1
            
            'byteOffset = (position - 1) * 3072 + 7              '7 for the header
            byteOffset = calcInsertionPoint(ts(index).header, position)
            
            Get #sourceNum, byteOffset, tileBlock
            Put #destNum, byteOffset, tileBlock
            
        Next position
        
        'That has written the tiles before the selected tile, now the tiles after.
        
        For position = ts(index).selectedTileNum + 1 To ts(index).header.tilesInSet + 1
            'Loop to the tile count + 1, because we decreased it earlier!
        
            'byteOffset = (position - 1) * 3072 + 7
            byteOffset = calcInsertionPoint(ts(index).header, position)

            Get #sourceNum, byteOffset, tileBlock
            Put #destNum, byteOffset - 3072, tileBlock
            
        Next position
        
    'Done!
    Close #sourceNum
    Close #destNum
    
    'Overwrite the working file.
    ChDir (currentDir)
    Kill Source
    Name Destination As Source
    
    ts(index).selectedTileNum = -1
    lblContains(index).Caption = "Contains: " & ts(index).header.tilesInSet & " tiles"
    lblSelectedTile(index).Caption = "Selected tile:"
    Call drawTileset(index)
    Call drawTile(index)

End Sub

Private Sub cmdInsert_Click(index As Integer): On Error Resume Next
'==============================================================================
'Insert the selected tile from the other set into the position in front of the
'selected tile in the Index set.
'Calls insertTile - as with drag-drop events.
'==============================================================================

    Dim number As Integer
    
    If ts(index).selectedTileNum = -1 Then
        'If no tile is selected, add the tile to the end of the set.
        number = ts(index).header.tilesInSet + 1
    Else
        number = ts(index).selectedTileNum
    End If
    
    Call insertTile(index, number)
    
End Sub

Private Sub cmdInsertBlank_Click(index As Integer): On Error Resume Next
'==============================================================================
'Insert a blank (transparent) tile into the position in front of the selected
'tile in the Index set.
'Calls insertTile - as with drag-drop events.
'==============================================================================

    Dim position As Long
    Dim Source As String, Destination As String, sourceNum As Integer, destNum As Integer
    Dim rgbByte As Byte, element As Long, byteOffset As Long, tileoffset As Long
    
    If LenB(ts(index).filename) = 0 Then Exit Sub
    
    If ts(index).selectedTileNum = -1 Then
        'If no tile is selected, add the tile to the end of the set.
        position = ts(index).header.tilesInSet + 1
    Else
        position = ts(index).selectedTileNum
    End If
    
    'Form the tileblock. Cycle over the bytes setting 0,1,2 sequentially, which represents
    'the transparent colour.
    
    For element = 0 To 3071
        tileBlock(element) = rgbByte
        rgbByte = rgbByte + 1
        If rgbByte = 3 Then rgbByte = 0
    Next element
    
    'Create the temporary files in the root!
    Source = projectPath & ts(index).workingFilename
    Destination = projectPath & tempTileset
   
    'First, we copy the working tileset into the temporary file.
    ChDir (currentDir)
    Call FileCopy(Source, Destination)
    
    'Open the files for copying.
    sourceNum = FreeFile
    Open Source For Binary Access Read As #sourceNum
    
    destNum = FreeFile
    Open Destination For Binary Access Write As #destNum

        'Calculate the byte position to insert the tile.
        byteOffset = calcInsertionPoint(ts(index).header, position)
        
        'Write the tile:
        Put #destNum, byteOffset, tileBlock
    
        'Now, we add the rest of the tiles to the set after this tile.
        
        For tileoffset = position To ts(index).header.tilesInSet
        
            'byteOffset = (tileOffset - 1) * 3072 + 7
            byteOffset = calcInsertionPoint(ts(index).header, tileoffset)
            
            Get #sourceNum, byteOffset, tileBlock
            Put #destNum, byteOffset + 3072, tileBlock
        
        Next tileoffset
        
        'Overwrite the header.
        ts(index).header.tilesInSet = ts(index).header.tilesInSet + 1
        Put #destNum, 1, ts(index).header
        
    'Done!
    Close #sourceNum
    Close #destNum
    
    'Overwrite the working file.
    ChDir (currentDir)
    Kill Source
    Name Destination As Source
    
    ts(index).selectedTileNum = position
    lblSelectedTile(index).Caption = "Selected tile: " & ts(index).selectedTileNum
    lblContains(index).Caption = "Contains: " & ts(index).header.tilesInSet & " tiles"
    
    Call drawTileset(index)
    Call drawTile(index)


End Sub

Private Sub cmdMoveDown_Click(index As Integer): On Error Resume Next
'==============================================================================
'Decreases the tile's position in the set (moves down one place).
'Calls move tile routine - as used in dragging.
'==============================================================================

    Dim number As Integer

    'If there is no tile selected or the last tile is selected, or there is only one tile, exit sub.
    If ts(index).selectedTileNum >= ts(index).header.tilesInSet _
        Or ts(index).selectedTileNum = -1 Or ts(index).header.tilesInSet = 1 Then Exit Sub
        
    number = ts(index).selectedTileNum + 1          'Move down.
        
    Call moveTile(index, number)
    
End Sub

Private Sub cmdMoveUp_Click(index As Integer): On Error Resume Next
'==============================================================================
'Increases the tile's position in the set (moves up one place).
'Calls moveTile - as used in drag-drop.
'==============================================================================

    Dim number As Integer

    'If there is no tile selected or the first tile is selected, or there is only one tile, exit sub.
    If ts(index).selectedTileNum <= 1 Or ts(index).header.tilesInSet = 1 Then Exit Sub
        
    number = ts(index).selectedTileNum - 1          'Move up.
        
    Call moveTile(index, number)

End Sub

Private Sub cmdOK_Click(): On Error Resume Next
'==============================================================================
'Save changes and exit.
'==============================================================================
    Call cmdSave_Click(0)
    Call cmdSave_Click(1)
    Unload Me
End Sub

Private Sub cmdOpen_Click(index As Integer): On Error Resume Next
'==============================================================================
'Opens a tileset and draws it in the corresponding window.
'==============================================================================

    Dim dlg As FileDialogInfo, result As VbMsgBoxResult
    
    ChDir (currentDir)
    
    'If the open tileset is not saved:
    If ts(index).requireSave Then
        result = MsgBox("Do you want to save the changes to the open tileset?", vbYesNoCancel + vbExclamation)
        
        If result = vbYes Then Call cmdSave_Click(index)
        If result = vbCancel Then Exit Sub
    End If
    
    'Set up the dialog window for opening the tileset.
    dlg.strDefaultFolder = projectPath & tilePath
    dlg.strTitle = "Open Tileset"
    dlg.strDefaultExt = "tst"
    dlg.strFileTypes = "Supported Types|*.tst;*.iso|RPG Toolkit TileSet (*.tst)|*.tst|RPG Toolkit Isometric TileSet (*.iso)|*.iso|All files(*.*)|*.*"
    
    If Not OpenFileDialog(dlg, Me.hwnd) Then Exit Sub 'User pressed cancel.
    If LenB(dlg.strSelectedFileNoPath) = 0 Then Exit Sub
     
    'Remove the old working tileset. Created in the game directory!!
    Kill (projectPath & ts(index).workingFilename)
    ts(index).selectedTileNum = -1
    ts(index).requireSave = True                        'Might want to change this!
    
    ts(index).filename = dlg.strSelectedFileNoPath
    
    'Get the header information from the tileset.
    ts(index).tileFormat = tilesetInfo(ts(index).filename)
    ts(index).header = tileset
    
    'Create the working tileset: _index_original.tst
    ts(index).workingFilename = "_" & CStr(index) & "_" & ts(index).filename
    ChDir (currentDir)
    Call FileCopy(projectPath & tilePath & ts(index).filename, projectPath & ts(index).workingFilename)
    
    'Initial values for check buttons:
    Select Case ts(index).tileFormat
        Case ISOTYPE
            chkIso(index).value = 1
            chkIso(index).Enabled = False
            lblFormat(index).Caption = "Format: Isometric 64x32"
            scrHorizontal(index).max = Int(picTileset(index).width / 64)
        Case TSTTYPE
            chkIso(index).value = 0
            chkIso(index).Enabled = True
            lblFormat(index).Caption = "Format: Standard 32x32"
            scrHorizontal(index).max = picTileset(index).width / 32
        Case Else
            Exit Sub
    End Select
    
    'Set up the scrollbar:
    ts(index).startNumber = 1                       'Tile to place in the top-left corner.
    scrVertical(index).value = 0
    scrHorizontal(index).value = scrHorizontal(index).max
    
    'Update the labels:
    lblTileset(index).Caption = "Tileset: " & ts(index).filename
    lblContains(index).Caption = "Contains: " & ts(index).header.tilesInSet & " tiles"
    
    picTile(index).Cls
    lblSelectedTile(index).Caption = "Selected tile:"
    
    'Activate the tool buttons:
    cmdInsert(index).Enabled = True: cmdInsert(Abs(index - 1)).Enabled = True
    cmdMoveUp(index).Enabled = True
    cmdMoveDown(index).Enabled = True
    cmdDelete(index).Enabled = True
    cmdInsertBlank(index).Enabled = True

    Call drawTileset(index)                         'Draw the tileset.
    
End Sub

Private Sub cmdSave_Click(index As Integer): On Error Resume Next
'==============================================================================
'Saves the current tileset.
'All changes are made to the working copy, this copies the changes back to the original.
'==============================================================================

    If LenB(ts(index).filename) = 0 Or ts(index).filename = "untitled" Then
        Call cmdSaveAs_Click(index)
        Exit Sub
    End If
    If (GetAttr(projectPath & tilePath & ts(index).filename) And vbReadOnly) Then
        Call MsgBox("This file is read-only; please choose a different file.")
        Call cmdSaveAs_Click(index)
        Exit Sub
    End If
    'Delete the original and copy the working the tileset.
    ChDir (currentDir)
    Kill (projectPath & tilePath & ts(index).filename)
    Call FileCopy(projectPath & ts(index).workingFilename, projectPath & tilePath & ts(index).filename)

End Sub

Private Sub cmdSaveAs_Click(index As Integer): On Error Resume Next
'==============================================================================
'Save As - create dialog and new tile.
'==============================================================================

    Dim dlg As FileDialogInfo, result As VbMsgBoxResult
    
    If ts(index).requireSave = False Then Exit Sub

    'Set up the dialog window for opening the tileset.
    dlg.strDefaultFolder = projectPath & tilePath
    dlg.strTitle = "Save Tileset As"
    
    If ts(index).tileFormat = ISOTYPE Then
        dlg.strDefaultExt = "iso"
        dlg.strFileTypes = "RPG Toolkit Isometric TileSet (*.iso)|*.iso|All files(*.*)|*.*"
    Else
        dlg.strDefaultExt = "tst"
        dlg.strFileTypes = "RPG Toolkit TileSet (*.tst)|*.tst|All files(*.*)|*.*"
    End If
    
    ChDir (currentDir)
    If Not SaveFileDialog(dlg, Me.hwnd) Then Exit Sub 'User pressed cancel.
    If LenB(dlg.strSelectedFile) = 0 Then Exit Sub
     
    'Kill the file and copy the working file across.
    ChDir (currentDir)
    Kill (dlg.strSelectedFile)
    Call FileCopy(projectPath & ts(index).workingFilename, dlg.strSelectedFile)
    
    'Rename the working file.
    dlg.strSelectedFile = "_" & CStr(index) & "_" & dlg.strSelectedFileNoPath
    Name (projectPath & ts(index).workingFilename) As (projectPath & dlg.strSelectedFile)

    ts(index).filename = dlg.strSelectedFileNoPath
    ts(index).workingFilename = dlg.strSelectedFile
    
    lblTileset(index).Caption = "Tileset: " & dlg.strSelectedFileNoPath
    

End Sub

Private Sub Form_Load(): On Error Resume Next
'==============================================================================
'Form entry point.
'==============================================================================

    Dim index As Integer

    ' Call LocalizeForm(Me)       'Not done for this form.
    
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
    Call GFXInitScreen(640, 480)
    For index = 0 To 1
        ts(index).selectedTileNum = -1
        ts(index).requireSave = False
    Next index
    
    Call clearInfo(0)
    Call clearInfo(1)

End Sub

Private Sub Form_Unload(Cancel As Integer): On Error Resume Next
'==============================================================================
'Exit point - delete the temporary files.
'==============================================================================

    Dim index As Integer

    'Delete the temporary files.
    ChDir (currentDir)
    For index = 0 To 1
        If LenB(ts(index).workingFilename) Then Kill projectPath & ts(index).workingFilename
    Next index
    
    tilesetedit.SSTab1.Tab = 0

End Sub

Private Sub drawGrid(ByVal index As Integer): On Error Resume Next
'==============================================================================
'Draws the grid on top of the specified picture box.
'==============================================================================
    
    Dim x As Integer, y As Integer, tileWidth As Integer, tileHeight As Integer
    
    If chkGrid(index).value = 0 Then Exit Sub
    
    tileWidth = scrHorizontal(index).value
    tileHeight = picTileset(index).Height / 32
    
    'Draw vertical lines.
    If chkIso(index).value = 0 Then
        '2D. Vertical lines.
        For x = 0 To tileWidth * 32 Step 32
            Call vbPicLine(picTileset(index), x, 0, x, tileHeight * 32, QBColor(1))
        Next x
        'Draw horizontal lines.
        For y = 0 To (tileHeight + 1) * 32 Step 32
            Call vbPicLine(picTileset(index), 0, y, tileWidth * 32, y, QBColor(1))
        Next y
    Else
        'Iso. Vertical lines.
        For x = 0 To tileWidth * 64 Step 64
            Call vbPicLine(picTileset(index), x, 0, x, tileHeight * 32, QBColor(1))
        Next x
        'Draw horizontal lines.
        For y = 0 To (tileHeight + 1) * 32 Step 32
            Call vbPicLine(picTileset(index), 0, y, tileWidth * 64, y, QBColor(1))
        Next y
    End If
    
End Sub

Private Sub drawTileset(ByVal index As Integer): On Error Resume Next
'==============================================================================
'Draws the tileset in the corresponding picture box.
'==============================================================================

    Dim tileWidth As Long, tileHeight As Long, isometric As Long

    'Determine the size of the picture box in tiles.
    tileWidth = scrHorizontal(index).value
    tileHeight = picTileset(index).Height / 32
    
    If chkIso(index).value = 1 Then isometric = 1
    If ts(index).tileFormat = ISOTYPE Then isometric = ISOTYPE
    
    'Set up the scrollbar:
    scrVertical(index).max = (-Int(ts(index).header.tilesInSet / (-tileWidth))) - tileHeight
    
    If scrVertical(index).max < 1 Then
        'If all the tiles are contained in the window.
        scrVertical(index).Enabled = False
    Else
        'Clicking the bar (not button). Scrolls to the last row (last row becomes top row).
        scrVertical(index).LargeChange = tileHeight - 1
        scrVertical(index).Enabled = True
    End If

    ts(index).startNumber = (scrVertical(index).value * tileWidth) + 1
    
    picTileset(index).Cls
    Call GFXdrawTstWindow(projectPath & ts(index).workingFilename, _
                          picTileset(index).hdc, _
                          ts(index).startNumber, _
                          tileWidth, _
                          tileHeight, _
                          isometric)
    Call drawGrid(index)

End Sub

Private Sub drawTile(ByVal index As Integer): On Error Resume Next
'==============================================================================
'Draws the selected tile in the preview box.
'==============================================================================
    
    Dim x As Integer, y As Integer, pixel As Long
    
    picTile(index).Cls
    If ts(index).selectedTileNum = -1 Then Exit Sub
    
    'Clear the tilemem.
    For x = 0 To 64
        For y = 0 To 32
            tileMem(x, y) = -1
            ts(index).selectedTile(x, y) = -1
        Next y
    Next x
            
    'Load the tile into memory.
    ChDir (currentDir)
    Call openFromTileSet(projectPath & ts(index).workingFilename, ts(index).selectedTileNum)
    
    'Copy across from tilemem.
    For x = 0 To 64
        For y = 0 To 32
            ts(index).selectedTile(x, y) = tileMem(x, y)
        Next y
    Next x
    
    'Draw the tile.
    If chkIso(index).value = 0 Then
        '2D.
        
        For x = 1 To 32
            For y = 1 To 32
                If ts(index).selectedTile(x, y) <> -1 Then
                    Call vbPicPSet(picTile(index), x - 1, y - 1, ts(index).selectedTile(x, y))
                Else
                    Call vbPicPSet(picTile(index), x - 1, y - 1, RGB(255, 255, 255))
                End If
            Next y
        Next x
        
    Else
        'Isometric.
        
        If ts(index).tileFormat = ISOTYPE Then
            '.iso isometric.
            Call tileDrawIso(picTile(index), 0, 0, ISODETAIL)
        Else
            '.tst isometric.
            Call tileDrawIso(picTile(index), 0, 0, 3)
        End If
        
    End If 'chkIso.value
    
End Sub

Private Sub picTileset_DragDrop(index As Integer, Source As Control, x As Single, y As Single): On Error Resume Next
'==============================================================================
'Drag-drop on the tileset picture boxes, i.e. mouseUp after movement.
'==============================================================================

    'We want to be able to drag tiles around or between tilesets.
    'We have the selected tile from mouseDown and the selectedTile property.
    'We just need the location to place the tile.
    'If we're moving between tilesets, we're adding a tile.
    'If we're rearranging, we're not adding a tile.

    Dim tileWidth As Integer, number As Integer
    
    picTileset(index).Refresh    'Clear the box highlight.
    
    'Calculate the selected tile.
    x = IIf(chkIso(index).value = 0, x \ 32, x \ 64)
    y = y \ 32
    
    tileWidth = scrHorizontal(index).value
    If x + 1 > tileWidth Then x = tileWidth
    
    number = y * tileWidth + x + 1
    number = number + scrVertical(index).value * tileWidth
    
    'Work out if we're in the same tileset as we started in.
    If index = lastMouseDown Then
        'If the "mouse-up" Index is the same as the mouse-down, we're in the same tileset.
        
        'If the tile hasn't moved, exit.
        If number = ts(index).selectedTileNum Then Exit Sub
        
        Call moveTile(index, number)
        
    Else
        'We've moved to the other tileset.
        
        If number > ts(index).header.tilesInSet Then number = ts(index).header.tilesInSet + 1
        
        Call insertTile(index, number)
        
    End If

End Sub

Private Sub picTileset_DragOver(index As Integer, Source As Control, x As Single, y As Single, State As Integer): On Error Resume Next
'==============================================================================
'Drag movement on the tileset picture boxes, i.e. mouseMove.
'==============================================================================

    'We want to place a highlight on the drop position during the drag over.
    'We draw a box around the nearest tile.
    
    Dim xPixel As Long, yPixel As Long
    
    'Redraw the tileset (and grid).
    picTileset(index).Refresh
    'Disable autoredraw so lines aren't persistent.
    picTileset(index).AutoRedraw = False
        
    If State <> vbLeave Then
        
        'Draw the box only if we're not leaving the picture!
        yPixel = y - y Mod 32
        If chkIso(index).value = 0 Then
            '32x32 box.
            xPixel = x - x Mod 32
            Call vbPicRect(picTileset(index), xPixel, yPixel, xPixel + 32, yPixel + 32, vbQBColor(15))
            Call vbPicRect(picTileset(index), xPixel - 1, yPixel - 1, xPixel + 33, yPixel + 33, vbQBColor(15))
        Else
            'Isometric 64x32.
            xPixel = x - x Mod 64
            Call vbPicRect(picTileset(index), xPixel, yPixel, xPixel + 64, yPixel + 32, vbQBColor(15))
            Call vbPicRect(picTileset(index), xPixel - 1, yPixel - 1, xPixel + 65, yPixel + 33, vbQBColor(15))
        End If
        
    End If
    
    picTileset(index).AutoRedraw = True

End Sub

Private Sub picTileset_KeyDown(index As Integer, keyCode As Integer, Shift As Integer): On Error Resume Next
'==============================================================================
'Keyboard shortcuts for some of the tools.
'Only work when the tileset picture box has the focus!
'==============================================================================

    Select Case keyCode
        Case 27:
            'Escape. Clear the selected tile.
            ts(index).selectedTileNum = -1
            lblSelectedTile(index).Caption = "Selected Tile:"
            Call drawTile(index)
        Case 37:
            'Left arrow.
            Call cmdInsert_Click(index)
        Case 38:
            'Up arrow.
            Call cmdMoveUp_Click(index)
        Case 39:
            'Right arrow.
            Call cmdInsert_Click(Abs(index - 1))
        Case 40:
            'Down arrow.
            Call cmdMoveDown_Click(index)
        Case 46:
            'Delete.
            Call cmdDelete_Click(index)
    End Select
    
End Sub

Private Sub picTileset_MouseDown(index As Integer, Button As Integer, Shift As Integer, x As Single, y As Single): On Error Resume Next
'==============================================================================
'Mouse down on the tileset picture box.
'==============================================================================

    Dim tileWidth As Integer, tileHeight As Integer, number As Integer
    
    'Calculate the selected tile.
    x = IIf(chkIso(index).value = 0, x \ 32, x \ 64)
    y = y \ 32
    
    'Check we've not selected the blank area.
    tileWidth = scrHorizontal(index).value
    If x + 1 > tileWidth Then Exit Sub
    
    number = y * tileWidth + x + 1
    number = number + scrVertical(index).value * tileWidth
    
    'Assign if is a valid number.
    If number > ts(index).header.tilesInSet Then
        Exit Sub
    Else
        ts(index).selectedTileNum = number
    End If
    
    lblSelectedTile(index).Caption = "Selected tile: " & ts(index).selectedTileNum
    
    'Assign the last clicked tileset to the current index.
    lastMouseDown = index
    
    Call drawTile(index)
    
End Sub

Private Sub picTileset_MouseMove(index As Integer, Button As Integer, Shift As Integer, x As Single, y As Single): On Error Resume Next
'==============================================================================
'Mouse move on the tilesets.
'==============================================================================
    'Only initiate drag upon movement (and a button held).
    If Button <> 0 Then picTileset(index).Drag
End Sub

Private Sub scrHorizontal_Change(index As Integer)
'==============================================================================
'Horizontal scrollers.
'==============================================================================
    Call drawTileset(index)
End Sub

Private Sub scrVertical_Change(index As Integer): On Error Resume Next
'==============================================================================
'Vertical scrollers.
'==============================================================================
    Call drawTileset(index)
End Sub

Private Sub insertTile(ByVal index As Integer, ByVal position As Integer): On Error Resume Next
'==============================================================================
'Inserts the selected tile from the other set into the position specified.
'Subsequent tiles in the set are shifted down a place.
'Here, "index" refers to the set we are inserting into.
'Called for the insert command button and a drag-drop event between tilesets.
'For the command button, position is the selected tile in the Index set.
'==============================================================================

    Dim Source As String, Destination As String, sourceNum As Integer, destNum As Integer
    Dim byteOffset As Long, tileoffset As Long
    Dim x As Integer, y As Integer
    Dim r As Byte, g As Byte, b As Byte
    Dim element As Long, xCount As Integer, yCount As Integer

    'First check there is a selected tile the origin set.
    If ts(Abs(index - 1)).selectedTileNum = -1 Then Exit Sub
    
    'Check if we need to create a new set.
    If LenB(ts(index).filename) = 0 Then
        Call createSet(index)
        position = 1
    End If
    
    'Check we're not trying to insert an isometric tile into a .tst
    If ts(index).tileFormat <> ISOTYPE And ts(Abs(index - 1)).tileFormat = ISOTYPE Then
        Call MsgBox("You cannot insert an isometric tile into a 2D tileset.", vbOKOnly + vbInformation)
        Exit Sub
    End If
    
    'If we're inserting a .tst tile into an isometric set, reshape the tile:
    If ts(index).tileFormat = ISOTYPE And ts(Abs(index - 1)).tileFormat <> ISOTYPE Then
    
        'First load the tile into tilemem
        For x = 0 To 32
            For y = 0 To 32
                 tileMem(x, y) = ts(Abs(index - 1)).selectedTile(x, y)
            Next y
        Next x
        
        'Convert the tile. Operates on tilemem. We now have buftile in an isometric shape!
        Call tstToIsometric
        
        'Write buftile into the tile block.
        element = 0: xCount = 1: yCount = 1
        For x = 1 To 64
            For y = 1 To 32
            
'Call traceString("buftile(" & x & ", " & y & ") = " & buftile(x, y))

                If isoMaskBmp(x, y) = RGB(0, 0, 0) Then 'Black. Take pixel.
                
                    'Convert long colour to rgb byte values.
                    If bufTile(x - 1, y - 1) = -1 Then
                        'Transparent colour.
                        r = 0: g = 1: b = 2
                    Else
                        r = red(bufTile(x - 1, y - 1))
                        g = green(bufTile(x - 1, y - 1))
                        b = blue(bufTile(x - 1, y - 1))
                    End If
                    
                    'Set the bytes in the block.
                    tileBlock(element) = r
                    tileBlock(element + 1) = g
                    tileBlock(element + 2) = b
                    element = element + 3
                    
                    'Set the pixels in the selected tile.
                    ts(index).selectedTile(xCount, yCount) = bufTile(x - 1, y - 1)
                    
'Call traceString("selectedtile(" & xCount & ", " & yCount & ") = " & buftile(x - 1, y - 1))

                    
                    yCount = yCount + 1
                    If (yCount > 32) Then
                        xCount = xCount + 1
                        yCount = 1
                    End If
                                        
                End If
            Next y
        Next x
                             
    Else
    
        'We read the tile straight from memory.
        
        'Load the selected tile in the other set.
        Dim insertNum As Integer, insert As String
        insert = projectPath & ts(Abs(index - 1)).workingFilename
        
        insertNum = FreeFile
        Open insert For Binary As #insertNum
        
            byteOffset = calcInsertionPoint(ts(Abs(index - 1)).header, ts(Abs(index - 1)).selectedTileNum)
        
            Get #insertNum, byteOffset, tileBlock
            
        Close #insertNum
        
    End If 'tst -> iso.
    
    Source = projectPath & ts(index).workingFilename                   'Create the temporary files in the root!
    Destination = projectPath & tempTileset
   
    'First, we copy the working tileset into the temporary file.
    ChDir (currentDir)
    Call FileCopy(Source, Destination)
    
    
    'Open the files for copying.
    sourceNum = FreeFile
    Open Source For Binary As #sourceNum
    
    destNum = FreeFile
    Open Destination For Binary As #destNum

        'Calculate the byte position to insert the tile.
        byteOffset = calcInsertionPoint(ts(index).header, position)
        
        'Write the tile:
        Put #destNum, byteOffset, tileBlock
    
        'Now, we add the rest of the tiles to the set after this tile.
        
        For tileoffset = position To ts(index).header.tilesInSet
        
            'byteOffset = (tileOffset - 1) * 3072 + 7
            byteOffset = calcInsertionPoint(ts(index).header, tileoffset)
            
            Get #sourceNum, byteOffset, tileBlock
            Put #destNum, byteOffset + 3072, tileBlock
        
        Next tileoffset
        
        'Overwrite the header.
        ts(index).header.tilesInSet = ts(index).header.tilesInSet + 1
        Put #destNum, 1, ts(index).header
        
    'Done!
    Close #sourceNum
    Close #destNum
    
    'Overwrite the working file.
    ChDir (currentDir)
    Kill Source
    Name Destination As Source
    
    ts(index).selectedTileNum = position
    lblSelectedTile(index).Caption = "Selected tile: " & ts(index).selectedTileNum
    lblContains(index).Caption = "Contains: " & ts(index).header.tilesInSet & " tiles"
    
    Call drawTileset(index)
    Call drawTile(index)

End Sub

Private Sub moveTile(ByVal index As Integer, ByVal position As Integer): On Error Resume Next
'==============================================================================
'Moves the selected tile to the position given in its own tileset.
'Called by the drag-drop event and the move up / down buttons.
'==============================================================================

    Dim x As Integer, y As Integer, Source As String, Destination As String
    Dim byteOffset As Long, tileoffset As Long, direction As Long
    Dim sourceNum As Integer, destNum As Integer

    'If we're trying to move past the end of the set, put it on the end.
    If position > ts(index).header.tilesInSet Then position = ts(index).header.tilesInSet
    
    If position = ts(index).selectedTileNum Then Exit Sub   'Don't want to write the same tile.
    
    Source = projectPath & ts(index).workingFilename
    Destination = projectPath & tempTileset
    
    'First, we copy the working tileset into the temporary file.
    ChDir (currentDir)
    Call FileCopy(Source, Destination)
    
    sourceNum = FreeFile
    Open Source For Binary As #sourceNum
    
    destNum = FreeFile
    Open Destination For Binary As #destNum
    
        'Load the selected tile into the block from the source.
        byteOffset = calcInsertionPoint(ts(index).header, ts(index).selectedTileNum)
        
        Get #sourceNum, byteOffset, tileBlock
        
        'Calculate the byte position to insert the tile.
        byteOffset = calcInsertionPoint(ts(index).header, position)
        
        'Write the tile:
        Put #destNum, byteOffset, tileBlock
        
        'Now, shift the position of the intermediate tiles.
        'If we're moving up, we can use a standard incremental for-loop.
        'If we're moving down, we need to shift the tiles *up*.
        'direction will equal 1 or -1
        direction = Sgn(ts(index).selectedTileNum - position)
        
        For tileoffset = position To ts(index).selectedTileNum - direction Step direction
        
            byteOffset = calcInsertionPoint(ts(index).header, tileoffset)
        
            Get #sourceNum, byteOffset, tileBlock
            Put #destNum, byteOffset + 3072 * direction, tileBlock
            
        Next tileoffset

    'Done!
    Close #sourceNum
    Close #destNum
    
    'Overwrite the working file.
    ChDir (currentDir)
    Kill Source
    Name Destination As Source
    
    ts(index).selectedTileNum = position
    lblSelectedTile(index).Caption = "Selected tile: " & ts(index).selectedTileNum
    
    Call drawTileset(index)

End Sub

Private Sub createSet(ByVal index As Integer): On Error Resume Next
'==============================================================================
'Creates a new tileset when a tile is dragged or inserted into a blank window.
'New set takes the information of the origin set.
'==============================================================================

    Dim Source As String, sourceNum As Integer
    
    'Set up the information for the set.
    With ts(index)
    
        .filename = "untitled"
    
        .header.detail = ts(Abs(index - 1)).header.detail
        .header.version = ts(Abs(index - 1)).header.version
        .header.tilesInSet = 0
        .tileFormat = ts(Abs(index - 1)).tileFormat
        If .tileFormat = ISOTYPE Then
            .workingFilename = "_" & CStr(index) & "_.iso"
        Else
            .workingFilename = "_" & CStr(index) & "_.tst"
        End If
        .requireSave = True
    End With
    
    'Write the header to file.
    ChDir (currentDir)
    Source = projectPath & ts(index).workingFilename
    
    sourceNum = FreeFile
    Open Source For Binary Access Write As #sourceNum
    
        Put #sourceNum, 1, ts(index).header
    
    Close #sourceNum
    
    'Captions:
    lblTileset(index).Caption = "Tileset: New"
    lblFormat(index).Caption = lblFormat(Abs(index - 1)).Caption
    
    'Buttons:
    cmdMoveUp(index).Enabled = True
    cmdMoveDown(index).Enabled = True
    cmdDelete(index).Enabled = True
    
    chkIso(index).value = chkIso(Abs(index - 1)).value
    chkIso(index).Enabled = chkIso(Abs(index - 1)).Enabled
    
End Sub

Private Sub clearInfo(ByVal index As Integer): On Error Resume Next
'==============================================================================
'Clear the tileset information.
'==============================================================================

    Dim x As Integer, y As Integer

    ts(index).filename = vbNullString
    ts(index).grid = False
    ts(index).header.detail = 0
    ts(index).header.tilesInSet = 0
    ts(index).header.version = -1
    ts(index).isometric = False
    ts(index).position = 0
    ts(index).requireSave = False
    For x = 0 To 64
        For y = 0 To 32
            ts(index).selectedTile(x, y) = 0
        Next y
    Next x
    ts(index).selectedTileNum = 0
    ts(index).tileFormat = 0
    ts(index).workingFilename = vbNullString
    
End Sub

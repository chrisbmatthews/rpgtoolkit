VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form grab 
   Caption         =   "Grab Tile"
   ClientHeight    =   6960
   ClientLeft      =   405
   ClientTop       =   435
   ClientWidth     =   9105
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
   Icon            =   "GRAB.frx":0000
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   6960
   ScaleWidth      =   9105
   Tag             =   "11"
   Begin VB.HScrollBar scrHorizontal 
      Height          =   255
      Left            =   120
      TabIndex        =   10
      TabStop         =   0   'False
      Top             =   5280
      Width           =   8655
   End
   Begin VB.VScrollBar scrVertical 
      Height          =   5175
      Left            =   8760
      TabIndex        =   9
      TabStop         =   0   'False
      Top             =   120
      Width           =   255
   End
   Begin VB.Frame grabFrame 
      Height          =   1335
      Left            =   120
      TabIndex        =   1
      Top             =   5520
      Width           =   8895
      Begin VB.CheckBox chkTrans 
         Height          =   375
         Left            =   840
         Picture         =   "GRAB.frx":0CCA
         Style           =   1  'Graphical
         TabIndex        =   21
         ToolTipText     =   "Get transparent color"
         Top             =   240
         Width           =   375
      End
      Begin VB.PictureBox picSelectColor 
         Height          =   200
         Left            =   3600
         ScaleHeight     =   135
         ScaleWidth      =   135
         TabIndex        =   19
         ToolTipText     =   "Click to select color"
         Top             =   750
         Width           =   200
      End
      Begin VB.PictureBox picGridColor 
         Height          =   200
         Left            =   2520
         ScaleHeight     =   135
         ScaleWidth      =   135
         TabIndex        =   18
         ToolTipText     =   "Click to select color"
         Top             =   750
         Width           =   200
      End
      Begin MSComctlLib.StatusBar grabStatus 
         Height          =   255
         Left            =   120
         TabIndex        =   17
         Top             =   960
         Width           =   8655
         _ExtentX        =   15266
         _ExtentY        =   450
         _Version        =   393216
         BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
            NumPanels       =   2
            BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
               Object.Width           =   3528
               MinWidth        =   3528
               Text            =   "Image: None"
               TextSave        =   "Image: None"
               Object.ToolTipText     =   "Loaded Image"
            EndProperty
            BeginProperty Panel2 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
               Object.Width           =   3528
               MinWidth        =   3528
               Text            =   "Selection:"
               TextSave        =   "Selection:"
               Object.ToolTipText     =   "Selection Co-ordinates"
            EndProperty
         EndProperty
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin MSComctlLib.ProgressBar batchProgress 
         Height          =   255
         Left            =   5520
         TabIndex        =   16
         ToolTipText     =   "Batch Grab Progress"
         Top             =   720
         Width           =   3255
         _ExtentX        =   5741
         _ExtentY        =   450
         _Version        =   393216
         Appearance      =   1
      End
      Begin VB.CommandButton cmdLoadTileEditor 
         Height          =   375
         Left            =   4920
         Picture         =   "GRAB.frx":0FD4
         Style           =   1  'Graphical
         TabIndex        =   15
         ToolTipText     =   "Edit Selected Tile In Tile Editor"
         Top             =   240
         Visible         =   0   'False
         Width           =   375
      End
      Begin VB.CheckBox chkOffset 
         Caption         =   "Grid offset"
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
         Left            =   2520
         TabIndex        =   14
         ToolTipText     =   "Offset the grid vertically by 16 pixels"
         Top             =   480
         Width           =   1095
      End
      Begin VB.CheckBox chkIgnore 
         Caption         =   "Ignore edge tiles"
         Enabled         =   0   'False
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
         Left            =   2520
         TabIndex        =   13
         ToolTipText     =   "Ignore the edge tiles on isometric grabs"
         Top             =   240
         Value           =   1  'Checked
         Width           =   1575
      End
      Begin VB.CheckBox chkIso 
         Height          =   375
         Left            =   480
         Picture         =   "GRAB.frx":1C9E
         Style           =   1  'Graphical
         TabIndex        =   12
         ToolTipText     =   "Set isometric mode"
         Top             =   600
         Width           =   375
      End
      Begin VB.CheckBox chkGrid 
         Height          =   375
         Left            =   120
         Picture         =   "GRAB.frx":2968
         Style           =   1  'Graphical
         TabIndex        =   11
         ToolTipText     =   "Draw gridlines"
         Top             =   600
         Width           =   375
      End
      Begin VB.CommandButton cmdBatch32 
         Caption         =   "Batch Grab 32x32"
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
         Left            =   5520
         TabIndex        =   7
         Top             =   240
         Width           =   1575
      End
      Begin VB.PictureBox picTrans 
         Height          =   375
         Left            =   840
         ScaleHeight     =   315
         ScaleWidth      =   315
         TabIndex        =   6
         ToolTipText     =   "Transparent color on the image"
         Top             =   600
         Width           =   375
      End
      Begin VB.CommandButton cmdReset 
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
         Left            =   480
         Picture         =   "GRAB.frx":3632
         Style           =   1  'Graphical
         TabIndex        =   5
         ToolTipText     =   "Reset grid and selection"
         Top             =   240
         Width           =   375
      End
      Begin VB.PictureBox picGrabbed 
         BackColor       =   &H80000005&
         Height          =   560
         Left            =   1320
         ScaleHeight     =   33
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   33
         TabIndex        =   4
         ToolTipText     =   "Tile preview"
         Top             =   360
         Width           =   560
      End
      Begin VB.CommandButton cmdOpen 
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
         Left            =   120
         Picture         =   "GRAB.frx":3EFC
         Style           =   1  'Graphical
         TabIndex        =   3
         ToolTipText     =   "Open graphic"
         Top             =   240
         Width           =   375
      End
      Begin VB.CommandButton cmdBatch16 
         Caption         =   "Batch Grab 16x16"
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
         Left            =   7080
         TabIndex        =   2
         Top             =   240
         Width           =   1695
      End
      Begin VB.Label lblSelectColor 
         Caption         =   "Selection color"
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
         Left            =   3840
         TabIndex        =   20
         Top             =   750
         Width           =   1215
      End
      Begin VB.Label lblGridColor 
         Caption         =   "Grid color"
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
         Left            =   2800
         TabIndex        =   8
         Top             =   750
         Width           =   735
      End
   End
   Begin VB.PictureBox grabForm 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   5175
      Left            =   120
      ScaleHeight     =   345
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   577
      TabIndex        =   0
      Top             =   120
      Width           =   8655
   End
End
Attribute VB_Name = "grab"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'=======================================================================
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'=======================================================================

'============================================
'Edited for 3.0.4 for new isometric tilesets.
'By Delano.
'
'The following subs have been renamed, removed or merged with others.
'
'   sizeup, emptyYN, cmdTrans_Click, cmdGrab_Click, Batch32Go, batch32, batch16, batch16Go
'
'Most subs are new - original code has been adapted or rewritten.

Option Explicit

'Added: Hold some information about the background image.
Private Type grabberImage
    filename As String
    pxWidth As Long         'Image size, from freeimage.dll.
    pxHeight As Long
    pxOffsetX As Long       'Pixel offset of the image (by scrolling).
    pxOffsetY As Long
    twipWidth As Single
    twipHeight As Single
    pointer As Long         'A pointer to the image, passed to freeimage.dll.
    loaded As Long        'Return upon closing the image in the dll.
End Type

'Added:
Private Type grabDoc
    gridOffsetX As Integer  'The pixel offsets of the grid.
    gridOffsetY As Integer
    mouseDownX As Single
    mouseDownY As Single
    drawSelection As Boolean 'Temporarily turn the selection box off whilst grabbing.
    gridColor As Long
    selectionColor As Long
    scrollX As Integer
    scrollY As Integer
    localDetail As Byte     ' 1 = for 32x32 or isometric, = 2 for 16x16.
    x1 As Integer
    x2 As Integer
    y1 As Integer
    y2 As Integer
    tile(64, 32) As Long
End Type

Private gridOffsetX As Integer     'The pixel offsets of the grid.
Private gridOffsetY As Integer
Private mouseDownX As Single
Private mouseDownY As Single
Private drawSelection As Boolean    'Temporarily turn the selection box off whilst grabbing.
Private gridColor As Long
Private selectionColor As Long
Private scrollX As Integer
Private scrollY As Integer

'Create the openImage object.
Private openImage As grabberImage
 

Public Function formType() As Long: On Error Resume Next
'======================
' Identify type of form
'======================
    formType = FT_GRAB
End Function


Private Sub BatchStandard(ByVal filename As String, ByVal level As Byte)
'======================================
'New - create standard 32x32 or 16x16
'2D tiles, and save into a tileset.
'16x16 tiles *should* work. [level = 2]
'32x32 tiles are the default [level= 1]
'======================================
    On Error GoTo ErrorHandler
    
    Dim tileNumber As Integer, setType As Integer, setTileNo As Integer, tileCount As Integer
    Dim tileWidth As Integer, tileHeight As Integer, tileMax As Integer
    Dim xTile As Integer, yTile As Integer
    Dim xPixel As Integer, yPixel As Integer
    Dim x As Integer, y As Integer
    Dim foundPixel As Boolean
    Dim selection As RECT
    
    'Set up the area for grabbing.
    If openTileEditorDocs(activeTile.indice).grabx1 <> -1 And openTileEditorDocs(activeTile.indice).grabx2 <> -1 Then
    
        selection.Left = openTileEditorDocs(activeTile.indice).grabx1                       'Pixel points.
        selection.Top = openTileEditorDocs(activeTile.indice).graby1
        selection.Right = openTileEditorDocs(activeTile.indice).grabx2
        selection.Bottom = openTileEditorDocs(activeTile.indice).graby2
        
        grabStatus.Panels(2).Text = "Selection: "
        
    Else
        'Grab the whole image.
        
        selection.Left = 0                                      'Pixel points.
        selection.Top = 0
        selection.Right = openImage.pxWidth
        selection.Bottom = openImage.pxHeight
        
        'Increase the size of the form
        'grabForm.width = openImage.twipWidth
        'grabForm.height = openImage.twipHeight
        'Call Form_Resize
        
        grabStatus.Panels(2).Text = "Selection: Whole image: "
        
    End If
    
    'level divider sets the size to 16 or 32, depending on save type.
    tileWidth = Int((selection.Right - selection.Left) / (32 / level))
    tileHeight = Int((selection.Bottom - selection.Top) / (32 / level))
    
    'If we can't make a tile from what we've got, exit.
    If tileWidth < 1 Or tileHeight < 1 Then Exit Sub
    
    
    'Maximum number of tiles we could grab - some might be empty though.
    tileMax = tileWidth * tileHeight
    tileNumber = 0              'Start the count.
    tileCount = 0               'Count for the progress bar.
    
    'Assign the *Global* detail level for saving:
    detail = level
    
    grabStatus.Panels(2).Text = grabStatus.Panels(2).Text & tileWidth & " x " & tileHeight & " = " & tileMax & " Tiles"
    
    For yTile = 1 To tileHeight
        For xTile = 1 To tileWidth
            'Loop row by row.
            tileCount = tileCount + 1
     
            DoEvents        'Big images can slow down...
           
            'Clear the tile memory.
            For x = 0 To 64
                For y = 0 To 32
                    tileMem(x, y) = -1
                Next y
            Next x
            
            'Calculate the pixel co-ordinates of this tile.
            xPixel = (xTile - 1) * (32 / level) + selection.Left
            yPixel = (yTile - 1) * (32 / level) + selection.Top
            foundPixel = False
            
            For x = 1 To (32 / level)
                For y = 1 To (32 / level)
                
                    'Check the pixel is in the form range.
                    'If xPixel + x - 1 <= selection.Right And xPixel + x - 1 >= selection.Left And _
                    '    yPixel + y - 1 <= selection.Bottom And yPixel + y - 1 >= selection.Top Then
                        
                        'Take the pixel from the canvas.
                        'tilemem(x, y) = vbFrmPoint(grabForm, xPixel + x - 1, yPixel + y - 1)
                        tileMem(x, y) = CanvasGetPixel(openImage.pointer, scrHorizontal.value * 32 + xPixel + x - 1, scrVertical.value * 32 + yPixel + y - 1)
                        
                    'End If
                    
                    'Set the transparent colour.
                    If tileMem(x, y) = openTileEditorDocs(activeTile.indice).transpcolor Then
                        tileMem(x, y) = -1
                    ElseIf tileMem(x, y) <> grabForm.BackColor Then
                        'We have a pixel - this tile isn't empty.
                        foundPixel = True
                    End If
                Next y
            Next x
            
            'Saving...
            
            If foundPixel Then
                'This tile isn't empty.
                tileNumber = tileNumber + 1
                
                setType = tilesetInfo(filename$)
                
                If tileNumber = 1 And setType = 1 Then
                    'Check if the tileset exists, if not create it.
                    
                    setTileNo = createNewTileSet(filename$)
                    
                    If setTileNo <> 1 Then
                        MsgBox "Error creating new tileset."
                        Exit Sub
                    End If

                Else
                    'Tileset exists.
                    
                    setTileNo = addToTileSet(filename$)
                    
                    If setTileNo < 1 Then
                        MsgBox "Error adding tile to tileset."
                        Exit Sub
                    End If
                End If
                                     

            End If 'foundPixel.
            
            batchProgress.value = (tileCount / (tileHeight * tileWidth)) * 100
            
        Next xTile
    Next yTile
    
    MsgBox "Done. " & tileNumber & " tiles added to " & filename$

    Exit Sub
    
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub BatchIsometric(ByVal filename As String)
'===================================
'New - create 64x32 isometric tiles,
'and save into .iso tileset.
'===================================
    On Error GoTo ErrorHandler
    
    Dim tileNumber As Integer, setType As Integer, setTileNo As Integer, tileCount As Integer
    Dim tileWidth As Integer, tileHeight As Integer, tileMax As Integer
    Dim rowOffset As Byte, longRow As Integer, shortRow As Integer
    Dim xTile As Integer, yTile As Integer
    Dim xPixel As Integer, yPixel As Integer
    Dim x As Integer, y As Integer
    Dim foundPixel As Boolean, grabImage As Boolean
    Dim edges As RECT, selection As RECT

    'Set up the area for grabbing.
    If openTileEditorDocs(activeTile.indice).grabx1 <> -1 And openTileEditorDocs(activeTile.indice).grabx2 <> -1 Then
        
        selection.Left = openTileEditorDocs(activeTile.indice).grabx1                       'Pixel points.
        selection.Top = openTileEditorDocs(activeTile.indice).graby1
        selection.Right = openTileEditorDocs(activeTile.indice).grabx2
        selection.Bottom = openTileEditorDocs(activeTile.indice).graby2
        
        grabStatus.Panels(2).Text = "Selection: "
        
        grabImage = False
        
    Else
        'Grab the whole image.
        
        selection.Left = 0                                      'Pixel points.
        selection.Top = 0
        selection.Right = openImage.pxWidth
        selection.Bottom = openImage.pxHeight
        
        'Increase the size of the form
        grabForm.Width = openImage.twipWidth
        grabForm.height = openImage.twipHeight
        Call Form_Resize
        
        grabStatus.Panels(2).Text = "Selection: Whole image: "
        
        grabImage = True
       
    End If
    
    'Use these later:
    edges = selection
    
    rowOffset = 0
    If grabImage Then rowOffset = Abs(chkOffset.value - 1)
    
    If chkIgnore.value = 0 Then
        'Take edges into account: Add two extra tiles in each direction.
        selection.Left = selection.Left - 32
        selection.Top = selection.Top - 16
        selection.Right = selection.Right + 32
        selection.Bottom = selection.Bottom + 16
    End If

    'This is the total width, considering both "rows"
    tileWidth = Int((selection.Right - selection.Left - 32) / 32)
    tileHeight = Int((selection.Bottom - selection.Top - 16) / 16)
    
    'Maximum number of tiles we could grab - some might be empty though.
    tileMax = 0 - Int((tileWidth * tileHeight) / -2)    'For isometrics.
    tileNumber = 0                                      'Start the count.
    tileCount = 0                                       'Count for the progress bar.
 
    'shortRow will either equal longRow or longRow - 1
    longRow = Int((selection.Right - selection.Left) / 64)
    shortRow = Int((selection.Right - selection.Left - 32) / 64)
    
    'If we can't make a tile from what we've got, exit.
    If tileWidth < 1 Or tileHeight < 1 Then Exit Sub
    
    
    grabStatus.Panels(2).Text = grabStatus.Panels(2).Text & tileWidth & " x " & tileHeight & " = " & tileMax & " Tiles"
    
    For yTile = 1 To tileHeight             'This loops over a single column.
        For xTile = 1 To longRow            'Over a single row.
            'Loop row by row.
            tileCount = tileCount + 1
            
            DoEvents
            
            'Clear the tile memory.
            For x = 0 To 64
                For y = 0 To 32
                    tileMem(x, y) = -1
                Next y
            Next x
            
            'Calculate the pixel co-ordinates of this tile.
            xPixel = (xTile - 1) * 64 + selection.Left
            xPixel = xPixel + (((yTile - 1 + rowOffset) Mod 2) * 32)     'Add the row offset.
                      
            'No offset needed for y.
            yPixel = (yTile - 1) * 16 + selection.Top
            
'Call traceString("yTile=" & yTile & " xTile=" & xTile & " xPixel=" & xPixel & " yPixel=" & yPixel)
            
            foundPixel = False
            
            For x = 1 To 64
                For y = 1 To 32
                
                    'Check the pixel is in the form range.
                    If xPixel + x - 1 <= edges.Right And xPixel + x - 1 >= edges.Left And _
                        yPixel + y - 1 <= edges.Bottom And yPixel + y - 1 >= edges.Top Then
                        'Take the pixel from the canvas.
                        'tilemem(x, y) = vbFrmPoint(grabForm, xPixel + x - 1, yPixel + y - 1)
                        tileMem(x, y) = CanvasGetPixel(openImage.pointer, scrHorizontal.value * 32 + xPixel + x - 1, scrVertical.value * 32 + yPixel + y - 1)

'Call traceString("tilemem(" & x & ", " & y & ") = vbFrmPoint(grabForm," & (xPixel + x - 1) & ", " & (yPixel + y - 1) & ") xPixel=" & xPixel & " yPixel=" & yPixel)
                        
                    End If
                        
                    'Set the transparent colour.
                    If tileMem(x, y) = openTileEditorDocs(activeTile.indice).transpcolor Then
                        tileMem(x, y) = -1
                    ElseIf tileMem(x, y) <> grabForm.BackColor Then
                        'We have a pixel - this tile isn't empty.
                        foundPixel = True
                    End If
                    
                Next y
            Next x
            
            'Saving...
            
            'If this is a mismatched row, it will not be saved.
            If yTile Mod 2 = 0 And (xTile > shortRow) Then foundPixel = False
            
            If foundPixel Then
                'This tile isn't empty.
                tileNumber = tileNumber + 1
                
                setType = tilesetInfo(filename$)
                
                If tileNumber = 1 And setType = 1 Then
                    'Check if the tileset exists, if not create it.
                    
                    setTileNo = createNewTileSet(filename$, True)
                    
                    If setTileNo <> 1 Then
                        MsgBox "Error creating new tileset."
                        Exit Sub
                    End If

                ElseIf setType = ISOTYPE Then
                    'Isometric tileset exists.
                    
                    setTileNo = addToTileSet(filename$)
                    
                    If setTileNo < 1 Then
                        MsgBox "Error adding tile to tileset."
                        Exit Sub
                    End If
                End If
                                     
            End If 'foundPixel.
            
            'batchProgress.value = (tileNumber / tileMax) * 100
            batchProgress.value = (tileCount / (tileHeight * longRow)) * 100
            
        Next xTile
    Next yTile
    
MsgBox "Done. " & tileNumber & " tiles added to " & filename$

    Exit Sub
    
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
    
    
End Sub


Private Sub chkGrid_Click(): On Error Resume Next
'==========================
'Grid check button
'==========================

    Call grabRedraw

End Sub

Private Sub chkIgnore_Click(): On Error Resume Next
'============================
'Ignore the edge tiles if the image is isometric.
'============================
End Sub

Private Sub chkIso_Click(): On Error Resume Next
'=========================
'Isometric check button
'========================

    Call grabRedraw
    
    Call activeTile.isoChange(chkIso.value)
    
    chkIgnore.Enabled = chkIso.value            'Enable the ignore feature for isometric boards.
    cmdBatch16.Enabled = Abs(chkIso.value - 1)  'Disable the batch 16x16 button.
    
    'Clear the grab data.
    Call cmdReset_Click
    
    If chkIso.value = 1 Then
        cmdBatch32.Caption = "Batch Isometric"
        picGrabbed.Width = 66 * Screen.TwipsPerPixelX       'Tile preview window.
    Else
        cmdBatch32.Caption = "Batch Grab 32x32"
        picGrabbed.Width = 33 * Screen.TwipsPerPixelX
    End If
    
End Sub

Private Sub chkOffset_Click(): On Error Resume Next
'=============================
'Grid offset - shift the grid.
'=============================

    gridOffsetY = chkOffset.value * 16

    Call grabRedraw

End Sub

Private Sub chkTrans_Click(): On Error Resume Next
'============================
'Get transparent color click.
'Altered from command button to check button.
'============================
    
    If chkTrans.value = 1 Then
        MsgBox LoadStringLoc(970, "Click on the image to select a color for transparency")
    End If

End Sub



Private Sub cmdLoadTileEditor_Click(): On Error Resume Next
'============================================
'If a selection is made, run the tile editor.
'Hidden for the moment, since it runs *from*
'the tile editor.
'============================================

    Dim loadTile As Form
    
    'If we have a selection
    If openTileEditorDocs(activeTile.indice).grabx1 <> -1 And openTileEditorDocs(activeTile.indice).grabx2 <> -1 Then
     
        Set loadTile = New tileedit
        loadTile.Show
        
    Else
        MsgBox "Please select a tile first"
    End If

End Sub

Private Sub Form_Unload(Cancel As Integer): On Error Resume Next
'=========================================
'Delete the image canvas!
'=========================================

    Call DestroyCanvas(openImage.pointer)

End Sub

Private Sub picGridColor_Click(): On Error Resume Next
'======================================
'Set the colour of the grid by clicking
'the picture box.
'======================================
    
    Dim color As Long
    'Get the colour from the standard colour dialog.
    color = ColorDialog()
    
    'Do not assign if cancel pressed.
    If color <> -1 Then gridColor = color
    
    picGridColor.BackColor = gridColor
    Call grabRedraw
    
End Sub

Private Sub picSelectColor_Click(): On Error Resume Next
'======================================
'Set the colour of the grid by clicking
'the picture box.
'======================================
    
    Dim color As Long
    'Get the colour from the standard colour dialog.
    color = ColorDialog()
    
    'Do not assign if cancel pressed.
    If color <> -1 Then selectionColor = color
    
    picSelectColor.BackColor = selectionColor
    Call grabRedraw
    
End Sub

Private Sub picTrans_Click(): On Error Resume Next
'=============================================
'Set the transparent colour from a dialog box.
'=============================================
    
    Dim color As Long
    'Get the colour from the standard colour dialog.
    color = ColorDialog()
    
    'Do not assign if cancel pressed.
    If color <> -1 Then openTileEditorDocs(activeTile.indice).transpcolor = color
    
    picTrans.BackColor = openTileEditorDocs(activeTile.indice).transpcolor
    Call grabRedraw
End Sub

Private Sub cmdOpen_Click(): On Error Resume Next
'=====================================
'Open graphic.
'=====================================
    Dim antiPath As String, thextention As String
    
    ChDir (currentDir$)
    
    'Setup file info object.
    Dim dlg As FileDialogInfo
    dlg.strTitle = "Open Graphic"
    dlg.strDefaultExt = "bmp"
    dlg.strFileTypes = strFileDialogFilterGfx
    dlg.strDefaultFolder = projectPath$ + bmpPath$
    
    'Get the name and path of the selected graphic as chosen in the dialog window.
    If OpenFileDialog(dlg, Me.hwnd) Then
        filename$(1) = dlg.strSelectedFile
        antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub  'user pressed cancel
    End If
    
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    thextention$ = extention(filename$(1))
    
    'Set the image in the grabform.
    
    'Added: Get some information about the image.
    With openImage
        .filename$ = filename$(1)
    
        'Create a canvas to hold the image
        .pointer = CreateCanvas(1, 1)
        Call CanvasLoadFullPicture(.pointer, .filename$, -1, -1)
        
        .pxWidth = GetCanvasWidth(.pointer)
        .pxHeight = GetCanvasHeight(.pointer)
              
        .twipWidth = openImage.pxWidth * Screen.TwipsPerPixelX
        .twipHeight = openImage.pxHeight * Screen.TwipsPerPixelY
        
        If .pxWidth = 0 And .pxHeight = 0 Then
            Call DestroyCanvas(.pointer)
            Exit Sub
        End If
        .loaded = 1
    End With
    
    'Set the image info in the status bar:
    grabStatus.Panels(1).Text = "Image: " & antiPath$ & " = " & openImage.pxWidth & "x" & openImage.pxHeight
    grab.Caption = "Grab Tiles (" + antiPath$ + ")"
    
    Call vbPicAutoRedraw(grab.grabForm, True)
    Call DrawImage(filename$(1), 0, 0, vbPicHDC(grab.grabForm))
    Call vbPicRefresh(grab.grabForm)
    ChDir (currentDir$)
    
    
    Call Form_Resize
    
    
End Sub


Private Sub cmdReset_Click(): On Error Resume Next
'==============================
'Reset grabber and grid.
'==============================
    
    openTileEditorDocs(activeTile.indice).grabx1 = -1: openTileEditorDocs(activeTile.indice).grabx2 = -1
    openTileEditorDocs(activeTile.indice).graby1 = -1: openTileEditorDocs(activeTile.indice).graby2 = -1
    
    gridOffsetX = 0
    gridOffsetY = chkOffset.value * 16
    
    Call grabRedraw
    
    'Clear the preview box:
    picGrabbed.Picture = LoadPicture("")

End Sub

Private Sub cmdBatch32_Click()
'==================================
'Batch Import 32x32 or isometric.
'==================================
    On Error GoTo ErrorHandler
    
    Dim user As VbMsgBoxResult
    Dim tiles As String, selection As String
    
    If openImage.loaded = 0 Then Exit Sub   'No image loaded.
    
    tiles$ = "32x32"
    If chkIso.value = 1 Then tiles$ = "64x32 isometric"
    
    selection$ = "selection"
    If openTileEditorDocs(activeTile.indice).grabx1 = -1 And openTileEditorDocs(activeTile.indice).grabx2 = -1 Then selection$ = "whole image"
    
    user = MsgBox("This will convert the " & selection & " into " & tiles & " tiles and place in a tileset.", 65)
        
    'Run the routine for both isometric and 2D tiles.
    If user <> vbOK Then Exit Sub
    
    'batch32 moved to here - altered!
    
    ChDir (currentDir$)
    
    'Setup the filetype info object for saving the tiles.
    'Changed the default to tst - now saving into tilesets only.
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + tilePath$
    dlg.strTitle = "Save Into Tileset"
    
    If chkIso.value = 1 Then
        'Saving as isometric.
        dlg.strDefaultExt = "iso"
        dlg.strFileTypes = "RPG Toolkit Isometric Tileset (*.iso)|*.iso|All files(*.*)|*.*"
    Else
        'Saving as 2D .tst
        dlg.strDefaultExt = "tst"
        dlg.strFileTypes = "RPG Toolkit Tileset (*.tst)|*.tst|All files(*.*)|*.*"
    End If
    
    'Get the name and path of the file to save to.
    If SaveFileDialog(dlg, Me.hwnd) Then
        filename$(1) = dlg.strSelectedFile
        'antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub        'User pressed cancel.
    End If
    
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    
    'Clear the grid.
    'chkGrid.value = 0
    'drawSelection = False
    'Call grabRedraw
    'drawSelection = True
    
    batchProgress.value = 0                 'Reset the progress bar.
    
    If chkIso.value = 1 Then
        Call BatchIsometric(filename$(1))
    Else
        'BatchStandard used for 32x32 and 16x16 : 1 is the detail level for 32x32.
        Call BatchStandard(filename$(1), 1)
    End If

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub cmdBatch16_Click()
'==================================
'Batch Import 16x16
'==================================
    On Error GoTo ErrorHandler
    
    Dim user As VbMsgBoxResult, selection As String
    
    If openImage.loaded = 0 Then Exit Sub   'No image loaded.
    
    selection$ = "selection"
    If openTileEditorDocs(activeTile.indice).grabx1 = -1 And openTileEditorDocs(activeTile.indice).grabx2 = -1 Then selection$ = "whole image"
    
    user = MsgBox("This will convert the " & selection & " into 16x16 tiles and place in a tileset.", 65)
        
    'Run the routine for both isometric and 2D tiles.
    If user <> vbOK Then Exit Sub
    
    'batch16 moved to here - altered!

    ChDir (currentDir$)
    
    'Setup the filetype info object for saving the tiles.
    'Changed the default to tst - now saving into tilesets only.
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = projectPath$ + tilePath$
    dlg.strTitle = "Save Into Tileset"
    dlg.strDefaultExt = "tst"
    dlg.strFileTypes = "RPG Toolkit Tileset (*.tst)|*.tst|All files(*.*)|*.*"
    
    'Get the name and path of the file to save to.
    If SaveFileDialog(dlg, Me.hwnd) Then
        filename$(1) = dlg.strSelectedFile
        'antiPath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub        'User pressed cancel.
    End If
    
    ChDir (currentDir$)
    If filename$(1) = "" Then Exit Sub
    
    'Clear the grid.
    'chkGrid.value = 0
    'drawSelection = False
    'Call grabRedraw
    'drawSelection = True
    
    batchProgress.value = 0                 'Reset the progress bar.
    
    'BatchStandard used for 32x32 and 16x16 : 2 is the detail level for 16x16.
    Call BatchStandard(filename$(1), 2)
    
    Exit Sub
    
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub


Private Sub Form_Activate(): On Error GoTo ErrorHandler
'=============================
'Added: grabber is an MDIChild
'Adapted from tileedit.
'=============================
    
    
    Dim x As Integer, y As Integer
    
    Set activeForm = Me
    
    scrVertical.value = scrollY
    scrHorizontal.value = scrollX
    Call grabRedraw                 'And tile
    
     
    'extras
    tkMainForm.animationExtras.Visible = False
    tkMainForm.bottomFrame.Visible = False
    tkMainForm.tileExtras.Visible = False
    'tkMainForm.boardExtras.Visible = False
    tkMainForm.tileBmpExtras.Visible = False

    'tools
    tkMainForm.tilebmpTools.Visible = False
    tkMainForm.animationTools.Visible = False
    tkMainForm.rpgcodeTools.Visible = False
    tkMainForm.tileTools.Visible = False
    tkMainForm.boardTools.Visible = False

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Form_Deactivate(): On Error Resume Next
'============================
'Upon activating another form.
'============================

    Dim x As Integer, y As Integer
    'theData = openTileEditorDocs(activeTile.indice)
    
    For x = 0 To 64
        For y = 0 To 32
            openTileEditorDocs(activeTile.indice).tileMem(x, y) = tileMem(x, y)
        Next y
    Next x
    
    
End Sub

Private Sub Form_Load(): On Error GoTo ErrorHandler
    '=========================
    'Grabber entry point.
    '=========================
    
    
    Call LocalizeForm(Me)
    grab.tag = 1608         'Assign a name for the editor bar.
    grab.Caption = "Grab Tile (No image)"
    
    gridOffsetX = 0
    gridOffsetY = 0
    drawSelection = True    'The selection box.
    
    scrollX = 0: scrollY = 0
    
    gridColor = vbQBColor(1)
    selectionColor = vbQBColor(9)
    picGridColor.BackColor = gridColor
    picSelectColor.BackColor = selectionColor
    
    grab.Left = (Screen.Width - grab.Width) / 2
    grab.Top = (Screen.height - grab.height) / 2
    
    openImage.loaded = 0              'Set the background image to unloaded.
    Call Form_Resize
    
    scrHorizontal.value = 0
    scrVertical.value = 0
      
    'Clear the grabber settings in the general tile.
    openTileEditorDocs(activeTile.indice).transpcolor = -1
    openTileEditorDocs(activeTile.indice).grabx1 = -1: openTileEditorDocs(activeTile.indice).grabx2 = -1
    openTileEditorDocs(activeTile.indice).graby1 = -1: openTileEditorDocs(activeTile.indice).graby2 = -1
    
    grabStatus.Panels(1).Width = grabStatus.Width / 2
    grabStatus.Panels(2).Width = grabStatus.Width / 2
    
    'Welcome message.
    
    MsgBox "Welcome to the new look tile grabber, which allows you to grab both 2D and " _
        & "isometric tiles and save them straight into tilesets." _
        & chr$(13) & chr$(13) _
        & "  A left click selects a tile that is aligned to the grid." & chr$(13) _
        & "  A right click selects a tile at that position and aligns the grid to the tile." & chr$(13) _
        & "  A left drag creates a selection that is aligned to the grid." & chr$(13) _
        & "  A right drag creates a selection at that position and aligns the grid to the selection." & chr$(13) _
        & chr$(13) _
        & "To grab the whole image, clear the selection and hit the Batch button." _
        & chr$(13) & chr$(13) _
        & "To change the color of the grid, selection or transparent color click the corresponding color box and " _
        & "a color dialog window will appear. You can also click the dropper button and choose a color from the image." _
        & chr$(13) & chr$(13) _
        & "The ""Ignore Edge Tiles"" check box ignores the tiles around the edge of a square selection in isometric mode." & chr$(13) _
        & "The ""Grid Offset"" check box vertically offsets the grid by 16 pixels - this can be useful for isometric grabbing." _
        & chr$(13) & chr$(13) _
        & "If you encounter any problems please report them on the forums at http://www.rpgtoolkit.com"
   
    Exit Sub
    
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub



Private Sub Form_Resize(): On Error Resume Next
'========================
'Added.
'========================

    Dim tileWidth As Single, tileHeight As Single

    'Deactivate the redraw whilst we resize.
    Call vbPicAutoRedraw(grabForm, False)
    grab.AutoRedraw = False
    
    'Set the minimum window size.
    If grab.Width < 9000 Then grab.Width = 9000
    If grab.height < 6400 Then grab.height = 6400
    
    'Size the grabForm picture box.
    'The vertical edges of the grabber are 120 twips. The horizontal edges total 510 twips.
    grabForm.Top = 120         'Aligned to top-left corner always.
    grabForm.Left = 120
    grabForm.Width = grab.Width - (3 * 120)
    grabForm.height = grab.height - grabFrame.height - 510 - 120
    
    'Centre the toolFrame, align to the bottom:
    grabFrame.Top = grabForm.height + grabForm.Top
    grabFrame.Left = (grab.Width - grabFrame.Width) / 2
    
    scrVertical.Visible = False
    scrHorizontal.Visible = False
    
    If openImage.loaded Then
        'If an image has been loaded and successfully unloaded (will equal 1).
        
        If openImage.twipWidth <= grabForm.Width Then
            grabForm.Width = openImage.twipWidth
        Else
            'Image is wider than grabform.
            'Enable the horziontal scroll.
            scrHorizontal.Visible = True
            grabForm.height = grabForm.height - scrHorizontal.height
            
            grabForm.Width = (Int(grabForm.Width / (Screen.TwipsPerPixelX * 32))) * 32 * Screen.TwipsPerPixelX
        End If
        
        If openImage.twipHeight <= grabForm.height Then
            grabForm.height = openImage.twipHeight
            grabForm.Top = (grab.height - grabForm.height) / 2
        Else
            'Image is taller than grabform.
            'Enable the vertical scroll.
            scrVertical.Visible = True
            grabForm.Width = grabForm.Width - scrVertical.Width
            
            If openImage.twipWidth > grabForm.Width Then
                grabForm.Width = (Int(grabForm.Width / (Screen.TwipsPerPixelX * 32))) * 32 * Screen.TwipsPerPixelX
            End If
            
            grabForm.height = (Int(grabForm.height / (Screen.TwipsPerPixelY * 32))) * 32 * Screen.TwipsPerPixelY
        End If
        
        grabForm.Left = (grab.Width - grabForm.Width) / 2
    End If
              
    'Align the scroll bars:
    scrVertical.Top = grabForm.Top
    scrVertical.Left = grabForm.Width + grabForm.Left
    scrVertical.height = grabForm.height
    scrHorizontal.Top = grabForm.height + grabForm.Top
    scrHorizontal.Left = grabForm.Left
    scrHorizontal.Width = grabForm.Width
    
    'This will scroll in tile units (32x32).
    scrHorizontal.max = (openImage.twipWidth - grabForm.Width) / (Screen.TwipsPerPixelX * 32)
    scrVertical.max = (openImage.twipHeight - grabForm.height) / (Screen.TwipsPerPixelY * 32)
    scrHorizontal.LargeChange = grabForm.Width / (Screen.TwipsPerPixelX * 32) - 1
    scrVertical.LargeChange = grabForm.height / (Screen.TwipsPerPixelY * 32) - 1
    'scrHorizontal.value = 0
    'scrVertical.value = 0
    
    Call vbPicAutoRedraw(grabForm, True)
    grab.AutoRedraw = False
    Call grabRedraw                     'Redraw the image.

End Sub

Private Sub grabform_MouseDown(button As Integer, Shift As Integer, x As Single, y As Single)
'========================================
'MouseDown on the image.
'Action depends on the settings.
'========================================
'Functionality altered: old sub below.
'A single left-mouse click selects a single tile on the grid.
'A single right-mouse click selects a tile at the point clicked and aligns the grid.
'A left-click drag draws the selection box, aligned to the grid.
'A right-click drag draws the selection box unaligned.
On Error GoTo ErrorHandler

    Dim xTile As Integer, yTile As Integer, dx As Integer, dy As Integer
    Dim maskX As Byte, maskY As Byte
    
    If chkTrans.value = 1 Then
        'Firstly used to set transparent colour if "Get Transparent Color" was pressed.
        '"Get Transparent Color" has been changed to a check button, and given a picture
        'label, the eye dropper.
   
        'Get the pixel value at the clicked point.
        openTileEditorDocs(activeTile.indice).transpcolor = vbFrmPoint(grab.grabForm, x, y)
        
        'Set the transparent colour in the preview window.
        If openTileEditorDocs(activeTile.indice).transpcolor <> -1 Then
            picTrans.BackColor = openTileEditorDocs(activeTile.indice).transpcolor
        Else
            picTrans.BackColor = vbQBColor(15)      'White.
        End If
        
        Exit Sub
    End If
    
    'We are making a new selection, clear the old selection.
    openTileEditorDocs(activeTile.indice).grabx1 = -1: openTileEditorDocs(activeTile.indice).grabx2 = -1
    openTileEditorDocs(activeTile.indice).graby1 = -1: openTileEditorDocs(activeTile.indice).graby2 = -1

    mouseDownX = x: mouseDownY = y  'For use in mouseUp.
    
    If button = 1 Then
        'Left button.
        'All clicks are aligned to grid:
        'MouseDown selects the start co-ordinates.
        
        If chkIso.value = 0 Then
            '2D.
            'This sets x,y to top-left corner of the tile clicked.
            xTile = Int((x - gridOffsetX) / 32): openTileEditorDocs(activeTile.indice).grabx1 = xTile * 32 + gridOffsetX
            yTile = Int((y - gridOffsetY) / 32): openTileEditorDocs(activeTile.indice).graby1 = yTile * 32 + gridOffsetY
            
            'openTileEditorDocs(activeTile.indice).grabx1 = x - ((x - gridOffsetX) Mod 32) + gridOffsetX
            'openTileEditorDocs(activeTile.indice).graby1 = y - ((y - gridOffsetY) Mod 32) + gridOffsetY
            
            
        Else
            'Isometric.
            
            xTile = Int((x - 32 - gridOffsetX) / 64)
            yTile = Int((y - gridOffsetY) / 32)
            openTileEditorDocs(activeTile.indice).graby1 = yTile * 32 + gridOffsetY
            openTileEditorDocs(activeTile.indice).grabx1 = xTile * 64 + 32 + gridOffsetX
                        
            'openTileEditorDocs(activeTile.indice).grabx1 = x - ((x - 32 - gridOffsetX) Mod 64) + gridOffsetX + 32
            'openTileEditorDocs(activeTile.indice).graby1 = y - ((y - gridOffsetY) Mod 32) + gridOffsetY
            
            maskX = x - openTileEditorDocs(activeTile.indice).grabx1
            maskY = y - openTileEditorDocs(activeTile.indice).graby1
            
            'Some initial values for the correction.
            dx = 0: dy = 0
            
            'Compare the click to the mask. (1->64, 1->32)
            If isoMaskBmp(maskX + 1, maskY + 1) <> 0 Then
                'This pixel is on the masked off area, and
                'corresponds to a different tile.
                
                'Calculate the tile number corrections.
                dx = Int(maskX / 32): If dx = 0 Then dx = -1
                dy = Int(maskY / 16): If dy = 0 Then dy = -1
                
            End If
            
            'Calculate the new start co-ordinates.
            openTileEditorDocs(activeTile.indice).grabx1 = openTileEditorDocs(activeTile.indice).grabx1 + dx * 32
            openTileEditorDocs(activeTile.indice).graby1 = openTileEditorDocs(activeTile.indice).graby1 + dy * 16
            
        End If 'chkIso.value
        
    ElseIf button = 2 Then
        'Right button.
        'Clicks are not aligned.
        'Align grid to click.
        
        'Align grid.
        If chkIso.value = 0 Then
            '2D.
            openTileEditorDocs(activeTile.indice).grabx1 = x: openTileEditorDocs(activeTile.indice).graby1 = y
            gridOffsetX = x Mod 32: gridOffsetY = y Mod 32
        Else
            'Isometric.
            'Y offset puts the left corner of the tile at the mouse-click.
            openTileEditorDocs(activeTile.indice).grabx1 = x: openTileEditorDocs(activeTile.indice).graby1 = y - 16
            gridOffsetX = x Mod 64: gridOffsetY = y Mod 32
        End If
        
    End If 'Button
        
    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub grabform_MouseMove(button As Integer, Shift As Integer, x As Single, y As Single)
'================================
'MouseMove on the image: draws the selection square.
'================================
'Rewritten - real-time selection square drawn.
'Left-click-drag draws a tiled selection aligned to the grid.
'Right-click-drag draws a tiled selection at the click.

    On Error GoTo ErrorHandler
    Dim offsetX As Integer, offsetY As Integer, dragX As Integer, dragY As Integer
    Dim tileX As Integer, tileY As Integer, tileMax As Integer
    
    'Exit if no button is held or we're getting the transparent colour.
    If chkTrans.value = 1 Or button = 0 Then Exit Sub
    
    'If we're dragging off-screen, scroll the form. Edit out for the moment.
    'If x * Screen.TwipsPerPixelX > grabForm.width Then: scrHorizontal.value = scrHorizontal.value + 1: Call scrHorizontal_Change
    'If x * Screen.TwipsPerPixelX < 0 Then: scrHorizontal.value = scrHorizontal.value - 1: Call scrHorizontal_Change
    'If y * Screen.TwipsPerPixelY > grabForm.height Then: scrVertical.value = scrVertical.value + 1: Call scrVertical_Change
    'If y * Screen.TwipsPerPixelY < 0 Then: scrVertical.value = scrVertical.value - 1: Call scrVertical_Change
   
    If button = 1 Then
        'Left click-drag.
        'Draw a selection aligned to the grid.
        
        dragX = openTileEditorDocs(activeTile.indice).grabx1: dragY = openTileEditorDocs(activeTile.indice).graby1
        
    ElseIf button = 2 Then
        'Right-click drag.
        'Draw a selection at the position.
        
        dragX = mouseDownX: dragY = mouseDownY
        
    End If
    
    'Same code for both clicks.
        
    offsetX = x - dragX
    offsetY = y - dragY
    
    'Sgn returns the sign of the number. Addition keeps mouse inside selection.
    If chkIso.value = 0 Then
        x = x - (offsetX Mod 32) + (32 * Sgn(offsetX))
    Else
        x = x - (offsetX Mod 64) + (64 * Sgn(offsetX))
    End If
    y = y - (offsetY Mod 32) + (32 * Sgn(offsetY))
    
    Call vbPicRefresh(grabForm)
    Call vbPicAutoRedraw(grabForm, False)
    Call vbPicRect(grabForm, dragX, dragY, x, y, selectionColor)
    Call vbPicRect(grabForm, dragX - 1, dragY - 1, x + 1, y + 1, selectionColor)
    Call vbPicAutoRedraw(grabForm, True)
    
    openTileEditorDocs(activeTile.indice).grabx2 = x
    openTileEditorDocs(activeTile.indice).graby2 = y
    
    'Update the status bar.
    If chkIso.value = 0 Then
        tileX = Abs(x - dragX) / 32
        tileY = Abs(y - dragY) / 32
        tileMax = tileX * tileY
    Else
        tileX = Abs(x - dragX - 32) / 32
        tileY = Abs(y - dragY - 16) / 16
        tileMax = 0 - Int((tileX * tileY) / -2)
    End If
    
    grabStatus.Panels(2).Text = "Selection: " & dragX & ", " & dragY & " -> " & x & ", " & y & " = " _
        & tileX & "x" & tileY & " = " & tileMax & " Tiles"
    
    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

Private Sub grabForm_MouseUp(button As Integer, Shift As Integer, x As Single, y As Single)
'===========================
'MouseUp on the image.
'Sets the end of the grab.
'Added.
'===========================
    On Error GoTo ErrorHandler
    
    Dim tileX As Integer, tileY As Integer, tileMax As Integer
    
    'If choosing transparent colour, deselect the check button and exit.
    If chkTrans.value = 1 Then chkTrans.value = 0: Exit Sub
    
    'Check to see if a drag has changed the co-ordinates, if not, this is a single tile selection.
    If chkIso.value = 0 Then
        If openTileEditorDocs(activeTile.indice).grabx2 = -1 Or openTileEditorDocs(activeTile.indice).grabx2 = openTileEditorDocs(activeTile.indice).grabx1 Then
            openTileEditorDocs(activeTile.indice).grabx2 = openTileEditorDocs(activeTile.indice).grabx1 + 32
        End If
    Else
        'Isometric.
        If openTileEditorDocs(activeTile.indice).grabx2 = -1 Or openTileEditorDocs(activeTile.indice).grabx2 = openTileEditorDocs(activeTile.indice).grabx1 Then
            openTileEditorDocs(activeTile.indice).grabx2 = openTileEditorDocs(activeTile.indice).grabx1 + 64
        End If
    End If
    
    If openTileEditorDocs(activeTile.indice).graby2 = -1 Or openTileEditorDocs(activeTile.indice).graby2 = openTileEditorDocs(activeTile.indice).graby1 Then
        openTileEditorDocs(activeTile.indice).graby2 = openTileEditorDocs(activeTile.indice).graby1 + 32
    End If
    
    'Check the bottom-right corner is below the top-left, if not, invert.
    If openTileEditorDocs(activeTile.indice).grabx1 > openTileEditorDocs(activeTile.indice).grabx2 Then
        x = openTileEditorDocs(activeTile.indice).grabx1: openTileEditorDocs(activeTile.indice).grabx1 = openTileEditorDocs(activeTile.indice).grabx2: openTileEditorDocs(activeTile.indice).grabx2 = x
    End If
    If openTileEditorDocs(activeTile.indice).graby1 > openTileEditorDocs(activeTile.indice).graby2 Then
        y = openTileEditorDocs(activeTile.indice).graby1: openTileEditorDocs(activeTile.indice).graby1 = openTileEditorDocs(activeTile.indice).graby2: openTileEditorDocs(activeTile.indice).graby2 = y
    End If
    
    Call grabRedraw
    
    'Update the status bar.
    If chkIso.value = 0 Then
        tileX = Abs(openTileEditorDocs(activeTile.indice).grabx2 - openTileEditorDocs(activeTile.indice).grabx1) / 32
        tileY = Abs(openTileEditorDocs(activeTile.indice).graby2 - openTileEditorDocs(activeTile.indice).graby1) / 32
        tileMax = tileX * tileY
    Else
        tileX = Abs(openTileEditorDocs(activeTile.indice).grabx2 - openTileEditorDocs(activeTile.indice).grabx1 - 32) / 32
        tileY = Abs(openTileEditorDocs(activeTile.indice).graby2 - openTileEditorDocs(activeTile.indice).graby1 - 16) / 16
        tileMax = 0 - Int((tileX * tileY) / -2)
    End If
                    
    grabStatus.Panels(2).Text = "Selection: " & openTileEditorDocs(activeTile.indice).grabx1 & ", " & openTileEditorDocs(activeTile.indice).graby1 & " -> " _
        & openTileEditorDocs(activeTile.indice).grabx2 & ", " & openTileEditorDocs(activeTile.indice).graby2 & " = " _
        & tileX & "x" & tileY & " = " & tileMax & " Tiles"

    
    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub


Private Sub scrHorizontal_Change(): On Error Resume Next
'===================================
'Horizontal scroller.
'===================================

    Dim change As Integer
    'Shift a selection with the image.
    change = (scrollX - scrHorizontal.value) * 32
    
    If openTileEditorDocs(activeTile.indice).grabx1 <> -1 And openTileEditorDocs(activeTile.indice).grabx2 <> -1 Then
        openTileEditorDocs(activeTile.indice).grabx1 = openTileEditorDocs(activeTile.indice).grabx1 + change
        openTileEditorDocs(activeTile.indice).grabx2 = openTileEditorDocs(activeTile.indice).grabx2 + change
    End If
    
    scrollX = scrHorizontal.value     'Store the previous scroll value.

    Call grabRedraw
End Sub

Private Sub scrVertical_Change(): On Error Resume Next
'================================
'Vertical scroller.
'================================

    Dim change As Integer
    'Shift a selection with the image.
    change = (scrollY - scrVertical.value) * 32
    
    If openTileEditorDocs(activeTile.indice).graby1 <> -1 And openTileEditorDocs(activeTile.indice).graby2 <> -1 Then
        openTileEditorDocs(activeTile.indice).graby1 = openTileEditorDocs(activeTile.indice).graby1 + change
        openTileEditorDocs(activeTile.indice).graby2 = openTileEditorDocs(activeTile.indice).graby2 + change
    End If
    
    scrollY = scrVertical.value     'Store the previous scroll value.
    
    Call grabRedraw
    
End Sub

Private Sub grabRedraw(): On Error Resume Next
'=========================================
'Redraws the grabform, and calls the grid.
'=========================================

    Dim offsetX As Long, offsetY As Long
    'Calculate the offset for the image.
    
    If openImage.loaded <> 1 Then
        'Clear the background.
        grabForm.Picture = LoadPicture("")
        Call drawGrid
        Exit Sub
    End If
    
    openImage.pxOffsetX = 0 - scrHorizontal.value * 32
    openImage.pxOffsetY = 0 - scrVertical.value * 32
    
    Call vbPicAutoRedraw(grabForm, True)
    
    Call DrawImage(openImage.filename$, openImage.pxOffsetX, openImage.pxOffsetY, vbPicHDC(grabForm))
    Call drawGrid
    
    'Now redraw the selection box, if there is one.
    
    If openTileEditorDocs(activeTile.indice).grabx1 <> -1 And openTileEditorDocs(activeTile.indice).graby1 <> -1 And _
        openTileEditorDocs(activeTile.indice).grabx2 <> -1 And openTileEditorDocs(activeTile.indice).graby2 <> -1 And _
        drawSelection Then
        'The last grab hasn't been cleared.
    
        If chkIso.value = 0 Then
            '2D.
            Call vbPicRect(grabForm, openTileEditorDocs(activeTile.indice).grabx1 - 1, openTileEditorDocs(activeTile.indice).graby1 - 1, _
                                    openTileEditorDocs(activeTile.indice).grabx2 + 1, openTileEditorDocs(activeTile.indice).graby2 + 1, selectionColor)
            Call vbPicRect(grabForm, openTileEditorDocs(activeTile.indice).grabx1, openTileEditorDocs(activeTile.indice).graby1, _
                                    openTileEditorDocs(activeTile.indice).grabx2, openTileEditorDocs(activeTile.indice).graby2, selectionColor)
                                    
        Else
            'Isometric.
            
            'If we've selected a single tile, draw the diamond:
            If Abs(openTileEditorDocs(activeTile.indice).grabx2 - openTileEditorDocs(activeTile.indice).grabx1) = 64 And _
                Abs(openTileEditorDocs(activeTile.indice).graby2 - openTileEditorDocs(activeTile.indice).graby1) = 32 Then
                
                'Top left.
                Call vbPicLine(grabForm, openTileEditorDocs(activeTile.indice).grabx1, openTileEditorDocs(activeTile.indice).graby1 + 16, _
                                openTileEditorDocs(activeTile.indice).grabx1 + 32, openTileEditorDocs(activeTile.indice).graby1, selectionColor)
                'Top right.
                Call vbPicLine(grabForm, openTileEditorDocs(activeTile.indice).grabx1, openTileEditorDocs(activeTile.indice).graby1 + 16, _
                                openTileEditorDocs(activeTile.indice).grabx1 + 32, openTileEditorDocs(activeTile.indice).graby1 + 32, selectionColor)
                'Bottom left.
                Call vbPicLine(grabForm, openTileEditorDocs(activeTile.indice).grabx1 + 32, openTileEditorDocs(activeTile.indice).graby1, _
                                openTileEditorDocs(activeTile.indice).grabx1 + 64, openTileEditorDocs(activeTile.indice).graby1 + 16, selectionColor)
                'Bottom right.
                Call vbPicLine(grabForm, openTileEditorDocs(activeTile.indice).grabx1 + 32, openTileEditorDocs(activeTile.indice).graby1 + 32, _
                                openTileEditorDocs(activeTile.indice).grabx1 + 64, openTileEditorDocs(activeTile.indice).graby1 + 16, selectionColor)
                         
            Else
                'Box outline.
                Call vbPicRect(grabForm, openTileEditorDocs(activeTile.indice).grabx1 - 1, openTileEditorDocs(activeTile.indice).graby1 - 1, _
                                openTileEditorDocs(activeTile.indice).grabx2 + 1, openTileEditorDocs(activeTile.indice).graby2 + 1, selectionColor)
                Call vbPicRect(grabForm, openTileEditorDocs(activeTile.indice).grabx1, openTileEditorDocs(activeTile.indice).graby1, _
                                    openTileEditorDocs(activeTile.indice).grabx2, openTileEditorDocs(activeTile.indice).graby2, selectionColor)

            End If
            
        End If 'chkIso.value
        
        'Now, draw the tile in the preview box.
        Call drawTile
    
    End If 'Draw grab square.
   
    Call vbPicRefresh(grabForm)

End Sub

Private Sub drawGrid()
'=========================================
'Draw the grid 2D or isometrically.
'Taken from boardedit, with modifications.
'=========================================

    On Error Resume Next
    Dim x As Long, y As Long
    Dim tilesX As Integer, tilesY As Integer
    
    Call vbPicAutoRedraw(picGrabbed, False)
    
    ' check grid is on
    If chkGrid.value = 1 Then
    
        ' if isometric
        If chkIso.value = 1 Then
        
            tilesX = Int((grabForm.Width / Screen.TwipsPerPixelX) / 64)
            tilesY = Int((grabForm.height / Screen.TwipsPerPixelY) / 16)
            
            'Draw lines: bottom left to top right.
            x = 0
            For y = 0 To tilesY * 32 * 2 Step 32
                'Call vbPicLine(grabForm, 0, y + offsetY, x + (offsetY * 2), 0, vbQBColor(col))
                Call vbPicLine(grabForm, 0, y + gridOffsetY + (gridOffsetX / 2), x + (gridOffsetY * 2) + gridOffsetX, 0, gridColor)
                x = x + 64
            Next y
                       
            'Draw lines: top left to bottom right.
            x = 0
            For y = tilesY * 32 To -tilesY * 32 Step -32
                'Call vbPicLine(grabForm, 0, y + offsetY, x, tilesY * 32 + offsetY, vbQBColor(col))
                Call vbPicLine(grabForm, 0, y + gridOffsetY - (gridOffsetX / 2), x + gridOffsetX, tilesY * 32 + gridOffsetY, gridColor)
                x = x + 64
            Next y
        
        ' if 2d
        Else
        
            tilesX = Int((grab.Width / Screen.TwipsPerPixelX) / 32)
            tilesY = Int((grab.height / Screen.TwipsPerPixelY) / 32)
        
            ' draw 2D grid lines
            'Vertical.
            For x = 0 To tilesX * 32 Step 32
                Call vbPicLine(grabForm, x + gridOffsetX, 0, x + gridOffsetX, tilesY * 32, gridColor)
            Next x
            'Horizontal.
            For y = 0 To tilesY * 32 Step 32
                Call vbPicLine(grabForm, 0, y + gridOffsetY, tilesX * 32, y + gridOffsetY, gridColor)
            Next y
            
        End If
        
    End If
    
    Call vbPicAutoRedraw(picGrabbed, True)

End Sub

Private Sub drawTile(): On Error GoTo ErrorHandler
'===========================================
'Draws the selected tile in the preview box.
'Draws first tile in selection (if more than one).
'===========================================

    
    Dim x As Integer, y As Integer, pixel As Long
    
    Call vbPicAutoRedraw(picGrabbed, True)

    If chkIso.value = 0 Then
        '2D.
        
        
        For x = 0 To 31
            For y = 0 To 31
                
                'Get the colour value at the pixel.
                'pixel = vbFrmPoint(grab.grabForm, openTileEditorDocs(activeTile.indice).grabx1 + x, openTileEditorDocs(activeTile.indice).graby1 + y)
                pixel = CanvasGetPixel(openImage.pointer, scrHorizontal.value * 32 + openTileEditorDocs(activeTile.indice).grabx1 + x, scrVertical.value * 32 + openTileEditorDocs(activeTile.indice).graby1 + y)
                
                'Set the transparent colour as -1.
                If pixel = openTileEditorDocs(activeTile.indice).transpcolor Then pixel = -1
                
                'Draw the tile into the preview window at the at the top.
                If pixel <> -1 Then
                    Call vbPicPSet(picGrabbed, x, y, pixel)
                End If
                
                'Set the pixel in tilemem.
                tileMem(x + 1, y + 1) = pixel
                
            Next y
        Next x
        
    Else
        'Isometric.
        For x = 0 To 63
            For y = 0 To 31
                
                'Get the colour value at the pixel.
                'pixel = vbFrmPoint(grab.grabForm, openTileEditorDocs(activeTile.indice).grabx1 + x, openTileEditorDocs(activeTile.indice).graby1 + y)
                pixel = CanvasGetPixel(openImage.pointer, scrHorizontal.value * 32 + openTileEditorDocs(activeTile.indice).grabx1 + x, scrVertical.value * 32 + openTileEditorDocs(activeTile.indice).graby1 + y)
                
                'Set the transparent colour as -1.
                If pixel = openTileEditorDocs(activeTile.indice).transpcolor Then pixel = -1
                
                'Draw the tile into the preview window at the at the top.
                'Mask off the corners using the mask.
                If pixel <> -1 And isoMaskBmp(x + 1, y + 1) = 0 Then
                    Call vbPicPSet(picGrabbed, x, y, pixel)
                Else
                    'White pixel.
                    Call vbPicPSet(picGrabbed, x, y, vbQBColor(15))
                End If
                
                tileMem(x + 1, y + 1) = pixel
               
            Next y
        Next x
        
    End If 'chkIso.value
    
    Call vbPicRefresh(picGrabbed)
    'Call vbPicAutoRedraw(picGrabbed, True)


    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub


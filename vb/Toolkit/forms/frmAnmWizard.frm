VERSION 5.00
Begin VB.Form frmAnmWizard 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Animation Wizard"
   ClientHeight    =   5595
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   9465
   Icon            =   "frmAnmWizard.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   5595
   ScaleWidth      =   9465
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame fra 
      Height          =   2295
      Index           =   2
      Left            =   5400
      TabIndex        =   14
      Top             =   120
      Width           =   3975
      Begin VB.PictureBox pic 
         BorderStyle     =   0  'None
         Height          =   1815
         Index           =   0
         Left            =   120
         ScaleHeight     =   1815
         ScaleWidth      =   3735
         TabIndex        =   15
         Top             =   240
         Width           =   3735
         Begin VB.OptionButton opt 
            Caption         =   "Image files or existing tile bitmaps"
            Height          =   255
            Index           =   0
            Left            =   0
            TabIndex        =   1
            Top             =   0
            Width           =   2655
         End
         Begin VB.CommandButton cmdRemove 
            Caption         =   "Remove"
            Height          =   375
            Left            =   2400
            TabIndex        =   4
            ToolTipText     =   "Remove the highlighted file"
            Top             =   720
            Width           =   1335
         End
         Begin VB.CommandButton cmdClear 
            Caption         =   "Remove All"
            Height          =   375
            Left            =   2400
            TabIndex        =   5
            ToolTipText     =   "Remove all files"
            Top             =   1080
            Width           =   1335
         End
         Begin VB.CommandButton cmdSelectFile 
            Caption         =   "Select Files..."
            Height          =   375
            Left            =   2400
            TabIndex        =   3
            ToolTipText     =   "Select multiple image files"
            Top             =   360
            Width           =   1335
         End
         Begin VB.ListBox lstFiles 
            Height          =   1035
            Left            =   0
            TabIndex        =   2
            Top             =   360
            Width           =   2295
         End
         Begin VB.Label lblFrames 
            Caption         =   "Frames: 1"
            Height          =   255
            Left            =   0
            TabIndex        =   24
            Top             =   1560
            Width           =   3375
         End
      End
   End
   Begin VB.Frame fra 
      Caption         =   "Animation Wizard"
      Height          =   2295
      Index           =   1
      Left            =   120
      TabIndex        =   20
      Top             =   120
      Width           =   5175
      Begin VB.Label lbl 
         Caption         =   $"frmAnmWizard.frx":0CCA
         Height          =   615
         Index           =   0
         Left            =   120
         TabIndex        =   27
         Top             =   480
         Width           =   4935
      End
      Begin VB.Label lbl 
         Caption         =   "This wizard creates an animation from a selection of images or tiles."
         Height          =   375
         Index           =   2
         Left            =   120
         TabIndex        =   23
         Top             =   240
         Width           =   4935
      End
      Begin VB.Label lbl 
         Caption         =   $"frmAnmWizard.frx":0D72
         Height          =   855
         Index           =   5
         Left            =   120
         TabIndex        =   22
         Top             =   1080
         Width           =   4935
      End
      Begin VB.Label lbl 
         Caption         =   "The transparent color is taken from the first pixel of the first frame."
         Height          =   255
         Index           =   6
         Left            =   120
         TabIndex        =   21
         Top             =   1920
         Width           =   4815
      End
   End
   Begin VB.Frame fra 
      Height          =   2655
      Index           =   0
      Left            =   120
      TabIndex        =   16
      Top             =   2400
      Width           =   9255
      Begin VB.PictureBox pic 
         BorderStyle     =   0  'None
         Height          =   2295
         Index           =   1
         Left            =   120
         ScaleHeight     =   153
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   601
         TabIndex        =   17
         Top             =   240
         Width           =   9015
         Begin VB.OptionButton opt 
            Caption         =   "Single or multiple tiles per frame"
            Height          =   255
            Index           =   1
            Left            =   0
            TabIndex        =   6
            Top             =   0
            Width           =   2655
         End
         Begin VB.HScrollBar hsbCurrent 
            Height          =   255
            Left            =   1800
            Max             =   48
            TabIndex        =   8
            TabStop         =   0   'False
            Top             =   600
            Width           =   495
         End
         Begin VB.HScrollBar hsbTbmFrames 
            Height          =   255
            Left            =   1800
            Max             =   48
            TabIndex        =   7
            TabStop         =   0   'False
            Top             =   360
            Width           =   495
         End
         Begin VB.PictureBox picTbm 
            AutoRedraw      =   -1  'True
            Height          =   1935
            Left            =   2400
            ScaleHeight     =   125
            ScaleMode       =   3  'Pixel
            ScaleWidth      =   125
            TabIndex        =   18
            ToolTipText     =   "Current animation frame"
            Top             =   360
            Width           =   1935
         End
         Begin VB.CommandButton cmdBrowseTbm 
            Caption         =   "..."
            Height          =   255
            Left            =   1800
            TabIndex        =   10
            Top             =   1920
            Width           =   495
         End
         Begin VB.TextBox txtTbm 
            Height          =   285
            Left            =   0
            TabIndex        =   9
            Text            =   "tbms\npc1.tbm"
            ToolTipText     =   "e.g. 'tbms\npc1.tbm' will produce 'npc1_000.tbm', 'npc1_001.tbm' etc. in the folder '\Bitmap\tbms'"
            Top             =   1560
            Width           =   2295
         End
         Begin Toolkit.ctlTilesetToolbar ctlTst 
            Height          =   2295
            Left            =   4320
            TabIndex        =   11
            Top             =   0
            Width           =   4695
            _ExtentX        =   8281
            _ExtentY        =   4048
         End
         Begin VB.Label lblTbm 
            Caption         =   "Filename template for tile bitmaps (multiple tiles only)."
            Height          =   495
            Index           =   0
            Left            =   0
            TabIndex        =   19
            ToolTipText     =   "e.g. 'tbms\npc1.tbm' will produce 'npc1_000.tbm', 'npc1_001.tbm' etc. in the folder '\Bitmap\tbms'"
            Top             =   1080
            Width           =   2415
         End
         Begin VB.Label lblCurrent 
            Caption         =   "Current frame: 1"
            Height          =   255
            Left            =   0
            TabIndex        =   26
            ToolTipText     =   "Use the cursor keys to switch frames quickly"
            Top             =   600
            Width           =   1575
         End
         Begin VB.Label lblTbmFrames 
            Caption         =   "Frames: 1"
            Height          =   255
            Left            =   0
            TabIndex        =   25
            Top             =   360
            Width           =   975
         End
      End
   End
   Begin VB.PictureBox pic 
      BorderStyle     =   0  'None
      Height          =   375
      Index           =   2
      Left            =   6480
      ScaleHeight     =   375
      ScaleWidth      =   2895
      TabIndex        =   0
      Top             =   5160
      Width           =   2895
      Begin VB.CommandButton cmdCancel 
         Cancel          =   -1  'True
         Caption         =   "Cancel"
         Height          =   375
         Left            =   1560
         TabIndex        =   13
         Top             =   0
         Width           =   1335
      End
      Begin VB.CommandButton cmdCreate 
         Caption         =   "OK"
         Default         =   -1  'True
         Height          =   375
         Left            =   240
         TabIndex        =   12
         Top             =   0
         Width           =   1335
      End
   End
End
Attribute VB_Name = "frmAnmWizard"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'========================================================================
' The RPG Toolkit, Version 3
' This file copyright (C) 2007 Jonathan D. Hughes
'========================================================================
'
' This program is free software; you can redistribute it and/or
' modify it under the terms of the GNU General Public License
' as published by the Free Software Foundation; either version 2
' of the License, or (at your option) any later version.
'
' This program is distributed in the hope that it will be useful,
' but WITHOUT ANY WARRANTY; without even the implied warranty of
' MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
' GNU General Public License for more details.
'
'========================================================================

Option Explicit

Private m_selectedTile As String
Private m_tbm() As TKTileBitmap

'========================================================================
' Get size and transparency details from an image/tbm
'========================================================================
Private Sub analyseImage(ByVal file As String, ByRef transpcolor As Long, ByRef x As Long, ByRef y As Long): On Error Resume Next
    
    Dim ex As String
    ex = UCase$(GetExt(file))
    
    If ex = "TBM" Then
        Dim tbm As TKTileBitmap
        Call OpenTileBitmap(projectPath & bmpPath & file, tbm)
        x = tbm.sizex * 32
        y = tbm.sizey * 32
        
        transpcolor = RGB(255, 255, 255)          'Redundant if tile background transparent.
    Else
        'Take the top-left pixel to be transparent.
        Dim cnv As Long
        cnv = createCanvas(32, 32)
        
        Call canvasLoadFullPicture(cnv, projectPath & bmpPath & file, -1, -1)
        transpcolor = canvasGetPixel(cnv, 1, 1)
        
        x = getCanvasWidth(cnv)
        y = getCanvasHeight(cnv)
        
        Call destroyCanvas(cnv)
    End If

End Sub

'========================================================================
' Select a new filename template for generating tbms
'========================================================================
Private Sub cmdBrowseTbm_Click(): On Error Resume Next

    Dim dlg As FileDialogInfo, file As String
    
    dlg.strDefaultFolder = projectPath & bmpPath
    dlg.strTitle = "Select New Tile Bitmap"
    dlg.strDefaultExt = "tbm"
    dlg.strFileTypes = "RPG Toolkit Tile Bitmap (*.tbm)|*.tbm|All files(*.*)|*.*"
    
    If Not SaveFileDialog(dlg, Me.hwnd, True) Then Exit Sub
    If LenB(dlg.strSelectedFile) = 0 Then Exit Sub
    
    'Preserve the path if a sub-folder is chosen.
    If Not getValidPath(dlg.strSelectedFile, dlg.strDefaultFolder, file, True) Then Exit Sub
    txtTbm.Text = file
End Sub

'========================================================================
' Select multiple images/pre-exisitng tbms
'========================================================================
Private Sub cmdSelectFile_Click(): On Error Resume Next

    Dim dlg As FileDialogInfo, files() As String, i As Long
    
    dlg.strDefaultFolder = projectPath & bmpPath
    dlg.strTitle = "Select Image"
    dlg.strDefaultExt = "jpg"
    dlg.strFileTypes = strFileDialogFilterGfx
    
    'First entry is the path.
    files = MultiselectFileDialog(dlg, Me.hwnd)
    If LenB(files(0)) = 0 Then Exit Sub
    
    'Sort array manually to allow custom order in list.
    Call sortArray(files, 1, UBound(files))
    
    For i = 1 To UBound(files)
        'Preserve the path if a sub-folder is chosen.
        If Not getValidPath(files(0) & files(i), dlg.strDefaultFolder, files(i), i = 1) Then Exit Sub
        
        'Copy folders outside the default directory into the default directory.
        If Not fileExists(dlg.strDefaultFolder & files(i)) Then
            FileCopy files(0) & files(i), dlg.strDefaultFolder & files(i)
        End If
        
        Call lstFiles.AddItem(files(i), lstFiles.ListIndex + i)
    Next i
    
    lblFrames.Caption = "Frames: " & CStr(lstFiles.ListCount)

End Sub

Private Sub cmdCancel_Click(): On Error Resume Next
    Unload Me
End Sub

'========================================================================
' OK button - generate animation
'========================================================================
Private Sub cmdCreate_Click(): On Error Resume Next

    Dim i As Long, x As Long, y As Long, transpcolor As Long
    Dim file As String, path As String
    Dim anm As TKAnimation
    
    anm.animPause = 0.15
    
    If opt(0).value Then
    
        'Image list.
        If lstFiles.ListCount = 0 Then Exit Sub
    
        'Get image properties of the first frame to define the properties of the animation.
        Call analyseImage(lstFiles.List(0), transpcolor, x, y)
        
        'Complete the animation.
        For i = 0 To lstFiles.ListCount - 1
            anm.animFrame(i) = lstFiles.List(i)
            anm.animTransp(i) = transpcolor
        Next i
        
        'Size to the first frame dimensions.
        anm.animSizeX = x
        anm.animSizeY = y
        
    Else
        'Tiles.
        For i = 0 To hsbTbmFrames.value
                                   
            If m_tbm(i).sizex = 1 And m_tbm(i).sizey = 1 Then
            
                'Single tile.
                anm.animFrame(i) = m_tbm(i).tiles(0, 0)
                anm.animTransp(i) = RGB(255, 255, 255)          'Redundant if tile background transparent.
                
            Else
                
                'Make the subdirectory if it does not exist (will error on multiple nonexistent subdirectories).
                If InStr(txtTbm.Text, "\") > 0 Then
                    path = projectPath & bmpPath & Left$(txtTbm.Text, InStrRev(txtTbm.Text, "\") - 1)
                    If Not dirExists(path) Then MkDir (path)
                End If
                
                'Remove the filetype from the template filename.
                If UCase$(GetExt(txtTbm.Text)) = "TBM" Then
                    txtTbm.Text = Left$(txtTbm.Text, InStrRev(txtTbm.Text, ".") - 1)
                End If
                
                'Create the indexed filename from the template (e.g., npc1.tbm will become
                'npc1_000.tbm, npc1_001.tbm, etc.).
                
                file = txtTbm.Text & "_" & Format(i, "000") & ".tbm"
                If fileExists(projectPath & bmpPath & file) Then
                    MsgBox file & " already exists, please choose a different tile bitmap filename or folder.", vbExclamation
                    Exit Sub
                End If
                Call SaveTileBitmap(projectPath & bmpPath & file, m_tbm(i))
                
                anm.animFrame(i) = file
                anm.animTransp(i) = RGB(255, 255, 255)          'Redundant if tile background transparent.
                
            End If 'Single tile.
                
        Next i
            
        'Size to first frame.
        anm.animSizeX = m_tbm(0).sizex * 32
        anm.animSizeY = m_tbm(0).sizey * 32
        
    End If 'Tiles.
    
    'Load into active editor.
    animationList(activeAnimationIndex).theData = anm
    Call activeAnimation.fillInfo
    
    'Reset the project files list.
    Call tkMainForm.tvReset

    Unload Me

End Sub

'========================================================================
' Clear the image listbox
'========================================================================
Private Sub cmdClear_Click(): On Error Resume Next
    lstFiles.clear
    lblFrames.Caption = "Frames: " & CStr(lstFiles.ListCount)
End Sub

'========================================================================
' Remove selected item from listbox
'========================================================================
Private Sub cmdRemove_Click(): On Error Resume Next
    If lstFiles.ListIndex <> -1 Then
        Call lstFiles.RemoveItem(lstFiles.ListIndex)
        lblFrames.Caption = "Frames: " & CStr(lstFiles.ListCount)
    End If
End Sub

'========================================================================
' Receive the selected tile from the tileset browser
'========================================================================
Public Sub ctlTilesetMouseDown(ByVal file As String): On Error Resume Next
    m_selectedTile = file
End Sub

'========================================================================
' Switch tbm frames
'========================================================================
Private Sub Form_KeyDown(keyCode As Integer, Shift As Integer): On Error Resume Next
    Select Case keyCode
        Case vbKeyRight, vbKeyDown
            If hsbCurrent.value <> hsbCurrent.max Then hsbCurrent.value = hsbCurrent.value + 1
        Case vbKeyLeft, vbKeyUp
            If hsbCurrent.value <> hsbCurrent.min Then hsbCurrent.value = hsbCurrent.value - 1
    End Select
End Sub

'========================================================================
' Initialise elements
'========================================================================
Private Sub Form_Load(): On Error Resume Next
    Call ctlTst.resize(configfile.lastTileset)
    opt(0).value = True
    ReDim m_tbm(0)
    Call TileBitmapSize(m_tbm(0), 0, 0)
End Sub

'========================================================================
' Change current tile frame
'========================================================================
Private Sub hsbCurrent_Change(): On Error Resume Next
    Call drawTbm
    lblCurrent.Caption = "Current frame: " & CStr(hsbCurrent.value + 1)
End Sub

'========================================================================
' Change maximum tile frames
'========================================================================
Private Sub hsbTbmFrames_Change(): On Error Resume Next
    hsbCurrent.max = hsbTbmFrames.value
    lblTbmFrames.Caption = "Frames: " & CStr(hsbTbmFrames.value + 1)
    
    Dim size As Boolean
    size = (UBound(m_tbm) < hsbTbmFrames.value)
    ReDim Preserve m_tbm(hsbTbmFrames.value)
    
    'Size last tbm if not already existing.
    If size Then Call TileBitmapSize(m_tbm(hsbTbmFrames.value), 0, 0)
End Sub

'========================================================================
' Switch between image / tile panes
'========================================================================
Private Sub opt_Click(Index As Integer): On Error Resume Next
    opt(Abs(Index - 1)).value = Not opt(Index).value
    
    Dim ctl As Control
    For Each ctl In Me
        If ctl.Container Is pic(0) Then ctl.Enabled = opt(0).value
        If ctl.Container Is pic(1) Then ctl.Enabled = opt(1).value
    Next ctl
    
    If opt(1).value Then
        Call drawTbm
    Else
        picTbm.Cls
    End If
    
    opt(0).Enabled = True
    opt(1).Enabled = True
End Sub

'========================================================================
' Set current tile in current tbm frame
'========================================================================
Private Sub picTbm_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single): On Error Resume Next
    
    If LenB(m_selectedTile) Then
        x = Fix(x / 32) + 1
        y = Fix(y / 32) + 1
        
        With m_tbm(hsbCurrent.value)
            If x > .sizex Or y > .sizey Then
                Call TileBitmapResize(m_tbm(hsbCurrent.value), IIf(x > .sizex, x, .sizex), IIf(y > .sizey, y, .sizey))
            End If
    
            'Tbm.sizex,y equal the tile array UBounds and the number of tiles displayed,
            'however entries in the array run from 0 to Ubound - 1.
            .tiles(x - 1, y - 1) = m_selectedTile
        End With
        
        Call drawTbm
    End If
End Sub

'========================================================================
' Draw the current tbm frame
'========================================================================
Private Sub drawTbm(): On Error Resume Next
    Dim pCEd As New CBoardEditor
    picTbm.Cls
    Call DrawTileBitmap(picTbm.hdc, -1, 0, 0, m_tbm(hsbCurrent.value))
    Call modBoard.gridDraw(picTbm, pCEd, False, 32, 32)
    picTbm.Refresh
End Sub

'========================================================================
' Sort a string array alphabetically
'========================================================================
Private Sub sortArray(ByRef arr() As String, ByVal startIdx As Long, ByVal endIdx As Long)
    Dim i As Long, j As Long, swap As String
    For i = startIdx To endIdx
        For j = startIdx To endIdx
            If StrComp(LCase$(arr(i)), LCase$(arr(j)), vbTextCompare) = -1 Then
                swap = arr(i)
                arr(i) = arr(j)
                arr(j) = swap
            End If
        Next j
    Next i
End Sub

VERSION 5.00
Begin VB.Form frmLayerTile 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Layer Tile"
   ClientHeight    =   1455
   ClientLeft      =   2550
   ClientTop       =   2865
   ClientWidth     =   3855
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
   Icon            =   "LAYERTIL.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   1455
   ScaleWidth      =   3855
   StartUpPosition =   1  'CenterOwner
   Tag             =   "1591"
   Begin VB.CommandButton cmdOK 
      Caption         =   "OK"
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
      Left            =   2520
      TabIndex        =   5
      Top             =   120
      Width           =   1215
   End
   Begin VB.CheckBox chkPreview 
      Caption         =   "Preview"
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
      Left            =   120
      TabIndex        =   4
      Top             =   720
      Width           =   1215
   End
   Begin VB.CommandButton cmdCancel 
      Caption         =   "Cancel"
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
      Left            =   2520
      TabIndex        =   3
      Top             =   600
      Width           =   1215
   End
   Begin VB.CheckBox transp 
      Caption         =   "Transparently Layer"
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
      Left            =   120
      TabIndex        =   2
      Tag             =   "1592"
      Top             =   1080
      Width           =   2055
   End
   Begin VB.PictureBox layerpic 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   495
      Left            =   1560
      ScaleHeight     =   31
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   31
      TabIndex        =   1
      Top             =   120
      Width           =   495
   End
   Begin VB.CommandButton cmdOpenTile 
      Appearance      =   0  'Flat
      Caption         =   "Open Tile"
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
      TabIndex        =   0
      Tag             =   "1593"
      Top             =   120
      Width           =   1215
   End
End
Attribute VB_Name = "frmLayerTile"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'========================================================================
'All contents copyright 2003, Christopher Matthews
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info
'========================================================================
'!NEW! Declared variables
Option Explicit

'KSNiloc says: No evil variants, please
Private X As Integer, Y As Integer

'========================================================================
' !NEW! The preview checkbox
'========================================================================
Private Sub chkPreview_Click()
    'If they uncheck it, we should turn the tile back to how it was at the start
    If chkPreview.value = 0 Then
        For X = 1 To 32
            For Y = 1 To 32
                'If tilemem(x, y) <> -1 Then
                    tileMem(X, Y) = tilePreview(X, Y)
                'End If
            Next Y
        Next X
    activeTile.tileRedraw
    'If they check it, preview the tile!
    Else
        Call Preview
    End If
End Sub

'========================================================================
' !NEW! The cancel button
'========================================================================
'Since cancel was clicked, the user doesn't wants to edit the tile...
'Because of this, we don't set the SaveChanges variable to true.
Private Sub cmdCancel_Click()
    Unload Me
End Sub

'========================================================================
' The OK button, this was first the layerbutton button
'========================================================================
Private Sub cmdOK_Click()
    On Error GoTo ErrorHandler
    
    'Since I added the Preview sub, why not use it here too?
    Call Preview
    
    '!NEW! The user wants to save the changes
    saveChanges = True
    
    Call Unload(Me)

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

'========================================================================
' The OpenTile button, this was first the openlayer button
'========================================================================
Private Sub cmdOpenTile_Click()
    On Error GoTo ErrorHandler

    ReDim buffer(32, 32)
    
    For X = 1 To 32
        For Y = 1 To 32
            bufTile(X, Y) = tileMem(X, Y)
        Next Y
    Next X
    
    ChDir (currentDir$)
    Dim dlg As FileDialogInfo
    
    '!NEW! Declared these variables, first there was a $ behind each of them, I
    'removed those.
    Dim antiPath, whichType, txtFile As String
    
    dlg.strDefaultFolder = projectPath$ + tilePath$
    
    dlg.strTitle = "Open Tile For Layering"
    dlg.strDefaultExt = "gph"
    dlg.strFileTypes = "Supported Types|*.gph;*.tst|RPG Toolkit Tile (*.gph)|*.gph|Tileset (*.tst)|*.tst|All files(*.*)|*.*"
    
    If OpenFileDialog(dlg, Me.hwnd) Then  'user pressed cancel
        filename(1) = dlg.strSelectedFile
        antiPath = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If

    If filename(1) = "" Then Exit Sub
    whichType = extention(filename(1))
    If UCase$(whichType) = "TST" Then      'Yipes! we've selected an archive!
        tstnum = 0
        ChDir (currentDir$)
        tstFile = antiPath
        tilesetform.Show 1
        'MsgBox setFilename$
        If setFilename$ = "" Then Exit Sub
        Call openWinTile(projectPath$ + tilePath$ + setFilename$)
    Else
        Call openWinTile(filename(1))
    End If

    Call vbPicFillRect(layerpic, 0, 0, 100, 100, vbQBColor(15))
    For X = 1 To 32
        For Y = 1 To 32
            If tileMem(X, Y) <> -1 Then
                Call vbPicPSet(layerpic, X - 1, Y - 1, tileMem(X, Y))
            End If
        Next Y
    Next X
    For X = 1 To 32
        For Y = 1 To 32
            buffer(X, Y) = tileMem(X, Y)
            tileMem(X, Y) = bufTile(X, Y)
            bufTile(X, Y) = buffer(X, Y)
        Next Y
    Next X
    ChDir (currentDir$)
    
    '!NEW! If the preview checkbox is checked, preview the tile.
    If chkPreview.value = 1 Then Call Preview

    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

'========================================================================
' Form_Activate
'========================================================================
Private Sub Form_Activate()
    On Error GoTo ErrorHandler
    If openTileEditorDocs(activeTile.indice).transparentLayer = 1 Then transp.value = 1 Else transp.value = 0
    
    '!NEW! Used to store the current tile for when the "preview" function is used
    For X = 1 To 32
        For Y = 1 To 32
            'If tilemem(x, y) <> -1 Then
                tilePreview(X, Y) = tileMem(X, Y)
            'End If
        Next Y
    Next X
    
    '!NEW! Set the variable to False at the start...
    saveChanges = False
    
    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub

'========================================================================
' Form_Load
'========================================================================
Private Sub Form_Load()
    Call LocalizeForm(Me)
End Sub

'========================================================================
' Form_Unload
'========================================================================
Private Sub Form_Unload(Cancel As Integer)
    'If the user has pressed the X in the form, he doesn't wants to add the changes
    If Not saveChanges Then
    
    'Use new undo
    Call activeTile.setUndo
    For X = 1 To 32
        For Y = 1 To 32
            If tileMem(X, Y) <> -1 Then
                tileMem(X, Y) = tilePreview(X, Y)
            End If
        Next Y
    Next X
    'Redraw
    activeTile.tileRedraw

    End If
End Sub

'========================================================================
' transp_Click()
'========================================================================
Private Sub transp_Click()
    On Error GoTo ErrorHandler
    If openTileEditorDocs(activeTile.indice).transparentLayer = 0 Then openTileEditorDocs(activeTile.indice).transparentLayer = 1 Else openTileEditorDocs(activeTile.indice).transparentLayer = 0
    
    '!NEW! Preview the tile, if preview is checked
    If chkPreview.value = 1 Then Call Preview
    
    Exit Sub
'Begin error handling code:
ErrorHandler:
    Call HandleError
    Resume Next
End Sub
'========================================================================
' !NEW! Previews the tile
'========================================================================
Private Sub Preview()
    '!NEW! Declared variables
    Dim rrbuf, ggbuf, bbbuf, rrtile, ggtile, bbtile As String
    
    'First we need to to set the tile back to how it was at the start
    For X = 1 To 32
        For Y = 1 To 32
            If tileMem(X, Y) <> -1 Then
                tileMem(X, Y) = tilePreview(X, Y)
            End If
        Next Y
    Next X
    
    For X = 1 To 32
        For Y = 1 To 32
            If openTileEditorDocs(activeTile.indice).transparentLayer = 0 Then
                
                Dim mee As Boolean
                If mee = False Then MsgBox "here": mee = True

                If bufTile(X, Y) = -1 Then bufTile(X, Y) = tileMem(X, Y)
                tileMem(X, Y) = bufTile(X, Y)
            Else
                If bufTile(X, Y) = -1 Then
                    bufTile(X, Y) = tileMem(X, Y)
                Else
                    rrbuf = red(bufTile(X, Y))
                    ggbuf = green(bufTile(X, Y))
                    bbbuf = blue(bufTile(X, Y))
                    rrtile = red(tileMem(X, Y))
                    ggtile = green(tileMem(X, Y))
                    bbtile = green(tileMem(X, Y))
                    rrtile = rrtile + rrbuf: If rrtile > 255 Then rrtile = 255
                    ggtile = ggtile + ggbuf: If ggtile > 255 Then ggtile = 255
                    bbtile = bbtile + bbbuf: If bbtile > 255 Then bbtile = 255
                    tileMem(X, Y) = RGB(rrtile, ggtile, bbtile)
                End If
            End If
        Next Y
    Next X
    
    'Redraw
    activeTile.tileRedraw
End Sub


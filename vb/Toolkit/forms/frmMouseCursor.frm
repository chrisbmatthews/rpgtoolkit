VERSION 5.00
Begin VB.Form frmMouseCursor 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Mouse Cursor"
   ClientHeight    =   4095
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   4815
   FillColor       =   &H8000000F&
   Icon            =   "frmMouseCursor.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4095
   ScaleWidth      =   4815
   ShowInTaskbar   =   0   'False
   Begin VB.CommandButton cmdOK 
      Caption         =   "OK"
      Default         =   -1  'True
      Height          =   375
      Left            =   3840
      TabIndex        =   4
      Top             =   3550
      Width           =   855
   End
   Begin VB.Frame fraCustom 
      Caption         =   "Custom Cursor"
      Height          =   3255
      Left            =   120
      TabIndex        =   3
      Top             =   120
      Width           =   4575
      Begin VB.PictureBox Picture1 
         BorderStyle     =   0  'None
         Height          =   2895
         Left            =   120
         ScaleHeight     =   2895
         ScaleWidth      =   4335
         TabIndex        =   5
         Top             =   240
         Width           =   4335
         Begin VB.CommandButton cmdTranspColor 
            Caption         =   "Set Transparent Color"
            Height          =   375
            Left            =   0
            TabIndex        =   11
            Top             =   1800
            Width           =   2295
         End
         Begin VB.CommandButton cmdBrowse 
            Caption         =   "..."
            Height          =   255
            Left            =   3840
            TabIndex        =   10
            Top             =   2400
            Width           =   495
         End
         Begin VB.PictureBox picTranspColor 
            Appearance      =   0  'Flat
            BackColor       =   &H00FFFFFF&
            FillColor       =   &H00FFFFFF&
            FillStyle       =   0  'Solid
            FontTransparent =   0   'False
            ForeColor       =   &H00FFFFFF&
            Height          =   375
            Left            =   3480
            ScaleHeight     =   345
            ScaleWidth      =   345
            TabIndex        =   9
            Top             =   1200
            Width           =   375
         End
         Begin VB.PictureBox picPreview 
            Appearance      =   0  'Flat
            AutoRedraw      =   -1  'True
            BackColor       =   &H80000005&
            ForeColor       =   &H80000008&
            Height          =   1020
            Left            =   240
            ScaleHeight     =   66
            ScaleMode       =   3  'Pixel
            ScaleWidth      =   66
            TabIndex        =   8
            Top             =   0
            Width           =   1020
         End
         Begin VB.TextBox txtFilename 
            Height          =   285
            Left            =   0
            TabIndex        =   7
            Top             =   2400
            Width           =   3735
         End
         Begin VB.CommandButton cmdSetHotSpot 
            Caption         =   "Set Cursor Hot Spot"
            Height          =   375
            Left            =   0
            TabIndex        =   6
            Top             =   1320
            Width           =   2295
         End
         Begin VB.Label Label2 
            Alignment       =   2  'Center
            BackStyle       =   0  'Transparent
            Caption         =   "Current Transparent Color"
            Height          =   375
            Left            =   3000
            TabIndex        =   13
            Top             =   1680
            Width           =   1335
         End
         Begin VB.Label Label1 
            Caption         =   "In game the cursor will be 32x32 pixels, it is shown larger here for your convenience."
            Height          =   615
            Left            =   1560
            TabIndex        =   12
            Top             =   120
            Width           =   2415
         End
      End
   End
   Begin VB.OptionButton optCustom 
      Caption         =   "Custom"
      Height          =   255
      Left            =   2640
      TabIndex        =   2
      Top             =   3600
      Width           =   975
   End
   Begin VB.OptionButton optNoCursor 
      Caption         =   "None"
      Height          =   255
      Left            =   1440
      TabIndex        =   1
      Top             =   3600
      Width           =   1095
   End
   Begin VB.OptionButton optDefault 
      Caption         =   "Default"
      Height          =   255
      Left            =   240
      TabIndex        =   0
      Top             =   3600
      Width           =   1095
   End
End
Attribute VB_Name = "frmMouseCursor"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'========================================================================
' The RPG Toolkit, Version 3
' This file copyright (C) 2007 Colin James Fitzpatrick
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

'=========================================================================
' Member variables
'=========================================================================
Private setHotSpot As Boolean
Private setTranspColor As Boolean

'=========================================================================
' Fill in the form
'=========================================================================
Private Sub fillInfo(Optional ByVal noHotSpot As Boolean, Optional ByVal noOptionButtons As Boolean)
    Call picPreview.Cls
    With mainMem
        If ((.mouseCursor <> "TK DEFAULT") And (.mouseCursor <> "")) Then
            fraCustom.Enabled = True
            If (fileExists(projectPath & bmpPath & .mouseCursor)) Then
                Call DrawSizedImage( _
                                       projectPath & bmpPath & .mouseCursor, _
                                       0, 0, _
                                       picPreview.ScaleWidth, _
                                       picPreview.ScaleHeight, _
                                       picPreview.hdc _
                                                        )
            End If
            picTranspColor.backColor = .transpcolor
            If (Not noHotSpot) Then
                Call vbPicLine(picPreview, .hotSpotX * 2, 0, .hotSpotX * 2, picPreview.ScaleHeight, 0)
                Call vbPicLine(picPreview, 0, .hotSpotY * 2, picPreview.ScaleWidth, .hotSpotY * 2, 0)
            End If
            txtFilename.Text = .mouseCursor
            If (Not noOptionButtons) Then optCustom.value = True
        ElseIf (.mouseCursor = "") Then
            If (Not noOptionButtons) Then fraCustom.Enabled = False
            If (Not noOptionButtons) Then optNoCursor.value = True
        ElseIf (.mouseCursor = "TK DEFAULT") Then
            If (Not noOptionButtons) Then fraCustom.Enabled = False
            If (Not noOptionButtons) Then optDefault.value = True
        End If
    End With
End Sub

'=========================================================================
' Return type of form
'=========================================================================
Public Property Get formType() As Long
    formType = FT_CURSOR
End Property

'=========================================================================
' Browse button
'=========================================================================
Private Sub cmdBrowse_Click()
    Call ChDir(currentDir)
    Dim dlg As FileDialogInfo, antiPath As String
    With dlg
        .strDefaultFolder = projectPath & bmpPath
        .strTitle = "Open Image"
        .strDefaultExt = "bmp"
        .strFileTypes = strFileDialogFilterWithTiles
        If (OpenFileDialog(dlg, Me.hwnd)) Then
            filename(1) = .strSelectedFile
            antiPath = .strSelectedFileNoPath
        Else
            Exit Sub
        End If
    End With
    Call ChDir(currentDir)
    If (filename(1) = "") Then Exit Sub
    Dim ext As String
    ext = UCase(GetExt(antiPath))
    If (ext = "TST" Or ext = "GPH") Then
        Dim theTile As String
        theTile = antiPath
        If (ext = "TST") Then
            'Get tile from the set
            Dim oldTst As String
            oldTst = tstFile
            tstFile = antiPath
            Call tilesetForm.Show(vbModal)
            If (setFilename = "") Then Exit Sub
            theTile = setFilename
            oldTst = tstFile
        End If
        'Make a tile bitmap
        Dim tbm As TKTileBitmap
        Call TileBitmapSize(tbm, 1, 1)
        tbm.tiles(0, 0) = theTile
        antiPath = replace(replace("cursor_image_" & Mid(theTile, 1, Len(antiPath) - 4) & "_.tbm", " ", ""), ".", "") & ".tbm"
        Call SaveTileBitmap(projectPath & bmpPath & antiPath, tbm)
    End If
    txtFilename.Text = antiPath
    mainMem.mouseCursor = antiPath
    Call fillInfo
End Sub

'=========================================================================
' OK button
'=========================================================================
Private Sub cmdOK_Click()
    Call Unload(Me)
End Sub

'=========================================================================
' Set hot spot
'=========================================================================
Private Sub cmdSetHotSpot_click()
    If (setTranspColor) Then
        Call MsgBox("Please finish setting the transparent color first.")
    Else
        Call MsgBox("Please click on the cursor where you would like the hot spot to be.")
        setHotSpot = True
    End If
End Sub

'=========================================================================
' Set transparent color
'=========================================================================
Private Sub cmdTranspColor_click()
    If (setHotSpot) Then
        Call MsgBox("Please finish setting the hot spot first.")
    Else
        Call MsgBox("Please click on the color in the cursor you would like to set as transparent.")
        setTranspColor = True
    End If
End Sub

'=========================================================================
' Form loaded
'=========================================================================
Private Sub Form_Load()
    On Error Resume Next
    cmdBrowse.MouseIcon = Images.MouseLink()
    Call fillInfo
End Sub

'=========================================================================
' Unload form
'=========================================================================
Private Sub Form_Unload(Cancel As Integer)
    Call tkMainForm.refreshTabs
End Sub

'=========================================================================
' Option buttons
'=========================================================================
Private Sub optCustom_Click()
    fraCustom.Enabled = True
    Call fillInfo(False, True)
End Sub
Private Sub optNoCursor_Click()
    fraCustom.Enabled = False
    txtFilename.Text = ""
    mainMem.mouseCursor = ""
    Call fillInfo
End Sub
Private Sub optDefault_Click()
    fraCustom.Enabled = False
    txtFilename.Text = ""
    mainMem.mouseCursor = "TK DEFAULT"
    Call fillInfo
End Sub

'=========================================================================
' Click on preview picture
'=========================================================================
Private Sub picPreview_MouseDown(ByRef Button As Integer, ByRef Shift As Integer, ByRef x As Single, ByRef y As Single)
    On Error Resume Next
    If (setTranspColor) Then
        Call fillInfo(True)
        mainMem.transpcolor = GetPixel(picPreview.hdc, x, y)
    ElseIf (setHotSpot) Then
        mainMem.hotSpotX = x / 2
        mainMem.hotSpotY = y / 2
    End If
    Call fillInfo
    setTranspColor = False
    setHotSpot = False
End Sub

'=========================================================================
' Change filename
'=========================================================================
Private Sub txtFilename_Change()
    mainMem.mouseCursor = txtFilename.Text
    Call fillInfo
End Sub

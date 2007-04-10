VERSION 5.00
Begin VB.Form main 
   Caption         =   "RPG Toolkit Setup Utility Creator"
   ClientHeight    =   4350
   ClientLeft      =   1320
   ClientTop       =   1695
   ClientWidth     =   8040
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
   Icon            =   "MAIN.frx":0000
   LinkTopic       =   "Form1"
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4350
   ScaleWidth      =   8040
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame1 
      Caption         =   "Create Setup Utility"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   3375
      Left            =   120
      TabIndex        =   2
      Top             =   240
      Width           =   7695
      Begin VB.CommandButton Command4 
         Caption         =   "Browse..."
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   345
         Left            =   6480
         TabIndex        =   13
         Top             =   1320
         Width           =   1095
      End
      Begin VB.CommandButton Command3 
         Caption         =   "Browse..."
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   345
         Left            =   6480
         TabIndex        =   12
         Top             =   600
         Width           =   1095
      End
      Begin VB.TextBox titlebox 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Left            =   3360
         TabIndex        =   7
         Text            =   "Click Here"
         Top             =   600
         Width           =   3015
      End
      Begin VB.TextBox toolkitbox 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Left            =   3360
         TabIndex        =   6
         Text            =   "c:\toolkit2\"
         Top             =   2760
         Width           =   3015
      End
      Begin VB.TextBox defaultdirbox 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Left            =   3360
         TabIndex        =   5
         Text            =   "C:\Program Files\MyGame\"
         Top             =   2040
         Width           =   3015
      End
      Begin VB.PictureBox Picture1 
         Height          =   2655
         Left            =   240
         Picture         =   "MAIN.frx":0CCA
         ScaleHeight     =   2595
         ScaleWidth      =   2595
         TabIndex        =   4
         Top             =   360
         Width           =   2655
      End
      Begin VB.TextBox Text1 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Left            =   3360
         TabIndex        =   3
         Text            =   "Click Here"
         Top             =   1320
         Width           =   3015
      End
      Begin VB.Label Label2 
         Caption         =   "Main File Of Game:"
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
         Index           =   0
         Left            =   3360
         TabIndex        =   11
         Top             =   360
         Width           =   1575
      End
      Begin VB.Label Label4 
         Caption         =   "Location of your RPG Toolkit Directory:"
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
         Left            =   3360
         TabIndex        =   10
         Top             =   2520
         Width           =   3255
      End
      Begin VB.Label Label2 
         Caption         =   "Default Directory for Your Game:"
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
         Index           =   1
         Left            =   3360
         TabIndex        =   9
         Top             =   1800
         Width           =   2895
      End
      Begin VB.Label Label2 
         Caption         =   "(Optional) 128 x 280 sidebar image:"
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
         Index           =   2
         Left            =   3360
         TabIndex        =   8
         Top             =   1080
         Width           =   3255
      End
   End
   Begin VB.CommandButton Command2 
      Appearance      =   0  'Flat
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
      Height          =   345
      Left            =   6720
      TabIndex        =   1
      Top             =   3840
      Width           =   1095
   End
   Begin VB.CommandButton Command1 
      Appearance      =   0  'Flat
      Caption         =   "Create Setup"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   345
      Left            =   5520
      TabIndex        =   0
      Top             =   3840
      Width           =   1095
   End
End
Attribute VB_Name = "main"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'========================================================================
' The RPG Toolkit, Version 3
' This file copyright (C) 2007 Christopher B. Matthews
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

'========================================================================
' Game publisher helper program (non-pak/exe)
'========================================================================

Private Sub Command1_Click()
On Error GoTo insterr
    destfile$ = getDest()
    If destfile$ = "" Then Exit Sub
    winsys$ = SystemDir
    destdir$ = toolkitbox.Text
    defaultdir$ = defaultdirbox.Text
    mainFile$ = titlebox.Text

    If mainFile$ = "Click Here" Or mainFile$ = "" Then
        MsgBox "Please Select The Main File"
        Exit Sub
    End If
    
    ex$ = GetExt(mainFile$)
    If UCase$(ex$) = "GAM" Then
        Call openMain(fileChosen$, mainMem)
    End If
    
    If destdir$ = "" Then
        MsgBox "Please Fill In The Toolkit Directory!!!"
        toolkitbox.Text = LCase$(App.path)
        Exit Sub
    End If
    If defaultdir$ = "" Then
        MsgBox "Please Fill In The Default Directory!!!"
        defaultdirbox.Text = "C:\Program Files\MyGame\"
        Exit Sub
    End If
    winsys$ = resolve(winsys$)
    destdir$ = resolve(destdir$)
    defaultdir$ = resolve(defaultdir$)

    a = MsgBox("Is This Information Correct?" + Chr$(13) + "Windows System Directory: " + winsys$ + Chr$(13) + "Toolkit Directory: " + destdir$, 4, "Confirmation")
    If a = 6 Then
        Call setup(destfile$)
    End If
Exit Sub
insterr:
ea = Err
Resume Next
End Sub

Private Sub Command2_Click()
    End
End Sub

Private Sub Command3_Click()
    'get a filename
    On Error Resume Next
    ChDir (currentdir$)
    Dim dlg As FileDialogInfo
    dlg.strDefaultFolder = "main\"
    dlg.strTitle = "Select main file"
    dlg.strDefaultExt = "gam"
    dlg.strFileTypes = "Supported Types|*.gam;*.tpk;*.exe|Main file (*.gam)|*.gam|RPG Toolkit PakFile (*.tpk)|*.tpk|RPG Toolkit EXE (*.exe)|*.exe|All files(*.*)|*.*"
    If OpenFileDialog(dlg) Then
        filename$ = dlg.strSelectedFile
        antipath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentdir$)
    
    If filename$ = "" Then Exit Sub
    ex$ = GetExt(filename$)
    If UCase$(ex$) = "GAM" Then
        Call openMain(filename$, mainMem)
    End If
    fileChosen$ = filename$
    titlebox.Text = filename$
End Sub

Private Sub Command4_Click()
    'get a filename
    On Error Resume Next
    ChDir (currentdir$)
    Dim dlg As FileDialogInfo
    dlg.strSelectedFile = ""
    dlg.strDefaultFolder = ""
    dlg.strTitle = "Select Image"
    dlg.strDefaultExt = "jpg"
    dlg.strFileTypes = "Supported Types|*.jpg;*.jpeg;*.gif;*.bmp|JPEG Image (*.jpg)|*.jpg;*;jpeg|GIF Image (*.gif)|*.gif|Window Bitmap (*.bmp)|*.bmp|All files(*.*)|*.*"
    If OpenFileDialog(dlg) Then
        filename$ = dlg.strSelectedFile
        antipath$ = dlg.strSelectedFileNoPath
    Else
        Exit Sub
    End If
    ChDir (currentdir$)
    
    If filename$ = "" Then Exit Sub
    sideBarImage = filename$
    Text1.Text = filename$
End Sub

Private Sub Form_Load()
zippath$ = "Zip\"
currentdir$ = CurDir$
toolkitbox.Text = LCase$(CurDir$)
registered = 1
'windowssystembox.Text = SystemDir()
Call testZIPdll
End Sub

Private Sub Form_Unload(Cancel As Integer)
    End
End Sub

Private Sub Text1_Change()
    sideBarImage = Text1.Text
End Sub

Private Sub titlebox_Change()
    fileChosen$ = titlebox.Text
End Sub


VERSION 5.00
Object = "{4186587A-906B-11D3-A98B-96B5662A9349}#66.0#0"; "DIALOG.OCX"
Begin VB.Form filearchiver 
   Appearance      =   0  'Flat
   BackColor       =   &H80000005&
   Caption         =   "Archive Files (Untitled)"
   ClientHeight    =   3960
   ClientLeft      =   840
   ClientTop       =   1710
   ClientWidth     =   8175
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
   Icon            =   "FILEARCH.frx":0000
   LinkTopic       =   "Form2"
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   3960
   ScaleWidth      =   8175
Tag = "1579"
   Begin VB.CommandButton takefile 
      Appearance      =   0  'Flat
      Caption         =   "Remove File"
      Height          =   375
      Left            =   240
      TabIndex        =   23
      Top             =   1800
      Width           =   1335
Tag = "1580"
   End
   Begin VB.PictureBox gphprevue 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   615
      Left            =   7320
      ScaleHeight     =   41
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   41
      TabIndex        =   22
      Top             =   1320
      Width           =   615
   End
   Begin VB.ListBox filesinarchive 
      Appearance      =   0  'Flat
      Height          =   1785
      Left            =   2760
      TabIndex        =   4
      Top             =   360
      Width           =   1455
   End
   Begin VB.CommandButton extractfilearc 
      Appearance      =   0  'Flat
      Caption         =   "Extract File"
      Height          =   375
      Left            =   240
      TabIndex        =   3
      Top             =   2280
      Width           =   1335
Tag = "1581"
   End
   Begin VB.CommandButton openarc 
      Appearance      =   0  'Flat
      Caption         =   "Open Archive"
      Height          =   375
      Left            =   240
      TabIndex        =   2
      Top             =   840
      Width           =   1335
Tag = "1582"
   End
   Begin VB.CommandButton addfilearc 
      Appearance      =   0  'Flat
      Caption         =   "Add File "
      Height          =   375
      Left            =   240
      TabIndex        =   1
      Top             =   1320
      Width           =   1335
Tag = "1003"
   End
   Begin VB.CommandButton newarchive 
      Appearance      =   0  'Flat
      Caption         =   "New Archive"
      Height          =   375
      Left            =   240
      TabIndex        =   0
      Top             =   360
      Width           =   1335
Tag = "1583"
   End
   Begin FileDialog.dlg CMDialog1 
      Left            =   0
      Top             =   0
      _ExtentX        =   873
      _ExtentY        =   873
   End
   Begin VB.Shape Shape2 
      Height          =   1695
      Left            =   4320
      Top             =   360
      Width           =   3735
   End
   Begin VB.Label selectcopy 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "None"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   135
      Left            =   5160
      TabIndex        =   21
      Top             =   1200
      Width           =   2415
Tag = "1010"
   End
   Begin VB.Label selectauthor 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "None"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   135
      Left            =   5040
      TabIndex        =   20
      Top             =   960
      Width           =   2655
Tag = "1010"
   End
   Begin VB.Label selectdesc 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "None"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   135
      Left            =   5760
      TabIndex        =   19
      Top             =   720
      Width           =   2175
Tag = "1010"
   End
   Begin VB.Label selectname 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "None"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   135
      Left            =   5160
      TabIndex        =   18
      Top             =   480
      Width           =   2415
Tag = "1010"
   End
   Begin VB.Label Label1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Copyright:"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   7
      Left            =   4440
      TabIndex        =   17
      Top             =   1200
      Width           =   735
Tag = "1004"
   End
   Begin VB.Label Label1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Author:"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   6
      Left            =   4440
      TabIndex        =   16
      Top             =   960
      Width           =   495
Tag = "1005"
   End
   Begin VB.Label Label1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Description Of File:"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   5
      Left            =   4440
      TabIndex        =   15
      Top             =   720
      Width           =   1335
Tag = "1014"
   End
   Begin VB.Label Label1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Filename:"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   4
      Left            =   4440
      TabIndex        =   14
      Top             =   480
      Width           =   735
Tag = "1013"
   End
   Begin VB.Label Label2 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Files Currently In Archive:"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   2280
      TabIndex        =   13
      Top             =   120
      Width           =   2535
Tag = "1015"
   End
   Begin VB.Shape Shape1 
      Height          =   1215
      Left            =   0
      Top             =   2640
      Width           =   4815
   End
   Begin VB.Label copyname 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "None"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   135
      Left            =   960
      TabIndex        =   12
      Top             =   3480
      Width           =   2655
Tag = "1010"
   End
   Begin VB.Label authorname 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "None"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   135
      Left            =   720
      TabIndex        =   11
      Top             =   3240
      Width           =   2415
Tag = "1010"
   End
   Begin VB.Label descarc 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "None"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   135
      Left            =   1800
      TabIndex        =   10
      Top             =   3000
      Width           =   2655
Tag = "1010"
   End
   Begin VB.Label curarcname 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "None"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   135
      Left            =   1320
      TabIndex        =   9
      Top             =   2760
      Width           =   1695
Tag = "1010"
   End
   Begin VB.Label Label1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Copyright:"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   3
      Left            =   120
      TabIndex        =   8
      Top             =   3480
      Width           =   735
Tag = "1004"
   End
   Begin VB.Label Label1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Author:"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   2
      Left            =   120
      TabIndex        =   7
      Top             =   3240
      Width           =   615
Tag = "1005"
   End
   Begin VB.Label Label1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Description Of Archive:"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   1
      Left            =   120
      TabIndex        =   6
      Top             =   3000
      Width           =   1575
Tag = "1012"
   End
   Begin VB.Label Label1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Current Archive:"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   0
      Left            =   120
      TabIndex        =   5
      Top             =   2760
      Width           =   1095
Tag = "1011"
   End
End
Attribute VB_Name = "filearchiver"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub addfilearc_Click()
On Error Resume Next
    If archivename$ = "" Then MsgBox "No Archive opened", , "Open an archive file": Exit Sub
    ChDir (currentdir$)
    CMDialog1.filename = ""
    CMDialog1.DialogTitle = "Select File To Add"
    CMDialog1.defaultExt = "gph"
    CMDialog1.Filter = "All Toolkit Formats|*.gph;*.brd;*.tem|RPG Toolkit Tile (*.gph)|*.gph|RPG Toolkit Board (*.brd)|*.brd|RPG Toolkit Character (*.tem)|*.tem|All files(*.*)|*.*"
    CMDialog1.Action 1
    If CMDialog1.cancelled = False Then 'user pressed cancel
        filename$(1) = CMDialog1.filename
        importtitle$ = CMDialog1.FileTitle
    Else
        Exit Sub
    End If

    If filename$(1) = "" Then Exit Sub
    importfile$ = filename$(1)
    ChDir (currentdir$)
    archiveaddfile.Show

End Sub

Private Sub extractfilearc_Click()
    On Error Goto errorhandler
    If archivename$ = "" Then MsgBox "No Archive opened", , "Open an archive file": Exit Sub
    ChDir (currentdir$)
    CMDialog1.filename = ""
    CMDialog1.DialogTitle = "Extract File From Archive"
    CMDialog1.defaultExt = "gph"
    CMDialog1.Filter = "RPG Toolkit Tile (*.gph)|*.gph|RPG Toolkit Board (*.brd)|*.brd|RPG Toolkit Character (*.tem)|*.tem|All files(*.*)|*.*"
    CMDialog1.Action 2
    If CMDialog1.cancelled = False Then 'user pressed cancel
        filename$(1) = CMDialog1.filename
    Else
        Exit Sub
    End If
    
    If filename$(1) = "" Then Exit Sub
    Call PasteArchiveToFile(filename$(1))

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError()
    Resume Next
End Sub

Private Sub filesinarchive_Click()
    On Error Goto errorhandler
    gphprevue.AutoRedraw = -1
    ReDim buf(32, 32)
    fileextract$ = filesinarchive.text
    Call ExtractArchive(archivename$, fileextract$)
    selectname.Caption = fileextract$
    selectdesc.Caption = importdescription$
    selectauthor.Caption = importauthor$
    selectcopy.Caption = importcopyright$
    'Is there a preview?  Preview GPHs only
    exten$ = extention(fileextract$)
    If UCase$(exten$) = "GPH" Then
        Call PasteArchiveToFile("rpgsrtch.gph")
    olddetail = detail
    For xx = 0 To 32
        For yy = 0 To 32
            buf(xx, yy) = tilemem(xx, yy)
        Next yy
    Next xx
    Call openwintile("rpgsrtch.gph")
    If detail = 2 Then Call increasedetail
    For xx = 1 To 32
        For yy = 1 To 32
            If tilemem(xx, yy) = -1 Then tilemem(xx, yy) = QBColor(15)
            gphprevue.PSet (xx - 1, yy - 1), tilemem(xx, yy)
            tilemem(xx, yy) = buf(xx, yy)
        Next yy
    Next xx
    detail = olddetail
    End If
    

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError()
    Resume Next
End Sub

Private Sub filesinarchive_KeyPress(keyascii As Integer)
    On Error Goto errorhandler
keyascii = 0

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError()
    Resume Next
End Sub

Private Sub newarchive_Click()
    On Error Resume Next
    ChDir (currentdir$)
    CMDialog1.InitDir = arcpath$
    CMDialog1.filename = ""
    CMDialog1.DialogTitle = "Create Archive"
    CMDialog1.defaultExt = "arc"
    CMDialog1.Filter = "General Archive (*.arc)|*.arc|All Files (*.*)|*.*"
    CMDialog1.Action 2
    If CMDialog1.cancelled = False Then 'user pressed cancel
        filename$(1) = CMDialog1.filename
        antipath$ = CMDialog1.FileTitle
    Else
        Exit Sub
    End If
    ChDir (currentdir$)
    If filename$(1) = "" Then Exit Sub
    filename$(2) = filename$(1)
    filearchiver.Caption = "Archive Files (" + antipath$ + ")"
    archivename$ = filename$(2)
    archivespecs.Show
End Sub

Private Sub openarc_Click()
On Error Resume Next
    ChDir (currentdir$)
    CMDialog1.InitDir = arcpath$
    CMDialog1.filename = ""
    CMDialog1.DialogTitle = "Open Archive"
    CMDialog1.defaultExt = "arc"
    CMDialog1.Filter = "Archive Files (*.arc)|*.arc|All files(*.*)|*.*"
    CMDialog1.Action 1
    If CMDialog1.cancelled = False Then 'user pressed cancel
        filename$(1) = CMDialog1.filename
        antipath$ = CMDialog1.FileTitle
    Else
        Exit Sub
    End If
    ChDir (currentdir$)
    If filename$(1) = "" Then Exit Sub
    archivename$ = antipath$
    
    FileCopy filename$(1), arcpath$ + antipath$
    archivename$ = arcpath$ + antipath$

    'Load it here:
    filearchiver.Caption = "Archive Files (" + antipath$ + ")"
    archiveit = FreeFile
    filesinarchive.Clear
    Open archivename$ For Input As #archiveit
        Input #archiveit, filetype$
        If UCase$(filetype$) <> "RPGTLKIT ARCHIVE" Then
            MsgBox "This is not a valid Archive file"
            Close #archiveit
            Exit Sub
        End If
        Input #archiveit, majorver
        Input #archiveit, minorver
        If majorver <> Major Then
            MsgBox "This archive was created with an unrecognised version of the Toolkit", , "Unable to open Archive"
            Exit Sub
            Close #archiveit
        End If
        If minorver <> Minor Then
            user = MsgBox("This Archive was created using Version " + Str$(majorver) + "." + Str$(minorver) + ".  You have version " + CurrentVersion$ + ". Opening this file may not work.  Continue?", 4, "Different Version")
            If user = 7 Then Close #archiveit: Exit Sub     'selected no
        End If
        Line Input #archiveit, description$
        Line Input #archiveit, author$
        Line Input #archiveit, copyright$
        Do While Not EOF(archiveit)         'Now we'll look through the archive for files
            Line Input #1, test$            'Input a test line
            If UCase$(test$) = "::START::" Then     'We found the start of a file
                Line Input #1, inherefile$          'Input filename
                filesinarchive.AddItem LCase$(inherefile$)  'Add filename to list
            End If
        Loop
    Close #archiveit
    curarcname.Caption = archivename$
    descarc.Caption = description$
    authorname.Caption = author$
    copyname.Caption = copyright$
End Sub

Private Sub takefile_Click()
    On Error Goto errorhandler
    If archivename$ = "" Then MsgBox "No Archive opened", , "Open an archive file": Exit Sub
    fileextract$ = filesinarchive.text
    If fileextract$ = "" Then MsgBox "You must click on the filename to remove first", , "Remove File": Exit Sub
    user = MsgBox("Delete the file " + fileextract$ + " from the archive?", 4, "Remove File")
    If user = 6 Then
        filesinarchive.RemoveItem filesinarchive.ListIndex
        Call RemoveArchiveFile(archivename$, fileextract$)
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError()
    Resume Next
End Sub


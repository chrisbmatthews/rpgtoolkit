VERSION 2.00
Begin Form GetFilenames 
   BackColor       =   &H00FFFFFF&
   Caption         =   "Select Filename"
   ClientHeight    =   3885
   ClientLeft      =   1470
   ClientTop       =   1755
   ClientWidth     =   6480
   Height          =   4290
   Icon            =   FILENAME.FRX:0000
   Left            =   1410
   LinkTopic       =   "Form2"
   ScaleHeight     =   3885
   ScaleWidth      =   6480
   Top             =   1410
   Width           =   6600
Tag = "1081"
   Begin CommandButton Command2 
      Caption         =   "Cancel"
      Height          =   375
      Left            =   4800
      TabIndex        =   9
      Top             =   720
      Width           =   1455
Tag = "1008"
   End
   Begin CommandButton Command1 
      Caption         =   "OK"
      Height          =   375
      Left            =   4800
      TabIndex        =   8
      Top             =   240
      Width           =   1455
Tag = "1022"
   End
   Begin ComboBox FileType 
      Height          =   315
      Left            =   240
      TabIndex        =   6
      Text            =   "*.*"
      Top             =   3360
      Width           =   1935
   End
   Begin FileListBox filList 
      Height          =   2175
      Left            =   240
      TabIndex        =   5
      Top             =   600
      Width           =   2055
   End
   Begin DriveListBox drvList 
      Height          =   315
      Left            =   2400
      TabIndex        =   2
      Top             =   3360
      Width           =   2055
   End
   Begin DirListBox dirList 
      Height          =   2280
      Left            =   2400
      TabIndex        =   1
      Top             =   600
      Width           =   2055
   End
   Begin TextBox SelectFile 
      Height          =   285
      Left            =   240
      TabIndex        =   0
      Top             =   120
      Width           =   2055
   End
   Begin Label Label3 
      BackStyle       =   0  'Transparent
      Caption         =   "File Type:"
      Height          =   255
      Left            =   240
      TabIndex        =   7
      Top             =   3120
      Width           =   1695
Tag = "1588"
   End
   Begin Label Label2 
      BackStyle       =   0  'Transparent
      Caption         =   "Directories:"
      Height          =   255
      Left            =   2400
      TabIndex        =   4
      Top             =   240
      Width           =   2055
Tag = "1589"
   End
   Begin Label Label1 
      BackStyle       =   0  'Transparent
      Caption         =   "Drives:"
      Height          =   255
      Left            =   2400
      TabIndex        =   3
      Top             =   3120
      Width           =   1815
Tag = "1590"
   End
End

Sub Command1_Click ()
    On Error Goto errorhandler
    If selectfile.Text = "" Then
    selectfile.Text = filList.FileName
        'Exit Sub
    End If
    FileName$(whichfilenum) = dirlist.Path + "\" + selectfile.Text
    strippedfile$(whichfilenum) = selectfile.Text
    FilePath$(whichfilenum) = dirlist.Path + "\"
    GetFilenames.Hide

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError()
    Resume Next
End Sub

Sub Command2_Click ()
    On Error Goto errorhandler
    GetFilenames.Hide

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError()
    Resume Next
End Sub

Sub dirList_Change ()
    ' Update File listbox to sync with Dir listbox.
    On Error Goto errorhandler
    filList.Path = dirlist.Path


    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError()
    Resume Next
End Sub

Sub drvList_Change ()
    On Error GoTo DriveHandler
    dirlist.Path = drvList.Drive
    Exit Sub

DriveHandler:
    drvList.Drive = dirlist.Path
    Exit Sub

End Sub

Sub FileType_Change ()
    On Error Goto errorhandler
    filList.Pattern = filetype.Text

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError()
    Resume Next
End Sub

Sub FileType_Click ()
    On Error Goto errorhandler
    filList.Pattern = filetype.Text

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError()
    Resume Next
End Sub

Sub FileType_DropDown ()
    On Error Goto errorhandler
    filetype.Clear
    
    For t = 0 To 50
        If extention$(t) = "" Then t = 50 Else filetype.AddItem extention$(t)
    Next t
    'filetype.AddItem "*.*"
    'filetype.AddItem "*.txt"
    'filetype.AddItem "*.doc"
    'filetype.AddItem "*.bib"


    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError()
    Resume Next
End Sub

Sub filList_Click ()
    'SelectFile_Change
    'Selectfile.Text = filList.FileName
    On Error Goto errorhandler
End Sub

Sub filList_DblClick ()
   'SelectFile_Change
    On Error Goto errorhandler
    selectfile.Text = filList.FileName


    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError()
    Resume Next

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError()
    Resume Next
End Sub

Sub Form_Activate ()
    On Error Goto errorhandler
    filetype.Text = extention$(0)
    If extention$(0) = "" Then filetype.Text = "*.*"
    selectfile.Text = strippedfile$(whichfilenum)


    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError()
    Resume Next
End Sub

Sub Form_Load ()
    On Error Goto errorhandler
    filetype.Text =  extention$(0)
    If extention$(0) = "" Then filetype.Text = "*.*"
    selectfile.Text = strippedfile$(whichfilenum)
'    filetype.AddItem "*.*"
'    filetype.AddItem "*.txt"
'    filetype.AddItem "*.doc"
'    filetype.AddItem "*.bib"
'    Command1.Caption = "File 1"

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError()
    Resume Next
End Sub

Sub SelectFile_Change ()
    On Error GoTo errortrapper
    'filList.Pattern = SelectFile.Text
    'SelectFile.Text = filList.FileName
    filList.FileName = selectfile.Text
    Exit Sub

errortrapper:
Resume Next
End Sub

Sub selectfile_Click ()
    'filList.Pattern = SelectFile.Text
'    SelectFile.Text = filList.FileName
    On Error Goto errorhandler
End Sub


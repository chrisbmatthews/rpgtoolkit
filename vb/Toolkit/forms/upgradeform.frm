VERSION 5.00
Begin VB.Form upgradeform 
   Caption         =   "Filesystem Upgrade"
   ClientHeight    =   4605
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7530
   Icon            =   "upgradeform.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   ScaleHeight     =   4605
   ScaleWidth      =   7530
   StartUpPosition =   2  'CenterScreen
   Tag             =   "1780"
   Begin VB.CommandButton Command2 
      Caption         =   "Cancel"
      Height          =   375
      Left            =   2160
      TabIndex        =   6
      Tag             =   "1008"
      Top             =   4080
      Width           =   1455
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Next ->"
      Height          =   375
      Left            =   4200
      TabIndex        =   5
      Tag             =   "1781"
      Top             =   4080
      Width           =   1455
   End
   Begin VB.PictureBox Picture1 
      Height          =   3495
      Left            =   120
      ScaleHeight     =   3435
      ScaleWidth      =   2955
      TabIndex        =   0
      Top             =   240
      Width           =   3015
   End
   Begin VB.Label status 
      Height          =   255
      Left            =   120
      TabIndex        =   7
      Top             =   3840
      Width           =   3015
   End
   Begin VB.Label Label4 
      Caption         =   $"upgradeform.frx":030A
      Height          =   855
      Left            =   3240
      TabIndex        =   4
      Tag             =   "1782"
      Top             =   2880
      Width           =   4215
   End
   Begin VB.Label Label3 
      Caption         =   $"upgradeform.frx":03C6
      Height          =   1095
      Left            =   3240
      TabIndex        =   3
      Top             =   1680
      Width           =   4215
   End
   Begin VB.Label Label2 
      Caption         =   $"upgradeform.frx":04D4
      Height          =   855
      Left            =   3240
      TabIndex        =   2
      Tag             =   "1782"
      Top             =   720
      Width           =   4215
   End
   Begin VB.Label Label1 
      Caption         =   "File System Upgrade"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   14.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   3240
      TabIndex        =   1
      Tag             =   "1783"
      Top             =   240
      Width           =   4095
   End
End
Attribute VB_Name = "upgradeform"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'=======================================================
'Notes by KSNiloc for 3.04
'
' ---What is done
' + Option Explicit added
' + Swapped +s for &s where appropriate
' + Removed $s
' + Declared everything early-bound
'
' ---What needs to be done
' + Apply new visual style
'
'=======================================================

Option Explicit

Private Function getMainFilename() As String

    On Error Resume Next
    
    ChDir (currentDir)

    Dim dlg As FileDialogInfo
    With dlg
        .strDefaultFolder = gamPath
        .strTitle = "Open Main File"
        .strDefaultExt = "gam"
        .strFileTypes = "RPG Toolkit Main File (*.gam)|*.gam|All files(*.*)|*.*"
        If OpenFileDialog(dlg, Me.hwnd) Then
            filename(1) = .strSelectedFile
            Dim antiPath As String
            antiPath = .strSelectedFileNoPath
        Else
            Exit Function
        End If
    End With

    ChDir (currentDir)
    If filename(1) = "" Then Exit Function
    FileCopy filename(1), gamPath & antiPath
    Call openMainFile(filename(1))
    getMainFilename = antiPath

End Function

Private Sub Command1_Click()
    On Error Resume Next
    Dim antiPath As String
    antiPath = getMainFilename()
    Call openMainFile(filename(1))
    mainfile = antiPath
    configfile.lastProject = antiPath
    Do While mainMem.gameTitle = ""
        mainMem.gameTitle = InputBox("Please choose a name for your game", "Your game must have a name!", "My Game")
    Loop
    Dim tt As String
    tt = mainMem.gameTitle
    tt = replace(tt, "\", "")
    tt = replace(tt, "/", "")
    tt = replace(tt, ":", "")
    tt = replace(tt, " ", "")
    projectPath = gamePath & tt & "\"
    MsgBox "Your project will be placed in " & projectPath, , "Upgrade File System"
    Call saveMain(gamPath & antiPath, mainMem)
    'move the files...
    Call moveFilesInto(projectPath)
    'out with the old...
    Dim a As VbMsgBoxResult
    a = MsgBox("Your files have been upgraded to the new file system.  The old file system can now be deleted.  You might want to check and make sure that the files copied correctly before you delete the old filesystem.  To delete the old file system later, you can select 'Delete Old File System' from the main 'File' menu.  Would you like to delete the old file system now?", vbYesNo, "Delete Old File System")
    If a = vbYes Then
        'yes-- delete it now!
        Call DeleteOldFiles
    End If
    
    MsgBox "File System Upgrade Complete!", , "Upgrade"
    Unload Me
End Sub

Private Sub Command2_Click()
    Unload Me
End Sub

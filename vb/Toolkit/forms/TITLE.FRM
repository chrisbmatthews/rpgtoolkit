VERSION 5.00
Begin VB.Form Form1 
   Appearance      =   0  'Flat
   BackColor       =   &H80000005&
   BorderStyle     =   0  'None
   Caption         =   "RPG Toolkit Development System Version 2.0"
   ClientHeight    =   3720
   ClientLeft      =   2355
   ClientTop       =   840
   ClientWidth     =   5955
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
   Icon            =   "TITLE.frx":0000
   LinkTopic       =   "Form1"
   PaletteMode     =   1  'UseZOrder
   Picture         =   "TITLE.frx":0CCA
   ScaleHeight     =   3720
   ScaleWidth      =   5955
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Tag             =   "1092"
   Begin VB.Timer Timer1 
      Interval        =   1800
      Left            =   1080
      Top             =   2160
   End
   Begin VB.Label Label3 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Release 3.0.4 (August 2004)"
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   120
      TabIndex        =   2
      Tag             =   "1094"
      Top             =   2880
      Width           =   2775
   End
   Begin VB.Label Label2 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Professional Edition [Registered]"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   495
      Left            =   120
      TabIndex        =   1
      Tag             =   "1093"
      Top             =   3120
      Width           =   2415
   End
   Begin VB.Label Label1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Copyright 2003, 2004 By Christopher B. Matthews And Contibutors"
      ForeColor       =   &H00000000&
      Height          =   375
      Left            =   2520
      TabIndex        =   0
      Tag             =   "1094"
      Top             =   3240
      Width           =   3495
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984

Private Sub Command1_Click()
    On Error GoTo errorhandler
mainoption.Show
Unload Form1
Call openConfig("toolkit.cfg")
If tipsOnOff = 1 Then
    'DoEvents
    tips.Show
End If
If tutCurrentLesson = 0 Then
    'never run the tutorial before!
    tutorialask.Show
End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command2_Click()
    On Error GoTo errorhandler
a = FileExist("d:\vb\toolki~2\archives\new.arc#demo1.brd")
MsgBox str$(a)

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Command3_Click()
    On Error GoTo errorhandler
    a = roundoff(1.9)
    MsgBox a
    a = roundoff(1.3)
    MsgBox a

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Public Sub Form_Click()
    On Error GoTo errorhandler
    
    Call traceString("Showing main screen...")
    
    'mainoption.Show
    tkMainForm.Show
    
    Call traceString("Done main screen...")
    Unload Form1
    Call traceString("Opening config file...")
    
    Call openConfig("toolkit.cfg")
        
    Call traceString("Done config file...")
        
    If tipsOnOff = 1 Then
        'DoEvents
        Call traceString("Showing tips...")
        
        tips.Show
    
        Call traceString("Done tips...")
    End If
    If tutCurrentLesson = 0 Then
        'never run the tutorial before!
        
        Call traceString("Asking tutorial...")
        
        tutorialask.Show
    
        Call traceString("Done tutorial ask...")
    End If
    If m_LangFile = "" Then
        Call traceString("Asking language...")
            
        selectLanguage.Show
        
        Call traceString("Done language ask...")
    Else
        Call traceString("Setting lang..." + resourcePath$ + m_LangFile)
        
        Call ChangeLanguage(resourcePath$ + m_LangFile)
    
        Call traceString("Done Setting lang..." + resourcePath$ + m_LangFile)
    End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub

Private Sub Form_Load()
    On Error GoTo titleerror

    ' ! KSNiloc...
    CreateAssociation "prg", "RPGCode Program", App.path & "\" & App.EXEName & ".exe"
    If Command <> "" Then Timer1.interval = 1
    
    Call LocalizeForm(Me)

    Call StartTracing("tktrace.txt")

    Randomize Timer
    
    'a = fileExist("brddraw.exe")
    'If a = 0 Then usefastdrawYN = False Else usefastdrawYN = True
    useFastDraw = True
    
    boardList(activeBoardIndex).theData.Bsizex = 19: boardList(activeBoardIndex).theData.Bsizey = 11
    If Not (InitRuntime()) Then
        MsgBox "Could not initialize actkrt3.dll.  Do you have actkrt3.dll and freeimage.dll in the working directory?"
        End
    End If
    Call BoardInit(boardList(activeBoardIndex).theData)
    Call TileAnmClear(tileAnmList(activeTileAnmIndex).theData)
    Call InitTkGfx
    Call InitCanvasEngine(True)
   
    
    mainMem.mainResolution = 0
    
    
    currentdir$ = CurDir$
    
    Major = 2   'Version 2
    Minor = 0   ' version 2.0
    CurrentVersion$ = "2.1"
    compression = 1 'compression is used
    publicTile.transparentLayer = 0
    filename$(2) = ""
    drawlock = 0
    boardList(activeBoardIndex).gridBoard = 0
    enemylist(activeEnemyIndex).theData.eneSizeX = 1
    enemylist(activeEnemyIndex).theData.eneSizeY = 1
    
    ' KSNiloc...
    If Command = "" Then
        gamePath$ = "Game\"            'game dir
        MkDir Mid$(gamePath$, 1, Len(gamePath$) - 1)
        tilepath$ = "Tiles\"          'Tile dir path
        'MkDir Mid$(tilepath$, 1, Len(tilepath$) - 1)
        brdpath$ = "Boards\"           'board dir path
        'MkDir Mid$(brdpath$, 1, Len(brdpath$) - 1)
        tempath$ = "Chrs\"           'character dir path
        'MkDir Mid$(tempath$, 1, Len(tempath$) - 1)
        arcpath$ = "Archives\"           'archive dir path
        'MkDir Mid$(arcpath$, 1, Len(arcpath$) - 1)
        spcpath$ = "SpcMove\"       'spc move path
        'MkDir Mid$(spcpath$, 1, Len(spcpath$) - 1)
        bkgpath$ = "Bkrounds\"       'bkg path
        'MkDir Mid$(bkgpath$, 1, Len(bkgpath$) - 1)
        mediapath$ = "Media\"       'media path
        'MkDir Mid$(mediapath$, 1, Len(mediapath$) - 1)
        prgpath$ = "Prg\"       'prg path
        'MkDir Mid$(prgpath$, 1, Len(prgpath$) - 1)
        fontpath$ = "Font\"     'Font path
         itmpath$ = "Item\"     'Item path
        enepath$ = "Enemy\"     'enemy path
        gampath$ = "Main\"     'main file path
        MkDir Mid$(gampath$, 1, Len(gampath$) - 1)
        bmppath$ = "Bitmap\"     'bmp file path
        statuspath$ = "StatusE\"     'status effect
        helppath$ = "Help\"     'help file path
        MkDir Mid$(helppath$, 1, Len(helppath$) - 1)
        hashpath$ = "Hash\"     'hash file path
        miscPath$ = "Misc\"     'misc file path
        pluginPath$ = "Plugin\"     'plugin file path
        resourcePath$ = "Resources\"     'resource file path
        MkDir Mid$(resourcePath$, 1, Len(resourcePath$) - 1)
    Else
        gamePath = "Game\"
        projectPath = "Basic\"
        prgpath = "Prg\"
        helppath = "Help\"
    End If
    chances = 50
    'Clear character graphics:
    'For t = 1 To 16
    '    For x = 1 To 32
    '        For y = 1 To 32
    '            walkinggraphics(x, y, t) = -1
    '            itmwalk(x, y, t) = -1
    '        Next y
    '    Next x
    'Next t
    'For t = 1 To 10
    '    For x = 1 To 32
    '        For y = 1 To 32
    '            custom(x, y, t) = -1
    '        Next y
    '    Next x
    'Next t
    'For t = 1 To 4
    '    For x = 1 To 32
    '        For y = 1 To 32
    '            fightinggraphics(x, y, t) = -1
    '            smgraphics(x, y, t) = -1
    '            defensegraphics(x, y, t) = -1
    '            deadgraphics(x, y, t) = -1
    '        Next y
    '    Next x
    'Next t
    '    For x = 1 To 32
    '        For y = 1 To 32
    '            atrest(x, y) = -1
    '            itmrest(x, y) = -1
    '        Next y
    '    Next x
    For t = 1 To 6
        playerList(activePlayerIndex).theData.armorType(t) = 1
    Next t
    playerList(activePlayerIndex).theData.maxLevel = 99
    playerList(activePlayerIndex).theData.experienceIncrease = 2
    
    boardList(activeBoardIndex).spotLightRadius = 2
    boardList(activeBoardIndex).percentFade = 100
    'Set up tileedit
    publicTile.currentColor = vbQBColor(0)
    detail = 1
    For x = 1 To 32
        For y = 1 To 32
            tilemem(x, y) = -1
            publicTile.Undotile(x, y) = -1
            boardList(activeBoardIndex).BoardTile(x, y) = -1
        Next y
    Next x
    
    boardList(activeBoardIndex).theData.brdBack$ = ""            'Board background image
    boardList(activeBoardIndex).theData.borderBack$ = ""         'Border background image
    boardList(activeBoardIndex).theData.brdColor = vbQBColor(15)           'Board color
    boardList(activeBoardIndex).theData.borderColor = vbQBColor(0)        'Border color
    
    
    'Get old palette
    theerror = 0
    'Open "256RGB.pal" For Input As #1
    'For clr = 0 To 255
    '    Input #1, gfxgetdoscolor(clr)
    'Next clr
    'Close #1
    'Open "256to16.pal" For Input As #1
    'For clr = 0 To 255
    '    Input #1, oldpal(clr)
    'Next clr
    'Close #1
    'If theerror = 1 Then
    '    theerror = 0
    '    nowcol = 0
    '    For clr = 0 To 255
    '        oldpal(clr) = nowcol
    '        'gfxgetdoscolor(color) = vbqbcolor(nowcol)
    '        nowcol = nowcol + 1
    '        If nowcol > 15 Then nowcol = 0
    '    Next clr
    'End If
    
    ' Commented by KSNiloc
    'If Command$ <> "" Then
    '    'attempt to load a file...
    '    Call openConfig("toolkit.cfg")
    '    ex$ = extention(Command$)
    '    antiPath$ = absNoPath(Command$)
    '    ex$ = UCase$(ex$)
    '    Select Case ex$
    '        Case "GPH", "TST":
    '            FileCopy Command$, projectPath$ + tilepath$ + antiPath$
    '        Case "BRD":
    '            FileCopy Command$, projectPath$ + brdpath$ + antiPath$
    '        Case "PRG":
    '            FileCopy Command$, projectPath$ + prgpath$ + antiPath$
    '        Case "SPC":
    '            FileCopy Command$, projectPath$ + spcpath$ + antiPath$
    '        Case "TEM":
    '            FileCopy Command$, projectPath$ + tempath$ + antiPath$
    '        Case "ITM":
    '            FileCopy Command$, projectPath$ + itmpath$ + antiPath$
    '        Case "FNT":
    '            FileCopy Command$, projectPath$ + fontpath$ + antiPath$
    '        Case "ENE":
    '            FileCopy Command$, projectPath$ + enepath$ + antiPath$
    '        Case "BKG":
    '            FileCopy Command$, projectPath$ + bkgpath$ + antiPath$
    '        Case "WAV":
    '            FileCopy Command$, projectPath$ + mediapath$ + antiPath$
    '        Case "MID", "MP3", "MOD", "VOC":
    '            FileCopy Command$, projectPath$ + mediapath$ + antiPath$
    '        Case "GAM":
    '            FileCopy Command$, gampath$ + antiPath$
    '    End Select
    '    mainoption.Show
    '    mainoption.openFile (Command$)
    '    Unload Form1
    'End If
    
    Label2.Caption = LoadStringLoc(906, "Community Edition [Open Source]")
    
    Call InitLocalizeSystem
    
    
    Exit Sub

titleerror:
theerror = 1: Resume Next
End Sub

Private Sub Timer1_Timer()
    On Error GoTo errorhandler
    Call Form_Click
    Exit Sub
mainoption.Show
Unload Form1
Call openConfig("toolkit.cfg")
If tipsOnOff = 1 Then
    'DoEvents
    tips.Show
End If
If tutCurrentLesson = 0 Then
    'never run the tutorial before!
    tutorialask.Show
End If

    Exit Sub
'Begin error handling code:
errorhandler:
    Call HandleError
    Resume Next
End Sub



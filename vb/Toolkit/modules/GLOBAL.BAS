Attribute VB_Name = "GLOBAL"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'Global
'Global registered           'registered? 0- No, 1-Yes
Global currentdir$          'Current directory
'Global oldpal(255)          'Old palette
Global CurrentVersion$      'Version "2.0"
'FIXIT: Declare 'Major' with an early-bound data type                                      FixIT90210ae-R1672-R1B8ZE
Global Major                'Major version
'FIXIT: Declare 'Minor' with an early-bound data type                                      FixIT90210ae-R1672-R1B8ZE
Global Minor                'Minor version
'FIXIT: Declare 'oldvalue' with an early-bound data type                                   FixIT90210ae-R1672-R1B8ZE
Global oldvalue             'oldvalue for RGB
'FIXIT: Declare 'compression' with an early-bound data type                                FixIT90210ae-R1672-R1B8ZE
Global compression          'compression used?
Global filename$(30)        'Filename array
Global gamePath$            'path of games
Global tilepath$            'Tile dir path
Global brdpath$             'board dir path
Global tempath$             'character dir path
Global arcpath$             'archive dir path
Global spcpath$             'special move dir
Global bkgpath$             'board background dir
Global mediapath$           'media files
Global prgpath$             'prg files
Global fontpath$            'font files
Global itmpath$             'item path
Global enepath$             'enemy path
Global gampath$             'main file path
Global bmppath$             'bmp file path
Global statuspath$          'status effect path
Global miscPath$            'path for miscellaneous files (ie, anims, etc)
Global pluginPath$          'path of plugins
Global resourcePath$        'path for Toolkit.exe resource files, like wallpapers, etc
Global helppath$            'help file path
Global hashpath$            'path of hash files
Global projectPath$         'path of current project
Global mp3Path$             'starting path for mp3 files (the bard)
'Global gfxgetdoscolor(255)
Global fileToRename$        'filename of file to rename.

Global mainfileToRegister$  'the main file to register (w/registered version only)
Global mainfileToUnRegister$  'the main file to unregister (w/registered version only)


'Top most form
Public activeForm As Form   'the top most window


Global askedAboutProject As Boolean 'have you already asked about the project existing?

'Tile Editor
Global buftile(64, 32)      'Tile buffer. Edited for isometrics - 3.0.4
'
Public activeTile As tileedit

'tile bitmap editor
Public activeTileBmp As editTileBitmap     'active mdi child form
Public activeTileBmpIndex As Long     'index for active tile bitmap

'board editor
Public activeBoard As boardedit     'active mdi child form
Public activeBoardIndex As Long     'index for active board

'Character Editor
Public activePlayer As characteredit     'active mdi child form
Public activePlayerIndex As Long     'index for active board
'Global playerlist(activeplayerindex).thedata As TKPlayer


'Item Editor:
Public activeItem As EditItem     'active mdi child form
Public activeItemIndex As Long     'index for active item
'Global itemList(activeitemindex).thedata As TKItem


'Main File editor
Global mainMem As TKMain    'main file

'Program editor
Public activeRPGCode As rpgcodeedit 'active mdi child form
Public activeRPGCodeIndex As Long   'index for active item

'enemy editor
Public activeEnemy As editenemy     'active mdi child form
Public activeEnemyIndex As Long     'index for active enemy
'Global enemylist(activeenemyindex).thedata As TKEnemy

'Special move editor
Public activeSpecialMove As editsm     'active mdi child form
Public activeSpecialMoveIndex As Long     'index for active special move
'Global specialmovelist(activespecialmoveindex).thedata As TKSpecialMove

'Background editor
Public activeBackground As editBackground     'active mdi child form
Public activeBkgIndex As Long     'index for active bkg

'status effect editor
Public activeStatusEffect As editstatus     'active mdi child form
Public activeStatusEffectIndex As Long     'index for active status effect
'Global statuseffectlist(activestatuseffectindex).thedata As TKStatusEffect

    
    
'animation editor
Public activeAnimation As animationeditor
Public activeAnimationIndex As Long
    
    
'animated tile editor
Public activeTileAnm As tileanim     'active mdi child form
Public activeTileAnmIndex As Long     'index for active tile anm
'Global tileanmlist(activetileanmindex).thedata As TKTileAnm  'animated tile
    
'For color conversion
Global qbtile(32, 32)
'FIXIT: Declare 'colorcode' with an early-bound data type                                  FixIT90210ae-R1672-R1B8ZE
Global colorCode(15)
'FIXIT: Declare 'coloruse' with an early-bound data type                                   FixIT90210ae-R1672-R1B8ZE
Global coloruse
'FIXIT: Declare 'newcolor' with an early-bound data type                                   FixIT90210ae-R1672-R1B8ZE
Global newcolor


'tileset
Global tstFile$             'filename of tileset
Global setFilename$         'filename of selected time in tileset.

'FIXIT: Declare 'ignore' with an early-bound data type                                     FixIT90210ae-R1672-R1B8ZE
Global ignore               'ignore next click 0-no, 1-yes
Global lastTileset$         'filename of last tst
'FIXIT: Declare 'tstStop' with an early-bound data type                                    FixIT90210ae-R1672-R1B8ZE
Global tstStop              'stop comparing

'FIXIT: Declare 'tstnum' with an early-bound data type                                     FixIT90210ae-R1672-R1B8ZE
Global tstnum              'current location in tileset

Global oldpath$     'old path in file explorer.

'config options
'FIXIT: Declare 'tipsOnOff' with an early-bound data type                                  FixIT90210ae-R1672-R1B8ZE
Global tipsOnOff            'tip window on/off (0=off, 1=on)
Global tipFile$             'tipfilename
'FIXIT: Declare 'tipNum' with an early-bound data type                                     FixIT90210ae-R1672-R1B8ZE
Global tipNum               'current tip number
'FIXIT: Declare 'commandsDocked' with an early-bound data type                             FixIT90210ae-R1672-R1B8ZE
Global commandsDocked       'command buttons docked (hidden) 0=no, 1=yes
'FIXIT: Declare 'filesDocked' with an early-bound data type                                FixIT90210ae-R1672-R1B8ZE
Global filesDocked          'file dialog docked?
Global lastProject$         'last project opened.
Global wallpaper$           'wallpaper file
Global quickEnabled(4) As Integer   'quick launch enabled 1-yes, 0-no
Global quickTarget$(4)      'quick launch targets
Global quickIcon$(4)        'quick launch icons
Global tutCurrentLesson As Integer  'current tuorial lesson (0=never run)

'Not used-- actually used in trans3, but we need to declare them so the common files know what they are
Public allPurposeCanvas As Long 'not used
Public gTranspCOlor As Long 'not used
Private Type BoardRender
    file As String
    canvas As Long
    canvasMask As Long
    topX As Double
    topY As Double
    tilesX As Long
    tilesY As Long
    shader As Long
    shadeg As Long
    shadeb As Long
    isometric As Long
End Type
Public lastRender As BoardRender    'not used
Public topX As Long
Public topY As Long
Public fontName As String
Public screenWidth As Long, screenHeight As Long
Public gGameState As Long
Public gPrevGameState As Long
'Game states...
Public Const GS_IDLE = 0    'just re-renders the screen
Public Const GS_QUIT = 1    'shutdown sequence
Public Const GS_MOVEMENT = 2    'movement is occurring (players or items)
Public Const GS_DONEMOVE = 3    'movement is finished
Public Const GS_PAUSE = 4   'pause game

'Form types...
Public Const FT_BOARD = 11     'board editor
Public Const FT_ANIMATION = 12
Public Const FT_CHARACTER = 13
Public Const FT_BACKGROUND = 14
Public Const FT_ENEMY = 15
Public Const FT_ITEM = 16
Public Const FT_MAINFILE = 17
Public Const FT_SM = 18
Public Const FT_STATUS = 19
Public Const FT_TILEBITMAP = 20
Public Const FT_RPGCODE = 21
Public Const FT_TILEANIM = 22
Public Const FT_TILE = 23
Public Const FT_GRAB = 24       'Added for grabber - 3.0.4

'Added by KSNiloc...
Global needsReColor As Boolean
Global programEditorCount As Long
Global programEditorCountDown As Long
Global Images As New clsImages


'Required for commonboard
Public itemMem() As Boolean
Public itmPos() As Boolean

Public xrange As Long
Public Sub ChangeBoolean(ByRef bol As Boolean)
 If bol = True Then bol = False Else bol = True
End Sub

Public Function BooleanToLong(ByVal bol As Boolean) As Long
 If bol = True Then BooleanToLong = 1
 If bol = False Then BooleanToLong = 0
End Function

Public Function integerToBoolean(ByVal inte As Integer) As Boolean
 If inte = 1 Then integerToBoolean = True
 If inte = 0 Then integerToBoolean = False
End Function

Public Function leftBit(ByVal str1 As String, ByVal str2 As String) As Boolean
 If Left(str1, Len(str2)) = str2 Then leftBit = True
End Function


Attribute VB_Name = "Globals"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'=======================================================
' Globals
'
' Contains various misc globals and constants.
'=======================================================

'=======================================================
'Cleaned up a bit, 3.0.4 by KSNiloc
'
' ---What is done
' + Option Explicit added
' + Unused declarations removed
' + Swapped $s for 'as string'
' + Removed variants
' + Swapped 'Global' for 'Public'
'
'=======================================================

Option Explicit

'Misc Variables
Public currentDir As String                    'Current directory
Public oldValue As Long                        'oldValue for RGB
Public filename(1 To 5) As String              'filename array
Public projectPath As String                   'path of current project
Public mp3Path As String                       'starting path for mp3 files (the bard)

'Misc Constants
Public Const compression = 1                   'use compression where avaliable
Public Const major = 2                         '[now] arbitrary value
Public Const minor = 0                         '[now] arbitrary value
Public Const gamePath = "Game\"                'game dir
Public Const tilePath = "Tiles\"               'Tile dir path
Public Const brdPath = "Boards\"               'board dir path
Public Const temPath = "Chrs\"                 'character dir path
Public Const arcPath = "Archives\"             'archive dir path
Public Const spcPath = "SpcMove\"              'spc move path
Public Const bkgPath = "Bkrounds\"             'bkg path
Public Const mediaPath = "Media\"              'media path
Public Const prgPath = "Prg\"                  'prg path
Public Const fontPath = "Font\"                'Font path
Public Const itmPath = "Item\"                 'Item path
Public Const enePath = "Enemy\"                'enemy path
Public Const gamPath = "Main\"                 'main file path
Public Const bmpPath = "Bitmap\"               'bmp file path
Public Const statusPath = "StatusE\"           'status effect
Public Const helpPath = "Help\"                'help file path
Public Const hashPath = "Hash\"                'hash file path
Public Const miscPath = "Misc\"                'misc file path
Public Const pluginPath = "Plugin\"            'plugin file path
Public Const resourcePath = "Resources\"       'resource file path
Public Const plugPath = "Plugin\"

'Top most form
Public activeForm As Form   'the top most window

Public askedAboutProject As Boolean 'have you already asked about the project existing?

'Tile Editor
Public buftile(64, 32) As Long     'Tile buffer. Edited for isometrics - 3.0.4
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

'Item Editor:
Public activeItem As EditItem     'active mdi child form
Public activeItemIndex As Long     'index for active item

'Main File editor
Public mainMem As TKMain    'main file

'Program editor
Public activeRPGCode As rpgcodeedit 'active mdi child form
Public activeRPGCodeIndex As Long   'index for active item

'enemy editor
Public activeEnemy As editenemy     'active mdi child form
Public activeEnemyIndex As Long     'index for active enemy

'Special move editor
Public activeSpecialMove As editsm     'active mdi child form
Public activeSpecialMoveIndex As Long     'index for active special move

'Background editor
Public activeBackground As editBackground     'active mdi child form
Public activeBkgIndex As Long     'index for active bkg

'status effect editor
Public activeStatusEffect As editstatus     'active mdi child form
Public activeStatusEffectIndex As Long     'index for active status effect

'animation editor
Public activeAnimation As animationeditor
Public activeAnimationIndex As Long

'animated tile editor
Public activeTileAnm As tileanim     'active mdi child form
Public activeTileAnmIndex As Long     'index for active tile anm

'For color conversion
Public qbtile(32, 32) As Long
Public colorCode(15) As Long
Public coloruse As Long
Public newcolor As Long

'tileset
Public tstFile As String             'filename of tileset
Public setFilename As String         'filename of selected time in tileset.
Public ignore As Integer               'ignore next click 0-no, 1-yes
Public lastTileset As String         'filename of last tst
Public tstStop As Integer              'stop comparing
Public tstnum As Long              'current location in tileset
Public oldpath As String     'old path in file explorer.

'config options
Public tipsOnOff As Integer            'tip window on/off (0=off, 1=on)
Public tipFile As String              'tipfilename
Public tipNum As Long               'current tip number
Public commandsDocked As Integer       'command buttons docked (hidden) 0=no, 1=yes
Public filesDocked As Integer         'file dialog docked?
Public lastProject As String         'last project opened.
Public wallpaper As String           'wallpaper file
Public quickEnabled(4) As Integer   'quick launch enabled 1-yes, 0-no
Public quickTarget(4) As String      'quick launch targets
Public quickIcon(4) As String        'quick launch icons
Public tutCurrentLesson As Integer  'current tuorial lesson (0=never run)

'Not used-- actually used in trans3, but we need to declare them so the common files know what they are
Public allPurposeCanvas As Long 'not used
Public gTranspColor As Long 'not used
Public transPlugin As Object 'not used

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
Public needsReColor As Boolean
Public programEditorCount As Long
Public programEditorCountDown As Long
Public Images As New clsImages

'Required for commonboard
Public itemMem() As Boolean
Public itmPos() As Boolean

'Currently running version
Public Property Get currentVersion() As String
    currentVersion = App.major & "." & App.minor & "." & App.Revision
End Property

Attribute VB_Name = "CommonGlobals"
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

#If isToolkit = 0 Then

    '=======================================================
    'Trans globals
    '=======================================================

    'Misc variables
    Public savPath As String                   'saved games

    'File type memories
    Public animationMem As TKAnimation         'animation file
    Public playerMem(4) As TKPlayer            'player files
    Public itemMem() As TKItem                 'item files
    Public specialMoveMem As TKSpecialMove
    Public bkgMem As TKBackground
    Public statusMem As TKStatusEffect
    Public enemyMem(4) As TKEnemy

    'File manipulation
    Public openFile() As String
    Public openFullFile() As String

#Else

    '=======================================================
    'Toolkit globals
    '=======================================================

    'tileset
    Public tstFile As String             'filename of tileset
    Public setFilename As String         'filename of selected time in tileset.
    Public ignore As Integer               'ignore next click 0-no, 1-yes
    Public tstStop As Integer              'stop comparing
    Public tstnum As Long              'current location in tileset
    Public oldpath As String     'old path in file explorer.

    'config options
    Public configfile As New CConfig

    Public TRANSP_COLOR As Long 'not used
    Public topX As Long
    Public topY As Long
    Public fontName As String
    Public screenWidth As Long, screenHeight As Long

    'Misc
    Public askedAboutProject As Boolean            'have you already asked about the project existing?
    Public needsReColor As Boolean
    Public programEditorCount As Long
    Public programEditorCountDown As Long
    Public Images As New CImages
    Public lockIndice As Long
    Public useLockIndice As Boolean
      
    'Form indexes
    Public activeRPGCodeIndex As Long   'index for active rpgcode
    
#End If

'=======================================================
'Common globals
'=======================================================

'Misc variables
Public currentDir As String                    'Current directory
Public oldValue As Long                        'oldValue for RGB
Public filename(1 To 5) As String              'filename array
Public projectPath As String                   'path of current project
Public mp3Path As String                       'starting path for mp3 files (the bard)

'Misc constants
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
Public Const resourcePath = "Resources\"       'resource file path
Public Const plugPath = "Plugin\"              'plugin path

Public bufTile(64, 32) As Long
Public activeTileBmpIndex As Long              'index for active tile bitmap
Public activeBoardIndex As Long                'index for active board
Public activePlayerIndex As Long               'index for active board
Public activeItemIndex As Long                 'index for active item
Public mainMem As TKMain                       'main file
Public activeEnemyIndex As Long                'index for active enemy
Public activeSpecialMoveIndex As Long          'index for active special move
Public activeBkgIndex As Long                  'index for active bkg
Public activeStatusEffectIndex As Long         'index for active status effect
Public activeAnimationIndex As Long            'index for active animation
Public activeTileAnmIndex As Long              'index for active tile anm

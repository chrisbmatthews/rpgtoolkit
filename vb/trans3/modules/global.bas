Attribute VB_Name = "modGlobals"
'All contents copyright 2003, 2004, Christopher Matthews or Contributors
'All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
'Read LICENSE.txt for licensing info

'=======================================================
'Cleaned up a bit, 3.0.4 by KSNiloc
'
' ---What is done
' + Removed variants
' + Added Option Explicit
' + Removed unused variables
' + Made some things constants
'
' ---What needs to be done
' + Examine usage of variables to nominalize boxing
'
'=======================================================

Option Explicit

'Misc globals
Public currentDir As String                    'Current directory
Public filename(1 To 5) As String              'Filename array
Public savPath As String                       'saved games
Public projectPath As String                   'project path
Public host As Form                            'host form object

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
Public Const plugPath = "Plugin\"              'plugin file path
Public Const resourcePath = "Resources\"       'resource file path
Public Const isToolkit As Boolean = False      'is this the editor?

Public tkMainForm As Form                      'not used

'Tile Editor
Public buftile(32, 32) As Long                 'Tile buffer
Public lastTileset As String

'Board Editor
Public activeBoardIndex As Long                'index for active board

'Character Editor
Public playerMem(4) As TKPlayer
Public activePlayerIndex As Long

'Item Editor:
Public itemMem() As TKItem

Public activeItemIndex As Long

'mainForm File editor
Public mainMem As TKMain

'enemy editor
Public enemyMem(4) As TKEnemy
Public activeEnemyIndex As Long                 'index of active enemy

'Special move editor
Public specialMoveMem As TKSpecialMove
Public activeSpecialMoveIndex As Long

'Background editor
Public bkgMem As TKBackground
Public activeBkgIndex As Long

'status effect editor
Public statusMem As TKStatusEffect
Public activeStatusEffectIndex As Long

'animation editor
Public animationMem As TKAnimation              'animation file
Public activeAnimationIndex As Long
Public activeTileAnmIndex As Long

'File manipulation
Public openFile() As String
Public openFullFile() As String

'Currently running version
Public Property Get currentVersion() As String
    currentVersion = App.major & "." & App.minor & "." & App.Revision
End Property

'Dummy sub
Public Sub SetParent(ByVal hwnd As Long, ByVal parent As Long)
    'Do nothing
End Sub

Attribute VB_Name = "Global"
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
'FIXIT: Declare 'compression' with an early-bound data type                                FixIT90210ae-R1672-R1B8ZE
Global compression          'compression used?
Global filename$(30)        'Filename array
Global tilePath$            'Tile dir path
Global brdPath$             'board dir path
Global temPath$             'character dir path
Global arcPath$             'archive dir path
Global spcPath$             'special move dir
Global bkgPath$             'board background dir
Global mediaPath$           'media files
Global prgPath$             'prg files
Global fontPath$            'font files
Global itmPath$             'item path
Global enePath$             'enemy path
Global gamPath$             'mainForm file path
Global bmpPath$             'bmp files
Global statusPath$          'status effect path
Global miscPath$            'miscellaneous path (ie, anims)
Global pluginPath$          'plugin path
Global savPath$             'saved games
Global projectPath$         'project path
Global resourcePath$        'resource path
'Global gfxgetdoscolor(255)
Global nocodeYN As Boolean   'did it have nocode?


'Tile Editor
Global buftile(32, 32)      'Tile buffer

'Board Editor
Public activeBoardIndex As Long     'index for active board

'Character Editor
Global playerMem(4) As TKPlayer
Public activePlayerIndex As Long

'Item Editor:
' ! MODIFIED BY KSNiloc...
Global itemMem() As TKItem

Public activeItemIndex As Long

'mainForm File editor
Global mainMem As TKMain

'enemy editor
Global enemyMem(4) As TKEnemy
Public activeEnemyIndex As Long 'index of active enemy

'Special move editor
Global specialMoveMem As TKSpecialMove
Public activeSpecialMoveIndex As Long

'Background editor
Global bkgMem As TKBackground
Public activeBkgIndex As Long

'status effect editor
Global statusMem As TKStatusEffect
Public activeStatusEffectIndex As Long

'animation editor
Public animationMem As TKAnimation  'animation file
Public activeAnimationIndex As Long

Public activeTileAnmIndex As Long

'''Globals added by KSNiloc'''

'file manipulation (modified by KSNiloc)
Public OpenFile() As String
Public OpenFullFile() As String

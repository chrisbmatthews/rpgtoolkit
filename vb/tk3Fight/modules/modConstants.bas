Attribute VB_Name = "modConstants"
'====================================================================================
' The RPG Toolkit Version 3 Default Battle System
' This file copyright (C) 2004-2007 Colin James Fitzpatrick
'====================================================================================
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
'====================================================================================

'====================================================================================
'Callback constant module
'====================================================================================

Option Explicit

'====================================================================================
'Data types
'====================================================================================
Public Const DT_NUM As Integer = 0
Public Const DT_LIT As Integer = 1
'====================================================================================
'Plugin types
'====================================================================================
Public Const PT_RPGCODE = 1
Public Const PT_MENU = 2
Public Const PT_FIGHT = 4
'====================================================================================
'Menu types
'====================================================================================
Public Const MNU_MAIN = 1         'main menu requested
Public Const MNU_INVENTORY = 2     'inventory menu requested
Public Const MNU_EQUIP = 4         'equip menu requested
Public Const MNU_ABILITIES = 8     'abilities menu requested
'====================================================================================
'fightInform() constants
'====================================================================================
Public Const INFORM_REMOVE_HP = 0   'hp was removed
Public Const INFORM_REMOVE_SMP = 1   'smp was removed
Public Const INFORM_SOURCE_ATTACK = 2   'source attacks
Public Const INFORM_SOURCE_SMP = 3   'source does special move
Public Const INFORM_SOURCE_ITEM = 4   'source uses item
Public Const INFORM_SOURCE_CHARGED = 5   'source is charged
Public Const INFORM_SOURCE_DEAD = 6 'source has died
Public Const INFORM_SOURCE_PARTY_DEFEATED = 7 'source party is all dead
'====================================================================================
'Constants you can return for Fight()
'====================================================================================
Public Const FIGHT_RUN_AUTO = 0                   'Player party ran - have trans apply the running progrma for us
Public Const FIGHT_RUN_MANUAL = 1                 'Player party ran - tell trans that the plugin has already executed the run prg
Public Const FIGHT_WON_AUTO = 2                   'Player party won - have trans apply the rewards for us
Public Const FIGHT_WON_MANUAL = 3                 'Player party won - tell trans that the plugin has already given rewards
Public Const FIGHT_LOST = 4                       'Player party lost
'====================================================================================
'Numerical Defines: (to be passed into CBGetEnemyNum as nInfoCode)
'====================================================================================
Public Const ENE_HP = 0                               'enemy hp level
Public Const ENE_MAXHP = 1                            'enemy max hp level
Public Const ENE_SMP = 2                              'enemy smp level
Public Const ENE_MAXSMP = 3                        'enemy max smp level
Public Const ENE_FP = 4                               'enemy fp
Public Const ENE_DP = 5                               'enemy dp
Public Const ENE_RUNYN = 6                            'can we run from enemy? 0- no, 1- yes
Public Const ENE_SNEAKCHANCES = 7             'chances of sneaking up on enemy
Public Const ENE_SNEAKUPCHANCES = 8       'chances of enemy snaking up on you
Public Const ENE_SIZEX = 9                            'enemy size x
Public Const ENE_SIZEY = 10                       'enemy size y
Public Const ENE_AI = 11                          'enemy AI level 0- very low ... 4- very high
Public Const ENE_EXP = 12                         'experience you get from defeating enemy
Public Const ENE_GP = 13                          'GP you get from defeating enemy
'====================================================================================
'String Defines: (to be passed into CBGetEnemyInfoString as nInfoCode)
'====================================================================================
Public Const ENE_FILENAME = 0                     'enemy filename
Public Const ENE_NAME = 1                             'enemy name
Public Const ENE_RPGCODEPROGRAM = 2      'rpgcode program to run as AI
Public Const ENE_DEFEATPRG = 3                    'rpgcode program to run when enemy is defeated
Public Const ENE_RUNPRG = 4                       'program to run when player runs away
Public Const ENE_ATTACKSOUND = 5              'filename of sound to play when enemy does phys attack
Public Const ENE_SMSOUND = 6                      'filename of sound to play when enemy does special move
Public Const ENE_HITSOUND = 7                     'filename of sound to play when enemy is hit
Public Const ENE_DIESOUND = 8                     'filename of sound to play when enemy dies
'====================================================================================
'Numerical Defines: (to be passed into CBGetPlayerNum as nInfoCode)
'====================================================================================
Public Const PLAYER_INITXP = 0                  'initial experience level
Public Const PLAYER_INITHP = 1                  'initial health level
Public Const PLAYER_INITMAXHP = 2           'initial max health level
Public Const PLAYER_INITDP = 3                  'initial dp level
Public Const PLAYER_INITFP = 4                  'initial fp level
Public Const PLAYER_INITSMP = 5                 'initial smp level
Public Const PLAYER_INITMAXSMP = 6          'initial max smp level
Public Const PLAYER_INITLEVEL = 7           'initial level
Public Const PLAYER_DOES_SM = 8             'player does special moves? 0- no, 1- yes
Public Const PLAYER_SM_MIN_EXPS = 9     'minimum experience for each special move (arrayPos 0-200)
Public Const PLAYER_SM_MIN_LEVELS = 10   'minimum level required for each special move (arrayPos 0-200)
Public Const PLAYER_ARMOURS = 11        'is armour type used?  0=no, 1=yes (arrayPos 0-6)
Public Const PLAYER_LEVELTYPE = 12      'level progression type
Public Const PLAYER_XP_INCREASE = 13 'experience increase factor for each level
Public Const PLAYER_MAXLEVEL = 14           'max level
Public Const PLAYER_HP_INCREASE = 15    'hp increase on level up
Public Const PLAYER_DP_INCREASE = 16    'dp increase on level up
Public Const PLAYER_FP_INCREASE = 17    'fp increase on level up
Public Const PLAYER_SMP_INCREASE = 18   'smp increase on level up
Public Const PLAYER_LEVELUP_TYPE = 19   'level up type 0=exponential, 1=linear
Public Const PLAYER_DIR_FACING = 20     'direction player is facing (1=south, 2=west, 3=north, 4=east)
Public Const PLAYER_NEXTLEVEL = 21      'percentage of next level gained (0 - 100)
'====================================================================================
'String Defines: (to be passed into CBGetPlayerString as nInfoCode)
'====================================================================================
Public Const PLAYER_NAME = 0                        'player name (handle)
Public Const PLAYER_XP_VAR = 1                  'player experience var
Public Const PLAYER_DP_VAR = 2                  'player dp var
Public Const PLAYER_FP_VAR = 3                  'player fp var
Public Const PLAYER_HP_VAR = 4                  'player hp var
Public Const PLAYER_MAXHP_VAR = 5           'player max hp var
Public Const PLAYER_NAME_VAR = 6                'player name var
Public Const PLAYER_SMP_VAR = 7                 'player smp var
Public Const PLAYER_MAXSMP_VAR = 8          'player max smp var
Public Const PLAYER_LEVEL_VAR = 9           'player level var
Public Const PLAYER_PROFILE = 10            'player profile picture filename
Public Const PLAYER_SM_FILENAMES = 11   'player spcial move filename array (arrayPos 0-200)
Public Const PLAYER_SM_NAME = 12        'player spcial move names
Public Const PLAYER_SM_CONDVARS = 13 'player special move conditional vars (arrayPos 0-200)
Public Const PLAYER_SM_CONDVARSEQ = 14  'player special move conditional variable conditions (arrayPos 0-200)
Public Const PLAYER_ACCESSORIES = 15 'player accessory names (arrayPos 0-10)
Public Const PLAYER_SWORDSOUND = 16     'player sword swipe sound
Public Const PLAYER_DEFENDSOUND = 17 'player defend sound
Public Const PLAYER_SMSOUND = 18        'player special move sound
Public Const PLAYER_DEATHSOUND = 19     'player death sound
Public Const PLAYER_RPGCODE_LEVUP = 20 'player rpgcode program to run on level up
'====================================================================================
'String Defines: (to be passed into CBGetGeneralString as nInfoCode)
'====================================================================================
Public Const GEN_PLAYERHANDLES = 0          'handles of players (nPlayerSlot 0-4)
Public Const GEN_PLAYERFILES = 1                'filenames of players (nPlayerSlot 0-4)
Public Const GEN_PLYROTHERHANDLES = 2   'handles of other players (nArrayPos 0-25)
Public Const GEN_PLYROTHERFILES = 3         'filenames of other players (nArrayPos 0-25)
Public Const GEN_INVENTORY_FILES = 4        'filenames of inventory slots (nArrayPos 0-500)
Public Const GEN_INVENTORY_HANDLES = 5  'handles of inventory slots (nArrayPos 0-500)
Public Const GEN_EQUIP_FILES = 6                'filenames of equipped items (nArrayPos 0-16 (equip slot), nPlayerSlot 0-4)
Public Const GEN_EQUIP_HANDLES = 7          'handles of equipped items (nArrayPos 0-16 (equip slot), nPlayerSlot 0-4)
Public Const GEN_MUSICPLAYING = 8           'currently playing music
Public Const GEN_CURRENTBOARD = 9           'current board filename
Public Const GEN_MENUGRAPHIC = 10               'filename of menu graphic
Public Const GEN_FIGHTMENUGRAPHIC = 11 'filename of fight menu graphic
Public Const GEN_MWIN_PIC_FILE = 12     'filename mwin graphic
Public Const GEN_FONTFILE = 13              'filename font
Public Const GEN_ENE_FILE = 14              'filename of loaded enemies (nPlayerSlot 0-3)
Public Const GEN_ENE_WINPROGRAMS = 15   'filenames of programs to run after defeating enemies (nPlayerSlot 0-3)
Public Const GEN_ENE_STATUS = 16            'filenames of status effects applied to enemies (nArrayPos 0-10, nPlayerSlot 0-3)
Public Const GEN_PLYR_STATUS = 17           'filenames of status effects applied to players (nArrayPos 0-10, nPlayerSlot 0-4)
Public Const GEN_CURSOR_MOVESOUND = 18  'filename of the cursor move sound
Public Const GEN_CURSOR_SELSOUND = 19   'filename of the cursor selection sound
Public Const GEN_CURSOR_CANCELSOUND = 20 'filename of the cursor cancel sound
'====================================================================================
'Numerical defines: (to be passed into CBGetGeneralNum as nInfoCode)
'====================================================================================
Public Const GEN_INVENTORY_NUM = 0          'number of each item in inventory (nArrayPos 0-500)
Public Const GEN_EQUIP_HPADD = 1                'amount of hp added to player by equipment (nPlayerslot 0-4)
Public Const GEN_EQUIP_SMPADD = 2           'amount of smp added to player by equipment (nPlayerslot 0-4)
Public Const GEN_EQUIP_DPADD = 3                'amount of dp added to player by equipment (nPlayerslot 0-4)
Public Const GEN_EQUIP_FPADD = 4                'amount of fp added to player by equipment (nPlayerslot 0-4)
Public Const GEN_CURX = 5                           'current player x pos (nPlayerSlot 0-4)
Public Const GEN_CURY = 6                           'current player y pos (nPlayerSlot 0-4)
Public Const GEN_CURLAYER = 7                   'current player layer pos (nPlayerSlot 0-4)
Public Const GEN_CURRENT_PLYR = 8           'currently selected player
Public Const GEN_TILESX = 9                     'size of screen x (in tiles)
Public Const GEN_TILESY = 10                'size of screen y (in tiles)
Public Const GEN_BATTLESPEED = 11           'current battle speed (returns 0=slow -> 8=fast)
Public Const GEN_TEXTSPEED = 12             'current text speed (returns 0=slow -> 3=fast)
Public Const GEN_CHARACTERSPEED = 13    'current character speed (returns 0=slow -> 3=fast)
Public Const GEN_SCROLLINGOFF = 14      'is scrolling turned off? 0=no, 1=yes
Public Const GEN_RESX = 15                      'screen x resolution, in pixels
Public Const GEN_RESY = 16                      'screen y resolution, in pixels
Public Const GEN_GP = 17                         'gp carried by player
Public Const GEN_FONTCOLOR = 18             'color of font (rgb value-- use red, green, blue fns)
Public Const GEN_PREV_TIME = 19             'time spent in previuously loaded game
Public Const GEN_START_TIME = 20            'time at start of game
Public Const GEN_GAME_TIME = 21             'length of game, in seconds
Public Const GEN_STEPS = 22                     'number of steps taken
Public Const GEN_ENE_RUN = 23                   'can we run from the currently loaded enemies? 0=no, 1=yes
Public Const GEN_ENEX = 24                      'x location of each enemy (nPlayerSlot 0-3)
Public Const GEN_ENEY = 25                      'y location of each enemy (nPlayerSlot 0-3)
Public Const GEN_FIGHT_OFFSETX = 26     'fighting window x offset, in tiles
Public Const GEN_FIGHT_OFFSETY = 27     'fighting window y offset, in tiles
Public Const GEN_TRANSPARENTCOLOR = 28  'color used as the 'transparent' color universally throughout the engine
'====================================================================================
'String Defines: (to be passed into CBGetPathString as nInfoCode)
'====================================================================================
Public Const PATH_TILE = 0                          'tile path
Public Const PATH_BOARD = 1                     'board path
Public Const PATH_CHAR = 2                          'character path
Public Const PATH_SPC = 3                           'special move path
Public Const PATH_BKG = 4                           'background path
Public Const PATH_MEDIA = 5                     'media path
Public Const PATH_PRG = 6                           'prg path
Public Const PATH_FONT = 7                          'font path
Public Const PATH_ITEM = 8                          'item path
Public Const PATH_ENEMY = 9                     'enemy path
Public Const PATH_MAIN = 10                     'main file path
Public Const PATH_BITMAP = 11                   'bitmap path
Public Const PATH_STATUSFX = 12             'status effects path
Public Const PATH_MISC = 13                     'misc path
Public Const PATH_SAVE = 14                     'saved games path
Public Const PATH_PROJECT = 15              'project path
'====================================================================================
'String Defines: (to be passed into CBGetSpecialMoveString as nInfoCode)
'====================================================================================
Public Const SPC_NAME = 0                           'name of special move
Public Const SPC_PRG_FILE = 1                   'filename of rpgcode program to run
Public Const SPC_STATUSFX = 2                   'status effect filename connected to this move
Public Const SPC_ANIMATION = 3                  'filename of animation connected to this move
Public Const SPC_DESCRIPTION = 4                'description of special move.
'====================================================================================
'Numerical Defines: (to be passed into CBGetSpecialMoveNum as nInfoCode)
'====================================================================================
Public Const SPC_FP = 0                             'fp of special move
Public Const SPC_SMP = 1                                'smp of special move
Public Const SPC_TARGET_SMP = 2                 'smp to remove from target
Public Const SPC_BATTLEDRIVEN = 3           'battle driven? 1-no, 0-yes
Public Const SPC_MENUDRIVEN = 4                 'menu driven? 1-no, 0-yes
'====================================================================================
'String Defines: (to be passed into CBGetItemString as nInfoCode)
'====================================================================================
Public Const ITM_NAME = 0                           'name of item
Public Const ITM_ACCESSORY = 1                  'name of accessory slot this item can be equipped to.
Public Const ITM_EQUIP_PRG = 2                  'program to run when item is equipped.
Public Const ITM_REMOVE_PRG = 3                 'program to run when item is removed (unequipped).
Public Const ITM_MENU_PRG = 4                   'program to run when used from menu
Public Const ITM_FIGHT_PRG = 5                  'program to run when used from fight
Public Const ITM_ONBOARD_PRG = 6                'program to run when item is on the board (multitask)
Public Const ITM_PICKEDUP_PRG = 7           'program to run when item is touched on the board
Public Const ITM_CHARACTERS = 8                 'characters who can use this item (nArrayPos 0-50)
Public Const ITM_DESCRIPTION = 9                'item description
Public Const ITM_ANIMATION = 10             'associated animation
'====================================================================================
'Numerical Defines: (to be passed into CBGetItemNum as nInfoCode)
'====================================================================================
Public Const ITM_EQUIP_YN = 0                   'is item equipable? 0=no, 1=yes
Public Const ITM_MENU_YN = 1                        'is item usable from menu? 0=no, 1=yes
Public Const ITM_BOARD_YN = 2                   'is item usable from board? 0=no, 1=yes
Public Const ITM_FIGHT_YN = 3                   'is item usable from a fight? 0=no, 1=yes
Public Const ITM_EQUIP_LOCATION = 4     'is item equippable on each body slot? (nArrayPos 1-7)
Public Const ITM_EQUIP_HPUP = 5             'hp increase upon equip
Public Const ITM_EQUIP_DPUP = 6                 'dp increase upon equip
Public Const ITM_EQUIP_FPUP = 7                 'fp increase upon equip
Public Const ITM_EQUIP_SMPUP = 8                'smp increase upon equip
Public Const ITM_MENU_HPUP = 9                  'hp increase upon use from menu
Public Const ITM_MENU_SMPUP = 10            'smp increase upon use from menu
Public Const ITM_FIGHT_HPUP = 11            'hp increase upon use from battle
Public Const ITM_FIGHT_SMPUP = 12           'smp increase upon use from battle
Public Const ITM_USEDBY = 13                'item used by 0=all, 1=defined
Public Const ITM_BUYING_PRICE = 14      'buying price
Public Const ITM_SELLING_PRICE = 15     'selling price
Public Const ITM_KEYITEM = 16                   'key item? 0=no, 1=yes
'====================================================================================
'Numerical Defines: (to be passed into CBGetBoardNum as nInfoCode)
'====================================================================================
Public Const BRD_SIZEX = 0                          'board size x
Public Const BRD_SIZEY = 1                          'board size y
Public Const BRD_AMBIENTRED = 2             'ambient red array for tiles (nArrayPos1 1-50, nArrayPos2 1-50, nArrayPos3 1-8)
Public Const BRD_AMBIENTGREEN = 3           'ambient green array for tiles (nArrayPos1 1-50, nArrayPos2 1-50, nArrayPos3 1-8)
Public Const BRD_AMBIENTBLUE = 4                'ambient blue array for tiles (nArrayPos1 1-50, nArrayPos2 1-50, nArrayPos3 1-8)
Public Const BRD_TILETYPE = 5                   'tile type array for tiles (nArrayPos1 1-50, nArrayPos2 1-50, nArrayPos3 1-8) (0=normal, 1=solid, 2=under, 3=ns normal, 4=ew normal, 11=elevate to level 1, ..., 18=elevate to level 8)
Public Const BRD_BACKCOLOR = 6                  'board background color (save as a long 3 (4) byte color value)
Public Const BRD_BORDERCOLOR = 7                'board border color (save as a long 3 (4) byte color value)
Public Const BRD_SKILL = 8                          'board skill level
Public Const BRD_FIGHTINGYN = 9                 'fighting on board? 1=yes, 0=no
Public Const BRD_CONSTANTS = 10             'board constants array (nArrayPos1 1-10)
Public Const BRD_PRG_X = 11                     'program x position (nArrayPos1 0-50)
Public Const BRD_PRG_Y = 12                     'program y position (nArrayPos1 0-50)
Public Const BRD_PRG_LAYER = 13             'program layer position (nArrayPos1 0-50)
Public Const BRD_PRG_ACTIVATION = 14 'program activation (nArrayPos1 0-50) 0=always active, 1=conditional activation
Public Const BRD_PRG_ACTIV_TYPE = 15 'program activation type (nArrayPos1 0-50) 0=step on, 1=conditional (activation key)
Public Const BRD_ITM_X = 16                     'program x position (nArrayPos1 0-10)
Public Const BRD_ITM_Y = 17                     'program y position (nArrayPos1 0-10)
Public Const BRD_ITM_LAYER = 18             'program layer position (nArrayPos1 0-10)
Public Const BRD_ITM_ACTIVATION = 19 'program activation (nArrayPos1 0-10) 0=always active, 1=conditional activation
Public Const BRD_ITM_ACTIV_TYPE = 20 'program activation type (nArrayPos1 0-10) 0=step on, 1=conditional (activation key)
Public Const BRD_PLAYERX = 21                   'starting player x position
Public Const BRD_PLAYERY = 22                   'starting player y position
Public Const BRD_PLAYERLAYER = 23           'starting player layer position
Public Const BRD_SAVING_DISABLED = 24   'is saving disabled? (0=no, 1=yes)
'====================================================================================
'String Defines: (to be passed into CBGetBoardString as nInfoCode)
'====================================================================================
Public Const BRD_TILE = 0                           'tile array (nArrayPos1 1-50, nArrayPos2 1-50, nArrayPos3 1-8)
Public Const BRD_BACK_IMAGE = 1                 'background image
Public Const BRD_BORDER_IMAGE = 2           'border image
Public Const BRD_DIR_LINK = 3                   'directional links (nArrayPos1 1-4) (1=n, 2=s, 3=e, 4=w)
Public Const BRD_FIGHT_BKG = 4                  'fighting background
Public Const BRD_MUSIC = 5                          'board music
Public Const BRD_LAYER_NAME = 6                 'layer title (nArrayPos1 1-8)
Public Const BRD_PRG = 7                                'program filenames (nArrayPos1 0-50)
Public Const BRD_PRG_GFX = 8                        'program graphics (nArrayPos1 0-50)
Public Const BRD_PRG_ACTIVE_VAR = 9         'program activation var (nArrayPos1 0-50)
Public Const BRD_PRG_DONE_VAR = 10      'program activation var at end of program (nArrayPos1 0-50)
Public Const BRD_PRG_ACTIVE_INIT = 11   'program activation var value at beginning of program (nArrayPos1 0-50)
Public Const BRD_PRG_DONE_INIT = 12     'program activation var value at end of program (nArrayPos1 0-50)
Public Const BRD_ITM = 13                           'item filenames (nArrayPos1 0-10)
Public Const BRD_ITM_ACTIVE_VAR = 14 'item activation var (nArrayPos1 0-10)
Public Const BRD_ITM_DONE_VAR = 15      'item activation var at end of program (nArrayPos1 0-10)
Public Const BRD_ITM_ACTIVE_INIT = 16   'item activation var value at beginning of program (nArrayPos1 0-10)
Public Const BRD_ITM_DONE_INIT = 17     'item activation var value at end of program (nArrayPos1 0-10)
Public Const BRD_ITM_PROGRAM = 18           'item step on program (nArrayPos1 0-10)
Public Const BRD_ITM_MULTI = 19             'item multitask program (nArrayPos1 0-10)
'====================================================================================
'For use with CBCanvasPopup
'====================================================================================
Public Const POPUP_NOFX = 0                         'show the canvas with no special effects
Public Const POPUP_VERTICAL = 1                 'vertical scroll from centre
Public Const POPUP_HORIZONTAL = 2           'horizontal scroll from centre
'====================================================================================
'For use with CBMessageWindow
'====================================================================================
Public Const MW_OK = 0                                  'show message window with 'OK' option
Public Const MW_YESNO = 1                           'show message window with 'YES' and 'NO' options
Public Const MWR_OK = 1                             'message window returned 'OK'
Public Const MWR_YES = 6                                'message window returned 'YES'
Public Const MWR_NO = 7                                 'message window returned 'NO'
'====================================================================================
'For use with CBSetTarget, CBSetSource
'====================================================================================
Public Const TYPE_PLAYER = 0                        'Target type player
Public Const TYPE_ITEM = 1                          'Target type item
Public Const TYPE_ENEMY = 2                     'Target type enemy
'====================================================================================
'For use with CBGetFighter* callbacks
'====================================================================================
Public Const ENEMY_PARTY = 0                        'The enemy party index
Public Const PLAYER_PARTY = 1                       'The player party index

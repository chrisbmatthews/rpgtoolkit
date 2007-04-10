/*
 ********************************************************************
 * The RPG Toolkit Version 3 Plugin Libraries
 * This file copyright (C) 2003-2007  Christopher B. Matthews
 ********************************************************************
 *
 * This file is released under the AC Open License v 1.0
 * See "AC Open License.txt" for details
 */

/*
 * To ensure the plugin works, do not modify this file.
 */

/******ENEMY INFO DEFINES*******/
//Numerical Defines: (to be passed into CBGetEnemyNum as nInfoCode)
#define ENE_HP							0		//enemy hp level
#define ENE_MAXHP						1		//enemy max hp level
#define ENE_SMP							2		//enemy smp level
#define ENE_MAXSMP					3		//enemy max smp level
#define ENE_FP							4		//enemy fp
#define ENE_DP							5		//enemy dp
#define ENE_RUNYN						6		//can we run from enemy? 0- no, 1- yes
#define ENE_SNEAKCHANCES		7		//chances of sneaking up on enemy
#define ENE_SNEAKUPCHANCES	8		//chances of enemy snaking up on you
#define ENE_SIZEX						9		//enemy size x
#define ENE_SIZEY						10	//enemy size y
#define ENE_AI							11	//enemy AI level 0- very low ... 4- very high
#define ENE_EXP							12	//experience you get from defeating enemy
#define ENE_GP							13	//GP you get from defeating enemy
//String Defines: (to be passed into CBGetEnemyInfoString as nInfoCode)
#define ENE_FILENAME				0		//enemy filename
#define ENE_NAME						1		//enemy name
#define ENE_RPGCODEPROGRAM	2		//rpgcode program to run as AI
#define ENE_DEFEATPRG				3		//rpgcode program to run when enemy is defeated
#define ENE_RUNPRG					4		//program to run when player runs away
#define ENE_ATTACKSOUND			5		//filename of sound to play when enemy does phys attack
#define ENE_SMSOUND					6		//filename of sound to play when enemy does special move
#define ENE_HITSOUND				7		//filename of sound to play when enemy is hit
#define ENE_DIESOUND				8		//filename of sound to play when enemy dies


/******PLAYER INFO DEFINES*******/
//Numerical Defines: (to be passed into CBGetPlayerNum as nInfoCode)
#define PLAYER_INITXP				0		//initial experience level
#define PLAYER_INITHP				1		//initial health level
#define PLAYER_INITMAXHP		2		//initial max health level
#define PLAYER_INITDP				3		//initial dp level
#define PLAYER_INITFP				4		//initial fp level
#define PLAYER_INITSMP			5		//initial smp level
#define PLAYER_INITMAXSMP		6		//initial max smp level
#define PLAYER_INITLEVEL		7		//initial level
#define PLAYER_DOES_SM			8		//player does special moves? 0- no, 1- yes
#define PLAYER_SM_MIN_EXPS	9		//minimum experience for each special move (arrayPos 0-200)
#define PLAYER_SM_MIN_LEVELS 10	//minimum level required for each special move (arrayPos 0-200)
#define PLAYER_ARMOURS			11	//is armour type used?  0=no, 1=yes (arrayPos 0-6)
#define PLAYER_LEVELTYPE		12	//level progression type
#define PLAYER_XP_INCREASE	13	//experience increase factor for each level
#define PLAYER_MAXLEVEL			14	//max level
#define PLAYER_HP_INCREASE	15	//hp increase on level up
#define PLAYER_DP_INCREASE	16	//dp increase on level up
#define PLAYER_FP_INCREASE	17	//fp increase on level up
#define PLAYER_SMP_INCREASE	18	//smp increase on level up
#define PLAYER_LEVELUP_TYPE	19	//level up type 0=exponential, 1=linear
#define PLAYER_DIR_FACING		20	//direction player is facing (1=south, 2=west, 3=north, 4=east)
#define PLAYER_NEXTLEVEL		21	//percentage of next level gained (0 - 100)
//String Defines: (to be passed into CBGetPlayerInfoString as nInfoCode)
#define PLAYER_NAME					0		//player name (handle)
#define PLAYER_XP_VAR				1		//player experience var
#define PLAYER_DP_VAR				2		//player dp var
#define PLAYER_FP_VAR				3		//player fp var
#define PLAYER_HP_VAR				4		//player hp var
#define PLAYER_MAXHP_VAR		5		//player max hp var
#define PLAYER_NAME_VAR			6		//player name var
#define PLAYER_SMP_VAR			7		//player smp var
#define PLAYER_MAXSMP_VAR		8		//player max smp var
#define PLAYER_LEVEL_VAR		9		//player level var
#define PLAYER_PROFILE			10	//player profile picture filename
#define PLAYER_SM_FILENAMES	11	//player spcial move filename array (arrayPos 0-200)
#define PLAYER_SM_NAME			12	//player spcial move names
#define PLAYER_SM_CONDVARS	13	//player special move conditional vars (arrayPos 0-200)
#define PLAYER_SM_CONDVARSEQ 14	//player special move conditional variable conditions (arrayPos 0-200)
#define PLAYER_ACCESSORIES	15	//player accessory names (arrayPos 0-10)
#define PLAYER_SWORDSOUND		16	//player sword swipe sound
#define PLAYER_DEFENDSOUND	17	//player defend sound
#define PLAYER_SMSOUND			18	//player special move sound
#define PLAYER_DEATHSOUND		19	//player death sound
#define PLAYER_RPGCODE_LEVUP 20	//player rpgcode program to run on level up


/******GENERAL INFO DEFINES*******/
//String Defines: (to be passed into CBGetGeneralString as nInfoCode)
#define GEN_PLAYERHANDLES		0		//handles of players (nPlayerSlot 0-4)
#define GEN_PLAYERFILES			1		//filenames of players (nPlayerSlot 0-4)
#define GEN_PLYROTHERHANDLES	2	//handles of other players (nArrayPos 0-25)
#define GEN_PLYROTHERFILES	3		//filenames of other players (nArrayPos 0-25)
#define GEN_INVENTORY_FILES	4		//filenames of inventory slots (nArrayPos 0-500)
#define GEN_INVENTORY_HANDLES	5	//handles of inventory slots (nArrayPos 0-500)
#define GEN_EQUIP_FILES			6		//filenames of equipped items (nArrayPos 0-16 (equip slot), nPlayerSlot 0-4)
#define GEN_EQUIP_HANDLES		7		//handles of equipped items (nArrayPos 0-16 (equip slot), nPlayerSlot 0-4)
#define GEN_MUSICPLAYING		8		//currently playing music
#define GEN_CURRENTBOARD		9		//current board filename
#define GEN_MENUGRAPHIC			10		//filename of menu graphic
#define GEN_FIGHTMENUGRAPHIC	11//filename of fight menu graphic
#define GEN_MWIN_PIC_FILE		12	//filename mwin graphic
#define GEN_FONTFILE				13	//filename font
#define GEN_ENE_FILE				14	//filename of loaded enemies (nPlayerSlot 0-3)
#define GEN_ENE_WINPROGRAMS	15	//filenames of programs to run after defeating enemies (nPlayerSlot 0-3)
#define GEN_ENE_STATUS			16	//filenames of status effects applied to enemies (nArrayPos 0-10, nPlayerSlot 0-3)
#define GEN_PLYR_STATUS			17	//filenames of status effects applied to players (nArrayPos 0-10, nPlayerSlot 0-4)
#define GEN_CURSOR_MOVESOUND 18	//filename of the cursor move sound
#define GEN_CURSOR_SELSOUND	19	//filename of the cursor selection sound
#define GEN_CURSOR_CANCELSOUND 20	//filename of the cursor cancel sound
//Numerical defines: (to be passed into CBGetGeneralNum as nInfoCode)
#define GEN_INVENTORY_NUM		0		//number of each item in inventory (nArrayPos 0-500)
#define GEN_EQUIP_HPADD			1		//amount of hp added to player by equipment (nPlayerslot 0-4)
#define GEN_EQUIP_SMPADD		2		//amount of smp added to player by equipment (nPlayerslot 0-4)
#define GEN_EQUIP_DPADD			3		//amount of dp added to player by equipment (nPlayerslot 0-4)
#define GEN_EQUIP_FPADD			4		//amount of fp added to player by equipment (nPlayerslot 0-4)
#define GEN_CURX						5		//current player x pos (nPlayerSlot 0-4)
#define GEN_CURY						6		//current player y pos (nPlayerSlot 0-4)
#define GEN_CURLAYER				7		//current player layer pos (nPlayerSlot 0-4)
#define GEN_CURRENT_PLYR		8		//currently selected player
#define GEN_TILESX					9		//size of screen x (in tiles)
#define GEN_TILESY					10	//size of screen y (in tiles)
#define GEN_BATTLESPEED			11	//current battle speed (returns 0=slow -> 8=fast)
#define GEN_TEXTSPEED				12	//current text speed (returns 0=slow -> 3=fast)
#define GEN_CHARACTERSPEED	13	//current character speed (returns 0=slow -> 3=fast)
#define GEN_SCROLLINGOFF		14	//is scrolling turned off? 0=no, 1=yes
#define GEN_RESX						15	//screen x resolution, in pixels
#define GEN_RESY						16	//screen y resolution, in pixels
#define GEN_GP							17	//gp carried by player
#define GEN_FONTCOLOR				18	//color of font (rgb value-- use red, green, blue fns)
#define GEN_PREV_TIME				19	//time spent in previuously loaded game
#define GEN_START_TIME			20	//time at start of game
#define GEN_GAME_TIME				21	//length of game, in seconds
#define GEN_STEPS						22	//number of steps taken
#define GEN_ENE_RUN					23	//can we run from the currently loaded enemies? 0=no, 1=yes
#define GEN_ENEX						24	//x location of each enemy (nPlayerSlot 0-3)
#define GEN_ENEY						25	//y location of each enemy (nPlayerSlot 0-3)
#define GEN_FIGHT_OFFSETX		26	//fighting window x offset, in tiles
#define GEN_FIGHT_OFFSETY		27	//fighting window y offset, in tiles
#define GEN_TRANSPARENTCOLOR	28	//color used as the 'transparent' color universally throughout the engine

/******PATH INFO DEFINES*******/
//String Defines: (to be passed into CBGetPathString as nInfoCode)
#define PATH_TILE						0		//tile path
#define PATH_BOARD					1		//board path
#define PATH_CHAR						2		//character path
#define PATH_SPC						3		//special move path
#define PATH_BKG						4		//background path
#define PATH_MEDIA					5		//media path
#define PATH_PRG						6		//prg path
#define PATH_FONT						7		//font path
#define PATH_ITEM						8		//item path
#define PATH_ENEMY					9		//enemy path
#define PATH_MAIN						10	//main file path
#define PATH_BITMAP					11	//bitmap path
#define PATH_STATUSFX				12	//status effects path
#define PATH_MISC						13	//misc path
#define PATH_SAVE						14	//saved games path
#define PATH_PROJECT				15	//project path


/******SPECIAL MOVE DEFINES*******/
//String Defines: (to be passed into CBGetSpecialMoveString as nInfoCode)
#define SPC_NAME						0		//name of special move
#define SPC_PRG_FILE				1		//filename of rpgcode program to run
#define SPC_STATUSFX				2		//status effect filename connected to this move
#define SPC_ANIMATION				3		//filename of animation connected to this move
#define SPC_DESCRIPTION			4		//description of special move.
//Numerical Defines: (to be passed into CBGetSpecialMoveNum as nInfoCode)
#define SPC_FP							0		//fp of special move
#define SPC_SMP							1		//smp of special move
#define SPC_TARGET_SMP			2		//smp to remove from target
#define SPC_BATTLEDRIVEN		3		//battle driven? 1-no, 0-yes
#define SPC_MENUDRIVEN			4		//menu driven? 1-no, 0-yes


/******ITEM DEFINES*******/
//String Defines: (to be passed into CBGetItemString as nInfoCode)
#define ITM_NAME						0		//name of item
#define ITM_ACCESSORY				1		//name of accessory slot this item can be equipped to.
#define ITM_EQUIP_PRG				2		//program to run when item is equipped.
#define ITM_REMOVE_PRG			3		//program to run when item is removed (unequipped).
#define ITM_MENU_PRG				4		//program to run when used from menu
#define ITM_FIGHT_PRG				5		//program to run when used from fight
#define ITM_ONBOARD_PRG			6		//program to run when item is on the board (multitask)
#define ITM_PICKEDUP_PRG		7		//program to run when item is touched on the board
#define ITM_CHARACTERS			8		//characters who can use this item (nArrayPos 0-50)
#define ITM_DESCRIPTION			9		//item description
#define ITM_ANIMATION				10	//associated animation
//Numerical Defines: (to be passed into CBGetItemNum as nInfoCode)
#define ITM_EQUIP_YN				0		//is item equipable? 0=no, 1=yes
#define ITM_MENU_YN					1		//is item usable from menu? 0=no, 1=yes
#define ITM_BOARD_YN				2		//is item usable from board? 0=no, 1=yes
#define ITM_FIGHT_YN				3		//is item usable from a fight? 0=no, 1=yes
#define ITM_EQUIP_LOCATION	4		//is item equippable on each body slot? (nArrayPos 1-7)
#define ITM_EQUIP_HPUP			5		//hp increase upon equip
#define ITM_EQUIP_DPUP			6		//dp increase upon equip
#define ITM_EQUIP_FPUP			7		//fp increase upon equip
#define ITM_EQUIP_SMPUP			8		//smp increase upon equip
#define ITM_MENU_HPUP				9		//hp increase upon use from menu
#define ITM_MENU_SMPUP			10	//smp increase upon use from menu
#define ITM_FIGHT_HPUP			11	//hp increase upon use from battle
#define ITM_FIGHT_SMPUP			12	//smp increase upon use from battle
#define ITM_USEDBY					13	//item used by 0=all, 1=defined
#define ITM_BUYING_PRICE		14	//buying price
#define ITM_SELLING_PRICE		15	//selling price
#define ITM_KEYITEM					16	//key item? 0=no, 1=yes


/******BOARD DEFINES*******/
//Numerical Defines: (to be passed into CBGetBoardNum as nInfoCode)
#define BRD_SIZEX						0		//board size x 
#define BRD_SIZEY						1		//board size y
#define BRD_AMBIENTRED			2		//ambient red array for tiles (nArrayPos1 1-50, nArrayPos2 1-50, nArrayPos3 1-8)
#define BRD_AMBIENTGREEN		3		//ambient green array for tiles (nArrayPos1 1-50, nArrayPos2 1-50, nArrayPos3 1-8)
#define BRD_AMBIENTBLUE			4		//ambient blue array for tiles (nArrayPos1 1-50, nArrayPos2 1-50, nArrayPos3 1-8)
#define BRD_TILETYPE				5		//tile type array for tiles (nArrayPos1 1-50, nArrayPos2 1-50, nArrayPos3 1-8) (0=normal, 1=solid, 2=under, 3=ns normal, 4=ew normal, 11=elevate to level 1, ..., 18=elevate to level 8)
#define BRD_BACKCOLOR				6		//board background color (save as a long 3 (4) byte color value)
#define BRD_BORDERCOLOR			7		//board border color (save as a long 3 (4) byte color value)
#define BRD_SKILL						8		//board skill level
#define BRD_FIGHTINGYN			9		//fighting on board? 1=yes, 0=no
#define BRD_CONSTANTS				10	//board constants array (nArrayPos1 1-10)
#define BRD_PRG_X						11	//program x position (nArrayPos1 0-50)
#define BRD_PRG_Y						12	//program y position (nArrayPos1 0-50)
#define BRD_PRG_LAYER				13	//program layer position (nArrayPos1 0-50)
#define BRD_PRG_ACTIVATION	14	//program activation (nArrayPos1 0-50) 0=always active, 1=conditional activation
#define BRD_PRG_ACTIV_TYPE	15	//program activation type (nArrayPos1 0-50) 0=step on, 1=conditional (activation key)
#define BRD_ITM_X						16	//program x position (nArrayPos1 0-10)
#define BRD_ITM_Y						17	//program y position (nArrayPos1 0-10)
#define BRD_ITM_LAYER				18	//program layer position (nArrayPos1 0-10)
#define BRD_ITM_ACTIVATION	19	//program activation (nArrayPos1 0-10) 0=always active, 1=conditional activation
#define BRD_ITM_ACTIV_TYPE	20	//program activation type (nArrayPos1 0-10) 0=step on, 1=conditional (activation key)
#define BRD_PLAYERX					21	//starting player x position
#define BRD_PLAYERY					22	//starting player y position
#define BRD_PLAYERLAYER			23	//starting player layer position
#define BRD_SAVING_DISABLED	24	//is saving disabled? (0=no, 1=yes)
//String Defines: (to be passed into CBGetBoardString as nInfoCode)
#define BRD_TILE						0		//tile array (nArrayPos1 1-50, nArrayPos2 1-50, nArrayPos3 1-8)
#define BRD_BACK_IMAGE			1		//background image
#define BRD_BORDER_IMAGE		2		//border image
#define BRD_DIR_LINK				3		//directional links (nArrayPos1 1-4) (1=n, 2=s, 3=e, 4=w)
#define BRD_FIGHT_BKG				4		//fighting background
#define BRD_MUSIC						5		//board music
#define BRD_LAYER_NAME			6		//layer title (nArrayPos1 1-8)
#define BRD_PRG							7		//program filenames (nArrayPos1 0-50)
#define BRD_PRG_GFX					8		//program graphics (nArrayPos1 0-50)
#define BRD_PRG_ACTIVE_VAR	9		//program activation var (nArrayPos1 0-50)
#define BRD_PRG_DONE_VAR		10	//program activation var at end of program (nArrayPos1 0-50)
#define BRD_PRG_ACTIVE_INIT	11	//program activation var value at beginning of program (nArrayPos1 0-50)
#define BRD_PRG_DONE_INIT		12	//program activation var value at end of program (nArrayPos1 0-50)
#define BRD_ITM							13	//item filenames (nArrayPos1 0-10)
#define BRD_ITM_ACTIVE_VAR	14	//item activation var (nArrayPos1 0-10)
#define BRD_ITM_DONE_VAR		15	//item activation var at end of program (nArrayPos1 0-10)
#define BRD_ITM_ACTIVE_INIT	16	//item activation var value at beginning of program (nArrayPos1 0-10)
#define BRD_ITM_DONE_INIT		17	//item activation var value at end of program (nArrayPos1 0-10)
#define BRD_ITM_PROGRAM			18	//item step on program (nArrayPos1 0-10)
#define BRD_ITM_MULTI				19	//item multitask program (nArrayPos1 0-10)


/******POPUP DEFINES*******/
//For use with CBCanvasPopup
#define POPUP_NOFX					0		//show the canvas with no special effects
#define POPUP_VERTICAL			1		//vertical scroll from centre
#define POPUP_HORIZONTAL		2		//horizontal scroll from centre


/******MESSAGE WINDOW DEFINES*******/
//For use with CBMessageWindow
#define MW_OK								0		//show message window with 'OK' option
#define MW_YESNO						1		//show message window with 'YES' and 'NO' options
#define MWR_OK							1		//message window returned 'OK'
#define MWR_YES							6		//message window returned 'YES'
#define MWR_NO							7		//message window returned 'NO'


/******TARGET AND SOURCE DEFINES*******/
//For use with CBSetTarget, CBSetSource
#define TYPE_PLAYER					0		//Target type player
#define TYPE_ITEM						1		//Target type item
#define TYPE_ENEMY					2		//Target type enemy


/******FIGHT PARTY DEFINES*******/
//For use with CBGetFighter* callbacks
#define ENEMY_PARTY					0		//The enemy party index
#define PLAYER_PARTY					1		//The player party index



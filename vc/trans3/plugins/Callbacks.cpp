/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

/*
 * Be very sure this file is all done, especially the
 * GetGeneralString &c., which are almost certainly
 * missing something within. 'TBD' is a good string to
 * check, but its employment is not consistent.
 *
 * Colin,
 * Note to self.
 */

#include "../stdafx.h"
#include "../trans3.h"
#include "Callbacks.h"
#include "plugins.h"
#include "constants.h"
#include "../rpgcode/CProgram.h"
#include "../rpgcode/parser/parser.h"
#include "../common/CAllocationHeap.h"
#include "../common/CInventory.h"
#include "../common/paths.h"
#include "../common/CFile.h"
#include "../common/CAnimation.h"
#include "../common/board.h"
#include "../common/enemy.h"
#include "../common/background.h"
#include "../common/item.h"
#include "../common/spcmove.h"
#include "../common/mainfile.h"
#include "../input/input.h"
#include "../misc/misc.h"
#include "../movement/CPlayer/CPlayer.h"
#include "../movement/locate.h"
#include "../images/FreeImage.h"
#include "../fight/fight.h"
#include "../audio/CAudioSegment.h"
#include "../../tkCommon/tkDirectX/platform.h"
#include "../../tkCommon/tkCanvas/GDICanvas.h"
#include "../../tkCommon/strings.h"
#include <map>

extern CAllocationHeap<CCanvas> g_canvases;
extern CDirectDraw *g_pDirectDraw;
extern std::vector<CPlayer *> g_players;
static HDC g_hScreenDc = NULL;
std::map<unsigned int, PLUGIN_ENEMY> g_enemies;
STRING g_menuGraphic, g_fightMenuGraphic;
SPCMOVE g_spc;
std::vector<STRING> g_specials;
std::vector<ITEM> g_items;
CProgram *g_prg = NULL;

template <class T>
inline T bounds(const T val, const T low, const T high)
{
	return ((val < low) ? low : ((val > high) ? high : val));
}

template <class T>
inline T advance(T i, unsigned int j)
{
	for (unsigned int k = 0; k < j; ++k, ++i);
	return i;
}

inline STRING addExtension(const STRING file, const STRING ext)
{
	if (getExtension(file).empty())
	{
		return (file + _T('.') + ext);
	}
	return file;
}

STDMETHODIMP CCallbacks::CBRpgCode(BSTR rpgcodeCommand)
{
	CProgram prg;
	prg.loadFromString(getString(rpgcodeCommand));
	prg.run();
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetString(BSTR varname, BSTR *pRet)
{
	const STRING var = getString(varname);
	LPSTACK_FRAME pVar = g_prg ? g_prg->getVar(var) : CProgram::getGlobal(var);
	BSTR bstr = getString(pVar->getLit());
	SysReAllocString(pRet, bstr);
	SysFreeString(bstr);
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetNumerical(BSTR varname, double *pRet)
{
	const STRING var = getString(varname);
	LPSTACK_FRAME pVar = g_prg ? g_prg->getVar(var) : CProgram::getGlobal(var);
	*pRet = pVar->getNum();
	return S_OK;
}

STDMETHODIMP CCallbacks::CBSetString(BSTR varname, BSTR newValue)
{
	const STRING var = getString(varname);
	LPSTACK_FRAME pVar = g_prg ? g_prg->getVar(var) : CProgram::getGlobal(var);
	pVar->udt = UDT_LIT;
	pVar->lit = getString(newValue);
	return S_OK;
}

STDMETHODIMP CCallbacks::CBSetNumerical(BSTR varname, double newValue)
{
	const STRING var = getString(varname);
	LPSTACK_FRAME pVar = g_prg ? g_prg->getVar(var) : CProgram::getGlobal(var);
	pVar->udt = UDT_NUM;
	pVar->num = newValue;
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetScreenDC(int *pRet)
{
	extern HWND g_hHostWnd;
	*pRet = int(g_hScreenDc = GetDC(g_hHostWnd));
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetScratch1DC(int *pRet)
{
	*pRet = 0; // Obsolete.
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetScratch2DC(int *pRet)
{
	*pRet = 0; // Obsolete.
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetMwinDC(int *pRet)
{
	*pRet = 0; // Obsolete.
	return S_OK;
}

STDMETHODIMP CCallbacks::CBPopupMwin(int *pRet)
{
	extern bool g_bShowMessageWindow;
	g_bShowMessageWindow = true;
	*pRet = TRUE;
	return S_OK;
}

STDMETHODIMP CCallbacks::CBHideMwin(int *pRet)
{
	extern bool g_bShowMessageWindow;
	g_bShowMessageWindow = false;
	*pRet = TRUE;
	return S_OK;
}

STDMETHODIMP CCallbacks::CBLoadEnemy(BSTR file, int eneSlot)
{
	extern STRING g_projectPath;
	const STRING strFile = getString(file);
	g_enemies[eneSlot].enemy.open(g_projectPath + ENE_PATH + strFile);
	g_enemies[eneSlot].fileName = strFile;
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetEnemyNum(int infoCode, int eneSlot, int *pRet)
{
	if (!g_enemies.count(eneSlot))
	{
		*pRet = 0;
		return S_OK;
	}
	ENEMY &ene = g_enemies[eneSlot].enemy;
	switch (infoCode)
	{
		case ENE_HP:
			*pRet = ene.iHp;
			break;
		case ENE_MAXHP:
			*pRet = ene.iMaxHp;
			break;
		case ENE_SMP:
			*pRet = ene.iSmp;
			break;
		case ENE_MAXSMP:
			*pRet = ene.iMaxSmp;
			break;
		case ENE_FP:
			*pRet = ene.fp;
			break;
		case ENE_DP:
			*pRet = ene.dp;
			break;
		case ENE_RUNYN:
			*pRet = ene.run;
			break;
		case ENE_SNEAKCHANCES:
			*pRet = ene.takeCrit;
			break;
		case ENE_SNEAKUPCHANCES:
			*pRet = ene.giveCrit;
			break;
		case ENE_SIZEX:
		case ENE_SIZEY:
			// Obsolete.
			*pRet = 0;
			break;
		case ENE_AI:
			*pRet = ene.ai;
			break;
		case ENE_EXP:
			*pRet = ene.exp;
			break;
		case ENE_GP:
			*pRet = ene.gp;
			break;
		default:
			*pRet = 0;
			break;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetEnemyString(int infoCode, int eneSlot, BSTR *pRet)
{
	if (!g_enemies.count(eneSlot))
	{
		SysReAllocString(pRet, L"");
		return S_OK;
	}
	ENEMY &ene = g_enemies[eneSlot].enemy;
	BSTR bstr = NULL;
	switch (infoCode)
	{
		case ENE_FILENAME:
			bstr = getString(g_enemies[eneSlot].fileName);
			break;
		case ENE_NAME:
			bstr = getString(ene.strName);
			break;
		case ENE_RPGCODEPROGRAM:
			bstr = getString(ene.prg);
			break;
		case ENE_DEFEATPRG:
			bstr = getString(ene.winPrg);
			break;
		case ENE_RUNPRG:
			bstr = getString(ene.runPrg);
			break;
		default:
			SysReAllocString(pRet, L"");
			break;
	}
	if (bstr)
	{
		SysReAllocString(pRet, bstr);
		SysFreeString(bstr);
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBSetEnemyNum(int infoCode, int newValue, int eneSlot)
{
	if (!g_enemies.count(eneSlot)) return S_OK;
	ENEMY &ene = g_enemies[eneSlot].enemy;
	switch (infoCode)
	{
		case ENE_HP:
			ene.iHp = newValue;
			break;
		case ENE_MAXHP:
			ene.iMaxHp = newValue;
			break;
		case ENE_SMP:
			ene.iSmp = newValue;
			break;
		case ENE_MAXSMP:
			ene.iMaxSmp = newValue;
			break;
		case ENE_FP:
			ene.fp = newValue;
			break;
		case ENE_DP:
			ene.dp = newValue;
			break;
		case ENE_RUNYN:
			ene.run = newValue;
			break;
		case ENE_SNEAKCHANCES:
			ene.takeCrit = newValue;
			break;
		case ENE_SNEAKUPCHANCES:
			ene.giveCrit = newValue;
			break;
		case ENE_SIZEX:
		case ENE_SIZEY:
			// Obsolete.
			break;
		case ENE_AI:
			ene.ai = newValue;
			break;
		case ENE_EXP:
			ene.exp = newValue;
			break;
		case ENE_GP:
			ene.gp = newValue;
			break;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBSetEnemyString(int infoCode, BSTR newValue, int eneSlot)
{
	if (!g_enemies.count(eneSlot)) return S_OK;
	ENEMY &ene = g_enemies[eneSlot].enemy;
	switch (infoCode)
	{
		case ENE_FILENAME:
			g_enemies[eneSlot].fileName = getString(newValue);
			break;
		case ENE_NAME:
			ene.strName = getString(newValue);
			break;
		case ENE_RPGCODEPROGRAM:
			ene.prg = getString(newValue);
			break;
		case ENE_DEFEATPRG:
			ene.winPrg = getString(newValue);
			break;
		case ENE_RUNPRG:
			ene.runPrg = getString(newValue);
			break;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetPlayerNum(int infoCode, int arrayPos, int playerSlot, int *pRet)
{
	if (playerSlot >= g_players.size())
	{
		*pRet = 0;
		return S_OK;
	}

	CPlayer *pPlayer = g_players[playerSlot];
	LPPLAYER pData = pPlayer->getPlayer();
	LPPLAYER_STATS pInitStats = &pPlayer->getPlayer()->stats;

	switch (infoCode)
	{
		case PLAYER_INITXP:
			*pRet = pInitStats->experience;
			break;
		case PLAYER_INITHP:
			*pRet = pInitStats->health;
			break;
		case PLAYER_INITMAXHP:
			*pRet = pInitStats->maxHealth;
			break;
		case PLAYER_INITDP:
			*pRet = pInitStats->defense;
			break;
		case PLAYER_INITFP:
			*pRet = pInitStats->fight;
			break;
		case PLAYER_INITSMP:
			*pRet = pInitStats->sm;
			break;
		case PLAYER_INITMAXSMP:
			*pRet = pInitStats->smMax;
			break;
		case PLAYER_INITLEVEL:
			*pRet = pInitStats->level;
			break;
		case PLAYER_DOES_SM:
			*pRet = !pData->smYN;
			break;
		case PLAYER_SM_MIN_EXPS:
			*pRet = pData->spcMinExp[bounds(arrayPos, 0, int(pData->spcMinExp.size() - 1))];
			break;
		case PLAYER_SM_MIN_LEVELS:
			*pRet = pData->spcMinLevel[bounds(arrayPos, 0, int(pData->spcMinLevel.size() - 1))];
			break;
		case PLAYER_ARMOURS:
			*pRet = pData->armorType[bounds(arrayPos, 0, int(pData->armorType.size() - 1))];
			break;
		case PLAYER_LEVELTYPE:
			*pRet = pData->levelType;
			break;
		case PLAYER_XP_INCREASE:
			*pRet = pData->experienceIncrease;
			break;
		case PLAYER_MAXLEVEL:
			*pRet = pData->maxLevel;
			break;
		case PLAYER_HP_INCREASE:
			*pRet = pData->levelHp;
			break;
		case PLAYER_DP_INCREASE:
			*pRet = pData->levelDp;
			break;
		case PLAYER_FP_INCREASE:
			*pRet = pData->levelFp;
			break;
		case PLAYER_SMP_INCREASE:
			*pRet = pData->levelSm;
			break;
		case PLAYER_LEVELUP_TYPE:
			*pRet = pData->charLevelUpType;
			break;
		case PLAYER_DIR_FACING:
			// TBD: warn users of direction index changes.
			*pRet = int(pPlayer->getFacing()->dir());
			break;
		case PLAYER_NEXTLEVEL:
		{
			unsigned double levelStart = 0.0, perc = 0.0;
			levelStart = pData->levelStarts[pData->stats.level - pInitStats->level];
			perc = (pData->stats.experience - levelStart) / (pData->nextLevel - levelStart) * 100.0;
			*pRet = int(perc);
		} break;
		default:
			*pRet = 0;
			break;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetPlayerString(int infoCode, int arrayPos, int playerSlot, BSTR *pRet)
{
	if (playerSlot >= g_players.size())
	{
		SysReAllocString(pRet, L"");
		return S_OK;
	}

	CPlayer *pPlayer = g_players[playerSlot];
	LPPLAYER pData = pPlayer->getPlayer();

	STRING str;

	switch (infoCode)
	{
		case PLAYER_NAME:
			str = pData->charname;
			break;
		case PLAYER_XP_VAR:
			str = pData->experienceVar;
			break;
		case PLAYER_DP_VAR:
			str = pData->defenseVar;
			break;
		case PLAYER_FP_VAR:
			str = pData->fightVar;
			break;
		case PLAYER_HP_VAR:
			str = pData->healthVar;
			break;
		case PLAYER_MAXHP_VAR:
			str = pData->maxHealthVar;
			break;
		case PLAYER_NAME_VAR:
			str = pData->nameVar;
			break;
		case PLAYER_SMP_VAR:
			str = pData->smVar;
			break;
		case PLAYER_MAXSMP_VAR:
			str = pData->smMaxVar;
			break;
		case PLAYER_LEVEL_VAR:
			str = pData->leVar;
			break;
		case PLAYER_PROFILE:
			str = pData->profilePic;
			break;
		case PLAYER_SM_FILENAMES:
			str = pData->smlist[bounds(arrayPos, 0, int(pData->smlist.size() - 1))];
			break;
		case PLAYER_SM_NAME:
			str = pData->specialMoveName;
			break;
		case PLAYER_SM_CONDVARS:
			str = pData->spcVar[bounds(arrayPos, 0, int(pData->spcVar.size() - 1))];
			break;
		case PLAYER_SM_CONDVARSEQ:
			str = pData->spcEquals[bounds(arrayPos, 0, int(pData->spcEquals.size() - 1))];
			break;
		case PLAYER_ACCESSORIES:
			str = pData->accessoryName[bounds(arrayPos, 0, int(pData->accessoryName.size() - 1))];
			break;
		case PLAYER_SWORDSOUND:
		case PLAYER_DEFENDSOUND:
		case PLAYER_SMSOUND:
		case PLAYER_DEATHSOUND:
			// Obsolete.
			break;
		case PLAYER_RPGCODE_LEVUP:
			str = pData->charLevelUpRPGCode;
			break;
	}

	BSTR bstr = getString(str);
	SysReAllocString(pRet, bstr);
	SysFreeString(bstr);
	return S_OK;
}

STDMETHODIMP CCallbacks::CBSetPlayerNum(int infoCode, int arrayPos, int newVal, int playerSlot)
{
	if (playerSlot >= g_players.size())
	{
		return S_OK;
	}

	CPlayer *pPlayer = g_players[playerSlot];
	LPPLAYER pData = pPlayer->getPlayer();
	LPPLAYER_STATS pInitStats = &pPlayer->getPlayer()->stats;

	switch (infoCode)
	{
		case PLAYER_INITXP:
			pInitStats->experience = newVal;
			break;
		case PLAYER_INITHP:
			pInitStats->health = newVal;
			break;
		case PLAYER_INITMAXHP:
			pInitStats->maxHealth = newVal;
			break;
		case PLAYER_INITDP:
			pInitStats->defense = newVal;
			break;
		case PLAYER_INITFP:
			pInitStats->fight = newVal;
			break;
		case PLAYER_INITSMP:
			pInitStats->sm = newVal;
			break;
		case PLAYER_INITMAXSMP:
			pInitStats->smMax = newVal;
			break;
		case PLAYER_INITLEVEL:
			pInitStats->level = newVal;
			break;
		case PLAYER_DOES_SM:
			pData->smYN = !newVal;
			break;
		case PLAYER_SM_MIN_EXPS:
			pData->spcMinExp[bounds(arrayPos, 0, 200)] = newVal;
			break;
		case PLAYER_SM_MIN_LEVELS:
			pData->spcMinLevel[bounds(arrayPos, 0, 200)] = newVal;
			break;
		case PLAYER_ARMOURS:
			pData->armorType[bounds(arrayPos, 0, 6)] = newVal;
			break;
		case PLAYER_LEVELTYPE:
			pData->levelType = newVal;
			break;
		case PLAYER_XP_INCREASE:
			pData->experienceIncrease = newVal;
			break;
		case PLAYER_MAXLEVEL:
			pData->maxLevel = newVal;
			break;
		case PLAYER_HP_INCREASE:
			pData->levelHp = newVal;
			break;
		case PLAYER_DP_INCREASE:
			pData->levelDp = newVal;
			break;
		case PLAYER_FP_INCREASE:
			pData->levelFp = newVal;
			break;
		case PLAYER_SMP_INCREASE:
			pData->levelSm = newVal;
			break;
		case PLAYER_LEVELUP_TYPE:
			pData->charLevelUpType = newVal;
			break;
		case PLAYER_DIR_FACING:
			// TBD: warn users of direction index changes.
			pPlayer->getFacing()->assign(MV_ENUM(newVal));
			break;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBSetPlayerString(int infoCode, int arrayPos, BSTR newVal, int playerSlot)
{
	if (playerSlot >= g_players.size())
	{
		return S_OK;
	}

	CPlayer *pPlayer = g_players[playerSlot];
	LPPLAYER pData = pPlayer->getPlayer();

	const STRING str = getString(newVal);

	switch (infoCode)
	{
		case PLAYER_NAME:
			pData->charname = str;
			break;
		case PLAYER_XP_VAR:
			pData->experienceVar = str;
			break;
		case PLAYER_DP_VAR:
			pData->defenseVar = str;
			break;
		case PLAYER_FP_VAR:
			pData->fightVar = str;
			break;
		case PLAYER_HP_VAR:
			pData->healthVar = str;
			break;
		case PLAYER_MAXHP_VAR:
			pData->maxHealthVar = str;
			break;
		case PLAYER_NAME_VAR:
			pData->nameVar = str;
			break;
		case PLAYER_SMP_VAR:
			pData->smVar = str;
			break;
		case PLAYER_MAXSMP_VAR:
			pData->smMaxVar = str;
			break;
		case PLAYER_LEVEL_VAR:
			pData->leVar = str;
			break;
		case PLAYER_PROFILE:
			pData->profilePic = str;
			break;
		case PLAYER_SM_FILENAMES:
			pData->smlist[bounds(arrayPos, 0, 200)] = str;
			break;
		case PLAYER_SM_NAME:
			pData->specialMoveName = str;
			break;
		case PLAYER_SM_CONDVARS:
			pData->spcVar[bounds(arrayPos, 0, 200)] = str;
			break;
		case PLAYER_SM_CONDVARSEQ:
			pData->spcEquals[bounds(arrayPos, 0, 200)] = str;
			break;
		case PLAYER_ACCESSORIES:
			pData->accessoryName[bounds(arrayPos, 0, 10)] = str;
			break;
		case PLAYER_SWORDSOUND:
		case PLAYER_DEFENDSOUND:
		case PLAYER_SMSOUND:
		case PLAYER_DEATHSOUND:
			// Obsolete.
			break;
		case PLAYER_RPGCODE_LEVUP:
			pData->charLevelUpRPGCode = str;
			break;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetGeneralString(int infoCode, int arrayPos, int playerSlot, BSTR *pRet)
{
	extern CInventory g_inv;
	extern MAIN_FILE g_mainFile;

	CPlayer *pPlayer = NULL;
	if (abs(playerSlot) < g_players.size()) pPlayer = g_players[abs(playerSlot)]; 

	BSTR bstr = NULL;
	switch (infoCode)
	{
		case GEN_PLAYERHANDLES:
			if (pPlayer) bstr = getString(pPlayer->name());
			break;
		case GEN_PLAYERFILES:
			if (pPlayer) bstr = getString(pPlayer->getPlayer()->fileName);
			break;
		case GEN_PLYROTHERHANDLES:
			// TBD. [Not currently held.]
			break;
		case GEN_PLYROTHERFILES:
			// TBD. [Not currently held.]
			break;
		case GEN_INVENTORY_FILES:
			bstr = getString(removePath(g_inv.fileAt(arrayPos)));
			break;
		case GEN_INVENTORY_HANDLES:
			bstr = getString(g_inv.handleAt(arrayPos));
			break;
		case GEN_EQUIP_FILES:
			{
				EQ_SLOT eq = pPlayer->equipment(arrayPos);
				bstr = getString(eq.first);
			} break;
		case GEN_EQUIP_HANDLES:
			{
				EQ_SLOT eq = pPlayer->equipment(arrayPos);
				bstr = getString(eq.second);
			} break;
		case GEN_MUSICPLAYING:
			extern CAudioSegment *g_bkgMusic;
			bstr = getString(g_bkgMusic->getPlayingFile());
			break;
		case GEN_CURRENTBOARD:
			extern LPBOARD g_pBoard;
			bstr = getString(g_pBoard->strFilename);
			break;
		case GEN_MENUGRAPHIC:
			bstr = getString(g_menuGraphic);
			break;
		case GEN_FIGHTMENUGRAPHIC:
			bstr = getString(g_fightMenuGraphic);
			break;
		case GEN_MWIN_PIC_FILE:
			extern STRING g_mwinBkg;
			bstr = getString(g_mwinBkg);
			break;
		case GEN_FONTFILE:
			extern STRING g_fontFace;
			bstr = getString(g_fontFace);
			break;
		case GEN_ENE_FILE:
			bstr = getString(g_enemies[playerSlot].fileName);
			break;
		case GEN_ENE_WINPROGRAMS:
			bstr = getString(g_enemies[playerSlot].enemy.winPrg);
			break;
		case GEN_ENE_STATUS:
		case GEN_PLYR_STATUS:
			int party, idx;
			if (infoCode == GEN_PLYR_STATUS)
			{
				getFighterIndices(pPlayer, party, idx);
			}
			else
			{
				party = ENEMY_PARTY;
				idx = playerSlot;
			}
			if ((party != -1) && (idx != -1))
			{
				LPFIGHTER pFighter = getFighter(party, idx);
				if (pFighter)
				{
					std::map<STRING, STATUS_EFFECT>::iterator i = pFighter->statuses.begin();
					if (arrayPos < 0) arrayPos = 0;
					if (pFighter->statuses.size() > arrayPos)
					{
						i = advance(i, arrayPos);
						bstr = getString(i->first);
					}
				}
			}
			break;
		case GEN_CURSOR_MOVESOUND:
			bstr = getString(g_mainFile.cursorMoveSound);
			break;
		case GEN_CURSOR_SELSOUND:
			bstr = getString(g_mainFile.cursorSelectSound);
			break;
		case GEN_CURSOR_CANCELSOUND:
			bstr = getString(g_mainFile.cursorCancelSound);
			break;
	}
	if (bstr)
	{
		SysReAllocString(pRet, bstr);
		SysFreeString(bstr);
	}
	else
	{
		SysReAllocString(pRet, L"");
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetGeneralNum(int infoCode, int arrayPos, int playerSlot, int *pRet)
{
	extern CPlayer *g_pSelectedPlayer;
	extern std::vector<CPlayer *> g_players;
	extern LPBOARD g_pBoard;

	CPlayer *pPlayer = NULL;
	if (abs(playerSlot) < g_players.size()) pPlayer = g_players[abs(playerSlot)]; 

	switch (infoCode)
	{
		case GEN_INVENTORY_NUM:
			extern CInventory g_inv;
			*pRet = g_inv.quantityAt(arrayPos);
			break;
		case GEN_EQUIP_HPADD:
			if (pPlayer) *pRet = pPlayer->equipmentHP();
			break;
		case GEN_EQUIP_SMPADD:
			if (pPlayer) *pRet = pPlayer->equipmentSM();
			break;
		case GEN_EQUIP_DPADD:
			if (pPlayer) *pRet = pPlayer->equipmentDP();
			break;
		case GEN_EQUIP_FPADD:
			if (pPlayer) *pRet = pPlayer->equipmentFP();
			break;
		case GEN_CURX:
		case GEN_CURY:
			if (pPlayer)
			{
				SPRITE_POSITION p = pPlayer->getPosition();
				int x = p.x, y = p.y;
				tileCoordinate(x, y, g_pBoard->coordType);
				*pRet = (infoCode == GEN_CURX ? x : y);
			} break;
		case GEN_CURLAYER:
			if (pPlayer) *pRet = pPlayer->getPosition().l;
			break;
		case GEN_CURRENT_PLYR:
			extern int g_selectedPlayer;
			*pRet = g_selectedPlayer;
			break;
		case GEN_TILESX:
			extern double g_tilesX;
			*pRet = int(g_tilesX);
			break;
		case GEN_TILESY:
			extern double g_tilesY;
			*pRet = int(g_tilesY);
			break;
		case GEN_RESX:
			extern RECT g_screen;
			*pRet = g_screen.right - g_screen.left;
			break;
		case GEN_RESY:
			extern RECT g_screen;
			*pRet = g_screen.bottom - g_screen.top;
			break;
		case GEN_GP:
			extern unsigned long g_gp;
			*pRet = int(g_gp);
			break;
		case GEN_FONTCOLOR:
			extern COLORREF g_color;
			*pRet = g_color;
			break;
		case GEN_PREV_TIME:
			// Total game runtime prior to this session (seconds).
			extern GAME_TIME g_gameTime;
			*pRet = g_gameTime.runTime;
			break;
		case GEN_START_TIME:
			// Processor "time" at start of this session (seconds).
			extern GAME_TIME g_gameTime;
			*pRet = g_gameTime.startTime;
			break;
		case GEN_GAME_TIME:
			// Total game runtime including this session (seconds).
			extern GAME_TIME g_gameTime;
			*pRet = g_gameTime.gameTime();
			break;
		case GEN_STEPS:
			extern unsigned long g_stepsTaken;
			*pRet = g_stepsTaken / 32.0;
			break;
		case GEN_ENE_RUN:
			*pRet = int(canRunFromFight());
			break;
		case GEN_TRANSPARENTCOLOR:
			*pRet = TRANSP_COLOR;
			break;
		case GEN_BATTLESPEED:
		case GEN_TEXTSPEED:
		case GEN_CHARACTERSPEED:
		case GEN_SCROLLINGOFF:
		case GEN_ENEX:
		case GEN_ENEY:
		case GEN_FIGHT_OFFSETX:
		case GEN_FIGHT_OFFSETY:
			// Obsolete.
			*pRet = 0;
			break;
		default:
			*pRet = 0;
			break;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBSetGeneralString(int infoCode, int arrayPos, int playerSlot, BSTR newVal)
{
	extern CInventory g_inv;

	switch (infoCode)
	{
		case GEN_PLAYERHANDLES:
			break;
		case GEN_PLAYERFILES:
			break;
		case GEN_PLYROTHERHANDLES:
			break;
		case GEN_PLYROTHERFILES:
			break;
		case GEN_INVENTORY_FILES:
			g_inv.fileAt(arrayPos, getString(newVal));
			break;
		case GEN_INVENTORY_HANDLES:
			g_inv.handleAt(arrayPos, getString(newVal));
			break;
		case GEN_EQUIP_FILES:
			break;
		case GEN_EQUIP_HANDLES:
			break;
		case GEN_MUSICPLAYING:
			break;
		case GEN_CURRENTBOARD:
			break;
		case GEN_MENUGRAPHIC:
			break;
		case GEN_FIGHTMENUGRAPHIC:
			break;
		case GEN_MWIN_PIC_FILE:
			break;
		case GEN_FONTFILE:
			break;
		case GEN_ENE_FILE:
			break;
		case GEN_ENE_WINPROGRAMS:
			break;
		case GEN_ENE_STATUS:
		case GEN_PLYR_STATUS:
		case GEN_CURSOR_MOVESOUND:
			break;
		case GEN_CURSOR_SELSOUND:
			break;
		case GEN_CURSOR_CANCELSOUND:
			break;
	}

	return S_OK;
}

STDMETHODIMP CCallbacks::CBSetGeneralNum(int infoCode, int arrayPos, int playerSlot, int newVal)
{
	switch (infoCode)
	{
		case GEN_INVENTORY_NUM:
			extern CInventory g_inv;
			g_inv.quantityAt(arrayPos, (unsigned int)newVal);
			break;
		case GEN_EQUIP_HPADD:
			break;
		case GEN_EQUIP_SMPADD:
			break;
		case GEN_EQUIP_DPADD:
			break;
		case GEN_EQUIP_FPADD:
			break;
		case GEN_CURX:
		case GEN_CURY:
			break;
		case GEN_CURLAYER:
			break;
		case GEN_CURRENT_PLYR:
			break;
		case GEN_TILESX:
			break;
		case GEN_TILESY:
			break;
		case GEN_RESX:
			break;
		case GEN_RESY:
			break;
		case GEN_GP:
			break;
		case GEN_FONTCOLOR:
			break;
		case GEN_PREV_TIME:
			break;
		case GEN_START_TIME:
			break;
		case GEN_GAME_TIME:
			break;
		case GEN_STEPS:
			break;
		case GEN_ENE_RUN:
			break;
		case GEN_TRANSPARENTCOLOR:
			break;
		case GEN_BATTLESPEED:
		case GEN_TEXTSPEED:
		case GEN_CHARACTERSPEED:
		case GEN_SCROLLINGOFF:
		case GEN_ENEX:
		case GEN_ENEY:
		case GEN_FIGHT_OFFSETX:
		case GEN_FIGHT_OFFSETY:
			// Obsolete.
			break;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetCommandName(BSTR rpgcodeCommand, BSTR *pRet)
{
	STRING str = getString(rpgcodeCommand);
	str = str.substr(0, str.find_first_of(_T('(')));
	char *const pstr = _strlwr(_strdup(str.c_str()));
	BSTR bstr = getString(pstr);
	SysReAllocString(pRet, bstr);
	SysFreeString(bstr);
	free(pstr);
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetBrackets(BSTR rpgcodeCommand, BSTR *pRet)
{
	STRING str = getString(rpgcodeCommand);
	str = str.substr(str.find_first_of(_T('(')) + 1);
	str = str.substr(0, str.find_last_of(_T(')')));
	BSTR bstr = getString(str);
	SysReAllocString(pRet, bstr);
	SysFreeString(bstr);
	return S_OK;
}

void getParameters(const STRING str, std::vector<STRING> &ret)
{
	int pos = str.find(_T('(')) + 1;
	bool bQuotes = false;
	unsigned int i;
	for (i = pos; i < str.length(); ++i)
	{
		const char &c = str[i];
		if (c == _T('"')) bQuotes = !bQuotes;
		else if (!bQuotes)
		{
			if (c == _T(','))
			{
				ret.push_back(str.substr(pos, i - pos));
				pos = i + 1;
			}
			else if (c == _T(')')) break;
		}
	}
	const STRING push = str.substr(pos, i - pos);
	if (!push.empty())
	{
		ret.push_back(push);
	}
}

STDMETHODIMP CCallbacks::CBCountBracketElements(BSTR rpgcodeCommand, int *pRet)
{
	const STRING str = getString(rpgcodeCommand);
	std::vector<STRING> parts;
	getParameters(str, parts);
	*pRet = parts.size();
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetBracketElement(BSTR rpgcodeCommand, int elemNum, BSTR *pRet)
{
	const STRING str = getString(rpgcodeCommand);
	std::vector<STRING> parts;
	getParameters(str, parts);
	if (parts.size() > --elemNum)
	{
		BSTR bstr = getString(parts[elemNum]);
		SysReAllocString(pRet, bstr);
		SysFreeString(bstr);
	}
	else
	{
		SysReAllocString(pRet, L"");
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetStringElementValue(BSTR rpgcodeCommand, BSTR *pRet)
{
	const STRING str = getString(rpgcodeCommand);
	STRING ret;
	char c = str[str.length() - 1];
	if (c == _T('$'))
	{
		const STRING var = str.substr(0, str.length() - 1);
		ret = g_prg->getVar(var)->getLit();
	}
	else
	{
		ret = str.substr(1, str.length() - 2);
	}

	BSTR bstr = getString(ret);
	SysReAllocString(pRet, bstr);
	SysFreeString(bstr);
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetNumElementValue(BSTR rpgcodeCommand, double *pRet)
{
	const STRING str = getString(rpgcodeCommand);
	char c = str[str.length() - 1];
	if (c == _T('!'))
	{
		const STRING var = str.substr(0, str.length() - 1);
		*pRet = g_prg->getVar(var)->getNum();
	}
	else
	{
		*pRet = atof(str.c_str());
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetElementType(BSTR data, int *pRet)
{
	const STRING str = getString(data);
	if (str[0] == _T('"'))
	{
		*pRet = PLUG_DT_LIT;
	}
	else
	{
		char c = str[str.length() - 1];
		if (c == _T('!')) *pRet = PLUG_DT_NUM;
		else if (c == _T('$')) *pRet = PLUG_DT_LIT;
		else
		{
			*pRet = PLUG_DT_NUM;
		}
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBDebugMessage(BSTR message)
{
	CProgram::debugger(getString(message));
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetPathString(int infoCode, BSTR *pRet)
{
	extern STRING g_projectPath, g_savePath;

	STRING str;
	switch (infoCode)
	{
		case PATH_TILE:
			str = TILE_PATH;
			break;
		case PATH_BOARD:
			str = BRD_PATH;
			break;
		case PATH_CHAR:
			str = TEM_PATH;
			break;
		case PATH_SPC:
			str = SPC_PATH;
			break;
		case PATH_BKG:
			str = BKG_PATH;
			break;
		case PATH_MEDIA:
			str = MEDIA_PATH;
			break;
		case PATH_PRG:
			str = PRG_PATH;
			break;
		case PATH_FONT:
			str = FONT_PATH;
			break;
		case PATH_ITEM:
			str = ITM_PATH;
			break;
		case PATH_ENEMY:
			str = ENE_PATH;
			break;
		case PATH_MAIN:
			str = GAM_PATH;
			break;
		case PATH_BITMAP:
			str = BMP_PATH;
			break;
		case PATH_STATUSFX:
			str = STATUS_PATH;
			break;
		case PATH_MISC:
			str = MISC_PATH;
			break;
		case PATH_SAVE:
			str = g_savePath;
			break;
		case PATH_PROJECT:
			str = g_projectPath;
			break;
	}

	BSTR bstr = getString(str);
	SysReAllocString(pRet, bstr);
	SysFreeString(bstr);
	return S_OK;
}

STDMETHODIMP CCallbacks::CBLoadSpecialMove(BSTR file)
{
	extern STRING g_projectPath;
	g_spc.open(g_projectPath + SPC_PATH + getString(file));
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetSpecialMoveString(int infoCode, BSTR *pRet)
{
	STRING str;
	switch (infoCode)
	{
		case SPC_NAME:
			str = g_spc.name;
			break;
		case SPC_PRG_FILE:
			str = g_spc.prg;
			break;
		case SPC_STATUSFX:
			str = g_spc.status;
			break;
		case SPC_ANIMATION:
			str = g_spc.animation;
			break;
		case SPC_DESCRIPTION:
			str = g_spc.description;
			break;
	}

	BSTR bstr = getString(str);
	SysReAllocString(pRet, bstr);
	SysFreeString(bstr);
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetSpecialMoveNum(int infoCode, int *pRet)
{
	switch (infoCode)
	{
		case SPC_FP:
			*pRet = g_spc.fp;
			break;
		case SPC_SMP:
			*pRet = g_spc.smp;
			break;
		case SPC_TARGET_SMP:
			*pRet = g_spc.targSmp;
			break;
		case SPC_BATTLEDRIVEN:
			*pRet = g_spc.battle;
			break;
		case SPC_MENUDRIVEN:
			*pRet = g_spc.menu;
			break;
		default:
			*pRet = 0;
			break;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBLoadItem(BSTR file, int itmSlot)
{
	extern LPBOARD g_pBoard;
	extern STRING g_projectPath;

	const STRING path = g_projectPath + ITM_PATH + addExtension(getString(file), _T("itm"));

	if (itmSlot < 0)
	{
		itmSlot = -itmSlot;
		g_items.resize(itmSlot + 1);
		g_items[itmSlot].open(path, NULL);
	}
	else
	{
		g_pBoard->items.resize(itmSlot + 1, NULL);
		CItem **ppItem = &g_pBoard->items[itmSlot];
		delete *ppItem;
		*ppItem = new CItem();
		(*ppItem)->open(path);
	}

	return S_OK;
}

LPITEM getItemFromSlot(int itmSlot)
{
	extern LPBOARD g_pBoard;

	if (itmSlot < 0)
	{
		itmSlot = -itmSlot;
		if (g_items.size() > itmSlot)
		{
			return &g_items[itmSlot];
		}
	}
	else if (g_pBoard->items.size() > itmSlot)
	{
		return g_pBoard->items[itmSlot]->getItem();
	}
	return NULL;
}

STDMETHODIMP CCallbacks::CBGetItemString(int infoCode, int arrayPos, int itmSlot, BSTR *pRet)
{
	LPITEM pItem = getItemFromSlot(itmSlot);

	if (!pItem)
	{
		SysReAllocString(pRet, L"");
		return S_OK;
	}

	STRING str;
	switch (infoCode)
	{
		case ITM_NAME:
			str = pItem->itemName;
			break;
		case ITM_ACCESSORY:
			str = pItem->accessory;
			break;
		case ITM_EQUIP_PRG:
			str = pItem->prgEquip;
			break;
		case ITM_REMOVE_PRG:
			str = pItem->prgRemove;
			break;
		case ITM_MENU_PRG:
			str = pItem->mnuUse;
			break;
		case ITM_FIGHT_PRG:
			str = pItem->fgtUse;
			break;
		case ITM_ONBOARD_PRG:
			str = pItem->itmPrgOnBoard;
			break;
		case ITM_PICKEDUP_PRG:
			str = pItem->itmPrgPickUp;
			break;
		case ITM_CHARACTERS:
			arrayPos = bounds(arrayPos, 0, int(pItem->itmChars.size() - 1));
			str = pItem->itmChars[arrayPos];
			break;
		case ITM_DESCRIPTION:
			str = pItem->itmDescription;
			break;
		case ITM_ANIMATION:
			str = pItem->itmAnimation;
			break;
	}

	BSTR bstr = getString(str);
	SysReAllocString(pRet, bstr);
	SysFreeString(bstr);
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetItemNum(int infoCode, int arrayPos, int itmSlot, int *pRet)
{
	LPITEM pItem = getItemFromSlot(itmSlot);
	if (!pItem)
	{
		*pRet = 0;
		return S_OK;
	}

	switch (infoCode)
	{
		case ITM_EQUIP_YN:
			*pRet = pItem->equipYN;
			break;
		case ITM_MENU_YN:
			*pRet = pItem->menuYN;
			break;
		case ITM_BOARD_YN:
			*pRet = pItem->boardYN;
			break;
		case ITM_FIGHT_YN:
			*pRet = pItem->fightYN;
			break;
		case ITM_EQUIP_LOCATION:
			arrayPos = bounds(arrayPos, 0, int(pItem->itemArmor.size() - 1));
			*pRet = pItem->itemArmor[arrayPos];
			break;
		case ITM_EQUIP_HPUP:
			*pRet = pItem->equipHP;
			break;
		case ITM_EQUIP_DPUP:
			*pRet = pItem->equipDP;
			break;
		case ITM_EQUIP_FPUP:
			*pRet = pItem->equipFP;
			break;
		case ITM_EQUIP_SMPUP:
			*pRet = pItem->equipSM;
			break;
		case ITM_MENU_HPUP:
			*pRet = pItem->mnuHPup;
			break;
		case ITM_MENU_SMPUP:
			*pRet = pItem->mnuSMup;
			break;
		case ITM_FIGHT_HPUP:
			*pRet = pItem->fgtHPup;
			break;
		case ITM_FIGHT_SMPUP:
			*pRet = pItem->fgtSMup;
			break;
		case ITM_USEDBY:
			*pRet = pItem->usedBy;
			break;
		case ITM_BUYING_PRICE:
			*pRet = pItem->buyPrice;
			break;
		case ITM_SELLING_PRICE:
			*pRet = pItem->sellPrice;
			break;
		case ITM_KEYITEM:
			*pRet = pItem->keyItem;
			break;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetBoardNum(int infoCode, int arrayPos1, int arrayPos2, int arrayPos3, int *pRet)
{
	extern LPBOARD g_pBoard;

	LPBRD_PROGRAM pPrg = NULL;
	CItem *pItem = NULL;

	if ((infoCode >= BRD_PRG_X) && (infoCode <= BRD_PRG_ACTIV_TYPE))
	{
		try
		{
			pPrg = g_pBoard->programs[bounds(arrayPos1, 0, int(g_pBoard->programs.size() - 1))];
		}
		catch (...) { }
	}
	else if ((infoCode >= BRD_ITM_X) && (infoCode <= BRD_ITM_ACTIV_TYPE))
	{
		try
		{
			pItem = g_pBoard->items[bounds(arrayPos1, 0, int(g_pBoard->items.size() - 1))];
		}
		catch (...) { }
	}

	switch (infoCode)
	{
		case BRD_SIZEX:
			*pRet = g_pBoard->bSizeX;
			break;
		case BRD_SIZEY:
			*pRet = g_pBoard->bSizeY;
			break;
		case BRD_AMBIENTRED:
			try
			{
				*pRet = g_pBoard->ambientRed[arrayPos1][arrayPos2][arrayPos3];
			}
			catch (...)
			{
				*pRet = 0;
			}
			break;
		case BRD_AMBIENTGREEN:
			try
			{
				*pRet = g_pBoard->ambientGreen[arrayPos1][arrayPos2][arrayPos3];
			}
			catch (...)
			{
				*pRet = 0;
			}
			break;
		case BRD_AMBIENTBLUE:
			try
			{
				*pRet = g_pBoard->ambientBlue[arrayPos1][arrayPos2][arrayPos3];
			}
			catch (...)
			{
				*pRet = 0;
			}
			break;
		case BRD_TILETYPE:
			try
			{
				*pRet = g_pBoard->tiletype[arrayPos1][arrayPos2][arrayPos3];
			}
			catch (...)
			{
				*pRet = 0;
			}
			break;
		case BRD_BACKCOLOR:
			*pRet = g_pBoard->brdColor;
			break;
		case BRD_BORDERCOLOR:
			*pRet = g_pBoard->borderColor;
			break;
		case BRD_SKILL:
			*pRet = g_pBoard->boardSkill;
			break;
		case BRD_FIGHTINGYN:
			*pRet = g_pBoard->fightingYN;
			break;
		case BRD_PRG_X:
		case BRD_PRG_Y:
		{
			if (pPrg)
			{
				DB_POINT pt = pPrg->vBase[0];
				int x = int(pt.x), y = int(pt.y);
				tileCoordinate(x, y, TILE_NORMAL);
				*pRet = ((infoCode == BRD_PRG_X) ? x : y);
			}
			else
			{
				*pRet = 0;
			}
		} break;
		case BRD_PRG_LAYER:
			*pRet = pPrg ? pPrg->layer : 0;
			break;
		case BRD_PRG_ACTIVATION:
			*pRet = pPrg ? pPrg->activate : 0;
			break;
		case BRD_PRG_ACTIV_TYPE:
			*pRet = pPrg ? (pPrg->activationType & PRG_KEYPRESS) : 0;
			break;
		case BRD_ITM_X:
		case BRD_ITM_Y:
			// TBD.
			// Delano, do we throw these away? (The answer is yes.)
			// What do you think we should do?
			break;
		case BRD_ITM_LAYER:
			// TBD, as above.
			break;
		case BRD_ITM_ACTIVATION:
			*pRet = pItem ? pItem->getBoardSprite()->activate : 0;
			break;
		case BRD_ITM_ACTIV_TYPE:
			*pRet = pItem ? (pItem->getBoardSprite()->activationType & PRG_KEYPRESS) : 0;
			break;
		case BRD_PLAYERX:
			*pRet = g_pBoard->playerX;
			break;
		case BRD_PLAYERY:
			*pRet = g_pBoard->playerY;
			break;
		case BRD_PLAYERLAYER:
			*pRet = g_pBoard->playerLayer;
			break;
		case BRD_SAVING_DISABLED:
			*pRet = g_pBoard->brdSavingYN;
			break;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetBoardString(int infoCode, int arrayPos1, int arrayPos2, int arrayPos3, BSTR *pRet)
{
	extern LPBOARD g_pBoard;

	LPBRD_PROGRAM pPrg = NULL;
	CItem *pItem = NULL;

	if ((infoCode >= BRD_PRG) && (infoCode <= BRD_PRG_DONE_INIT))
	{
		try
		{
			pPrg = g_pBoard->programs[bounds(arrayPos1, 0, int(g_pBoard->programs.size() - 1))];
		}
		catch (...) { }
	}
	else if ((infoCode >= BRD_ITM) && (infoCode <= BRD_ITM_MULTI))
	{
		try
		{
			pItem = g_pBoard->items[bounds(arrayPos1, 0, int(g_pBoard->items.size() - 1))];
		}
		catch (...) { }
	}

	STRING str;

	switch (infoCode)
	{
		case BRD_TILE:
			try
			{
				str = g_pBoard->tileIndex[g_pBoard->board[arrayPos1][arrayPos2][arrayPos3]];
			}
			catch (...) { }
			break;
		case BRD_BACK_IMAGE:
			str = g_pBoard->brdBack;
			break;
		case BRD_BORDER_IMAGE:
			str = g_pBoard->borderBack;
			break;
		case BRD_DIR_LINK:
			str = g_pBoard->dirLink[bounds(arrayPos1, 0, int(g_pBoard->dirLink.size() - 1))];
			break;
		case BRD_FIGHT_BKG:
			str = g_pBoard->boardBackground;
			break;
		case BRD_MUSIC:
			str = g_pBoard->boardMusic;
			break;
		case BRD_LAYER_NAME:
			str = g_pBoard->boardTitle[bounds(arrayPos1, 0, int(g_pBoard->boardTitle.size() - 1))];
			break;
		case BRD_PRG:
			if (pPrg) str = pPrg->fileName;
			break;
		case BRD_PRG_GFX:
			if (pPrg) str = pPrg->graphic;
			break;
		case BRD_PRG_ACTIVE_VAR:
			if (pPrg) str = pPrg->initialVar;
			break;
		case BRD_PRG_DONE_VAR:
			if (pPrg) str = pPrg->finalVar;
			break;
		case BRD_PRG_ACTIVE_INIT:
			if (pPrg) str = pPrg->initialValue;
			break;
		case BRD_PRG_DONE_INIT:
			if (pPrg) str = pPrg->finalValue;
			break;
		case BRD_ITM:
			if (pItem) str = pItem->getBoardSprite()->fileName;
			break;
		case BRD_ITM_ACTIVE_VAR:
			if (pItem) str = pItem->getBoardSprite()->initialVar;
			break;
		case BRD_ITM_DONE_VAR:
			if (pItem) str = pItem->getBoardSprite()->finalVar;
			break;
		case BRD_ITM_ACTIVE_INIT:
			if (pItem) str = pItem->getBoardSprite()->initialValue;
			break;
		case BRD_ITM_DONE_INIT:
			if (pItem) str = pItem->getBoardSprite()->finalValue;
			break;
		case BRD_ITM_PROGRAM:
			if (pItem) str = pItem->getBoardSprite()->prgActivate;
			break;
		case BRD_ITM_MULTI:
			if (pItem) str = pItem->getBoardSprite()->prgMultitask;
			break;
	}

	BSTR bstr = getString(str);
	SysReAllocString(pRet, bstr);
	SysFreeString(bstr);
	return S_OK;
}

STDMETHODIMP CCallbacks::CBSetBoardNum(int infoCode, int arrayPos1, int arrayPos2, int arrayPos3, int nValue)
{
	// TBD
	return S_OK;
}

STDMETHODIMP CCallbacks::CBSetBoardString(int infoCode, int arrayPos1, int arrayPos2, int arrayPos3, BSTR newVal)
{
	// TBD
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetHwnd(int *pRet)
{
	extern HWND g_hHostWnd;
	*pRet = (int)g_hHostWnd;
	return S_OK;
}

STDMETHODIMP CCallbacks::CBRefreshScreen(int *pRet)
{
	*pRet = g_pDirectDraw->Refresh();
	return S_OK;
}

STDMETHODIMP CCallbacks::CBCreateCanvas(int width, int height, int *pRet)
{
	CCanvas *p = g_canvases.allocate();
	p->CreateBlank(NULL, width, height, TRUE);
	*pRet = (int)p;
	return S_OK;
}

STDMETHODIMP CCallbacks::CBDestroyCanvas(int canvasID, int *pRet)
{
	*pRet = (int)g_canvases.free((CCanvas *)canvasID);
	return S_OK;
}

STDMETHODIMP CCallbacks::CBDrawCanvas(int canvasID, int x, int y, int *pRet)
{
	CCanvas *p = g_canvases.cast(canvasID);
	if (p)
	{
		*pRet = g_pDirectDraw->DrawCanvas(p, x, y, SRCCOPY);
	}
	else
	{
		*pRet = FALSE;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBDrawCanvasPartial(int canvasID, int xDest, int yDest, int xsrc, int ysrc, int width, int height, int *pRet)
{
	CCanvas *p = g_canvases.cast(canvasID);
	if (p)
	{
		*pRet = g_pDirectDraw->DrawCanvasPartial(p, xDest, yDest, xsrc, ysrc, width, height, SRCCOPY);
	}
	else
	{
		*pRet = FALSE;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBDrawCanvasTransparent(int canvasID, int x, int y, int crTransparentColor, int *pRet)
{
	CCanvas *p = g_canvases.cast(canvasID);
	if (p)
	{
		*pRet = g_pDirectDraw->DrawCanvasTransparent(p, x, y, crTransparentColor);
	}
	else
	{
		*pRet = FALSE;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBDrawCanvasTransparentPartial(int canvasID, int xDest, int yDest, int xsrc, int ysrc, int width, int height, int crTransparentColor, int *pRet)
{
	CCanvas *p = g_canvases.cast(canvasID);
	if (p)
	{
		*pRet = g_pDirectDraw->DrawCanvasTransparentPartial(p, xDest, yDest, xsrc, ysrc, width, height, crTransparentColor);
	}
	else
	{
		*pRet = FALSE;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBDrawCanvasTranslucent(int canvasID, int x, int y, double dIntensity, int crUnaffectedColor, int crTransparentColor, int *pRet)
{
	CCanvas *p = g_canvases.cast(canvasID);
	if (p)
	{
		*pRet = g_pDirectDraw->DrawCanvasTranslucent(p, x, y, dIntensity, crUnaffectedColor, crTransparentColor);
	}
	else
	{
		*pRet = FALSE;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBCanvasLoadImage(int canvasID, BSTR filename, int *pRet)
{
	CCanvas *p = g_canvases.cast(canvasID);
	if (p)
	{
		extern STRING g_projectPath;
		drawImage(g_projectPath + BMP_PATH + getString(filename), p, 0, 0, -1, -1);
	}
	else
	{
		*pRet = FALSE;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBCanvasLoadSizedImage(int canvasID, BSTR filename, int *pRet)
{
	CCanvas *p = g_canvases.cast(canvasID);
	if (p)
	{
		extern STRING g_projectPath;
		drawImage(g_projectPath + BMP_PATH + getString(filename), p, 0, 0, p->GetWidth(), p->GetHeight());
	}
	else
	{
		*pRet = FALSE;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBCanvasFill(int canvasID, int crColor, int *pRet)
{
	CCanvas *p = g_canvases.cast(canvasID);
	if (*pRet = (p != NULL))
	{
		p->ClearScreen(crColor);
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBCanvasResize(int canvasID, int width, int height, int *pRet)
{
	CCanvas *p = g_canvases.cast(canvasID);
	if (*pRet = (p != NULL))
	{
		p->Resize(NULL, width, height);
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBCanvas2CanvasBlt(int cnvSrc, int cnvDest, int xDest, int yDest, int *pRet)
{
	CCanvas *p = g_canvases.cast(cnvSrc);
	if (p)
	{
		CCanvas *pDest = g_canvases.cast(cnvDest);
		if (pDest)
		{	
			*pRet = p->Blt(pDest, xDest, yDest, SRCCOPY);
		}
		else
		{
			*pRet = FALSE;
		}
	}
	else
	{
		*pRet = FALSE;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBCanvas2CanvasBltPartial(int cnvSrc, int cnvDest, int xDest, int yDest, int xsrc, int ysrc, int width, int height, int *pRet)
{
	CCanvas *p = g_canvases.cast(cnvSrc);
	if (p)
	{
		CCanvas *pDest = g_canvases.cast(cnvDest);
		if (pDest)
		{	
			*pRet = p->BltPart(pDest, xDest, yDest, xsrc, ysrc, width, height, SRCCOPY);
		}
		else
		{
			*pRet = FALSE;
		}
	}
	else
	{
		*pRet = FALSE;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBCanvas2CanvasBltTransparent(int cnvSrc, int cnvDest, int xDest, int yDest, int crTransparentColor, int *pRet)
{
	CCanvas *p = g_canvases.cast(cnvSrc);
	if (p)
	{
		CCanvas *pDest = g_canvases.cast(cnvDest);
		if (pDest)
		{	
			*pRet = p->BltTransparent(pDest, xDest, yDest, crTransparentColor);
		}
		else
		{
			*pRet = FALSE;
		}
	}
	else
	{
		*pRet = FALSE;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBCanvas2CanvasBltTransparentPartial(int cnvSrc, int cnvDest, int xDest, int yDest, int xsrc, int ysrc, int width, int height, int crTransparentColor, int *pRet)
{
	CCanvas *p = g_canvases.cast(cnvSrc);
	if (p)
	{
		CCanvas *pDest = g_canvases.cast(cnvDest);
		if (pDest)
		{	
			*pRet = p->BltTransparentPart(pDest, xDest, yDest, xsrc, ysrc, width, height, crTransparentColor);
		}
		else
		{
			*pRet = FALSE;
		}
	}
	else
	{
		*pRet = FALSE;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBCanvas2CanvasBltTranslucent(int cnvSrc, int cnvDest, int destX, int destY, double dIntensity, int crUnaffectedColor, int crTransparentColor, int *pRet)
{
	CCanvas *p = g_canvases.cast(cnvSrc);
	if (p)
	{
		CCanvas *pDest = g_canvases.cast(cnvDest);
		if (pDest)
		{	
			*pRet = p->BltTranslucent(pDest, destX, destY, dIntensity, crUnaffectedColor, crTransparentColor);
		}
		else
		{
			*pRet = FALSE;
		}
	}
	else
	{
		*pRet = FALSE;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBCanvasGetScreen(int cnvDest, int *pRet)
{
	CCanvas *p = g_canvases.cast(cnvDest);
	if (p)
	{
		*pRet = g_pDirectDraw->CopyScreenToCanvas(p);
	}
	else
	{
		*pRet = FALSE;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBLoadString(int id, BSTR defaultString, BSTR *pRet)
{
	// Translations?
	SysReAllocString(pRet, defaultString); // Just return default.
	return S_OK;
}

STDMETHODIMP CCallbacks::CBCanvasDrawText(int canvasID, BSTR text, BSTR font, int size, double x, double y, int crColor, int isBold, int isItalics, int isUnderline, int isCentred, int isOutlined, int *pRet)
{
	CCanvas *p = g_canvases.cast(canvasID);
	if (p)
	{
		*pRet = p->DrawText(x * size - size, y * size - size, getString(text), getString(font), size, crColor, isBold, isItalics, isUnderline, isCentred, isOutlined);
	}
	else
	{
		*pRet = FALSE;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBCanvasPopup(int canvasID, int x, int y, int stepSize, int popupType, int *pRet)
{
	#define POPUP_NOFX			0
	#define POPUP_VERTICAL		1
	#define POPUP_HORIZONTAL	2

	CCanvas *p = g_canvases.cast(canvasID);
	if (!p)
	{
		*pRet = FALSE;
		return S_OK;
	}

	switch (popupType)
	{
		case POPUP_NOFX:
			// Nothing required.
			break;
		case POPUP_VERTICAL:
		{
			const int w = p->GetWidth();
			const int h = p->GetHeight();
			int cnt = 0;
			CCanvas temp = *g_pDirectDraw->getBackBuffer();
			for (int i = int(h / 2); i >= 0; i -= stepSize)
			{
				g_pDirectDraw->DrawCanvas(&temp, 0, 0);
				g_pDirectDraw->DrawCanvasPartial(p, x, y + i, 0, 0, w, h / 2 - i);
				g_pDirectDraw->DrawCanvasPartial(p, x, y + h / 2, 0, h - cnt, w, h / 2 - i);
				g_pDirectDraw->Refresh();
				cnt += stepSize;
				processEvent();
			}
		} break;
		case POPUP_HORIZONTAL:
		{
			const int w = p->GetWidth();
			const int h = p->GetHeight();
			int cnt = 0;
			CCanvas temp = *g_pDirectDraw->getBackBuffer();
			for (int i = int(w / 2); i >= 0; i -= stepSize)
			{
				g_pDirectDraw->DrawCanvas(&temp, 0, 0);
				g_pDirectDraw->DrawCanvasPartial(p, x + i, y, 0, 0, w / 2 - i, h);
				g_pDirectDraw->DrawCanvasPartial(p, x + w / 2, y, w - cnt, 0, w / 2 - i, h);
				g_pDirectDraw->Refresh();
				cnt += stepSize;
				processEvent();
			}
		} break;
	}

	// Render the canvas.
	g_pDirectDraw->DrawCanvas(p, x, y);
	g_pDirectDraw->Refresh();

	*pRet = TRUE;
	return S_OK;
}

STDMETHODIMP CCallbacks::CBCanvasWidth(int canvasID, int *pRet)
{
	CCanvas *p = g_canvases.cast(canvasID);
	if (p)
	{
		*pRet = p->GetWidth();
	}
	else
	{
		*pRet = FALSE;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBCanvasHeight(int canvasID, int *pRet)
{
	CCanvas *p = g_canvases.cast(canvasID);
	if (p)
	{
		*pRet = p->GetHeight();
	}
	else
	{
		*pRet = FALSE;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBCanvasDrawLine(int canvasID, int x1, int y1, int x2, int y2, int crColor, int *pRet)
{
	CCanvas *p = g_canvases.cast(canvasID);
	if (p)
	{
		*pRet = p->DrawLine(x1, y1, x2, y2, crColor);
	}
	else
	{
		*pRet = FALSE;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBCanvasDrawRect(int canvasID, int x1, int y1, int x2, int y2, int crColor, int *pRet)
{
	CCanvas *p = g_canvases.cast(canvasID);
	if (p)
	{
		*pRet = p->DrawRect(x1, y1, x2, y2, crColor);
	}
	else
	{
		*pRet = FALSE;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBCanvasFillRect(int canvasID, int x1, int y1, int x2, int y2, int crColor, int *pRet)
{
	CCanvas *p = g_canvases.cast(canvasID);
	if (p)
	{
		*pRet = p->DrawFilledRect(x1, y1, x2, y2, crColor);
	}
	else
	{
		*pRet = FALSE;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBCanvasDrawHand(int canvasID, int pointx, int pointy, int *pRet)
{
	extern CCanvas *g_cnvCursor;
	CCanvas *p = g_canvases.cast(canvasID);
	if (p)
	{
		*pRet = g_cnvCursor->BltTransparent(p, pointx - 42, pointy - 10, RGB(255, 0, 0));
	}
	else
	{
		*pRet = NULL;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBDrawHand(int pointx, int pointy, int *pRet)
{
	extern CCanvas *g_cnvCursor;
	*pRet = g_pDirectDraw->DrawCanvasTransparent(g_cnvCursor, pointx - 42, pointy - 10, RGB(255, 0, 0));
	return S_OK;
}

STDMETHODIMP CCallbacks::CBCheckKey(BSTR keyPressed, int *pRet)
{
	const STRING key = parser::uppercase(getString(keyPressed));
	if (key == _T("LEFT")) *pRet = (GetAsyncKeyState(VK_LEFT) < 0);
	else if (key == _T("RIGHT")) *pRet = (GetAsyncKeyState(VK_RIGHT) < 0);
	else if (key == _T("UP")) *pRet = (GetAsyncKeyState(VK_UP) < 0);
	else if (key == _T("DOWN")) *pRet = (GetAsyncKeyState(VK_DOWN) < 0);
	else if (key == _T("SPACE")) *pRet = (GetAsyncKeyState(VK_SPACE) < 0);
	else if (key == _T("ESC") || key == _T("ESCAPE")) *pRet = (GetAsyncKeyState(VK_ESCAPE) < 0);
	else if (key == _T("ENTER")) *pRet = (GetAsyncKeyState(VK_RETURN) < 0);
	else if (key == _T("NUMPAD0")) *pRet = (GetAsyncKeyState(VK_NUMPAD0) < 0);
	else if (key == _T("NUMPAD1")) *pRet = (GetAsyncKeyState(VK_NUMPAD1) < 0);
	else if (key == _T("NUMPAD2")) *pRet = (GetAsyncKeyState(VK_NUMPAD2) < 0);
	else if (key == _T("NUMPAD3")) *pRet = (GetAsyncKeyState(VK_NUMPAD3) < 0);
	else if (key == _T("NUMPAD4")) *pRet = (GetAsyncKeyState(VK_NUMPAD4) < 0);
	else if (key == _T("NUMPAD5")) *pRet = (GetAsyncKeyState(VK_NUMPAD5) < 0);
	else if (key == _T("NUMPAD6")) *pRet = (GetAsyncKeyState(VK_NUMPAD6) < 0);
	else if (key == _T("NUMPAD7")) *pRet = (GetAsyncKeyState(VK_NUMPAD7) < 0);
	else if (key == _T("NUMPAD8")) *pRet = (GetAsyncKeyState(VK_NUMPAD8) < 0);
	else if (key == _T("NUMPAD9")) *pRet = (GetAsyncKeyState(VK_NUMPAD9) < 0);
	else *pRet = (GetAsyncKeyState(key[0]) < 0);
	return S_OK;
}

STDMETHODIMP CCallbacks::CBPlaySound(BSTR soundFile, int *pRet)
{
	extern STRING g_projectPath;
	const STRING file = g_projectPath + MEDIA_PATH + getString(soundFile);
	CAudioSegment::playSoundEffect(file);
	*pRet = TRUE;
	return S_OK;
}

STDMETHODIMP CCallbacks::CBMessageWindow(BSTR text, int textColor, int bgColor, BSTR bgPic, int mbtype, int *pRet)
{
	// TBD
	return S_OK;
}

STDMETHODIMP CCallbacks::CBFileDialog(BSTR initialPath, BSTR fileFilter, BSTR *pRet)
{
	// TBD
	return S_OK;
}

STDMETHODIMP CCallbacks::CBDetermineSpecialMoves(BSTR playerHandle, int *pRet)
{
	const STRING handle = getString(playerHandle);
	// Locate the payer with this handle.
	std::vector<CPlayer *>::const_iterator i = g_players.begin();
	CPlayer *pPlayer = NULL;
	for (; i != g_players.end(); ++i)
	{
		if ((*i)->name() == handle)
		{
			pPlayer = *i;
			break;
		}
	}
	if (pPlayer)
	{
		// Determine the moves.
		g_specials.clear();
		pPlayer->getLearnedMoves(g_specials);
		*pRet = g_specials.size();
	}
	else
	{
		// Couldn't find the player.
		*pRet = 0;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetSpecialMoveListEntry(int idx, BSTR *pRet)
{
	if (g_specials.size() > idx)
	{
		BSTR bstr = getString(g_specials[idx]);
		SysReAllocString(pRet, bstr);
		SysFreeString(bstr);
	}
	else
	{
		SysReAllocString(pRet, L"");
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBRunProgram(BSTR prgFile)
{
	extern STRING g_projectPath;
	CProgram(g_projectPath + PRG_PATH + getString(prgFile)).run();
	return S_OK;
}

void setEntity(LPENTITY p, int idx, int type)
{
	extern LPBOARD g_pBoard;

	p->type = ET_EMPTY;
	if (type == TYPE_PLAYER)
	{
		if (g_players.size() > idx)
		{
			p->type = ET_PLAYER;
			p->p = &g_players[idx];
		}
	}
	else if (type == TYPE_ITEM)
	{
		if ((idx >= 0) && (g_pBoard->items.size() > idx))
		{
			p->type = ET_ITEM;
			p->p = g_pBoard->items[idx];
		}
	}
	else if (type == TYPE_ENEMY)
	{
		std::map<unsigned int, PLUGIN_ENEMY>::iterator i = g_enemies.find(idx);
		if (i != g_enemies.end())
		{
			p->type = ET_ENEMY;
			p->p = &i->second.enemy;
		}
	}
}

STDMETHODIMP CCallbacks::CBSetTarget(int targetIdx, int ttype)
{
	extern ENTITY g_target;
	setEntity(&g_target, targetIdx, ttype);
	return S_OK;
}

STDMETHODIMP CCallbacks::CBSetSource(int sourceIdx, int stype)
{
	extern ENTITY g_source;
	setEntity(&g_source, sourceIdx, stype);
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetPlayerHP(int playerIdx, double *pRet)
{
	if (g_players.size() > playerIdx)
	{
		*pRet = g_players[playerIdx]->health();
	}
	else
	{
		*pRet = 0.0;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetPlayerMaxHP(int playerIdx, double *pRet)
{
	if (g_players.size() > playerIdx)
	{
		*pRet = g_players[playerIdx]->maxHealth();
	}
	else
	{
		*pRet = 0.0;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetPlayerSMP(int playerIdx, double *pRet)
{
	if (g_players.size() > playerIdx)
	{
		*pRet = g_players[playerIdx]->smp();
	}
	else
	{
		*pRet = 0.0;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetPlayerMaxSMP(int playerIdx, double *pRet)
{
	if (g_players.size() > playerIdx)
	{
		*pRet = g_players[playerIdx]->maxSmp();
	}
	else
	{
		*pRet = 0.0;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetPlayerFP(int playerIdx, double *pRet)
{
	if (g_players.size() > playerIdx)
	{
		*pRet = g_players[playerIdx]->fight();
	}
	else
	{
		*pRet = 0.0;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetPlayerDP(int playerIdx, double *pRet)
{
	if (g_players.size() > playerIdx)
	{
		*pRet = g_players[playerIdx]->defence();
	}
	else
	{
		*pRet = 0.0;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetPlayerName(int playerIdx, BSTR *pRet)
{
	if (g_players.size() > playerIdx)
	{
		BSTR bstr = getString(g_players[playerIdx]->name());
		SysReAllocString(pRet, bstr);
		SysFreeString(bstr);
	}
	else
	{
		SysReAllocString(pRet, L"");
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBAddPlayerHP(int amount, int playerIdx)
{
	if (g_players.size() > playerIdx)
	{
		g_players[playerIdx]->health(g_players[playerIdx]->health() + amount);
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBAddPlayerSMP(int amount, int playerIdx)
{
	if (g_players.size() > playerIdx)
	{
		g_players[playerIdx]->smp(g_players[playerIdx]->smp() + amount);
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBSetPlayerHP(int amount, int playerIdx)
{
	if (g_players.size() > playerIdx)
	{
		g_players[playerIdx]->health(amount);
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBSetPlayerSMP(int amount, int playerIdx)
{
	if (g_players.size() > playerIdx)
	{
		g_players[playerIdx]->smp(amount);
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBSetPlayerFP(int amount, int playerIdx)
{
	if (g_players.size() > playerIdx)
	{
		g_players[playerIdx]->fight(amount);
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBSetPlayerDP(int amount, int playerIdx)
{
	if (g_players.size() > playerIdx)
	{
		g_players[playerIdx]->defence(amount);
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetEnemyHP(int eneIdx, int *pRet)
{
	if (!g_enemies.count(eneIdx)) return S_OK;
	*pRet = g_enemies[eneIdx].enemy.iHp;
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetEnemyMaxHP(int eneIdx, int *pRet)
{
	if (!g_enemies.count(eneIdx)) return S_OK;
	*pRet = g_enemies[eneIdx].enemy.iMaxHp;
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetEnemySMP(int eneIdx, int *pRet)
{
	if (!g_enemies.count(eneIdx)) return S_OK;
	*pRet = g_enemies[eneIdx].enemy.iSmp;
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetEnemyMaxSMP(int eneIdx, int *pRet)
{
	if (!g_enemies.count(eneIdx)) return S_OK;
	*pRet = g_enemies[eneIdx].enemy.iMaxSmp;
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetEnemyFP(int eneIdx, int *pRet)
{
	if (!g_enemies.count(eneIdx)) return S_OK;
	*pRet = g_enemies[eneIdx].enemy.fp;
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetEnemyDP(int eneIdx, int *pRet)
{
	if (!g_enemies.count(eneIdx)) return S_OK;
	*pRet = g_enemies[eneIdx].enemy.dp;
	return S_OK;
}

STDMETHODIMP CCallbacks::CBAddEnemyHP(int amount, int eneIdx)
{
	if (!g_enemies.count(eneIdx)) return S_OK;
	g_enemies[eneIdx].enemy.iHp += amount;
	if (g_enemies[eneIdx].enemy.iHp > g_enemies[eneIdx].enemy.iMaxHp)
	{
		g_enemies[eneIdx].enemy.iHp = g_enemies[eneIdx].enemy.iMaxHp;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBAddEnemySMP(int amount, int eneIdx)
{
	if (!g_enemies.count(eneIdx)) return S_OK;
	g_enemies[eneIdx].enemy.iSmp += amount;
	if (g_enemies[eneIdx].enemy.iSmp > g_enemies[eneIdx].enemy.iMaxSmp)
	{
		g_enemies[eneIdx].enemy.iSmp = g_enemies[eneIdx].enemy.iMaxSmp;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBSetEnemyHP(int amount, int eneIdx)
{
	if (!g_enemies.count(eneIdx)) return S_OK;
	if (amount < 0) amount = 0;
	else if (amount > g_enemies[eneIdx].enemy.iMaxHp) amount = g_enemies[eneIdx].enemy.iMaxHp;
	g_enemies[eneIdx].enemy.iHp = amount;
	return S_OK;
}

STDMETHODIMP CCallbacks::CBSetEnemySMP(int amount, int eneIdx)
{
	if (!g_enemies.count(eneIdx)) return S_OK;
	if (amount < 0) amount = 0;
	else if (amount > g_enemies[eneIdx].enemy.iSmp) amount = g_enemies[eneIdx].enemy.iMaxSmp;
	g_enemies[eneIdx].enemy.iSmp = amount;
	return S_OK;
}

STDMETHODIMP CCallbacks::CBCanvasDrawBackground(int canvasID, BSTR bkgFile, int x, int y, int width, int height)
{
	CCanvas *p = g_canvases.cast(canvasID);
	if (p)
	{
		extern STRING g_projectPath;
		BACKGROUND bkg;
		bkg.open(g_projectPath + BKG_PATH + getString(bkgFile));
		drawImage(g_projectPath + BMP_PATH + bkg.image, p, x, y, width, height);
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBCreateAnimation(BSTR file, int *pRet)
{
	CSharedAnimation *p = CSharedAnimation::insert(getString(file));
	*pRet = (int)p;
	return S_OK;
}

STDMETHODIMP CCallbacks::CBDestroyAnimation(int idx)
{
	CSharedAnimation::free((CSharedAnimation *)idx);
	return S_OK;
}

STDMETHODIMP CCallbacks::CBCanvasDrawAnimation(int canvasID, int idx, int x, int y, int forceDraw, int forceTransp)
{
	CSharedAnimation *anm = CSharedAnimation::cast(idx);
	if (anm)
	{
		LPANIMATION p = anm->m_pAnm->data();
		int *const i = &(anm->m_frame);
		CCanvas *pCnv = g_canvases.cast(canvasID);
		if (pCnv)
		{
			// This is a bit dubious!
			if ((!(anm->m_tick++ % int(80 * p->animPause))) || (*i == -1))
			{
				++(*i);
				if (*i > p->animFrames) *i = 0;
				anm->m_pAnm->playFrameSound(*i);
			}
			if (forceTransp)
			{
				pCnv->ClearScreen(TRANSP_COLOR);
			}
			anm->m_pAnm->getFrame(*i)->BltTransparent(pCnv, x, y, TRANSP_COLOR);
		}
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBCanvasDrawAnimationFrame(int canvasID, int idx, int frame, int x, int y, int forceTranspFill)
{
	CSharedAnimation *anm = CSharedAnimation::cast(idx);
	if (anm)
	{
		LPANIMATION p = anm->m_pAnm->data();
		CCanvas *pCnv = g_canvases.cast(canvasID);
		if (frame > p->animFrames) frame = 0;

		// Play sound on transitions.
		if (frame != anm->m_frame) 
		{
			anm->m_frame = frame;
			anm->m_pAnm->playFrameSound(frame);
		}
		if (pCnv)
		{
			if (forceTranspFill)
			{
				pCnv->ClearScreen(TRANSP_COLOR);
			}
			anm->m_pAnm->getFrame(anm->m_frame)->BltTransparent(pCnv, x, y, TRANSP_COLOR);
		}
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBAnimationCurrentFrame(int idx, int *pRet)
{
	CSharedAnimation *p = CSharedAnimation::cast(idx);
	*pRet = (p ? p->m_frame : 0);
	return S_OK;
}

STDMETHODIMP CCallbacks::CBAnimationMaxFrames(int idx, int *pRet)
{
	CSharedAnimation *p = CSharedAnimation::cast(idx);
	*pRet = (p ? p->m_pAnm->data()->animFrames : -1);
	return S_OK;
}

STDMETHODIMP CCallbacks::CBAnimationSizeX(int idx, int *pRet)
{
	CSharedAnimation *p = CSharedAnimation::cast(idx);
	*pRet = (p ? p->m_pAnm->data()->animSizeX : 0);
	return S_OK;
}

STDMETHODIMP CCallbacks::CBAnimationSizeY(int idx, int *pRet)
{
	CSharedAnimation *p = CSharedAnimation::cast(idx);
	*pRet = (p ? p->m_pAnm->data()->animSizeY : 0);
	return S_OK;
}

STDMETHODIMP CCallbacks::CBAnimationFrameImage(int idx, int frame, BSTR *pRet)
{
	CSharedAnimation *p = CSharedAnimation::cast(idx);
	if (p && (p->m_pAnm->data()->animFrames >= frame))
	{
		BSTR bstr = getString(p->m_pAnm->data()->animFrame[frame]);
		SysReAllocString(pRet, bstr);
		SysFreeString(bstr);
	}
	else
	{
		SysReAllocString(pRet, L"");
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetPartySize(int partyIdx, int *pRet)
{
	extern BATTLE g_battle;
	if (partyIdx < g_battle.parties.size())
	{
		*pRet = g_battle.parties[partyIdx].size();
	}
	else
	{
		*pRet = 0;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetFighterHP(int partyIdx, int fighterIdx, int *pRet)
{
	LPFIGHTER p = getFighter(partyIdx, fighterIdx);
	if (p)
	{
		*pRet = p->pFighter->health();
	}
	else
	{
		*pRet = 0;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetFighterMaxHP(int partyIdx, int fighterIdx, int *pRet)
{
	LPFIGHTER p = getFighter(partyIdx, fighterIdx);
	if (p)
	{
		*pRet = p->pFighter->maxHealth();
	}
	else
	{
		*pRet = 0;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetFighterSMP(int partyIdx, int fighterIdx, int *pRet)
{
	LPFIGHTER p = getFighter(partyIdx, fighterIdx);
	if (p)
	{
		*pRet = p->pFighter->smp();
	}
	else
	{
		*pRet = 0;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetFighterMaxSMP(int partyIdx, int fighterIdx, int *pRet)
{
	LPFIGHTER p = getFighter(partyIdx, fighterIdx);
	if (p)
	{
		*pRet = p->pFighter->maxSmp();
	}
	else
	{
		*pRet = 0;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetFighterFP(int partyIdx, int fighterIdx, int *pRet)
{
	LPFIGHTER p = getFighter(partyIdx, fighterIdx);
	if (p)
	{
		*pRet = p->pFighter->fight();
	}
	else
	{
		*pRet = 0;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetFighterDP(int partyIdx, int fighterIdx, int *pRet)
{
	LPFIGHTER p = getFighter(partyIdx, fighterIdx);
	if (p)
	{
		*pRet = p->pFighter->defence();
	}
	else
	{
		*pRet = 0;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetFighterName(int partyIdx, int fighterIdx, BSTR *pRet)
{
	LPFIGHTER p = getFighter(partyIdx, fighterIdx);
	if (p)
	{
		BSTR bstr = getString(p->pFighter->name());
		SysReAllocString(pRet, bstr);
		SysFreeString(bstr);
	}
	else
	{
		SysReAllocString(pRet, L"");
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetFighterAnimation(int partyIdx, int fighterIdx, BSTR animationName, BSTR *pRet)
{
	LPFIGHTER p = getFighter(partyIdx, fighterIdx);
	if (p)
	{
		BSTR bstr = getString(p->pFighter->getStanceAnimation(getString(animationName)));
		SysReAllocString(pRet, bstr);
		SysFreeString(bstr);
	}
	else
	{
		SysReAllocString(pRet, L"");
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBGetFighterChargePercent(int partyIdx, int fighterIdx, int *pRet)
{
	LPFIGHTER p = getFighter(partyIdx, fighterIdx);
	if (p)
	{
		*pRet = int(p->charge / double(p->chargeMax) * 100.0);
		if (*pRet > 100) *pRet = 100;
	}
	else
	{
		*pRet = 0;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBFightTick()
{
	fightTick();
	return S_OK;
}

STDMETHODIMP CCallbacks::CBDrawTextAbsolute(BSTR text, BSTR font, int size, int x, int y, int crColor, int isBold, int isItalics, int isUnderline, int isCentred, int isOutlined, int *pRet)
{
	*pRet = g_pDirectDraw->DrawText(x, y, getString(text), getString(font), size, crColor, isBold, isItalics, isUnderline, isCentred, isOutlined);
	return S_OK;
}

STDMETHODIMP CCallbacks::CBReleaseFighterCharge(int partyIdx, int fighterIdx)
{
	LPFIGHTER p = getFighter(partyIdx, fighterIdx);
	if (p)
	{
		p->charge = 0;
		p->bFrozenCharge = false;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBFightDoAttack(int sourcePartyIdx, int sourceFightIdx, int targetPartyIdx, int targetFightIdx, int amount, int toSmp, int *pRet)
{
#pragma warning (disable : 4800) // forcing value to bool 'true' or 'false' (performance warning)
	*pRet = performAttack(sourcePartyIdx, sourceFightIdx, targetPartyIdx, targetFightIdx, amount, toSmp);
#pragma warning (default : 4800) // forcing value to bool 'true' or 'false' (performance warning)
	return S_OK;
}

STDMETHODIMP CCallbacks::CBFightUseItem(int sourcePartyIdx, int sourceFightIdx, int targetPartyIdx, int targetFightIdx, BSTR itemFile)
{
	extern STRING g_projectPath;
	extern ENTITY g_target, g_source;
	extern CInventory g_inv;
	extern IPlugin *g_pFightPlugin;

	LPFIGHTER pSource = getFighter(sourcePartyIdx, sourceFightIdx);
	LPFIGHTER pTarget = getFighter(targetPartyIdx, targetFightIdx);
	if (!pSource || !pTarget || (pSource->pFighter->health() < 1))
	{
		// Target or source doesn't exist or source is dead.
		return S_OK;
	}

	ITEM itm;
	const STRING strItemFile = getString(itemFile);
	const STRING fullPath = g_projectPath + ITM_PATH + strItemFile;
	if (!itm.open(fullPath, NULL)) return S_OK;

	// HP.
	pTarget->pFighter->health(pTarget->pFighter->health() + itm.fgtHPup);
	const int hp = pTarget->pFighter->health();
	const int maxHp = pTarget->pFighter->maxHealth();
	if (hp > maxHp)
	{
		pTarget->pFighter->health(maxHp);
	}
	else if (hp < 0)
	{
		pTarget->pFighter->health(0);
	}

	// SMP.
	pTarget->pFighter->smp(pTarget->pFighter->smp() + itm.fgtSMup);
	const int mana = pTarget->pFighter->smp();
	const int maxMana = pTarget->pFighter->maxSmp();
	if (mana > maxMana)
	{
		pTarget->pFighter->smp(maxMana);
	}
	else if (mana < 0)
	{
		pTarget->pFighter->smp(0);
	}

	// Set target and source.
	g_target.p = pTarget->pFighter;
	g_source.p = pSource->pFighter;
	g_target.type = pTarget->bPlayer ? ET_PLAYER : ET_ENEMY;
	g_source.type = pSource->bPlayer ? ET_PLAYER : ET_ENEMY;

	g_inv.take(fullPath);

	g_pFightPlugin->fightInform(sourcePartyIdx, sourceFightIdx, targetPartyIdx, targetFightIdx, 0, 0, -itm.fgtHPup, -itm.fgtSMup, strItemFile, INFORM_SOURCE_ITEM);
	return S_OK;
}

STDMETHODIMP CCallbacks::CBFightUseSpecialMove(int sourcePartyIdx, int sourceFightIdx, int targetPartyIdx, int targetFightIdx, BSTR moveFile)
{
	performSpecialMove(sourcePartyIdx, sourceFightIdx, targetPartyIdx, targetFightIdx, getString(moveFile));
	return S_OK;
}

STDMETHODIMP CCallbacks::CBDoEvents()
{
	processEvent();
	return S_OK;
}

STDMETHODIMP CCallbacks::CBFighterAddStatusEffect(int partyIdx, int fightIdx, BSTR statusFile)
{
	LPFIGHTER p = getFighter(partyIdx, fightIdx);
	if (p)
	{
		const STRING file = getString(statusFile);
		applyStatusEffect(file, p);
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBFighterRemoveStatusEffect(int partyIdx, int fightIdx, BSTR statusFile)
{
	LPFIGHTER p = getFighter(partyIdx, fightIdx);
	if (p)
	{
		const STRING file = parser::uppercase(getString(statusFile));
		LPSTATUS_EFFECT pEffect = &p->statuses[file];
		removeStatusEffect(pEffect, p);
		p->statuses.erase(p->statuses.find(file));
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBCheckMusic()
{
	// Obsolete. Do nothing.
	return S_OK;
}

STDMETHODIMP CCallbacks::CBReleaseScreenDC()
{
	extern HWND g_hHostWnd;
	ReleaseDC(g_hHostWnd, g_hScreenDc);
	g_hScreenDc = NULL;
	return S_OK;
}

STDMETHODIMP CCallbacks::CBCanvasOpenHdc(int cnv, int *pRet)
{
	CCanvas *p = g_canvases.cast(cnv);
	if (p)
	{
		*pRet = (int)p->OpenDC();
	}
	else
	{
		*pRet = FALSE;
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBCanvasCloseHdc(int cnv, int hdc)
{
	CCanvas *p = g_canvases.cast(cnv);
	if (p)
	{
		p->CloseDC((HDC)hdc);
	}
	return S_OK;
}

STDMETHODIMP CCallbacks::CBFileExists(BSTR strFile, VARIANT_BOOL *pRet)
{
	extern STRING g_projectPath;
	*pRet = (CFile::fileExists(g_projectPath + getString(strFile)) ? VARIANT_TRUE : VARIANT_FALSE);
	return S_OK;
}

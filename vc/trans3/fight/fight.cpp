/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

#include "fight.h"
#include "../common/background.h"
#include "../common/paths.h"
#include "../common/mainfile.h"
#include "../common/board.h"
#include "../common/mbox.h"
#include "../common/CAllocationHeap.h"
#include "../plugins/plugins.h"
#include "../audio/CAudioSegment.h"
#include "../render/render.h"
#include "../rpgcode/CProgram.h"
#include <vector>

IPlugin *g_pFightPlugin = NULL;		// The fight plugin.
BATTLE g_battle;					// The current battle.

/*
 * Can we run away from this fight?
 */
bool canRunFromFight()
{
	return g_battle.bRun;
}

/*
 * Get a fighter.
 */
LPFIGHTER getFighter(const unsigned int party, const unsigned int idx)
{
	if ((party < g_battle.parties.size()) && (idx < g_battle.parties[party].size()))
	{
		return &g_battle.parties[party][idx];
	}
	return NULL;
}

/*
 * Cause one fighter to attack another.
 */
int performAttack(const int sourcePartyIdx, const int sourceFightIdx, const int targetPartyIdx, const int targetFightIdx, const int damage, const bool toSmp)
{
	LPFIGHTER pSource = getFighter(sourcePartyIdx, sourceFightIdx);
	LPFIGHTER pTarget = getFighter(targetPartyIdx, targetFightIdx);
	if (!pSource || !pTarget || (pSource->pFighter->health() < 1))
	{
		return 0;
	}
	int amount = damage;
	if (amount > 0)
	{
		amount += ((rand() % 20) - 10) / 100.0 * amount;
		if (rand() % (((sourcePartyIdx == PLAYER_PARTY) ? ((targetPartyIdx == ENEMY_PARTY) ? pTarget->pEnemy->takeCrit : 0) : ((targetPartyIdx == ENEMY_PARTY) ? pSource->pEnemy->giveCrit : pTarget->pEnemy->takeCrit)) + 1))
		{
			amount -= pTarget->pFighter->defence();
		}
	}
	if (amount < 1) amount = 1;
	if (toSmp)
	{
		pTarget->pFighter->smp(pTarget->pFighter->smp() - amount);
		if (pTarget->pFighter->smp() < 0) pTarget->pFighter->smp(0);
		g_pFightPlugin->fightInform(sourcePartyIdx, sourceFightIdx, targetPartyIdx, targetFightIdx, 0, 0, 0, amount, _T(""), INFORM_SOURCE_ATTACK);
	}
	else
	{
		pTarget->pFighter->health(pTarget->pFighter->health() - amount);
		if (pTarget->pFighter->health() < 0) pTarget->pFighter->health(0);
		g_pFightPlugin->fightInform(sourcePartyIdx, sourceFightIdx, targetPartyIdx, targetFightIdx, 0, 0, amount, 0, _T(""), INFORM_SOURCE_ATTACK);
	}
	return amount;
}

/*
 * Advance the state of a fight.
 */
void fightTick(void)
{
	std::vector<VECTOR_FIGHTER> *pParties = &g_battle.parties;

	std::vector<VECTOR_FIGHTER>::iterator i = pParties->begin();
	for (; i != pParties->end(); ++i)
	{
		VECTOR_FIGHTER::iterator j = i->begin();
		for (; j != i->end(); ++j)
		{
			if (j->charge <= j->chargeMax)
			{
				// Not charged.
				if (!j->bFrozenCharge && (j->pFighter->health() > 0))
				{
					j->charge++;
				}
			}
			else
			{
				// Charged.
				if (j->pFighter->health() <= 0) continue;

				const unsigned int party = i - pParties->begin(), idx = j - i->begin();

				// Status effects.
				std::map<STRING, STATUS_EFFECT>::iterator k = j->statuses.begin();
				for (; k != j->statuses.end(); ++k)
				{
					LPSTATUS_EFFECT pEffect = &k->second;
					if (pEffect->hp)
					{
						j->pFighter->health(j->pFighter->health() - pEffect->hpAmount);
						if (j->pFighter->health() < 0) j->pFighter->health(0);
						g_pFightPlugin->fightInform(-1, -1, party, idx, 0, 0, pEffect->hpAmount, 0, k->first, INFORM_REMOVE_HP);
					}

					if (pEffect->smp)
					{
						j->pFighter->smp(j->pFighter->smp() - pEffect->smpAmount);
						if (j->pFighter->smp() < 0) j->pFighter->smp(0);
						g_pFightPlugin->fightInform(-1, -1, party, idx, 0, 0, 0, pEffect->smpAmount, k->first, INFORM_REMOVE_SMP);
					}

					if (pEffect->code)
					{
						extern void *g_pTarget, *g_pSource;
						extern TARGET_TYPE g_targetType, g_sourceType;
						g_targetType = g_sourceType = j->bPlayer ? TT_PLAYER : TT_ENEMY;
						g_pTarget = g_pSource = j->pFighter;
						extern STRING g_projectPath;
						CProgram(g_projectPath + PRG_PATH + pEffect->prg).run();
					}

					if (--pEffect->rounds == 0)
					{
						if (k->second.speed) j->chargeMax += 20;
						if (k->second.slow) j->chargeMax -= 20;
						if (k->second.disable && !--j->freezes) j->bFrozenCharge = false;
						// Position the iterator one behind the next item, so that
						// the ++k in the for loop makes the next iteration be
						// over the first item after the one that was removed.
						(k = j->statuses.erase(k))--;
					}
				}

				if (j->bPlayer)
				{
					if (!j->bFrozenCharge)
					{
						j->bFrozenCharge = true; // This *must* be done before the informing.
						g_pFightPlugin->fightInform(party, idx, -1, -1, 0, 0, 0, 0, _T(""), INFORM_SOURCE_CHARGED);
					}
				}
				else
				{
					g_pFightPlugin->fightInform(party, idx, -1, -1, 0, 0, 0, 0, _T(""), INFORM_SOURCE_CHARGED);
					// TBD: Enemy attack here.
					j->charge = 0;
				}
			} // if (j->charge < j->chargeMax)
		} // for (j)
	} // for (i)

	// TBD: Check for dead parties.
	// Amazingly stupid thing to do here, but CBM did it here,
	// and even one small change *will* be found by all the
	// idiots who notice irrelevant things.
}

/*
 * Get an enemy of a particular skill level.
 */
STRING getEnemy(const int level)
{
	// Blame the crappiness of this function on
	// the mess that is the main file format.

	extern MAIN_FILE g_mainFile;

	unsigned int count = 0;
	std::vector<short>::iterator i = g_mainFile.skills.begin();
	for (; i != g_mainFile.skills.end(); ++i)
	{
		if (*i == level) count++;
	}
	if (count == 0)
	{
		return _T("");
	}
	const unsigned int ene = rand() % count + 1;
	count = 0;
	i = g_mainFile.skills.begin();
	for (; i != g_mainFile.skills.end(); ++i)
	{
		if ((*i == level) && (++count == ene))
		{
			return g_mainFile.enemy[i - g_mainFile.skills.begin()];
		}
	}
	return _T("");
}

/*
 * Start a fight based on skill level.
 */
void skillFight(const int skill, const STRING bkg)
{
	const int num = rand() % 4 + 1;
	std::vector<STRING> enemies;
	for (unsigned int i = 0; i < num; ++i)
	{
		const STRING enemy = getEnemy(skill);
		if (enemy.empty())
		{
			TCHAR num[255];
			_itot(skill, num, 10);
			messageBox(STRING(_T("No enemies of skill level ")) + num + _T(" found."));
			return;
		}
		enemies.push_back(enemy);
	}
	runFight(enemies, bkg);
}

/*
 * Test whether we need to begin a fight.
 */
void fightTest(const int moveSize)
{
	extern unsigned long g_stepsTaken;
	extern MAIN_FILE g_mainFile;
	extern LPBOARD g_pBoard;

	// That no ! is applied to fightGameYn is not an error.
	// For reasons unknown, this boolean is actually false when
	// it's true and vice versa.
	if (g_mainFile.fightGameYn || !g_pBoard->fightingYN) return;

	// The goal here is to test for a fight only after walking
	// a whole tile. The introduction of _T('true') pixel movement,
	// however, allows a user to set the movement size to a
	// distance that is not a factor of 32, making it impossible
	// for us to be in this function when the player has walked
	// a whole tile. Thus we consider a whole tile to be the
	// first number starting at 32 that has the movement size
	// as a factor. (This does not work for movement sizes
	// greater than 32. Shall such sizes be allowed?)
	//
	// Should rational movement sizes be allowed, this can
	// be adapted by changing (a % b) to the slower expression
	// ((a / b - int(a / b)) * b).
	// moveSize is the number of pixels per move for the player.
	if (g_stepsTaken % ((64 + (32 % moveSize)) / 2)) return;

	//if (!(((g_mainFile.fightType == 0) ? rand() : (g_stepsTaken / 32)) % g_mainFile.chances))
	{
		// Start a fight.
		if (g_mainFile.fprgYn)
		{
			extern STRING g_projectPath;
			CProgram(g_projectPath + PRG_PATH + g_mainFile.fightPrg).run();
		}
		else
		{
			skillFight(g_pBoard->boardSkill, g_pBoard->boardBackground);
		}
	}
}

/*
 * Hand out rewards.
 */
void rewardPlayers(const int gp, const int exp, const STRING prg)
{
	extern STRING g_projectPath;
	extern unsigned long g_gp;
	g_gp += gp;

	if (exp > 0)
	{
		TCHAR str[255];
		_itot(exp, str, 10);
		messageBox(STRING(_T("Gained ")) + str + " experience points.");
	}

	// Give the experience.
	extern std::vector<CPlayer *> g_players;
	std::vector<CPlayer *>::const_iterator i = g_players.begin();
	for (; i != g_players.end(); ++i)
	{
		if (!*i) continue;
		(*i)->giveExperience(exp);
	}

	if (gp > 0)
	{
		TCHAR str[255];
		_itot(gp, str, 10);
		messageBox(STRING(_T("Gained ")) + str + " GP.");
	}

	// Run RPGCode program.
	if (!prg.empty())
	{
		CProgram(g_projectPath + PRG_PATH + prg).run();
	}
}

/*
 * Run a fight.
 */
void runFight(const std::vector<STRING> enemies, const STRING background)
{
	if (!g_pFightPlugin) return;
	extern STRING g_projectPath;

	g_battle = BATTLE(); // Redundant, but takes so little time that it's worth being paranoid.

	std::vector<VECTOR_FIGHTER> *pParties = &g_battle.parties;

	pParties->push_back(VECTOR_FIGHTER());
	VECTOR_FIGHTER &rEnemies = pParties->back();

	STRING runPrg, rewardPrg;
	int gp = 0, exp = 0;
	g_battle.bRun = true;

	extern std::map<unsigned int, PLUGIN_ENEMY> g_enemies;

	std::vector<STRING>::const_iterator i = enemies.begin();
	for (unsigned int pos = 0; i != enemies.end(); ++i, ++pos)
	{
		FIGHTER fighter;
		fighter.bPlayer = false;
		g_enemies[pos].fileName = *i;
		fighter.pFighter = fighter.pEnemy = &g_enemies[pos].enemy;
		fighter.pEnemy->open(g_projectPath + ENE_PATH + *i);
		if (!fighter.pEnemy->runPrg.empty())
		{
			runPrg = fighter.pEnemy->runPrg;
		}
		if (fighter.pEnemy->run == 0)
		{
			g_battle.bRun = false;
		}
		if (!fighter.pEnemy->winPrg.empty())
		{
			rewardPrg = fighter.pEnemy->winPrg;
		}
		gp += fighter.pEnemy->gp;
		exp += fighter.pEnemy->exp;
		fighter.chargeMax = 41; // (Not fair to enemies!)
		fighter.charge = rand() % fighter.chargeMax;
		fighter.bFrozenCharge = false;
		fighter.freezes = 0;
		rEnemies.push_back(fighter);
	}

	pParties->push_back(VECTOR_FIGHTER());
	VECTOR_FIGHTER &rPlayers = pParties->back();

	extern std::vector<CPlayer *> g_players;
	std::vector<CPlayer *>::const_iterator j = g_players.begin();
	for (; j != g_players.end(); ++j)
	{
		if (!*j) continue;
		FIGHTER fighter;
		fighter.bPlayer = true;
		fighter.pFighter = fighter.pPlayer = *j;
		fighter.chargeMax = 25;
		fighter.charge = rand() % fighter.chargeMax;
		fighter.bFrozenCharge = false;
		fighter.freezes = 0;
		rPlayers.push_back(fighter);
	}

	BACKGROUND bkg;
	bkg.open(g_projectPath + BKG_PATH + background);

	extern CAllocationHeap<CAudioSegment> g_music;
	extern CAudioSegment *g_bkgMusic;
	CAudioSegment *pOldMusic = g_bkgMusic;
	pOldMusic->stop(); // A pause would be better.

	g_bkgMusic = g_music.allocate();
	g_bkgMusic->open(bkg.bkgMusic);
	g_bkgMusic->play(true);

	const int outcome = g_pFightPlugin->fight(enemies.size(), -1, background, g_battle.bRun);
	if (outcome == FIGHT_RUN_AUTO)
	{
		CProgram(g_projectPath + PRG_PATH + runPrg).run();
	}
	else if (outcome == FIGHT_WON_AUTO)
	{
		// Hand out rewards.
		rewardPlayers(gp, exp, rewardPrg);
	}
	else if (outcome == FIGHT_LOST)
	{
		// Do game over stuff.
	}

	g_bkgMusic->stop();
	g_music.free(g_bkgMusic);
	(g_bkgMusic = pOldMusic)->play(true);

	renderNow(NULL, true);

	g_battle = BATTLE();
}

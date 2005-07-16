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
#include "../common/CAllocationHeap.h"
#include "../plugins/plugins.h"
#include "../audio/CAudioSegment.h"
#include "../render/render.h"
#include "../rpgcode/CProgram/CProgram.h"
#include <vector>

IPlugin *g_pFightPlugin = NULL;			// The fight plugin.
std::vector<VECTOR_FIGHTER> g_parties;	// Parties.

/*
 * Get a fighter.
 */
LPFIGHTER getFighter(const unsigned int party, const unsigned int idx)
{
	if ((party < g_parties.size()) && (idx < g_parties[party].size()))
	{
		return &g_parties[party][idx];
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
		g_pFightPlugin->fightInform(sourcePartyIdx, sourceFightIdx, targetPartyIdx, targetFightIdx, 0, 0, 0, amount, "", INFORM_SOURCE_ATTACK);
	}
	else
	{
		pTarget->pFighter->health(pTarget->pFighter->health() - amount);
		if (pTarget->pFighter->health() < 0) pTarget->pFighter->health(0);
		g_pFightPlugin->fightInform(sourcePartyIdx, sourceFightIdx, targetPartyIdx, targetFightIdx, 0, 0, amount, 0, "", INFORM_SOURCE_ATTACK);
	}
	return amount;
}

/*
 * Advance the state of a fight.
 */
void fightTick(void)
{
	std::vector<VECTOR_FIGHTER>::iterator i = g_parties.begin();
	for (; i != g_parties.end(); ++i)
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

				const unsigned int party = i - g_parties.begin(), idx = j - i->begin();

				// Status effects.
				std::map<std::string, STATUS_EFFECT>::iterator k = j->statuses.begin();
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
						extern std::string g_projectPath;
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
						g_pFightPlugin->fightInform(party, idx, -1, -1, 0, 0, 0, 0, "", INFORM_SOURCE_CHARGED);
					}
				}
				else
				{
					g_pFightPlugin->fightInform(party, idx, -1, -1, 0, 0, 0, 0, "", INFORM_SOURCE_CHARGED);
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
std::string getEnemy(const int level)
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
		return "";
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
	return "";
}

/*
 * Start a fight based on skill level.
 */
void skillFight(const int skill, const std::string bkg)
{
	const int num = rand() % 4 + 1;
	std::vector<std::string> enemies;
	for (unsigned int i = 0; i < num; ++i)
	{
		const std::string enemy = getEnemy(skill);
		if (enemy.empty())
		{
			char num[255];
			itoa(skill, num, 10);
			MessageBox(NULL, (std::string("No enemies of skill level ") + num + " found.").c_str(), NULL, 0);
			return;
		}
		enemies.push_back(enemy);
	}
	runFight(enemies, bkg);
}

/*
 * Test whether we need to begin a fight.
 */
void fightTest(void)
{
	extern unsigned long g_stepsTaken;
	extern double g_movementSize;
	extern MAIN_FILE g_mainFile;
	extern LPBOARD g_pBoard;

	// That no ! is applied to fightGameYn is not an error.
	// For reasons unknown, this boolean is actually false when
	// it's true and vice versa.
	if (g_mainFile.fightGameYn || !g_pBoard->fightingYN) return;

	// The goal here is to test for a fight only after walking
	// a whole tile. The introduction of 'true' pixel movement,
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
	if (g_stepsTaken % ((64 + (32 % int(g_movementSize))) / 2)) return;

	if (!(((g_mainFile.fightType == 0) ? rand() : (g_stepsTaken / 32)) % g_mainFile.chances))
	{
		// Start a fight.
		if (g_mainFile.fprgYn)
		{
			extern std::string g_projectPath;
			CProgram(g_projectPath + PRG_PATH + g_mainFile.fightPrg).run();
		}
		else
		{
			skillFight(g_pBoard->boardSkill, g_pBoard->boardBackground);
		}
	}
}

/*
 * Run a fight.
 */
void runFight(const std::vector<std::string> enemies, const std::string background)
{
	if (!g_pFightPlugin) return;
	extern std::string g_projectPath;

	g_parties.clear(); // Redundant, but takes so little time that it's worth being paranoid.
	g_parties.push_back(VECTOR_FIGHTER());
	VECTOR_FIGHTER &rEnemies = g_parties.back();

	std::string runPrg, rewardPrg;
	bool bCanRun = true;

	extern std::map<unsigned int, PLUGIN_ENEMY> g_enemies;

	std::vector<std::string>::const_iterator i = enemies.begin();
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
			bCanRun = false;
		}
		if (!fighter.pEnemy->winPrg.empty())
		{
			rewardPrg = fighter.pEnemy->winPrg;
		}
		fighter.chargeMax = 130; // (Not fair to enemies!)
		fighter.charge = rand() % fighter.chargeMax;
		fighter.bFrozenCharge = false;
		fighter.freezes = 0;
		rEnemies.push_back(fighter);
	}

	g_parties.push_back(VECTOR_FIGHTER());
	VECTOR_FIGHTER &rPlayers = g_parties.back();

	extern std::vector<CPlayer *> g_players;
	std::vector<CPlayer *>::const_iterator j = g_players.begin();
	for (; j != g_players.end(); ++j)
	{
		if (!*j) continue;
		FIGHTER fighter;
		fighter.bPlayer = true;
		fighter.pFighter = fighter.pPlayer = *j;
		fighter.chargeMax = 80;
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

	const int outcome = g_pFightPlugin->fight(enemies.size(), -1, background, bCanRun);
	if (outcome == FIGHT_RUN_AUTO)
	{
		CProgram(g_projectPath + PRG_PATH + runPrg).run();
	}
	else if (outcome == FIGHT_WON_AUTO)
	{
		// Hand out rewards.
	}
	else if (outcome == FIGHT_LOST)
	{
		// Do game over stuff.
	}

	g_bkgMusic->stop();
	g_music.free(g_bkgMusic);
	(g_bkgMusic = pOldMusic)->play(true);

	renderNow(NULL, true);

	g_parties.clear();

}

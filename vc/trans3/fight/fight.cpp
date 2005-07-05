/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

#include "fight.h"
#include "../common/background.h"
#include "../plugins/plugins.h"
#include "../audio/CAudioSegment.h"
#include "../render/render.h"
#include "../rpgcode/CProgram/CProgram.h"
#include <vector>

// The fight plugin.
IPlugin *g_pFightPlugin = NULL;

// Parties.
std::vector<VECTOR_FIGHTER> g_parties;

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
		rPlayers.push_back(fighter);
	}

	BACKGROUND bkg;
	bkg.open(g_projectPath + BKG_PATH + background);

	extern CAudioSegment *g_bkgMusic;
	CAudioSegment *pOldMusic = g_bkgMusic;
	pOldMusic->stop(); // A pause would be better.

	g_bkgMusic = new CAudioSegment(bkg.bkgMusic);
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

	delete g_bkgMusic;
	(g_bkgMusic = pOldMusic)->play(true);

	renderNow(NULL, true);

	g_parties.clear();

}

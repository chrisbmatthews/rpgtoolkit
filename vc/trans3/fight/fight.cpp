/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

#include "fight.h"
#include "../common/background.h"
#include "../common/paths.h"
#include "../common/mainfile.h"
#include "../common/spcmove.h"
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
bool g_fighting = false;			// Are we currently fighting?

// ::first = move file
// ::second = curative?
typedef std::pair<STRING, bool> SPCMOVE_PAIR;

// ::first = status file
// ::second = the effect
typedef std::pair<STRING const, STATUS_EFFECT> STATUS_PAIR, *LPSTATUS_PAIR;

// A target class.
typedef enum tagTargetClass
{
	TC_RANDOM,
	TC_WEAKEST
} TARGET_CLASS;

/*
 * Can we run away from this fight?
 */
bool canRunFromFight()
{
	return g_battle.bRun;
}

/*
 * Are we currently fighting?
 */
bool isFighting()
{
	return g_fighting;
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
 * Get a fighter's indices.
 */
void getFighterIndices(const IFighter *pFighter, int &party, int &idx)
{
	std::vector<VECTOR_FIGHTER>::iterator i = g_battle.parties.begin();
	for (; i != g_battle.parties.end(); ++i)
	{
		VECTOR_FIGHTER::iterator j = i->begin();
		for (; j != i->end(); ++j)
		{
			if (j->pFighter == pFighter)
			{
				// Found the fighter.
				party = i - g_battle.parties.begin();
				idx = j - i->begin();
				return;
			}
		}
	}

	// Could not find the fighter.
	party = idx = -1;
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
 * Perform a special move.
 */
void performSpecialMove(const int sourcePartyIdx, const int sourceFightIdx, const int targetPartyIdx, const int targetFightIdx, const STRING moveFile)
{
	extern STRING g_projectPath;
	extern ENTITY g_target, g_source;

	LPFIGHTER pSource = getFighter(sourcePartyIdx, sourceFightIdx);
	LPFIGHTER pTarget = getFighter(targetPartyIdx, targetFightIdx);
	if (!pSource || !pTarget || (pSource->pFighter->health() < 1)) return;

	SPCMOVE spc;
	spc.open(g_projectPath + SPC_PATH + moveFile);

	const int hp = spc.fp;
	const int smp = spc.targSmp;
	const int sourceSmp = spc.smp;

	IFighter *pTargetFighter = pTarget->pFighter;

	// Set health.
	{
		int health = pTargetFighter->health() - hp;
		if (health < 0) health = 0;
		pTargetFighter->health(health);
	}

	// Set SMP.
	{
		int mana = pTargetFighter->smp() - smp;
		if (mana < 0) mana = 0;
		pTargetFighter->smp(mana);
	}

	// Remove SMP from source.
	{
		int mana = pSource->pFighter->smp() - sourceSmp;
		if (mana < 0) mana = 0;
		pSource->pFighter->smp(mana);
	}

	// Set target and source.
	g_target.p = pTarget->pFighter;
	g_source.p = pSource->pFighter;
	g_target.type = pTarget->bPlayer ? ET_PLAYER : ET_ENEMY;
	g_source.type = pSource->bPlayer ? ET_PLAYER : ET_ENEMY;

	// Inform the plugin.
	g_pFightPlugin->fightInform(
		sourcePartyIdx, sourceFightIdx,
		targetPartyIdx, targetFightIdx,
		0, sourceSmp,
		hp, smp,
		moveFile, INFORM_SOURCE_SMP
	);
}

/*
 * Get a list of moves that an enemy can use.
 */
void getUsableEnemyMoves(LPENEMY pEnemy, std::vector<SPCMOVE_PAIR> &moves)
{
	extern STRING g_projectPath;

	const int mana = pEnemy->smp();

	std::vector<STRING>::const_iterator i = pEnemy->specials.begin();
	for (; i != pEnemy->specials.end(); ++i)
	{
		if (i->length())
		{
			SPCMOVE spc;
			spc.open(g_projectPath + SPC_PATH + *i);
			if (spc.smp <= mana)
			{
				// The enemy can use this move.
				const bool curative = (spc.fp < 0);
				moves.push_back(SPCMOVE_PAIR(*i, curative));
			}
		}
	}
}

/*
 * Get the index of a random living party member.
 */
int randomPartyMember(const int idx)
{
	VECTOR_FIGHTER &party = g_battle.parties[idx];
	VECTOR_FIGHTER::iterator i = party.begin();
	std::vector<int> choices;
	for (; i != party.end(); ++i)
	{
		if (i->pFighter->health() > 0)
		{
			choices.push_back(i - party.begin());
		}
	}
	return choices[rand() % choices.size()];
}

/*
 * Get the index of the party member with the lowest health.
 */
int weakestPartyMember(const int idx)
{
	VECTOR_FIGHTER &party = g_battle.parties[idx];
	VECTOR_FIGHTER::iterator i = party.begin();
	int lowest = -1, target = 0;
	for (; i != party.end(); ++i)
	{
		const int health = i->pFighter->health();
		if (health <= 0) continue;
		if ((lowest == -1) || (health < lowest))
		{
			lowest = health;
			target = i - party.begin();
		}
	}
	return target;
}

/*
 * Get a target of the specified class.
 */
int getTarget(const int party, const TARGET_CLASS target)
{
	switch (target)
	{
		case TC_RANDOM:
			return randomPartyMember(party);
		case TC_WEAKEST:
			return weakestPartyMember(party);
	}
	return 0;
}

/*
 * Cause an enemy to use a special move.
 */
void performEnemySpecialMove(const int idx, SPCMOVE_PAIR move, const TARGET_CLASS target)
{
	if (!move.second)
	{
		const int player = getTarget(PLAYER_PARTY, target);
		performSpecialMove(ENEMY_PARTY, idx, PLAYER_PARTY, player, move.first);
	}
	else
	{
		// This is a curative move.
		const int enemy = getTarget(ENEMY_PARTY, target);
		performSpecialMove(ENEMY_PARTY, idx, ENEMY_PARTY, enemy, move.first);
	}
}

/*
 * Cause an enemy to attack a target with a random special.
 */
void performRandomEnemySpecial(const int idx, const TARGET_CLASS target)
{
	LPENEMY pEnemy = getFighter(ENEMY_PARTY, idx)->pEnemy;

	// Attempt to perform special move.
	std::vector<SPCMOVE_PAIR> moves;
	getUsableEnemyMoves(pEnemy, moves);
	if (moves.size())
	{
		// Use a special move.
		const SPCMOVE_PAIR move = moves[rand() % moves.size()];
		performEnemySpecialMove(idx, move, target);
	}
	else
	{
		// Fall back to physical attack.
		const int player = getTarget(PLAYER_PARTY, target);
		performAttack(ENEMY_PARTY, idx, PLAYER_PARTY, player, pEnemy->fp, false);
	}
}

/*
 * Cause an enemy to attack a target with a random move.
 */
void performRandomEnemyMove(const int idx, const TARGET_CLASS target)
{
	if (!(rand() % 2))
	{
		// Use physical attack.
		LPENEMY pEnemy = getFighter(ENEMY_PARTY, idx)->pEnemy;
		const int player = getTarget(PLAYER_PARTY, target);
		performAttack(ENEMY_PARTY, idx, PLAYER_PARTY, player, pEnemy->fp, false);
	}
	else
	{
		// Attempt to perform special move.
		performRandomEnemySpecial(idx, target);
	}
}

/*
 * Utilise the internal AI.
 */
void performFightAi(const int ai, const int idx)
{
	switch (ai)
	{
		case 0:
			// Low - Enemy attacks random players with a random
			// combination of standard (physical) attacks and special
			// moves (if it can make these).
			performRandomEnemyMove(idx, TC_RANDOM);
			break;
		case 1:
			// Medium - Enemy attacks random players, but uses special
			// moves (if it has any) until its SMP is exhausted, at which
			// point it reverts to normal attacks.
			performRandomEnemySpecial(idx, TC_RANDOM);
			break;
		case 2:
			// High - Enemy attacks the weakest player with a random
			// combination of standard attacks and special moves.
			performRandomEnemyMove(idx, TC_WEAKEST);
			break;
		case 3:
			// Very High - Enemy attacks the weakest player with special
			// moves until SMP is exhausted.
			performRandomEnemySpecial(idx, TC_WEAKEST);
			break;
	}
}

/*
 * Cause an enemy to attack.
 */
void enemyAttack(const int idx)
{
	extern STRING g_projectPath;
	extern ENTITY g_target, g_source;

	LPENEMY pEnemy = getFighter(ENEMY_PARTY, idx)->pEnemy;

	// Run the AI program if one has been set.
	if (pEnemy->useCode)
	{
		int target = randomPartyMember(PLAYER_PARTY);
		g_target.p = getFighter(PLAYER_PARTY, target)->pPlayer;
		g_target.type = ET_PLAYER;
		g_source.p = pEnemy;
		g_source.type = ET_ENEMY;

		CProgram(g_projectPath + PRG_PATH + pEnemy->prg).run();
		return;
	}

	// Use internal AI.
	performFightAi(pEnemy->ai, idx);
}

/*
 * Apply a status effect.
 */
void applyStatusEffect(const STRING file, LPFIGHTER pFighter)
{
	extern STRING g_projectPath;

	TCHAR *const str = _tcsupr(_tcsdup(file.c_str()));

	LPSTATUS_EFFECT pEffect = NULL;

	std::map<STRING, STATUS_EFFECT>::iterator i = pFighter->statuses.find(str);
	if (i != pFighter->statuses.end())
	{
		// This status is already applied; restart its effects.
		pEffect = &i->second;
		removeStatusEffect(pEffect, pFighter);
	}
	else
	{
		pEffect = &pFighter->statuses.insert(STATUS_PAIR(str, STATUS_EFFECT())).first->second;
	}

	free(str);

	pEffect->open(g_projectPath + STATUS_PATH + file);
	if (pEffect->speed)
	{
		pFighter->speed += SPEED_MODIFIER;
	}
	if (pEffect->slow)
	{
		pFighter->speed -= SPEED_MODIFIER;
	}
	if (pEffect->disable)
	{
		++pFighter->freezes;
		pFighter->bFrozenCharge = true;
		if (pFighter->charge >= pFighter->chargeMax)
		{
			// Unlikely, but just in case.
			pFighter->charge = pFighter->chargeMax - 1;
		}
	}
}

/*
 * Remove a status effect.
 */
void removeStatusEffect(LPSTATUS_EFFECT pEffect, LPFIGHTER pFighter)
{
	if (pEffect->speed)
	{
		pFighter->speed -= SPEED_MODIFIER;
	}
	if (pEffect->slow)
	{
		pFighter->speed += SPEED_MODIFIER;
	}
	if (pEffect->disable && !--pFighter->freezes)
	{
		// Unfreeze.
		pFighter->bFrozenCharge = false;
	}
}

/*
 * Invoke a status effect.
 */
int statusEffectTick(LPSTATUS_PAIR pEffectPair, LPFIGHTER pOuterFighter)
{
	extern STRING g_projectPath;
	extern ENTITY g_target, g_source;

	IFighter *const pFighter = pOuterFighter->pFighter;

	// Get the fighter's indices.
	int party = -1, idx = -1;
	getFighterIndices(pFighter, party, idx);

	const STRING file = pEffectPair->first;
	LPSTATUS_EFFECT pEffect = &pEffectPair->second;

	if (pEffect->hp != 0)
	{
		int hp = pFighter->health() - pEffect->hpAmount;
		if (hp < 0) hp = 0;
		pFighter->health(hp);
		g_pFightPlugin->fightInform(-1, -1, party, idx, 0, 0, pEffect->hpAmount, 0, file, INFORM_REMOVE_HP);
	}

	if (pEffect->smp != 0)
	{
		int mana = pFighter->smp() - pEffect->smpAmount;
		if (mana < 0) mana = 0;
		pFighter->smp(mana);
		g_pFightPlugin->fightInform(-1, -1, party, idx, 0, 0, 0, pEffect->smpAmount, file, INFORM_REMOVE_SMP);
	}

	if (pEffect->code)
	{
		g_target.type = g_source.type = pOuterFighter->bPlayer ? ET_PLAYER : ET_ENEMY;
		g_target.p = g_source.p = pFighter;
		CProgram(g_projectPath + PRG_PATH + pEffect->prg).run();
	}

	return --pEffect->rounds;
}

/*
 * Advance the state of a fight.
 */
void fightTick()
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
					j->charge += j->speed;
				}
			}
			else
			{
				// Charged.
				if (j->pFighter->health() <= 0) continue;

				// Status effects.
				std::map<STRING, STATUS_EFFECT>::iterator k = j->statuses.begin();
				for (; k != j->statuses.end(); ++k)
				{
					if (statusEffectTick(&*k, j) == 0)
					{
						removeStatusEffect(&k->second, j);
						k = j->statuses.erase(k);
						--k;
					}
				}

				const unsigned int party = i - pParties->begin(), idx = j - i->begin();

				if (j->bPlayer)
				{
					if (!j->bFrozenCharge)
					{
						j->bFrozenCharge = true;
						g_pFightPlugin->fightInform(party, idx, -1, -1, 0, 0, 0, 0, _T(""), INFORM_SOURCE_CHARGED);
					}
				}
				else
				{
					// An enemy's turn.
					g_pFightPlugin->fightInform(party, idx, -1, -1, 0, 0, 0, 0, _T(""), INFORM_SOURCE_CHARGED);
					enemyAttack(idx);
					j->charge = 0;
				}
			}
		}
	}

	// TBD: Check for dead parties here.
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

	if (!(((g_mainFile.fightType == 0) ? rand() : (g_stepsTaken / 32)) % g_mainFile.chances))
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
	extern std::vector<CPlayer *> g_players;

	g_gp += gp;

	if (exp > 0)
	{
		TCHAR str[255];
		_itot(exp, str, 10);
		messageBox(STRING(_T("Gained ")) + str + _T(" experience points."));
	}

	// Give the experience.
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
		messageBox(STRING(_T("Gained ")) + str + _T(" GP."));
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
	extern STRING g_projectPath;
	extern std::map<unsigned int, PLUGIN_ENEMY> g_enemies;
	extern CAllocationHeap<CAudioSegment> g_music;
	extern CAudioSegment *g_bkgMusic;
	extern std::vector<CPlayer *> g_players;

	if (!g_pFightPlugin) return;

	g_fighting = true;
	g_battle = BATTLE(); // Redundant, but takes so little time that it's worth being paranoid.

	std::vector<VECTOR_FIGHTER> *pParties = &g_battle.parties;

	pParties->push_back(VECTOR_FIGHTER());
	VECTOR_FIGHTER &rEnemies = pParties->back();

	STRING runPrg, rewardPrg;
	int gp = 0, exp = 0;
	g_battle.bRun = true;

	// Add the enemies.
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
		fighter.chargeMax = 123; // (Not fair to enemies!)
		fighter.charge = rand() % fighter.chargeMax;
		fighter.speed = 3;
		fighter.bFrozenCharge = false;
		fighter.freezes = 0;
		rEnemies.push_back(fighter);
	}

	pParties->push_back(VECTOR_FIGHTER());
	VECTOR_FIGHTER &rPlayers = pParties->back();

	// Add the players.
	std::vector<CPlayer *>::const_iterator j = g_players.begin();
	for (; j != g_players.end(); ++j)
	{
		if (!*j) continue;
		FIGHTER fighter;
		fighter.bPlayer = true;
		fighter.pFighter = fighter.pPlayer = *j;
		fighter.chargeMax = 75;
		fighter.charge = rand() % fighter.chargeMax;
		fighter.speed = 3;
		fighter.bFrozenCharge = false;
		fighter.freezes = 0;
		rPlayers.push_back(fighter);
	}

	// Open the background.
	BACKGROUND bkg;
	bkg.open(g_projectPath + BKG_PATH + background);

	// Play the new music.
	CAudioSegment *pOldMusic = g_bkgMusic;
	pOldMusic->stop(); // A pause would be better.

	g_bkgMusic = g_music.allocate();
	g_bkgMusic->open(bkg.bkgMusic);
	g_bkgMusic->play(true);

	// Execute the fight.
	const int outcome = g_pFightPlugin->fight(enemies.size(), -1, background, g_battle.bRun);

	// Handle the aftermath of the fight.
	if (outcome == FIGHT_RUN_AUTO)
	{
		if (!runPrg.empty())
		{
			CProgram(g_projectPath + PRG_PATH + runPrg).run();
		}
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

	// Revert back to the previous music.
	g_bkgMusic->stop();
	g_music.free(g_bkgMusic);
	(g_bkgMusic = pOldMusic)->play(true);

	// Render the scene.
	renderNow(NULL, true);

	// Clean up.
	g_battle = BATTLE();
	g_fighting = false;
}

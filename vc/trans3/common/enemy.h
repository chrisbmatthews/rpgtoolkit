/*
 * All contents copyright 2003, 2004, 2005 Christopher Matthews or Contributors.
 * Various port optimizations copyright by Colin James Fitzpatrick, 2005.
 * All rights reserved. You may not remove this notice
 * Read license.txt for licensing details.
 */

#ifndef _ENEMY_H_
#define _ENEMY_H_

#include "../../tkCommon/strings.h"
#include "../fight/IFighter.h"
#include <vector>
#include <map>

typedef enum tagEneGfx
{
	EN_REST,
	EN_FIGHT,
	EN_DEFEND,
	EN_SPECIAL,
	EN_DIE
} ENE_GFX;

typedef struct tagEnemy : public IFighter
{
	STRING strName;
	int iHp, iMaxHp;
	int iSmp, iMaxSmp;
	int fp;
	int dp;
	char run;
	short takeCrit;
	short giveCrit;
    std::vector<STRING> specials;
    std::vector<STRING> weaknesses;
	std::vector<STRING> strengths;
	char ai; // 0-4 inclusive.
    char useCode; // Has program for AI?
    STRING prg;
    int exp;
    int gp;
    STRING winPrg;
    STRING runPrg;
	std::vector<STRING> gfx;
    std::map<STRING, STRING> customAnims;
	// IFighter.
	void experience(const int val) { exp = val; }
	int experience() { return exp; }
	void health(const int val) { iHp = val; }
	int health() { return iHp; }
	void maxHealth(const int val) { iMaxHp = val; }
	int maxHealth() { return iMaxHp; }
	void defence(const int val) { dp = val; }
	int defence() { return dp; }
	void fight(const int val) { fp = val; }
	int fight() { return fp; }
	void smp(const int val) { iSmp = val; }
	int smp() { return iSmp; }
	void maxSmp(const int val) { iMaxSmp = val; }
	int maxSmp() { return iMaxSmp; }
	void name(const STRING str) { strName = str; }
	STRING name() { return strName; }
	STRING getStanceAnimation(const STRING anim);
	//----------------------------------------------------------
	bool open(const STRING strFile);
} ENEMY, *LPENEMY;

#endif

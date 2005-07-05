/*
 * All contents copyright 2003, 2004, 2005 Christopher Matthews or Contributors.
 * Various port optimizations copyright by Colin James Fitzpatrick, 2005.
 * All rights reserved. You may not remove this notice
 * Read license.txt for licensing details.
 */

#ifndef _ENEMY_H_
#define _ENEMY_H_

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
	std::string strName;
	int iHp, iMaxHp;
	int iSmp, iMaxSmp;
	int fp;
	int dp;
	char run;
	short takeCrit;
	short giveCrit;
    std::vector<std::string> specials;
    std::vector<std::string> weaknesses;
	std::vector<std::string> strengths;
	char ai; // 0-4 inclusive.
    char useCode; // Has program for AI?
    std::string prg;
    int exp;
    int gp;
    std::string winPrg;
    std::string runPrg;
	std::vector<std::string> gfx;
    std::map<std::string, std::string> customAnims;
	// IFighter.
	void experience(const int val) { exp = val; }
	int experience(void) { return exp; }
	void health(const int val) { iHp = val; }
	int health(void) { return iHp; }
	void maxHealth(const int val) { iMaxHp = val; }
	int maxHealth(void) { return iMaxHp; }
	void defence(const int val) { dp = val; }
	int defence(void) { return dp; }
	void fight(const int val) { fp = val; }
	int fight(void) { return fp; }
	void smp(const int val) { iSmp = val; }
	int smp(void) { return iSmp; }
	void maxSmp(const int val) { iMaxSmp = val; }
	int maxSmp(void) { return iMaxSmp; }
	void name(const std::string str) { strName = str; }
	std::string name(void) { return strName; }
	//----------------------------------------------------------
	void open(const std::string strFile);
} ENEMY, *LPENEMY;

#endif

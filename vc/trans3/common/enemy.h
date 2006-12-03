/*
 ********************************************************************
 * The RPG Toolkit, Version 3
 * This file copyright (C) 2006  Christopher Matthews & contributors
 *
 * Contributors:
 *    - Colin James Fitzpatrick
 *    - Jonathan D. Hughes
 ********************************************************************
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
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
	int experience() const { return exp; }
	void health(const int val) { iHp = val; }
	int health() const { return iHp; }
	void maxHealth(const int val) { iMaxHp = val; }
	int maxHealth() const { return iMaxHp; }
	void defence(const int val) { dp = val; }
	int defence() const { return dp; }
	void fight(const int val) { fp = val; }
	int fight() const { return fp; }
	void smp(const int val) { iSmp = val; }
	int smp() const { return iSmp; }
	void maxSmp(const int val) { iMaxSmp = val; }
	int maxSmp() const { return iMaxSmp; }
	void name(const STRING str) { strName = str; }
	STRING name() const { return strName; }
	STRING getStanceAnimation(const STRING anim);
	//----------------------------------------------------------
	bool open(const STRING strFile);
} ENEMY, *LPENEMY;

#endif

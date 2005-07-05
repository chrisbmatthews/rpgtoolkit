/*
 * All contents copyright 2005, Jonathan D. Hughes
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

#ifndef _CPLAYER_H_
#define _CPLAYER_H_

#include "../../fight/IFighter.h"
#include "../../common/player.h";
#include "../CSprite/CSprite.h"

class CPlayer : public CSprite, public IFighter
{
public:

	// IFighter.
	// Keep this first in the vtable.
	//------------------------------------------------------------------
	void experience(const int val) { m_playerMem.experience = val; }
	int experience(void) { return m_playerMem.experience; }
	void health(const int val) { m_playerMem.health = val; }
	int health(void) { return m_playerMem.health; }
	void maxHealth(const int val) { m_playerMem.maxHealth = val; }
	int maxHealth(void) { return m_playerMem.maxHealth; }
	void defence(const int val) { m_playerMem.defense = val; }
	int defence(void) { return m_playerMem.defense; }
	void fight(const int val) { m_playerMem.fight = val; }
	int fight(void) { return m_playerMem.fight; }
	void smp(const int val) { m_playerMem.sm = val; }
	int smp(void) { return m_playerMem.sm; }
	void maxSmp(const int val) { m_playerMem.smMax = val; }
	int maxSmp(void) { return m_playerMem.smMax; }
	void name(const std::string str) { m_playerMem.charname = str; }
	std::string name(void) { return m_playerMem.charname; }
	std::string getStanceAnimation(const std::string anim) { return m_playerMem.spriteAttributes.getStanceAnm(anim); }
	//--------------------------------------------------------------------

	// Constructor
	CPlayer(const std::string file, const bool show);

private:
	PLAYER m_playerMem;			// Player-specific data.

};

#endif

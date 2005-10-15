/*
 * All contents copyright 2005, Jonathan D. Hughes
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

#ifndef _CPLAYER_H_
#define _CPLAYER_H_

#include "../../fight/IFighter.h"
#include "../../common/player.h"
#include "../CSprite/CSprite.h"

//	EQ_SLOT.first = filename
//	EQ_SLOT.second = handle
typedef std::pair<std::string, std::string> EQ_SLOT;

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
	std::string getStanceAnimation(const std::string anim) { return m_attr.getStanceAnm(anim); }

	// This is ridiculous! Make them public!
	int equipmentDP(void) const { return m_equipment.mDP; }
	int equipmentFP(void) const { return m_equipment.mFP; }
	int equipmentHP(void) const { return m_equipment.mHP; }
	int equipmentSM(void) const { return m_equipment.mSM; }
	int equipmentDP(const int val) { m_equipment.mDP = val; }
	int equipmentFP(const int val) { m_equipment.mFP = val; }
	int equipmentHP(const int val) { m_equipment.mHP = val; }
	int equipmentSM(const int val) { m_equipment.mSM = val; }
	EQ_SLOT equipment(const int i) const { return (m_equipment.data.size() > abs(i) ? m_equipment.data[i] : EQ_SLOT()); }
	void equipment(const EQ_SLOT eq, const int i) { if(m_equipment.data.size() > abs(i)) m_equipment.data[i] = eq; }
	//--------------------------------------------------------------------

	// Constructor
	CPlayer(const std::string file, const bool show);

	void addEquipment(const unsigned int slot, const std::string file);
	void removeEquipment(const unsigned int slot);

private:

	struct tagEquipment
	{
		int mDP, mFP, mHP, mSM;		// Cumulative attribute modifiers.
		std::vector<EQ_SLOT> data;
	} m_equipment;

	PLAYER m_playerMem;			// Player-specific data.

};

#endif

/*
 * All contents copyright 2005, Jonathan D. Hughes
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

#ifndef _CPLAYER_H_
#define _CPLAYER_H_

#include "../../../tkCommon/strings.h"
#include "../../fight/IFighter.h"
#include "../../common/player.h"
#include "../CSprite/CSprite.h"

//	EQ_SLOT.first = filename
//	EQ_SLOT.second = handle
typedef std::pair<STRING, STRING> EQ_SLOT;

class CPlayer : public CSprite, public IFighter
{
public:

	// IFighter.
	// Keep this first in the vtable.
	//------------------------------------------------------------------
	void experience(const int val) { m_playerMem.stats.experience = val; }
	int experience() { return m_playerMem.stats.experience; }
	void health(const int val) { m_playerMem.stats.health = val; }
	int health() { return m_playerMem.stats.health; }
	void maxHealth(const int val) { m_playerMem.stats.maxHealth = val; }
	int maxHealth() { return m_playerMem.stats.maxHealth; }
	void defence(const int val) { m_playerMem.stats.defense = val; }
	int defence() { return m_playerMem.stats.defense; }
	void fight(const int val) { m_playerMem.stats.fight = val; }
	int fight() { return m_playerMem.stats.fight; }
	void smp(const int val) { m_playerMem.stats.sm = val; }
	int smp() { return m_playerMem.stats.sm; }
	void maxSmp(const int val) { m_playerMem.stats.smMax = val; }
	int maxSmp() { return m_playerMem.stats.smMax; }
	void name(const STRING str) { m_playerMem.charname = str; }
	STRING name() { return m_playerMem.charname; }
	STRING getStanceAnimation(const STRING anim) { return m_attr.getStanceAnm(anim); }

	// Delano: This is ridiculous! Make them public!
	//
	// Colin:	Be my guest! IFigher is using functions because it
	//			is implemented differently in players and enemies, not
	//			because I love pointless functions!
	//
	//			In this specific case, we could even do without the
	//			setting, or at least having one general case for both
	//			set and get (i.e. one set and one get function).
	int equipmentDP() const { return m_equipment.mDP; }
	int equipmentFP() const { return m_equipment.mFP; }
	int equipmentHP() const { return m_equipment.mHP; }
	int equipmentSM() const { return m_equipment.mSM; }
	int equipmentDP(const int val) { m_equipment.mDP = val; }
	int equipmentFP(const int val) { m_equipment.mFP = val; }
	int equipmentHP(const int val) { m_equipment.mHP = val; }
	int equipmentSM(const int val) { m_equipment.mSM = val; }
	EQ_SLOT equipment(const int i) const { return (m_equipment.data.size() > abs(i) ? m_equipment.data[i] : EQ_SLOT()); }
	void equipment(const EQ_SLOT eq, const int i) { if(m_equipment.data.size() > abs(i)) m_equipment.data[i] = eq; }
	//--------------------------------------------------------------------

	// Constructor
	CPlayer(const STRING file, const bool show);

	void addEquipment(const unsigned int slot, const STRING file);
	void removeEquipment(const unsigned int slot);

	void calculateLevels(const bool init);

	// For the callbacks...
	LPPLAYER getPlayer() { return &m_playerMem; }
	LPPLAYER_STATS getInitialStats() { return &m_initStats; }

private:

	struct tagEquipment
	{
		int mDP, mFP, mHP, mSM;		// Cumulative attribute modifiers.
		std::vector<EQ_SLOT> data;
	} m_equipment;

	PLAYER m_playerMem;			// Player-specific data.
	PLAYER_STATS m_initStats;	// Initial stats.

};

#endif

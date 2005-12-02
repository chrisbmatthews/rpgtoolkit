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
	//------------------------------------------------------------------
	void experience(const int val);
	int experience() const;
	void health(const int val);
	int health() const;
	void maxHealth(const int val);
	int maxHealth() const;
	void defence(const int val);
	int defence() const;
	void fight(const int val);
	int fight() const;
	void smp(const int val);
	int smp() const;
	void maxSmp(const int val);
	int maxSmp() const;
	void name(const STRING str);
	STRING name() const;
	STRING getStanceAnimation(const STRING anim) { return m_attr.getStanceAnm(anim); }
	void level(const int val);
	int level() const;

	void giveExperience(const int exp);
	void levelUp();

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

	void getLearnedMoves(std::vector<STRING> &moves) const;

	// Constructor
	CPlayer(const STRING file, const bool show, const bool createGlobals);

	void addEquipment(const unsigned int slot, const STRING file);
	void removeEquipment(const unsigned int slot);

	void restore(const bool bDoLevels);

	// For the callbacks.
	LPPLAYER getPlayer() { return &m_playerMem; }

private:
	void calculateLevels(const bool init);

	struct tagEquipment
	{
		int mDP, mFP, mHP, mSM;		// Cumulative attribute modifiers.
		std::vector<EQ_SLOT> data;
		tagEquipment():
			mDP(0), mFP(0), mHP(0), mSM(0) { }
	} m_equipment;

	PLAYER m_playerMem;			// Player-specific data.

};

#endif

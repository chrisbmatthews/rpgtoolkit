/*
 ********************************************************************
 * The RPG Toolkit, Version 3
 * This file copyright (C) 2007 Jonathan D. Hughes & Colin James Fitzpatrick
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

#ifndef _CPLAYER_H_
#define _CPLAYER_H_

#include "../../../tkCommon/strings.h"
#include "../../fight/IFighter.h"
#include "../../common/player.h"
#include "../CSprite/CSprite.h"

//	EQ_SLOT.first = filename
//	EQ_SLOT.second = handle
typedef std::pair<STRING, STRING> EQ_SLOT, *LPEQ_SLOT;

class CPlayer : public IFighter, public CSprite 
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
	void equipmentDP(const int val) { m_equipment.mDP = val; }
	void equipmentFP(const int val) { m_equipment.mFP = val; }
	void equipmentHP(const int val) { m_equipment.mHP = val; }
	void equipmentSM(const int val) { m_equipment.mSM = val; }
	LPEQ_SLOT equipment(const int i) { return (m_equipment.data.size() > abs(i) ? &m_equipment.data[i] : NULL); }
	void equipment(const EQ_SLOT eq, const int i) 
	{ 
		while (abs(i) >= m_equipment.data.size())
		{
			m_equipment.data.push_back(EQ_SLOT());
		}
		m_equipment.data[abs(i)] = eq; 
	}

	void getLearnedMoves(std::vector<STRING> &moves) const;

	// Constructor
	CPlayer(const STRING file, const bool show, const bool createGlobals);

	void addEquipment(const unsigned int slot, const STRING file);
	void removeEquipment(const unsigned int slot);

	void restore(const bool bDoLevels);

	// For the callbacks.
	LPPLAYER getPlayer() { return &m_playerMem; }

	// Swap the graphics of this player for those of another.
	void swapGraphics(const STRING file);
	// Get the filename of the swapped graphic.
	STRING swapGraphics(void) const { return m_anmReplacement; }

private:
	void calculateLevels(const bool init);

	struct tagEquipment
	{
		int mDP, mFP, mHP, mSM;		// Cumulative attribute modifiers.
		std::vector<EQ_SLOT> data;
		tagEquipment():
			mDP(0), mFP(0), mHP(0), mSM(0) { }
	} m_equipment;

	PLAYER m_playerMem;				// Player-specific data.
	STRING m_anmReplacement;		// Filename of player whose graphics
									// have replaced this player's through
									// NewPlayer().

};

#endif

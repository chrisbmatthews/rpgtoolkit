/*
 * All contents copyright 2005, Jonathan D. Hughes
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

/*
 * Implementation of a player class.
 */

#include "CPlayer.h"
#include "../../common/CFile.h"
#include "../../common/CInventory.h"
#include "../../common/item.h"
#include "../../common/paths.h"
#include "../../rpgcode/CProgram.h"
#include "../../fight/fight.h"

/*
 * Constructor
 */
CPlayer::CPlayer(const STRING file, const bool show):
CSprite(show)				// Is the player visible?
{
	if (m_playerMem.open(file, m_attr) <= PRE_VECTOR_PLAYER)
	{
		// Create standard vectors for old items.
		m_attr.createVectors(SPR_STEP);
	}

	// Set initial stats.
	LPPLAYER_STATS pStats = &m_playerMem.stats;

	experience(pStats->experience);
	health(pStats->health);
	maxHealth(pStats->maxHealth);
	defence(pStats->defense);
	fight(pStats->fight);
	smp(pStats->sm);
	maxSmp(pStats->smMax);
	name(m_playerMem.charname);

	calculateLevels(true);

	// Get these into milliseconds!
	m_attr.speed *= MILLISECONDS;
	m_attr.idleTime *= MILLISECONDS;
}

/*
 * Stat functions.
 * These need to be done this way because the vars used can be changed.
 */

void CPlayer::experience(const int val)
{
	LPSTACK_FRAME pVar = CProgram::getGlobal(m_playerMem.experienceVar);
	pVar->udt = UDT_NUM;
	pVar->num = double(val);
}

int CPlayer::experience() const
{
	LPSTACK_FRAME pVar = CProgram::getGlobal(m_playerMem.experienceVar);
	return int(pVar->getNum());
}

void CPlayer::health(const int val)
{
	LPSTACK_FRAME pVar = CProgram::getGlobal(m_playerMem.healthVar);
	pVar->udt = UDT_NUM;
	pVar->num = double(val);
}

int CPlayer::health() const
{
	LPSTACK_FRAME pVar = CProgram::getGlobal(m_playerMem.healthVar);
	return int(pVar->getNum());
}

void CPlayer::maxHealth(const int val)
{
	LPSTACK_FRAME pVar = CProgram::getGlobal(m_playerMem.maxHealthVar);
	pVar->udt = UDT_NUM;
	pVar->num = double(val);
}

int CPlayer::maxHealth() const
{
	LPSTACK_FRAME pVar = CProgram::getGlobal(m_playerMem.maxHealthVar);
	return int(pVar->getNum());
}

void CPlayer::defence(const int val)
{
	LPSTACK_FRAME pVar = CProgram::getGlobal(m_playerMem.defenseVar);
	pVar->udt = UDT_NUM;
	pVar->num = double(val);
}

int CPlayer::defence() const
{
	LPSTACK_FRAME pVar = CProgram::getGlobal(m_playerMem.defenseVar);
	return int(pVar->getNum());
}

void CPlayer::fight(const int val)
{
	LPSTACK_FRAME pVar = CProgram::getGlobal(m_playerMem.fightVar);
	pVar->udt = UDT_NUM;
	pVar->num = double(val);
}

int CPlayer::fight() const
{
	LPSTACK_FRAME pVar = CProgram::getGlobal(m_playerMem.fightVar);
	return int(pVar->getNum());
}

void CPlayer::smp(const int val)
{
	LPSTACK_FRAME pVar = CProgram::getGlobal(m_playerMem.smVar);
	pVar->udt = UDT_NUM;
	pVar->num = double(val);
}

int CPlayer::smp() const
{
	LPSTACK_FRAME pVar = CProgram::getGlobal(m_playerMem.smVar);
	return int(pVar->getNum());
}

void CPlayer::maxSmp(const int val)
{
	LPSTACK_FRAME pVar = CProgram::getGlobal(m_playerMem.smMaxVar);
	pVar->udt = UDT_NUM;
	pVar->num = double(val);
}

int CPlayer::maxSmp() const
{
	LPSTACK_FRAME pVar = CProgram::getGlobal(m_playerMem.smMaxVar);
	return int(pVar->getNum());
}

void CPlayer::name(const STRING str)
{
	LPSTACK_FRAME pVar = CProgram::getGlobal(m_playerMem.nameVar);
	pVar->udt = UDT_LIT;
	pVar->lit = str;
}

STRING CPlayer::name() const
{
	LPSTACK_FRAME pVar = CProgram::getGlobal(m_playerMem.nameVar);
	return pVar->getLit();
}

/*
 * Calculate level up information.
 */
void CPlayer::calculateLevels(const bool init)
{
	if (init)
	{
		m_playerMem.nextLevel = m_playerMem.levelType;
		m_playerMem.levelProgression = m_playerMem.levelType - m_playerMem.stats.experience;
	}

	unsigned int numLevels = m_playerMem.maxLevel - m_playerMem.stats.level + 1;

	std::vector<double> *pLevels = &m_playerMem.levelStarts;
	pLevels->clear();
	pLevels->reserve(numLevels);
	pLevels->push_back(double(m_playerMem.stats.experience));

	unsigned double exp = double(m_playerMem.levelType);
	for (unsigned int i = 1; i < numLevels; ++i)
	{
		pLevels->push_back((*pLevels)[i - 1] + exp);
		if (m_playerMem.charLevelUpType == 0)
		{
			// Linear increase.
			exp += m_playerMem.experienceIncrease;
		}
		else
		{
			// Exponential increase.
			exp *= 1 + m_playerMem.experienceIncrease;
		}
	}
}

/*
 * Equip an item to a location on the player.
 * file contains complete path.
 */
void CPlayer::addEquipment(const unsigned int slot, const STRING file)
{
	extern STRING g_projectPath;
	extern void *g_pTarget;
	extern TARGET_TYPE g_targetType;

	if (!CFile::fileExists(file)) return;

	ITEM item;
	item.open(file, NULL);

	// Is item equippable?
	if (item.equipYN != 1) throw CError(_T("Item not equippable"));

	// Is player allowed to equip it?
	if (item.usedBy == 1)
	{
		std::vector<STRING>::iterator i = item.itmChars.begin();
		for (; i != item.itmChars.end(); ++i)
		{
			if (_tcsicmp(m_playerMem.charname.c_str(), i->c_str()) == 0)
				break;
		}
		if (i == item.itmChars.end()) throw CError(_T("Player cannot equip item."));
	}

	while (slot >= m_equipment.data.size())
	{
		m_equipment.data.push_back(EQ_SLOT());
	}
	m_equipment.data[slot].first = file;
	m_equipment.data[slot].second = item.itemName;

	// Cumulative modifiers.
	m_equipment.mDP += item.equipDP;
	m_equipment.mFP += item.equipFP;
	m_equipment.mHP += item.equipHP;
	m_equipment.mSM += item.equipSM;

	// Player variables.
	m_playerMem.stats.defense += item.equipDP;
	m_playerMem.stats.fight += item.equipFP;
	m_playerMem.stats.maxHealth += item.equipHP;
	m_playerMem.stats.smMax += item.equipSM;

	// Run equip program.

	// Preserve current target pointer.
	void *const target = g_pTarget;
	const TARGET_TYPE tt = g_targetType;

	g_pTarget = this;	g_targetType = TT_PLAYER;

	CProgram(g_projectPath + PRG_PATH + item.prgEquip).run();

	g_pTarget = target;	g_targetType = tt;
}

/*
 * Remove an equipped item from a specific body location.
 */
void CPlayer::removeEquipment(const unsigned int slot)
{
	extern STRING g_projectPath;
	extern void *g_pTarget;
	extern TARGET_TYPE g_targetType;
	extern CInventory g_inv;

	if (slot > m_equipment.data.size()) return;
	if (m_equipment.data[slot].first.empty()) return;

	ITEM item;
	item.open(m_equipment.data[slot].first, NULL);

	// Run dequip program.

	// Preserve current target pointer.
	void *const target = g_pTarget;
	const TARGET_TYPE tt = g_targetType;

	g_pTarget = this;	g_targetType = TT_PLAYER;

	CProgram(g_projectPath + PRG_PATH + item.prgRemove).run();

	g_pTarget = target;	g_targetType = tt;

	// Return item to inventory.
	g_inv.give(m_equipment.data[slot].first);

	m_equipment.data[slot].first.erase();
	m_equipment.data[slot].second.erase();

	// Remove attribute modifiers.
	// Cumulative modifiers.
	m_equipment.mDP -= item.equipDP;
	m_equipment.mFP -= item.equipFP;
	m_equipment.mHP -= item.equipHP;
	m_equipment.mSM -= item.equipSM;

	// Player variables.
	m_playerMem.stats.defense -= item.equipDP;
	m_playerMem.stats.fight -= item.equipFP;
	m_playerMem.stats.maxHealth -= item.equipHP;
	m_playerMem.stats.smMax -= item.equipSM;

	// Cap health, smp.
	if (m_playerMem.stats.health > m_playerMem.stats.maxHealth) m_playerMem.stats.health = m_playerMem.stats.maxHealth;
	if (m_playerMem.stats.sm > m_playerMem.stats.smMax) m_playerMem.stats.sm = m_playerMem.stats.smMax;
}
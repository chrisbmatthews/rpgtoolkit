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
//#include "../../rpgcode/globals.h"

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

	// This seemingly innocent block just loves to crash
	// for no reason. Crashing annoys me, so I'm commenting this
	// out until such time as I fix it.
	/** createNumGlobal(m_playerMem.defenseVar, m_playerMem.defense);
	createNumGlobal(m_playerMem.fightVar, m_playerMem.fight);
	createNumGlobal(m_playerMem.healthVar, m_playerMem.health);
	createNumGlobal(m_playerMem.maxHealthVar, m_playerMem.maxHealth);
	createNumGlobal(m_playerMem.smVar, m_playerMem.sm);
	createNumGlobal(m_playerMem.smMaxVar, m_playerMem.smMax);
	createNumGlobal(m_playerMem.leVar, m_playerMem.level);
	createNumGlobal(m_playerMem.experienceVar, m_playerMem.experience);
	createLitGlobal(m_playerMem.nameVar, m_playerMem.charname); **/

	// Get these into milliseconds!
	m_attr.speed *= MILLISECONDS;
	m_attr.idleTime *= MILLISECONDS;

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
	m_playerMem.defense += item.equipDP;
	m_playerMem.fight += item.equipFP;
	m_playerMem.maxHealth += item.equipHP;
	m_playerMem.smMax += item.equipSM;

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
	m_playerMem.defense -= item.equipDP;
	m_playerMem.fight -= item.equipFP;
	m_playerMem.maxHealth -= item.equipHP;
	m_playerMem.smMax -= item.equipSM;

	// Cap health, smp.
	if (m_playerMem.health > m_playerMem.maxHealth) m_playerMem.health = m_playerMem.maxHealth;
	if (m_playerMem.sm > m_playerMem.smMax) m_playerMem.sm = m_playerMem.smMax;
}
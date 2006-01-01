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
#include "../../common/mbox.h"
#include "../../rpgcode/CProgram.h"
#include "../../fight/fight.h"

/*
 * Constructor
 */
CPlayer::CPlayer(const STRING file, const bool show, const bool createGlobals):
CSprite(show)				// Is the player visible?
{
	if (m_playerMem.open(file, m_attr) <= PRE_VECTOR_PLAYER)
	{
		// Create standard vectors for old items.
		m_attr.createVectors(SPR_STEP);
	}

	// Load animations, but do not render frames.
	m_attr.loadAnimations(false);
	setAnm(MV_S);

	// Set initial stats.
	if (createGlobals)
	{
		// Stats need not be created for restoring players.
		LPPLAYER_STATS pStats = &m_playerMem.stats;

		experience(pStats->experience);
		level(pStats->level);
		health(pStats->health);
		maxHealth(pStats->maxHealth);
		defence(pStats->defense);
		fight(pStats->fight);
		smp(pStats->sm);
		maxSmp(pStats->smMax);
		name(m_playerMem.charname);

		calculateLevels(true);
	}

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

void CPlayer::level(const int val)
{
	LPSTACK_FRAME pVar = CProgram::getGlobal(m_playerMem.leVar);
	pVar->udt = UDT_NUM;
	pVar->num = double(val);
}

int CPlayer::level() const
{
	LPSTACK_FRAME pVar = CProgram::getGlobal(m_playerMem.leVar);
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
 * Give experience and level up as required.
 */
void CPlayer::giveExperience(const int amount)
{
	experience(experience() + amount);

	m_playerMem.nextLevel -= amount;

	while (m_playerMem.nextLevel <= 0)
	{
		// Level up.
		const int nextLev = m_playerMem.nextLevel;
		levelUp();
		m_playerMem.nextLevel += nextLev;
	}
}

/*
 * Level up the player.
 */
void CPlayer::levelUp()
{
	extern STRING g_projectPath;

	// Run the level up program.
	if (!m_playerMem.charLevelUpRPGCode.empty())
	{
		CProgram(g_projectPath + PRG_PATH + m_playerMem.charLevelUpRPGCode).run();
	}

	// Level up.
	const int lev = level();
	if (lev >= m_playerMem.maxLevel) return;
	level(lev + 1);

	if (m_playerMem.charLevelUpType == 0)
	{
		m_playerMem.levelProgression += m_playerMem.levelProgression * int(m_playerMem.experienceIncrease / 100.0);
	}
	else
	{
		m_playerMem.levelProgression += m_playerMem.experienceIncrease;
	}
	m_playerMem.nextLevel = m_playerMem.levelProgression;

	// HP.
	{
		int hp = maxHealth();
		if (m_playerMem.charLevelUpType == 0)
		{
			hp += (hp - m_equipment.mHP) * m_playerMem.levelHp / 100.0;
		}
		else
		{
			hp += m_playerMem.levelHp;
		}
		maxHealth(hp);
	}

	// DP.
	{
		int dp = defence();
		if (m_playerMem.charLevelUpType == 0)
		{
			dp += (dp - m_equipment.mDP) * m_playerMem.levelDp / 100.0;
		}
		else
		{
			dp += m_playerMem.levelDp;
		}
		defence(dp);
	}

	// FP.
	{
		int fp = fight();
		if (m_playerMem.charLevelUpType == 0)
		{
			fp += (fp - m_equipment.mFP) * m_playerMem.levelFp / 100.0;
		}
		else
		{
			fp += m_playerMem.levelFp;
		}
		fight(fp);
	}

	// SMP.
	{
		int sm = maxSmp();
		if (m_playerMem.charLevelUpType == 0)
		{
			sm += (sm - m_equipment.mSM) * m_playerMem.levelSm / 100.0;
		}
		else
		{
			sm += m_playerMem.levelSm;
		}
		maxSmp(sm);
	}

	// Inform the player.
	messageBox(name() + _T(" gained a level."));
}

/*
 * Get a list of moves the player has learnt.
 */
void CPlayer::getLearnedMoves(std::vector<STRING> &moves) const
{
	const int exp = experience();
	const int lev = level();

	std::vector<STRING>::const_iterator i = m_playerMem.smlist.begin();
	for (unsigned int j = 0; i != m_playerMem.smlist.end(); ++i, ++j)
	{
		if (!i->length()) continue;

		bool learned = false;

		// Check experience.
		if (exp >= m_playerMem.spcMinExp[j]) learned = true;

		// Check level.
		if (!learned)
		{
			if (lev >= m_playerMem.spcMinLevel[j]) learned = true;
		}

		// Check activation variable.
		if (!learned)
		{
			if (!m_playerMem.spcVar[j].empty())
			{
				LPSTACK_FRAME pVar = CProgram::getGlobal(m_playerMem.spcVar[j]);
				if (pVar->getLit() == m_playerMem.spcEquals[j]) learned = true;
			}
		}

		if (learned)
		{
			// Add this move to the list.
			moves.push_back(*i);
		}
	}
}

/*
 * Calculate level up information (for callbacks only...).
 */
void CPlayer::calculateLevels(const bool init)
{
	if (init)
	{
		m_playerMem.nextLevel = m_playerMem.levelType;
		m_playerMem.levelProgression = m_playerMem.levelType - m_playerMem.stats.experience;
	}

	unsigned int numLevels = abs(m_playerMem.maxLevel - m_playerMem.stats.level + 1);

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
			// Exponential increase.
			exp *= 1 + m_playerMem.experienceIncrease;
		}
		else
		{
			// Linear increase.
			exp += m_playerMem.experienceIncrease;
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
	extern ENTITY g_target;

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
	defence(defence() + item.equipDP);
	fight(fight() + item.equipFP);
	maxHealth(maxHealth() + item.equipHP);
	maxSmp(maxSmp() + item.equipSM);

	// Run equip program.

	// Preserve current target pointer.
	ENTITY t = g_target;

	g_target.p = this;
	g_target.type = ET_PLAYER;

	CProgram(g_projectPath + PRG_PATH + item.prgEquip).run();

	g_target = t;
}

/*
 * Remove an equipped item from a specific body location.
 */
void CPlayer::removeEquipment(const unsigned int slot)
{
	extern STRING g_projectPath;
	extern ENTITY g_target;
	extern CInventory g_inv;

	if (slot > m_equipment.data.size()) return;
	if (m_equipment.data[slot].first.empty()) return;

	ITEM item;
	item.open(m_equipment.data[slot].first, NULL);

	// Run dequip program.

	// Preserve current target pointer.
	ENTITY t = g_target;

	g_target.p = this;
	g_target.type = ET_PLAYER;

	CProgram(g_projectPath + PRG_PATH + item.prgRemove).run();

	g_target = t;

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
	defence(defence() - item.equipDP);
	fight(fight() - item.equipFP);
	maxHealth(maxHealth() - item.equipHP);
	maxSmp(maxSmp() - item.equipSM);

	// Cap health, smp.
	const int maxHp = maxHealth();
	if (health() > maxHp) health(maxHp);
	const int maxSm = maxSmp();
	if (smp() > maxSm) smp(maxSm);
}

/*
 * Restore a player, reconstructing their level.
 */
void CPlayer::restore(const bool bDoLevels)
{
	if (bDoLevels)
	{
		// Calculate level progressions.
		const int levels = level() - m_playerMem.stats.level;
		if (levels == 0)
		{
			// Player just started out.
			m_playerMem.nextLevel = m_playerMem.levelType;
			m_playerMem.levelProgression = m_playerMem.levelType - m_playerMem.stats.experience;
		}
		else
		{
			int exp = 0;
			double levelUp = double(m_playerMem.levelType);
			for (int i = 0; i != levels; ++i)
			{
				if (m_playerMem.charLevelUpType == 0)
				{
					// Exponential increase.
					levelUp *= 1 + m_playerMem.experienceIncrease * 0.01;
					exp += int(levelUp);
				}
				else
				{
					// Linear increase.
					levelUp += m_playerMem.experienceIncrease;
					exp += levelUp;
				}
			}
			m_playerMem.nextLevel = exp - experience();
			m_playerMem.levelProgression = int(levelUp);
		}
	}
	// Calculate all levels for callback use.
    calculateLevels(false);
}
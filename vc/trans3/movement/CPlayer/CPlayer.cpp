/*
 * All contents copyright 2005, Jonathan D. Hughes
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

/*
 * Implementation of a player class.
 */

#include "CPlayer.h"
#include "../../rpgcode/globals.h"

/*
 * Constructor
 */
CPlayer::CPlayer(const std::string file, const bool show):
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

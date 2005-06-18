/*
 * All contents copyright 2005, Jonathan D. Hughes
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

/*
 * Implementation of a player class.
 */

#include "CPlayer.h"

/*
 * Constructor
 */
CPlayer::CPlayer(const std::string file, const bool show):
CSprite(show)				// Is the player visible?
{
	// createCharacter().
	m_playerMem.open(file, m_attr);
	/* Variable stuff */
	
	// Get these into milliseconds!
	m_attr.speed *= MILLISECONDS;
	m_attr.idleTime *= MILLISECONDS;
}



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

/*
 * Set the player's target and current locations.
 */
void CPlayer::setPosition(const int x, const int y, const int l)
{
	m_pend.xOrig = m_pend.xTarg = m_pos.x = x;
	m_pend.yOrig = m_pend.yTarg = m_pos.y = y;
	m_pend.lOrig = m_pend.lTarg = m_pos.l = l;
}



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
	m_playerMem.open(file);
	/* Variable stuff */
	
	// Set the base class pointer to point to the player's attributes,
	// so that we can use them in the base class.
	m_pAttr = &m_playerMem.spriteAttr;

	// Or could put the SPRITE_ATTRIBUTES in CSprite and pass them into
	// player.open().
}

/*
 * Copy constructor
 */
CPlayer::CPlayer(const CPlayer &rhs):
CSprite(rhs.m_bActive)
{
	// Stuff.
}

/*
 * Copy constructor
 */
CPlayer& CPlayer::operator=(const CPlayer &rhs)
{
	// Stuff.
	std::string str = " ";
	return CPlayer(str, true);
}

/*
 * Destructor
 */
CPlayer::~CPlayer() {}

/*
 * Set the player's target and current locations.
 */
void CPlayer::setPosition(const int x, const int y, const int l)
{
	m_pend.xOrig = m_pos.x = x;
	m_pend.yOrig = m_pos.y = y;
	m_pend.lOrig = m_pos.l = l;
}



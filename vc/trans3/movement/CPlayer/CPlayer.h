/*
 * All contents copyright 2005, Jonathan D. Hughes
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

#ifndef _CPLAYER_H_
#define _CPLAYER_H_

#include "../../common/player.h";
#include "../CSprite/CSprite.h"

class CPlayer : public CSprite  
{
public:

	/*
	 * Constructor
	 */
	CPlayer(const std::string file, const bool show);

	/*
	 * Copy constructor
	 */
	CPlayer(const CPlayer &rhs);

	/*
	 * Assignment operator
	 */
	CPlayer& operator=(const CPlayer &rhs);

	/*
	 * Destructor
	 */
	~CPlayer();

	/*
	 * Set the player's target and current locations.
	 */
	void setPosition(const int x, const int y, const int l);

private:
	PLAYER m_playerMem;

};

#endif

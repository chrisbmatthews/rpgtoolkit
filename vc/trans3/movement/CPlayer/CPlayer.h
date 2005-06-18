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

	// Constructor
	CPlayer(const std::string file, const bool show);

private:
	PLAYER m_playerMem;			// Player-specific data.

};

#endif

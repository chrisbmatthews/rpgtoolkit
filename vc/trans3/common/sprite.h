/*
 * All contents copyright 2005 Christopher Matthews or Contributors.
 * All rights reserved. You may not remove this notice
 * Read license.txt for licensing details.
 */

/*
 * Common sprite file attribute functions.
 */

#ifndef _SPRITE_H_
#define _SPRITE_H_

/*
 * Includes.
 */
#include "../rpgcode/parser/parser.h"

/*
 * Definitions. *** Rename / move! ***
 */

#define PLYR_WALK_S 0
#define PLYR_WALK_N 1
#define PLYR_WALK_E 2
#define PLYR_WALK_W 3
#define PLYR_WALK_NW 4
#define PLYR_WALK_NE 5
#define PLYR_WALK_SW 6
#define PLYR_WALK_SE 7
#define PLYR_FIGHT 8
#define PLYR_DEFEND 9
#define PLYR_SPC 10
#define PLYR_DIE 11
#define PLYR_REST 12

/*
 * Common attributes of players and sprites:
 * sprite vectors, speed variables.
 */
typedef struct tagSpriteAttr
{
	std::vector<std::string> gfx;				// Filenames of standard animations for graphics.
	std::vector<std::string> standingGfx;		// Filenames of the standing animations/graphics.
	std::vector<std::string> customGfx;			// Customized animations.
	std::vector<std::string> customGfxNames;	// Customized animations (handles).
	double idleTime;							// Seconds to wait proir to switching to STAND_ graphics.
	double speed;								// Seconds between each frame increase.
//	int loopSpeed;	// Not needed here			// .speed converted to loops.

	std::string getStanceAnm(std::string stance);
} SPRITE_ATTR;

#endif

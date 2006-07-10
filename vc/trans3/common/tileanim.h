/*
 * All contents copyright 2003, 2004, 2005 Christopher Matthews or Contributors.
 * Various port optimizations copyright by Colin James Fitzpatrick, 2005.
 * All rights reserved. You may not remove this notice
 * Read license.txt for licensing details.
 */

#ifndef _TILEANIM_H_
#define _TILEANIM_H_

/*
 * Inclusions.
 */
#include "../../tkCommon/strings.h"
#include <vector>

/*
 * A tile animation.
 */
typedef struct tagTileAnim
{
	std::vector<STRING> frames;				// Filenames of each image in animation.
	int frameDelay;							// Frames per second for animation (15 is fast).

	// Volatile data.
	int currentFrame;						// Current frame for insertion/animation.
	int frameTime;							// This number will be 0 to 29 to indicate how many times the timer has clicked.

	bool open(const STRING fileName);
} TILEANIM;

#endif

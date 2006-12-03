/*
 ********************************************************************
 * The RPG Toolkit, Version 3
 * This file copyright (C) 2006  Christopher Matthews & contributors
 *
 * Contributors:
 *    - Colin James Fitzpatrick
 *    - Jonathan D. Hughes
 ********************************************************************
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
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

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
#include <string>
#include <vector>

/*
 * A tile animation.
 */
typedef struct tagTileAnim
{
	int animTileFrames;						// Total number of frames.
	std::vector<std::string> animTileFrame;	// Filenames of each image in animation.
	int animTilePause;						// Frames per second for animation (15 is fast).
	int animTileCurrentFrame;				// Current frame for insertion/animation.
	int timerFrame;							// This number will be 0 to 29 to indicate how many times the timer has clicked.
	int currentAnmFrame;					// Currently animating frame.
	bool open(const std::string fileName);
} TILEANIM;

#endif

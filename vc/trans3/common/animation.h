/*
 * All contents copyright 2003, 2004, 2005 Christopher Matthews or Contributors.
 * Various port optimizations copyright by Colin James Fitzpatrick, 2005.
 * All rights reserved. You may not remove this notice
 * Read license.txt for licensing details.
 */

#ifndef _ANIMATION_H_
#define _ANIMATION_H_

/*
 * Inclusions.
 */
#include <string>
#include <vector>

/*
 * An animation.
 */
typedef struct tagAnimation
{
	int animSizeX;						// Width.
	int animSizeY;						// Height.
	int animFrames;						// Total number of frames.
	std::vector<std::string> animFrame;	// Filenames of each image in animation.
	std::vector<int> animTransp;		// Transparent color for frame.
	std::vector<std::string> animSound;	// Sounds for each frame.
	double animPause;					// Pause length (sec) between each frame.
	int animCurrentFrame;				// Current frame we are editing.
	short animGetTransp;				// Currently getting transparent color?
	int timerFrame;						// This number will be 0 to 29 to indicate how many times the timer has clicked.
	int currentAnmFrame;				// Currently animating frame.
	std::string animFile;				// Filename (no path).
	void open(const std::string fileName);
	void save(const std::string fileName) const;
} ANIMATION;

#endif

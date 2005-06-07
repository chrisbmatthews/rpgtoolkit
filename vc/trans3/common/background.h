/*
 * All contents copyright 2003, 2004, 2005 Christopher Matthews or Contributors.
 * Various port optimizations copyright by Colin James Fitzpatrick, 2005.
 * All rights reserved. You may not remove this notice
 * Read license.txt for licensing details.
 */

#ifndef _BACKGROUND_H_
#define _BACKGROUND_H_

/*
 * Inclusions.
 */
#include <string>
#include <vector>

/*
 * A background.
 */
typedef struct tagBackground
{
	std::string image;			// Image to use on background.
	std::string bkgMusic;		// Music to play.
	std::string bkgSelWav;		// Wav to play when moving on the menu.
	std::string bkgChooseWav;	// Wav to play when player chooses from menu.
	std::string bkgReadyWav;	// Wav to play when player is ready.
	std::string bkgCantDoWav;	// Wav to play when you can't do something.
	void open(const std::string fileName);
} BACKGROUND;

#endif

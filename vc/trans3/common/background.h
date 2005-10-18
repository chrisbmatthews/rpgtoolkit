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
#include "../../tkCommon/strings.h"
#include <vector>

/*
 * A background.
 */
typedef struct tagBackground
{
	STRING image;			// Image to use on background.
	STRING bkgMusic;		// Music to play.
	STRING bkgSelWav;		// Wav to play when moving on the menu.
	STRING bkgChooseWav;	// Wav to play when player chooses from menu.
	STRING bkgReadyWav;		// Wav to play when player is ready.
	STRING bkgCantDoWav;	// Wav to play when you can't do something.
	void open(const STRING fileName);
} BACKGROUND;

#endif

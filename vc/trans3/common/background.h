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

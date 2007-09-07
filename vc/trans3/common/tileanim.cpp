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
 *
 * Creating a game EXE using the Make EXE feature creates a 
 * derivative version of trans3 that includes the game's files. 
 * Therefore the EXE must be licensed under the GPL. However, as a 
 * special exception, you are permitted to license EXEs made with 
 * this feature under whatever terms you like, so long as 
 * Corresponding Source, as defined in the GPL, of the version 
 * of trans3 used to make the EXE is available separately under 
 * terms compatible with the Licence of this software and that you 
 * do not charge, aside from any price of the game EXE, to obtain 
 * these components.
 * 
 * If you publish a modified version of this Program, you may delete
 * these exceptions from its distribution terms, or you may choose
 * to propagate them.
 */

/*
 * Inclusions.
 */
#include "../movement/movement.h"
#include "tileanim.h"
#include "CFile.h"
#include "mbox.h"

/*
 * Open a tile animtion.
 *
 * fileName (in) - file to open
 * bool (out) - open success
 */
bool tagTileAnim::open(const STRING fileName)
{

	CFile file(fileName);

	STRING fileHeader;
	file >> fileHeader;
	if (fileHeader != _T("RPGTLKIT TILEANIM"))
	{
		messageBox(_T("Unrecognised File Format! ") + fileName);
		return false;
	}

	short majorVer, minorVer;
	file >> majorVer;
	file >> minorVer;
	file >> frameDelay;

	// Convert the file's "frame pause" into a millisecond delay.
	// (The editor (as of 3.1.0 and before) stores the value of
	// a scrollbar whose maximum value of 200 corresponds to an intended
	// delay of 5ms, and minimum of 1, corresponding to 1000ms.)
	frameDelay = MILLISECONDS / double(frameDelay);

	int frameCount;
	file >> frameCount;

	frames.clear();
	for (unsigned int i = 0; i < frameCount; i++)
	{
		STRING frame;
		file >> frame;
		frames.push_back(frame);
	}
	return true;
}

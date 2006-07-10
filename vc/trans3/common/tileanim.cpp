/*
 * All contents copyright 2003, 2004, 2005 Christopher Matthews or Contributors.
 * Various port optimizations copyright by Colin James Fitzpatrick, 2005.
 * All rights reserved. You may not remove this notice
 * Read license.txt for licensing details.
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
	// (The editor (as of 3.0.7 and before) stores the value of
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

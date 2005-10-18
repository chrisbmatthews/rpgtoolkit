/*
 * All contents copyright 2003, 2004, 2005 Christopher Matthews or Contributors.
 * Various port optimizations copyright by Colin James Fitzpatrick, 2005.
 * All rights reserved. You may not remove this notice
 * Read license.txt for licensing details.
 */

/*
 * Inclusions.
 */
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
	file >> animTilePause;
	file >> animTileFrames;

	animTileFrame.clear();
	for (unsigned int i = 0; i < animTileFrames; i++)
	{
		STRING frame;
		file >> frame;
		animTileFrame.push_back(frame);
	}
	return true;
}

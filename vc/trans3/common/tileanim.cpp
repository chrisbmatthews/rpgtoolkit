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

/*
 * Open a tile animtion.
 *
 * fileName (in) - file to open
 */
void tagTileAnim::open(const std::string fileName)
{

	CFile file(fileName);

	std::string fileHeader;
	file >> fileHeader;
	if (fileHeader != "RPGTLKIT TILEANIM")
	{
		MessageBox(NULL, ("Unrecognised File Format! " + fileName).c_str(), "Open Animated Tile", 0);
		return;
	}

	short majorVer, minorVer;
	file >> majorVer;
	file >> minorVer;
	file >> animTilePause;
	file >> animTileFrames;

	animTileFrame.clear();
	for (unsigned int i = 0; i < animTileFrames; i++)
	{
		std::string frame;
		file >> frame;
		animTileFrame.push_back(frame);
	}

}

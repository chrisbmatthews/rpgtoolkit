/*
 * All contents copyright 2003, 2004, 2005 Christopher Matthews or Contributors.
 * Various port optimizations copyright by Colin James Fitzpatrick, 2005.
 * All rights reserved. You may not remove this notice
 * Read license.txt for licensing details.
 */

/*
 * Inclusions.
 */
#include "tilebitmap.h"
#include "CFile.h"

/*
 * Open a tile bitmap.
 *
 * fileName (in) - file to open
 */
void tagTileBitmap::open(const std::string fileName)
{

	CFile file(fileName);

	std::string fileHeader;
	file >> fileHeader;

	if (fileHeader != "TK3 TILEBITMAP")
	{
		MessageBox(NULL, ("Invalid tile bitmap " + fileName).c_str(), "Open Tile Bitmap", 0);
		return;
	}

	short majorVer, minorVer;
	file >> majorVer;
	file >> minorVer;

	file >> width;
	file >> height;
	resize(width, height);

	for (unsigned int i = 0; i <= width; i++)
	{
		for (unsigned int j = 0; j <= height; j++)
		{
			file >> tiles[i][j];
			file >> red[i][j];
			file >> green[i][j];
			file >> blue[i][j];
		}
	}

}

/*
 * Save a tile bitmap.
 *
 * fileName (in) - file to save to
 */
void tagTileBitmap::save(const std::string fileName) const
{

	CFile file(fileName, OF_CREATE | OF_WRITE);

	file << "TK3 TILEBITMAP";
	file << short(3);
	file << short(0);

	file << width;
	file << height;

	for (unsigned int i = 0; i <= width; i++)
	{
		for (unsigned int j = 0; j <= height; j++)
		{
			file << tiles[i][j];
			file << red[i][j];
			file << green[i][j];
			file << blue[i][j];
		}
	}

}

/*
 * Resize a tile bitmap.
 *
 * width (in) - new width
 * height (in) - new height
 */
void tagTileBitmap::resize(const int width, const int height)
{
	this->width = width;
	this->height = height;
	tiles.clear();
	red.clear();
	green.clear();
	blue.clear();
	for (unsigned int i = 0; i <= width; i++)
	{
		tiles.push_back(VECTOR_STR());
		VECTOR_STR &a = tiles.back();
		//
		red.push_back(VECTOR_SHORT());
		VECTOR_SHORT &b = red.back();
		//
		green.push_back(VECTOR_SHORT());
		VECTOR_SHORT &c = green.back();
		//
		blue.push_back(VECTOR_SHORT());
		VECTOR_SHORT &d = blue.back();
		for (unsigned int j = 0; j <= height; j++)
		{
			a.push_back("");
			b.push_back(0);
			c.push_back(0);
			d.push_back(0);
		}
	}
}

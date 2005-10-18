/*
 * All contents copyright 2003, 2004, 2005 Christopher Matthews or Contributors.
 * Various port optimizations copyright by Colin James Fitzpatrick, 2005.
 * All rights reserved. You may not remove this notice
 * Read license.txt for licensing details.
 */

#ifndef _TILE_BITMAP_H_
#define _TILE_BITMAP_H_

/*
 * Inclusions.
 */
#include "../render/render.h"
#include "../../tkCommon/strings.h"
#include <vector>

/*
 * A tile bitmap.
 */
typedef struct tagTileBitmap
{
	short width;
	short height;
	typedef std::vector<STRING> VECTOR_STR;
	std::vector<VECTOR_STR> tiles;
	typedef std::vector<short> VECTOR_SHORT;
	std::vector<VECTOR_SHORT> red;
	std::vector<VECTOR_SHORT> green;
	std::vector<VECTOR_SHORT> blue;
	bool open(const STRING fileName);
	void save(const STRING fileName) const;
	void resize(const int width, const int height);
	bool draw(CCanvas *cnv, 
			  CCanvas *cnvMask, 
			  const int x, 
			  const int y);
} TILE_BITMAP;

#endif

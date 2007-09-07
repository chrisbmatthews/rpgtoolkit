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

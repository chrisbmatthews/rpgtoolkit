/*
 ********************************************************************
 * The RPG Toolkit, Version 3
 * This file copyright (C) 2007  Jonathan D. Hughes
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

#ifndef _COORDS_H_
#define _COORDS_H_

/*
 * Defines.
 */

// Base-point of a square tile, with 0,0 at the top-left corner.
const int BASE_POINT_X = 16;
const int BASE_POINT_Y = 31;

// Iso tile, 0,0 at centre.
const int BASE_POINT_ISO_X = 0;
const int BASE_POINT_ISO_Y = 0;

// Co-ordinate system types (board member).
typedef enum tagCoordType
{
	TILE_NORMAL = 0,
	ISO_STACKED = 1,						// (Old) staggered column method.
	ISO_ROTATED = 2,						// x-y axes rotated by 60 / 30 degrees.
	PX_ABSOLUTE = 4							// Absolute co-ordinates (iso and 2D).
} COORD_TYPE;

namespace coords
{

	// Convert a tile co-ordinate to a pixel co-ordinate. brdSizeX in tiles.
	void tileToPixel(
		int &x, 
		int &y, 
		const COORD_TYPE coord, 
		const bool bAddBasePoint, 
		const int brdSizeX
	);

	// Convert a pixel co-ordinate to a tile co-ordinate. brdSizeX in tiles.
	void pixelToTile(
		int &x, 
		int &y, 
		const COORD_TYPE coord,
		const bool bRemoveBasePoint, 
		const int brdSizeX
	);

	// Round a pixel co-ordinate to the centre of the corresponding tile,
	// returning the pixel co-ordinate.
	void roundToTile(
		double &x, 
		double &y, 
		const bool bIso,
		const bool bAddBasePoint
	);
	void roundToTile(
		long &x, 
		long &y, 
		const bool bIso,
		const bool bAddBasePoint
	);

	// Transform between isometric co-ordinate systems. brdSizeX in tiles.
	void isometricTransform(
		double &x, 
		double &y, 
		const COORD_TYPE oldType,
		const COORD_TYPE newType,
		const int brdSizeX
	);
}

#endif

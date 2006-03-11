/*
 * All contents copyright 2005, 2006 Jonathan D. Hughes.
 * All rights reserved. You may not remove this notice
 * Read license.txt for licensing details.
 */

#ifndef _COORDS_H_
#define _COORDS_H_

/*
 * Defines.
 */

// Base-point of a square tile, with 0,0 at the top-left corner.
const int BASE_POINT_X = 16;
const int BASE_POINT_Y = 32;

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

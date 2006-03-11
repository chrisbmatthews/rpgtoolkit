/*
 * All contents copyright 2005, 2006 Jonathan D. Hughes
 * All rights reserved. You may not remove this notice
 * Read license.txt for licensing details.
 */

/*
 * Inclusions.
 */
#include "coords.h"

/*
 * Convert a tile co-ordinate to a pixel co-ordinate. brdSizeX in tiles.
 */
void coords::tileToPixel(int &x, int &y, const COORD_TYPE coord, const bool bAddBasePoint, const int brdSizeX)
{
	// If we have any combination (## & PX_ABSOLUTE), the position
	// will be in pixels (PX_ABSOLUTE overrides).
	switch (coord)
	{
		case TILE_NORMAL:
		{
			x = (x - 1) * 32;
			y = (y - 1) * 32;
		} break;
		case ISO_STACKED:
		{
			x = x * 64 - (y % 2 ? 32 : 64);
			y = y * 16 - 16;
		} break;
		case ISO_ROTATED:
		{
			const int dx = x;
			x = (x - y + brdSizeX) * 32; 
			y = (dx + y - brdSizeX) * 16 - 16;	
		} break;
		default:
			return;
	}

	if (bAddBasePoint)
	{
		x += (coord == TILE_NORMAL ? BASE_POINT_X : BASE_POINT_ISO_X);
		y += (coord == TILE_NORMAL ? BASE_POINT_Y : BASE_POINT_ISO_Y);
	}
}

/*
 * Convert a pixel co-ordinate to a tile co-ordinate. brdSizeX in tiles.
 */
void coords::pixelToTile(int &x, int &y, const COORD_TYPE coord, const int brdSizeX)
{
	// coord is the output type. tbd: PX_ABSOLUTE absolute should have no effect.
	switch (coord)
	{
		case TILE_NORMAL:
		{
			x = x / 32 + 1;
			y = y / 32 + 1;
		} break;
		case ISO_STACKED:
		{
			double dx = x, dy = y;
			roundToTile(dx, dy, true, false);
			// dy is at tile centre.
			y = int(dy / 16.0) + 1;
			x = int(dx / 64.0) + 1;
		} break;
		case ISO_ROTATED:
		{
			double dx = x, dy = y;
			roundToTile(dx, dy, true, false);
			y = int((dy + 16.0) / 32.0) - int(dx / 64.0) + brdSizeX;
			x = int(dx / 32.0) + y - brdSizeX;
		} break;
	}
}

/*
 * Round a pixel co-ordinate to the centre of the corresponding tile,
 * returning the pixel co-ordinate.
 */
void coords::roundToTile(double &x, double &y, const bool bIso, const bool bAddBasePoint)
{
	if (bIso)
	{
		// Round to a 32x16 grid.
		const int px = int(x / 32) * 32, py = int(y / 16) * 16;
		// Pixel offset from px.
		const int dx = int(x) - px, dy = int(y) - py;
		x = px;
		y = py;
		// Two cases: tile division runs top-left to bottom-right or
		// top-right to bottom-left through this square.
		// Determine which side the point is on - the tile centre is
		// at the closest corner.
		if (px % 64 == (py % 32) * 2)
		{
			if (dx > 2 * dy) x += 32;
			else y += 16;
		}
		else
		{
			if (32 - dx < 2 * dy)
			{
				x += 32;
				y += 16;
			}
		}
		if (bAddBasePoint)
		{
			x += BASE_POINT_ISO_X;
			y += BASE_POINT_ISO_Y;
		}
	}
	else
	{
		// Round to the 32x32 grid.
		x = int((x - 1) / 32.0) * 32.0;
		y = int((y - 1) / 32.0) * 32.0;
		if (bAddBasePoint)
		{
			x += BASE_POINT_X;
			y += BASE_POINT_Y;
		}
	}
}

/*
 * Transform between isometric co-ordinate systems. brdSizeX in tiles.
 */
void coords::isometricTransform(double &x, double &y, const COORD_TYPE oldType, const COORD_TYPE newType, const int brdSizeX)
{
	const double oldX = x, oldY = y;

	if (newType == ISO_ROTATED && oldType == ISO_STACKED)
	{
		x = oldX + int((oldY - 1.0) / 2.0);
		y = int(oldY / 2.0) + 1 - int(oldX) + (oldY - int(oldY));
		y += brdSizeX;
	}
	else if (oldType == ISO_ROTATED && newType == ISO_STACKED)
	{
		const int dy = int(oldY) - brdSizeX;

		if (!(int(oldX) % 2))
		{
			x = int(oldX / 2.0) - int((dy - 1.0) / 2.0) + (oldX - int(oldX));
			y = int(oldX) + dy;
		}
		else
		{
			x = int((oldX + 1.0) / 2.0) - int(dy / 2.0) + (oldX - int(oldX));
			y = int(oldX) + dy;
		}
	}
}

/*
 * All contents copyright 2003, 2004, 2005 Christopher Matthews or Contributors.
 * All rights reserved. You may not remove this notice
 * Read license.txt for licensing details.
 */

/*
 * Inclusions.
 */
#include "locate.h"
#include "../common/board.h"

extern LPBOARD g_pBoard;

/*
 * Convert a tile co-ordinate to a pixel co-ordinate.
 */
void pixelCoordinate(int &x, int &y, const COORD_TYPE coord, const bool bAddBasePoint)
{
	// If we have any combination (## & PX_ABSOLUTE), the position
	// will be in pixels (PX_ABSOLUTE overrides).
	switch (coord)
	{
		case TILE_NORMAL:
		{
			x = (x - 1) * 32;
			y = (y - 1) * 32;
			break;
		}
		case ISO_STACKED:
		{
			x = x * 64 - (y % 2 ? 32 : 64);
			y = y * 16 - 16;
			break;
		}
		case ISO_ROTATED:
		{
			const int dx = x;
			x = (x - y + g_pBoard->bSizeX) * 32; 
			y = (dx + y - g_pBoard->bSizeX) * 16 - 16;	
			break;
		}
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
 * Convert a pixel co-ordinate to a tile co-ordinate.
 */
void tileCoordinate(int &x, int &y, const COORD_TYPE coord)
{
	// coord is the output type.
	switch (coord)
	{
		case TILE_NORMAL:
		{
			x = x / 32 + 1;
			y = y / 32 + 1;
			break;
		}
		case ISO_STACKED:
		{
			double dx = x, dy = y;
			roundToTile(dx, dy, true, false);
			// dy is at tile centre.
			y = int(dy / 16.0) + 1;
			x = int(dx / 64.0) + 1;
			break;
		}
		case ISO_ROTATED:
		{
			double dx = x, dy = y;
			roundToTile(dx, dy, true, false);
			y = int((dy + 16.0) / 32.0) - int(dx / 64.0) + g_pBoard->bSizeX;
			x = int(dx / 32.0) + y - g_pBoard->bSizeX;
			break;
		}
	}
}

/*
 * Round a pixel co-ordinate to the centre of the corresponding tile.
 */
void roundToTile(double &x, double &y, const bool bIso, const bool bAddBasePoint)
{
	if (bIso)
	{
		// Round to a 32x16 grid.
		const int px = int(x / 32) * 32, py = int(y / 16) * 16,
		// Pixel offset from px.
				  dx = x - px, dy = y - py;
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

/**** Note to self: merge these and use COORD_TYPE. ****/

/*
 * Transform old-type isometric co-ordinates to new-type.
 */
void isoCoordTransform(const double oldX, const double oldY, double &newX, double &newY)
{
	if (g_pBoard->isIsometric())
	{
		newX = oldX + int((oldY - 1.0) / 2.0);
		newY = int(oldY / 2.0) + 1 - int(oldX) + (oldY - int(oldY));
		newY += g_pBoard->bSizeX;
	}
	else
	{
		newX = oldX;
		newY = oldY;
	}
}			

/*
 * Inverse transform old-type isometric co-ordinates to new-type.
 */
void invIsoCoordTransform(const double newX, const double newY, double &oldX, double &oldY)
{
	if (g_pBoard->isIsometric())
	{

		const int y = newY - g_pBoard->bSizeX;

		if (!(int(newX) % 2))
		{
			oldX = int(newX / 2.0) - int((y - 1.0) / 2.0) + (newX - int(newX));
			oldY = int(newX) + y;
		}
		else
		{
			oldX = int((newX + 1.0) / 2.0) - int(y / 2.0) + (newX - int(newX));
			oldY = int(newX) + y;
		}

	}
	else
	{
		oldX = newX;
		oldY = newY;
	}
}

/*
 * Get the x coord at the bottom center of a board.
 * Called by putSpriteAt, checkScrollEast, checkScrollWest.
 */
int getBottomCentreX(const double boardX, const double boardY)
{

	extern double g_topX;

	if (g_pBoard->isIsometric)
	{

		double newBoardX, newBoardY;
		isoCoordTransform(boardX, boardY, newBoardX, newBoardY);
		return int((newBoardX - (newBoardY - g_pBoard->bSizeX) - g_topX * 2.0) * 32.0);

	}
	else
	{

		// 2D board - easy!
		return int((boardX - g_topX) * 32.0 - 16.0);

	}

}

/*
 * Get the y coord at the bottom center of a board.
 * Called by putSpriteAt, checkScrollNorth, checkScrollSouth.
 */
int getBottomCentreY(const double boardX, const double boardY)
{

	extern double g_topY;

	if (g_pBoard->isIsometric)
	{
		double newBoardX, newBoardY;
		isoCoordTransform(boardX, boardY, newBoardX, newBoardY);
		return int((newBoardX + (newBoardY - g_pBoard->bSizeX) - (g_topY * 2.0 + 1.0)) * 16.0);
	}
	else
	{
		return int((boardY - g_topY) * 32.0);
	}

}
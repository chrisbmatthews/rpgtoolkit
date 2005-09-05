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
void pixelCoordinate(int &x, int &y, const COORD_TYPE coord)
{
	// If we have any combination (## & PX_ABSOLUTE), the position
	// will be in pixels (PX_ABSOLUTE overrides).
	switch (coord)
	{
		case TILE_NORMAL:
		{
			x = (x - 1) * 32 + BASE_POINT_X;
			y = (y - 1) * 32 + BASE_POINT_Y;
			break;
		}
		case ISO_STACKED:
		{
			x = x * 64 - (y % 2 ? 32 : 64) + BASE_POINT_ISO_X;
			y = y * 16 - 16 + BASE_POINT_ISO_Y;
			break;
		}
		case ISO_ROTATED:
		{
			const int dx = x;
			x = (x - y + g_pBoard->bSizeX) * 32 + BASE_POINT_ISO_X; 
			y = (dx + y - g_pBoard->bSizeX) * 16 + BASE_POINT_ISO_Y;	
		}
	}
}

/*
 * Round a pixel co-ordinate to the centre of the corresponding tile.
 */
void roundToTile(double &x, double &y, const bool bIso)
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
		x += BASE_POINT_ISO_X;
		y += BASE_POINT_ISO_Y;
	}
	else
	{
		// Round to the 32x32 grid.
		x = int((x - 1) / 32.0) * 32.0 + BASE_POINT_X;
		y = int((y - 1) / 32.0) * 32.0 + BASE_POINT_Y;
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

/*
 * Increment a player's position on the board.
 */
void incrementPosition(SPRITE_POSITION &pos, PENDING_MOVEMENT &pend, const double moveFraction)
{

	if (g_pBoard->isIsometric)
	{

		// Coordinate transform!
		isoCoordTransform(pos.x, pos.y, pos.x, pos.y);
		double xTarg, yTarg;
		isoCoordTransform(pend.xTarg, pend.yTarg, xTarg, yTarg);

		switch (pend.direction)
		{

			case MV_NE:
				pos.y -= moveFraction;
				if (pos.y < yTarg) pos.y = yTarg;	 // We need x, y as FRACTIONs.
				break;

			case MV_NW:
				pos.x -= moveFraction;
				if (pos.x < xTarg) pos.x = xTarg;
				break;

			case MV_SE:
				pos.x += moveFraction;
				if (pos.x > xTarg) pos.x = xTarg;
				break;

			case MV_SW:
				pos.y += moveFraction;
				if (pos.y > yTarg) pos.y = yTarg;
				break;

			case MV_N:
				pos.x -= moveFraction;
				pos.y -= moveFraction;

				if (pos.x < xTarg) pos.x = xTarg;
				if (pos.y < yTarg) pos.y = yTarg;
				break;

			case MV_S:
				pos.x += moveFraction;
				pos.y += moveFraction;
					
				if (pos.x > xTarg) pos.x = xTarg;
				if (pos.y > yTarg) pos.y = yTarg;
				break;

			case MV_E:
				pos.x += moveFraction;
				pos.y -= moveFraction;

				if (pos.x > xTarg) pos.x = xTarg;
				if (pos.y < yTarg) pos.y = yTarg;
				break;

			case MV_W:
				pos.x -= moveFraction;
				pos.y += moveFraction;

				if (pos.x < xTarg) pos.x = xTarg;
				if (pos.y > yTarg) pos.y = yTarg;
				break;

		}

		// Invert!
		invIsoCoordTransform(pos.x, pos.y, pos.x, pos.y);

	}
	else
	{

		switch (pend.direction)
		{

			case MV_NE:
				pos.x += moveFraction;
				pos.y -= moveFraction;
					
				if (pos.x > pend.xTarg) pos.x = pend.xTarg; // We need x, y as FRACTIONs.
				if (pos.y < pend.yTarg) pos.y = pend.yTarg;
				break;

			case MV_NW:
				pos.x -= moveFraction;
				pos.y -= moveFraction;

				if (pos.x < pend.xTarg) pos.x = pend.xTarg;
				if (pos.y < pend.yTarg) pos.y = pend.yTarg;
				break;

			case MV_SE:
				pos.x += moveFraction;
				pos.y += moveFraction;

				if (pos.x > pend.xTarg) pos.x = pend.xTarg;
				if (pos.y > pend.yTarg) pos.y = pend.yTarg;
				break;

			case MV_SW:
				pos.x -= moveFraction;
				pos.y += moveFraction;

				if (pos.x < pend.xTarg) pos.x = pend.xTarg;
				if (pos.y > pend.yTarg) pos.y = pend.yTarg;
				break;

			case MV_N:
				pos.y -= moveFraction;
				if (pos.y < pend.yTarg) pos.y = pend.yTarg;
				break;

			case MV_S:
				pos.y += moveFraction;
				if (pos.y > pend.yTarg) pos.y = pend.yTarg;
				break;

			case MV_E:
				pos.x += moveFraction;
				if (pos.x > pend.xTarg) pos.x = pend.xTarg;
				break;

			case MV_W:
				pos.x -= moveFraction;
				if (pos.x < pend.xTarg) pos.x = pend.xTarg;
				break;

		}

	}

}

/*
 * Fill in tile target coordinates from pending movement.
 */
void insertTarget(PENDING_MOVEMENT &pend)
{

	extern double g_movementSize;

	if (g_pBoard->isIsometric)
	{

		// Coordinate transform!
		// ============================================================
		isoCoordTransform(pend.xOrig, pend.yOrig, pend.xOrig, pend.yOrig);

		switch (pend.direction)
		{

			case MV_NE:
				pend.xTarg = pend.xOrig;
				pend.yTarg = pend.yOrig - g_movementSize;
				break;

			case MV_NW:
				pend.xTarg = pend.xOrig - g_movementSize;
				pend.yTarg = pend.yOrig;
				break;

			case MV_SE:
				pend.xTarg = pend.xOrig + g_movementSize;
				pend.yTarg = pend.yOrig;
				break;

			case MV_SW:
				pend.xTarg = pend.xOrig;
				pend.yTarg = pend.yOrig + g_movementSize;
				break;

			case MV_N:
				pend.xTarg = pend.xOrig - g_movementSize;
				pend.yTarg = pend.yOrig - g_movementSize;
				break;

			case MV_S:
				pend.xTarg = pend.xOrig + g_movementSize;
				pend.yTarg = pend.yOrig + g_movementSize;
				break;

			case MV_E:
				pend.xTarg = pend.xOrig + g_movementSize;
				pend.yTarg = pend.yOrig - g_movementSize;
				break;

			case MV_W:
				pend.xTarg = pend.xOrig - g_movementSize;
				pend.yTarg = pend.yOrig + g_movementSize;
				break;

			default:
				pend.xTarg = pend.xOrig;
				pend.yTarg = pend.yOrig;
				break;

		}

		invIsoCoordTransform(pend.xTarg, pend.yTarg, pend.xTarg, pend.yTarg);
		invIsoCoordTransform(pend.xOrig, pend.yOrig, pend.xOrig, pend.yOrig); // Don't forget these!
		// =================================================================

	}
	else
	{
		// 2D.
		switch (pend.direction)
		{

			case MV_NE:
				pend.xTarg = pend.xOrig + g_movementSize;
				pend.yTarg = pend.yOrig - g_movementSize;
				break;

			case MV_NW:
				pend.xTarg = pend.xOrig - g_movementSize;
				pend.yTarg = pend.yOrig - g_movementSize;
				break;

			case MV_SE:
				pend.xTarg = pend.xOrig + g_movementSize;
				pend.yTarg = pend.yOrig + g_movementSize;
				break;

			case MV_SW:
				pend.xTarg = pend.xOrig - g_movementSize;
				pend.yTarg = pend.yOrig + g_movementSize;
				break;

			case MV_N:
				pend.xTarg = pend.xOrig;
				pend.yTarg = pend.yOrig - g_movementSize;
				break;

			case MV_S:
				pend.xTarg = pend.xOrig;
				pend.yTarg = pend.yOrig + g_movementSize;
				break;

			case MV_E:
				pend.xTarg = pend.xOrig + g_movementSize;
				pend.yTarg = pend.yOrig;
				break;

			case MV_W:
				pend.xTarg = pend.xOrig - g_movementSize;
				pend.yTarg = pend.yOrig;
				break;

			default:
				pend.xTarg = pend.xOrig;
				pend.yTarg = pend.yOrig;
				break;

		}

	}

   pend.lTarg = pend.lOrig;

}

/*
 * Round player coords.
 */
SPRITE_POSITION roundCoords(SPRITE_POSITION &passPos, const int direction)
{

	/*
	 * We want programs to trigger when it *appears* that the sprite is in far enough onto the
	 * tile to trigger it.
	 * Sprite size will vary widely, but we assume 32px wide, with "feet" at the very base of
	 * the sprite.
	 * Triggering will act differently for horizontal and vertical movement.
	 *   Horizontally, the position of the base is well-defined, and it can be clearly seen
	 *   when a player is aligned with the tile (y = 0.25 -> 1.00 == 4 quarters.)
	 *   Vertically, it depends on the width of the player. Assuming 32px, the player will
	 *   straddle the trigger tile from x = -0.25 -> 0.75 == 7 quarters, but if we disregard
	 *   the first on either side, that leaves x = -0.75 -> 0.5 == 4 quarters which is better.
	 *
	 *   This does however lead to inconsistencies when walking onto tiles from different
	 *   directions: walking up the side of a tile @ x = -0.25 or x = 0.75 won't trigger,
	 *   whilst walking on the same spots horizontally will trigger.
	 *
	 *   There are also problems with diagonals: the corner sectors won't trigger because
	 *   their co-ords correspond to other trigger spots.
	 *
	 *   Trigger programs run only once per tile by only running when first entering the tile.
	 *   Decimal checks on the co-ords ensure this.
	 */

	extern double g_movementSize;

	if (g_movementSize == 1) return passPos;

	SPRITE_POSITION toRet = passPos;

	if (g_pBoard->isIsometric)
	{

		/*
		 * The conditions are slightly different because the sprite's base is a different
		 * shape. Also, directions have rotated.
		 */

		double rx, ry;
		isoCoordTransform(toRet.x, toRet.y, toRet.x, toRet.y);

		switch (direction)
		{

			/*
			 * First, check technical East-West. Directions have rotated, so North is now
			 * NorthEast, SouthEast is now South etc.
			 */
			case MV_E:
			case MV_SE:
			case MV_S:

				if ((toRet.x - int(toRet.x)) == (1 - g_movementSize))
				{
					rx = -int(-toRet.x);
					if (abs(toRet.y - round(toRet.y)) <= g_movementSize) // <= 1/4 [sprite width / 2]
					{
						ry = round(toRet.y);
					}
				}
				break;

			case MV_N:
			case MV_NW:
			case MV_W:

				if ((toRet.x - int(toRet.x)) == g_movementSize)
				{	
					rx = int(toRet.x);
					if (abs(toRet.y - round(toRet.y)) <= g_movementSize)  // <= 1/4
					{
						ry = round(toRet.y);
					}
				}
				break;

		}

		switch (direction)
		{

			// Now check technical North-South. Overwrite rx for diagonals if found.
			case MV_N:
			case MV_NE:
			case MV_E:

				if ((toRet.y - int(toRet.y)) == g_movementSize)
				{
					ry = int(toRet.y);
					if (abs(toRet.x - round(toRet.x)) <= g_movementSize) // <= 1/4
					{
						rx = round(toRet.x);
					}
				}
				break;

			case MV_W:
			case MV_SW:
			case MV_S:

				if ((toRet.y - int(toRet.y)) == (1 - g_movementSize))
				{
					ry = -int(-toRet.y);
					if (abs(toRet.x - round(toRet.x)) <= g_movementSize)	// <= 1/4
					{
						rx = round(toRet.x);
					}
				}
				break;

			case MV_SE:
			case MV_NW:
				// Prevent "Case Else"
				break;

			default:
				rx = round(toRet.x);
				ry = round(toRet.y);
				break;
	
		}

		/*
		 * All cases: assign what we've calculated.
		 * Most of the time these will be zero, and no prg will trigger, which prevents
		 * multiple runnings whilst walking over a tile.
		 */
		toRet.x = rx;
		toRet.y = ry;

		invIsoCoordTransform(toRet.x, toRet.y, toRet.x, toRet.y);

	}
	else
	{

		double rx, ry;

		// Standard.
		switch (direction)
		{
			
			// First, check East-West.
			case MV_E:
			case MV_NE:
			case MV_SE:

				if ((toRet.x - int(toRet.x)) == g_movementSize)
				{
					rx = -int(-toRet.x);
				}
				break;

			case MV_W:
			case MV_NW:
			case MV_SW:

				if ((toRet.x - int(toRet.x)) == (1 - g_movementSize))
				{
					rx = int(toRet.x);
				}
				break;

		}

		switch (direction)
		{

			// Now check North-South. Overwrite rx for diagonals if found.
			case MV_N:
			case MV_NE:
			case MV_NW:

				if (int(toRet.y) == toRet.y)
				{
					rx = round(toRet.x);
				}
				break;

			case MV_S:
			case MV_SE:
			case MV_SW:
				if ((toRet.y - int(toRet.y)) == g_movementSize)
				{
					rx = round(toRet.x);
				}
				break;

			case MV_E:
			case MV_W:
				// Prevent "Case Else"
				break;

			default:
				rx = round(toRet.x);
				ry = round(toRet.y);
				break;

		}

		// All cases: assign what we've calculated.
		toRet.x = rx;
		toRet.y = -int(-toRet.y);

	}

	return toRet;

}

/*
 * Increment the player co-ords one tile from the direction they are facing, to test
 * if items or programs lie directly in front of them.
 * Called by programTest only.
 */
SPRITE_POSITION activationCoords(SPRITE_POSITION &passPos, SPRITE_POSITION &roundPos)
{

	extern double g_movementSize;

	SPRITE_POSITION toRet;

	double passX, passY;
	isoCoordTransform(passPos.x, passPos.y, passX, passY);

	if (g_pBoard->isIsometric)
	{

		/*
		 * For iso px/tile we can't get closer than a tile (if solid).
		 * If .y not integer (px}, it won't trigger, which is good because
		 * we don't want it to unless we're right next to it.
		 */

		const std::string &stance = passPos.stance;

		if (stance == "walk_n" || stance == "stand_n")
		{
			if (passX == int(passX)) // Pushing against a right-hand edge.
			{
				toRet.x = passX - 1;
			}
			else
			{
				toRet.x = round(passX);
			}
			if (passY == int(passY)) // Pushing against a left-hand edge.
			{
				toRet.y = passY - 1;
			}
			else
			{
				toRet.y = round(passY);
			}
		}
		else if (stance == "walk_s" || stance == "stand_s")
		{
			if (passX == int(passX)) // Pushing against a right-hand edge.
			{
				toRet.x = passX + 1;
			}
			else
			{
				toRet.x = round(passX);
			}
			if (passY == int(passY)) // Pushing against a left-hand edge.
			{
				toRet.y = passY + 1;
			}
			else
			{
				toRet.y = round(passY);
			}
		}
		else if (stance == "walk_e" || stance == "stand_e")
		{
			if (passX == int(passX)) // Pushing against an upper edge.
			{
				toRet.x = passX + 1;
			}
			else
			{
				toRet.x = round(passX);
			}
			if (passY == int(passY)) // Pushing against a lower edge.
			{
				toRet.y = passY - 1;
			}
			else
			{
				toRet.y = round(passY);
			}
		}
		else if (stance == "walk_w" || stance == "stand_w")
		{
			if (passX == int(passX)) // Pushing against an upper edge.
			{
				toRet.x = passX - 1;
			}
			else
			{
				toRet.x = round(passX);
			}
			if (passY == int(passY)) // Pushing against a lower edge.
			{
				toRet.y = passY + 1;
			}
			else
			{
				toRet.y = round(passY);
			}
		}
		else if (stance == "walk_ne" || stance == "stand_ne")
		{
			toRet.y = passY - 1;
			toRet.x = round(passX);
		}
		else if (stance == "walk_nw" || stance == "stand_nw")
		{
			toRet.x = passX - 1;
			toRet.y = round(passY);
		}
		else if (stance == "walk_se" || stance == "stand_se")
		{
			toRet.x = passX + 1;
			toRet.y = round(passY);
		}
		else if (stance == "walk_sw" || stance == "stance_sw")
		{
			toRet.y = passY + 1;
			toRet.x = round(passX);
		}

	}
	else
	{

		// Using .stance because pend.direction could be mv_idle.
		const std::string &stance = passPos.stance;

		if (stance == "walk_n" || stance == "stand_n")
		{
			toRet.x = roundPos.x;
			if (g_movementSize != 1)
			{
				toRet.y = round(passPos.y);
			}
			else
			{
				toRet.y = passPos.y - 1;
			}
		}
		else if (stance == "walk_s" || stance == "stand_s")
		{
			toRet.x = roundPos.x;
			toRet.y = int(passPos.y) + 1;
		}
		else if (stance == "walk_e" || stance == "stand_e")
		{
			toRet.x = int(passPos.x) + 1;
			toRet.y = -int(-passPos.y);
		}
		else if (stance == "walk_w" || stance == "stand_w")
		{
			toRet.x = -int(-passPos.x) - 1;
			toRet.y = -int(-passPos.y);
		}
		else if (stance == "walk_ne" || stance == "stand_ne")
		{
			toRet.x = int(passPos.x) + 1;
			if (g_movementSize != 1)
			{
				toRet.y = round(passPos.y) - 1;
			}
			else
			{
				toRet.y = passPos.y - 1;
			}
		}
		else if (stance == "walk_nw" || stance == "stand_nw")
		{
			toRet.x = -int(-passPos.x) - 1;
			if (g_movementSize != 1)
			{
				toRet.y = round(passPos.y) - 1;
			}
			else
			{
				toRet.y = passPos.y - 1;
			}
		}
		else if (stance == "walk_se" || stance == "stand_se")
		{
			toRet.x = int(passPos.x) + 1;
			toRet.y = int(passPos.y) - 1;
		}
		else if (stance == "walk_sw" || stance == "stand_sw")
		{
			toRet.x = -int(-passPos.x) - 1;
			toRet.y = int(passPos.y) + 1;
		}

	}

	return toRet;

}

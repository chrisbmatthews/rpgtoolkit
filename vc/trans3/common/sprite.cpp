/*
 * All contents copyright 2005 Christopher Matthews or Contributors.
 * All rights reserved. You may not remove this notice
 * Read license.txt for licensing details.
 */

/*
 * Common sprite file attribute functions.
 */

#include "sprite.h"
#include "board.h"
#include "../rpgcode/parser/parser.h"

/*
 * Fill out unoccupied stances with occupied stances.
 * *Much* more efficient than ::getStanceAnm!
 */
void tagSpriteAttr::completeStances(GFX_MAP &gfx)
{
	// Complete diagonal movements with EAST / WEST.
	// Note EAST / WEST may also be empty, but this is checked when using.
	if (gfx[MV_NW].empty())	gfx[MV_NW] = gfx[MV_W];
	if (gfx[MV_SW].empty())	gfx[MV_SW] = gfx[MV_W];
	if (gfx[MV_NE].empty())	gfx[MV_NE] = gfx[MV_E];
	if (gfx[MV_SE].empty())	gfx[MV_SE] = gfx[MV_E];

	// Initialise the MV_IDLE entry too for safety, 
	// although it should never be called.
	gfx[MV_IDLE] = gfx[MV_S];
}

/*
 * Redundant in movement animations - to be modified for battle plugin.
 * Get a stance animation filename
 * (CommonPlayer playerGetStanceAnm and (CommonItem itemGetStanceAnm))
 */
std::string tagSpriteAttr::getStanceAnm(std::string stance)
{
	if (stance.empty())
	{
		stance = "WALK_S";
	}
	else
	{
		stance = parser::uppercase(stance);
	}

	if (stance == "STAND_S")
	{
		return mapGfx[GFX_IDLE][MV_S];
	}
	else if (stance == "STAND_N")
	{
		return mapGfx[GFX_IDLE][MV_N];
	}
	else if (stance == "STAND_E")
	{
		return mapGfx[GFX_IDLE][MV_E];
	}
	else if (stance == "STAND_W")
	{
		return mapGfx[GFX_IDLE][MV_W];
	}
	else if (stance == "STAND_NW")
	{
		return mapGfx[GFX_IDLE][MV_NW];
	}
	else if (stance == "STAND_NE")
	{
		return mapGfx[GFX_IDLE][MV_NE];
	}
	else if (stance == "STAND_SW")
	{
		return mapGfx[GFX_IDLE][MV_SW];
	}
	else if (stance == "STAND_SE")
	{
		return mapGfx[GFX_IDLE][MV_SE];
	}
	else if (stance == "WALK_S")
	{
		return mapGfx[GFX_MOVE][MV_S];
	}
	else if (stance == "WALK_N")
	{
		return mapGfx[GFX_MOVE][MV_N];
	}
	else if (stance == "WALK_E")
	{
		return mapGfx[GFX_MOVE][MV_E];
	}
	else if (stance == "WALK_W")
	{
		return mapGfx[GFX_MOVE][MV_W];
	}
	else if (stance == "WALK_NW")
	{
		return mapGfx[GFX_MOVE][MV_NW];
	}
	else if (stance == "WALK_NE")
	{
		return mapGfx[GFX_MOVE][MV_NE];
	}
	else if (stance == "WALK_SW")
	{
		return mapGfx[GFX_MOVE][MV_SW];
	}
	else if (stance == "WALK_SE")
	{
		return mapGfx[GFX_MOVE][MV_SE];
	}
	else if (stance == "FIGHT" || stance == "ATTACK")
	{
		return mapCustomGfx[GFX_FIGHT];
	}
	else if (stance == "SPC" || stance == "SPECIAL MOVE")
	{
		return mapCustomGfx[GFX_SPC];
	}
	return mapCustomGfx[stance];
}

/*
 * Create some default vectors for *old* versions of players, items.
 */
void tagSpriteAttr::createVectors(const int activationType)
{
	extern double g_movementSize;
	extern LPBOARD g_pBoard;
	// Activation vector depends on activation method.
	// For keypress, the activation vector must extend outside the base.
	// For step, the activation will be the base.

	if (g_pBoard->isIsometric == 1)
	{

	}
	else
	{
		if (g_movementSize != 1)
		{
			// 1/2 height base for pixel movement (or other?).
			DB_POINT pts[] = {{1, 17}, {1, 31}, {31, 31}, {31, 17}};
			vBase.push_back(pts, 4);
			vBase.close(true, 0);

			if (activationType & SPR_KEYPRESS)
			{
				DB_POINT pts[] = {{-8, 8}, {-8, 39}, {39, 39}, {39, 8}};
				vActivate.push_back(pts, 4);
				vActivate.close(true, 0);
			}
			else
			{
				vActivate = vBase;
			}
		}
		else
		{

			DB_POINT pts[] = {{1, 1}, {1, 31}, {31, 31}, {31, 1}};
			vBase.push_back(pts, 4);
			vBase.close(true, 0);

			if (activationType & SPR_KEYPRESS)
			{
				// Create a one tile-wide ring around player.
				DB_POINT pts[] = {{-32, -32}, {-32, 63}, {63, 63}, {63, -32}};
				vActivate.push_back(pts, 4);
				vActivate.close(true, 0);
			}
			else
			{
				vActivate = vBase;
			}
		} // if (g_movementSize != 1)
	} // if (g_pBoard->isIsometric == 1)
}


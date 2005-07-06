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

	std::string toRet = "";

    if (stance == "STAND_S")
	{
		toRet = (standingGfx[PLYR_WALK_S].empty() ? gfx[PLYR_WALK_S] : standingGfx[PLYR_WALK_S]);
    }
    else if (stance == "STAND_N")
	{
		toRet = (standingGfx[PLYR_WALK_N].empty() ? gfx[PLYR_WALK_N] : standingGfx[PLYR_WALK_N]);
    }
    else if (stance == "STAND_E")
	{
		toRet = (standingGfx[PLYR_WALK_E].empty() ? gfx[PLYR_WALK_E] : standingGfx[PLYR_WALK_E]);
    }
    else if (stance == "STAND_W")
	{
		toRet = (standingGfx[PLYR_WALK_W].empty() ? gfx[PLYR_WALK_W] : standingGfx[PLYR_WALK_W]);
    }
    else if (stance == "STAND_NW")
	{
		// stand_nw > stand_w > walk_nw > walk_w.
		toRet = (standingGfx[PLYR_WALK_NW].empty() ? standingGfx[PLYR_WALK_W] : standingGfx[PLYR_WALK_NW]);
		if (toRet.empty())
		{
			toRet = (gfx[PLYR_WALK_NW].empty() ? gfx[PLYR_WALK_W] : gfx[PLYR_WALK_NW]);
		}
    }
    else if (stance == "STAND_NE")
	{
		// stand_ne > stand_e > walk_ne > walk_e.
		toRet = (standingGfx[PLYR_WALK_NE].empty() ? standingGfx[PLYR_WALK_E] : standingGfx[PLYR_WALK_NE]);
		if (toRet.empty())
		{
			toRet = (gfx[PLYR_WALK_NE].empty() ? gfx[PLYR_WALK_E] : gfx[PLYR_WALK_NE]);
		}
    }
    else if (stance == "STAND_SW")
	{
		// stand_sw > stand_w > walk_sw > walk_w.
		toRet = (standingGfx[PLYR_WALK_SW].empty() ? standingGfx[PLYR_WALK_W] : standingGfx[PLYR_WALK_SW]);
		if (toRet.empty())
		{
			toRet = (gfx[PLYR_WALK_SW].empty() ? gfx[PLYR_WALK_W] : gfx[PLYR_WALK_SW]);
		}
    }
    else if (stance == "STAND_SE")
	{
		// stand_se > stand_e > walk_se > walk_e.
		toRet = (standingGfx[PLYR_WALK_SE].empty() ? standingGfx[PLYR_WALK_E] : standingGfx[PLYR_WALK_SE]);
		if (toRet.empty())
		{
			toRet = (gfx[PLYR_WALK_SE].empty() ? gfx[PLYR_WALK_E] : gfx[PLYR_WALK_SE]);
		}
    }
	else if (stance == "WALK_S")
	{
		toRet = gfx[PLYR_WALK_S];
	}
	else if (stance == "WALK_N")
	{
		toRet = gfx[PLYR_WALK_N];
	}
	else if (stance == "WALK_E")
	{
		toRet = gfx[PLYR_WALK_E];
	}
	else if (stance == "WALK_W")
	{
		toRet = gfx[PLYR_WALK_W];
	}
	else if (stance == "WALK_NW")
	{
		toRet = (gfx[PLYR_WALK_NW].empty() ? gfx[PLYR_WALK_W] : gfx[PLYR_WALK_NW]);
	}
	else if (stance == "WALK_NE")
	{
		toRet = (gfx[PLYR_WALK_NE].empty() ? gfx[PLYR_WALK_E] : gfx[PLYR_WALK_NE]);
	}
	else if (stance == "WALK_SW")
	{
		toRet = (gfx[PLYR_WALK_SW].empty() ? gfx[PLYR_WALK_W] : gfx[PLYR_WALK_SW]);
	}
	else if (stance == "WALK_SE")
	{
		toRet = (gfx[PLYR_WALK_SE].empty() ? gfx[PLYR_WALK_E] : gfx[PLYR_WALK_SE]);
	}
	else if (stance == "FIGHT" || stance == "ATTACK")
	{
		toRet = mapCustomGfx[GFX_FIGHT];
	}
	else if (stance == "DEFEND")
	{
		toRet = mapCustomGfx[GFX_DEFEND];
	}
	else if (stance == "SPC" || stance == "SPECIAL MOVE")
	{
		toRet = mapCustomGfx[GFX_SPC];
	}
	else if (stance == "DIE")
	{
		toRet = mapCustomGfx[GFX_DIE];
	}
	else if (stance == "REST")
	{
		toRet = mapCustomGfx[GFX_REST];
	}
	else
	{
		//it's a custom stance, search the custom stances.
		for (unsigned int i = 0; i <= customGfxNames.size(); i++)
		{
			if (parser::uppercase(customGfxNames[i]) == stance) 
			{
				toRet = customGfx[i];
				break;
			}
		}
	}
    return toRet;
}

/*
 * Create some default vectors for *old* versions of players, items.
 */
void tagSpriteAttr::createVectors(const int activationType)
{
	extern double g_movementSize;
	extern BOARD g_activeBoard;
	// Activation vector depends on activation method.
	// For keypress, the activation vector must extend outside the base.
	// For step, the activation will be the base.

	if (g_activeBoard.isIsometric == 1)
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
	} // if (g_activeBoard.isIsometric == 1)
}


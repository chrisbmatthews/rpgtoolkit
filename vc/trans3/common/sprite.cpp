/*
 ********************************************************************
 * The RPG Toolkit, Version 3
 * This file copyright (C) 2007 Jonathan D. Hughes & Colin James Fitzpatrick
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
 */

/*
 * Common sprite file attribute functions.
 */

#include "sprite.h"
#include "board.h"
#include "../rpgcode/parser/parser.h"
#include "../movement/CSprite/CSprite.h"


/*
 * Define some default sprite bases and activation areas.
 */
DB_POINT spriteBases[8][4] = 
{
	{{  0, 0}, {30, 0}, {30, 30}, {0, 30}},	// Tile/2D. 31x31.
	{{  0, 0}, {96, 0}, {96, 96}, {0, 96}},	// Tile/2D activation. 97x97.
	{{  0, 0}, {30, 0}, {30, 14}, {0, 14}},	// Pixel/2D. 31x15.
	{{  0, 0}, {48, 0}, {48, 32}, {0, 32}},	// Pixel/2D activation. 49x33.
	{{-31, 0}, {0, 15}, {31,  0}, {0,-15}},	// Tile/iso. 31x15 diamond.
	{{-95, 0}, {0, 47}, {95,  0}, {0,-47}},	// Tile/iso activation. 31x15 diamond.
	{{-15, 0}, {0,  7}, {15,  0}, {0, -7}},	// Pixel/iso. 31x15 diamond.
	{{-31, 0}, {0, 15}, {31,  0}, {0,-15}}	// Pixel/iso activation. 63x31 diamond.
};

/*
 * Offsets for above bases (see BASE_POINT_* constants).
 */
DB_POINT spriteBaseOffsets[8] = 
{
	{-15,-31}, {-48,-48}, {-15,-15}, {-24,-24},		// Tile (see above).
	{  0,  0}, {  0,  0}, {  0,  0}, {  0,  0}		// Isometric.
};

/*
 * Fill out unoccupied stances with occupied stances.
 * *Much* more efficient than ::getStanceAnm!
 */
void tagSpriteAttr::completeStances(GFX_MAP &gfx)
{
	// Complete diagonal movements with EAST / WEST.
	// Note EAST / WEST may also be empty, but this is checked when using.
	if (gfx[MV_NW].file.empty()) gfx[MV_NW] = gfx[MV_W];
	if (gfx[MV_SW].file.empty()) gfx[MV_SW] = gfx[MV_W];
	if (gfx[MV_NE].file.empty()) gfx[MV_NE] = gfx[MV_E];
	if (gfx[MV_SE].file.empty()) gfx[MV_SE] = gfx[MV_E];

	// Initialise the MV_IDLE entry too for safety, 
	// although it should never be called.
	gfx[MV_IDLE] = gfx[MV_S];
}

/*
 * Load animations.
 */
void tagSpriteAttr::loadAnimations(const bool bRenderFrames)
{
	for (std::vector<GFX_MAP>::iterator i = mapGfx.begin(); i != mapGfx.end(); ++i)
	{
		completeStances(*i);

		for (GFX_MAP::iterator j = i->begin(); j != i->end(); ++j)
		{
			// Enter the animation into the global shared animation vector.
			// If this animation is being used by another sprite,
			// they will share the same object.
			j->second.pAnm = CSharedAnimation::insert(j->second.file);
			if (j->second.pAnm && bRenderFrames) j->second.pAnm->m_pAnm->render();
		}
	}

	// Duplicate the idle animations as custom animations.
	mapCustomGfx[IDLE_E].file = mapGfx[GFX_IDLE][MV_E].file;
	mapCustomGfx[IDLE_SE].file = mapGfx[GFX_IDLE][MV_SE].file;
	mapCustomGfx[IDLE_S].file = mapGfx[GFX_IDLE][MV_S].file;
	mapCustomGfx[IDLE_SW].file = mapGfx[GFX_IDLE][MV_SW].file;
	mapCustomGfx[IDLE_W].file = mapGfx[GFX_IDLE][MV_W].file;
	mapCustomGfx[IDLE_NW].file = mapGfx[GFX_IDLE][MV_NW].file;
	mapCustomGfx[IDLE_N].file = mapGfx[GFX_IDLE][MV_N].file;
	mapCustomGfx[IDLE_NE].file = mapGfx[GFX_IDLE][MV_NE].file;

	for (GFX_CUSTOM_MAP::iterator j = mapCustomGfx.begin(); j != mapCustomGfx.end(); ++j)
	{
		j->second.pAnm = CSharedAnimation::insert(j->second.file);
		if (j->second.pAnm && bRenderFrames) j->second.pAnm->m_pAnm->render();
	}
}

/*
 * Free animations.
 */
void tagSpriteAttr::freeAnimations(void)
{
	// Free the map animations.
	for (std::vector<GFX_MAP>::iterator i = mapGfx.begin(); i != mapGfx.end(); ++i)
	{
		for (GFX_MAP::iterator j = i->begin(); j != i->end(); ++j)
		{
			CSharedAnimation::free(j->second.pAnm);
		}
	}

	for (GFX_CUSTOM_MAP::iterator j = mapCustomGfx.begin(); j != mapCustomGfx.end(); ++j)
	{
		CSharedAnimation::free(j->second.pAnm);
	}
} 

/*
 * Redundant in movement animations - to be modified for battle plugin.
 * Get a stance animation filename
 * (CommonPlayer playerGetStanceAnm and (CommonItem itemGetStanceAnm))
 */
STRING tagSpriteAttr::getStanceAnm(STRING stance)
{
	if (stance.empty())
	{
		stance = _T("WALK_S");
	}
	else
	{
		stance = parser::uppercase(stance);
	}

	if (stance == _T("STAND_S"))
	{
		return mapGfx[GFX_IDLE][MV_S].file;
	}
	else if (stance == _T("STAND_N"))
	{
		return mapGfx[GFX_IDLE][MV_N].file;
	}
	else if (stance == _T("STAND_E"))
	{
		return mapGfx[GFX_IDLE][MV_E].file;
	}
	else if (stance == _T("STAND_W"))
	{
		return mapGfx[GFX_IDLE][MV_W].file;
	}
	else if (stance == _T("STAND_NW"))
	{
		return mapGfx[GFX_IDLE][MV_NW].file;
	}
	else if (stance == _T("STAND_NE"))
	{
		return mapGfx[GFX_IDLE][MV_NE].file;
	}
	else if (stance == _T("STAND_SW"))
	{
		return mapGfx[GFX_IDLE][MV_SW].file;
	}
	else if (stance == _T("STAND_SE"))
	{
		return mapGfx[GFX_IDLE][MV_SE].file;
	}
	else if (stance == _T("WALK_S"))
	{
		return mapGfx[GFX_MOVE][MV_S].file;
	}
	else if (stance == _T("WALK_N"))
	{
		return mapGfx[GFX_MOVE][MV_N].file;
	}
	else if (stance == _T("WALK_E"))
	{
		return mapGfx[GFX_MOVE][MV_E].file;
	}
	else if (stance == _T("WALK_W"))
	{
		return mapGfx[GFX_MOVE][MV_W].file;
	}
	else if (stance == _T("WALK_NW"))
	{
		return mapGfx[GFX_MOVE][MV_NW].file;
	}
	else if (stance == _T("WALK_NE"))
	{
		return mapGfx[GFX_MOVE][MV_NE].file;
	}
	else if (stance == _T("WALK_SW"))
	{
		return mapGfx[GFX_MOVE][MV_SW].file;
	}
	else if (stance == _T("WALK_SE"))
	{
		return mapGfx[GFX_MOVE][MV_SE].file;
	}
	else if (stance == _T("FIGHT") || stance == _T("ATTACK"))
	{
		return mapCustomGfx[GFX_FIGHT].file;
	}
	else if (stance == _T("SPC") || stance == _T("SPECIAL MOVE"))
	{
		return mapCustomGfx[GFX_SPC].file;
	}
	return mapCustomGfx[stance].file;
}

void offset(DB_POINT *pts, const int size, const int x, const int y)
{
	for (int i = 0; i != size; ++i)
	{
		pts[i].x += x;
		pts[i].y += y;
	}
}

void tagSpriteAttr::defaultVector(DB_POINT *pts, const bool bIsometric, const bool bPixel, const bool bActivate)
{
	const int flags = (bIsometric ? 4:0) | (bPixel ? 2:0) | (bActivate ? 1:0);
	for (int i = 0; i != sizeof(spriteBases[flags]) / sizeof(DB_POINT); ++i)
		pts[i] = spriteBases[flags][i];
	offset(pts, 4, spriteBaseOffsets[flags].x, spriteBaseOffsets[flags].y);
}

/*
 * Create some default vectors for *old* versions of players, items.
 */
void tagSpriteAttr::createVectors(const int activationType)
{
	extern LPBOARD g_pBoard;

	// Activation vector depends on activation method.
	// For keypress, the activation vector must extend outside the base.
	// For step, the activation will be the base.
	
	// Clear the vectors.
	vBase = vActivate = CVector();

	DB_POINT pts[4];
	defaultVector(pts, g_pBoard->isIsometric(), CSprite::m_bPxMovement, false);
	vBase.push_back(pts, 4);
	vBase.close(true);

	defaultVector(pts, g_pBoard->isIsometric(), CSprite::m_bPxMovement, activationType & SPR_KEYPRESS);
	vActivate.push_back(pts, 4);
	vActivate.close(true);
}

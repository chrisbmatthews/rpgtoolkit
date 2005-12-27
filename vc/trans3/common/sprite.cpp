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
			if (bRenderFrames) j->second.pAnm->m_pAnm->render();
		}
	}

	for (GFX_CUSTOM_MAP::iterator j = mapCustomGfx.begin(); j != mapCustomGfx.end(); ++j)
	{
		j->second.pAnm = CSharedAnimation::insert(j->second.file);
		if (bRenderFrames) j->second.pAnm->m_pAnm->render();
	}
}

/*
 * Deconstructor
 */
tagSpriteAttr::~tagSpriteAttr()
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

void offset(DB_POINT pts[], const int size, const int x, const int y)
{
	for (int i = 0; i != size; ++i)
	{
		pts[i].x += x;
		pts[i].y += y;
	}
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

	if (g_pBoard->isIsometric())
	{
		// Referenced with origin at centre of an isometric tile.
		if (CSprite::m_bPxMovement)
		{
			const DB_POINT pts[] = {{-15, 0}, {0, 7}, {15, 0}, {0, -7}};
			vBase.push_back(pts, 4);
			vBase.close(true);

			if (activationType & SPR_KEYPRESS)
			{
				const DB_POINT pts[] = {{-31, 0}, {0, 15}, {15, 0}, {0, -31}};
				vActivate.push_back(pts, 4);
				vActivate.close(true);
			}
			else
			{
				vActivate = vBase;
			}
		}
		else
		{
			const DB_POINT pts[] = {{-31, 0}, {0, 15}, {31, 0}, {0, -15}};
			vBase.push_back(pts, 4);
			vBase.close(true);

			if (activationType & SPR_KEYPRESS)
			{
				// Create a one tile-wide ring around player.
				const DB_POINT pts[] = {{-95, 0}, {0, 47}, {95, 0}, {0, -47}};
				vActivate.push_back(pts, 4);
				vActivate.close(true);
			}
			else
			{
				vActivate = vBase;
			}
		} // if (pixel movement)

	}
	else
	{
		// Referenced with the origin at bottom-centre of tile.
		if (CSprite::m_bPxMovement)
		{
			// 1/2 height base for pixel movement (or other?).
			DB_POINT pts[] = {{0, 0}, {30, 0}, {30, 15}, {0, 15}};
			offset(pts, 4, -15, -15);
			vBase.push_back(pts, 4);
			vBase.close(true);

			if (activationType & SPR_KEYPRESS)
			{
				DB_POINT pts[] = {{0, 0}, {48, 0}, {48, 32}, {0, 32}};
				offset(pts, 4, -24, -24);
				vActivate.push_back(pts, 4);
				vActivate.close(true);
			}
			else
			{
				vActivate = vBase;
			}
		}
		else
		{
			DB_POINT pts[] = {{0, 0}, {30, 0}, {30, 30}, {0, 30}};
			offset(pts, 4, -15, -30);
			vBase.push_back(pts, 4);
			vBase.close(true);

			if (activationType & SPR_KEYPRESS)
			{
				// Create a one tile-wide ring around player.
				DB_POINT pts[] = {{0, 0}, {96, 0}, {96, 96}, {0, 96}};
				offset(pts, 4, -48, -48);
				vActivate.push_back(pts, 4);
				vActivate.close(true);
			}
			else
			{
				vActivate = vBase;
			}
		} // if (pixel movement)
	} // if (g_pBoard->isIsometric())
}

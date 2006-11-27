/*
 * All contents copyright 2003, 2004, 2005 Christopher Matthews or Contributors.
 * Various port optimizations copyright by Colin James Fitzpatrick, 2005.
 * All rights reserved. You may not remove this notice
 * Read license.txt for licensing details.
 */

/*
 * Inclusions.
 */
#include "../misc/misc.h"
#include "item.h"
#include "tilebitmap.h"
#include "animation.h"
#include "paths.h"
#include "CFile.h"
#include "mbox.h"
#include <sstream>

/*
 * Definitions.
 *
#define ITEM_WALK_S 0
#define ITEM_WALK_N 1
#define ITEM_WALK_E 2
#define ITEM_WALK_W 3
#define ITEM_WALK_NW 4
#define ITEM_WALK_NE 5
#define ITEM_WALK_SW 6
#define ITEM_WALK_SE 7
#define ITEM_REST 8

#define ITEM_GFX_UBOUND 9
#define ITEM_GFX_STANDING_UBOUND 7
*/

/*
 * Open an item. Return the minor version.
 */
short tagItem::open(const STRING fileName, SPRITE_ATTR *pAttr)
{
	// Allow opening outside of a CItem by creating a local SPRITE_ATTR.
	const bool bAttr = (pAttr == NULL);

	CFile file(fileName);

	if (!file.isOpen())
	{
		// FileExists check.
		messageBox(_T("File not found: ") + fileName);
		return 0;
	}

	itmAnimation = _T("");

	file.seek(13);
	char cVersion;
	file >> cVersion;
	if (cVersion)
	{
		messageBox(_T("Please save ") + fileName + _T(" in the editor!"));
		return 0;
	}
	file.seek(0);

	STRING fileHeader;
	file >> fileHeader;

	if (fileHeader != _T("RPGTLKIT ITEM"))
	{
		messageBox(_T("Unrecognised File Format! ") + fileName);
		return 0;
	}

	short majorVer, minorVer;
	file >> majorVer;
	file >> minorVer;

	file >> itemName;
	file >> itmDescription;
	file >> equipYN;
	file >> menuYN;
	file >> boardYN;
	file >> fightYN;
	file >> usedBy;

	itmChars.clear();
	unsigned int i;
	for (i = 0; i <= 50; i++)
	{
		STRING str;
		file >> str;
		itmChars.push_back(str);
	}

	if (minorVer >= 3)
	{
		file >> buyPrice;
		file >> sellPrice;
	}
	else
	{
		short buy, sell;
		file >> buy;
		file >> sell;
		buyPrice = buy;
		sellPrice = sell;
	}

	file >> keyItem;

	itemArmor.clear();
	for (i = 0; i <= 7; i++)
	{
		char cEnabled;
		file >> cEnabled;
		itemArmor.push_back(cEnabled);
	}

	file >> accessory;

	if (minorVer >= 3)
	{
		file >> equipHP;
		file >> equipDP;
		file >> equipFP;
		file >> equipSM;
	}
	else
	{
		short hp, dp, fp, sm;
		file >> hp;
		file >> dp;
		file >> fp;
		file >> sm;
		equipHP = hp;
		equipDP = dp;
		equipFP = fp;
		equipSM = sm;
	}

	file >> prgEquip;
	file >> prgRemove;

	if (minorVer >= 3)
	{
		file >> mnuHPup;
		file >> mnuSMup;
	}
	else
	{
		short hp, sm;
		file >> hp;
		file >> sm;
		mnuHPup = hp;
		mnuSMup = sm;
	}

	file >> mnuUse;

	if (minorVer >= 3)
	{
		file >> fgtHPup;
		file >> fgtSMup;
	}
	else
	{
		short hp, sm;
		file >> hp;
		file >> sm;
		fgtHPup = hp;
		fgtSMup = sm;
	}

	file >> fgtUse;
	file >> itmAnimation;
	file >> itmPrgOnBoard;
	file >> itmPrgPickUp;

	char itmSizeType;
	file >> itmSizeType;

	// Create local SPRITE_ATTR if none passed in. Create after opening tests.
	if (bAttr) pAttr = new SPRITE_ATTR();

	if (minorVer >= 4)
	{
		// Load standard graphics - saved in a different order!
		GFX_MAP gfx;
		gfx.clear();
		file >> gfx[MV_S].file;
		file >> gfx[MV_N].file;
		file >> gfx[MV_E].file;
		file >> gfx[MV_W].file;
		file >> gfx[MV_NW].file;
		file >> gfx[MV_NE].file;
		file >> gfx[MV_SW].file;
		file >> gfx[MV_SE].file;

		STRING strItemRest, strUnused;
		file >> strItemRest;				// Hold this for minorVer < 6.
		file >> strUnused;

		// Push graphics onto the gfx vector.
		// Map completed in loadAnimations().
		pAttr->mapGfx.clear();
		pAttr->mapGfx.push_back(gfx);

		gfx.clear();

		if (minorVer >= 5)
		{
			// Idle graphics - saved in a different order!
			file >> gfx[MV_S].file;
			file >> gfx[MV_N].file;
			file >> gfx[MV_E].file;
			file >> gfx[MV_W].file;
			file >> gfx[MV_NW].file;
			file >> gfx[MV_NE].file;
			file >> gfx[MV_SW].file;
			file >> gfx[MV_SE].file;

			file >> pAttr->speed;
			file >> pAttr->idleTime;
		}

		// Push idle graphics onto vector (empty for minorVer = 4).
		// Map completed in loadAnimations().
		pAttr->mapGfx.push_back(gfx);

		if (minorVer < 6)
		{
			pAttr->mapGfx[GFX_IDLE][MV_S].file = strItemRest;
		}

		// Custom stances - place in a map with handles as keys.
		int count;
		file >> count;

		for (i = 0; i <= count; i++)
		{
			STRING anim, handle;
			file >> anim;
			file >> handle;
			if (!handle.empty() && !anim.empty())
			{
				pAttr->mapCustomGfx[handle].file = anim;
			}
		}

		// Vector bases.
		if (minorVer >= 7)
		{
			short count = 0, pts = 0;
			int x = 0, y = 0, i = 0;

			// Number of vectors (= 2 for 3.0.7; provision for further.)
			file >> count;

			// Clear the vectors.
			pAttr->vBase = pAttr->vActivate = CVector();

			// Collision base first.
			file >> pts;
			for (i = 0; i <= pts; ++i)
			{
				file >> x;
				file >> y;
				pAttr->vBase.push_back(double(x), double(y));
			}
			pAttr->vBase.close(true);

			// Activation base.
			file >> pts;
			for (i = 0; i <= pts; ++i)
			{
				file >> x;
				file >> y;
				pAttr->vActivate.push_back(double(x), double(y));
			}
			pAttr->vActivate.close(true);
		}
		// Default vectors for non-vector items are created with their
		// board activation data information via CSprite::createVectors().
	}
	else // if (minorVer < 4)
	{
		GFX_MAP gfx;
		gfx.clear();

		unsigned int x, y;

		STRING itmWalkGfx[16][2], itmRestGfx[2];

		for (x = 0; x <= 15; x++)
		{
			for (y = 0; y <= 1; y++)
			{
				file >> itmWalkGfx[x][y];
			}
		}

		for (y = 0; y <= 1; y++)
		{
			file >> itmRestGfx[y];
		}

		extern STRING g_projectPath;

		ANIMATION anm;
		anm.pxWidth = 32;
		anm.pxHeight = 64;
		anm.delay = 0.167;

		int xx = 0;
		STRING walkFix = _T("S");

		for (x = 0; x <= 15; x++)
		{

			const STRING anmName = g_projectPath + MISC_PATH + replace(removePath(fileName), _T('.'), _T('_')) + _T("_walk_") + walkFix + _T("_") + _T(".anm");

			STRINGSTREAM ss;
			ss	<< g_projectPath << BMP_PATH << replace(removePath(fileName), _T('.'), _T('_')) << _T("_walk_")
				<< x << _T(".tbm");

			const STRING tbmName = ss.str();

			TILE_BITMAP tbm;
			tbm.resize(1, 2);
			for (y = 0; y <= 1; y++)
			{
				tbm.tiles[0][y] = itmWalkGfx[x][y];
			}
			tbm.save(tbmName);

			anm.frameFiles.push_back(removePath(tbmName));
			anm.transpColors.push_back(RGB(255, 255, 255));
			anm.sounds.push_back(_T(""));

			if (x == 3)
			{
				walkFix = _T("E");
				anm.save(anmName);
				gfx[MV_S].file = removePath(anmName);
				xx = -1;
			}
			else if (x == 7)
			{
				walkFix = _T("N");
				anm.save(anmName);
				gfx[MV_E].file = removePath(anmName);
				xx = -1;
			}
			else if (x == 11)
			{
				walkFix = _T("W");
				anm.save(anmName);
				gfx[MV_N].file = removePath(anmName);
				xx = -1;
			}
			else if (x == 15)
			{
				anm.save(anmName);
				gfx[MV_W].file = removePath(anmName);
				xx = -1;
			}
			if (xx++ == -1)
			{
				anm.frameFiles.clear();
				anm.transpColors.clear();
				anm.sounds.clear();
			}
		} // for (x)

		// Push graphics onto the gfx vector.
		// Map completed in loadAnimations().
		pAttr->mapGfx.clear();
		pAttr->mapGfx.push_back(gfx);

		/* Idle frame. */

		anm.frameFiles.clear();
		anm.transpColors.clear();
		anm.sounds.clear();

		const STRING anmName = g_projectPath + MISC_PATH + replace(removePath(fileName), _T('.'), _T('_')) + _T("_rest") + _T(".anm");
		const STRING tbmName = g_projectPath + BMP_PATH + replace(removePath(fileName), _T('.'), _T('_')) + _T("_rest") + _T(".tbm");

		TILE_BITMAP tbm;
		tbm.resize(1, 2);
		for (y = 0; y <= 1; y++)
		{
			tbm.tiles[0][y] = itmRestGfx[y];
		}
		tbm.save(tbmName);

		anm.frameFiles.push_back(removePath(tbmName));
		anm.transpColors.push_back(RGB(255, 255, 255));
		anm.sounds.push_back(_T(""));
		anm.save(anmName);

		gfx.clear();
		gfx[MV_S].file = removePath(anmName);

		// Push graphics onto the gfx vector.
		// Map completed in loadAnimations().
		pAttr->mapGfx.push_back(gfx);

	} // if (minorVer >= 4)

	// Clean up.
	if (bAttr) delete pAttr;
	return minorVer;
}

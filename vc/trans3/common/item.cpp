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
#include <sstream>

/*
 * Definitions.
 */
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

/*
 * Open an item.
 *
 * fileName (in) - file to open
 */
void tagItem::open(const std::string fileName)
{

	CFile file(fileName);

	itmAnimation = "";
	itmSizeType = 0;

	file.seek(13);
	char cVersion;
	file >> cVersion;
	if (cVersion)
	{
		MessageBox(NULL, ("Please save " + fileName + " in the editor!").c_str(), NULL, 0);
		return;
	}
	file.seek(0);

	std::string fileHeader;
	file >> fileHeader;

	if (fileHeader != "RPGTLKIT ITEM")
	{
		MessageBox(NULL, ("Unrecognised File Format! " + fileName).c_str(), "Open Item", 0);
		return;
	}

	short majorVer, minorVer;
	file >> majorVer;
	file >> minorVer;

	file >> itemName;
	file >> itmDescription;
	file >> EquipYN;
	file >> MenuYN;
	file >> BoardYN;
	file >> FightYN;
	file >> usedBy;

	itmChars.clear();
	unsigned int i;
	for (i = 0; i <= 50; i++)
	{
		std::string str;
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
		
	file >> itmSizeType;

	if (minorVer >= 4)
	{

		for (i = 0; i <= ITEM_GFX_UBOUND; i++)
		{
			file >> gfx[i];
		}

		if (minorVer >= 5)
		{
			for (i = 0; i <= ITEM_GFX_STANDING_UBOUND; i++)
			{
				file >> standingGfx[i];
			}
			file >> speed;
			file >> idleTime;
		}

		if (minorVer < 6)
		{
			standingGfx[ITEM_WALK_S] = gfx[ITEM_REST];
			gfx[ITEM_REST] = "";
		}

		customGfx.clear();
		customGfxNames.clear();

		int cnt;
		file >> cnt;
		for (i = 0; i <= cnt; i++)
		{
			std::string anim, handle;
			file >> anim;
			file >> handle;
			if (!handle.empty())
			{
				customGfx.push_back(anim);
				customGfxNames.push_back(handle);
			}
		}

	}
	else
	{

		unsigned int x, y;

		std::string itmWalkGfx[16][2], itmRestGfx[2];

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

		extern std::string g_projectPath;

		ANIMATION anm;
		anm.animSizeX = 32;
		anm.animSizeY = 64;
		anm.animPause = 0.167;

		int xx = 0;
		std::string walkFix = "S";

		for (x = 0; x <= 15; x++)
		{

			const std::string anmName = g_projectPath + MISC_PATH + replace(removePath(fileName), '.', '_') + "_walk_" + walkFix + "_" + ".anm";

			std::stringstream ss;
			ss	<< g_projectPath << BMP_PATH << replace(removePath(fileName), '.', '_') << "_walk_"
				<< x << ".tbm";

			const std::string tbmName = ss.str();

			TILE_BITMAP tbm;
			tbm.resize(1, 2);
			for (y = 0; y <= 1; y++)
			{
				tbm.tiles[0][y] = itmWalkGfx[x][y];
			}
			tbm.save(tbmName);

			anm.animFrame.push_back(removePath(tbmName));
			anm.animTransp.push_back(RGB(255, 255, 255));
			anm.animSound.push_back("");

			if (x == 3)
			{
				walkFix = "E";
				anm.save(anmName);
				gfx[ITEM_WALK_S] = removePath(anmName);
				xx = -1;
			}
			else if (x == 7)
			{
				walkFix = "N";
				anm.save(anmName);
				gfx[ITEM_WALK_E] = removePath(anmName);
				xx = -1;
			}
			else if (x == 11)
			{
				walkFix = "W";
				anm.save(anmName);
				gfx[ITEM_WALK_N] = removePath(anmName);
				xx = -1;
			}
			else if (x == 15)
			{
				anm.save(anmName);
				gfx[ITEM_WALK_W] = removePath(anmName);
				xx = -1;
			}
			if (xx++ == -1)
			{
				anm.animFrame.clear();
				anm.animTransp.clear();
				anm.animSound.clear();
			}
		}

		anm.animFrame.clear();
		anm.animTransp.clear();
		anm.animSound.clear();

		const std::string anmName = g_projectPath + MISC_PATH + replace(removePath(fileName), '.', '_') + "_rest" + ".anm";
		const std::string tbmName = g_projectPath + BMP_PATH + replace(removePath(fileName), '.', '_') + "_rest" + ".tbm";

		TILE_BITMAP tbm;
		tbm.resize(1, 2);
		for (y = 0; y <= 1; y++)
		{
			tbm.tiles[0][y] = itmRestGfx[y];
		}
		tbm.save(tbmName);

		anm.animFrame.push_back(removePath(tbmName));
		anm.animTransp.push_back(RGB(255, 255, 255));
		anm.animSound.push_back("");
		anm.save(anmName);

		standingGfx[ITEM_WALK_S] = removePath(anmName);
		itmSizeType = 1;

	}

}

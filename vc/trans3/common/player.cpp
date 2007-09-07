/*
 ********************************************************************
 * The RPG Toolkit, Version 3
 * This file copyright (C) 2006  Christopher Matthews & contributors
 *
 * Contributors:
 *    - Colin James Fitzpatrick
 *    - Jonathan D. Hughes
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
 *
 * Creating a game EXE using the Make EXE feature creates a 
 * derivative version of trans3 that includes the game's files. 
 * Therefore the EXE must be licensed under the GPL. However, as a 
 * special exception, you are permitted to license EXEs made with 
 * this feature under whatever terms you like, so long as 
 * Corresponding Source, as defined in the GPL, of the version 
 * of trans3 used to make the EXE is available separately under 
 * terms compatible with the Licence of this software and that you 
 * do not charge, aside from any price of the game EXE, to obtain 
 * these components.
 * 
 * If you publish a modified version of this Program, you may delete
 * these exceptions from its distribution terms, or you may choose
 * to propagate them.
 */

/*
 * Inclusions.
 */
#include "player.h"
#include "paths.h"
#include "CFile.h"
#include "mbox.h"
#include "../misc/misc.h"

/*
 * Definitions.
 */
#define PLYR_WALK_S 0
#define PLYR_WALK_N 1
#define PLYR_WALK_E 2
#define PLYR_WALK_W 3
#define PLYR_WALK_NW 4
#define PLYR_WALK_NE 5
#define PLYR_WALK_SW 6
#define PLYR_WALK_SE 7
#define PLYR_FIGHT 8
#define PLYR_DEFEND 9
#define PLYR_SPC 10
#define PLYR_DIE 11
#define PLYR_REST 12

/*
 * Open a player.
 *
 * fileName (in)	- file to open.
 * spriteAttr (in)	- common attributes that feed into CSprite.
 * short (out)		- minor version.
 */
short tagPlayer::open(const STRING fileName, SPRITE_ATTR &spriteAttr)
{
	CFile file(fileName);

	if (!file.isOpen())
	{
		// FileExists check.
		messageBox(_T("File not found: ") + fileName);
		return 0;
	}

	// Preserve subfolder to ensure loading from saved file.
	this->fileName = removePath(fileName, TEM_PATH);

	file.seek(13);
	char cVersion;
	file >> cVersion;
	file.seek(0);

	if (!cVersion)
	{

		STRING fileHeader;
		file >> fileHeader;
		if (fileHeader != _T("RPGTLKIT CHAR"))
		{
			messageBox(_T("Unrecognised File Format! ") + fileName);
			return 0;
		}

		short majorVer, minorVer;
		file >> majorVer;
		file >> minorVer;

		file >> charname;
		file >> experienceVar; replace(experienceVar, _T("!"), _T(""));
		file >> defenseVar; replace(defenseVar, _T("!"), _T(""));
		file >> fightVar; replace(fightVar, _T("!"), _T(""));
		file >> healthVar; replace(healthVar, _T("!"), _T(""));
		file >> maxHealthVar; replace(maxHealthVar, _T("!"), _T(""));
		file >> nameVar; replace(nameVar, _T("$"), _T(""));
		file >> smVar; replace(smVar, _T("!"), _T(""));
		file >> smMaxVar; replace(smMaxVar, _T("!"), _T(""));
		file >> leVar; replace(leVar, _T("!"), _T(""));
		file >> stats.experience;
		file >> stats.health;
		file >> stats.maxHealth;
		file >> stats.defense;
		file >> stats.fight;
		file >> stats.sm;
		file >> stats.smMax;
		file >> stats.level;
		file >> profilePic;

		unsigned int i;

		smlist.clear();
		spcMinExp.clear();
		spcMinLevel.clear();
		spcVar.clear();
		spcEquals.clear();
		for (i = 0; i <= 200; i++)
		{
			STRING str;
			int num;
			file >> str;
			smlist.push_back(str);
			file >> num;
			spcMinExp.push_back(num);
			file >> num;
			spcMinLevel.push_back(num);
			file >> str;
			spcVar.push_back(str);
			file >> str;
			spcEquals.push_back(str);
		}

		file >> specialMoveName;
		file >> smYN;

		accessoryName.clear();
		for (i = 0; i <= 10; i++)
		{
			STRING str;
			file >> str;
			accessoryName.push_back(str);
		}

		armorType.clear();
		for (i = 0; i <= 6; i++)
		{
			char chr;
			file >> chr;
			armorType.push_back(chr);
		}

		if (minorVer == 3)
		{
			char lev;
			file >> lev;
			levelType = lev;
		}
		else
		{
			file >> levelType;
		}

		file >> experienceIncrease;
		file >> maxLevel;
		file >> levelHp;
		file >> levelDp;
		file >> levelFp;
		file >> levelSm;

		STRING swipeWav, defendWav, smWav, deadWav;
		if (minorVer < 5)
		{
			file >> swipeWav;
			file >> defendWav;
			file >> smWav;
			file >> deadWav;
		}
        
		file >> charLevelUpRPGCode;
		file >> charLevelUpType;
		file >> charSizeType;
        
		if (minorVer >= 5)
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

			// Push graphics onto the gfx vector.
			// Map completed in loadAnimations().
			spriteAttr.mapGfx.clear();
			spriteAttr.mapGfx.push_back(gfx);

			// Store battle animations in the custom map with
			// pre-defined keys.
			spriteAttr.mapCustomGfx.clear();
			file >> spriteAttr.mapCustomGfx[GFX_FIGHT].file;
			file >> spriteAttr.mapCustomGfx[GFX_DEFEND].file;
			file >> spriteAttr.mapCustomGfx[GFX_SPC].file;
			file >> spriteAttr.mapCustomGfx[GFX_DIE].file;
			file >> spriteAttr.mapCustomGfx[GFX_REST].file;

			STRING strUnused;
			file >> strUnused;

			gfx.clear();

			if (minorVer >= 6)
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
			}

			// Push idle graphics onto vector. In the case minorVer = 5
			// push a set of blank strings onto the gfx vector.
			// Map completed in loadAnimations().
			spriteAttr.mapGfx.push_back(gfx);

			if (minorVer >= 7)
			{
				file >> spriteAttr.idleTime;
				file >> spriteAttr.speed;
			}
			// Defaults set in constructor.

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
					spriteAttr.mapCustomGfx[handle].file = anim;
				}
			}

			// Vector bases.
			if (minorVer >= 8)
			{
				short count = 0, pts = 0;
				int x = 0, y = 0, i = 0;

				// Number of vectors (= 2 for 3.1.0; provision for further.)
				file >> count;

				spriteAttr.vBase = spriteAttr.vActivate = CVector();

				// Collision base first.
				file >> pts;
				for (i = 0; i <= pts; ++i)
				{
					file >> x;
					file >> y;
					spriteAttr.vBase.push_back(double(x), double(y));
				}
				spriteAttr.vBase.close(true);

				// Activation base.
				file >> pts;
				for (i = 0; i <= pts; ++i)
				{
					file >> x;
					file >> y;
					spriteAttr.vActivate.push_back(double(x), double(y));
				}
				spriteAttr.vActivate.close(true);
			}
			else
			{
				spriteAttr.createVectors(SPR_STEP);
			}

			return minorVer;
		}
	}
	// Definitely don't need this.
	messageBox(_T("Please save ") + fileName + _T(" in the editor!"));
	return 0;
}

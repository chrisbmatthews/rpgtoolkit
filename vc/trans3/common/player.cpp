/*
 * All contents copyright 2003, 2004, 2005 Christopher Matthews or Contributors.
 * Various port optimizations copyright by Colin James Fitzpatrick, 2005.
 * All rights reserved. You may not remove this notice
 * Read license.txt for licensing details.
 */

/*
 * Inclusions.
 */
#include "player.h"
#include "CFile.h"

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
 * fileName (in) - file to open
 * spriteAttr (in) - common attributes that feed into CSprite.
 */
void tagPlayer::open(const std::string fileName, SPRITE_ATTR &spriteAttr)
{
	spriteAttr.vBase.push_back(1, 31);
	spriteAttr.vBase.push_back(31, 31);
	spriteAttr.vBase.push_back(31, 1);
	spriteAttr.vBase.close(4, true, 0);

	spriteAttr.vAction = spriteAttr.vBase;

	CFile file(fileName);

	file.seek(13);
	char cVersion;
	file >> cVersion;
	file.seek(0);

	if (!cVersion)
	{

		std::string fileHeader;
		file >> fileHeader;
		if (fileHeader != "RPGTLKIT CHAR")
		{
			MessageBox(NULL, ("Unrecognised File Format! " + fileName).c_str(), "Open Character", 0);
			return;
		}

		short majorVer, minorVer;
		file >> majorVer;
		file >> minorVer;

		file >> charname;
		file >> experienceVar;
		file >> defenseVar;
		file >> fightVar;
		file >> healthVar;
		file >> maxHealthVar;
		file >> nameVar;
		file >> smVar;
		file >> smMaxVar;
		file >> leVar;
		file >> initExperience;
		file >> initHealth;
		file >> initMaxHealth;
		file >> initDefense;
		file >> initFight;
		file >> initSm;
		file >> initSmMax;
		file >> initLevel;
		file >> profilePic;

		unsigned int i;

		smlist.clear();
		spcMinExp.clear();
		spcMinLevel.clear();
		spcVar.clear();
		spcEquals.clear();
		for (i = 0; i <= 200; i++)
		{
			std::string str;
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
			std::string str;
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

		std::string swipeWav, defendWav, smWav, deadWav;
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
        
/*
		if (minorVer >= 5)
		{
			spriteAttr.gfx.clear();
			// gfx.clear();
			for (i = 0; i <= UBOUND_GFX; i++)
			{
				// file >> gfx[i];
				std::string str;
				file >> str;
				// gfx.push_back(str);
				spriteAttr.gfx.push_back(str);
			}

			if (minorVer >= 6)
			{
				spriteAttr.standingGfx.clear();
				// standingGfx.clear();
				for (i = 0; i <= UBOUND_STANDING_GFX; i++)
				{
					// file >> standingGfx[i];
					std::string str;
					file >> str;
					// standingGfx.push_back(str);
					spriteAttr.standingGfx.push_back(str);
				}
			}
*/
		if (minorVer >= 5)
		{			
			// Load standard graphics - saved in a different order!
			GFX_MAP gfx;
			gfx.clear();
			file >> gfx[MV_S];
			file >> gfx[MV_N];
			file >> gfx[MV_E];
			file >> gfx[MV_W];
			file >> gfx[MV_NW];
			file >> gfx[MV_NE];
			file >> gfx[MV_SW];
			file >> gfx[MV_SE];

			// Complete diagonal directions with east/west graphics.
			spriteAttr.completeStances(gfx);

			// Push graphics onto the gfx vector.
			spriteAttr.mapGfx.clear();
			spriteAttr.mapGfx.push_back(gfx);

			// Store battle animations in the custom map with
			// pre-defined keys.
			spriteAttr.mapCustomGfx.clear();
			file >> spriteAttr.mapCustomGfx[GFX_FIGHT];
			file >> spriteAttr.mapCustomGfx[GFX_DEFEND];
			file >> spriteAttr.mapCustomGfx[GFX_SPC];
			file >> spriteAttr.mapCustomGfx[GFX_DIE];
			file >> spriteAttr.mapCustomGfx[GFX_REST];

			std::string strUnused;
			file >> strUnused;

			if (minorVer >= 6)
			{
				// Idle graphics - saved in a different order!
				gfx.clear();
				file >> gfx[MV_S];
				file >> gfx[MV_N];
				file >> gfx[MV_E];
				file >> gfx[MV_W];
				file >> gfx[MV_NW];
				file >> gfx[MV_NE];
				file >> gfx[MV_SW];
				file >> gfx[MV_SE];

				// Push idle graphics onto vector.
				spriteAttr.completeStances(gfx);
				spriteAttr.mapGfx.push_back(gfx);
			}

			if (minorVer >= 7)
			{
				file >> spriteAttr.idleTime;	// file >> idleTime;
				file >> spriteAttr.speed;		// file >> speed;
			}

			// Custom stances - place in a map with handles as keys.
			int count;
			file >> count;
//			spriteAttr.customGfx.clear();		// customGfx.clear();
//			spriteAttr.customGfxNames.clear();	// customGfxNames.clear();
			for (i = 0; i <= count; i++)
			{
				std::string anim, handle;
				file >> anim;
				file >> handle;
				if (!handle.empty() && !anim.empty())
				{
//					spriteAttr.customGfx.push_back(anim);			// customGfx.push_back(anim);
//					spriteAttr.customGfxNames.push_back(handle);	// customGfxNames.push_back(handle);
					spriteAttr.mapCustomGfx[handle] = anim;
				}
			}
			return;
		}
	}
	// Definitely don't need this.
	MessageBox(NULL, ("Please save " + fileName + " in the editor!").c_str(), NULL, 0);
}


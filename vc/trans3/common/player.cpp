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
 */
void tagPlayer::open(const std::string fileName)
{

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
        
		if (minorVer >= 5)
		{

			// gfx.clear();
			for (i = 0; i <= UBOUND_GFX; i++)
			{
				file >> gfx[i];
				// std::string str;
				// file >> str;
				// gfx.push_back(str);
			}

			if (minorVer >= 6)
			{
				// standingGfx.clear();
				for (i = 0; i <= UBOUND_STANDING_GFX; i++)
				{
					file >> standingGfx[i];
					// std::string str;
					// file >> str;
					// standingGfx.push_back(str);
				}
			}

			if (minorVer >= 7)
			{
				file >> idleTime;
				file >> speed;
			}
			else
			{
				idleTime = 3.0;
				speed = 0.05;
			}

			int cnt;
			file >> cnt;
			customGfx.clear();
			customGfxNames.clear();
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
			return;
		}
	}
	// Definitely don't need this.
	MessageBox(NULL, ("Please save " + fileName + " in the editor!").c_str(), NULL, 0);
}

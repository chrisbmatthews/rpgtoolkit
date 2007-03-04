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
 */

/*
 * Inclusions.
 */
#include "mainfile.h"
#include "CFile.h"
#include "mbox.h"
#include "../movement/CPathFind/CPathFind.h"
#define DIRECTINPUT_VERSION DIRECTINPUT_HEADER_VERSION
#include <dinput.h>

/*
 * Constructor.
 */
tagMainFile::tagMainFile(): 
	drawVectors(NULL), 
	movementControls(MF_USE_KEYS | MF_ALLOW_DIAGONALS) 
{
	// Default to cursor keys for movement keys.
	movementKeys.clear();
	movementKeys.push_back(DIK_RIGHT);	// MV_E
	movementKeys.push_back(0);			// MV_SE
	movementKeys.push_back(DIK_DOWN);	// MV_S
	movementKeys.push_back(0);			// MV_SW
	movementKeys.push_back(DIK_LEFT);	// MV_W
	movementKeys.push_back(0);			// MV_NW
	movementKeys.push_back(DIK_UP);		// MV_N
	movementKeys.push_back(0);			// MV_NE

	pathColor = RGB(255, 255, 255);
}

/*
 * Open a main file.
 *
 * fileName (in) - file to open
 */
bool tagMainFile::open(const STRING fileName)
{

	CFile file(fileName);

	if (!file.isOpen())
	{
		// FileExists check.
		messageBox(_T("File not found: ") + fileName);
		return false;
	}

	STRING fileHeader;
	file >> fileHeader;
	if (fileHeader != "RPGTLKIT MAIN")
	{
		messageBox(_T("Unrecognised File Format! ") + fileName);
		return false;
	}

	this->filename = fileName;

	short majorVer, minorVer;
	file >> majorVer;
	file >> minorVer;

	int iUnused;
	STRING strUnused;
	file >> iUnused;
	file >> strUnused;

	extern STRING g_projectPath, g_pakTempPath;
	file >> g_projectPath;
	if (!g_pakTempPath.empty())
	{
		g_projectPath = _T("");
	}

	file >> gameTitle;
	file >> mainScreenType;
	file >> extendToFullScreen;
	file >> mainResolution;

	if (minorVer < 3)
	{
		file >> iUnused;
	}

	file >> mainDisableProtectReg;

	file >> strUnused; // Language file.

	file >> startupPrg;
	file >> initBoard;
	file >> initChar;

	runTimeKeys.clear();
	runTimePrg.clear();

	HKL hkl = GetKeyboardLayout(0);

	STRING runTime; short runKey;
	file >> runTime;
	file >> runKey;
	runKey = MapVirtualKeyEx(toupper(runKey), 0, hkl);

	if (!runTime.empty())
	{
		runTimeKeys.push_back(runKey);
		runTimePrg.push_back(runTime);
	}

	file >> menuKey;
	menuKey = MapVirtualKeyEx(toupper(menuKey), 0, hkl);
	file >> key;
	key = MapVirtualKeyEx(toupper(key), 0, hkl);

	short len;
	file >> len;
	unsigned int i;
	for (i = 0; i <= len; i++)
	{
		short sUnused;
		file >> sUnused;
		sUnused = MapVirtualKeyEx(toupper(sUnused), 0, hkl);
		file >> strUnused;
		if (!strUnused.empty())
		{
			runTimeKeys.push_back(sUnused);
			runTimePrg.push_back(strUnused);
		}
	}

	if (minorVer >= 3)
	{
		file >> menuPlugin;
		file >> fightPlugin;
	}
	else
	{
		file >> iUnused;
		menuPlugin = _T("tk3menu.dll");
		fightPlugin = _T("tk3fight.dll");
	}

	if (minorVer <= 2)
	{
		file >> iUnused;
		short sUnused;
		file >> sUnused;
	}

	file >> fightGameYn;

	file >> len;
	enemy.clear();
	skills.clear();
	for (i = 0; i <= len; i++)
	{
		file >> strUnused;
		enemy.push_back(strUnused);
		short sUnused;
		file >> sUnused;
		skills.push_back(sUnused);
	}

	file >> fightType;
	file >> chances;
	file >> fprgYn;
	file >> fightPrg;

	if (minorVer < 3)
	{
		short sUnused;
		file >> sUnused;
	}

	file >> gameOverPrg;
	file >> skinButton;
	file >> skinWindow;

	file >> len;
	plugins.clear();
	if (minorVer <= 2)
	{
		for (i = 0; i <= len; i++)
		{
			short sEnabled;
			file >> sEnabled;
			if (sEnabled)
			{
				STRINGSTREAM ss;
				ss << _T("tkplug") << i << _T(".dll");
				plugins.push_back(ss.str());
			}
		}
	}
	else
	{
		for (i = 0; i <= len; i++)
		{
			STRING plugin;
			file >> plugin;
			plugins.push_back(plugin);
		}
	}

	file >> mainUseDayNight;
	file >> mainDayNightType;
	file >> mainDayLength;

	if (minorVer >= 3)
	{
		file >> cursorMoveSound;
		file >> cursorSelectSound;
		file >> cursorCancelSound;
		file >> useJoystick;
		file >> colorDepth;
	}

	if (minorVer >= 4)
	{
		file >> gameSpeed;
		file >> pixelMovement;
	}
	else
	{
		gameSpeed = 0;
		pixelMovement = 0;
	}

	if (minorVer < 8)
	{
		setGameSpeed(gameSpeed);
	}

	if (minorVer < 6)
	{
		if (minorVer == 5)
		{
			char cEnabled;
			file >> cEnabled;
			mouseCursor = cEnabled ? _T("TK DEFAULT") : _T("");
		}
		else
		{
			mouseCursor = _T("TK DEFAULT");
		}
		hotSpotX = 0;
		hotSpotY = 0;
	}
	else
	{
		file >> mouseCursor;
		file >> hotSpotX;
		file >> hotSpotY;
		file >> transpColor;
	}

	if (mouseCursor == _T("TK DEFAULT"))
	{
		transpColor = RGB(255, 0, 0);
	}

	if (minorVer >= 7)
	{
		file >> resX;
		file >> resY;
	}

	if (minorVer >= 8)
	{
		file >> bFpsInTitleBar;
	}

	pfHeuristic = PF_DIAGONAL;			// Pre-vector tile pathfinding.
	if (minorVer >= 9)
	{
		file >> pfHeuristic;
		file >> drawVectors;
		file >> pathColor;
		file >> movementControls;

		movementKeys.clear();
		short scanCode = 0;

		// (This loop would be infinite if using a MV_ENUM.)
		for (int i = MV_MIN; i <= MV_MAX; ++i)
		{
			// DIK_ = scan code.
			file >> scanCode;
			movementKeys.push_back(scanCode);
		}
	}

	return true;
}

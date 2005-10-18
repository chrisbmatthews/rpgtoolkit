/*
 * All contents copyright 2003, 2004, 2005 Christopher Matthews or Contributors.
 * Various port optimizations copyright by Colin James Fitzpatrick, 2005.
 * All rights reserved. You may not remove this notice
 * Read license.txt for licensing details.
 */

/*
 * Inclusions.
 */
#include "mainfile.h"
#include "CFile.h"
#include "mbox.h"

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

	short majorVer, minorVer;
	file >> majorVer;
	file >> minorVer;

	int iUnused;
	STRING strUnused;
	file >> iUnused;
	file >> strUnused;

	extern STRING g_projectPath;
	file >> g_projectPath;

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

	file >> runTime;

	// Get these into scan codes.
	HKL hkl = GetKeyboardLayout(0);
	file >> runKey; runKey = MapVirtualKeyEx(runKey, 0, hkl);
	file >> menuKey; menuKey = MapVirtualKeyEx(menuKey, 0, hkl);
	file >> key; key = MapVirtualKeyEx(key, 0, hkl);

	short len;
	file >> len;
	runTimeKeys.clear();
	runTimePrg.clear();
	unsigned int i;
	for (i = 0; i <= len; i++)
	{
		short sUnused;
		file >> sUnused; sUnused = MapVirtualKeyEx(sUnused, 0, hkl);
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

	return true;
}

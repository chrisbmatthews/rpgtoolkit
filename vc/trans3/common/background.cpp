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
#include "background.h"
#include "tilebitmap.h"
#include "paths.h"
#include "CFile.h"
#include "mbox.h"
#include "../misc/misc.h"

/*
 * Open a background.
 *
 * fileName (in) - file to open
 */
void tagBackground::open(const STRING fileName)
{

	CFile file(fileName);

	char cUnused;
	file.seek(12);
	file >> cUnused;
	file.seek(0);
	if (!cUnused)
	{

		STRING fileHeader;
		file >> fileHeader;
		if (fileHeader != _T("RPGTLKIT BKG"))
		{
			messageBox(_T("Unrecognised File Format! ") + fileName);
			return;
		}

		short majorVer, minorVer;
		file >> majorVer;
		file >> minorVer;

		file >> image;
		file >> bkgMusic;
		file >> bkgSelWav;
		file >> bkgChooseWav;
		file >> bkgReadyWav;
		file >> bkgCantDoWav;

	}
	else
	{

		if (file.line() != _T("RPGTLKIT BKG"))
		{
			messageBox(_T("Unrecognised File Format! ") + fileName);
			return;
		}

		const short majorVer = _ttoi(file.line().c_str());
		const short minorVer = _ttoi(file.line().c_str());

		TILE_BITMAP tbm;
		tbm.width = 19;
		tbm.height = 19;

		unsigned int i, j;
		for (i = 0; i < 19; i++)
		{
			tbm.tiles.push_back(std::vector<STRING>());
			for (j = 0; j < 19; j++)
			{
				tbm.tiles.back().push_back(file.line());
			}
		}
 
		bkgMusic = file.line();
		bkgSelWav = file.line();
		bkgChooseWav = file.line();
		bkgReadyWav = file.line();
		bkgCantDoWav = file.line();

		file.line();

		for (i = 0; i < 19; i++)
		{
			tbm.red.push_back(std::vector<short>());
			tbm.green.push_back(std::vector<short>());
			tbm.blue.push_back(std::vector<short>());
			for (j = 0; j < 19; j++)
			{
				tbm.red.back().push_back(_ttoi(file.line().c_str()));
				tbm.green.back().push_back(_ttoi(file.line().c_str()));
				tbm.blue.back().push_back(_ttoi(file.line().c_str()));
			}
		}

		STRING noPath = removePath(fileName);
		replace(noPath, ".", "_");
		const STRING tbmFile = noPath + _T(".tbm");
		image = tbmFile;
		extern STRING g_projectPath;
		tbm.save(g_projectPath + BMP_PATH + tbmFile);

	}

}

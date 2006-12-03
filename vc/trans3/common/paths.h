/*
 ********************************************************************
 * The RPG Toolkit, Version 3
 * This file copyright (C) 2006  Colin James Fitzpatrick
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

#ifndef _TK_PATHS_H_
#define _TK_PATHS_H_

/*
 * Inclusions
 */
#include "../../tkCommon/strings.h"

/*
 * Path definitions.
 */
#define GAME_PATH _T("Game\\")				// Game dir.
#define TILE_PATH _T("Tiles\\")				// Tile dir path.
#define BRD_PATH _T("Boards\\")				// Board dir path.
#define TEM_PATH _T("Chrs\\")				// Character dir path.
#define ARC_PATH _T("Archives\\")			// Archive dir path.
#define SPC_PATH _T("SpcMove\\")			// Spc move path.
#define BKG_PATH _T("Bkrounds\\")			// Bkg path.
#define MEDIA_PATH _T("Media\\")			// Media path.
#define PRG_PATH _T("Prg\\")				// Prg path.
#define FONT_PATH _T("Font\\")				// Font path.
#define ITM_PATH _T("Item\\")				// Item path.
#define ENE_PATH _T("Enemy\\")				// Enemy path.
#define GAM_PATH _T("Main\\")				// Main file path.
#define BMP_PATH _T("Bitmap\\")				// Bmp file path.
#define STATUS_PATH _T("StatusE\\")			// Status effect.
#define HELP_PATH _T("Help\\")				// Help file path.
#define HASH_PATH _T("Hash\\")				// Hash file path.
#define MISC_PATH _T("Misc\\")				// Misc file path.
#define RESOURCE_PATH _T("Resources\\")		// Resource file path.
#define PLUG_PATH _T("Plugin\\")			// Plugin path.

/*
 * Remove the path from a filename.
 *
 * str (in) - filename
 * preserveFrom (in) - default folder to preserve subfolders within
 * return (out) - pathless filename
 */
STRING removePath(const STRING str);
STRING removePath(const STRING str, const STRING preserveFrom);

/*
 * Get the extension of a file.
 *
 * str (in) - file to check
 * return (out) - extension
 */
inline STRING getExtension(const STRING str)
{
	const int dot = str.find_last_of(_T('.'));
	return (dot == -1) ? _T("") : str.substr(dot + 1);
}

/*
 * Add the extension of a file if not present.
 */
inline STRING addExtension(const STRING file, const STRING ext)
{
	if (_ftcsicmp(getExtension(file).c_str(), ext.c_str()) != 0)
	{
		return (file + _T('.') + ext);
	}
	return file;
}

// Resolve a file name.
extern STRING (*resolve)(const STRING path);

// Toggle file resolution.
// MUST be set at least once, lest trans3 should crash.
void setResolve(const bool bPak);

// Detect whether we are a standalone game.
bool isStandaloneGame();

// Initialise a pak file.
bool initialisePakFile(const STRING file);

// Uninitialise a pak file.
void uninitialisePakFile();

#endif

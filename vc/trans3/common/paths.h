/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
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
 * return (out) - pathless filename
 */
inline STRING removePath(const STRING str)
{
	return str.substr(str.find_last_of(_T('\\')) + 1);
}

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

// Resolve a file name.
extern STRING (*resolve)(const STRING path);

// Toggle file resolution.
// MUST be set at least once, lest trans3 should crash.
void setResolve(const bool bPak);

#endif

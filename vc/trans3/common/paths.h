/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

#ifndef _TK_PATHS_H_
#define _TK_PATHS_H_

/*
 * Inclusions/
 */
#include <string>

/*
 * Path definitions.
 */
#define GAME_PATH "Game\\"				// Game dir.
#define TILE_PATH "Tiles\\"				// Tile dir path.
#define BRD_PATH "Boards\\"				// Board dir path.
#define TEM_PATH "Chrs\\"				// Character dir path.
#define ARC_PATH "Archives\\"			// Archive dir path.
#define SPC_PATH "SpcMove\\"			// Spc move path.
#define BKG_PATH "Bkrounds\\"			// Bkg path.
#define MEDIA_PATH "Media\\"			// Media path.
#define PRG_PATH "Prg\\"				// Prg path.
#define FONT_PATH "Font\\"				// Font path.
#define ITM_PATH "Item\\"				// Item path.
#define ENE_PATH "Enemy\\"				// Enemy path.
#define GAM_PATH "Main\\"				// Main file path.
#define BMP_PATH "Bitmap\\"				// Bmp file path.
#define STATUS_PATH "StatusE\\"			// Status effect.
#define HELP_PATH "Help\\"				// Help file path.
#define HASH_PATH "Hash\\"				// Hash file path.
#define MISC_PATH "Misc\\"				// Misc file path.
#define RESOURCE_PATH "Resources\\"		// Resource file path.
#define PLUG_PATH "Plugin\\"			// Plugin path.

/*
 * Remove the path from a filename.
 *
 * str (in) - filename
 * return (out) - pathless filename
 */
std::string removePath(const std::string str);

/*
 * Get the extension of a file.
 *
 * str (in) - file to check
 * return (out) - extension
 */
std::string getExtension(const std::string str);

#endif

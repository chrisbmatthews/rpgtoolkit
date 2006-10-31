/*
 * All contents copyright 2003, 2004, 2005 Christopher Matthews or Contributors.
 * Various port optimizations copyright by Colin James Fitzpatrick, 2005.
 * All rights reserved. You may not remove this notice
 * Read license.txt for licensing details.
 */

#ifndef _MAIN_FILE_H_
#define _MAIN_FILE_H_

/*
 * Inclusions.
 */
#include "../../tkCommon/strings.h"
#include <vector>

/*
 * Defines.
 */
enum
{
	MF_MOVE_TILE,
	MF_MOVE_PIXEL,
	MF_PUSH_PIXEL
};

typedef enum tagMovementControls
{
	MF_USE_KEYS = 1,
	MF_USE_MOUSE = 2,
	MF_ALLOW_DIAGONALS = 4

} MF_MOVEMENT_CONTROLS;

/*
 * A main file.
 */
typedef struct tagMainFile
{
    STRING gameTitle;					// Title of game.
    short mainScreenType;				// Screen type 2=windowed (GDI), 1=DirectX, 0- DirectX (not used)
    short extendToFullScreen;			// Extend screen to maximum extents  (0=no, 1=yes)
    short mainResolution;				// Resolution to use for optimal res 0=640x480, 1=800x600, 2=1024x768
    short mainDisableProtectReg;		// Disable protect registered files (0=no, 1=yes)
    STRING startupPrg;					// Start up program.
    STRING initBoard;					// Initial board.
    STRING initChar;					// Initial character.
    short menuKey;						// Ascii code of menu key.
	short key;							// Ascii code of general run key.
    std::vector<short> runTimeKeys;		// 50 extended run time keys.
    std::vector<STRING> runTimePrg;		// 50 extended run time programs.
    STRING menuPlugin;					// The main menu plugin.
    STRING fightPlugin;					// The fighting plugin.
    short fightGameYn;					// Fighting in game? 0-yes, 1-no
    std::vector<STRING> enemy;			// List of 500 enemy files 0-500
    std::vector<short> skills;			// List of enemy skill levels.
    short fightType;					// Fight type: 0-random, 1- planned.
    int chances;						// Chances of getting in fight (1 in x) OR number of steps to take.
    short fprgYn;						// Use alt fight program YN 0-no, 1-yes.
    STRING fightPrg;					// Program to run for fighting.
    STRING gameOverPrg;					// Game over program.
    STRING skinButton;					// Skin's button graphic.
    STRING skinWindow;					// Skin's window graphic.
    std::vector<STRING> plugins;		// Plugin list to use.
    short mainUseDayNight;				// Game is affected by day and night 0=no, 1=yes.
    short mainDayNightType;				// Day/night type: 0=real world, 1=set time.
    int mainDayLength;					// Day length, in minutes.
    STRING cursorMoveSound;				// Sound played when cursor moves.
    STRING cursorSelectSound;			// Sound played when cursor selects.
    STRING cursorCancelSound;			// Sound played when cursor cancels.
    char useJoystick;					// Allow joystick input? 0- no 1- yes
    char colorDepth;					// Colour depth.
    char pixelMovement;					// Pixel movement (1 / 0).
    STRING mouseCursor;					// Mouse cursor to use.
    char hotSpotX;						// X hot spot on mouse.
    char hotSpotY;						// Y hot spot on mouse.
    int transpColor;					// Transparent colour on cursor.
    int resX;							// Custom x resolution.
    int resY;							// Custom y resolution.
    char bFpsInTitleBar;				// Show FPS in the title bar?

	// 3.0.7:
	short startX;						// Coordinates for the player to start from,
	short startY;						// moved from tagBoard.
	short startL;
	short pfHeuristic;					// Default heuristic for pathfinding.
	int drawVectors;					// Draw board vectors? See CV_DRAW_VECTORS.
	int pathColor;						// Selected player path and destination colour.
	int movementControls;				// See MF_MOVEMENT_CONTROLS
	std::vector<short> movementKeys;	// Keyboard controls (scan codes / DIKs), ordered from MV_MIN to MV_MAX.

	int getGameSpeed() const { return gameSpeed - 128; }
	void setGameSpeed(const int gs) { gameSpeed = gs + 128; }
	bool open(const STRING fileName);
	STRING getFilename(void) const { return filename; }
	tagMainFile();

private:
    unsigned char gameSpeed;			// Speed at which game runs.
	STRING filename;
} MAIN_FILE;

#endif

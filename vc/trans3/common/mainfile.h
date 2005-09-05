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
#include <string>
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

/*
 * A main file.
 */
typedef struct tagMainFile
{
    std::string gameTitle;				// Title of game.
    short mainScreenType;				// Screen type 2=windowed (GDI), 1=DirectX, 0- DirectX (not used)
    short extendToFullScreen;			// Extend screen to maximum extents  (0=no, 1=yes)
    short mainResolution;				// Resolution to use for optimal res 0=640x480, 1=800x600, 2=1024x768
    short mainDisableProtectReg;		// Disable protect registered files (0=no, 1=yes)
    std::string startupPrg;				// Start up program.
    std::string initBoard;				// Initial board.
    std::string initChar;				// Initial character.
    std::string runTime;				// Run time program.
    short runKey;						// Ascii code of run time key.
    short menuKey;						// Ascii code of menu key.
	short key;							// Ascii code of general run key.
    std::vector<short> runTimeKeys;		// 50 extended run time keys.
    std::vector<std::string> runTimePrg;// 50 extended run time programs.
    std::string menuPlugin;				// The main menu plugin.
    std::string fightPlugin;			// The fighting plugin.
    short fightGameYn;					// Fighting in game? 0-yes, 1-no
    std::vector<std::string> enemy;		// List of 500 enemy files 0-500
    std::vector<short> skills;			// List of enemy skill levels.
    short fightType;					// Fight type: 0-random, 1- planned.
    int chances;						// Chances of getting in fight (1 in x) OR number of steps to take.
    short fprgYn;						// Use alt fight program YN 0-no, 1-yes.
    std::string fightPrg;				// Program to run for fighting.
    std::string gameOverPrg;			// Game over program.
    std::string skinButton;				// Skin's button graphic.
    std::string skinWindow;				// Skin's window graphic.
    std::vector<std::string> plugins;	// Plugin list to use.
    short mainUseDayNight;				// Game is affected by day and night 0=no, 1=yes.
    short mainDayNightType;				// Day/night type: 0=real world, 1=set time.
    int mainDayLength;					// Day length, in minutes.
    std::string cursorMoveSound;		// Sound played when cursor moves.
    std::string cursorSelectSound;		// Sound played when cursor selects.
    std::string cursorCancelSound;		// Sound played when cursor cancels.
    char useJoystick;					// Allow joystick input? 0- no 1- yes
    char colorDepth;					// Colour depth.
    char pixelMovement;					// Pixel movement (1 / 0).
    std::string mouseCursor;			// Mouse cursor to use.
    char hotSpotX;						// X hot spot on mouse.
    char hotSpotY;						// Y hot spot on mouse.
    int transpColor;					// Transparent colour on cursor.
    int resX;							// Custom x resolution.
    int resY;							// Custom y resolution.
    char bFpsInTitleBar;				// Show FPS in the title bar?
	int getGameSpeed(void) { return gameSpeed - 128; }
	void setGameSpeed(const int gs) { gameSpeed = gs + 128; }
	bool open(const std::string fileName);
private:
    char gameSpeed;						// Speed at which game runs.
} MAIN_FILE;

#endif

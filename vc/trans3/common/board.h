/*
 * All contents copyright 2003, 2004, 2005 Christopher Matthews or Contributors.
 * Various port optimizations copyright by Colin James Fitzpatrick, 2005.
 * All rights reserved. You may not remove this notice
 * Read license.txt for licensing details.
 */

#ifndef _BOARD_H_
#define _BOARD_H_

/*
 * Inclusions.
 */
#include "tileanim.h"
#include <string>
#include <vector>

/*
 * A board's tile animation.
 */
typedef struct tagBoardTileAnim
{
	TILEANIM tile;
	int x, y, z;
} BOARD_TILEANIM;

/*
 * A board.
 */
typedef struct tagBoard
{
	short bSizeX;									// Board size x.
	short bSizeY;									// Board size y.
	short bSizeL;									// Board size layer.
	std::vector<std::string> tileIndex;				// Lookup table for tiles.
	typedef std::vector<short> VECTOR_SHORT;
	typedef std::vector<VECTOR_SHORT> VECTOR_SHORT2D;
	std::vector<VECTOR_SHORT2D> board;				// Board tiles -- codes indicating where the tiles are on the board.
	std::vector<VECTOR_SHORT2D> ambientRed;			// Ambient tile red.
	std::vector<VECTOR_SHORT2D> ambientGreen;		// Ambient tile green.
	std::vector<VECTOR_SHORT2D> ambientBlue;		// Ambient tile blue.
	typedef std::vector<char> VECTOR_CHAR;
	typedef std::vector<VECTOR_CHAR> VECTOR_CHAR2D;
	std::vector<VECTOR_CHAR2D> tiletype;			// Tile types 0- Normal, 1- solid 2- Under, 3- NorthSouth normal, 4- EastWest Normal, 11- Elevate to level 1, 12- Elevate to level 2... 18- Elevate to level 8.
	std::string brdBack;							// Board background img (parallax layer).
	int brdBackCNV;									// Canvas holding the background image.
	std::string brdFore;							// Board foreground image (parallax).
	std::string borderBack;							// Border background img.
	int brdColor;									// Board color.
	int borderColor;								// Border color.
	short ambientEffect;							// BoardList(activeBoardIndex).ambient effect applied to the board 0- none, 1- fog, 2- darkness, 3- watery.
	std::vector<std::string> dirLink;				// Direction links 1- N, 2- S, 3- E, 4-W.
	short boardSkill;								// Board skill level.
	std::string boardBackground;					// Fighting background.
	short fightingYN;								// Fighting on boardYN (1- yes, 0- no).
	short BoardDayNight;							// Board is affected by day/night? 0=no, 1=yes.
	short BoardNightBattleOverride;					// Use custom battle options at night? 0=no, 1=yes.
	short BoardSkillNight;							// Board skill level at night.
	std::string BoardBackgroundNight;				// Fighting background at night.
	std::vector<short> brdConst;					// Board Constants (1-10).
	std::string boardMusic;							// Background music file.
	std::vector<std::string> boardTitle;			// Board title (layer).
	std::vector<std::string> programName;			// Board program filenames.
	std::vector<short> progX;						// Program x.
	std::vector<short> progY;						// Program y.
	std::vector<short> progLayer;					// Program layer.
	std::vector<std::string> progGraphic;			// Program graphic.
	std::vector<short> progActivate;				// Program activation: 0- always active, 1- conditional activation.
	std::vector<std::string> progVarActivate;		// Activation variable.
	std::vector<std::string> progDoneVarActivate;	// Activation variable at end of prg.
	std::vector<std::string> activateInitNum;		// Initial number of activation.
	std::vector<std::string> activateDoneNum;		// What to make variable at end of activation.
	std::vector<short> activationType;				// Activation type- 0-step on, 1- conditional (activation key).
	std::string enterPrg;							// Program to run on entrance.
	std::string bgPrg;								// Background program.
	std::vector<std::string> itmName;				// Filenames of items.
	std::vector<short> itmX;						// X coord.
	std::vector<short> itmY;						// Y coord.
	std::vector<short> itmLayer;					// Layer coord.
	std::vector<short> itmActivate;					// Itm activation: 0- always active, 1- conditional activation.
	std::vector<std::string> itmVarActivate;		// Activation variable.
	std::vector<std::string> itmDoneVarActivate;	// Activation variable at end of itm.
	std::vector<std::string> itmActivateInitNum;	// Initial number of activation.
	std::vector<std::string> itmActivateDoneNum;	// What to make variable at end of activation.
	std::vector<short> itmActivationType;			// Activation type- 0-step on, 1- conditional (activation key).
	std::vector<std::string> itemProgram;			// Program to run when item is touched.
	std::vector<std::string> itemMulti;				// Multitask program for item.
	short playerX;									// Player x ccord.
	short playerY;									// Player y coord.
	short playerLayer;								// Player layer coord.
	short brdSavingYN;								// Can player save on board? 0-yes, 1-no.
	char isIsometric;								// Is it an isometric board? (0- no, 1-yes).
	std::vector<std::string> threads;				// Filenames of threads on board.
	bool hasAnmTiles;								// Does board have anim tiles?
	std::vector<BOARD_TILEANIM> animatedTile;		// Animated tiles associated with this board.
	std::vector<int> anmTileLUTIndices;				// Indices into LUT of animated tiles.
	int anmTileLUTInsertIdx;						// Index of LUT table insertion.
	std::string strFilename;						// Filename of the board.
	void open(const std::string fileName);
	void addAnimTile(const std::string fileName, const int x, const int y, const int z);
	void setSize(const int width, const int height, const int depth);
} BOARD;

#endif

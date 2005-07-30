/*
 * All contents copyright 2003, 2004, 2005 Christopher Matthews or Contributors.
 * Various port optimizations copyright by Colin James Fitzpatrick, 2005.
 * All rights reserved. You may not remove this notice
 * Read license.txt for licensing details.
 */

#ifndef _BOARD_H_
#define _BOARD_H_

struct tagBoard;
typedef struct tagBoard BOARD, *LPBOARD;

#include "../movement/CVector/CVector.h"
#include "../movement/movement.h"
#include <string>
#include <vector>

/*
 * A board-set program.
 */
#define PRG_STEP		0				// Triggers once until player leaves area.
#define PRG_KEYPRESS	1				// Player must hit activation key.
#define PRG_REPEAT		2				// Triggers repeatedly after a certain distance or
										// can only be triggered after a certain distance.

#define PRG_ACTIVE		0				// Program is always active.
#define PRG_CONDITIONAL	1				// Program's running depends on RPGCode variables.

typedef struct tagBoardProgram
{
	std::string fileName;				// Board program filename.
//	short x;							// Co-ordinates.
//	short y;							
	short layer;						// Layer.
	std::string graphic;				// Associated graphic.
	short activate;						// PRG_ACTIVE - always active.
										// PRG_CONDITIONAL - conditional activation.
	std::string initialVar;				// Activation variable.
	std::string finalVar;				// Activation variable at end of prg.
	std::string initialValue;			// Initial value of activation variable.
	std::string finalValue;				// Value of variable after program runs.
	short activationType;				// Activation type: (flags)
										// PRG_STEP - walk in vector.
										// PRG_KEYPRESS - hit general activation key inside vector.
										// PRG_REPEAT - Whether player must leave vector to before
										//				program can retrigger or not.

	CVector vBase;						// The activation area.
	double distanceRepeat;				// Distance to travel between activations within the vector.
	double distance;					// Distance travelled within vector since last run.

	tagBoardProgram():
		activate(PRG_ACTIVE),			// Always active.
		activationType(PRG_STEP),		// Step on (once).
		distanceRepeat(0),
		distance(0),
		layer(1),
		vBase() {};						// Do not define any points yet.

} BRD_PROGRAM, *LPBRD_PROGRAM;

// Tile-type attributes.
#define TA_BRD_BACKGROUND		1		// Under vector uses background image.
#define TA_ALL_LAYERS_BELOW		2		// Under vector applies to all layers below.

typedef struct tagBoardVector
{
	int layer;
	CGDICanvas *pCnv;
	CVector *pV;
	TILE_TYPE type;
	int attributes;						// Various attributes for each tile type.
										// TT_STAIRS: layer to move to.
										// TT_UNDER:  TA_BRD_BACKGROUND
										//			  TA_ALL_LAYERS_BELOW

	tagBoardVector():
		layer(0),
		pCnv(NULL),
		pV(),
		type(TT_SOLID) {};

} BRD_VECTOR;

// Vector indices for .dirLink member (only used in CSprite::send())
typedef enum tagDirectionalLinks
{
	LK_NONE = -1,
	LK_N,
	LK_S,
	LK_E,
	LK_W
} LK_ENUM;

#include "../movement/CItem/CItem.h"
#include "tileanim.h"

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
	typedef std::vector<VECTOR_SHORT2D> VECTOR_SHORT3D;
	VECTOR_SHORT3D board;							// Board tiles -- codes indicating where the tiles are on the board.
	VECTOR_SHORT3D ambientRed;						// Ambient tile red.
	VECTOR_SHORT3D ambientGreen;					// Ambient tile green.
	VECTOR_SHORT3D ambientBlue;						// Ambient tile blue.
	typedef std::vector<char> VECTOR_CHAR;
	typedef std::vector<VECTOR_CHAR> VECTOR_CHAR2D;
	std::vector<VECTOR_CHAR2D> tiletype;			// Tile types 0- Normal, 1- solid 2- Under, 3- NorthSouth normal, 4- EastWest Normal, 11- Elevate to level 1, 12- Elevate to level 2... 18- Elevate to level 8.
	std::string brdBack;							// Board background img (parallax layer).
	std::string brdFore;							// Board foreground image (parallax).
	std::string borderBack;							// Border background img.
	int brdColor;									// Board color.
	int borderColor;								// Border color.
	short ambientEffect;							// BoardList(activeBoardIndex).ambient effect applied to the board 0- none, 1- fog, 2- darkness, 3- watery.
	std::vector<std::string> dirLink;				// Direction links 1- N, 2- S, 3- E, 4-W.
	short boardSkill;								// Board skill level.
	std::string boardBackground;					// Fighting background.
	short fightingYN;								// Fighting on boardYN (1- yes, 0- no).
	short boardDayNight;							// Board is affected by day/night? 0=no, 1=yes.
	short boardNightBattleOverride;					// Use custom battle options at night? 0=no, 1=yes.
	short boardSkillNight;							// Board skill level at night.
	std::string boardBackgroundNight;				// Fighting background at night.
	std::vector<short> brdConst;					// Board Constants (1-10).
	std::string boardMusic;							// Background music file.
	std::vector<std::string> boardTitle;			// Board title (layer).

	std::vector<LPBRD_PROGRAM> programs;

	std::string enterPrg;							// Program to run on entrance.
	std::string bgPrg;								// Background program.

	// Delano:	These should be in the player's file.
	// Colin:	I prefer the main file. You can only
	//			have one starting position per game.
	// Delano:  Even better.
	short playerX;									// Player x ccord.
	short playerY;									// Player y coord.
	short playerLayer;								// Player layer coord.

	short brdSavingYN;								// Can player save on board? 0-yes, 1-no.
//	char isIsometric;								// Superseded by coordType.
	std::vector<std::string> threads;				// Filenames of threads on board.

	// Animated tiles.
	bool hasAnmTiles;								// Does board have anim tiles?
	std::vector<BOARD_TILEANIM> animatedTile;		// Animated tiles associated with this board.
	std::vector<int> anmTileLUTIndices;				// Indices into LUT of animated tiles.

	std::string strFilename;						// Filename of the board.
	std::vector<BRD_VECTOR> vectors;				// Vectors.
	std::vector<CItem *> items;						// Items.

	COORD_TYPE coordType;							// Co-ordinate system type.
	std::vector<bool> bLayerOccupied;				// Do layers contain tiles?

	bool open(const std::string fileName);
	void vectorize(const unsigned int layer);
	void createVectorCanvases(void);
	void freeVectors(void);
	void freePrograms(void);
	void freeItems(void);
	void addAnimTile(const std::string fileName, const int x, const int y, const int z);
	void setSize(const int width, const int height, const int depth);

	void render(CGDICanvas *cnv,
			   const int destX, const int destY,		// canvas destination.
			   const int lLower, const int lUpper, 
			   int topX, int topY,						// pixel location on board to start from. 
			   const int width, const int height,		// pixel dimensions to draw. 
			   const int aR, const int aG, const int aB);


	bool isIsometric(void) { return (coordType & (ISO_STACKED | ISO_ROTATED)); };
	// Board dimensions in pixels.
	int pxWidth (void);
	int pxHeight(void);

	tagBoard(void): coordType(TILE_NORMAL) { }
	~tagBoard(void) { freeVectors(); freePrograms(); freeItems(); }

private:
	tagBoard &operator=(tagBoard &rhs);
	tagBoard(tagBoard &rhs);
} BOARD, *LPBOARD;

#endif

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

#include "../../tkCommon/strings.h"
#include "../movement/CVector/CVector.h"
#include "../movement/movement.h"
#include <string>
#include <vector>

/*
 * A board-set program.
 */
#define PRG_STEP			0			// Triggers once until player leaves area.
#define PRG_KEYPRESS		1			// Player must hit activation key.
#define PRG_REPEAT			2			// Triggers repeatedly after a certain distance or
										// can only be triggered after a certain distance.
#define PRG_STOPS_MOVEMENT	4			// Running the program clears the movement queue.

#define PRG_ACTIVE			0			// Program is always active.
#define PRG_CONDITIONAL		1			// Program's running depends on RPGCode variables.

typedef struct tagBoardProgram
{
	STRING fileName;				// Board program filename.
//	short x;							// Co-ordinates.
//	short y;							
	short layer;						// Layer.
	STRING graphic;				// Associated graphic.
	short activate;						// PRG_ACTIVE - always active.
										// PRG_CONDITIONAL - conditional activation.
	STRING initialVar;				// Activation variable.
	STRING finalVar;				// Activation variable at end of prg.
	STRING initialValue;			// Initial value of activation variable.
	STRING finalValue;				// Value of variable after program runs.
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
#define TA_RECT_INTERSECT		4		// Under vector activated by bounding rect intersection.

/*
 * A board vector collision object.
 */
typedef struct tagBoardVector
{
	int layer;
	CCanvas *pCnv;
	CVector *pV;
	TILE_TYPE type;
	int attributes;						// Various attributes for each tile type.
										// TT_STAIRS: layer to move to.
										// TT_UNDER:  TA_BRD_BACKGROUND
										//			  TA_ALL_LAYERS_BELOW

	tagBoardVector():
		layer(0),
		pCnv(NULL),
		pV(NULL),
		type(TT_SOLID) {};

	void createCanvas(BOARD &board);

} BRD_VECTOR, *LPBRD_VECTOR;

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
 * Possible board image treatments.
 */
typedef enum tagBoardImageEnum
{
	BI_NORMAL,
	BI_PARALLAX,
	BI_STRETCH
} BI_ENUM;

/*
 * An image placed on a layer at a location.
 */
typedef struct tagBoardImage
{
	BI_ENUM type;						// Drawing option.
	STRING file;
	int layer;
	CCanvas *pCnv;
	RECT r;								// Board pixel co-ordinates.
	DB_POINT scroll;					// Scrolling factors (x,y).
	LONG transpColor;					// Transparent colour on the image.

	tagBoardImage():
		type(BI_NORMAL), 
		file(STRING()), 
		layer(1), 
		pCnv(NULL),
		transpColor(TRANSP_COLOR)
		{ r.left = r.right = r.top = r.bottom = 0; };

	void createCanvas(BOARD &board);

} BRD_IMAGE, *LPBRD_IMAGE;

/*
 * A board's tile animation.
 */
typedef struct tagBoardTileAnim
{
	TILEANIM tile;
	int x, y, z;
} BOARD_TILEANIM;

// Struct to temporarily hold locations for old items, programs.
typedef struct tagObjPosition
{
	short x, y, layer, version;
} OBJ_POSITION, *LPOBJ_POSITION;

/*
 * A board.
 */
typedef struct tagBoard
{
	short bSizeX;									// Board size x.
	short bSizeY;									// Board size y.
	short bSizeL;									// Board size layer.	
	std::vector<STRING> tileIndex;				// Lookup table for tiles.
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
	STRING brdBack;							// Board background img (parallax layer).
	STRING brdFore;							// Board foreground image (parallax).
	STRING borderBack;							// Border background img.
	int brdColor;									// Board color.
	int borderColor;								// Border color.
	short ambientEffect;							// BoardList(activeBoardIndex).ambient effect applied to the board 0- none, 1- fog, 2- darkness, 3- watery.
	std::vector<STRING> dirLink;				// Direction links 1- N, 2- S, 3- E, 4-W.
	short boardSkill;								// Board skill level.
	STRING boardBackground;					// Fighting background.
	short fightingYN;								// Fighting on boardYN (1- yes, 0- no).
	short boardDayNight;							// Board is affected by day/night? 0=no, 1=yes.
	short boardNightBattleOverride;					// Use custom battle options at night? 0=no, 1=yes.
	short boardSkillNight;							// Board skill level at night.
	STRING boardBackgroundNight;				// Fighting background at night.
	std::vector<short> brdConst;					// Board Constants (1-10).
	STRING boardMusic;							// Background music file.
	std::vector<STRING> boardTitle;			// Board title (layer).

	std::vector<LPBRD_PROGRAM> programs;

	STRING enterPrg;							// Program to run on entrance.
	STRING bgPrg;								// Background program.

	// Delano:	These should be in the player's file.
	// Colin:	I prefer the main file. You can only
	//			have one starting position per game.
	// Delano:  Even better.
	short playerX;									// Player x ccord.
	short playerY;									// Player y coord.
	short playerLayer;								// Player layer coord.

	short brdSavingYN;								// Can player save on board? 0-yes, 1-no.
//	char isIsometric;								// Superseded by coordType.
	std::vector<CThread *> threads;					// Threads on board.

	// Animated tiles.
	bool hasAnmTiles;								// Does board have anim tiles?
	std::vector<BOARD_TILEANIM> animatedTile;		// Animated tiles associated with this board.
	std::vector<int> anmTileLUTIndices;				// Indices into LUT of animated tiles.

	STRING strFilename;						// Filename of the board.
	std::vector<BRD_VECTOR> vectors;				// Vectors.
	std::vector<CItem *> items;						// Items.

	COORD_TYPE coordType;							// Co-ordinate system type.
	std::vector<bool> bLayerOccupied;				// Do layers contain tiles?

	/* Either keep the background image separate or put it
	   on the front of images. */
	LPBRD_IMAGE bkgImage;
	std::vector<LPBRD_IMAGE> images;

	bool open(const STRING fileName);
	void vectorize(const unsigned int layer);
	void createVectorCanvases();
	void freeVectors(const int layer = 0);
	void freePrograms();
	void freeItems();
	void freeImages();
	void freeThreads();
	void addAnimTile(const STRING fileName, const int x, const int y, const int z);
	void setSize(const int width, const int height, const int depth);

	void render(CCanvas *cnv,
			   const int destX, const int destY,		// canvas destination.
			   const int lLower, const int lUpper, 
			   int topX, int topY,						// pixel location on board to start from. 
			   const int width, const int height,		// pixel dimensions to draw. 
			   const int aR, const int aG, const int aB);

	void renderBackground(CCanvas *cnv, RECT bounds);

	bool isIsometric() const { return (coordType & (ISO_STACKED | ISO_ROTATED)); };
	// Board dimensions in pixels.
	inline int pxWidth ();
	inline int pxHeight();

	void createProgramBase(LPBRD_PROGRAM pPrg, LPOBJ_POSITION pObj) const;
	const BRD_VECTOR *getVectorFromTile(const int x, const int y, const int z) const;

	bool hasProgram(LPBRD_PROGRAM p) const;

	tagBoard(): coordType(TILE_NORMAL), bkgImage(NULL) { }
	~tagBoard() { freeVectors(); freePrograms(); freeItems(); freeImages(); freeThreads(); }

private:
	tagBoard &operator=(tagBoard &rhs);
	tagBoard(tagBoard &rhs);
} BOARD, *LPBOARD;

#endif

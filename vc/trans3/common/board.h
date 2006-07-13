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
class CItem;
class CThread;

#include "../../tkCommon/movement/board conversion.h"
#include "../../tkCommon/movement/coords.h"
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
	STRING fileName;					// Board program filename.
	short layer;						// Layer.
	STRING graphic;						// Associated graphic.
	short activate;						// PRG_ACTIVE - always active.
										// PRG_CONDITIONAL - conditional activation.
	STRING initialVar;					// Activation variable.
	STRING finalVar;					// Activation variable at end of prg.
	STRING initialValue;				// Initial value of activation variable.
	STRING finalValue;					// Value of variable after program runs.
	short activationType;				// Activation type (see 1st set of flags above).

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
										// TT_UNDER:  see TA_ above.

	tagBoardVector():
		attributes(0),
		layer(0),
		pCnv(NULL),
		pV(NULL),
		type(TT_SOLID) {};

	void createCanvas(BOARD &board);

} BRD_VECTOR, *LPBRD_VECTOR;

// Vector indices for links member (only used in CSprite::send())
typedef enum tagDirectionalLinks
{
	LK_NONE = -1,
	LK_N,
	LK_S,
	LK_E,
	LK_W
} LK_ENUM;

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
		layer(0), 
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
	std::vector<int> lutIndices;	// Indices of frames in board Lut.

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
	typedef std::vector<short> VECTOR_SHORT;
	typedef std::vector<VECTOR_SHORT> VECTOR_SHORT2D;
	typedef std::vector<VECTOR_SHORT2D> VECTOR_SHORT3D;
	typedef std::vector<char> VECTOR_CHAR;
	typedef std::vector<VECTOR_CHAR> VECTOR_CHAR2D;

	short sizeX;									// x-tile dimension.
	short sizeY;									// y-tile dimension.
	short sizeL;									// Layers.	
	COORD_TYPE coordType;							// Co-ordinate system type.

	std::vector<STRING> tileIndex;					// Lookup table for tiles.
	VECTOR_SHORT3D board;							// Board tiles indices.
	VECTOR_SHORT3D ambientRed;						// Ambient tile red.
	VECTOR_SHORT3D ambientGreen;					// Ambient tile green.
	VECTOR_SHORT3D ambientBlue;						// Ambient tile blue.

	std::vector<CItem *> items;						// Items.
	std::vector<LPBRD_IMAGE> images;				// Layered images.
	std::vector<LPBRD_PROGRAM> programs;			// Programs.
	std::vector<CThread *> threads;					// Threads on board.
	std::vector<BRD_VECTOR> vectors;				// Collision vectors.

	std::vector<STRING> constants;					// Constants.
	std::vector<STRING> layerTitles;				// Board title (layer).
	std::vector<STRING> links;						// Board edge links.
													// 0: N, 1: S, 2: E, 3: W.

	LPBRD_IMAGE bkgImage;							// Background image.
	int bkgColor;									// Background color.
	STRING bkgMusic;								// Background music file.

	STRING enterPrg;								// Program to run on entrance.
	STRING battleBackground;						// Fighting background.
	short battleSkill;								// Random enemy skill level.
	bool bAllowBattles;								// Random fighting allowed?
	bool bDisableSaving;							// Is saving disabled on board?
	short ambientEffect;							// Ambient effect applied to the board.
													// 0: none, 1: fog, 2: darkness, 3: watery.

	std::vector<CVector *> paths;					// Board-defined paths that can be
													// assigned to sprites.

	// Pre-vector boards only.
	std::vector<VECTOR_CHAR2D> tiletype;			// Note order: [z][y][x]

	/* Volatile data */

	std::vector<bool> bLayerOccupied;				// Do layers contain tiles?

	std::vector<BOARD_TILEANIM> animatedTiles;		// Animated tiles associated with this board.

	STRING strFilename;								// Filename of the board.

	/* Member functions */

	bool open(const STRING fileName);
	void vectorize(const unsigned int layer);
	void createVectorCanvases();
	void freeVectors(const int layer = 0);
	void freePrograms();
	void freeItems();
	void freeImages();
	void freeThreads();
	void freePaths();
	bool hasProgram(LPBRD_PROGRAM p) const;
	int pxWidth() const;
	int pxHeight() const;
	bool insertTile(const STRING tile, const int x, const int y, const int z);
	void setSize(const int width, const int height, const int depth);
	bool isIsometric() const { return (coordType & (ISO_STACKED | ISO_ROTATED)); };
	void createProgramBase(LPBRD_PROGRAM pPrg, LPOBJ_POSITION pObj) const;
	const BRD_VECTOR *getVectorFromTile(const int x, const int y, const int z) const;

	void render(
		CCanvas *cnv,
		int destX, 			// canvas destination.
		const int destY,
		const int lLower, 	// layer bounds. 
		const int lUpper,
		int topX,			// pixel location on board to start from. 
		int topY,
		int width, 			// pixel dimensions to draw. 
		int height,
		const int aR, 
		const int aG, 
		const int aB
	);
	void renderBackground(CCanvas *cnv, RECT bounds);
	void renderAnimatedTiles(SCROLL_CACHE &scrollCache);

	tagBoard(): coordType(TILE_NORMAL), bkgImage(NULL) { }
	~tagBoard() { freeVectors(); freePrograms(); freeItems(); freeImages(); freeThreads(); freePaths(); }

private:
	tagBoard &operator=(tagBoard &rhs);
	tagBoard(tagBoard &rhs);
	void addAnimTile(const STRING fileName, const int x, const int y, const int z);
	int lutIndex(const STRING tile);
	int tileWidth() const { return (isIsometric() ? 64 : 32); }
	int tileHeight() const { return (isIsometric() ? 16 : 32); }
	void renderImages(
		CCanvas *cnv, 
		const int destX,
		const int destY,
		const RECT bounds, 
		const int layer
	);
	void renderStack(
		CCanvas *cnv,
		const int destX,	// canvas destination.
		const int destY,
		const int lLower, 	// layer bounds. 
		const int lUpper,
		const int x,		// tile location on board to draw. 
		const int y,
		const RECT bounds,
		const int aR, 
		const int aG, 
		const int aB
	);

} BOARD, *LPBOARD;

#endif

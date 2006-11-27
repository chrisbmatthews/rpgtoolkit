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
typedef struct tagStackFrame STACK_FRAME, *LPSTACK_FRAME;

#include "../../tkCommon/board/conversion.h"
#include "../../tkCommon/board/coords.h"
#include "../../tkCommon/board/lighting.h"
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
	STRING handle;

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

// Flags for tagBoard::bLayerOccupied.
typedef enum tagLayerOccupied
{
	LO_NONE,
	LO_TILES,
	LO_IMAGES
} LO_ENUM;

inline LO_ENUM operator|= (const LO_ENUM lhs, const LO_ENUM rhs)
{
	return LO_ENUM(lhs | rhs);
}

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

} BOARD_TILEANIM, *LPBOARD_TILEANIM;

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

	int sizeX;										// x-tile dimension.
	int sizeY;										// y-tile dimension.
	int sizeL;										// Layers.	
	COORD_TYPE coordType;							// Co-ordinate system type.

	std::vector<STRING> tileIndex;					// Lookup table for tiles.
	VECTOR_SHORT3D board;							// Board tiles indices.
	
	std::vector<LPLAYER_SHADE> tileShading;			// Tile shading array (old ambientRed, -Green, -Blue arrays)							

	// There is currently no need to store the lights permanently
	// since they cannot be altered once applied.
	// std::vector<LPBRD_LIGHT> lights;				// Dynamic lighting objects (spotlight, gradient).

	std::vector<CItem *> items;						// Items.
	std::vector<LPBRD_IMAGE> images;				// Layered images.
	std::vector<LPBRD_PROGRAM> programs;			// Programs.
	std::vector<CThread *> threads;					// Threads on board.
	std::vector<BRD_VECTOR> vectors;				// Collision vectors.

	std::vector<STRING> constants;					// Constants.
	std::vector<STRING> layerTitles;				// Board title (layer).
	std::vector<STRING> links;						// Board edge links. LK_ENUM

	LPBRD_IMAGE bkgImage;							// Background image.
	int bkgColor;									// Background color.
	STRING bkgMusic;								// Background music file.

	STRING enterPrg;								// Program to run on entrance.
	STRING battleBackground;						// Fighting background.
	short battleSkill;								// Random enemy skill level.
	bool bAllowBattles;								// Random fighting allowed?
	bool bDisableSaving;							// Is saving disabled on board?
	RGB_SHORT ambientEffect;						// Ambient effect applied to the board.

	std::vector<CVector *> paths;					// Board-defined paths that can be
													// assigned to sprites.

	// Pre-vector boards only.
	std::vector<VECTOR_CHAR2D> tiletype;			// Note order: [z][y][x]

	/* Volatile data */

	std::vector<int> bLayerOccupied;				// Do layers contain tiles or images? (see LO_ENUM)
	
	std::vector<BOARD_TILEANIM> animatedTiles;		// Animated tiles associated with this board.

	STRING filename;								// Filename of the board.

	/* Member functions */

	bool open(const STRING fileName, const bool startThreads = true);
	void vectorize(const unsigned int layer);
	void createImageCanvases();
	void createVectorCanvases();
	void freeVectors(const int layer = 0);
	void freePrograms();
	void freeItems();
	void freeImages();
	void freeThreads();
	void freePaths();
	void freeShading();
	bool hasProgram(LPBRD_PROGRAM p) const;
	int pxWidth() const;
	int pxHeight() const;
	bool insertTile(const STRING tile, const int x, const int y, const int z);
	bool isIsometric() const { return (coordType & (ISO_STACKED | ISO_ROTATED)); };
	void createProgramBase(LPBRD_PROGRAM pPrg, LPOBJ_POSITION pObj) const;
	const BRD_VECTOR *getVectorFromTile(const int x, const int y, const int z) const;
	LPBRD_VECTOR getVector(const LPSTACK_FRAME pParam);
	LPBRD_PROGRAM getProgram(const unsigned int index);

	void render(
		CCanvas *const cnv,
		int destX, 			// canvas destination.
		const int destY,
		const int lLower, 	// layer bounds. 
		const int lUpper,
		int topX,			// pixel location on board to start from. 
		int topY,
		int width, 			// pixel dimensions to draw. 
		int height
	);
	void renderBackground(CCanvas *const cnv, const RECT bounds);
	void renderAnimatedTiles(SCROLL_CACHE &scrollCache);

	tagBoard(): coordType(TILE_NORMAL), bkgImage(NULL) { }
	~tagBoard() { freeVectors(); freePrograms(); freeItems(); freeImages(); freeThreads(); freePaths(); freeShading(); }

private:
	tagBoard &operator=(tagBoard &rhs);
	tagBoard(tagBoard &rhs);
	LPBOARD_TILEANIM addAnimTile(const STRING fileName, const int x, const int y, const int z);
	int lutIndex(const STRING tile);
	void setSize(const int width, const int height, const int depth, const bool createTiletypeArray);
	int tileWidth() const { return (isIsometric() ? 64 : 32); }
	int tileHeight() const { return (isIsometric() ? 16 : 32); }
	void renderImages(
		CCanvas *const cnv, 
		const int destX,
		const int destY,
		const RECT bounds, 
		const int layer
	);
	void renderStack(
		CCanvas *const cnv,
		const int destX,	// canvas destination.
		const int destY,
		const int lLower, 	// layer bounds. 
		const int lUpper,
		const int x,		// tile location on board to draw. 
		const int y,
		const RECT bounds
	);

} BOARD, *LPBOARD;

#endif

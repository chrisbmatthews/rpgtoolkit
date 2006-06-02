//--------------------------------------------------------------------------
// All contents copyright 2004 - 2006 
// Colin James Fitzpatrick & Jonathan D. Hughes
// All rights reserved. YOU MAY NOT REMOVE THIS NOTICE.
// Read LICENSE.txt for licensing info
//--------------------------------------------------------------------------

//--------------------------------------------------------------------------
// Board drawing routines
//--------------------------------------------------------------------------

//--------------------------------------------------------------------------
// Protect the header
//--------------------------------------------------------------------------
#ifndef _CBOARD_H_
#define _CBOARD_H_
#pragma once

//--------------------------------------------------------------------------
// Inclusions
//--------------------------------------------------------------------------
#include <vector>
#include <set>
#define WIN32_MEAN_AND_LEAN			// Obtain lean version of windows
#include <windows.h>				// Windows headers
#include <string>					// String class
#include "stdafx.h"
#include "../../tkCommon/strings.h"
#include "../../tkCommon/movement/coords.h"

//--------------------------------------------------------------------------
// Definitions
//--------------------------------------------------------------------------
#if !defined(INLINE) && !defined(FAST_CALL)
#	if defined(_MSC_VER)
#		define INLINE __inline		// VC++ prefers the __inline keyword
#		define FAST_CALL __fastcall
#	else
#		define INLINE inline
#		define FAST_CALL			// Register (fast) calls are specific to VC++
#	endif
#endif
#if !defined(CNV_HANDLE)
typedef INT CNV_HANDLE;
#endif

class CCanvas;
class CBoard;

#pragma pack(4) // Align UDTs to 4-byte packing for VB.

//--------------------------------------------------------------------------
// An image placed on a layer.
//--------------------------------------------------------------------------
typedef struct tagVBBoardImage
{
	LONG drawType;						// Drawing option.
	LONG layer;
	RECT bounds;						// Board pixel co-ordinates.
	LONG transpColor;					// Transparent colour on the image.
	CCanvas *pCnv;
	DOUBLE scrollx;						// Scrolling factors (x,y).
	DOUBLE scrolly;
	BSTR file;

	void draw(
		CONST CCanvas &cnv, 
		CONST RECT screen, 
		CONST LONG brdWidth, 
		CONST LONG brdHeight
	);

	CCanvas *render(
		CONST STRING projectPath, 
		CONST HDC hdcCompat
	);

} VB_BRDIMAGE, *LPVB_BRDIMAGE;

typedef struct tagVBBoard
{
	//
	// Attributes of a board - most are unused
	// but (obviously) required to be here.
	//
	// 3.0.7
	SHORT m_coordType;
	VB_BRDIMAGE m_bkgImage;				// Background image.
	LPSAFEARRAY m_images;				// Array of tagVBBoardImages

	// Pre 3.0.7
	SHORT m_bSizeX;						// Board size x
	SHORT m_bSizeY;						// Board size y
	SHORT m_bSizeL;						// Board size layer
	LPSAFEARRAY m_tileIndex;			// Lookup table for tiles
	LPSAFEARRAY m_board;				// Board tiles - codes indicating where the tiles are on the board
	LPSAFEARRAY m_ambientRed;			// Ambient tile red
	LPSAFEARRAY m_ambientGreen;			// Ambient tile green
	LPSAFEARRAY m_ambientBlue;			// Ambient tile blue
	LPSAFEARRAY m_tileType;				// Tile types 0- Normal, 1- solid 2- Under, 3- NorthSouth normal, 4- EastWest Normal, 11- Elevate to level 1, 12- Elevate to level 2... 18- Elevate to level 8
	BSTR m_brdBack;						// Board background img (parallax layer)
	INT m_brdBackCnv;					// Canvas holding the background image
	BSTR m_brdFore;						// Board foreground image (parallax)
	BSTR m_borderBack;					// Border background img
	INT m_brdColor;						// Board color
	INT m_borderColor;					// Border color
	SHORT m_ambientEffect;				// Ambient effect applied to the board
	LPSAFEARRAY m_dirLink;				// Direction links 1- N, 2- S, 3- E, 4-W
	SHORT m_boardSkilll;				// Board skill level
	BSTR m_boardBackground;				// Fighting background
	SHORT m_fightingYN;					// Fighting on boardYN (1- yes, 0- no)
	SHORT m_dayNight;					// Board is affected by day/night? 0=no, 1=yes
	SHORT m_nightBattleOverride;		// Sse custom battle options at night? 0=no, 1=yes
	SHORT m_skillNight;					// Board skill level at night
	BSTR m_backgroundNight;				// Fighting background at night
	LPSAFEARRAY m_brdConst;				// Board Constants (1-10)
	BSTR m_boardMusic;					// Background music file
	LPSAFEARRAY m_boardTitle;			// Board title (layer)
	LPSAFEARRAY m_programName;			// Board program filenames
	LPSAFEARRAY m_progX;				// Program x
	LPSAFEARRAY m_progY;				// Program y
	LPSAFEARRAY m_progLayer;			// Program layer
	LPSAFEARRAY m_progGraphic;			// Program graphic
	LPSAFEARRAY m_progActivate;			// Program activation: 0- always active, 1- conditional activation.
	LPSAFEARRAY m_progVarActivate;		// Activation variable
	LPSAFEARRAY m_progDoneVarActivate;	// Activation variable at end of prg.
	LPSAFEARRAY m_activateInitNum;		// Initial number of activation
	LPSAFEARRAY m_activateDoneNum;		// What to make variable at end of activation.
	LPSAFEARRAY m_activationType;		// Activation type- 0-step on, 1- conditional (activation key)
	BSTR m_enterPrg;					// Program to run on entrance
	BSTR m_bgPrg;						// Background program
	LPSAFEARRAY m_itmName;				// Filenames of items
	LPSAFEARRAY m_itmX;					// X coord
	LPSAFEARRAY m_itmY;					// Y coord
	LPSAFEARRAY m_itmLayer;				// Layer coord
	LPSAFEARRAY m_itmActivate;			// Itm activation: 0- always active, 1- conditional activation.
	LPSAFEARRAY m_itmVarActivate;		// Activation variable
	LPSAFEARRAY m_itmDoneVarActivate;	// Activation variable at end of itm.
	LPSAFEARRAY m_itmActivateInitNum;	// Initial number of activation
	LPSAFEARRAY m_itmActivateDoneNum;	// What to make variable at end of activation.
	LPSAFEARRAY m_itmActivationType;	// Activation type- 0-step on, 1- conditional (activation key)
	LPSAFEARRAY m_itemProgram;			// Program to run when item is touched.
	LPSAFEARRAY m_itemMulti;			// Multitask program for item
	SHORT m_playerX;					// Player x ccord
	SHORT m_playerY;					// Player y coord
	SHORT m_playerLayer;				// Player layer coord
	SHORT m_brdSavingYn;				// Can player save on board? 0-yes, 1-no
	CHAR m_isIsometric;					// Is it an isometric board? (0- no, 1-yes)
	LPSAFEARRAY m_threads;				// Filenames of threads on board
	VARIANT_BOOL m_hasAnmTiles;			// Does board have anim tiles?
//	LPSAFEARRAY m_animatedTile;			// Animated tiles associated with this board
	INT m_anmTileInsertIdx;				// Index of animated tile insertion
	LPSAFEARRAY m_anmTileLutIndices;	// Indices into LUT of animated tiles
	INT m_anmTileLutInsertIdx;			// Index of LUT table insertion
	BSTR strFilename;					// Filename of the board
	
	INT pxWidth() 
	{
		if (m_coordType & ISO_STACKED) return m_bSizeX * 64 - 32;
		if (m_coordType & ISO_ROTATED) return m_bSizeX * 64 - 32;
		return m_bSizeX * 32;			// TILE_NORMAL.
	}
	INT pxHeight() 
	{ 
		if (m_coordType & ISO_STACKED) return m_bSizeY * 16 - 16;
		if (m_coordType & ISO_ROTATED) return m_bSizeY * 32;
		return m_bSizeY * 32;			// TILE_NORMAL.
	}
	BOOL isIsometric()
	{
		return (m_coordType & (ISO_STACKED | ISO_ROTATED));
	}

} VB_BOARD, *LPVB_BOARD;

typedef struct tagVBBoardEditor
{
    CBoard *pCBoard;					// pointer to associated CBoard in actkrt
    LPSAFEARRAY bLayerOccupied;			// layer contains tiles (VARIANT_BOOL)
    LPSAFEARRAY bLayerVisible;			// layer visibility in the editor
//	VB_BOARD board; //Note to self: pass pointer from vb
	/* Fragment... */

} VB_BRDEDITOR, *LPVB_BRDEDITOR;

typedef struct tagEditorLayer
{
	CCanvas *cnv;
	RECT bounds;			// Extent of cnv wrt to board, in pixels.

	tagEditorLayer(): cnv(NULL) { };

} BRD_LAYER, *LPBRD_LAYER;

typedef std::vector<BRD_LAYER>::iterator BL_ITR;
typedef std::vector<CBoard *>::iterator CB_ITR;

typedef struct tagVBConvertedVector
{
	LPSAFEARRAY pts;
	LONG type;
	LONG layer;
	LONG attributes;
	VARIANT_BOOL closed;

} VB_CONV_VECTOR, *LPVB_CONV_VECTOR;

//--------------------------------------------------------------------------
// Definition of an RPGToolkit board
//--------------------------------------------------------------------------
class CBoard
{
public:
	CBoard(CONST STRING path) 
	{ 
		m_layers.reserve(8);
		m_projectPath = path; 
	}
	~CBoard();

	// Get ambient red of a tile
	INT ambientRed(
		CONST INT x,
		CONST INT y,
		CONST INT z
	) CONST;

	// Get ambient green of a tile
	INT ambientGreen(
		CONST INT x,
		CONST INT y,
		CONST INT z
	) CONST;

	// Get ambient blue of a tile
	INT ambientBlue(
		CONST INT x,
		CONST INT y,
		CONST INT z
	) CONST;

	// Get the filename of a tile
	std::string tile(
		CONST INT x,
		CONST INT y,
		CONST INT z
	) CONST;

	VOID CBoard::draw(
		CONST LPVB_BRDEDITOR pEditor,
		CONST LPVB_BOARD pBoard, 
		CONST HDC hdc,
		CONST LONG destX, CONST LONG destY,
		CONST LONG brdX, CONST LONG brdY,
		CONST LONG width,
		CONST LONG height,
		CONST DOUBLE scale
	);

	VOID render(
		CONST LPVB_BRDEDITOR pEditor,
		CONST LPVB_BOARD pBoard, 
		CONST HDC hdcCompat,
		CONST LONG layer,
		CONST BOOL bDestroyCanvas
	);

	VOID renderLayer(
		CONST LONG i, 
		CONST HDC hdcCompat,
		CONST BOOL bDestroyCanvas
	);

	std::vector<LPVB_BRDIMAGE> getImages(
		VOID
	);

	VOID renderTile(
		CONST LPVB_BOARD pBoard, 
		CONST LONG x, 
		CONST LONG y, 
		CONST LONG z, 
		CONST HDC hdcCompat
	);

	VOID vectorize(
		CONST LPVB_BOARD pBoard,
		LPSAFEARRAY FAR *toRet
	);

private:
	LPVB_BOARD m_pBoard;				// Board data passed from vb.
	std::vector<BRD_LAYER> m_layers;	// Canvases for layers.
	std::set<CCanvas *> m_images;		// Canvases for images.
	STRING m_projectPath;				// \Game\$game$

	void insertCnv(CCanvas *const cnv) { if (cnv) m_images.insert(cnv); }
};

#endif

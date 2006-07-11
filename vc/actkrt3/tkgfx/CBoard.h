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

//--------------------------------------------------------------------------
// VB structure of the board format.
//--------------------------------------------------------------------------
typedef struct tagVBBoard
{
	// Ordered for Visual Basic (see modBoard.TKBoard)
	SHORT m_bSizeX;						// Board size x
	SHORT m_bSizeY;						// Board size y
	SHORT m_bSizeL;						// Board size layer
	SHORT m_coordType;

	LPSAFEARRAY m_tileIndex;			// Lookup table for tiles
	LPSAFEARRAY m_board;				// Board tiles - codes indicating where the tiles are on the board
	LPSAFEARRAY m_ambientRed;			// Ambient tile red
	LPSAFEARRAY m_ambientGreen;			// Ambient tile green
	LPSAFEARRAY m_ambientBlue;			// Ambient tile blue
	LPSAFEARRAY m_tileType;				// Tiletypes (3.0.6- boards only)

	LPSAFEARRAY m_images;				// Array of tagVBBoardImages.
	LPSAFEARRAY m_spriteImages;			// tagVBBoardImages for sprites.
	VB_BRDIMAGE m_bkgImage;				// Background image.
	INT m_brdColor;						// Board color

	// Unordered (not required by actkrt)
	LPSAFEARRAY m_vectors;
	LPSAFEARRAY m_programs;
	LPSAFEARRAY m_sprites;
	LPSAFEARRAY m_threads;				// Filenames of threads on board
	LPSAFEARRAY m_brdConst;				// Constants
	LPSAFEARRAY m_boardTitle;			// Board title (layer)
	LPSAFEARRAY m_dirLink;				// Direction links 1- N, 2- S, 3- E, 4-W
	BSTR m_enterPrg;					// Program to run on entrance
	BSTR m_boardMusic;					// Background music file
	BSTR m_boardBackground;				// Fighting background
	SHORT m_boardSkilll;				// Board skill level
	SHORT m_fightingYN;					// Fighting on boardYN (1- yes, 0- no)
	SHORT m_brdSavingYn;				// Can player save on board? 0-yes, 1-no
	SHORT m_ambientEffect;				// Ambient effect applied to the board

	// Volatile data (trans3 only)
	//LPSAFEARRAY m_animatedTile;			// Animated tiles associated with this board
	//BSTR strFilename;					// Filename of the board
	
	INT pxWidth() const
	{
		if (m_coordType & ISO_STACKED) return m_bSizeX * 64 - 32;
		if (m_coordType & ISO_ROTATED) return m_bSizeX * 64 - 32;
		return m_bSizeX * 32;			// TILE_NORMAL.
	}
	INT pxHeight() const
	{ 
		if (m_coordType & ISO_STACKED) return m_bSizeY * 16 - 16;
		if (m_coordType & ISO_ROTATED) return m_bSizeY * 32;
		return m_bSizeY * 32;			// TILE_NORMAL.
	}
	BOOL isIsometric() const
	{
		return (m_coordType & (ISO_STACKED | ISO_ROTATED));
	}

} VB_BOARD, *LPVB_BOARD;

//--------------------------------------------------------------------------
// VB structure of the board editor UDT.
//--------------------------------------------------------------------------
typedef struct tagVBBoardEditor
{
    CBoard *pCBoard;					// pointer to associated CBoard in actkrt
	LONG optSetting;					// The current setting (eBrdSetting enumeration)
    LPSAFEARRAY bLayerOccupied;			// layer contains tiles (VARIANT_BOOL)
    LPSAFEARRAY bLayerVisible;			// layer visibility in the editor
	VARIANT_BOOL bShowSprites;
	VARIANT_BOOL bShowImages;
//	VB_BOARD board; //Note to self: pass pointer from vb
	/* Fragment... */

} VB_BRDEDITOR, *LPVB_BRDEDITOR;

//--------------------------------------------------------------------------
// Board editor setting enumeration (mirrors that in modBoard.bas)
//--------------------------------------------------------------------------
typedef enum tagVBBoardSettings
{
	BS_GENERAL,
	BS_ZOOM,
	BS_TILE,
	BS_VECTOR,
	BS_PROGRAM,
	BS_SPRITE,
	BS_IMAGE
} VB_EBRDSETTING;

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
		CONST LPVB_BRDEDITOR pEditor
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

	VOID freeImage(
		LPVB_BRDIMAGE pImg
	);

	VOID insertCnv(CCanvas *CONST cnv)
	{ 
		if (cnv) m_images.insert(cnv); 
	}

	STRING projectPath(VOID) CONST
	{
		return m_projectPath;
	}

private:
	LPVB_BOARD m_pBoard;				// Board data passed from vb.
	std::vector<BRD_LAYER> m_layers;	// Canvases for layers.
	std::set<CCanvas *> m_images;		// Canvases for images.
	STRING m_projectPath;				// \Game\$game$
};

#endif

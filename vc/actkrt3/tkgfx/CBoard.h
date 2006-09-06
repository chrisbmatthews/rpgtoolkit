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
#include "../../tkCommon/board/coords.h"
#include "../../tkCommon/board/lighting.h"

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
// VB Board tile and layer shading
//--------------------------------------------------------------------------

// An rgb colorshade.
typedef tagRgbShade VB_TILESHADE, *LPVB_TILESHADE;

// A layer of tile shading.
typedef struct tagVBLayerShade
{
    LPSAFEARRAY values;					// VB_TILESHADE(x, y)
	INT layer;							// Top layer to cast onto.
} VB_LAYERSHADE, *LPVB_LAYERSHADE;

typedef std::vector<VB_TILESHADE> tagRgbVector, RGB_VECTOR;
typedef std::vector<RGB_VECTOR> tagRgbMatrix, RGB_MATRIX;

// C++ version of tagVBLayerShade.
typedef struct tagLayerShade
{
	RGB_MATRIX shades;
	INT layer;
} LAYER_SHADE, *LPLAYER_SHADE;

// Point of a VB CVector.
typedef struct tagVBVectorPoint
{
	LONG x, y;
	VARIANT_BOOL bSet;
} VB_CVECTOR_POINT, *LPVB_CVECTOR_POINT;

//--------------------------------------------------------------------------
// VB structure of the board format.
//--------------------------------------------------------------------------
typedef struct tagVBBoard
{
	// Ordered for Visual Basic (see modBoard.TKBoard)
	SHORT sizeX;						// Board size x
	SHORT sizeY;						// Board size y
	SHORT sizeL;						// Board size layer
	SHORT coordType;

	LPSAFEARRAY tileIndex;				// Lookup table for tiles
	LPSAFEARRAY board;					// Board tiles - codes indicating where the tiles are on the board
	LPSAFEARRAY ambientRed;				// Ambient tile red
	LPSAFEARRAY ambientGreen;			// Ambient tile green
	LPSAFEARRAY ambientBlue;			// Ambient tile blue
	LPSAFEARRAY tileType;				// Tiletypes (3.0.6- boards only)

	LPSAFEARRAY tileShading;			// Tile shading (3.0.7+)
	LPSAFEARRAY lights;					// Lighting (3.0.7+)

	LPSAFEARRAY images;					// Array of tagVBBoardImages.
	LPSAFEARRAY spriteImages;			// tagVBBoardImages for sprites.
	VB_BRDIMAGE bkgImage;				// Background image.
	INT brdColor;						// Board color

	// Unordered (not required by actkrt)
	LPSAFEARRAY vectors;
	LPSAFEARRAY programs;
	LPSAFEARRAY sprites;
	LPSAFEARRAY threads;				// Filenames of threads on board
	LPSAFEARRAY brdConst;				// Constants
	LPSAFEARRAY boardTitle;				// Board title (layer)
	LPSAFEARRAY dirLink;				// Direction links 1- N, 2- S, 3- E, 4-W
	BSTR enterPrg;						// Program to run on entrance
	BSTR boardMusic;					// Background music file
	BSTR boardBackground;				// Fighting background
	SHORT boardSkilll;					// Board skill level
	SHORT fightingYN;					// Fighting on boardYN (1- yes, 0- no)
	SHORT brdSavingYn;					// Can player save on board? 0-yes, 1-no
	SHORT ambientEffect;				// Ambient effect applied to the board

	// Volatile data (trans3 only)
	//LPSAFEARRAY animatedTile;			// Animated tiles associated with this board
	//BSTR strFilename;					// Filename of the board
	
	INT pxWidth() const
	{
		if (coordType & ISO_STACKED) return sizeX * 64 - 32;
		if (coordType & ISO_ROTATED) return sizeX * 64 - 32;
		return sizeX * 32;				// TILE_NORMAL.
	}
	INT pxHeight() const
	{ 
		if (coordType & ISO_STACKED) return sizeY * 16 - 16;
		if (coordType & ISO_ROTATED) return sizeY * 32;
		return sizeY * 32;				// TILE_NORMAL.
	}
	BOOL isIsometric() const
	{
		return (coordType & (ISO_STACKED | ISO_ROTATED));
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
	LPSAFEARRAY bDrawObjects;			// Object visibility.
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
	BS_IMAGE,
	BS_SHADING,
	BS_LIGHTING
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

	VOID draw(
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

	VOID vectorize(
		CONST LPVB_BOARD pBoard,
		LPSAFEARRAY FAR *toRet
	);

	VOID freeImage(
		LPVB_BRDIMAGE pImg
	);

	VOID renderStack(
		CONST LPVB_BOARD pBoard, 
		CONST LPVB_BRDEDITOR pEditor,
		CONST LONG x, 
		CONST LONG y, 
		CONST HDC hdcCompat
	);

	VOID convertLight(
		CONST LPVB_BOARD pBoard, 
		CONST LPUNKNOWN pLight
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
	std::vector<LPVB_BRDIMAGE> getImages(
		CONST LPVB_BRDEDITOR pEditor
	);

	std::string tile(
		CONST INT x,
		CONST INT y,
		CONST INT z
	) CONST;	
	
	VOID renderLayer(
		CONST LONG i, 
		CONST HDC hdcCompat,
		CONST BOOL bDestroyCanvas
	);

	VOID renderTile(
		CONST LPVB_BOARD pBoard, 
		CONST LONG x, 
		CONST LONG y, 
		CONST LONG z, 
		CONST HDC hdcCompat
	);

	VOID applyLighting(
		RGB_MATRIX &shades
	);	
	
	VOID recalculateShading(
		CONST LPVB_BRDEDITOR pEditor
	);

	VOID getBoardLight(
		CONST LPUNKNOWN pLight, 
		BRD_LIGHT &bl
	);

	LPVB_BOARD m_pBoard;				// Board data passed from vb.
	std::vector<BRD_LAYER> m_layers;	// Canvases for layers.
	std::set<CCanvas *> m_images;		// Canvases for images.
	STRING m_projectPath;				// \Game\$game$
	LAYER_SHADE m_layerShade;			// Single-layer shading.
};

#endif

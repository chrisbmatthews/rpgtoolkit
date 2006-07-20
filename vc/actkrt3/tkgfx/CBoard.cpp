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
// Inclusions
//--------------------------------------------------------------------------
#include "CBoard.h"			// Stuff for this file
#include "../../tkCommon/tkGfx/CUtil.h"			// Utility functions
#include "CTileAnim.h"		// Animated tiles
#include "../../tkCommon/images/FreeImage.h"
#include "../../tkCommon/tkGfx/CTile.h"
#include "../../tkCommon/movement/board conversion.h"
#include <map>
#include "../../trans3/common/paths.h"

std::vector<CBoard *> g_boards;
//--------------------------------------------------------------------------
// Create a new instance and pass it back to VB.
//--------------------------------------------------------------------------
LONG APIENTRY BRDNewCBoard(CONST CHAR* projectPath)
{
	g_boards.reserve(16);
	g_boards.push_back(new CBoard(projectPath));
	return LONG(g_boards.back());
}

//--------------------------------------------------------------------------
// 
//--------------------------------------------------------------------------
LONG APIENTRY BRDFree(CONST CBoard *pBoard)
{
	for (CB_ITR i = g_boards.begin(); i != g_boards.end(); ++i)
	{
		if (*i == pBoard) 
		{ 
			delete pBoard;
			g_boards.erase(i);
			return 1;
		}
	}
	return 0;
}

//--------------------------------------------------------------------------
// 
//--------------------------------------------------------------------------
LONG APIENTRY BRDDraw(
	CONST LPVB_BRDEDITOR pEditor,
	CONST LPVB_BOARD pData,
	CONST LONG hdc,
	CONST LONG destX, LONG destY,
	CONST LONG brdX, LONG brdY,
	CONST LONG width,
	CONST LONG height,
	CONST DOUBLE scale)
{
	for (CB_ITR i = g_boards.begin(); i != g_boards.end(); ++i)
		if (*i == pEditor->pCBoard) pEditor->pCBoard->draw(pEditor, pData, reinterpret_cast<HDC>(hdc), destX, destY, brdX, brdY, width, height, scale);
	return 0;
}

//--------------------------------------------------------------------------
// 
//--------------------------------------------------------------------------
LONG APIENTRY BRDRender(
	CONST LPVB_BRDEDITOR pEditor,
	CONST LPVB_BOARD pData,
	CONST LONG hdcCompat,
	CONST SHORT bDestroyCanvas,
	CONST LONG layer)
{
	for (CB_ITR i = g_boards.begin(); i != g_boards.end(); ++i)
		if (*i == pEditor->pCBoard) pEditor->pCBoard->render(pEditor, pData, reinterpret_cast<HDC>(hdcCompat), layer, bDestroyCanvas);
	return 0;
}

//--------------------------------------------------------------------------
// 
//--------------------------------------------------------------------------
LONG APIENTRY BRDPixelToTile(
	LONG *x, 
	LONG *y, 
	CONST SHORT coordType, 
	CONST SHORT bRemoveBasePoint,
	CONST SHORT brdSizeX)
{
	INT px = *x, py = *y;
	coords::pixelToTile(px, py, COORD_TYPE(coordType), bRemoveBasePoint, brdSizeX);
	*x = px; *y = py;
	return 0;
}

//--------------------------------------------------------------------------
// 
//--------------------------------------------------------------------------
LONG APIENTRY BRDTileToPixel(
	LONG *x, 
	LONG *y, 
	CONST SHORT coordType,
	CONST SHORT bAddBasePoint,
	CONST SHORT brdSizeX)
{
	INT px = *x, py = *y;
	coords::tileToPixel(px, py, COORD_TYPE(coordType), BOOL(bAddBasePoint), brdSizeX);
	*x = px; *y = py;
	return 0;
}

//--------------------------------------------------------------------------
// 
//--------------------------------------------------------------------------
LONG APIENTRY BRDIsometricTransform(
	DOUBLE *x, 
	DOUBLE *y, 
	CONST SHORT oldType, 
	CONST SHORT newType,
	CONST SHORT brdSizeX)
{
	DOUBLE dx = *x, dy = *y;
	coords::isometricTransform(dx, dy, COORD_TYPE(oldType), COORD_TYPE(newType), brdSizeX);
	*x = dx; *y = dy;
	return 0;
}

//--------------------------------------------------------------------------
// 
//--------------------------------------------------------------------------
LONG APIENTRY BRDRenderTileToBoard(
	CBoard *pBoard, 
	CONST LPVB_BOARD pData,
	CONST LONG hdcCompat,
	CONST LONG x,
	CONST LONG y,
	CONST LONG z)
{
	for (CB_ITR i = g_boards.begin(); i != g_boards.end(); ++i)
		if (*i == pBoard) pBoard->renderTile(pData, x, y, z, reinterpret_cast<HDC>(hdcCompat));
	return 0;
}

//--------------------------------------------------------------------------
// 
//--------------------------------------------------------------------------
LONG APIENTRY BRDRenderTile(
	CONST CHAR* filename,
	CONST SHORT bIsometric,
	LONG hdc,
	CONST LONG x,
	CONST LONG y,
	CONST LONG backgroundColor)
{
	CONST RGBSHADE rgb = {0, 0, 0};
	CTile *pTile = CTile::findCacheMatch(
		filename, 
		TM_NONE, 
		rgb, 
		bIsometric, 
		reinterpret_cast<HDC>(hdc)
	);
	if (!pTile) return 1; 
	CCanvas cnv;
	cnv.CreateBlank(reinterpret_cast<HDC>(hdc), (bIsometric ? 64 : 32), 32, TRUE);
	cnv.ClearScreen(backgroundColor);
	pTile->cnvDraw(&cnv, 0, 0);
	cnv.Blt(reinterpret_cast<HDC>(hdc), x, y, SRCCOPY);
	//pTile->gdiDraw(reinterpret_cast<HDC>(hdc), x, y);
	return 0;
}

//--------------------------------------------------------------------------
// 
//--------------------------------------------------------------------------
LONG APIENTRY BRDVectorize(
	CBoard *pBoard, 
	CONST LPVB_BOARD pData,
	LPSAFEARRAY FAR *pVectors)
{
	for (CB_ITR i = g_boards.begin(); i != g_boards.end(); ++i)
		if (*i == pBoard) pBoard->vectorize(pData, pVectors);
	return 0;
}

//--------------------------------------------------------------------------
// 
//--------------------------------------------------------------------------
LONG APIENTRY BRDTileToVector(
	CONST LPVB_CONV_VECTOR pVector,
	CONST INT x,
	CONST INT y,
	CONST SHORT coordType)
{
	std::vector<CONV_POINT> pts = tileToVector(x, y, COORD_TYPE(coordType));

	// Create a new SAFEARRAY for the points.
	if (SafeArrayAllocDescriptor(1, &pVector->pts) != S_OK) return 1;

	pVector->pts->cbElements = sizeof(CONV_POINT);
	pVector->pts->fFeatures = FADF_EMBEDDED;
	pVector->pts->rgsabound[0].cElements = pts.size();
	pVector->pts->rgsabound[0].lLbound = 0;

	if (SafeArrayAllocData(pVector->pts) == S_OK)
	{
		// Insert the points into the new array.
		LONG index = 0;
		std::vector<CONV_POINT>::iterator i = pts.begin();
		for (; i != pts.end(); ++i, ++index)
		{
			if (SafeArrayPutElement(pVector->pts, &index, (void *)i) != S_OK) break;
		}
		pVector->closed = VARIANT_TRUE;
	} 
	return 0;
}

//--------------------------------------------------------------------------
// 
//--------------------------------------------------------------------------
LONG APIENTRY BRDFreeImage(CBoard *pBoard, LPVB_BRDIMAGE pImg)
{
	for (CB_ITR i = g_boards.begin(); i != g_boards.end(); ++i)
	{
		if (*i == pBoard) 
		{ 
			pBoard->freeImage(pImg);
			return 1;
		}
	}
	return 0;
}

//--------------------------------------------------------------------------
// 
//--------------------------------------------------------------------------
LONG APIENTRY BRDRenderImage(
	CBoard *pBoard, 
	LPVB_BRDIMAGE pImg,
	CONST HDC hdcCompat)
{
	for (CB_ITR i = g_boards.begin(); i != g_boards.end(); ++i)
	{
		if (*i == pBoard) 
		{
			pBoard->insertCnv(pImg->render(pBoard->projectPath(), hdcCompat));
			return 1;
		}
	}
	return 0;
}

//--------------------------------------------------------------------------
// 
//--------------------------------------------------------------------------
CBoard::~CBoard()
{
	BL_ITR i = m_layers.begin();
	for (; i != m_layers.end(); ++i) delete i->cnv;
	m_layers.clear();	
	std::set<CCanvas *>::iterator j = m_images.begin();
	for (; j != m_images.end(); ++j) delete *j;
	m_images.clear();
}

//--------------------------------------------------------------------------
// 
//--------------------------------------------------------------------------
std::vector<LPVB_BRDIMAGE> CBoard::getImages(CONST LPVB_BRDEDITOR pEditor)
{
	// Get board image array.
	LONG length = 0;
	SafeArrayGetUBound(m_pBoard->m_images, 1, &length);

	// Object visibility in the editor.
	LONG ub = 0, i = BS_IMAGE;
	SafeArrayGetUBound(pEditor->bDrawObjects, 1, &ub);
	
	VARIANT_BOOL visible = VARIANT_TRUE;
	if (BS_IMAGE <= ub) SafeArrayGetElement(pEditor->bDrawObjects, &i, LPVOID(&visible));

	std::vector<LPVB_BRDIMAGE> vect;
	if (visible == VARIANT_TRUE || pEditor->optSetting == BS_IMAGE)
	{
		for (i = 0; i <= length; ++i)
		{
			LPVB_BRDIMAGE pImg = NULL;
			SafeArrayPtrOfIndex(m_pBoard->m_images, &i, (void **)&pImg);
			vect.push_back(pImg);
		}
	}

	// Treat board sprites as images for the purposes of drawing them in the editor.
	SafeArrayGetUBound(m_pBoard->m_spriteImages, 1, &length);
	i = BS_SPRITE;
	visible = VARIANT_TRUE;
	if (BS_SPRITE <= ub) SafeArrayGetElement(pEditor->bDrawObjects, &i, LPVOID(&visible));

	std::map<int, LPVB_BRDIMAGE> spr;

	if (visible == VARIANT_TRUE || pEditor->optSetting == BS_SPRITE)
	{
		for (i = 0; i <= length; ++i)
		{
			LPVB_BRDIMAGE pImg = NULL;
			SafeArrayPtrOfIndex(m_pBoard->m_spriteImages, &i, (void **)&pImg);
			
			// Do some basic z-ordering (multiple sprites 
			// at the same co-ordinate will be invisible).
			spr[m_pBoard->pxWidth() * pImg->bounds.top + pImg->bounds.left] = pImg;
		}
		std::map<int, LPVB_BRDIMAGE>::const_iterator j = spr.begin();
		for (; j != spr.end(); ++j) vect.push_back(j->second);
	}
	
	return vect;
}

//--------------------------------------------------------------------------
// 
//--------------------------------------------------------------------------
VOID CBoard::freeImage(LPVB_BRDIMAGE pImg)
{
	std::set<CCanvas *>::iterator i = m_images.find(pImg->pCnv);
	if (i != m_images.end()) 
	{
		delete *i;
		m_images.erase(i);
		pImg->pCnv = 0;
	}
}

//--------------------------------------------------------------------------
// 
//--------------------------------------------------------------------------
VOID CBoard::draw(
	CONST LPVB_BRDEDITOR pEditor,
	CONST LPVB_BOARD pBoard,
	CONST HDC hdc,
	CONST LONG destX, CONST LONG destY,		// Pixel destination on the board.
	CONST LONG brdX, CONST LONG brdY,		// Unscaled pixel corner of the board.
	CONST LONG width,						// Unscaled dimensions of the hdc area.
	CONST LONG height,
	CONST DOUBLE scale)
{
	if (!hdc) return;
	m_pBoard = pBoard;

	// The board dimensions of the visible area (e.g., double area for 0.5 zoom).
	CONST LONG newWidth = width / scale, newHeight = height / scale;

	// Blt onto an intermediate canvas.
	CCanvas cnv;
	cnv.CreateBlank(hdc, newWidth, newHeight, TRUE);
	cnv.ClearScreen(m_pBoard->m_brdColor);
	CONST RECT screen = {brdX, brdY, brdX + newWidth, brdY + newHeight};

	// Background image.
	CONST LPVB_BRDIMAGE pBkg = &m_pBoard->m_bkgImage;
	if (!pBkg->pCnv && !getString(pBkg->file).empty()) insertCnv(pBkg->render(m_projectPath, hdc));
	// Find a match in m_images.
	if (m_images.find(pBkg->pCnv) != m_images.end()) pBkg->draw(cnv, screen, m_pBoard->pxWidth(), m_pBoard->pxHeight());

	// Board images.
	// Reallocation will not occur during this call so no need to lock.
	// SafeArrayLock(m_pBoard->m_images);
	std::vector<LPVB_BRDIMAGE> imgs = getImages(pEditor);
	
	LONG z = 1, length = 0;
	SafeArrayGetUBound(pEditor->bLayerVisible, 1, &length);

	for (z = 1; z <= m_pBoard->m_bSizeL; ++z)
	{
		if (z <= length)
		{
			VARIANT_BOOL vis = VARIANT_TRUE;
			SafeArrayGetElement(pEditor->bLayerVisible, &z, LPVOID(&vis));
			if (!vis) continue;
		}
		RECT r = {0, 0, 0, 0};

		// Draw tiles.
		if (m_layers.size() > z)
		{
			LPBRD_LAYER i = &m_layers[z];
			if (i->cnv && IntersectRect(&r, &screen, &i->bounds))
			{
				i->cnv->BltTransparentPart(
					&cnv,
					r.left - screen.left,
					r.top - screen.top,
					r.left - i->bounds.left,
					r.top - i->bounds.top,
					r.right - r.left,
					r.bottom - r.top,
					TRANSP_COLOR
				);
			}
		}

		// Draw sprites and images.
		std::vector<LPVB_BRDIMAGE>::iterator j = imgs.begin();
		for(; j != imgs.end(); ++j)
		{
			// If no canvas exists, create and add to CBoard::m_images.
			if (!(*j)->pCnv) insertCnv((*j)->render(m_projectPath, hdc));

			// Find a match in m_images.
			if ((*j)->layer == z)
			{
				if (m_images.find((*j)->pCnv) != m_images.end())
				{
					(*j)->draw(cnv, screen, m_pBoard->pxWidth(), m_pBoard->pxHeight());
				}
				else
				{
					// Draw a small square to represent the image.
					
					RECT r = {0, 0, 0, 0}, *b = &(*j)->bounds;
					b->right = b->left + 32;
					b->bottom = b->top + 32;
					
					if (IntersectRect(&r, &screen, b))
						cnv.DrawFilledRect(
							r.left - screen.left,
							r.top - screen.top,
							r.right - screen.left,
							r.bottom - screen.top,
							(!m_pBoard->m_brdColor ? RGB(255, 255, 255) : 0)
						);
				}
			}
		} // for (images)

	} // for (layers)

	// Stretch onto the dc.
	if (scale == 1.0)
	{
		cnv.Blt(hdc, destX, destY, SRCCOPY);
	}
	else
	{
		cnv.BltStretch(
			hdc,
			destX, destY, 
			0, 0,
			newWidth, newHeight,
			width, height,
			SRCCOPY
		);
	}

	// Unlock the image array to allow reallocation in VB.
	// SafeArrayUnlock(m_pBoard->m_images);
}

//--------------------------------------------------------------------------
// layer = 0 -- all layers
//--------------------------------------------------------------------------
VOID CBoard::render(
	CONST LPVB_BRDEDITOR pEditor,
	CONST LPVB_BOARD pBoard,
	CONST HDC hdcCompat, 
	CONST LONG layer,
	CONST BOOL bDestroyCanvas)
{
	m_pBoard = pBoard;
	LONG length = 0;
	CONST LONG lower = (layer ? layer : 1), upper = (layer ? layer : m_pBoard->m_bSizeL);
	SafeArrayGetUBound(pEditor->bLayerOccupied, 1, &length);

	for (LONG i = lower; i <= upper; ++i)
	{
		if (i <= length)
		{
			VARIANT_BOOL occ = VARIANT_TRUE;
			SafeArrayGetElement(pEditor->bLayerOccupied, &i, LPVOID(&occ));
			if (!occ) continue;
		}
		renderLayer(i, hdcCompat, bDestroyCanvas);
	}
}

//--------------------------------------------------------------------------
// 
//--------------------------------------------------------------------------
VOID CBoard::renderTile(
	CONST LPVB_BOARD pBoard, 
	CONST LONG x, 
	CONST LONG y, 
	CONST LONG z, 
	CONST HDC hdcCompat)
{
	m_pBoard = pBoard;
	while (z >= m_layers.size()) m_layers.push_back(BRD_LAYER());
	CONST LPBRD_LAYER p = &m_layers[z];
	
	CONST INT w = m_pBoard->pxWidth(), h = m_pBoard->pxHeight();

	if (!p->cnv)
	{
		p->cnv = new CCanvas();
		p->cnv->CreateBlank(hdcCompat, w, h, TRUE);
		CONST RECT r = {0, 0, w, h};
		p->cnv->ClearScreen(TRANSP_COLOR);
		p->bounds = r;
	}

	CONST STRING strTile = tile(x, y, z);

	if (!strTile.empty())
	{
		// Tile exists at this location.
		CONST INT r = ambientRed(x, y, z); //+ aR;
		CONST INT g = ambientGreen(x, y, z); //+ aG;
		CONST INT b = ambientBlue(x, y, z); //+ aB;

		// Set the tile onto it
		CONST HDC hdc = p->cnv->OpenDC();
		CTile::drawByBoardCoordHdc(
			m_projectPath + TILE_PATH + strTile,
			x, y,
			r, g, b,
			hdc,
			TM_NONE,
			0, 0,
			COORD_TYPE(m_pBoard->m_coordType),
			m_pBoard->m_bSizeX,
			1 /*isoEO*/
		);
		p->cnv->CloseDC(hdc);
	}
	else
	{
		// TBD: Draw blank tile.
	}
}

//--------------------------------------------------------------------------
//
//--------------------------------------------------------------------------
VOID CBoard::renderLayer(
	CONST LONG i, 
	CONST HDC hdcCompat,
	CONST BOOL bDestroyCanvas)
{
	// TBD: Shrink canvas to used area.
	while (i >= m_layers.size()) m_layers.push_back(BRD_LAYER());
	LPBRD_LAYER p = &m_layers[i];
	
	CONST INT w = m_pBoard->pxWidth(), h = m_pBoard->pxHeight();

	if (bDestroyCanvas && p->cnv)
	{
		delete p->cnv;
		p->cnv = NULL;
	}
	if (!p->cnv)
	{
		p->cnv = new CCanvas();
		p->cnv->CreateBlank(hdcCompat, w, h, TRUE);
		CONST RECT r = {0, 0, w, h};
		p->bounds = r;
	}

	p->cnv->ClearScreen(TRANSP_COLOR);
	CONST HDC hdc = p->cnv->OpenDC();

	INT effWidth = m_pBoard->m_bSizeX, effHeight = m_pBoard->m_bSizeY;
	if (m_pBoard->m_coordType & ISO_ROTATED)
	{
		// Data matrix is square.
		effWidth += m_pBoard->m_bSizeY;
		effHeight += m_pBoard->m_bSizeX;
	}

	for (INT x = 1; x <= effWidth; ++x)
	{
		for (INT y = 1; y <= effHeight; ++y)
		{
			CONST STRING strTile = tile(x, y, i);
			if (!strTile.empty())
			{
				CONST INT r = ambientRed(x, y, i); //+ aR;
				CONST INT g = ambientGreen(x, y, i); //+ aG;
				CONST INT b = ambientBlue(x, y, i); //+ aB;

				// Set the tile onto it
				CTile::drawByBoardCoordHdc(
					m_projectPath + TILE_PATH + strTile,
					x, y,
					r, g, b,
					hdc,
					TM_NONE,
					0, 0,
					COORD_TYPE(m_pBoard->m_coordType),
					m_pBoard->m_bSizeX,
					1 /*isoEO*/
				);			
			} // if (!strTile.empty())
		} // for y
	} // for x

	p->cnv->CloseDC(hdc);
}	

//--------------------------------------------------------------------------
//
//--------------------------------------------------------------------------
void tagVBBoardImage::draw(
	CONST CCanvas &cnv, 
	CONST RECT screen, 
	CONST LONG brdWidth, 
	CONST LONG brdHeight)
{
	RECT r = {0, 0, 0, 0};

	CONST LONG scrWidth = screen.right - screen.left, scrHeight = screen.bottom - screen.top;
	CONST LONG width = bounds.right - bounds.left, height = bounds.bottom - bounds.top;
	LONG destX = 0, destY = 0, left = 0, top = 0;

	if (drawType == 1/*BI_PARALLAX*/)
	{
		// Scrolling factors.
		if (brdWidth !=  scrWidth)
		{
			scrollx = (width - scrWidth) / double(brdWidth - scrWidth);
		}
		if (brdHeight !=  scrHeight)
		{
			scrolly = (height - scrHeight) / double(brdHeight - scrHeight);
		}
		if (scrollx < 0 || width < scrWidth)
		{
			// Centre the image if board and/or image smaller than screen.
			destX = (scrWidth - width) * 0.5;
		}
		else
		{
			left = scrollx * screen.left;
		}
		if (scrolly < 0 || height < scrHeight)
		{
			destY = (scrHeight - height) * 0.5;
		}
		else
		{
			top = scrolly * screen.top;
		}
		pCnv->BltTransparentPart(
			&cnv, 
			destX, 
			destY, 
			left, 
			top, 
			width > scrWidth ? scrWidth : width, 
			height > scrHeight ? scrHeight: height, 
			transpColor
		);
		return;
	} // if (parallax)

	// Stretch or normal.
	if (IntersectRect(&r, &screen, &bounds))
	{
		CCanvas *pIntCnv = pCnv;
		if (drawType == 2/*BI_STRETCH*/)
		{
			pIntCnv = new CCanvas();
			CONST HDC hdc = pCnv->OpenDC();
			pIntCnv->CreateBlank(hdc, width, height, TRUE);
			pCnv->CloseDC(hdc);
			pIntCnv->ClearScreen(TRANSP_COLOR);
			pCnv->BltStretch(
				pIntCnv,
				0, 0, 
				0, 0,
				pCnv->GetWidth(), pCnv->GetHeight(),
				width, height,
				SRCCOPY
			);
		}
		pIntCnv->BltTransparentPart(
			&cnv,
			r.left - screen.left,
			r.top - screen.top,
			r.left - bounds.left,
			r.top - bounds.top,
			r.right - r.left,
			r.bottom - r.top,
			transpColor
		);
	} // if (intersect)
}

//--------------------------------------------------------------------------
//
//--------------------------------------------------------------------------
CCanvas *tagVBBoardImage::render(
	CONST STRING projectPath, 
	CONST HDC hdcCompat)
{
	// Make a new canvas.
	CONST STRING filename = getString(file), ext = util::getExt(filename);
	if (stricmp(ext.c_str(), "tst") == 0 || stricmp(ext.c_str(), "tbm") == 0)
	{
		// Create a blank canvas and render tst/tbm through toolkit3.exe
		// since the tbm format is not directly accessible here.
		pCnv = new CCanvas();
		pCnv->CreateBlank(hdcCompat, 32, 32, TRUE);
		pCnv->ClearScreen(TRANSP_COLOR);
		return pCnv;
	}

	CONST STRING strFile = projectPath + BMP_PATH + filename;
	FIBITMAP *bmp = FreeImage_Load(
		FreeImage_GetFileType(getAsciiString(strFile).c_str(), 16), 
		getAsciiString(strFile).c_str()
	);
	if (!bmp) return NULL;

	CONST INT w = FreeImage_GetWidth(bmp), h = FreeImage_GetHeight(bmp);
	
	// Assign width and height to bounds, since the image is only rendered once.
//	if (bounds.right - bounds.left <= 0 || bounds.bottom - bounds.top <= 0)
	{
		bounds.right = bounds.left + w;
		bounds.bottom = bounds.top + h;
	}
	
	pCnv = new CCanvas();
	pCnv->CreateBlank(hdcCompat, w, h, TRUE);
	pCnv->ClearScreen(TRANSP_COLOR);

	CONST HDC hdc = pCnv->OpenDC();
	SetDIBitsToDevice(
		hdc,
		0, 0, 
		w, h, 
		0, 0, 0, h, 
		FreeImage_GetBits(bmp),
		FreeImage_GetInfo(bmp), 
		DIB_RGB_COLORS
	); 
	pCnv->CloseDC(hdc);
	FreeImage_Unload(bmp);

	return pCnv;
}

//--------------------------------------------------------------------------
// Get ambient red of a tile
//--------------------------------------------------------------------------
INLINE INT CBoard::ambientRed(
	CONST INT x,
	CONST INT y,
	CONST INT z
		) CONST
{

	// Obtain the ambient red value
	LONG indicies[] = {x, y, z};
	SHORT toRet = 0;
	SafeArrayGetElement(m_pBoard->m_ambientRed, indicies, LPVOID(&toRet));
	return toRet;

}

//--------------------------------------------------------------------------
// Get ambient green of a tile
//--------------------------------------------------------------------------
INLINE INT CBoard::ambientGreen(
	CONST INT x,
	CONST INT y,
	CONST INT z
		) CONST
{

	// Obtain the ambient green value
	LONG indicies[] = {x, y, z};
	SHORT toRet = 0;
	SafeArrayGetElement(m_pBoard->m_ambientGreen, indicies, LPVOID(&toRet));
	return toRet;

}

//--------------------------------------------------------------------------
// Get ambient blue of a tile
//--------------------------------------------------------------------------
INLINE INT CBoard::ambientBlue(
	CONST INT x,
	CONST INT y,
	CONST INT z
		) CONST
{

	// Obtain the ambient blue value
	LONG indicies[] = {x, y, z};
	SHORT toRet = 0;
	SafeArrayGetElement(m_pBoard->m_ambientBlue, indicies, LPVOID(&toRet));
	return toRet;

}

//--------------------------------------------------------------------------
// Get the filename of a tile
//--------------------------------------------------------------------------
INLINE std::string CBoard::tile(
	CONST INT x,
	CONST INT y,
	CONST INT z
		) CONST
{

	// First, get the lut code
	LONG lutIndicies[] = {x, y, z};
	SHORT lut = 0;
	SafeArrayGetElement(m_pBoard->m_board, lutIndicies, LPVOID(&lut));

	if (!lut)
	{
		// No tile at this location (lut == 0).
		return std::string();
	}
	else
	{
		// Now, find the tile with that code
		LONG tileIndices[] = {lut};
		BSTR str = NULL;
		SafeArrayGetElement(m_pBoard->m_tileIndex, tileIndices, LPVOID(&str));

		// Convert to ASCII
		CONST INT len = SysStringLen(str);
		LPSTR toRet = new CHAR[len + 1];
		for (INT i = 0; i < len; i++)
		{
			// Copy over
			toRet[i] = str[i];
		}

		// Append NULL
		toRet[len] = '\0';

		// Create the return string
		CONST std::string toRetStr = toRet;

		// Clean up
		delete [] toRet;

		// Get the file's extension
		CONST std::string strExt = util::upperCase(util::getExt(toRetStr));

		// If it's an animated tile
		if (strExt.compare("TAN") == 0)
		{
			// Use the first frame
			return CTileAnim(m_projectPath + TILE_PATH + toRetStr).frame(1);
		}

		// Return the result
		return toRetStr;

	} // if (lut == 0)

}

//--------------------------------------------------------------------------
//
//--------------------------------------------------------------------------
VOID CBoard::vectorize(
	CONST LPVB_BOARD pBoard,
	LPSAFEARRAY FAR *vbArray)
{
	m_pBoard = pBoard;

	SAFEARRAYBOUND sabound = {1, 0};

	if (SafeArrayRedim(*vbArray, &sabound) != S_OK) return;

	// Start inserting from zero.
	sabound.cElements = 0;

	// Construct a vector array from the tiletype SAFEARRAY.
	for (UINT z = 1; z <= m_pBoard->m_bSizeL; ++z)
	{
		VECTOR_CHAR row;
		VECTOR_CHAR2D matrix;
		 
		for (UINT x = 0; x <= m_pBoard->m_bSizeX; ++x) row.push_back('\0');
		for (UINT y = 0; y <= m_pBoard->m_bSizeY; ++y) matrix.push_back(row);

		for (x = 1; x <= m_pBoard->m_bSizeX; ++x)
		{
			for (y = 1; y <= m_pBoard->m_bSizeY; ++y)
			{
				LONG indices[] = {x, y, z};
				CHAR type = 0;
				SafeArrayGetElement(m_pBoard->m_tileType, indices, LPVOID(&type));

				matrix[y][x] = type;
			}
		}

		// Make a vector of points for each new board vector.
		std::vector<LPCONV_VECTOR> vects = vectorizeLayer(
			matrix,
			m_pBoard->m_bSizeX,
			m_pBoard->m_bSizeY,
			COORD_TYPE(m_pBoard->m_coordType)
		);

		// Increase the size of the vb array to accomodate.
		LONG element = sabound.cElements;
		sabound.cElements += vects.size();
		if (SafeArrayRedim(*vbArray, &sabound) != S_OK) return;

		// Create a SAFEARRAY for each set of board vector points.
		std::vector<LPCONV_VECTOR>::iterator j = vects.begin();
		for (; j != vects.end(); ++j, ++element)
		{
			// Get the pointer to the new vector in the vb array.
			LPVB_CONV_VECTOR pCvVt = NULL;
			SafeArrayPtrOfIndex(*vbArray, &element, (void **)&pCvVt);

			// Create a new SAFEARRAY for the points.
			if (SafeArrayAllocDescriptor(1, &pCvVt->pts) != S_OK) continue;

			pCvVt->pts->cbElements = sizeof(CONV_POINT);
			pCvVt->pts->fFeatures = FADF_EMBEDDED;
			pCvVt->pts->rgsabound[0].cElements = (*j)->pts.size();
			pCvVt->pts->rgsabound[0].lLbound = 0;

			if (SafeArrayAllocData(pCvVt->pts) == S_OK)
			{
				// Insert the points into the new array.
				LONG index = 0;
				std::vector<CONV_POINT>::iterator k = (*j)->pts.begin();
				for (; k != (*j)->pts.end(); ++k, ++index)
				{
					if (SafeArrayPutElement(pCvVt->pts, &index, (void *)k) != S_OK) break;
				}

				// Set the other properties.
				pCvVt->closed = VARIANT_TRUE;
				pCvVt->type = TILE_TYPE((*j)->type);
				if ((*j)->type >= STAIRS1 && (*j)->type <= STAIRS8)
				{
					// Old stairs are stored as targetLayer + 10.
					pCvVt->attributes = (*j)->type - 10;
					pCvVt->type = TT_STAIRS;
				}
				else if ((*j)->type == NORTH_SOUTH || (*j)->type == EAST_WEST)
				{
					pCvVt->type = TT_SOLID;		
					pCvVt->closed = 0;
				}
				pCvVt->layer = z;

			} // Point array allocated.
		
			// VectorizeLayer allocated the points.
			delete *j;

		} // for (vectors on this layer)
	} // for (z)
}

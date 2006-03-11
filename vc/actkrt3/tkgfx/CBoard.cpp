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
LONG APIENTRY BRDFree(CBoard *pBoard)
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
	LPVB_BRDEDITOR pEditor,
	LONG hdc,
	LONG destX, LONG destY,
	LONG brdX, LONG brdY,
	LONG width,
	LONG height,
	DOUBLE scale)
{
	for (CB_ITR i = g_boards.begin(); i != g_boards.end(); ++i)
		if (*i == pEditor->pCBoard) pEditor->pCBoard->draw(pEditor, reinterpret_cast<HDC>(hdc), destX, destY, brdX, brdY, width, height, scale);
	return 0;
}

//--------------------------------------------------------------------------
// 
//--------------------------------------------------------------------------
LONG APIENTRY BRDRender(
	LPVB_BRDEDITOR pEditor,
	LONG hdcCompat,
	LONG layer)
{
	for (CB_ITR i = g_boards.begin(); i != g_boards.end(); ++i)
		if (*i == pEditor->pCBoard) pEditor->pCBoard->render(pEditor, reinterpret_cast<HDC>(hdcCompat), layer);
	return 0;
}

//--------------------------------------------------------------------------
// 
//--------------------------------------------------------------------------
LONG APIENTRY BRDPixelToTile(
	LONG *x, 
	LONG *y, 
	SHORT coordType, 
	SHORT brdSizeX)
{
	INT px = *x, py = *y;
	coords::pixelToTile(px, py, COORD_TYPE(coordType), brdSizeX);
	*x = px; *y = py;
	return 0;
}

//--------------------------------------------------------------------------
// 
//--------------------------------------------------------------------------
LONG APIENTRY BRDTileToPixel(
	LONG *x, 
	LONG *y, 
	SHORT coordType, 
	SHORT brdSizeX)
{
	INT px = *x, py = *y;
	coords::tileToPixel(px, py, COORD_TYPE(coordType), false, brdSizeX);
	*x = px; *y = py;
	return 0;
}

//--------------------------------------------------------------------------
// 
//--------------------------------------------------------------------------
LONG APIENTRY BRDRenderTile(
	CBoard *pBoard, 
	LPVB_BOARD pData,
	LONG hdcCompat,
	LONG x,
	LONG y,
	LONG z)
{
	for (CB_ITR i = g_boards.begin(); i != g_boards.end(); ++i)
		if (*i == pBoard) pBoard->renderTile(pData, x, y, z, reinterpret_cast<HDC>(hdcCompat));
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
std::vector<LPVB_BRDIMAGE> CBoard::getImages()
{
	// Get board image array.
	LONG length = 0;
	SafeArrayGetUBound(m_pBoard->m_images, 1, &length);

	std::vector<LPVB_BRDIMAGE> vect;
	for (LONG i = 0; i != length; ++i)
	{
		LPVB_BRDIMAGE pImg = NULL;
		SafeArrayPtrOfIndex(m_pBoard->m_images, &i, (void **)&pImg);
		vect.push_back(pImg);
	}
	return vect;
}

//--------------------------------------------------------------------------
// 
//--------------------------------------------------------------------------
VOID CBoard::draw(
	CONST LPVB_BRDEDITOR pEditor,
	CONST HDC hdc,
	CONST LONG destX, CONST LONG destY,		// Pixel destination on the board.
	CONST LONG brdX, CONST LONG brdY,		// Unscaled pixel corner of the board.
	CONST LONG width,						// Unscaled dimensions of the hdc area.
	CONST LONG height,
	CONST DOUBLE scale)
{

	if (!hdc) return;
	m_pBoard = &pEditor->board;

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
	std::vector<LPVB_BRDIMAGE> imgs = getImages();
	
	LONG z = 1, length = 0;
	SafeArrayGetUBound(pEditor->bLayerVisible, 1, &length);

	for (BL_ITR i = m_layers.begin() + 1; i != m_layers.end(); ++i, ++z)
	{
		if (z < length)
		{
			VARIANT_BOOL vis = 1;
			SafeArrayGetElement(pEditor->bLayerVisible, &z, LPVOID(&vis));
			if (!vis) continue;
		}
		RECT r = {0, 0, 0, 0};

		// Draw tiles.
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

		// Draw images.
		std::vector<LPVB_BRDIMAGE>::iterator j = imgs.begin();
		for(; j != imgs.end(); ++j)
		{
			// If no canvas exists, create and add to CBoard::m_images.
			if (!(*j)->pCnv) insertCnv((*j)->render(m_projectPath, hdc));

			// Find a match in m_images.
			if ((*j)->layer == z && m_images.find((*j)->pCnv) != m_images.end())
			{
				(*j)->draw(cnv, screen, m_pBoard->pxWidth(), m_pBoard->pxHeight());
			}
		} // for (images)

		// Draw items.

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
	CONST HDC hdcCompat, 
	CONST LONG layer)
{
	m_pBoard = &pEditor->board;
	LONG length = 0;
	CONST LONG lower = (layer ? layer : 1), upper = (layer ? layer : m_pBoard->m_bSizeL);
	SafeArrayGetUBound(pEditor->bLayerOccupied, 1, &length);

	for (LONG i = lower; i <= upper; ++i)
	{
		if (i < length)
		{
			VARIANT_BOOL occ = -1;
			SafeArrayGetElement(pEditor->bLayerOccupied, &i, LPVOID(&occ));
			if (!occ) continue;
		}
		renderLayer(i, hdcCompat);
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
			m_projectPath + "tiles\\" + strTile,
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
	CONST HDC hdcCompat)
{
	// TBD: Shrink canvas to used area.
	while (i >= m_layers.size()) m_layers.push_back(BRD_LAYER());
	LPBRD_LAYER p = &m_layers[i];
	
	CONST INT w = m_pBoard->pxWidth(), h = m_pBoard->pxHeight();

	if (!p->cnv)
	{
		p->cnv = new CCanvas();
		p->cnv->CreateBlank(hdcCompat, w, h, TRUE);
		CONST RECT r = {0, 0, w, h};
		p->bounds = r;
	}
	p->cnv->ClearScreen(TRANSP_COLOR);
	CONST HDC hdc = p->cnv->OpenDC();

	for (INT x = 1; x <= m_pBoard->m_bSizeX; ++x)
	{
		for (INT y = 1; y <= m_pBoard->m_bSizeY; ++y)
		{
			CONST STRING strTile = tile(x, y, i);
			if (!strTile.empty())
			{
				CONST INT r = ambientRed(x, y, i); //+ aR;
				CONST INT g = ambientGreen(x, y, i); //+ aG;
				CONST INT b = ambientBlue(x, y, i); //+ aB;

				// Set the tile onto it
				CTile::drawByBoardCoordHdc(
					m_projectPath + "tiles\\" + strTile,
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
	CONST STRING strFile = projectPath + getString(file);
	FIBITMAP *bmp = FreeImage_Load(
		FreeImage_GetFileType(getAsciiString(strFile).c_str(), 16), 
		getAsciiString(strFile).c_str()
	);
	if (!bmp) return NULL;

	CONST INT w = FreeImage_GetWidth(bmp), h = FreeImage_GetHeight(bmp);
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
			return CTileAnim("tiles\\" + toRetStr).frame(1);
		}

		// Return the result
		return toRetStr;

	} // if (lut == 0)

}

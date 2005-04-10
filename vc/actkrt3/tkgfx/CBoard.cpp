//--------------------------------------------------------------------------
// All contents copyright 2004, Colin James Fitzpatrick
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
#include "tkgfx.h"			// Main gfx routines
#include "../../tkCommon/tkGfx/CUtil.h"			// Utility functions
#include "CTileAnim.h"		// Animated tiles

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
	SafeArrayGetElement(m_ambientRed, indicies, LPVOID(&toRet));
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
	SafeArrayGetElement(m_ambientGreen, indicies, LPVOID(&toRet));
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
	SafeArrayGetElement(m_ambientBlue, indicies, LPVOID(&toRet));
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
	SafeArrayGetElement(m_board, lutIndicies, LPVOID(&lut));

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
		SafeArrayGetElement(m_tileIndex, tileIndices, LPVOID(&str));

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

//--------------------------------------------------------------------------
// Draw the board to a canvas
//--------------------------------------------------------------------------
VOID FAST_CALL CBoard::draw(
	CONST CNV_HANDLE cnv,
	CONST INT layer,
	CONST INT topX,
	CONST INT topY,
	CONST INT tilesX,
	CONST INT tilesY,
	CONST INT nBsizeX,
	CONST INT nBsizeY,
	CONST INT nBsizeL,
	CONST INT aR,
	CONST INT aG,
	CONST INT aB,
	CONST BOOL bIsometric
		) CONST
{

	// Is it an even or odd tile?
	CONST INT nIsoEvenOdd = !(topY % 2);

	// Record top and bottom layers
	CONST INT nLower = layer ? layer : 1;
	CONST INT nUpper = layer ? layer : nBsizeL;

	// Calculate width and height
	CONST INT nWidth = (tilesX + topX > nBsizeX) ? nBsizeX - topX : tilesX;
	CONST INT nHeight = (tilesY + topY > nBsizeY) ? nBsizeY - topY : tilesY;

	// For each layer
	for (INT i = nLower; i <= nUpper; i++)
	{

		// For the x axis
		for (INT j = 1; j <= nWidth; j++)
		{

			// For the y axis
			for (INT k = 1; k <= nHeight; k++)
			{
				// Obtain some information
				CONST INT x = j + topX;
				CONST INT y = k + topY;
				CONST std::string strTile = tile(x, y, i);
				if (!strTile.empty())
				{
					// Tile exists at this location.
					LPCSTR pstrTile = strTile.c_str();
					CONST INT r = ambientRed(x, y, i) + aR;
					CONST INT g = ambientGreen(x, y, i) + aG;
					CONST INT b = ambientBlue(x, y, i) + aB;

					// Set the tile onto it
					GFXDrawTileCNV(
						pstrTile,
						j, k,
						r, g, b,
						cnv,
						bIsometric,
						nIsoEvenOdd
					);

				} // if (!strTile.empty())

			} // for k

		} // for j

	} // for i

}

//--------------------------------------------------------------------------
// Draw the board to a HDC
//--------------------------------------------------------------------------
VOID FAST_CALL CBoard::drawHdc(
	CONST INT hdc,
	CONST INT maskHdc,
	CONST INT layer,
	CONST INT topX,
	CONST INT topY,
	CONST INT tilesX,
	CONST INT tilesY,
	CONST INT nBsizeX,
	CONST INT nBsizeY,
	CONST INT nBsizeL,
	CONST INT aR,
	CONST INT aG,
	CONST INT aB,
	CONST BOOL bIsometric
		) CONST
{

	// Is it an even or odd tile?
	CONST INT nIsoEvenOdd = !(topY % 2);

	// Record top and bottom layers
	CONST INT nLower = layer ? layer : 1;
	CONST INT nUpper = layer ? layer : nBsizeL;

	// Calculate width and height
	CONST INT nWidth = (tilesX + topX > nBsizeX) ? nBsizeX - topX : tilesX;
	CONST INT nHeight = (tilesY + topY > nBsizeY) ? nBsizeY - topY : tilesY;

	// For each layer
	for (INT i = nLower; i <= nUpper; i++)
	{

		// For the x axis
		for (INT j = 1; j <= nWidth; j++)
		{

			// For the y axis
			for (INT k = 1; k <= nHeight; k++)
			{

				// Obtain some information
				CONST INT x = j + topX;
				CONST INT y = k + topY;
				CONST std::string strTile = tile(x, y, i);
				if (!strTile.empty())
				{
					// Tile exists at this location.
					LPCSTR pstrTile = strTile.c_str();
					CONST INT r = ambientRed(x, y, i) + aR;
					CONST INT g = ambientGreen(x, y, i) + aG;
					CONST INT b = ambientBlue(x, y, i) + aB;

					// If there's a canvas
					if (hdc != -1)
					{

						// Set the tile onto it
						GFXdrawtile(
							pstrTile,
							j, k,
							r, g, b,
							hdc,
							bIsometric,
							nIsoEvenOdd
						);

					}

					// If there's a mask canvas
					if (maskHdc != -1)
					{

						// Draw the tile's mask
						GFXdrawtilemask(
							pstrTile,
							j, k,
							r, g, b,
							maskHdc, 0,
							bIsometric,
							nIsoEvenOdd
						);

					}

				} // if (!strTile.empty())

			} // for k

		} // for j

	} // for i

}

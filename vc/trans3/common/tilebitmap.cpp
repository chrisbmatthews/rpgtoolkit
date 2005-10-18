/*
 * All contents copyright 2003, 2004, 2005 Christopher Matthews or Contributors.
 * Various port optimizations copyright by Colin James Fitzpatrick, 2005.
 * All rights reserved. You may not remove this notice
 * Read license.txt for licensing details.
 */

/*
 * Inclusions.
 */
#include "tilebitmap.h"
#include "CFile.h"
#include "paths.h"
#include "mbox.h"

/*
 * Open a tile bitmap.
 *
 * fileName (in) - file to open
 * bool (out) - open success
 */
bool tagTileBitmap::open(const STRING fileName)
{

	CFile file(fileName);

	STRING fileHeader;
	file >> fileHeader;

	if (fileHeader != _T("TK3 TILEBITMAP"))
	{
		messageBox(_T("Invalid tile bitmap ") + fileName);
		return false;
	}

	short majorVer, minorVer;
	file >> majorVer;
	file >> minorVer;

	file >> width;
	file >> height;
	resize(width, height);

	for (unsigned int i = 0; i <= width; i++)
	{
		for (unsigned int j = 0; j <= height; j++)
		{
			file >> tiles[i][j];
			file >> red[i][j];
			file >> green[i][j];
			file >> blue[i][j];
		}
	}
	return true;
}

/*
 * Save a tile bitmap.
 *
 * fileName (in) - file to save to
 */
void tagTileBitmap::save(const STRING fileName) const
{

	CFile file(fileName, OF_CREATE | OF_WRITE);

	file << _T("TK3 TILEBITMAP");
	file << short(3);
	file << short(0);

	file << width;
	file << height;

	for (unsigned int i = 0; i <= width; i++)
	{
		for (unsigned int j = 0; j <= height; j++)
		{
			file << tiles[i][j];
			file << red[i][j];
			file << green[i][j];
			file << blue[i][j];
		}
	}

}

/*
 * Resize a tile bitmap.
 *
 * width (in) - new width
 * height (in) - new height
 */
void tagTileBitmap::resize(const int width, const int height)
{
	this->width = width;
	this->height = height;
	tiles.clear();
	red.clear();
	green.clear();
	blue.clear();
	for (unsigned int i = 0; i <= width; i++)
	{
		tiles.push_back(VECTOR_STR());
		VECTOR_STR &a = tiles.back();
		//
		red.push_back(VECTOR_SHORT());
		VECTOR_SHORT &b = red.back();
		//
		green.push_back(VECTOR_SHORT());
		VECTOR_SHORT &c = green.back();
		//
		blue.push_back(VECTOR_SHORT());
		VECTOR_SHORT &d = blue.back();
		for (unsigned int j = 0; j <= height; j++)
		{
			a.push_back(_T(""));
			b.push_back(0);
			c.push_back(0);
			d.push_back(0);
		}
	}
}

/*
 * Draw a tile bitmap, including tst.
 * Called when rendering sprite frames.
 */
bool tagTileBitmap::draw(CCanvas *cnv, 
						 CCanvas *cnvMask, 
						 const int x, 
						 const int y)
{
    const int xx = x / 32 + 1, yy = y / 32 + 1;

    for (int i = 0; i != width; i++)
	{
        for (int j = 0; j != height; j++)
		{
            if (!tiles[i][j].empty())
			{
                if (cnv)
				{
/*                
                   'Ambient levels determined in renderAnimationFrame *before*
                    'opening DC.

					'Declare variables defined in transRender if running
					'in toolkit3.exe project
					Dim addOnR As Double, addOnG As Double, addOnB As Double
*/
					if (!drawTileCnv(cnv, 
						TILE_PATH + tiles[i][j], 
						i + xx, j + yy,						
						red[i][j], // + addOnR, 
						green[i][j], // + addOnG, 
						blue[i][j], // + addOnB, 
						false, true, false, false)) return false;
                }                
                if (cnvMask)
				{                
					if (!drawTileCnv(cnvMask, 
						TILE_PATH + tiles[i][j],
						i + xx, j + yy,
						red[i][j],
						green[i][j],
						blue[i][j],
						true, true)) return false;                        
	             }
            }
			else
			{
                if (cnv && cnvMask)
				{
//                    Call canvasFillBox(cnv, x + i * 32, y + j * 32, x + 32 + i * 32, y + 32 + j * 32, TRANSP_COLOR_ALT)
//                    Call canvasFillBox(cnvMask, x + i * 32, y + j * 32, x + 32 + i * 32, y + 32 + j * 32, TRANSP_COLOR)
                }
            } // if (!theTileBmp.tiles[i][j].empty())
		}	// for (j)
	} // for (i)

	return true;        
}
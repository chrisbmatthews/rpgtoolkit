/*
 * All contents copyright 2003, 2004, 2005 Christopher Matthews or Contributors.
 * Various port optimizations copyright by Colin James Fitzpatrick, 2005.
 * All rights reserved. You may not remove this notice
 * Read license.txt for licensing details.
 */

/*
 * Inclusions.
 */
#include "board.h"
#include "sprite.h"
#include "paths.h"
#include "CFile.h"
#include "mbox.h"
#include "../movement/locate.h"
#include <malloc.h>

// Struct to temporarily hold locations for old items, programs.
typedef struct OBJ_POSITION
{
	short x, y, layer;
};

/*
 * Open a board. Note for old versions, all co-ordinates must be transformed into
 * pixel co-ordinates. (Isometrics to be done).
 *
 * fileName (in) - file to open
 */
bool tagBoard::open(const std::string fileName)
{
	extern std::string g_projectPath;
	extern LPBOARD g_pBoard;

	CFile file(fileName);

	if (!file.isOpen())
	{
		messageBox("File not found: " + fileName);
		return false;
	}

	strFilename = removePath(fileName);

	file.seek(14);
	char cUnused;
	file >> cUnused;
	file.seek(0);
	if (cUnused)
	{
		messageBox("Please save " + fileName + " in the editor.");
		return false;
	}

	std::string fileHeader;
	file >> fileHeader;

	if (fileHeader != "RPGTLKIT BOARD")
	{
		messageBox("Please save " + fileName + " in the editor.");
		return false;
	}

	short majorVer, minorVer;
	file >> majorVer;
	file >> minorVer;

	if (minorVer < 2)
	{
		messageBox("Please save " + fileName + " in the editor.");
		return false;
	}

	int regYN;
	std::string regCode;
	file >> regYN;
	file >> regCode;

	file >> bSizeX;
	file >> bSizeY;
	file >> bSizeL;
	setSize(bSizeX, bSizeY, bSizeL);

	file >> playerX;
	file >> playerY;
	file >> playerLayer;
	file >> brdSavingYN;
    
	short lutSize;
	file >> lutSize;
	tileIndex.clear();

	unsigned int i;
	hasAnmTiles = false;
	for (i = 0; i <= lutSize; i++)
	{
		std::string entry;
		file >> entry;
		tileIndex.push_back(entry);
		if (!entry.empty())
		{
			const std::string ext = getExtension(entry);
			if (_stricmp(ext.c_str(), "TAN") == 0)
			{
				anmTileLUTIndices.push_back(i);
				hasAnmTiles = true;
			}
		}
	}

	unsigned int x, y, l;
	for (l = 1; l <= bSizeL; l++)
	{
		for (y = 1; y <= bSizeY; y++)
		{
			for (x = 1; x <= bSizeX; x++)
			{
				short test;
				file >> test;

				// Determine if the layer contains tiles.
				if (test) bLayerOccupied[l] = true;

				if (test < 0)
				{
					test = -test;
					short bb, rr, gg, bl;
					char tt;
					file >> bb;
					file >> rr;
					file >> gg;
					file >> bl;
					file >> tt;
					for (unsigned int cnt = 1; cnt <= test; cnt++)
					{
						board[x][y][l] = bb;
						ambientRed[x][y][l] = rr;
						ambientGreen[x][y][l] = gg;
						ambientBlue[x][y][l] = bl;
						tiletype[x][y][l] = tt;
						std::vector<int>::const_iterator i = anmTileLUTIndices.begin();
						for (; i != anmTileLUTIndices.end(); ++i)
						{
							if (board[x][y][l] == *i)
							{
								addAnimTile(tileIndex[board[x][y][l]], x, y, l);
							}
						}
						if (++x > bSizeX)
						{
							x = 1;
							if (++y > bSizeY)
							{
								y = 1;
								if (++l > bSizeL)
								{
									goto lutEnd;
								}
							}
						}
					}
					x--;
				}
				else
				{
					board[x][y][l] = test;
					file >> ambientRed[x][y][l];
					file >> ambientGreen[x][y][l];
					file >> ambientBlue[x][y][l];
					file >> tiletype[x][y][l];
					std::vector<int>::const_iterator i = anmTileLUTIndices.begin();
					for (; i != anmTileLUTIndices.end(); ++i)
					{
						if (board[x][y][l] == *i)
						{
							addAnimTile(tileIndex[board[x][y][l]], x, y, l);
						}
					}
				}
			}
		}
	}
lutEnd:

	file >> brdBack;
	file >> brdFore;
	file >> borderBack;
	file >> brdColor;
	file >> borderColor;
	file >> ambientEffect;

	dirLink.clear();
	for (i = 1; i <= 4; i++)
	{
		std::string link;
		file >> link;
		dirLink.push_back(link);
	}

	file >> boardSkill;
	file >> boardBackground;
	file >> fightingYN;
	file >> boardDayNight;
	file >> boardNightBattleOverride;
	file >> boardSkillNight;
	file >> boardBackgroundNight;

	brdConst.clear();
	for (i = 0; i <= 10; i++)
	{
		short sConst;
		file >> sConst;
		brdConst.push_back(sConst);
	}

	file >> boardMusic;

	boardTitle.clear();
	for (i = 0; i <= 8; i++)
	{
		std::string title;
		file >> title;
		boardTitle.push_back(title);
	}

	short numPrg;
	file >> numPrg;

	freePrograms();

	// Temporary vector to hold locations until isometric byte is read.
	std::vector<OBJ_POSITION> prgPos;

	for (i = 0; i <= numPrg; i++)
	{
		LPBRD_PROGRAM prg = new BRD_PROGRAM();
		OBJ_POSITION pos = {0, 0, 0};

		file >> prg->fileName;
		file >> pos.x;
		file >> pos.y;
		file >> prg->layer;
		file >> prg->graphic;
		file >> prg->activate;
		file >> prg->initialVar;
		file >> prg->finalVar;
		file >> prg->initialValue;
		file >> prg->finalValue;
		file >> prg->activationType;

		if (!prg->fileName.empty())
		{
			// Add the program to the list.
			programs.push_back(prg);

			// Can't form vector here because we don't know
			// if the board is isometric yet.
			prgPos.push_back(pos);
		}
		else
		{
			delete prg;
		}
	}

	file >> enterPrg;
	file >> bgPrg;

	short numSpr;
	file >> numSpr;

	freeItems();

	// Temporary vector to hold locations until isometric byte is read.
	std::vector<OBJ_POSITION> itemPos;

	for (i = 0; i <= numSpr; ++i)
	{
		BRD_SPRITE spr;
		OBJ_POSITION pos = {0, 0, 0};

		file >> spr.fileName;

		// Look after these.
		file >> pos.x;
		file >> pos.y;
		file >> pos.layer;

		file >> spr.activate;
		file >> spr.initialVar;
		file >> spr.finalVar;
		file >> spr.initialValue;
		file >> spr.finalVar;
		file >> spr.activationType;
		file >> spr.prgActivate;
		file >> spr.prgMultitask;

		if (!spr.fileName.empty() && (this == g_pBoard))
		{
			// Create new instance but don't load file just yet.
			CItem *pItem = new CItem(spr);
			items.push_back(pItem);

			// Hold onto location until isometric byte is read.
			itemPos.push_back(pos);
		}
	}

	threads.clear();
	if (minorVer >= 3)
	{
		int tCount;
		file >> tCount;
		for (i = 0; i <= tCount; i++)
		{
			std::string thread;
			file >> thread;
			threads.push_back(thread);
		}
	}

	if (minorVer > 2)
	{
		char coord;
		file >> coord;
		coordType = COORD_TYPE(coord);
	}

	freeVectors();
	for (i = 1; i <= bSizeL; i++)
	{
		// Vectorize in all instances - we might be testing a linked board.
		vectorize(i);
	}

	if (this == g_pBoard) 
	{
		// Required only for the active board.

		createVectorCanvases();

		// Create program bases.
		std::vector<LPBRD_PROGRAM>::iterator p = programs.begin();
		std::vector<OBJ_POSITION>::iterator pos = prgPos.begin();
		for (; p != programs.end(); ++p, ++pos)
		{
			if (coordType & ISO_STACKED)
			{
				// Column offset (old co-ordinate system).
				const double dx = (pos->y % 2 ? 0 : 32);

				// Isometric diamond at the location (3.0-).
				(*p)->vBase.push_back((pos->x - 1.0) * 64.0 - dx, (pos->y - 1.0) * 16.0);
				(*p)->vBase.push_back((pos->x - 0.5) * 64.0 - dx, (pos->y - 2.0) * 16.0);
				(*p)->vBase.push_back(pos->x * 64.0 - dx, (pos->y - 1.0) * 16.0);
				(*p)->vBase.push_back((pos->x - 0.5) * 64.0 - dx, pos->y * 16.0);
			}
			else
			{
				// Create a 32x32 vector at the location.
				(*p)->vBase.push_back((pos->x - 1.0) * 32.0, pos->y * 32.0);
				(*p)->vBase.push_back(pos->x * 32.0, pos->y * 32.0);
				(*p)->vBase.push_back(pos->x * 32.0, (pos->y - 1.0) * 32.0);
				(*p)->vBase.push_back((pos->x - 1.0) * 32.0, (pos->y - 1.0) * 32.0);
			}
			(*p)->vBase.close(true, 0);
		}

		// Load items (after isometric data is read from board).
		std::vector<CItem *>::iterator itm = items.begin();
		pos = itemPos.begin();
		for (; itm != items.end(); ++itm, ++pos)
		{
			// Open file stored in CItem::m_brdData.fileName and set position.
			(*itm)->open();
			(*itm)->setPosition(pos->x, pos->y, pos->layer, coordType);
		}

	} // if (this == g_pBoard) 

	return true;
}

/*
 * Convert the tiletype array to vectors.
 *
 * layer (in) - layer to vectorize
 */
void tagBoard::vectorize(const unsigned int layer)
{
	// TO DO: n/s e/w types (2D only, no iso support).

	// Some old tiletype defines for this function.
	#define NORTH_SOUTH 3
	#define EAST_WEST 4
	#define STAIRS1 11
	#define STAIRS8 18

	unsigned int i, j, width = bSizeX, height = bSizeY;

	if (coordType & ISO_STACKED)
	{
		// For old isometrics, transform the layer to the rotated
		// co-ordinate system, so we can apply the same routine.

		// Determine the transformed dimensions.
		double x = bSizeX, y = bSizeY;
		isoCoordTransform(x, y, x, y);

		// New iso board is effectively "square", but with many empty entries.
		width = height = x;
	}

	bool *const pFinished = (bool *)_alloca(width * height);
	memset(pFinished, 0, width * height);

	// Local array of the tiletype.
	int *const pTypes = (int *)_alloca(width * height * sizeof(int));
	memset(pTypes, 0, width * height * sizeof(int));

	// Create a new array to work from (iso rotated, or the standard 2D).
	for (i = 0; i < bSizeX; ++i)
	{
		for (j = 0; j < bSizeY; ++j)
		{
			if (coordType & ISO_STACKED)
			{
				// Transform this co-ordinate.
				double x = 0, y = 0;
				isoCoordTransform(i + 1, j + 1, x, y);
				// Enter its type in the new array.
				pTypes[height * int(x) + int(y)] = tiletype[i + 1][j + 1][layer];
			}
			else
			{
				// Just copy the value across.
				pTypes[height * (i + 1) + (j + 1)] = tiletype[i + 1][j + 1][layer];
			}
		}
	}

	while (true)
	{
		/*
		 * Working southeast from the top-left corner, locate
		 * the first tile that is neither "normal" nor included
		 * in any vector.
		 */
		unsigned int x = 0, y, i, j;
		for (i = 0; i < width; ++i)
		{
			for (j = 0; j < height; ++j)
			{
				if (!pFinished[height * i + j] && pTypes[height * (i + 1) + (j + 1)])
				{
					// More effective method?
					x = i + 1;
					y = j + 1;
					i = width + 1;
					break;
				}
			}
		}
		// If there are none left, exit.
		if (x == 0) break;

		// Store current x and y, and the tile type as this position.
		const unsigned int type = pTypes[height * x + y], origX = x, origY = y;

		// Find the lowest point where this type stops.
		while ((y < height) && (pTypes[height * x + y + 1] == type)) y++;

		while (x < width)
		{
			/*
			 * Check whether this column, to the height of the first
			 * one found, contains the type of the current vector.
			 */
			bool column = true;
			for (i = origY; i <= y; i++)
			{
				if (pTypes[height * (x + 1) + i] != type)
				{
					// It doesn't, so stop here.
					column = false;
					break;
				}
			}
			if (!column) break;
			// Move onto the next column.
			x++;
		}

		// Mark off the tiles in this rectangle as in a vector.
		for (i = origX - 1; i < x; i++)
		{
			memset(pFinished + height * i + origY - 1, 1, y - origY + 1);
		}

		// Create the vector and add it to the board's list.
		BRD_VECTOR vector;
		if (coordType & ISO_STACKED)
		{
			vector.pV = new CVector(((origX - 1) - (origY - 1) + bSizeX) * 32, ((origX - 1) + (origY - 1) - bSizeX) * 16, 4, type);
			vector.pV->push_back(((origX - 1) - y + bSizeX) * 32, ((origX - 1) + y - bSizeX) * 16);
			vector.pV->push_back((x - y + bSizeX) * 32, (x + y - bSizeX) * 16);
			vector.pV->push_back((x - (origY - 1) + bSizeX) * 32, (x + (origY - 1) - bSizeX) * 16);
		}
		else
		{
			vector.pV = new CVector((origX - 1) * 32, (origY - 1) * 32, 4, type);
			vector.pV->push_back((origX - 1) * 32, y * 32);
			vector.pV->push_back(x * 32, y * 32);
			vector.pV->push_back(x * 32, (origY - 1) * 32);
		}
		vector.pV->close(true, 0);
		vector.layer = layer;
		vector.type = TILE_TYPE(type);

		if (type >= STAIRS1 && type <= STAIRS8)
		{
			// Old stairs are stored as targetLayer + 10.
			vector.attributes = type - 10;
			vector.type = TT_STAIRS;
		}

		vectors.push_back(vector);
	}

}

/*
 * Create canvases from a board's vectors.
 */
void tagBoard::createVectorCanvases(void)
{
	// After vectorize() on old formats.
	
	CONST LONG SOLID_COLOR = 0;

	for (std::vector<BRD_VECTOR>::iterator i = vectors.begin(); i != vectors.end(); ++i)
	{
		// Only need to do this for under tiles.
		if (!(i->type & TT_UNDER)) continue;

		// Get the bounding box of the vector.
		const RECT r = i->pV->getBounds();

		i->pCnv = new CGDICanvas();
		i->pCnv->CreateBlank(NULL, r.right - r.left, r.bottom - r.top, TRUE);
		i->pCnv->ClearScreen(TRANSP_COLOR);

		// Inflate to align to the grid (iso or 2D).
		const RECT rAlign = {r.left - r.left % 32,
							r.top - r.top % 32,
							r.right - r.right % 32 + 32,
							r.bottom - r.bottom % 32 + 32};

		// Create an intermediate canvas that is aligned to the grid.
		CGDICanvas *cnv = new CGDICanvas();
		cnv->CreateBlank(NULL, rAlign.right - rAlign.left, rAlign.bottom - rAlign.top, TRUE);
		cnv->ClearScreen(TRANSP_COLOR);

		// Create a mask from the vector on the vector's canvas.
		if (i->pV->createMask(i->pCnv, r.left, r.top, SOLID_COLOR))
		{
			// Was drawn if vector was closed.

			// Determine whether all layers below the under vector
			// are affected, or just the specified layer.
			const int lLower = (i->attributes & TA_ALL_LAYERS_BELOW ? 1 : i->layer); 

			// Draw the board layer within the bounds to the intermediate canvas.
			render (cnv, 
					0, 0, lLower, i->layer,  
					rAlign.left, rAlign.top, 
					rAlign.right - rAlign.left, 
					rAlign.bottom - rAlign.top,
					0, 0, 0);
			
			// Blt the mask onto the canvas. In this case we want
			// the *solid* colour on the mask to be transparent.
			i->pCnv->BltTransparentPart(cnv, 
										r.left % 32, r.top % 32, 
										0, 0, 
										r.right - r.left, 
										r.bottom - r.top, 
										SOLID_COLOR);

			// Blt the vector area back to the vector's canvas.
			// (Note: it may seem easier to put the mask on the intermediate
			// canvas, but this results in a larger vector canvas that
			// is harder to manipulate.)
			cnv->BltPart(i->pCnv, 
						0, 0, 
						r.left % 32, r.top % 32, 
						r.right - r.left, 
						r.bottom - r.top, 
						SRCCOPY);
		}
		else
		{
			// No need to keep this canvas.
			delete i->pCnv;
			i->pCnv = NULL;
		}

		delete cnv;

	}
}

void tagBoard::render(CGDICanvas *cnv,
			   int destX, const int destY,			// canvas destination.
			   const int lLower, const int lUpper,	// layer bounds. 
			   int topX, int topY,					// pixel location on board to start from. 
			   int width, int height,				// pixel dimensions to draw. 
			   const int aR, const int aG, const int aB)
{
	// Tile dimensions.
	const int tWidth = (isIsometric() ? 64 : 32),
			  tHeight = (isIsometric() ? 16 : 32);

	// Number of tiles to draw in each dimension.
	int nWidth = (width + topX > pxWidth() ? pxWidth() - topX : width) / tWidth,
		nHeight = (height + topY > pxHeight() ? pxHeight() - topY : height) / tHeight;

	// Grow the board to draw the outer edges (of large boards).
	if (coordType & ISO_STACKED) 
	{ 
		++nWidth; 
		++nHeight; 

		// Note to self: could be dangerous.
		if (topX % 64) destX -= 32;
	}

	// Is the top-left corner at the corner of a tile or at the centre?
	const int parity = !(topY % 32);

	// Tile start co-ordinates.
	topX /= tWidth;
	topY /= tHeight;
	
	// For each layer
	for (unsigned int i = lLower; i <= lUpper; ++i)
	{
		if (!bLayerOccupied[i]) continue;

		// For the x axis
		for (unsigned int j = 1; j <= nWidth; ++j)
		{
			// For the y axis
			for (unsigned int k = 1; k <= nHeight; ++k)
			{
				// The tile co-ordinates.
				const int x = j + topX, y = k + topY;
				
				if (board[x][y][i])
				{
					const std::string strTile = tileIndex[board[x][y][i]];
					if (!strTile.empty())
					{
						// Tile exists at this location.
						drawTile(strTile, 
								 j, k, 
								 ambientRed[x][y][i] + aR,
								 ambientGreen[x][y][i] + aG,
								 ambientBlue[x][y][i] + aB,
								 cnv, 
								 destX, destY,
								 isIsometric(), 
								 parity);

					} // if (!strTile.empty())
				} // if (brd.board[x][y][i])
			} // for k
		} // for j
	} // for i

}

inline int tagBoard::pxWidth(void) 
{
	if (coordType & ISO_STACKED) return bSizeX * 64 - 32;
	if (coordType & ISO_ROTATED) return 0;
	return bSizeX * 32;			// TILE_NORMAL.
}

inline int tagBoard::pxHeight(void) 
{ 
	if (coordType & ISO_STACKED) return bSizeY * 16 - 16;
	if (coordType & ISO_ROTATED) return 0;
	return bSizeY * 32;			// TILE_NORMAL.
}

/*
 * Free vectors.
 */
void tagBoard::freeVectors(void)
{
	for (std::vector<BRD_VECTOR>::iterator i = vectors.begin(); i != vectors.end(); ++i)
	{
		delete i->pCnv;
		delete i->pV;
	}
	vectors.clear();
}

/*
 * Free programs.
 */
void tagBoard::freePrograms(void)
{
	for (std::vector<LPBRD_PROGRAM>::iterator i = programs.begin(); i != programs.end(); ++i)
	{
		delete *i;
	}
	programs.clear();
}

/*
 * Delete items.
 */
void tagBoard::freeItems(void)
{
	for (std::vector<CItem *>::iterator i = items.begin(); i != items.end(); ++i)
	{
		delete *i;
	}
	items.clear();
}

/*
 * Add an animated tile to the board.
 *
 * fileName (in) - tile to add
 * x (in) - x position on board
 * y (in) - y position on board
 * z (in) - z position on board
 */
void tagBoard::addAnimTile(const std::string fileName, const int x, const int y, const int z)
{
	static std::string lastAnimFile;
	static TILEANIM lastAnim;
	if (_stricmp(lastAnimFile.c_str(), fileName.c_str()) != 0)
	{
		extern std::string g_projectPath;
		lastAnim.open(g_projectPath + TILE_PATH + fileName);
		lastAnimFile = fileName;
	}
	BOARD_TILEANIM anim;
	anim.tile = lastAnim;
	anim.x = x;
	anim.y = y;
	anim.z = z;
	animatedTile.push_back(anim);
}

/*
 * Set the board's size.
 *
 * width (in) - new width
 * height (in) - new height
 * depth (in) - new depth
 */
void tagBoard::setSize(const int width, const int height, const int depth)
{
	bSizeX = width;
	bSizeY = height;
	bSizeL = depth;
	{
		VECTOR_SHORT row;
		VECTOR_SHORT2D face;
		unsigned int i;
		for (i = 0; i <= bSizeL; i++)
		{
			row.push_back(0);
			bLayerOccupied.push_back(false);
		}
		for (i = 0; i <= bSizeY; i++) face.push_back(row);
		ambientBlue.clear();
		for (i = 0; i <= bSizeX; i++) ambientBlue.push_back(face);
		board = ambientRed = ambientGreen = ambientBlue;
	}
	{
		VECTOR_CHAR row;
		VECTOR_CHAR2D face;
		unsigned int i;
		for (i = 0; i <= bSizeL; i++) row.push_back('\0');
		for (i = 0; i <= bSizeY; i++) face.push_back(row);
		tiletype.clear();
		for (i = 0; i <= bSizeX; i++) tiletype.push_back(face);
	}
}

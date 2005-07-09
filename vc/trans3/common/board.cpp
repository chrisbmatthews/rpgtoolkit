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
#include "../movement/CItem/CItem.h"
#include "paths.h"
#include "CFile.h"

/*
 * Open a board. Note for old versions, all co-ordinates must be transformed into
 * pixel co-ordinates. (Isometrics to be done).
 *
 * fileName (in) - file to open
 */
void tagBoard::open(const std::string fileName)
{
	extern std::string g_projectPath;
	extern std::vector<CItem *> g_items;
	extern BOARD g_activeBoard;

	CFile file(fileName);

	bSizeX = 50;
	bSizeY = 50;
	bSizeL = 8;

	strFilename = removePath(fileName);

	file.seek(14);
	char cUnused;
	file >> cUnused;
	file.seek(0);
	if (!cUnused)
	{

		std::string fileHeader;
		file >> fileHeader;

		if (fileHeader != "RPGTLKIT BOARD")
		{
			file.seek(0);
			goto ver1;
		}

		short majorVer, minorVer;
		file >> majorVer;
		file >> minorVer;

		if (minorVer < 2)
		{
			file.seek(0);
			goto ver2;
		}

		int regYN;
		std::string regCode;
		file >> regYN;
		file >> regCode;

		file >> bSizeX;
		file >> bSizeY;
		file >> bSizeL;
		setSize(bSizeX, bSizeY, bSizeL);

		// All co-ordinates are PIXEL co-ordinates.
		file >> playerX; playerX *= 32;
		file >> playerY; playerY *= 32;
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
							unsigned int tAnm;
							const int len = anmTileLUTIndices.size();
							for (tAnm = 0; tAnm < len; tAnm++)
							{
								if (board[x][y][l] == anmTileLUTIndices[tAnm])
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
						unsigned int tAnm;
						const int len = anmTileLUTIndices.size();
						for (tAnm = 0; tAnm < len; tAnm++)
						{
							if (board[x][y][l] == anmTileLUTIndices[tAnm])
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
		file >> BoardDayNight;
		file >> BoardNightBattleOverride;
		file >> BoardSkillNight;
		file >> BoardBackgroundNight;

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

		for (i = 0; i <= numPrg; i++)
		{
			LPBRD_PROGRAM prg = new BRD_PROGRAM();
			short x = 0, y = 0;

			file >> prg->fileName;
			file >> x;				// Not needed in struct.
			file >> y;
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
				// Create a 32x32 vector at the location.
				prg->vBase.push_back((x - 1.0) * 32.0, y * 32.0);
				prg->vBase.push_back(x * 32.0, y * 32.0);
				prg->vBase.push_back(x * 32.0, (y - 1.0) * 32.0);
				prg->vBase.push_back((x - 1.0) * 32.0, (y - 1.0) * 32.0);
				prg->vBase.close(true, 0);
				// Add the program to the list.
				programs.push_back(prg);
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

		for (i = 0; i <= numSpr; ++i)
		{
			BRD_SPRITE spr;

			std::string sprFileName;
			short x, y, layer;

			// Do not need to save these.
			file >> sprFileName;
			file >> x;
			file >> y;
			file >> layer;

			file >> spr.activate;
			file >> spr.initialVar;
			file >> spr.finalVar;
			file >> spr.initialValue;
			file >> spr.finalVar;
			file >> spr.activationType;
			file >> spr.prgActivate;
			file >> spr.prgMultitask;

			if (!sprFileName.empty())
			{
				// Only load the items if this is the active board
				// (we may be loading the board for other purposes).
				if (this == &g_activeBoard)
				{
					g_items.push_back(new CItem(g_projectPath + ITM_PATH + sprFileName, spr));
					g_items.back()->setPosition(x * 32, y * 32, layer);
				}
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
			file >> isIsometric;
		}

	}
	else
	{
ver2:

		if (file.line() != "RPGTLKIT BOARD")
		{
			file.seek(0);
			goto ver1;
		}

		const int majorVer = atoi(file.line().c_str());
		const int minorVer = atoi(file.line().c_str());

		file.line();
		file.line();

		if (minorVer == 1)
		{
			bSizeX = atoi(file.line().c_str());
			bSizeY =  atoi(file.line().c_str());
			setSize(bSizeX, bSizeY, bSizeL);
		}
		else if (minorVer == 0)
		{
			setSize(19, 11, 8);
		}

		unsigned int x, y, l;
		for (x = 1; x <= bSizeX; x++)
		{
			for (y = 1; y <= bSizeY; y++)
			{
				for (l = 1; l <= bSizeL; l++)
				{
					// setTile(x, y, l, file.line());
					ambientRed[x][y][l] = atoi(file.line().c_str());
					ambientGreen[x][y][l] = atoi(file.line().c_str());
					ambientBlue[x][y][l] = atoi(file.line().c_str());
					tiletype[x][y][l] = atoi(file.line().c_str());
				}
			}
		}

		brdBack = file.line();
		borderBack = file.line();
		brdColor = atoi(file.line().c_str());
		borderColor = atoi(file.line().c_str());
		ambientEffect = atoi(file.line().c_str());

		unsigned int i;

		dirLink.clear();
		for (i = 1; i <= 4; i++)
		{
			dirLink.push_back(file.line());
		}

		boardSkill = atoi(file.line().c_str());
		boardBackground = file.line();
		fightingYN = atoi(file.line().c_str());

		brdConst.clear();
		for (i = 1; i <= 10; i++)
		{
			brdConst.push_back(atoi(file.line().c_str()));
		}

		boardMusic = file.line();

		boardTitle.clear();
		for (i = 1; i <= 8; i++)
		{
			boardTitle.push_back(file.line());
		}

		for (i = 0; i <= 50; i++)
		{
			programName.push_back(file.line());
			progX.push_back(atoi(file.line().c_str()));
			progY.push_back(atoi(file.line().c_str()));
			progLayer.push_back(atoi(file.line().c_str()));
			progGraphic.push_back(file.line());
			progActivate.push_back(atoi(file.line().c_str()));
			progVarActivate.push_back(file.line());
			progDoneVarActivate.push_back(file.line());
			activateInitNum.push_back(file.line());
			activateDoneNum.push_back(file.line());
			activationType.push_back(atoi(file.line().c_str()));
		}

		itmName.clear();
		itmX.clear();
		itmY.clear();
		itmLayer.clear();
		itmActivate.clear();
		itmVarActivate.clear();
		itmDoneVarActivate.clear();
		itmActivateInitNum.clear();
		itmActivateDoneNum.clear();
		itmActivationType.clear();
		itemProgram.clear();
		itemMulti.clear();

		for (i = 0; i <= 10; i++)
		{
			itmName.push_back(file.line());
			itmX.push_back(atoi(file.line().c_str()));
			itmY.push_back(atoi(file.line().c_str()));
			itmLayer.push_back(atoi(file.line().c_str()));
			itmActivate.push_back(atoi(file.line().c_str()));
			itmVarActivate.push_back(file.line());
			itmDoneVarActivate.push_back(file.line());
			itmActivateInitNum.push_back(file.line());
			itmActivateDoneNum.push_back(file.line());
			itmActivationType.push_back(atoi(file.line().c_str()));
		}

		playerX = atoi(file.line().c_str());
		playerY = atoi(file.line().c_str());
		playerLayer = atoi(file.line().c_str());

		for (i = 0; i <= 10; i++)
		{
			itemProgram.push_back(file.line());
		}

		brdSavingYN = atoi(file.line().c_str());

		for (i = 0; i <= 10; i++)
		{
			itemMulti.push_back(file.line());
		}

		BoardDayNight = atoi(file.line().c_str());
		BoardNightBattleOverride = atoi(file.line().c_str());
		BoardSkillNight = atoi(file.line().c_str());
		BoardBackgroundNight = atoi(file.line().c_str());

	}

ver1:

	if (this != &g_activeBoard) return;

	// Finally, vectorize the board.
	vectorize(playerLayer);
	createVectorCanvases();

}

/*
 * Convert the tiletype array to vectors.
 *
 * layer (in) - layer to vectorize
 */
void tagBoard::vectorize(const unsigned int layer)
{

	// Free old vectors.
	freeVectors();

	/*
	 * Initialize a vector to store whether each tile is
	 * included within a vector.
	 */
	typedef std::vector<bool> VECTOR_BOOL;
	std::vector<VECTOR_BOOL> finished;
	{
		VECTOR_BOOL row;
		unsigned int i;
		for (i = 0; i < bSizeY; i++) row.push_back(false);
		for (i = 0; i < bSizeX; i++) finished.push_back(row);
	}

	while (true)
	{
		/*
		 * Working southeast from the top-left corner, locate
		 * the first tile that is neither "normal" nor included
		 * in any vector.
		 */
		unsigned int x = 0, y, i, j;
		for (i = 0; i < bSizeX; i++)
		{
			for (j = 0; j < bSizeY; j++)
			{
				if (!finished[i][j] && tiletype[i + 1][j + 1][layer])
				{
					// More effective method?
					x = i + 1;
					y = j + 1;
					i = bSizeX + 1;
					break;
				}
			}
		}
		// If there are none left, exit.
		if (x == 0) break;

		// Store current x and y, and the tile type as this position.
		const unsigned int type = tiletype[x][y][layer], origX = x, origY = y;

		// Find the lowest point where this type stops.
		while ((y < bSizeY) && (tiletype[x][y + 1][layer] == type)) y++;

		while (x < bSizeX)
		{
			/*
			 * Check whether this column, to the height of the first
			 * one found, contains the type of the current vector.
			 */
			bool column = true;
			for (i = origY; i <= y; i++)
			{
				if (tiletype[x + 1][i][layer] != type)
				{
					// It doesn't; stop here.
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
			for (j = origY - 1; j < y; j++)
			{
				// Better way?
				finished[i][j] = true;
			}
		}

		// Create the vector and add it the board's list.
		// - Note that different math is required here for isometrics, but
		//   all isometrics are currently broken, so it is difficult to implement.
		BRD_VECTOR vector;
		vector.pV = new CVector((origX - 1) * 32, (origY - 1) * 32, 4, type);
		vector.pV->push_back((origX - 1) * 32, y * 32);
		vector.pV->push_back(x * 32, y * 32);
		vector.pV->push_back(x * 32, (origY - 1) * 32);
		vector.pV->close(true, 0);
		vector.layer = layer;
		vector.type = TILE_TYPE(type);
		vectors.push_back(vector);
	}

}

/*
 *
 */
void tagBoard::createVectorCanvases(void)
{
	// After vectorize() on old formats.

	CONST LONG SOLID_COLOR = 0;

	for (std::vector<BRD_VECTOR>::iterator i = vectors.begin(); i != vectors.end(); ++i)
	{
		// Only need to do this for under tiles.
		// Tile type doesn't need to be in CVector!
		if (!(i->type & TT_UNDER)) continue;

		// Get the bounding box of the vector.
		const RECT r = i->pV->getBounds();

		i->pCnv = new CGDICanvas();
		i->pCnv->CreateBlank(NULL, r.right - r.left, r.bottom - r.top, TRUE);
		i->pCnv->ClearScreen(TRANSP_COLOR);

		// Inflate to align to the grid.
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

			// Draw the board layer within the bounds to the intermediate canvas.
			drawBoard(*this, cnv, 
					  0, 0, 
					  i->layer, 
					  rAlign.left / 32, rAlign.top / 32, 
					  (rAlign.right - rAlign.left) / 32, 
					  (rAlign.bottom - rAlign.top) / 32,
					  0, 0, 0, false);

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
 * Delete all *global* items (in g_items).
 */
void tagBoard::freeItems(void)
{
	extern BOARD g_activeBoard;
	extern std::vector<CItem *> g_items;

	// Only delete items if we're changing boards.
	if (this != &g_activeBoard) return;

	for (std::vector<CItem *>::iterator i = g_items.begin(); i != g_items.end(); ++i)
	{
		delete *i;
	}
	g_items.clear();
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
		for (i = 0; i <= bSizeL; i++) row.push_back(0);
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

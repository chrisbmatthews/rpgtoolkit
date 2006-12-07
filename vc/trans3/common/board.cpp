/*
 ********************************************************************
 * The RPG Toolkit, Version 3
 * This file copyright (C) 2006  Christopher Matthews & contributors
 *
 * Contributors:
 *    - Colin James Fitzpatrick
 *    - Jonathan D. Hughes
 ********************************************************************
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 */

/*
 * Inclusions.
 */
#include "board.h"
#include "sprite.h"
#include "paths.h"
#include "CFile.h"
#include "mbox.h"
#include "mainfile.h"
#include "../movement/CItem/CItem.h"
#include "../rpgcode/CProgram.h"
#include "../misc/misc.h"
#include "../../tkCommon/images/FreeImage.h"
#include "../../tkCommon/tkgfx/CTile.h"

/*
 * "Ambient effect" definitions.
 */
const RGB_SHORT BRD_AMBIENT[] = {
	{  0,   0,   0},
	{ 75,  75,  75},		// "Mist".
	{-75, -75, -75},		// "Dark".
	{  0,   0,  75}			// "Water".
};

/*
 * Open a board. Note for old versions, all co-ordinates must be transformed into
 * pixel co-ordinates. (Isometrics to be done).
 *
 * fileName (in) - file to open
 */
bool tagBoard::open(const STRING fileName, const bool startThreads)
{
	extern STRING g_projectPath;
	extern LPBOARD g_pBoard;

	CFile file(fileName);

	if (!file.isOpen())
	{
		messageBox(_T("File not found: ") + fileName);
		return false;
	}

	// Preserve subfolder to ensure loading from saved file.
	this->filename = removePath(fileName, BRD_PATH);

	file.seek(14);
	char cUnused;
	file >> cUnused;
	file.seek(0);
	if (cUnused)
	{
		// Version 2 board.
		messageBox(_T("Please save ") + fileName + _T(" in the editor."));
		return false;
	}

	STRING fileHeader;
	file >> fileHeader;

	if (fileHeader != _T("RPGTLKIT BOARD"))
	{
		// Version 1 board.
		messageBox(_T("Please save ") + fileName + _T(" in the editor."));
		return false;
	}

	short majorVer, minorVer;
	file >> majorVer;
	file >> minorVer;

	switch (minorVer)
	{
	case 0:
	case 1:
		messageBox(_T("Please save ") + fileName + _T(" in the editor."));
		return false;
	case 2:
	case 3:
		goto pvVersion;
	}

vVersion:
	{
		// 3.0.7 vector implementation.

		short var;
		file >> var; sizeX = int(var);
		file >> var; sizeY = int(var);
		file >> var; sizeL = int(var);
		file >> var; coordType = COORD_TYPE(var);

		// Effective matrix dimensions.
		const int effectiveWidth = (coordType & ISO_ROTATED ? sizeX + sizeY : sizeX); 
		const int effectiveHeight = (coordType & ISO_ROTATED ? sizeX + sizeY : sizeY);

		// Dimension the board matrices.
		setSize(effectiveWidth, effectiveHeight, sizeL, false);

		// Build the tile look-up-table.
		short lutSize;
		file >> lutSize;
		tileIndex.clear();
		animatedTiles.clear();

		// Temporarily to hold animated tile indices.
		std::vector<int> tanLutIndices;

		for (int i = 0; i <= lutSize; ++i)
		{
			STRING entry;
			file >> entry;

			tileIndex.push_back(entry);
			if (!entry.empty())
			{
				if (_stricmp(getExtension(entry).c_str(), _T("TAN")) == 0)
				{
					// Indices that point to animated tiles.
					tanLutIndices.push_back(i);
				}
			}
		}

		// Tile index block.
		int x, y, z;
		for (z = 1; z <= sizeL; ++z)
		{
			for (y = 1; y <= effectiveHeight; ++y)
			{
				for (x = 1; x <= effectiveWidth; ++x)
				{
					short index = 0, count = 0;
					file >> index;

					if (index < 0)
					{
						// Compression: stream of identical tiles 'test' long. 
						count = -index;
						short r, b, g;
						file >> index;

						// Determine if the layer contains tiles.
						// [0] indicates if the whole board contains tiles.
						if (index) bLayerOccupied[z] = bLayerOccupied[0] = LO_TILES;

						for (short i = 1; i <= count; ++i)
						{
							board[z][y][x] = index;

							std::vector<int>::const_iterator j = tanLutIndices.begin();
							for (; j != tanLutIndices.end(); ++j)
							{
								if (board[z][y][x] == *j)
								{
									LPBOARD_TILEANIM tan = addAnimTile(tileIndex[board[z][y][x]], x, y, z);

									// Change the LUT index to point to a TST.
									board[z][y][x] = tan->lutIndices[0];
								}
							}

							if (++x > effectiveWidth)
							{
								x = 1;
								if (++y > effectiveHeight)
								{
									y = 1;
									if (++z > sizeL)
									{
										goto lutEndA;
									}
									// Onto the next layer.
									if (index) bLayerOccupied[z] = LO_TILES;
								}
							}
						} // for(i)
						--x;
					}
					else // (index > 0)
					{
						if (index) bLayerOccupied[z] = bLayerOccupied[0] = LO_TILES;

						board[z][y][x] = index;
					
						std::vector<int>::const_iterator i = tanLutIndices.begin();
						for (; i != tanLutIndices.end(); ++i)
						{
							if (board[z][y][x] == *i)
							{
								LPBOARD_TILEANIM tan = addAnimTile(tileIndex[board[z][y][x]], x, y, z);

								// Change the LUT index to point to a TST.
								board[z][y][x] = tan->lutIndices[0];
							}
						}
					}
				} // for (x)
			} // for (y)
		} // for (z)
lutEndA:

        /// Tile shading (independent layer(s) stored in similar way to tiles)
		freeShading();
		short ub;
		file >> ub;
		for (z = 0; z <= ub; ++z)
		{
			LPLAYER_SHADE pLs = new LAYER_SHADE(effectiveWidth, effectiveHeight);
			LPRGB_MATRIX pMat = &pLs->shades;
			file >> pLs->layer;

			for (y = 1; y <= effectiveHeight; ++y)
			{
				for (x = 1; x <= effectiveWidth; ++x)
				{
					short count = 0;
					RGB_SHORT rgb = {0, 0, 0};
					file >> count;
					file >> rgb.r;
					file >> rgb.g;
					file >> rgb.b;

					if (count > 1)
					{
						for (short i = 1; i <= count; ++i)
						{
							(*pMat)[x][y] = rgb;

							if (++x > effectiveWidth)
							{
								x = 1;
								if (++y > effectiveHeight)
								{
									goto layerEnd;
								}
							}
						} // for(i)
						--x;
					}
					else
					{
						(*pMat)[x][y] = rgb;
					}
				} // for (x)
			} // for (y)
layerEnd:
			tileShading.push_back(pLs);
		} // for (z)

		// Lights.
		short pts;
		file >> ub;
		if (ub >= 0)
		{
			// Negative number indicates no objects.
			for (i = 0; i <= ub; ++i)
			{
				BRD_LIGHT light;
				short var;
				
				file >> light.layer;
				int type;
				file >> type; light.eType = LIGHT_TYPE(type);
				
				// Nodes.
				file >> pts;
				for (int j = 0; j <= pts; ++j)
				{
					file >> x;
					file >> y;
					const POINT pt = {x, y};
					light.nodes.push_back(pt);
				}

				// Colors.
				file >> pts;
				for (j = 0; j <= pts; ++j)
				{
					RGB_SHORT rgb = {0, 0, 0};
					file >> rgb.r;
					file >> rgb.g;
					file >> rgb.b;
					light.colors.push_back(rgb);
				}

				// Render light to tileShading array (single layer implementation).
				calculateLighting(tileShading[0]->shades, light, coordType, sizeX);

				// There is currently no need to store the lights permanently
				// since they cannot be altered once applied.
			}
		}

		// Vectors.
		freeVectors();
		file >> ub;
		if (ub >= 0)
		{
			// Negative number indicates no objects.
			vectors.reserve(ub);

			for (i = 0; i <= ub; ++i)
			{
				BRD_VECTOR vect;
				short var;
				vect.pV = new CVector();
				
				file >> pts;
				for (int j = 0; j <= pts; ++j)
				{
					file >> x;
					file >> y;
					vect.pV->push_back(double(x), double(y));
				}
				file >> var; vect.attributes = int(var);
				file >> var; vect.pV->close(var != 0);
				file >> var; vect.layer = int(var);
				file >> var; vect.type = TILE_TYPE(var);
				file >> vect.handle;
				
				vectors.push_back(vect);
			}
		}

		// Programs.
		freePrograms();
		file >> ub;
		if (ub >= 0)
		{
			programs.reserve(ub);

			for (i = 0; i <= ub; ++i)
			{
				LPBRD_PROGRAM prg = new BRD_PROGRAM();

				short var;
				file >> prg->fileName;
				file >> prg->initialVar;
				file >> prg->initialValue;
				file >> prg->finalVar;
				file >> prg->finalValue;
				file >> prg->activate;
				file >> prg->activationType;
				file >> var; prg->distanceRepeat = double(var);
				file >> prg->layer;

				file >> pts;
				for (int j = 0; j <= pts; ++j)
				{
					file >> x;
					file >> y;
					prg->vBase.push_back(double(x), double(y));
				}
				file >> var; prg->vBase.close(var != 0);

				STRING strReserved;
				file >> strReserved;		// For program handle (c.f. vector handle).
				
				programs.push_back(!prg->fileName.empty() ? prg : NULL);
			}
		}

		// Sprites.
		freeItems();
		file >> ub;
		if (ub >= 0)
		{
			// tbd: players?
			items.reserve(ub);

			for (i = 0; i <= ub; ++i)
			{
				BRD_SPRITE spr;
				short x, y, z, sReserved;
				file >> spr.fileName;
				file >> spr.prgActivate;
				file >> spr.prgMultitask;
				file >> spr.initialVar;
				file >> spr.initialValue;
				file >> spr.finalVar;
				file >> spr.finalValue;
				file >> spr.loadingVar;
				file >> spr.loadingValue;
				file >> spr.activate;
				file >> spr.activationType;
				file >> x;
				file >> y;
				file >> z;

				file >> sReserved;			// Associated board waypoint vector.

				if (!spr.fileName.empty() && (this == g_pBoard))
				{
					short version = 0;
					try
					{
						CItem *pItem = new CItem(g_projectPath + ITM_PATH + spr.fileName, spr, version, startThreads);
						if (version <= PRE_VECTOR_ITEM)
						{
							// Create standard vectors for old items.
							pItem->createVectors();
						} 
						// Set the position. Sprite location is always stored in pixels.
						pItem->setPosition(x, y, z, COORD_TYPE(coordType | PX_ABSOLUTE));
						items.push_back(pItem);
					}
					catch (CInvalidItem) { }
				}
			} // for (i)
		}

		// Images
		freeImages();
		file >> ub;
		if (ub >= 0)
		{
			images.reserve(ub);
			bLayerOccupied[0] |= LO_IMAGES; // Images on any layer.
			int q = bLayerOccupied[0];

			for (i = 0; i <= ub; ++i)
			{
				LPBRD_IMAGE img = new BRD_IMAGE();

				short var;
				int color;
				file >> img->file;
				file >> x; img->r.left = x;
				file >> y; img->r.top = y;
				file >> var; img->layer = int(var);
				file >> var; img->type = BI_ENUM(var);
				file >> color; img->transpColor = color;
				
				// Reserved for translucency, or other.
				file >> var;
    
				images.push_back(img);
				bLayerOccupied[img->layer] |= LO_IMAGES;

				// Create canvases later.
			} // for (i)
		}

		// Threads.
		if (this == g_pBoard) 
		{
			freeThreads();
		}

		file >> ub;
		for (i = 0; i <= ub; ++i)
		{
			STRING thread;
			file >> thread;
			if (startThreads && (this == g_pBoard))
			{
				thread = g_projectPath + PRG_PATH + thread;
				if (CFile::fileExists(thread))
				{
					CThread *p = CThread::create(thread);
					char str[255]; itoa(i, str, 10);
					LPSTACK_FRAME var = CProgram::getGlobal(STRING(_T("threads[")) + str + _T("]"));
					var->udt = UDT_NUM;
					var->num = double(int(p));
					threads.push_back(p);
				}
			}
		}

		STRING str;

		// Constants
		file >> ub;
		constants.clear();
		for (i = 0; i <= ub; ++i)
		{
			file >> str;
			constants.push_back(str);
		}

		// Layer titles.
		layerTitles.clear();
		for (i = 0; i <= sizeL; ++i)
		{
			file >> str;
			layerTitles.push_back(str);
		}

		// Directional links.
		links.clear();
		for (i = 0; i != 4; ++i)
		{
			file >> str;
			links.push_back(str);
		}

		delete bkgImage;
		bkgImage = NULL;

		file >> str;
		file >> i; 
		if (!str.empty())
		{
			bkgImage = new BRD_IMAGE();
			bkgImage->file = str;
			bkgImage->type = BI_ENUM(i);
		}
		
		file >> bkgColor;
		file >> bkgMusic;
		file >> enterPrg;
		file >> battleBackground;
		file >> battleSkill;
		file >> var; bAllowBattles = bool(var);
		file >> var; bDisableSaving = bool(var);

		bool bUpdate = false;
		file >> var; if (ambientEffect.r != var) bUpdate = true; ambientEffect.r = var;
		file >> var; if (ambientEffect.g != var) bUpdate = true; ambientEffect.g = var; 
		file >> var; if (ambientEffect.b != var) bUpdate = true; ambientEffect.b = var; 

		if (this == g_pBoard) 
		{
			// Required only for the active board.

			// setAmbientLevel calls g_pBoard->createImageCanvases().
			if (bUpdate) 
			{
				setAmbientLevel();
			}
			else
			{
				createImageCanvases();
			}
			createVectorCanvases();

		}

		return true;
	}
pvVersion:
	{
		// Pre-vector version.

		short var;
		int iUnused;
		STRING sUnused;

		file >> var;			// Registered version?
		file >> sUnused;		// Registration code.

		file >> var; sizeX = int(var);
		file >> var; sizeY = int(var);
		file >> var; sizeL = int(var);
		setSize(sizeX, sizeY, sizeL, true);

        // Create only a local versions of the old .ambientRed, -Green, -Blue arrays,
        // since they are not required outside of this function.
        VECTOR_SHORT3D red, green, blue;
		red = green = blue = board;

		// Start position moved to main file; hold
		// onto until after isometric byte is read.
		int pStartX, pStartY, pStartL;
		file >> var; pStartX = int(var);
		file >> var; pStartY = int(var);
		file >> var; pStartL = int(var);

		file >> var; bDisableSaving = bool(var);
    
		short lutSize;
		file >> lutSize;
		tileIndex.clear();
		animatedTiles.clear();

		// Temporarily to hold animated tile indices.
		std::vector<int> tanLutIndices;

		for (int i = 0; i <= lutSize; ++i)
		{
			STRING entry;
			file >> entry;

			tileIndex.push_back(entry);
			if (!entry.empty())
			{
				const STRING ext = getExtension(entry);
				if (_stricmp(ext.c_str(), _T("TAN")) == 0)
				{
					// Indices that point to animated tiles.
					tanLutIndices.push_back(i);
				}
			}
		}

		int x, y, z;
		for (z = 1; z <= sizeL; ++z)
		{
			for (y = 1; y <= sizeY; ++y)
			{
				for (x = 1; x <= sizeX; ++x)
				{
					short index, count;
					file >> index;

					if (index < 0)
					{
						// Compression: stream of identical tiles 'test' long. 
						count = -index;
						short r, b, g;
						char type;
						file >> index;
						file >> r;
						file >> g;
						file >> b;
						file >> type;

						// Determine if the layer contains tiles.
						// [0] indicates if the whole board contains tiles.
						if (index) bLayerOccupied[z] = bLayerOccupied[0] = LO_TILES;

						for (int i = 1; i <= count; ++i)
						{
							board[z][y][x] = index;

							// Load colors into local array.
							red[z][y][x] = r;
							green[z][y][x] = g;
							blue[z][y][x] = b;

							tiletype[z][y][x] = type;

							std::vector<int>::const_iterator j = tanLutIndices.begin();
							for (; j != tanLutIndices.end(); ++j)
							{
								if (board[z][y][x] == *j)
								{
									LPBOARD_TILEANIM tan = addAnimTile(tileIndex[board[z][y][x]], x, y, z);

									// Change the LUT index to point to a TST.
									board[z][y][x] = tan->lutIndices[0];
								}
							}

							if (++x > sizeX)
							{
								x = 1;
								if (++y > sizeY)
								{
									y = 1;
									if (++z > sizeL)
									{
										goto lutEndB;
									}
									// Onto the next layer.
									if (index) bLayerOccupied[z] = LO_TILES;
								}
							}
						} // for(i)
						--x;
					}
					else // (index > 0)
					{
						if (index) bLayerOccupied[z] = bLayerOccupied[0] = LO_TILES;

						board[z][y][x] = index;
						file >> red[z][y][x];
						file >> green[z][y][x];
						file >> blue[z][y][x];
						file >> tiletype[z][y][x];
					
						std::vector<int>::const_iterator i = tanLutIndices.begin();
						for (; i != tanLutIndices.end(); ++i)
						{
							if (board[z][y][x] == *i)
							{
								LPBOARD_TILEANIM tan = addAnimTile(tileIndex[board[z][y][x]], x, y, z);

								// Change the LUT index to point to a TST.
								board[z][y][x] = tan->lutIndices[0];
							}
						}
					}
				} // for (x)
			} // for (y)
		} // for (z)
lutEndB:

		delete bkgImage;
		bkgImage = NULL;

		STRING str;
		file >> str;
		if (!str.empty())
		{
			bkgImage = new BRD_IMAGE();
			bkgImage->file;
			bkgImage->type = BI_PARALLAX;
		}

		file >> sUnused;				// Foreground image.
		file >> sUnused;				// Border image.
		file >> bkgColor;
		file >> iUnused;				// Border colour.
		file >> var;
		ambientEffect = BRD_AMBIENT[(var <= 3 ? var : 0)];

		links.clear();
		for (i = 0; i != 4; ++i)
		{
			STRING link;
			file >> link;
			links.push_back(link);
		}

		file >> battleSkill;
		file >> battleBackground;
		file >> var; bAllowBattles = bool(var);
		file >> var;					// boardDayNight.
		file >> var;					// boardNightBattleOverride.
		file >> var;					// boardSkillNight.
		file >> sUnused;				// boardBackgroundNight.

		constants.clear();
		for (i = 0; i <= 10; ++i)
		{
			std::stringstream ss;
			file >> var;
			ss << var;
			constants.push_back(ss.str());
		}

		file >> bkgMusic;

		layerTitles.clear();
		for (i = 0; i <= 8; ++i)
		{
			STRING title;
			file >> title;
			layerTitles.push_back(title);
		}

		short numPrg;
		file >> numPrg;

		freePrograms();

		// Temporary vector to hold locations until isometric byte is read.
		std::vector<OBJ_POSITION> prgPos;

		for (i = 0; i <= numPrg; ++i)
		{
			LPBRD_PROGRAM prg = new BRD_PROGRAM();
			OBJ_POSITION pos = {0, 0, 0};

			file >> prg->fileName;
			file >> pos.x;
			file >> pos.y;
			file >> prg->layer;
			file >> prg->graphic;
			file >> prg->activate;
			file >> prg->initialVar; replace(replace(prg->initialVar, _T("!"), _T("")), _T("$"), _T(""));
			file >> prg->finalVar; replace(replace(prg->finalVar, _T("!"), _T("")), _T("$"), _T(""));
			file >> prg->initialValue;
			file >> prg->finalValue;
			file >> prg->activationType;

			// Old programs: default to PRG_STOPS_MOVEMENT.
			prg->activationType |= PRG_STOPS_MOVEMENT;

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
		file >> sUnused;

		short numSpr;
		file >> numSpr;

		freeItems();

		// Temporary vector to hold locations until isometric byte is read.
		std::vector<OBJ_POSITION> itemPos;

		for (i = 0; i <= numSpr; ++i)
		{
			BRD_SPRITE spr;
			OBJ_POSITION pos = {0, 0, 0, 0};

			file >> spr.fileName;

			// Look after these.
			file >> pos.x;
			file >> pos.y;
			file >> pos.layer;

			file >> spr.activate;
			file >> spr.initialVar; replace(replace(spr.initialVar, _T("!"), _T("")), _T("$"), _T(""));
			file >> spr.finalVar; replace(replace(spr.finalVar, _T("!"), _T("")), _T("$"), _T(""));
			file >> spr.initialValue;
			file >> spr.finalValue;
			file >> spr.activationType;
			file >> spr.prgActivate;
			file >> spr.prgMultitask;

			// Upgrade: set the loading variable.
			spr.loadingVar = spr.initialVar;
			spr.loadingValue = spr.initialValue;

			if (!spr.fileName.empty() && (this == g_pBoard))
			{
				try
				{
					CItem *pItem = new CItem(g_projectPath + ITM_PATH + spr.fileName, spr, pos.version, startThreads);
					items.push_back(pItem);

					// Hold onto location until isometric byte is read.
					itemPos.push_back(pos);
				}
				catch (CInvalidItem) { }

			}
		}

		if (this == g_pBoard) 
		{
			freeThreads();
		}
		if (minorVer >= 3)
		{
			int tCount;
			file >> tCount;
			for (i = 0; i <= tCount; ++i)
			{
				STRING thread;
				file >> thread;
				if (startThreads && (this == g_pBoard))
				{
					thread = g_projectPath + PRG_PATH + thread;
					if (CFile::fileExists(thread))
					{
						CThread *p = CThread::create(thread);
						char str[255]; itoa(i, str, 10);
						LPSTACK_FRAME var = CProgram::getGlobal(STRING(_T("threads[")) + str + _T("]"));
						var->udt = UDT_NUM;
						var->num = double(int(p));
						threads.push_back(p);
					}
				}
			}
		}

		if (minorVer > 2)
		{
			char coord;
			file >> coord;
			coordType = COORD_TYPE(coord);
		}

		freeVectors();
		for (i = 1; i <= sizeL; ++i)
		{
			// Vectorize in all instances - we might be testing a linked board.
			vectorize(i);
		}

		if (this == g_pBoard) 
		{
			// Required only for the active board.

			// setAmbientLevel calls g_pBoard->renderImageCanvases().
			setAmbientLevel();

			// Upgrade tile lighting before setting under vectors.
			freeShading();
			tileShading.push_back(new LAYER_SHADE(sizeX, sizeY));			
			for (z = 1; z <= sizeL; ++z)
			{
				for (y = 1; y <= sizeY; ++y)
				{
					for (x = 1; x <= sizeX; ++x)
					{                    
						 // Store the highest shading values in the new single layer shade.
						const RGB_SHORT rgb = { red[z][y][x], green[z][y][x], blue[z][y][x] };
						if (rgb.r || rgb.g || rgb.b)
						{
							tileShading[0]->shades[x][y] = rgb;
                        
							// Promote the shading layer to cast onto the highest layer occupied.
							tileShading[0]->layer = z;
						}
					}
				}
			}

			// Convert to pixel co-ordinates.
			coords::tileToPixel(pStartX, pStartY, coordType, true, sizeX);
			extern MAIN_FILE g_mainFile;
			if (!g_mainFile.startX) g_mainFile.startX = short(pStartX);
			if (!g_mainFile.startY) g_mainFile.startY = short(pStartY);
			if (!g_mainFile.startL) g_mainFile.startL = short(pStartL);

			// Create program bases.
			std::vector<LPBRD_PROGRAM>::iterator p = programs.begin();
			std::vector<OBJ_POSITION>::iterator pos = prgPos.begin();
			for (; p != programs.end(); ++p, ++pos)
			{
				createProgramBase(*p, &*pos);
			}

			createVectorCanvases();

			// Set the positions of and create vectors for old items.
			std::vector<CItem *>::iterator itm = items.begin();
			pos = itemPos.begin();
			for (; itm != items.end(); ++itm, ++pos)
			{
				if (pos->version <= PRE_VECTOR_ITEM)
				{
					// Create standard vectors for old items.
					(*itm)->createVectors();
				}

				// Can do this only after reading the isometric bit.
				(*itm)->setPosition(pos->x, pos->y, pos->layer, coordType);
			}

		} // if (this == g_pBoard) 

	} // pvVersion
	return true;
}

/*
 * Create a program's base.
 */
void tagBoard::createProgramBase(LPBRD_PROGRAM pPrg, LPOBJ_POSITION pObj) const
{
	pPrg->vBase = CVector();

	std::vector<CONV_POINT> pts = tileToVector(pObj->x, pObj->y, coordType);
	std::vector<CONV_POINT>::iterator i = pts.begin();
	for (; i != pts.end(); ++i)
	{
		pPrg->vBase.push_back(i->x, i->y);
	}
	pPrg->vBase.close(true);
}

/*
 * Convert the tiletype array to vectors.
 *
 * layer (in) - layer to vectorize
 */
void tagBoard::vectorize(const unsigned int layer)
{
	std::vector<LPCONV_VECTOR> vects = vectorizeLayer(
		tiletype[layer],
		sizeX,
		sizeY,
		coordType
	);

	std::vector<LPCONV_VECTOR>::iterator i = vects.begin();
	for (; i != vects.end(); ++i)
	{
		// Create the vector and add it to the board's list.
		BRD_VECTOR vector;
		vector.layer = layer;
		vector.type = TILE_TYPE((*i)->type);

		if ((*i)->type >= STAIRS1 && (*i)->type <= STAIRS8)
		{
			// Old stairs are stored as targetLayer + 10.
			vector.attributes = (*i)->type - 10;
			vector.type = TT_STAIRS;
		}
		else if (vector.type == TT_UNDER)
		{
			// Default for old board loading.
			vector.attributes = TA_BRD_BACKGROUND;
		}

		vector.pV = new CVector();

		std::vector<CONV_POINT>::iterator j = (*i)->pts.begin();
		for (; j != (*i)->pts.end(); ++j)
		{
			vector.pV->push_back(j->x, j->y);
		}
		if ((*i)->type == NORTH_SOUTH || (*i)->type == EAST_WEST)
		{
			vector.type = TT_SOLID;		
			vector.pV->close(false);
		}
		else
		{
			vector.pV->close(true);
		}
		vectors.push_back(vector);

		delete *i;
	}
}

/*
 * Create under tile canvases from a board's vectors.
 */
void tagBoard::createVectorCanvases()
{
	// After vectorize() on old formats.

	for (std::vector<BRD_VECTOR>::iterator i = vectors.begin(); i != vectors.end(); ++i)
	{
		i->createCanvas(*this);
	}
}

/*
 * Create image canvases for background and layer images.
 */
void tagBoard::createImageCanvases()
{
	if (bkgImage) bkgImage->createCanvas(*this);

	for (std::vector<LPBRD_IMAGE>::iterator i = images.begin(); i != images.end(); ++i)
	{
		(*i)->createCanvas(*this);
	}
}

/*
 * Create a canvas from a vector.
 */
void tagBoardVector::createCanvas(BOARD &board)
{
	CONST LONG SOLID_COLOR = 0;

	// Only need to do this for under tiles.
	if (~type & TT_UNDER) return;

	// Get the bounding box of the vector.
	const RECT r = pV->getBounds();
	if (r.right - r.left < 1 || r.bottom - r.top < 1) return;

	delete pCnv;
	pCnv = new CCanvas();
	pCnv->CreateBlank(NULL, r.right - r.left, r.bottom - r.top, TRUE);
	pCnv->ClearScreen(TRANSP_COLOR);

	// Inflate to align to the grid (iso or 2D).
	const RECT rAlign = {r.left - r.left % 32,
						r.top - r.top % 32,
						r.right - r.right % 32 + 32,
						r.bottom - r.bottom % 32 + 32};

	// Create an intermediate canvas that is aligned to the grid.
	CCanvas cnv;
	cnv.CreateBlank(NULL, rAlign.right - rAlign.left, rAlign.bottom - rAlign.top, TRUE);
	cnv.ClearScreen(TRANSP_COLOR);

	// Create a mask from the vector on the vector's canvas.
	if (pV->createMask(pCnv, r.left, r.top, SOLID_COLOR))
	{
		// Was drawn if vector was closed.

		// Determine whether all layers below the under vector
		// are affected, or just the specified layer.
		const int lLower = (attributes & TA_ALL_LAYERS_BELOW ? 1 : layer); 
	
		// If the under tile applies to the background.
		if (attributes & TA_BRD_BACKGROUND)
		{
			// Does not apply to parallaxed images.
			if (board.bkgImage && board.bkgImage->type != BI_PARALLAX)
				board.renderBackground(&cnv, rAlign);
		}

		// Draw the board layer within the bounds to the intermediate canvas.
		board.render(
			&cnv, 
			0, 0, 
			lLower, layer,  
			rAlign.left, rAlign.top, 
			rAlign.right - rAlign.left, 
			rAlign.bottom - rAlign.top
		);
		
		// Blt the mask onto the canvas. In this case we want
		// the *solid* colour on the mask to be transparent.
		pCnv->BltTransparentPart(
			&cnv, 
			r.left % 32, r.top % 32, 
			0, 0, 
			r.right - r.left, 
			r.bottom - r.top, 
			SOLID_COLOR
		);

		// Blt the vector area back to the vector's canvas.
		// (Note: it may seem easier to put the mask on the intermediate
		// canvas, but this results in a larger vector canvas that
		// is harder to manipulate.)
		cnv.BltPart(
			pCnv, 
			0, 0, 
			r.left % 32, r.top % 32, 
			r.right - r.left, 
			r.bottom - r.top, 
			SRCCOPY
		);
	}
	else
	{
		// No need to keep this canvas.
		delete pCnv;
		pCnv = NULL;
	}
}

/*
 * Load images attached to layers into separate canvases.
 */
void tagBoardImage::createCanvas(BOARD &board)
{
	extern STRING g_projectPath;
	extern RECT g_screen;
	extern MAIN_FILE g_mainFile;

	const int resX = g_screen.right - g_screen.left, resY = g_screen.bottom - g_screen.top;

	// Load the image.
	const STRING path = resolve(g_projectPath + BMP_PATH + file);
	FIBITMAP *bmp = FreeImage_Load (FreeImage_GetFileType(path.c_str(), 16), path.c_str());
	if (bmp)
	{
		// Remove unnecessary drawing types.
		if ((board.pxWidth() == FreeImage_GetWidth(bmp)) && (board.pxHeight() == FreeImage_GetHeight(bmp)))
			type = BI_NORMAL;

		// Successfully loaded. Size the canvas to the image size.
		const DWORD width  = (type == BI_STRETCH) ? board.pxWidth() : FreeImage_GetWidth(bmp),
					height = (type == BI_STRETCH) ? board.pxHeight() : FreeImage_GetHeight(bmp);

		if (pCnv) delete pCnv;
		pCnv = new CCanvas();
		pCnv->CreateBlank(NULL, width, height, TRUE);
		pCnv->ClearScreen(TRANSP_COLOR);

		// Draw the image to the canvas.
		const HDC hdc = pCnv->OpenDC();
		StretchDIBits(
			hdc,
			0, 0,
			width, height,
			0, 0,
			FreeImage_GetWidth(bmp),
			FreeImage_GetHeight(bmp),
			FreeImage_GetBits(bmp),
			FreeImage_GetInfo(bmp), 
			DIB_RGB_COLORS,
			SRCCOPY
		);

		// Clean up.
		pCnv->CloseDC(hdc);
		FreeImage_Unload(bmp);

		// Apply ambient level.
		extern AMBIENT_LEVEL g_ambientLevel;
		if (g_ambientLevel.color)
		{
			CCanvas cnv;
			cnv.CreateBlank(NULL, width, height, TRUE);
			cnv.ClearScreen(g_ambientLevel.color);
			cnv.BltAdditivePart(pCnv->GetDXSurface(), 0, 0, 0, 0, width, height, g_ambientLevel.sgn, -1, transpColor);
		}

		r.right = r.left + width;
		r.bottom = r.top + height;

		if (type == BI_PARALLAX)
		{
			// Scrolling factors.
			if (board.pxWidth() != resX)
			{
				scroll.x = double(width - resX) / (board.pxWidth() - resX);
			}
			if (board.pxHeight() != resY)
			{
				scroll.y = double(height - resY) / (board.pxHeight() - resY);
			}
		}

#ifdef DEBUG_VECTORS
		if (this == board.bkgImage && type != BI_PARALLAX && (g_mainFile.drawVectors & CV_DRAW_BRD_VECTORS))
		{
			// Draw program and tile vectors onto the background image.
			pCnv->Lock();
			for (std::vector<LPBRD_PROGRAM>::iterator b = board.programs.begin(); b != board.programs.end(); ++b)
			{
				if(*b) (*b)->vBase.draw(RGB(255, 255, 0), true, 0, 0, pCnv);
			}
			for (std::vector<BRD_VECTOR>::iterator c = board.vectors.begin(); c != board.vectors.end(); ++c)
			{
				const int r = (c->type == TT_UNDER ? RGB(0,255,0) : RGB(255, 255, 255));
				c->pV->draw(r, true, 0, 0, pCnv);
			}
			pCnv->Unlock();
		}
#endif
	}
}

/*
 * Render the board to a canvas.
 */
void tagBoard::render(
	CCanvas *const cnv,
	int destX, 			// canvas destination.
	const int destY,
	const int lLower, 	// layer bounds. 
	const int lUpper,
	int topX,			// pixel location on board to start from. 
	int topY,
	int width, 			// pixel dimensions to draw. 
	int height)
{
	extern STRING g_projectPath;
	extern AMBIENT_LEVEL g_ambientLevel;
	const RGBSHADE al = g_ambientLevel.rgb;

	const RECT bounds = { topX, topY, topX + width, topY + height };

	// Number of tiles to draw in each dimension.
	int nWidth = (width + topX > pxWidth() ? pxWidth() - topX : width) / tileWidth(),
		nHeight = (height + topY > pxHeight() ? pxHeight() - topY : height) / tileHeight();

	// Effective matrix dimensions.
	const int effectiveWidth = (coordType & ISO_ROTATED ? sizeX + sizeY : sizeX); 
	const int effectiveHeight = (coordType & ISO_ROTATED ? sizeX + sizeY : sizeY);

	// Tile start co-ordinates.
	int x = topX, y = topY;
	coords::pixelToTile(x, y, COORD_TYPE(coordType & ~PX_ABSOLUTE), false, sizeX);

	if (coordType & ISO_STACKED)
	{
		// Brute force draw edges in all situations.
		--x; ++nWidth;
		--y; ++nHeight;
	}
	else if (coordType & ISO_ROTATED)
	{
		y = y - nWidth;
		nWidth = nHeight = (nWidth + nHeight);
	}

	// For each layer
	for (unsigned int i = lLower; i <= lUpper; ++i)
	{
		if (bLayerOccupied[i] & LO_TILES)
		{
			const bool castShade = (tileShading[0]->layer >= i);

			// For the x axis
			for (unsigned int j = x; j <= x + nWidth; ++j)
			{
				if (j > effectiveWidth) continue;

				// For the y axis
				for (unsigned int k = y; k <= y + nHeight; ++k)
				{
					if (k > effectiveHeight) continue;

					if (board[i][k][j])
					{
						const STRING tile = tileIndex[board[i][k][j]];
						if (!tile.empty())
						{
							// Single layer lighting implementation.
							RGB_SHORT shade = {0, 0, 0};
							if (castShade) shade = tileShading[0]->shades[j][k];

							// Tile exists at this location.
							CTile::drawByBoardCoord(
								g_projectPath + TILE_PATH + tile,
								j, k, 
								shade.r + al.r,
								shade.g + al.g,
								shade.b + al.b,
								cnv, 
								TM_NONE,
								destX - topX, destY - topY,
								coordType,
								sizeX
							);
						} // if (!strTile.empty())
					} // if (board[i][k][j])
				} // for k
			} // for j
		} // if (layer occupied with tiles)

		// Draw attached images over tiles on their respective layers.
		// Background image handled separately.
		if (bLayerOccupied[i] & LO_IMAGES) renderImages(cnv, destX, destY, bounds, i);

	} // for i
}

/*
 * Render images on a layer that intersect the RECT bounds (or all images if layer = 0).
 */
void tagBoard::renderImages(
	CCanvas *const cnv, 
	const int destX,
	const int destY,
	const RECT bounds, 
	const int layer)
{
	for (std::vector<LPBRD_IMAGE>::iterator i = images.begin(); i != images.end(); ++i)
	{
		BRD_IMAGE img = **i;
		if ((img.layer == layer || !layer) && (img.pCnv) && (img.type != BI_PARALLAX))
		{
			// Do not blt parallaxed images - unlikely to be
			// feasible to have parallaxed images between layers.
			RECT rect = {0, 0, 0, 0};
			if (IntersectRect(&rect, &img.r, &bounds))
			{
				// If the image intersects the scrollcache.
				img.pCnv->BltTransparentPart(cnv, 
					rect.left - bounds.left + destX,
					rect.top - bounds.top + destY,
					rect.left - img.r.left,
					rect.top - img.r.top,
					rect.right - rect.left,
					rect.bottom - rect.top,
					img.transpColor
				);
			}
		}
	}
}

/*
 * Render the board background (independently of the board).
 */
void tagBoard::renderBackground(CCanvas *const cnv, const RECT bounds)
{
	extern RECT g_screen;

	if (!bkgImage) return;
	BRD_IMAGE img = *bkgImage;

	const int width = img.r.right - img.r.left,
			  height = img.r.bottom - img.r.top,
			  resX = g_screen.right - g_screen.left,
			  resY = g_screen.bottom - g_screen.top;
	int destX = 0, destY = 0;
	RECT rect = {0, 0, 0, 0};

	if (img.type == BI_PARALLAX)
	{
		// Always use g_screen for parallax.
		if (img.scroll.x < 0 || width < resX)
		{
			// Centre the image if board and/or image smaller than screen.
			// Bitshift in place of divide by two (>> 1 equivalent to / 2)
			destX = (resX - width) >> 1;
		}
		else
		{
			rect.left = img.scroll.x * g_screen.left;
		}

		if (img.scroll.y < 0 || height < resY)
		{
			destY = (resY - height) >> 1;
		}
		else
		{
			rect.top = img.scroll.y * g_screen.top;
		}

		img.pCnv->BltTransparentPart(
			cnv, 
			destX, 
			destY, 
			rect.left, 
			rect.top, 
			width > resX ? resX : width, 
			height > resY ? resY : height, 
			img.transpColor);
	}
	else
	{
		// No parallax - straight blt with the target rect offset.
		if (IntersectRect(&rect, &img.r, &bounds))
		{
			img.pCnv->BltTransparentPart(cnv, 
				rect.left - bounds.left,
				rect.top - bounds.top,
				rect.left - img.r.left, 
				rect.top - img.r.top, 
				rect.right - rect.left, 
				rect.bottom - rect.top,
				img.transpColor);
		}

	} // if (parallax)

}

/*
 * Board dimensions in pixels.
 * Use bitshifts in place of multiplication. x << y = x * 2^y.
 */
int tagBoard::pxWidth() const
{
	if (coordType & ISO_STACKED) return (sizeX << 6) - 32;
	if (coordType & ISO_ROTATED) return (sizeX << 6) - 32;
	return sizeX << 5;			// TILE_NORMAL.
}

int tagBoard::pxHeight() const
{ 
	if (coordType & ISO_STACKED) return (sizeY << 4) - 16;
	if (coordType & ISO_ROTATED) return sizeY << 5;
	return sizeY << 5;			// TILE_NORMAL.
}

/*
 * Free vectors, optionally on a single layer.
 */
void tagBoard::freeVectors(const int layer)
{
	if (layer)
	{
		// Delete vectors on the given layer.
		while (true)
		{
			for (std::vector<BRD_VECTOR>::iterator i = vectors.begin(); i != vectors.end(); ++i)
			{
				if (i->layer == layer) break;
			}

			// If no vectors were found, break.
			if (i == vectors.end()) break;

			// Else, clean up and remove the pointer.
			delete i->pCnv;
			delete i->pV;			
			vectors.erase(i);
		}
	}
	else
	{
		for (std::vector<BRD_VECTOR>::iterator i = vectors.begin(); i != vectors.end(); ++i)
		{
			delete i->pCnv;
			delete i->pV;
		}
		vectors.clear();
	}
}

/*
 * Free programs.
 */
void tagBoard::freePrograms()
{
	for (std::vector<LPBRD_PROGRAM>::iterator i = programs.begin(); i != programs.end(); ++i)
	{
		delete *i;
	}
	programs.clear();
}

/*
 * Free items.
 */
void tagBoard::freeItems()
{
	for (std::vector<CItem *>::iterator i = items.begin(); i != items.end(); ++i)
	{
		delete *i;
	}
	items.clear();
}

/*
 * Free images.
 */
void tagBoard::freeImages()
{
	delete bkgImage;
	bkgImage = NULL;
	for (std::vector<LPBRD_IMAGE>::iterator i = images.begin(); i != images.end(); ++i)
	{
		delete *i;
	}
	images.clear();
}

/*
 * Free threads.
 */
void tagBoard::freeThreads()
{
	for (std::vector<CThread *>::iterator i = threads.begin(); i != threads.end(); ++i)
	{
		CThread::destroy(*i);
	}
	threads.clear();
}

/*
 * Free paths.
 */
void tagBoard::freePaths()
{
	for (std::vector<CVector *>::iterator i = paths.begin(); i != paths.end(); ++i)
	{
		delete *i;
	}
	paths.clear();
}

/*
 * Free tile shading layers.
 */
void tagBoard::freeShading()
{
	for (std::vector<LPLAYER_SHADE>::iterator i = tileShading.begin(); i != tileShading.end(); ++i)
	{
		delete *i;
	}
	tileShading.clear();
}

/*
 * Add an animated tile to the board.
 *
 * fileName (in) - tile to add
 * x (in) - x position on board
 * y (in) - y position on board
 * z (in) - z position on board
 */
LPBOARD_TILEANIM tagBoard::addAnimTile(const STRING fileName, const int x, const int y, const int z)
{
	static STRING lastAnimFile;
	static TILEANIM lastAnim;

	// Save time when multiple TANs are being loaded.
	if (_stricmp(lastAnimFile.c_str(), fileName.c_str()) != 0)
	{
		extern STRING g_projectPath;
		lastAnim.open(g_projectPath + TILE_PATH + fileName);
		lastAnimFile = fileName;	
	}

	BOARD_TILEANIM anim;
	anim.tile = lastAnim;
	anim.x = x;
	anim.y = y;
	anim.z = z;

	// Unpack the TAN and add each frame to the Lut to be 
	// cycled through during rendering.
	std::vector<STRING>::const_iterator i = lastAnim.frames.begin();
	for (; i != lastAnim.frames.end(); ++i)
	{
		anim.lutIndices.push_back(lutIndex(*i));
	}

	animatedTiles.push_back(anim);
	return &animatedTiles.back();
}

/*
 * Set the board's size.
 *
 * width (in) - new width
 * height (in) - new height
 * depth (in) - new depth
 */
void tagBoard::setSize(const int width, const int height, const int depth, const bool createTiletypeArray)
{
	// Arrays accessed as board[z][y][x].
	{
		VECTOR_SHORT row;
		VECTOR_SHORT2D face;
		unsigned int i;
		board.clear();
		for (i = 0; i <= width; ++i) row.push_back(0);
		for (i = 0; i <= height; ++i) face.push_back(row);
		for (i = 0; i <= depth; ++i) 
		{
			board.push_back(face);
			bLayerOccupied.push_back(LO_NONE);
		}
	}
	if (createTiletypeArray)
	{
		VECTOR_CHAR row;
		VECTOR_CHAR2D face;
		unsigned int i;
		for (i = 0; i <= width; ++i) row.push_back(_T('\0'));
		for (i = 0; i <= height; ++i) face.push_back(row);
		tiletype.clear();
		for (i = 0; i <= depth; ++i) tiletype.push_back(face);
	}
}

/*
 * Get the vector that contains a given tile.
 */
const BRD_VECTOR* tagBoard::getVectorFromTile(const int x, const int y, const int z) const
{
	// Convert the point to pixels.
	int px = x, py = y;
	coords::tileToPixel(px, py, coordType, false, sizeX);
	DB_POINT pt = {px + 1.0, py + 1.0};

	// Locate the vector.
	std::vector<BRD_VECTOR>::const_iterator i = vectors.begin();
	for (; i != vectors.end(); ++i)
	{
		if (i->layer == z)
		{
			if (i->pV->containsPoint(pt))
			{
				return &*i;
			}
		}
	}

	// Didn't find it -- point may still be valid, as normal tiles
	// do not have vectors.
	return NULL;
}

LPBRD_VECTOR tagBoard::getVector(const LPSTACK_FRAME pParam)
{
	if (pParam->getType() & UDT_LIT)
	{
		// Handle.
		const STRING handle = pParam->getLit();
		std::vector<BRD_VECTOR>::iterator i = vectors.begin();
		for (; i != vectors.end(); ++i)
		{
			if (_ftcsicmp(handle.c_str(), i->handle.c_str()) == 0) return &*i;
		}
	}
	else
	{
		const int i = int(pParam->getNum());
		if (i < vectors.size())
		{
			return &vectors.at(i);
		}
	}
	return NULL;
}

/*
 * Get a program by index.
 */
LPBRD_PROGRAM tagBoard::getProgram(const unsigned int index)
{
	if (index < programs.size())
	{
		return programs.at(index);
	}
	return NULL;
}

/*
 * Determine whether the board has a given program on it.
 */
bool tagBoard::hasProgram(LPBRD_PROGRAM p) const
{
	if (!p) return false;
	std::vector<LPBRD_PROGRAM>::const_iterator i = programs.begin();
	for (; i != programs.end(); ++i)
	{
		if ((*i) == p) return true;
	}
	return false;
}

/*
 * Insert a tile onto the board for the duration the board is loaded.
 */
bool tagBoard::insertTile(const STRING tile, const int x, const int y, const int z)
{
	try
	{
		board[z][y][x] = lutIndex(tile);
		bLayerOccupied[z] |= LO_TILES;
		bLayerOccupied[0] |= LO_TILES;		// Any layer occupied.
	}
	catch (...) 
	{
		return false;
	}
	return true;
}

/*
 * Get the Lut index of a tile, adding the tile if not found.
 */
int tagBoard::lutIndex(const STRING tile)
{
	int index = 0;
	// Search the table for the tile.
	std::vector<STRING>::iterator i = tileIndex.begin(), j = i;
	for (; i != tileIndex.end(); ++i)
	{
		if (_ftcsicmp(tile.c_str(), i->c_str()) == 0)
		{
			index = i - j;
			break;
		}
	}
	if (!index)
	{
		// Insert it onto the end.
		index = tileIndex.size();
		tileIndex.push_back(tile);
	}
	return index;
}

void tagBoard::renderAnimatedTiles(SCROLL_CACHE &scrollCache)
{
	std::vector<BOARD_TILEANIM>::iterator i = animatedTiles.begin();
	for (; i != animatedTiles.end(); ++i)
	{
		TILEANIM *tan = &i->tile;
		const int x = i->x, y = i->y, z = i->z;

		if (GetTickCount() - tan->frameTime > tan->frameDelay)
		{
			(++tan->currentFrame) %= tan->frames.size();
			tan->frameTime = GetTickCount();

			// Change the LUT index to point to a TST.
			board[z][y][x] = i->lutIndices[tan->currentFrame];

			// Pixel bounds of tile stack.
			int px = x, py = y;
			coords::tileToPixel(px, py, COORD_TYPE(coordType & ~PX_ABSOLUTE), false, sizeX);
			if (isIsometric())
			{
				// Render location.
				px -= 32;
				py -= 16;
			}
			const RECT bounds = {px, py, px + tileWidth(), py + tileHeight()};
			
			// Draw the whole tile stack onto the scrollcache.
			renderStack(
				&scrollCache.cnv,
				bounds.left - scrollCache.r.left,
				bounds.top - scrollCache.r.top,
				1, sizeL,
				x, y,
				bounds
			);
		} // if (advanced frame)
	} // for (i)
}

/*
 * Render tiles on all layers at a single co-ordinate.
 */
void tagBoard::renderStack(
	CCanvas *const cnv,
	const int destX,	// canvas destination.
	const int destY,
	const int lLower, 	// layer bounds. 
	const int lUpper,
	const int x,		// tile location on board to draw. 
	const int y,
	const RECT bounds)
{
	extern STRING g_projectPath;
	extern RECT g_screen;
	extern AMBIENT_LEVEL g_ambientLevel;
	const RGBSHADE al = g_ambientLevel.rgb;

	// Skip tan if off screen.
	RECT dest = {0, 0, 0, 0};
	if (!IntersectRect(&dest, &bounds, &g_screen)) return;

	// Draw a blank tile.
	HDC hdc = cnv->OpenDC();
	CTile::drawBlankHdc(
		x, y, 
		hdc, 
		bkgColor,
		destX - bounds.left, 
		destY - bounds.top,
		coordType,
		sizeX
	);
	cnv->CloseDC(hdc);

	for (unsigned int i = lLower; i <= lUpper; ++i)
	{
		if ((bLayerOccupied[i] & LO_TILES) && board[i][y][x])
		{
			const STRING tile = tileIndex[board[i][y][x]];
			if (!tile.empty())
			{
				// Tile exists at this location.
						
				// Single layer lighting implementation.
				RGB_SHORT shade = {0, 0, 0};
				if (tileShading[0]->layer >= i) shade = tileShading[0]->shades[x][y];
				
				CTile::drawByBoardCoord(
					g_projectPath + TILE_PATH + tile,
					x, y, 
					shade.r + al.r,
					shade.g + al.g,
					shade.b + al.b,
					cnv, 
					TM_NONE,
					destX - bounds.left, 
					destY - bounds.top,
					coordType,
					sizeX
				);
			}
		}

		if (bLayerOccupied[i] & LO_IMAGES) renderImages(cnv, destX, destY, bounds, i);
	}
}

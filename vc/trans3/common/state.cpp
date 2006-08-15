/*
 * All contents copyright 2003, 2004, 2005 Christopher Matthews or Contributors.
 * All rights reserved. You may not remove this notice
 * Read license.txt for licensing details.
 */

#include "state.h"
#include "CFile.h"
#include "mbox.h"
#include "CInventory.h"
#include "paths.h"
#include "mainfile.h"
#include "board.h"
#include "../rpgcode/CProgram.h"
#include "../rpgcode/virtualvar.h"
#include "../misc/misc.h"
#include "../movement/CPlayer/CPlayer.h"
#include "../movement/CItem/CItem.h"
#include <vector>

extern std::vector<CPlayer *> g_players;
extern CInventory g_inv;
extern STRING g_projectPath;
extern int g_selectedPlayer;
extern CPlayer *g_pSelectedPlayer;
extern unsigned long g_gp;
extern COLORREF g_mwinColor;
extern STRING g_mwinBkg;
extern STRING g_fontFace;
extern int g_fontSize;
extern COLORREF g_color;
extern BOOL g_bold;
extern BOOL g_italic;
extern BOOL g_underline;
extern unsigned long g_pxStepsTaken;
extern MAIN_FILE g_mainFile;
extern LPBOARD g_pBoard;
extern STRING g_menuGraphic, g_fightMenuGraphic;
extern int g_mwinSize;
extern GAME_TIME g_gameTime;

#include "mbox.h"

void loadSaveState(const STRING str)
{
	CFile file(str);

	if (!file.isOpen())
	{
		messageBox(_T("File not found: ") + str);
		return;
	}

	STRING header;
	file >> header;
	if (header != _T("RPGTLKIT SAVE"))
	{
		messageBox(_T("Invalid save file: ") + str);
		return;
	}

	short majorVer, minorVer;
	file >> majorVer >> minorVer;

	CProgram::clearRedirects();
	CProgram::freeGlobals();
	CThread::destroyAll();

	STRING varName;
	double varValue;
	STRING varString;

	int i;
	int count;

	// Read numerical global variables.
	file >> count;
	for (i = 0; i < count; ++i)
	{
		file >> varName >> varValue;
		if (!varName.empty())
		{
			// Remove type definition character.
			replace(varName, _T("!"), _T(""));
			// Remove quotes from maps.
			replace(varName, _T("\""), _T(""));
			LPSTACK_FRAME pVar = CProgram::getGlobal(varName);
			pVar->udt = UDT_NUM;
			pVar->num = varValue;
		}
	}

	// Read literal global variables.
	file >> count;
	for (i = 0; i < count; ++i)
	{
		file >> varName >> varString;
		if (!varName.empty())
		{
			// Remove type definition character.
			replace(varName, _T("$"), _T(""));
			// Remove quotes from maps.
			replace(varName, _T("\""), _T(""));
			LPSTACK_FRAME pVar = CProgram::getGlobal(varName);
			pVar->udt = UDT_LIT;
			pVar->lit = varString;
		}
	}

	// Recreate virtual variables.
	initVirtualVars();

	// Get redirects.
	file >> count;
	for (i = 0; i < count; ++i)
	{
		file >> varName >> varString;
		if (!varName.empty())
		{
			CProgram::addRedirect(varName, varString);
		}
	}

	// Get player party information.

	{
		for (std::vector<CPlayer *>::const_iterator i = g_players.begin(); i != g_players.end(); ++i)
		{
			delete *i;
		}
		g_players.clear();
	}

	int players = 5;
	if (minorVer >= 4) file >> players;

	for (i = 0; i < players; ++i)
	{
		STRING name, fileName;
		file >> name >> fileName;
		if (!fileName.empty())
		{
			if (minorVer < 4) fileName = removePath(fileName);
			CPlayer *p = new CPlayer(g_projectPath + TEM_PATH + fileName, false, false);
			p->name(name);
			g_players.push_back(p);
		}
	}

	g_inv.clear();
	short itemCount;					// VB recorded this as a short.
	file >> itemCount;
	for (i = 0; i != itemCount; ++i)
	{
		STRING fileName, handle;
		int quantity;
		file >> fileName >> handle >> quantity;
		if (!fileName.empty())
		{
			// Remove path up to and including ITM_PATH.
			g_inv.give(g_projectPath + ITM_PATH + removePath(fileName, ITM_PATH), quantity);
		}
	}

	// Equipment - slot numbers run from 1.
	for (i = 1; i <= 16; ++i)
	{
		for (unsigned int j = 0; j < players; ++j)
		{
			STRING fileName, handle;
			file >> fileName >> handle;

			if (!fileName.empty() && j < g_players.size())
			{ 
				CPlayer *p = g_players[j];
				if (p) p->equipment(EQ_SLOT(fileName, handle), i);
			}
		}
	}

	// Equipment stat modifiers.
	for (i = 0; i < players; ++i)
	{
		int hp, sm, dp, fp;
		file >> hp >> sm >> dp >> fp;

		if (i < g_players.size())
		{
			CPlayer *p = g_players[i];
			if (p)
			{
				p->equipmentHP(hp);
				p->equipmentSM(sm);
				p->equipmentDP(dp);
				p->equipmentFP(fp);
			}
		}
	}

	int unused;
	file >> unused; // menuColor

	file >> g_selectedPlayer;
	if (g_selectedPlayer >= g_players.size()) g_selectedPlayer = 0;
	g_pSelectedPlayer = g_players[g_selectedPlayer];

	int gp;
	file >> gp;
	g_gp = gp; // Performs an upcast.

	int colour;
	file >> colour;
	g_mwinColor = abs(colour);

	file >> g_mwinBkg;

	int debug;			// Show the debugger?
	file >> debug;
	CProgram::setDebugLevel(debug != 0 ? E_WARNING : E_DISABLED);

	int fontColour;
	file >> fontColour;
	g_color = fontColour;

	file >> g_fontFace;
	file >> g_fontSize;

	file >> g_bold >> g_underline >> g_italic;

	int gameTime;
	file >> gameTime;
	g_gameTime.reset(gameTime);

	int steps;
	file >> steps;
	g_pxStepsTaken = steps * 32;

	STRING mainFile;
	file >> mainFile;
	g_mainFile.open(GAM_PATH + removePath(mainFile));

	STRING board;
	file >> board;
	if (minorVer < 4) board = removePath(board);
	g_pBoard->open(g_projectPath + BRD_PATH + board, false);

	for (i = 0; i < players; ++i)
	{
		double x, y;
		int z, active = 0;
		COORD_TYPE ct = g_pBoard->coordType;

		file >> x >> y >> z;

		if (minorVer >= 4)
		{
			file >> active;
			ct = PX_ABSOLUTE;			// Pre-3.0.7, location stored in tiles.
		}
		if (i < g_players.size() && g_players[i])
		{
			g_players[i]->setPosition(int(x), int(y), z, ct);
			g_players[i]->setActive(active != 0);
		}
	}

	for (i = 0; i < players; ++i)
	{
		int nl, lp;
		file >> nl >> lp;
		if (i < g_players.size())
		{
			CPlayer *p = g_players[i];
			if (p)
			{
				LPPLAYER pPlayer = p->getPlayer();
				pPlayer->nextLevel = nl;
				pPlayer->levelProgression = lp;
				p->restore(false);
			}
		}
	}

	for (i = 0; i < 26; ++i)
	{
		// Other player list isn't currently used:
		// not needed for player restoration.
		STRING otherPlayer, otherPlayerHandle;
		file >> otherPlayer >> otherPlayerHandle;
	}

	file >> g_menuGraphic >> g_fightMenuGraphic;
	file >> g_mwinSize;

	// Change the player's graphics to any previous NewPlayer() character.
	STRING newPlayerName;
	file >> newPlayerName;
	g_pSelectedPlayer->swapGraphics(newPlayerName);

	// Item restoration - restore all board items from the save state
	// rather than from the board data. (3.0.7)
	if (minorVer >= 4)
	{
		g_pBoard->freeItems();
		file >> count;
		for (i = 0; i != count; ++i)
		{
			BRD_SPRITE spr;
			double x, y;
			int z, active;
			file >> spr.fileName;
			if (!spr.fileName.empty())
			{
				file >> spr.prgActivate;
				file >> spr.prgMultitask;
				file >> spr.initialVar;
				file >> spr.initialValue;
				file >> spr.finalVar;
				file >> spr.finalValue;
				file >> spr.activate;
				file >> spr.activationType;
				file >> x;
				file >> y;
				file >> z;
				file >> active;

				short version = 0;
				try
				{
					CItem *pItem = new CItem(g_projectPath + ITM_PATH + spr.fileName, spr, version, false);
					if (version <= PRE_VECTOR_ITEM)
					{
						// Create standard vectors for old items.
						pItem->createVectors();
					} 
					// Set the position. Sprite location is always stored in pixels.
					pItem->setPosition(x, y, z, PX_ABSOLUTE);
					pItem->setActive(active != 0);
					g_pBoard->items.push_back(pItem);
				}
				catch (CInvalidItem) { }
			}
			else
			{
				// Empty slot.
				g_pBoard->items.push_back(NULL);
			}
		}	// for (i)
	}

	// Restore threads.
	file >> count;
	for (i = 0; i <= count; ++i)
	{
		STRING fileName;
		file >> fileName;

		BOOL bPersist;
		file >> bPersist;

		int itm = -1;	// Item position.

		if (minorVer < 4)
		{
			// In 3.0.7, the position is not saved here. It is saved
			// as part of the state data (see below).
			int pos;
			file >> pos;
		}
		else if (bPersist)
		{
			BOOL bItem = FALSE;
			file >> bItem;
			if (bItem)
			{
				file >> itm;
			}
		}

		BOOL bSleep;
		file >> bSleep;
		double duration;
		file >> duration;

		CThread *pThread = NULL;

		if (!fileName.empty())
		{
			if ((itm != -1) && (g_pBoard->items.size() > itm) && g_pBoard->items[itm])
			{
				CItemThread *pItemThread = CItemThread::create(fileName, g_pBoard->items[itm]);
				g_pBoard->items[itm]->attachThread(pItemThread);
				pThread = pItemThread;
			}
			else
			{
				pThread = CThread::create(fileName);
			}
			if (!bPersist)
			{
				g_pBoard->threads.push_back(pThread);
			}
			if (bSleep)
			{
				if (minorVer < 4) duration *= 1000.0;
				pThread->sleep(int(duration));
			}
		}

		if (minorVer >= 4)
		{
			// If this save file is from 3.0.7 or later, we can
			// reconstruct the program's state. Otherwise, we do
			// not have enough information to reconstruct, so we
			// won't attempt it.
			if (pThread) pThread->reconstructState(file);
		}
		else
		{
			int heaps;
			file >> heaps;
			if (heaps >= 0)
			{
				unsigned int j;
				for (j = 0; j <= heaps; ++j)
				{
					// Create local heaps...
					int nums;
					file >> nums;
					for (j = 0; j < nums; ++j)
					{
						STRING varName; double varValue;
						file >> varName >> varValue;
					}

					int lits;
					file >> lits;
					for (j = 0; j < lits; ++j)
					{
						STRING varName, varString;
						file >> varName >> varString;
					}
				}
			}
		} // if (minorVer >= 4)

		if ((itm != -1) && ((g_pBoard->items.size() <= itm) || !g_pBoard->items[itm]))
		{
			// This thread formerly belonged to an item created with CreateItem(),
			// but since rpgcode-created items aren't restored, we shouldn't
			// restore this thread either.
			CThread::destroy(pThread);
		}
	}

	// Movement size (probably unneeded unless changed halfway through game).
	double movementSize;
	file >> movementSize;
	CSprite::m_bPxMovement = (movementSize != 1.0);

	// Partially obsolete OOP information.
	if ((minorVer >= 1) && (minorVer < 4)) // ignore for now
	{
		file >> count;
		for (i = 0; i <= count; ++i)
		{
			int hClass; STRING className;
			file >> hClass;
			file >> className;
			// hClass is obsolete, but the className has potential use.
			// tbd - recreate the object
		}

		// Obsolete hClass usage.
		file >> count;
		for (i = 0; i <= count; ++i)
		{
			char c;
			file >> c;
		}
	}

	// Currently obsolete garbage collection information. But
	// garbage collection will have to be reintroduced sooner
	// or later and it might become useful then.
	if ((minorVer >= 3) && (minorVer < 4)) // ignore for now
	{
		file >> count;
		for (i = 0; i <= count; ++i)
		{
			int data;
			file >> data;
		}
	}

	if (minorVer >= 2)
	{
		int loopOffset;
		file >> loopOffset;
		CSprite::setLoopOffset(loopOffset);
	}

	g_pSelectedPlayer->setActive(true);
	g_pSelectedPlayer->send();
}

void saveSaveState(const STRING fileName)
{
 	CFile file(fileName, OF_CREATE | OF_WRITE);

	// Header
	file << _T("RPGTLKIT SAVE");
	file << short(3);				// Major version
	file << short(4);				// Minor version - 4 as of 3.0.7

	unsigned int i = 0;

	// Write globals.
	{
		HEAP_ENUM heap = CProgram::enumerateGlobals();
		HEAP_ENUM::ITR itr = heap.begin();

		// We are going to sort the globals into numerical and literal.
		// This will keep the file format the same size, even though
		// it takes a little bit of effort when saving, so it's worth it.
		std::vector<HEAP_ENUM::ITR> lits, nums;
		std::vector<HEAP_ENUM::ITR>::const_iterator j;

		for (; itr != heap.end(); ++itr)
		{
			((itr->second->udt & UDT_LIT) ? lits : nums).push_back(itr);
		}

		// Write numerical globals.
		file << int(nums.size());
		for (j = nums.begin(); j != nums.end(); ++j)
		{
			file << (*j)->first << (*j)->second->num;
		}

		// Write literal globals.
		file << int(lits.size());
		for (j = lits.begin(); j != lits.end(); ++j)
		{
			file << (*j)->first << (*j)->second->lit;
		}
	}

	// Write redirects.
	{
		REDIRECT_ENUM redirects = CProgram::enumerateRedirects();
		REDIRECT_ENUM::ITR itr = redirects.begin();

		file << int(redirects.size());

		for (; itr != redirects.end(); ++itr)
		{
			file << itr->first << itr->second;
		}
	}

	// Player information.
	file <<  int(g_players.size());

	for (i = 0; i < g_players.size(); ++i)
	{
		STRING name, filename;
		if (g_players.at(i))
		{
			name = g_players.at(i)->name();
			filename = g_players.at(i)->getPlayer()->fileName;
		}
		file << name << filename;
	}

	// Inventory.
	file << short(g_inv.size());

	for (i = 0; i != g_inv.size(); ++i)
	{
		// filename holds the entire path (from g_projectPath).
		STRING filename, handle;
		int quantity;
		filename = g_inv.fileAt(i);
		handle = g_inv.handleAt(i);
		quantity = int(g_inv.quantityAt(i));
		file << filename << handle << quantity;
	}

	// Equipment - slot numbers run from 1.
	for (i = 1; i <= 16; ++i)
	{
		for (unsigned int j = 0; j < g_players.size(); ++j)
		{
			STRING filename, handle;
			if (g_players.at(j))
			{
				const LPEQ_SLOT pEq = g_players.at(j)->equipment(i);
				if (pEq)
				{
					filename = pEq->first;
					handle = pEq->second;
				}
			}
			file << filename << handle;
		}
	}

	// Equipment stat modifiers.
	for (i = 0; i < g_players.size(); ++i)
	{
		int hp = 0, sm = 0, dp = 0, fp = 0;
		if (g_players.at(i))
		{
			hp = g_players.at(i)->equipmentHP();
			sm = g_players.at(i)->equipmentSM();
			dp = g_players.at(i)->equipmentDP();
			fp = g_players.at(i)->equipmentFP();
		}
		file << hp << sm << dp << fp;
	}

	// Menu color (unused).
	file << int(0);

	// Miscellaneous variables.
	file << g_selectedPlayer;
	file << int(g_gp);
	file << int(g_mwinColor);
	file << g_mwinBkg;

	const EXCEPTION_TYPE et = CProgram::getDebugLevel();
	file << int(et == E_DISABLED ? 0 : 1);

	file << int(g_color);
	file << g_fontFace;
	file << int(g_fontSize);
	file << int(g_bold);
	file << int(g_underline);
	file << int(g_italic);
	file << g_gameTime.gameTime();
	file << int(g_pxStepsTaken / 32);			// Saved in tiles.
	file << g_mainFile.getFilename();
	file << g_pBoard->filename;

	// Player locations.
	for (i = 0; i < g_players.size(); ++i)
	{
		SPRITE_POSITION p;
		bool active = false;
		if (g_players.at(i))
		{
			p = g_players.at(i)->getPosition();
			active = g_players.at(i)->isActive();
		}
		// Store pixel values always.
		file << p.x << p.y << p.l; 
		file << int(active);
	}

	// Player levels.
	for (i = 0; i < g_players.size(); ++i)
	{
		int nl = 0, lp = 0;
		if (g_players.at(i))
		{
			const LPPLAYER pPlayer = g_players.at(i)->getPlayer();
			nl = pPlayer->nextLevel;
			lp = pPlayer->levelProgression;
		}
		file << nl << lp;
	}

	// Other players (currently unused).
	for (i = 0; i < 26; ++i)
	{
		STRING otherPlayer, otherPlayerHandle;
		file << otherPlayer << otherPlayerHandle;
	}

	// Miscellaneous variables.
	file << g_menuGraphic;
	file << g_fightMenuGraphic;
	file << g_mwinSize;

	// Player filename given in the last NewPlayer() call.	
	file << g_pSelectedPlayer->swapGraphics();

	// Items - save all board items, since items may have been 
	// added, moved or removed since the board was first loaded.
	file << int(g_pBoard->items.size());

	std::vector<CItem *>::const_iterator j = g_pBoard->items.begin();
	for (; j != g_pBoard->items.end(); ++j)
	{
		if (*j)
		{
			const BRD_SPRITE spr = *(*j)->getBoardSprite();
			const SPRITE_POSITION pos = (*j)->getPosition();

			file << spr.fileName;
			file << spr.prgActivate;
			file << spr.prgMultitask;
			file << spr.initialVar;
			file << spr.initialValue;
			file << spr.finalVar;
			file << spr.finalValue;
			file << spr.activate;
			file << spr.activationType;

			file << pos.x;						// Double
			file << pos.y;						// Double
			file << pos.l;						// Int
			file << int((*j)->isActive());		// Int
		}
		else 
		{
			// Empty slot.
			file << STRING();
		}
	}

	// Threads
	{
		THREAD_ENUM threads = CThread::enumerateThreads();
		THREAD_ENUM::ITR itr = threads.begin();
		file << int(threads.size() - 1);

		for (; itr != threads.end(); ++itr)
		{
			// Threads specific to a board will appear in the threads
			// member of g_pBoard. These are non-persistent threads.
			bool bPersist = true;
			std::vector<CThread *>::const_iterator j = g_pBoard->threads.begin();
			for (; j != g_pBoard->threads.end(); ++j)
			{
				if (*j == *itr)
				{
					// It is not persistent.
					bPersist = false;
					break;
				}
			}

			file << (*itr)->getFileName();
			file << int(bPersist ? 1 : 0);

			if (bPersist)
			{
				// It might still be an item thread.
				bool bItem = false;
				std::vector<CItem *>::const_iterator k = g_pBoard->items.begin();
				for (; k != g_pBoard->items.end(); ++k)
				{
					if ((*k) && (*k)->getThread() == *itr)
					{
						bItem = true;
						break;
					}
				}

				file << int(bItem ? 1 : 0);

				if (bItem)
				{
					// If it is an item thread, record the item to reattach it to.
					file << int(k - g_pBoard->items.begin());
				}
			}

			file << int((*itr)->isSleeping() ? 1 : 0);
			file << double((*itr)->sleepRemaining());

			// Serialise the program state so that it can be reconstucted later.
			(*itr)->serialiseState(file);
		}
	}
        
	// Movement size (pixel movement setting).
	file << double (CSprite::m_bPxMovement ? 0.0 : 1.0);
  
/**
	// OOP information.
        Call BinWriteLong(num, UBound(g_objects))
        For t = 0 To UBound(g_objects)
            Call BinWriteLong(num, g_objects(t).hClass)
            Call BinWriteString(num, g_objects(t).strInstancedFrom)
        Next t
        Call BinWriteLong(num, UBound(g_objHandleUsed))
        For t = 0 To UBound(g_objHandleUsed)
            If (g_objHandleUsed(t)) Then
                Call BinWriteByte(num, 1)
            Else
                Call BinWriteByte(num, 0)
            End If
        Next t
        Dim lngFreeableObjects As Long
        lngFreeableObjects = countFreeableObjects(g_garbageHeap)
        Call BinWriteLong(num, lngFreeableObjects)
        For t = 0 To lngFreeableObjects
            Call BinWriteLong(num, getFreeableObjectHandle(g_garbageHeap, t))
        Next t
**/

	// Loop offset (game speed modifier).
	file << CSprite::getLoopOffset();

}

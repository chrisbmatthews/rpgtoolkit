/*
 * All contents copyright 2003, 2004, 2005 Christopher Matthews or Contributors.
 * Various port optimizations copyright by Colin James Fitzpatrick, 2005.
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
#include "../misc/misc.h"
#include "../movement/CPlayer/CPlayer.h"
#include <vector>

extern std::vector<CPlayer *> g_players;
extern CInventory g_inv;
extern STRING g_projectPath;
extern int g_selectedPlayer;
extern CSprite *g_pSelectedPlayer;
extern unsigned long g_gp;
extern COLORREF g_mwinColor;
extern STRING g_mwinBkg;
extern STRING g_fontFace;
extern int g_fontSize;
extern COLORREF g_color;
extern BOOL g_bold;
extern BOOL g_italic;
extern BOOL g_underline;
extern unsigned long g_stepsTaken;
extern MAIN_FILE g_mainFile;
extern LPBOARD g_pBoard;
extern STRING g_menuGraphic, g_fightMenuGraphic;
extern int g_mwinSize;
extern double g_movementSize;

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

	// tbd:	- clear redirects
	//		- hide players

	short majorVer, minorVer;
	file >> majorVer >> minorVer;

	CProgram::freeGlobals();
	CThread::destroyAll();

	STRING varName;
	double varValue;
	STRING varString;

	unsigned int i;
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
			LPSTACK_FRAME pVar = CProgram::getGlobal(varName);
			pVar->udt = UDT_LIT;
			pVar->lit = varString;
		}
	}

	// Get redirects.
	file >> count;
	for (i = 0; i < count; ++i)
	{
		file >> varName >> varString;
		if (!varName.empty())
		{
			CProgram::setRedirect(varName, varString);
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

	for (i = 0; i < 5; ++i)
	{
		STRING name, fileName;
		file >> name >> fileName;
		if (!fileName.empty())
		{
			CPlayer *p = new CPlayer(g_projectPath + TEM_PATH + fileName, false, false);
			p->name(name);
			g_players.push_back(p);
		}
	}

	g_inv.clear();
	file >> count;
	for (i = 0; i <= count; ++i)
	{
		STRING fileName, handle;
		int quantity;
		file >> fileName >> handle >> quantity;
		if (!fileName.empty())
		{
			g_inv.give(fileName, quantity);
		}
	}

	for (i = 0; i < 16; ++i)
	{
		for (unsigned int j = 0; j < 5; ++j)
		{
			// tbd: equipment
			// playerEquip$(t, z) = BinReadString(num)   'What is equipped on each player (filename)
			// equipList$(t, z) = BinReadString(num)   'What is equipped on each player (handle)

			STRING fileName, handle;
			file >> fileName >> handle;
		}
	}

	for (i = 0; i < g_players.size(); ++i)
	{
		CPlayer *p = g_players[i];
		int hp, sm, dp, fp;
		file >> hp >> sm >> dp >> fp;
		p->equipmentHP(hp);
		p->equipmentSM(sm);
		p->equipmentDP(dp);
		p->equipmentFP(fp);
	}

	int unused;
	file >> unused; // menuColor

	file >> g_selectedPlayer;
	g_pSelectedPlayer = g_players[g_selectedPlayer];
	int gp;
	file >> gp;
	g_gp = gp; // Performs an upcast.
	int colour;
	file >> colour;
	g_mwinColor = colour;
	file >> g_mwinBkg;
	if (colour == -1) g_mwinBkg = _T("");
	int debug;
	file >> debug; // Show the debugger?
	// tbd - use 'debug'
	int fontColour;
	file >> fontColour;
	g_color = fontColour;
	file >> g_fontFace;
	file >> g_fontSize;
	file >> g_bold >> g_underline >> g_italic;
	int gameTime;
	file >> gameTime;
	// tbd - use 'gameTime'
	int steps;
	file >> steps;
	g_stepsTaken = steps;
	STRING mainFile;
	file >> mainFile;
	g_mainFile.open(GAM_PATH + mainFile);
	STRING board;
	file >> board;
	g_pBoard->open(g_projectPath + BRD_PATH + removePath(board));

	for (i = 0; i < 5; ++i)
	{
		double x, y;
		int z;
		file >> x >> y >> z;
		if (i < g_players.size())
		{
			CPlayer *p = g_players[i];
			if (p)
			{
				p->setPosition(int(x), int(y), z, g_pBoard->coordType);
			}
		}
	}

	for (i = 0; i < 5; ++i)
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
			}
		}
	}

	for (i = 0; i < 26; ++i)
	{
		// Other player list isn't currently used.
		STRING otherPlayer, otherPlayerHandle;
		file >> otherPlayer >> otherPlayerHandle;
	}

	file >> g_menuGraphic >> g_fightMenuGraphic;
	file >> g_mwinSize;
	STRING newPlyrName;
	file >> newPlyrName;
	// tbd - call a new player routine (i.e. not the RPGCode function)

	// Restore threads.
	file >> count;
	for (i = 0; i <= count; ++i)
	{
		STRING fileName;
		file >> fileName;

		BOOL bPersist;
		file >> bPersist;

		// Position in program. Probably cannot be restored.
		// Theoretically a divergence from the previous
		// implementation but in practice this should cause
		// few problems.
		int pos;
		file >> pos;

		BOOL bSleep;
		file >> bSleep;
		double duration;
		file >> duration;

		// This whole thread restoration is dubious and has
		// always been dubious because the id of the restored
		// thread will not be the same as the id of the original
		// thread rendering variables holding old thread ids
		// useless.
		CThread *pThread = CThread::create(fileName);
		if (!bPersist)
		{
			g_pBoard->threads.push_back(pThread);
		}
		if (bSleep)
		{
			pThread->sleep(int(duration * 1000.0));
		}

		// Read local variables but don't actually attempt to set
		// them because I can't see any good way of doing this.
		// An especially futile task when we aren't restoring the
		// position.
		int heaps;
		file >> heaps;
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

	// Movement size.
	file >> g_movementSize;

	// Partially obsolete OOP information.
	if (minorVer >= 1)
	{
		file >> count;
		for (i = 0; i <= count; ++i)
		{
			int hClass; STRING className;
			file >> hClass >> className;
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

	// Loop offset - 3.0.7 equivalent?
	// tbd - have Delano look at this
	if (minorVer >= 2)
	{
		int loopOffset;
		file >> loopOffset;
	}

	// Currently obsolete garbage collection information. But
	// garbage collection will have to be reintroduced sooner
	// or later and it might become useful then.
	if (minorVer >= 3)
	{
		file >> count;
		for (i = 0; i <= count; ++i)
		{
			int data;
			file >> data;
		}
	}

	g_pSelectedPlayer->setActive(true);
	g_pSelectedPlayer->send();
}

void saveSaveState(const STRING file)
{
}

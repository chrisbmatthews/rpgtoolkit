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

	// tbd:	- hide players - default to hidden. No record of whether
	//						 they were active or hidden. Use position?

	short majorVer, minorVer;
	file >> majorVer >> minorVer;

	CProgram::clearRedirects();
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

	for (i = 0; i < 5; ++i)
	{
		STRING name, fileName;
		file >> name >> fileName;
		if (!fileName.empty())
		{
			CPlayer *p = new CPlayer(g_projectPath + TEM_PATH + removePath(fileName), false, false);
			p->name(name);
			g_players.push_back(p);
		}
	}

	g_inv.clear();
	short itemCount;					// VB recorded this as a short.
	file >> itemCount;
	for (i = 0; i <= itemCount; ++i)
	{
		STRING fileName, handle;
		int quantity;
		file >> fileName >> handle >> quantity;
		if (!fileName.empty())
		{
			g_inv.give(g_projectPath + ITM_PATH + removePath(fileName), quantity);
		}
	}

	// Equipment - slot numbers run from 1.
	for (i = 1; i <= 16; ++i)
	{
		for (unsigned int j = 0; j < 5; ++j)
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
	for (i = 0; i < 5; ++i)
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

	int bd, un, it;
	file >> bd >> un >> it;
	g_bold = bool(bd);
	g_underline = bool(un);
	g_italic = bool(it);

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
	// tbd: remove path up to...
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
				// tbd: increment minor ver and store PX_ABSOLUTE?
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
		if (!fileName.empty())
		{
			CThread *pThread = CThread::create(fileName);
			if (!bPersist)
			{
				g_pBoard->threads.push_back(pThread);
			}
			if (bSleep)
			{
				pThread->sleep(int(duration * 1000.0));
			}
		}

		// Read local variables but don't actually attempt to set
		// them because I can't see any good way of doing this.
		// An especially futile task when we aren't restoring the
		// position.
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
	}

	// Movement size (probably unneeded unless changed halfway through game).
	double movementSize;
	file >> movementSize;
	CSprite::m_bPxMovement = (movementSize != 1.0);

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
	file << short(3);				// Minor version
                   
	unsigned int i = 0;

/**
	// Numerical globals.
        Dim nCount As Long
        nCount = countNumVars(globalHeap)
        
        Call BinWriteLong(num, nCount)
        
        Dim t As Long
        For t = 1 To nCount
            Call BinWriteString(num, GetNumName(t - 1, globalHeap))
            Call BinWriteDouble(num, GetNumVar(GetNumName(t - 1, globalHeap), globalHeap))
        Next t
        
	// Literal globals.
        nCount = countLitVars(globalHeap)
        
        Call BinWriteLong(num, nCount)
        
        For t = 1 To nCount
            Call BinWriteString(num, GetLitName(t - 1, globalHeap))
            Call BinWriteString(num, GetLitVar(GetLitName(t - 1, globalHeap), globalHeap))
        Next t
        
	// Redirects.
        nCount = countRedirects()
        
        Call BinWriteLong(num, nCount)
        
        For t = 1 To nCount
            Call BinWriteString(num, getRedirectName(t - 1))
            Call BinWriteString(num, getRedirect(getRedirectName(t - 1)))
        Next t
**/
        
	// Player information.
	for (i = 0; i < 5; ++i)
	{
		STRING name, filename;
		if (i < g_players.size() && g_players.at(i))
		{
			name = g_players.at(i)->name();
			filename = g_players.at(i)->getPlayer()->fileName;
		}
		file << name << fileName;
	}

	// Inventory.
	file << short(g_inv.size());

	for (i = 0; i != g_inv.size(); ++i)
	{
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
		for (unsigned int j = 0; j < 5; ++j)
		{
			STRING filename, handle;
			if (j < g_players.size() && g_players.at(j))
			{
				LPEQ_SLOT pEq = g_players.at(j)->equipment(i);
				filename = pEq->first;
				handle = pEq->second;
			}
			file << filename << handle;
		}
	}

	// Equipment stat modifiers.
	for (i = 0; i < 5; ++i)
	{
		int hp = 0, sm = 0, dp = 0, fp = 0;
		if (i < g_players.size() && g_players.at(i))
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
	for (i = 0; i < 5; ++i)
	{
		SPRITE_POSITION p;
		if (i < g_players.size() && g_players.at(i))
		{
			// tbd: increment minor ver and store PX_ABSOLUTE?
			int x, y;
			p = g_players.at(i)->getPosition();
			x = int(p.x);
			y = int(p.y);
			coords::pixelToTile(x, y, g_pBoard->coordType, true, g_pBoard->sizeX);
			p.x = double(x);
			p.y = double(y);
		}
		file << p.x << p.y << p.l;
	}

	// Player levels.
	for (i = 0; i < 5; ++i)
	{
		int nl = 0, lp = 0;
		if (i < g_players.size() && g_players.at(i))
		{
			LPPLAYER pPlayer = g_players.at(i)->getPlayer();
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
        
/**
	// Active threads.
        Call BinWriteLong(num, UBound(Threads))
        For t = 0 To UBound(Threads)
            Call BinWriteString(num, Threads(t).filename)
            If Threads(t).bPersistent Then
                Call BinWriteLong(num, 1)
            Else
                Call BinWriteLong(num, 0)
            End If
            Call BinWriteLong(num, Threads(t).thread.programPos)
            If Threads(t).bIsSleeping Then
                Call BinWriteLong(num, 1)
            Else
                Call BinWriteLong(num, 0)
            End If
            Dim dDuration As Double
            dDuration = ThreadSleepRemaining(t)
            Call BinWriteDouble(num, dDuration)
            
            'write local variables...
            Call BinWriteLong(num, Threads(t).thread.currentHeapFrame)
            Dim tt As Long
            For tt = 0 To Threads(t).thread.currentHeapFrame
                'print num vars...
                nCount = countNumVars(Threads(t).thread.heapStack(tt))
                Call BinWriteLong(num, nCount)
                
                Dim ttt As Long
                For ttt = 1 To nCount
                    Call BinWriteString(num, GetNumName(ttt - 1, Threads(t).thread.heapStack(tt)))
                    Call BinWriteDouble(num, GetNumVar(GetNumName(ttt - 1, Threads(t).thread.heapStack(tt)), Threads(t).thread.heapStack(tt)))
                Next ttt
                
                'print lit vars...
                nCount = countLitVars(Threads(t).thread.heapStack(tt))
                Call BinWriteLong(num, nCount)
                
                For ttt = 1 To nCount
                    Call BinWriteString(num, GetLitName(ttt - 1, Threads(t).thread.heapStack(tt)))
                    Call BinWriteString(num, GetLitVar(GetLitName(ttt - 1, Threads(t).thread.heapStack(tt)), Threads(t).thread.heapStack(tt)))
                Next ttt
            Next tt
        Next t
**/
        
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


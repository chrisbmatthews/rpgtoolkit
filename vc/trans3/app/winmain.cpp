/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

/*
 * Inclusions.
 */
#include "../rpgcode/CProgram.h"
#include "../plugins/plugins.h"
#include "../common/paths.h"
#include "../common/mainfile.h"
#include "../common/item.h"
#include "../common/player.h"
#include "../common/mbox.h"
#include "../common/CAllocationHeap.h"
#include "../common/board.h"
#include "../common/CFile.h"
#include "../render/render.h"
#include "../movement/CPlayer/CPlayer.h"
#include "../movement/CItem/CItem.h"
#include "../movement/movement.h"
#include "../input/input.h"
#include "../misc/misc.h"
#include "../audio/CAudioSegment.h"
#include "../images/FreeImage.h"
#include "../resource.h"
#include "winmain.h"
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <commdlg.h>
#include <string>
#include <vector>
#include <sstream>
#include <iostream>

/*
 * Globals.
 */
GAME_STATE g_gameState = GS_IDLE;		// The current gamestate.
MAIN_FILE g_mainFile;					// The loaded main file.
CAllocationHeap<BOARD> g_boards;		// All boards.
LPBOARD g_pBoard = NULL;				// The active board.
CAllocationHeap<CAudioSegment> g_music;	// All music.
CAudioSegment *g_bkgMusic = NULL;		// Playing background music.

std::vector<CPlayer *> g_players;		// Loaded players.
ZO_VECTOR g_sprites;					// z-ordered players and items.
CSprite *g_pSelectedPlayer = NULL;		// Pointer to selected player?

HINSTANCE g_hInstance = NULL;			// Handle to application.
double g_renderCount = 0;				// Count of GS_MOVEMENT state loops.
double g_renderTime = 0;				// Millisecond cumulative GS_MOVEMENT state loop time.

IPlugin *g_pMenuPlugin = NULL;			// The menu plugin.

bool CSprite::m_bPxMovement = false;	// Using pixel or tile movement.

#ifdef _DEBUG

unsigned long g_allocated = 0;

void *operator new(size_t size)
{
	void *p = malloc(sizeof(size_t) + size);
	*(size_t *)p = size;
	g_allocated += size;
	return ((size_t *)p + 1);
}

void operator delete(void *p)
{
	if (!p) return;
	p = (size_t *)p - 1;
	g_allocated -= *(size_t *)p;
	free(p);
}

#endif

void termFunc(void)
{
	messageBox(	"An unhandled exception has occurred. "
				"Trans3 will now close.\n\n"
				"We apologize for this inconvenience. "
				"If this problem persists, please post at www.toolkitzone.com "
				"on the \"Toolkit Discussion\" forum with an explanation of "
				"what you were doing when the bug occurred and instructions "
				"on how to reproduce the bug, and we will attempt to solve "
				"this problem."	);
	exit(EXIT_FAILURE);
}

/*
 * Split a string.
 */
void split(const std::string str, const std::string delim, std::vector<std::string> &parts)
{
	std::string::size_type pos = std::string::npos, begin = 0;
	while ((pos = str.find(delim, pos + 1)) != std::string::npos)
	{
		parts.push_back(str.substr(begin, pos - begin));
		begin = pos + 1;
	}
	parts.push_back(str.substr(begin, pos - begin));
}

/*
 * Set up the game.
 */
VOID setUpGame(VOID)
{

	extern int g_selectedPlayer;
	extern std::string g_projectPath;
	extern RECT g_screen;
	extern SCROLL_CACHE g_scrollCache;

	g_pBoard = g_boards.allocate();

	// Load plugins.
	CProgram::freePlugins();
	std::vector<std::string>::iterator i = g_mainFile.plugins.begin();
	for (; i != g_mainFile.plugins.end(); ++i)
	{
		IPlugin *p = loadPlugin(g_projectPath + PLUG_PATH + *i);
		if (!p) continue;
		if (p->plugType(PT_RPGCODE))
		{
			CProgram::addPlugin(p);
		}
		else
		{
			delete p;
		}
	}
	// Menu plugin.
	{
		IPlugin *p = loadPlugin(g_projectPath + PLUG_PATH + g_mainFile.menuPlugin);
		if (p && p->plugType(PT_MENU))
		{
			extern IPlugin *g_pMenuPlugin;
			g_pMenuPlugin = p;
		}
		else
		{
			delete p;
		}
	}
	// Fight plugin.
	{
		IPlugin *p = loadPlugin(g_projectPath + PLUG_PATH + g_mainFile.fightPlugin);
		if (p && p->plugType(PT_FIGHT))
		{
			extern IPlugin *g_pFightPlugin;
			g_pFightPlugin = p;
		}
		else
		{
			delete p;
		}
	}

	CSprite::m_bPxMovement = g_mainFile.pixelMovement;
	CSprite::setLoopOffset(g_mainFile.getGameSpeed());
	g_selectedPlayer = 0;

    // Get the last gAvgTime from the registry.
	double avgTime = -1;
    if (!g_mainFile.extendToFullScreen)
	{
		switch (g_mainFile.mainResolution)
		{
			case 0: // 640 * 480
				getSetting("gAvgTime_640_Win", avgTime);
				break;
			case 1: // 1024 * 768
				getSetting("gAvgTime_1024_Win", avgTime);
				break;
			default: // Custom -- use 800 * 600
				getSetting("gAvgTime_800_Win", avgTime);
				break;
		}
	}
	else
	{
		switch (g_mainFile.mainResolution)
		{
			case 0: // 640 * 480
				getSetting("gAvgTime_640_Full", avgTime);
				break;
			case 1: // 1024 * 768
				getSetting("gAvgTime_1024_Full", avgTime);
				break;
			default: // Custom -- use 800 * 600
				getSetting("gAvgTime_800_Full", avgTime);
				break;
		}
	}
	// Do an fps estimate.
	if (avgTime < 0) avgTime = 0.1; 

	g_renderTime = avgTime * MILLISECONDS;
	g_renderCount = 100;
	g_renderTime *= g_renderCount;

	// Create and load start player.
	g_players.clear();
	g_players.reserve(5);			// Reserve places for 5 players (can be expanded).
	if (!g_mainFile.initChar.empty())
	{
		g_players.push_back(new CPlayer(g_projectPath + TEM_PATH + g_mainFile.initChar, true));
		g_pSelectedPlayer = g_players.front();
	}

// Testing!
//	g_players.push_back(new CPlayer(g_projectPath + TEM_PATH + g_mainFile.initChar, true));

	// This *must* be done here. I'm not sure why.
	// But don't move it to render.cpp unless you like seeing
	// things crash for no real reason.
	extern CGDICanvas *g_cnvCursor;
	g_cnvCursor = new CGDICanvas();
	g_cnvCursor->CreateBlank(NULL, 32, 32, TRUE);
	{
		const HDC hdc = g_cnvCursor->OpenDC();
		const HDC compat = CreateCompatibleDC(hdc);
		extern HINSTANCE g_hInstance;
		HBITMAP bmp = LoadBitmap(g_hInstance, MAKEINTRESOURCE(IDB_BITMAP1));
		HGDIOBJ obj = SelectObject(compat, bmp);
		BitBlt(hdc, 0, 0, 32, 32, compat, 0, 0, SRCCOPY);
		g_cnvCursor->CloseDC(hdc);
		SelectObject(compat, obj);
		DeleteObject(bmp);
		DeleteDC(compat);
	}

	// Run startup program.
	if (!g_mainFile.startupPrg.empty())
	{
		CProgram(g_projectPath + PRG_PATH + g_mainFile.startupPrg).run();
	}

	if (!g_mainFile.initBoard.empty())
	{
		g_pBoard->open(g_projectPath + BRD_PATH + g_mainFile.initBoard);

		// Set player position before rendering in order to align board.
		g_pSelectedPlayer->setPosition (g_pBoard->playerX ? g_pBoard->playerX : 1,
										g_pBoard->playerY ? g_pBoard->playerY : 1,
										g_pBoard->playerLayer ? g_pBoard->playerLayer : 1,
										g_pBoard->coordType);

		g_pSelectedPlayer->alignBoard(g_screen, true);
		g_scrollCache.render(true);

		// z-order the sprites on board loading.
		g_sprites.zOrder();

		if (!g_pBoard->boardMusic.empty())
		{
			g_bkgMusic->open(g_pBoard->boardMusic);
			g_bkgMusic->play(true);
		}
		if (!g_pBoard->enterPrg.empty())
		{
			CProgram(g_projectPath + PRG_PATH + g_pBoard->enterPrg).run();
		}
// Testing!
//		g_players[1]->setPosition(10 * 32, 5 * 32, 1);
	g_pSelectedPlayer->createVectors();	// Temporary.

	}

}

/*
 * Open engine subsystems.
 */
VOID openSystems(VOID)
{
	extern void initRpgCode();
	initPluginSystem();
	FreeImage_Initialise();
	srand(GetTickCount());
	initGraphics();
	CProgram::initialize();
	initRpgCode();
	CAudioSegment::initLoader();
	g_bkgMusic = g_music.allocate();
	//createRpgCodeGlobals();
	setUpGame();
}

/*
 * Close engine subsystems.
 */
VOID closeSystems(VOID)
{

	// Free plugins first so that they have access to
	// everything we're about to kill.
	CProgram::freePlugins();
	CThread::destroyAll();
	extern IPlugin *g_pMenuPlugin, *g_pFightPlugin;
	if (g_pMenuPlugin)
	{
		g_pMenuPlugin->terminate();
		delete g_pMenuPlugin;
		g_pMenuPlugin = NULL;
	}
	if (g_pFightPlugin)
	{
		g_pFightPlugin->terminate();
		delete g_pFightPlugin;
		g_pFightPlugin = NULL;
	}
	freePluginSystem();

	closeGraphics();
	extern void freeInput(void);
	freeInput();

	// Destroy sprites (move to somewhere)
	for (std::vector<CPlayer *>::const_iterator i = g_players.begin(); i != g_players.end(); ++i)
	{
		delete (*i);
	}
	g_players.clear();

	// Items... currently freed by the board destructor.

	g_music.free(g_bkgMusic);
	g_bkgMusic = NULL;
	CAudioSegment::freeLoader();

	FreeImage_DeInitialise();

	g_boards.free(g_pBoard);
	g_pBoard = NULL;

}

/*
 * Get a main file name.
 */
std::string getMainFileName(const std::string cmdLine)
{

	std::vector<std::string> parts;
	split(cmdLine, " ", parts);

	if (parts.size() == 2)
	{
		// Main game file passed on command line.
		const std::string ret = GAM_PATH + parts[1];
		if (CFile::fileExists(ret)) return ret;
	}
	else if (parts.size() == 3)
	{
		// Run program.
		const std::string main = GAM_PATH + parts[1];
		if (CFile::fileExists(main))
		{
			g_mainFile.open(main);
			g_mainFile.startupPrg = "";
			g_mainFile.initBoard = "";
			openSystems();
			extern std::string g_projectPath;
			CProgram(g_projectPath + PRG_PATH + parts[2]).run();
			closeSystems();
			return "";
		}
	}

	TCHAR strFileName[MAX_PATH] = "";

	OPENFILENAME ofn = {
		sizeof(OPENFILENAME),
		NULL,
		g_hInstance,
		"Supported Files\0*.gam;*.tpk\0RPG Toolkit Main File (*.gam)\0*.gam\0RPG Toolkit PakFile (*.tpk)\0*.tpk\0All files(*.*)\0*.*",
		NULL, 0, 1,
		strFileName, MAX_PATH,
		NULL, 0,
		GAM_PATH, "Open Main File",
		OFN_FILEMUSTEXIST | OFN_HIDEREADONLY, 0, 0,
		TEXT(".gam"),
		0, NULL, NULL
	};

	const std::string fileName = (GetOpenFileName(&ofn) ? strFileName : "");

	if (_stricmp(getExtension(fileName).c_str(), "TPK") == 0)
	{
		/* ... do pakfile stuff ... */
		return "main.gam";
	}
	else
	{
		return fileName;
	}

}

/*
 * Run a frame of game logic.
 *
 * return (out) - current game state
 */
GAME_STATE gameLogic(VOID)
{
	switch (g_gameState)
	{
		case GS_IDLE:
			// Only receive input when the player is idle.
			scanKeys();

		case GS_MOVEMENT:
		{

			extern HWND g_hHostWnd;
			std::stringstream ss;
			ss << g_mainFile.gameTitle.c_str() << " — " << g_pBoard->vectors.size() << " vectors, " << ((g_renderCount * MILLISECONDS) / g_renderTime) << " FPS";
#if _DEBUG
			ss << ", " << g_allocated << " bytes";
#endif
			SetWindowText(g_hHostWnd, ss.str().c_str());

			// Multitask.
			CThread::multitask();

			// Movement.
			std::vector<CSprite *>::const_iterator i = g_sprites.v.begin();
			for (; i != g_sprites.v.end(); ++i)
			{
				(*i)->move(g_pSelectedPlayer, false);
			}

			// Run programs outside of the above loop for the cases
			// when sprites may be removed from the vector.
			g_pSelectedPlayer->playerDoneMove();

			// Render.
			renderNow();
		} break;

		case GS_QUIT:
		default:
			// Close down.
			break;
	}

	return g_gameState;
}

/*
 * Main event loop.
 */
INT mainEventLoop(VOID)
{

	// Calculate how long one frame should take, in milliseconds
	#define FPS_CAP 120.0
	CONST DWORD dwOneFrame = DWORD(1000.0 / FPS_CAP);

	// Define a structure to hold the messages we recieve
	MSG message;

	while (TRUE)
	{

		// Get current time
		DWORD dwTimeNow = GetTickCount();

		if (PeekMessage(&message, NULL, 0, 0, PM_REMOVE))
		{
			// There was a message, check if it's eventProcessor() asking
			// to leave this loop
			if (message.message == WM_QUIT)
			{
				// It was; quit
				break;
			}
			else
			{
				// Change ascii keys and the like to virtual keys
				TranslateMessage(&message);
				// Send the message to the event processor
				DispatchMessage(&message);
			}
		}

		// Run a frame of game logic
		if (gameLogic() != GS_PAUSE)
		{
			// Count this loop if not in Paused state

			// Sleep for any remaining time
			while ((GetTickCount() - dwTimeNow) < dwOneFrame);

			// Update length rendering took
			dwTimeNow = GetTickCount() - dwTimeNow;

			// Add the time for this loop and increment the counter.
			// Add only if this is a "short" loop.
			if (dwTimeNow < 200)
			{
				g_renderTime += dwTimeNow;
				++g_renderCount;
			}
		}

	}

	return message.wParam;
}

#include <direct.h>

/*
 * Main entry point.
 */
INT mainEntry(CONST HINSTANCE hInstance, CONST HINSTANCE /*hPrevInstance*/, CONST LPSTR lpCmdLine, CONST INT nCmdShow)
{
	// #define WORKING_DIRECTORY "C:\\Program Files\\Toolkit3\\"
	#define WORKING_DIRECTORY "C:\\CVS\\Tk3 Dev\\"

	set_terminate(termFunc);

	g_hInstance = hInstance;

	_chdir(WORKING_DIRECTORY);

	freopen("log.txt", "w", stderr); // Destination for std::cerr.

	const std::string fileName = getMainFileName(lpCmdLine);
	_chdir(WORKING_DIRECTORY);

	if (fileName.empty()) return EXIT_SUCCESS;

	if (!g_mainFile.open(fileName)) return EXIT_SUCCESS;

	try
	{
		openSystems();
		const int toRet = mainEventLoop();
		closeSystems();
		return toRet;
	}
	catch (...)
	{
		terminate();
	}

	return EXIT_SUCCESS;
}

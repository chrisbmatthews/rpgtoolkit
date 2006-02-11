/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

/*
 * Inclusions.
 */
#include "../../tkCommon/strings.h"
#include "../rpgcode/CProgram.h"
#include "../plugins/plugins.h"
#include "../common/paths.h"
#include "../common/mainfile.h"
#include "../common/item.h"
#include "../common/player.h"
#include "../common/mbox.h"
#include "../common/CAllocationHeap.h"
#include "../common/CAnimation.h"
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
GAME_TIME g_gameTime;					// Length of game info.

std::vector<CPlayer *> g_players;		// Loaded players.
ZO_VECTOR g_sprites;					// z-ordered players and items.
CPlayer *g_pSelectedPlayer = NULL;		// Pointer to selected player?

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

void termFunc()
{
	messageBox(	_T("An unhandled exception has occurred. ")
				_T("Trans3 will now close.\n\n")
				_T("We apologize for this inconvenience. ")
				_T("If this problem persists, please post at www.toolkitzone.com ")
				_T("on the \"Toolkit Discussion\" forum with an explanation of ")
				_T("what you were doing when the bug occurred and instructions ")
				_T("on how to reproduce the bug, and we will attempt to solve ")
				_T("this problem.")	);
	exit(EXIT_FAILURE);
}

/*
 * Set up the game.
 */
void setUpGame()
{
	extern int g_selectedPlayer;
	extern STRING g_projectPath;
	extern RECT g_screen;
	extern SCROLL_CACHE g_scrollCache;

	// Load plugins.
	CProgram::freePlugins();
	std::vector<STRING>::iterator i = g_mainFile.plugins.begin();
	for (; i != g_mainFile.plugins.end(); ++i)
	{
		if (i->empty()) continue;
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
	if (!g_mainFile.menuPlugin.empty())
	{
		IPlugin *p = loadPlugin(g_projectPath + PLUG_PATH + g_mainFile.menuPlugin);
		if (p && p->plugType(PT_MENU))
		{
			extern IPlugin *g_pMenuPlugin;
			if (g_pMenuPlugin)
			{
				g_pMenuPlugin->terminate();
				delete g_pMenuPlugin;
			}
			g_pMenuPlugin = p;
		}
		else
		{
			delete p;
		}
	}

	// Fight plugin.
	if (!g_mainFile.fightPlugin.empty())
	{
		IPlugin *p = loadPlugin(g_projectPath + PLUG_PATH + g_mainFile.fightPlugin);
		if (p && p->plugType(PT_FIGHT))
		{
			extern IPlugin *g_pFightPlugin;
			if (g_pFightPlugin)
			{
				g_pFightPlugin->terminate();
				delete g_pFightPlugin;
			}
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
				getSetting(_T("gAvgTime_640_Win"), avgTime);
				break;
			case 1: // 1024 * 768
				getSetting(_T("gAvgTime_1024_Win"), avgTime);
				break;
			default: // Custom -- use 800 * 600
				getSetting(_T("gAvgTime_800_Win"), avgTime);
				break;
		}
	}
	else
	{
		switch (g_mainFile.mainResolution)
		{
			case 0: // 640 * 480
				getSetting(_T("gAvgTime_640_Full"), avgTime);
				break;
			case 1: // 1024 * 768
				getSetting(_T("gAvgTime_1024_Full"), avgTime);
				break;
			default: // Custom -- use 800 * 600
				getSetting(_T("gAvgTime_800_Full"), avgTime);
				break;
		}
	}
	// Do an fps estimate.
	if (avgTime < 0) avgTime = 0.1; 

	g_renderTime = avgTime * MILLISECONDS;
	g_renderCount = 100;
	g_renderTime *= g_renderCount;

	// Create and load start player.
	for (std::vector<CPlayer *>::const_iterator j = g_players.begin(); j != g_players.end(); ++j)
	{
		delete *j;
	}
	g_players.clear();

	if (!g_mainFile.initChar.empty())
	{
		g_players.push_back(new CPlayer(g_projectPath + TEM_PATH + g_mainFile.initChar, true, true));
		g_pSelectedPlayer = g_players.front();
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
		g_pSelectedPlayer->createVectors();	// TBD: Temporary.

	}
}

/*
 * Open engine subsystems.
 */
void openSystems()
{
	extern void initRpgCode();
	extern GAME_TIME g_gameTime;
	initPluginSystem();
	FreeImage_Initialise();
	srand(GetTickCount());
	initGraphics();
	CProgram::initialize();
	initRpgCode();
	CAudioSegment::initLoader();
	g_bkgMusic = g_music.allocate();
	//createRpgCodeGlobals();
	g_pBoard = g_boards.allocate();
	g_gameTime.reset(0);
	setUpGame();
}

/*
 * Reset the game (for RPGCode functions and default battle loss).
 */
void reset()
{
	CProgram::freeGlobals();
	CThread::destroyAll();
	// Other plugin stuff?
	setUpGame();
}

/*
 * Close engine subsystems.
 */
void closeSystems()
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
	extern void freeInput();
	freeInput();

	// Destroy sprites (move to somewhere)
	for (std::vector<CPlayer *>::const_iterator i = g_players.begin(); i != g_players.end(); ++i)
	{
		delete (*i);
	}
	g_players.clear();


	g_music.free(g_bkgMusic);
	g_bkgMusic = NULL;
	CAudioSegment::freeLoader();

	FreeImage_DeInitialise();

	// Items... currently freed by the board destructor.
	g_boards.free(g_pBoard);
	g_pBoard = NULL;

	CThreadAnimation::destroyAll();
	CSharedAnimation::freeAll();
}

/*
 * Get a main file name.
 */
STRING getMainFileName(const STRING cmdLine)
{

	std::vector<STRING> parts;
	split(cmdLine, _T(" "), parts);

	if (parts.size() == 2)
	{
		// Main game file passed on command line.
		const STRING ret = GAM_PATH + parts[1];
		if (CFile::fileExists(ret)) return ret;
	}
	else if (parts.size() == 3)
	{
		// Run program.
		const STRING main = GAM_PATH + parts[1];
		if (CFile::fileExists(main))
		{
			g_mainFile.open(main);
			g_mainFile.startupPrg = _T("");
			g_mainFile.initBoard = _T("");
			openSystems();
			extern STRING g_projectPath;
			CProgram(g_projectPath + PRG_PATH + parts[2]).run();
			closeSystems();
			return _T("");
		}
	}

	TCHAR strFileName[MAX_PATH] = _T("");

	OPENFILENAME ofn = {
		sizeof(OPENFILENAME),
		NULL,
		g_hInstance,
		_T("Supported Files\0*.gam;*.tpk\0RPG Toolkit Main File (*.gam)\0*.gam\0RPG Toolkit PakFile (*.tpk)\0*.tpk\0All files(*.*)\0*.*"),
		NULL, 0, 1,
		strFileName, MAX_PATH,
		NULL, 0,
		GAM_PATH, _T("Open Main File"),
		OFN_FILEMUSTEXIST | OFN_HIDEREADONLY, 0, 0,
		_T(".gam"),
		0, NULL, NULL
	};

	const STRING fileName = (GetOpenFileName(&ofn) ? strFileName : _T(""));

	if (_ftcsicmp(getExtension(fileName).c_str(), _T("TPK")) == 0)
	{
		/* ... do pakfile stuff ... */
		return _T("main.gam");
	}

	return fileName;
}

/*
 * Run a frame of game logic.
 *
 * return (out) - current game state
 */
GAME_STATE gameLogic()
{
	switch (g_gameState)
	{
		case GS_IDLE:
			// Only receive input when the player is idle.
			scanKeys();

		case GS_MOVEMENT:
		{
			extern HWND g_hHostWnd;
			STRINGSTREAM ss;
			ss <<	g_mainFile.gameTitle.c_str()
				<< _T(" — ") << g_pBoard->vectors.size()
				<< _T(" vectors, ") << ((g_renderCount * MILLISECONDS) / g_renderTime)
				<< _T(" FPS");
#if _DEBUG
			ss << _T(", ") << g_allocated << _T(" bytes");
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

		case GS_PAUSE:
			// Relinquish some CPU time.
			Sleep(100);
		case GS_QUIT:
		default:
			break;
	}

	return g_gameState;
}

/*
 * Main event loop.
 */
int mainEventLoop()
{

	// Calculate how long one frame should take, in milliseconds
	#define FPS_CAP 120.0
	const DWORD dwOneFrame = DWORD(1000.0 / FPS_CAP);

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
int mainEntry(const HINSTANCE hInstance, const HINSTANCE /*hPrevInstance*/, const LPTSTR lpCmdLine, const int nCmdShow)
{
	extern STRING g_savePath;

	// #define WORKING_DIRECTORY _T("C:\\Program Files\\Toolkit3\\")
	#define WORKING_DIRECTORY _T("C:\\CVS\\Tk3 Dev\\")

	set_terminate(termFunc);

	g_hInstance = hInstance;

	_tchdir(WORKING_DIRECTORY);

	_tfreopen(_T("log.txt"), _T("w"), stderr); // Destination for std::cerr.

	// Make the default save game folder before pak file stuff.
	_tmkdir(g_savePath.c_str());

	const STRING fileName = getMainFileName(lpCmdLine);
	_tchdir(WORKING_DIRECTORY);

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

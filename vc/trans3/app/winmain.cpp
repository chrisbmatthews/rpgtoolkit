/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

/*
 * Inclusions.
 */
#include "../rpgcode/CProgram/CProgram.h"
#include "../rpgcode/globals.h"
#include "../common/paths.h"
#include "../common/mainfile.h"
#include "../common/item.h"
#include "../common/player.h"
#include "../render/render.h"
#include "../movement/CPlayer/CPlayer.h"
#include "../movement/CItem/CItem.h"
#include "../movement/movement.h"
#include "../common/board.h"
#include "../input/input.h"
#include "../misc/misc.h"
#include "../audio/CAudioSegment.h"
#include "winmain.h"
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <commdlg.h>
#include <string>
#include <vector>

/*
 * Definitions.
 */

/* Header?
#define GS_IDLE 0					// Just re-renders the screen
#define GS_MOVEMENT 1				// Movement is occurring (players or items)
#define GS_PAUSE 2					// Pause game (do nothing)
#define GS_QUIT 3					// Shutdown sequence
*/

/*
 * Globals.
 */
int g_gameState;					// The current gamestate.
MAIN_FILE g_mainFile;				// The loaded main file.
BOARD g_activeBoard;				// The active board.
CAudioSegment *g_bkgMusic = NULL;	// Playing background music.

std::vector<CPlayer *> g_players;	// Loaded players.
std::vector<CItem *> g_items;		// Loaded items.
CSprite *g_pSelectedPlayer = NULL;	// Pointer to selected player?

HINSTANCE g_hInstance = NULL;		// Handle to application.
unsigned int g_renderCount = 0;		// Count of GS_MOVEMENT state loops.
unsigned int g_renderTime = 0;		// Millisecond cumulative GS_MOVEMENT state loop time.

/*
 * Show a main file dialogue.
 *
 * return (out) - file chosen.
 */
std::string mainFileDialog(void)
{

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

	return (GetOpenFileName(&ofn) ? strFileName : "");

}

/*
 * Get a main file name.
 */
std::string getMainFileName(void)
{

	const std::string fileName = mainFileDialog();

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
 * Set up the game.
 */
VOID setUpGame(VOID)
{

	extern double g_movementSize;
	extern int g_selectedPlayer;
	extern std::string g_projectPath;

	g_movementSize = g_mainFile.pixelMovement ? 0.25 : 1.0;
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
	if (avgTime == -1) avgTime = 0.1; 

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
	g_players.push_back(new CPlayer(g_projectPath + TEM_PATH + g_mainFile.initChar, true));

	// Run startup program.
	if (!g_mainFile.startupPrg.empty())
	{
		CProgram(g_projectPath + PRG_PATH + g_mainFile.startupPrg).run();
	}

	if (!g_mainFile.initBoard.empty())
	{
		g_activeBoard.open(g_projectPath + BRD_PATH + g_mainFile.initBoard);
		
		if (!g_activeBoard.boardMusic.empty())
		{
			g_bkgMusic->open(g_activeBoard.boardMusic);
			g_bkgMusic->play(true);
		}
		if (!g_activeBoard.enterPrg.empty())
		{
			CProgram(g_projectPath + PRG_PATH + g_activeBoard.enterPrg).run();
		}
		g_players[g_selectedPlayer]->setPosition(g_activeBoard.playerX ? g_activeBoard.playerX : 1,
												g_activeBoard.playerY ? g_activeBoard.playerY : 1,
												g_activeBoard.playerLayer ? g_activeBoard.playerLayer : 1);
// Testing!
		g_players[1]->setPosition(10, 5, 1);

	}

}

/*
 * Open engine subsystems.
 */
VOID openSystems(VOID)
{
	extern VOID initRpgCode(VOID);

	srand(GetTickCount());
	initGraphics();
	initRpgCode();
	CAudioSegment::initLoader();
	g_bkgMusic = new CAudioSegment();
	createRpgCodeGlobals();
	setUpGame();
}

/*
 * Run a frame of game logic.
 *
 * return (out) - current game state
 */
INT gameLogic(VOID)
{

	switch (g_gameState)
	{
		case GS_IDLE:
		case GS_MOVEMENT:
		{

			extern HWND g_hHostWnd;
			std::stringstream ss;
			ss << g_mainFile.gameTitle.c_str() << " — " << ((g_renderCount * MILLISECONDS) / g_renderTime) << " FPS";
			SetWindowText(g_hHostWnd, ss.str().c_str());

			// Timer stuff.
			// Input.
			scanKeys();

// Testing!
			g_players[1]->setQueuedMovements(rand() % 9, true);

			// Movement.
			for (std::vector<CPlayer *>::const_iterator i = g_players.begin(); i != g_players.end(); i++)
			{
				(*i)->move(g_pSelectedPlayer);
			}
			//for (i = g_items.begin(); i != g_items.end(); i++) i->move();

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
				g_renderCount++;
			}
		}

	}

	return message.wParam;

}

/*
 * Close engine subsystems.
 */
VOID closeSystems(VOID)
{
	closeGraphics();
	extern void freeInput(void);
	freeInput();

	// Destroy sprites (move to somewhere)
	for (std::vector<CPlayer *>::const_iterator i = g_players.begin(); i != g_players.end(); i++)
	{
		delete (*i);
	}
	g_players.clear();

	// Items...

	delete g_bkgMusic;
	CAudioSegment::freeLoader();

}

#include <direct.h>

/*
 * Main entry point.
 */
INT mainEntry(CONST HINSTANCE hInstance, CONST HINSTANCE /*hPrevInstance*/, CONST LPSTR lpCmdLine, CONST INT nCmdShow)
{

	#define WORKING_DIRECTORY "C:\\Program Files\\Toolkit3\\"
	// #define WORKING_DIRECTORY "C:\\CVS\\Tk3 Dev\\"

	g_hInstance = hInstance;

	_chdir(WORKING_DIRECTORY);

	CONST std::string fileName = getMainFileName();
	if (fileName.empty()) return EXIT_SUCCESS;

	g_mainFile.open(fileName);

	extern std::string g_projectPath;
	g_projectPath = WORKING_DIRECTORY + g_projectPath;

	openSystems();

	CONST INT toRet = mainEventLoop();

	closeSystems();

	return toRet;

}

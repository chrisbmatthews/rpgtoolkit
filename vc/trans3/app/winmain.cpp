/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

/*
 * Inclusions.
 */
#include "../rpgcode/CProgram/CProgram.h"
#include "../common/paths.h"
#include "../common/mainfile.h"
#include "../common/item.h"
#include "../common/player.h"
#include "../render/render.h"
#include "../movement/movement.h"
#include "../common/board.h"
#include "../input/input.h"
#include "../misc/misc.h"
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <commdlg.h>
#include <string>
#include <vector>

/*
 * Definitions.
 */
#define GS_IDLE 0					// Just re-renders the screen
#define GS_MOVEMENT 1				// Movement is occurring (players or items)
#define GS_PAUSE 2					// Pause game (do nothing)
#define GS_QUIT 3					// Shutdown sequence

/*
 * Globals.
 */
MAIN_FILE g_mainFile;				// The loaded main file.
BOARD g_activeBoard;				// The active board.
std::vector<PLAYER> g_playerMem;	// Loaded players.
std::vector<ITEM> g_itemMem;		// Loaded items.
HINSTANCE g_hInstance = NULL;		// Handle to application.
int g_renderCount = 0;				// Count of GS_MOVEMENT state loops.
double g_renderTime = 0.0;			// Cumulative GS_MOVEMENT state loop time.

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
	extern std::vector<bool> g_showPlayer;
	extern std::string g_projectPath;
	extern SPRITE_POSITIONS g_pPos;
	extern PENDING_MOVEMENTS g_pendingPlayerMovement;

	g_movementSize = g_mainFile.pixelMovement ? 0.25 : 1.0;
	g_selectedPlayer = 0;

    // Get the last gAvgTime from the registry
    if (!g_mainFile.extendToFullScreen)
	{
		switch (g_mainFile.mainResolution)
		{
			case 0: // 640 * 480
				getSetting("gAvgTime_640_Win", g_renderTime);
				break;
			case 1: // 1024 * 768
				getSetting("gAvgTime_1024_Win", g_renderTime);
				break;
			default: // Custom -- use 800 * 600
				getSetting("gAvgTime_800_Win", g_renderTime);
				break;
		}
	}
	else
	{
		switch (g_mainFile.mainResolution)
		{
			case 0: // 640 * 480
				getSetting("gAvgTime_640_Full", g_renderTime);
				break;
			case 1: // 1024 * 768
				getSetting("gAvgTime_1024_Full", g_renderTime);
				break;
			default: // Custom -- use 800 * 600
				getSetting("gAvgTime_800_Full", g_renderTime);
				break;
		}
	}
	g_renderCount = 100;
	g_renderTime *= g_renderCount;

	// Load initial character.
	if (!g_mainFile.initChar.empty())
	{
		createCharacter(g_projectPath + TEM_PATH + g_mainFile.initChar, 0);
	}

	// Hide all players except the walking graphic one.
	const int size = g_showPlayer.size();
	for (unsigned int i = 0; i < size; i++)
	{
		g_showPlayer[i] = (i == g_selectedPlayer);
		g_pPos[i].stance = "WALK_S";
		g_pPos[i].loopFrame = -1;
	}

	// Run startup program.
	if (!g_mainFile.startupPrg.empty())
	{
		CProgram(g_projectPath + PRG_PATH + g_mainFile.startupPrg).run();
	}

	if (!g_mainFile.initBoard.empty())
	{
		g_activeBoard.open(g_projectPath + BRD_PATH + g_mainFile.initBoard);
		if (!g_activeBoard.enterPrg.empty())
		{
			CProgram(g_projectPath + PRG_PATH + g_activeBoard.enterPrg).run();
		}
		SPRITE_POSITION &pos = g_pPos[g_selectedPlayer];
		PENDING_MOVEMENT &pend = g_pendingPlayerMovement[g_selectedPlayer];
		pend.xOrig = pos.x = g_activeBoard.playerX ? g_activeBoard.playerX : 1;
		pend.yOrig = pos.y = g_activeBoard.playerY ? g_activeBoard.playerY : 1;
		pend.lOrig = pos.l = g_activeBoard.playerLayer ? g_activeBoard.playerLayer : 1;
	}

}

/*
 * Open engine subsystems.
 */
VOID openSystems(VOID)
{

	extern VOID initRpgCode(VOID);
	extern SPRITE_POSITIONS g_pPos;
	extern std::vector<bool> g_showPlayer;
	extern PENDING_MOVEMENTS g_pendingPlayerMovement;

	srand(GetTickCount());

	// Five players for now.
	for (unsigned int i = 0; i < 5; i++)
	{
		g_playerMem.push_back(PLAYER());
		g_pPos.push_back(SPRITE_POSITION());
		g_showPlayer.push_back(false);
		g_pendingPlayerMovement.push_back(PENDING_MOVEMENT());
	}

	initGraphics();
	initRpgCode();
	setUpGame();

}

/*
 * Run a frame of game logic.
 *
 * return (out) - current game state
 */
INT gameLogic(VOID)
{
	renderNow();
	return GS_IDLE;
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
			// Add only if this is a short loop.
			if (dwTimeNow < 200)
			{
				g_renderTime += double(dwTimeNow) / 1000.0; // (Should kill this division!)
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
}

#include <direct.h>

/*
 * Main entry point.
 */
INT WINAPI WinMain(CONST HINSTANCE hInstance, CONST HINSTANCE /*hPrevInstance*/, CONST LPSTR lpCmdLine, CONST INT nCmdShow)
{

	#define WORKING_DIRECTORY "C:\\Program Files\\Toolkit3\\"

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

/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

/*
 * Inclusions.
 */
#include <vector>
#include "input.h"
#include "../common/sprite.h"
#include "../common/paths.h"
#include "../common/board.h"
#include "../common/mainfile.h"
#include "../plugins/plugins.h"
#include "../plugins/constants.h"
#include "../movement/CPlayer/CPlayer.h"
#include "../rpgcode/CProgram.h"

/*
 * Globals.
 */
std::vector<char> g_keys;
IDirectInput8A *g_lpdi = NULL;
IDirectInputDevice8A *g_lpdiKeyboard = NULL;
IDirectInputDevice8A *g_lpdiMouse = NULL;
struct tagMOUSE
{
	POINT move;
	POINT click;
} g_mouse;

/*
 * Process an event from the message queue.
 */
void processEvent()
{
	MSG message;
	if (PeekMessage(&message, NULL, 0, 0, PM_REMOVE))
	{
		// There was a message. Check if it's eventProcessor() asking to leave this loop.
		if (message.message == WM_QUIT)
		{
			// It was; quit.
			extern void closeSystems();
			closeSystems();
			exit(message.wParam);
		}
		else
		{
			// Change ascii keys and the like to virtual keys.
			TranslateMessage(&message);
			// Send the message to the event processor.
			DispatchMessage(&message);
		}
	}
}

/*
 * Transform a char to an STRING, converting
 * common characters to string representations.
 */
STRING getName(const char chr, const bool bCapital)
{
	switch (chr)
	{
		case 13: return _T("ENTER");
		case 27: return _T("ESC");
		case 37: return _T("LEFT");
		case 39: return _T("RIGHT");
		case 38: return _T("UP");
		case 40: return _T("DOWN");
	}
	const TCHAR toRet[] = {bCapital ? toupper(TCHAR(chr)) : TCHAR(chr), _T('\0')};
	return toRet;
}

/*
 * Wait for a key.
 *
 * return (out) - the key pressed
 */
STRING waitForKey(const bool bCapital)
{
	g_keys.clear();
	while (g_keys.size() == 0)
	{
		processEvent();
	}
	const char chr = g_keys.front();
	g_keys.erase(g_keys.begin());
	return getName(chr, bCapital);
}

/*
 * Get last mouse click / wait for mouse.
 */
POINT getMouseClick(const bool bWait)
{
	if (bWait)
	{
		g_mouse.click.x = -1;
		while (g_mouse.click.x == -1)
		{
			processEvent();
		}
	}
	return g_mouse.click;
}

/*
 * Get last mouse move.
 */
POINT getMouseMove(void)
{
	const int x = g_mouse.move.x;
	while (g_mouse.move.x == x)
	{
		processEvent();
	}
	return g_mouse.move;
}

/*
 * Enumerate keyboards.
 */
BOOL CALLBACK diEnumKeyboardProc(LPCDIDEVICEINSTANCE lpddi, LPVOID pvRef)
{
	*(LPGUID)pvRef = lpddi->guidProduct;
	if (GET_DIDEVICE_SUBTYPE(lpddi->dwDevType) == DI8DEVTYPEKEYBOARD_PCENH)
	{
		return DIENUM_STOP;
	}
	return DIENUM_CONTINUE;
}

/*
 * Initialize input.
 */
void initInput()
{
	if (g_lpdi) return;
	extern HINSTANCE g_hInstance;
	extern HWND g_hHostWnd;
	DirectInput8Create(g_hInstance, DIRECTINPUT_VERSION, IID_IDirectInput8A, (void **)&g_lpdi, NULL);
	
	GUID kbGuid = GUID_SysKeyboard;
	g_lpdi->EnumDevices(DI8DEVTYPE_KEYBOARD, diEnumKeyboardProc, &kbGuid, DIEDFL_ATTACHEDONLY);
	g_lpdi->CreateDevice(kbGuid, &g_lpdiKeyboard, NULL);
	g_lpdiKeyboard->SetCooperativeLevel(g_hHostWnd, DISCL_NONEXCLUSIVE | DISCL_FOREGROUND);
	g_lpdiKeyboard->SetDataFormat(&c_dfDIKeyboard);
	g_lpdiKeyboard->Acquire();

	GUID msGuid = GUID_SysMouse;
	// No need to enumerate the mouse.
	g_lpdi->CreateDevice(msGuid, &g_lpdiMouse, NULL);
	g_lpdiMouse->SetCooperativeLevel(g_hHostWnd, DISCL_NONEXCLUSIVE | DISCL_FOREGROUND);
	g_lpdiMouse->SetDataFormat(&c_dfDIMouse);
	g_lpdiMouse->Acquire();
}

/*
 * Close input.
 */
void freeInput()
{
	if (!g_lpdi) return;
	g_lpdiKeyboard->Unacquire();
	g_lpdiKeyboard->Release();
	g_lpdiKeyboard = NULL;

	g_lpdiMouse->Unacquire();
	g_lpdiMouse->Release();
	g_lpdiMouse = NULL;

	g_lpdi->Release();
	g_lpdi = NULL;
}

/*
 * Scan for keys.
 */
void scanKeys()
{
	extern GAME_STATE g_gameState;
	extern CPlayer *g_pSelectedPlayer;
	extern MAIN_FILE g_mainFile;
	extern STRING g_projectPath;

	BYTE keys[256];
	if (FAILED(g_lpdiKeyboard->GetDeviceState(256, keys))) return;
	#define SCAN_KEY_DOWN(x) (keys[x] & 0x80)

	MV_ENUM queue = MV_IDLE;

	// General activation key.
	if (SCAN_KEY_DOWN(g_mainFile.key))
	{
		if (g_pSelectedPlayer->programTest()) return;
	}

	// Menu key.
	if (SCAN_KEY_DOWN(g_mainFile.menuKey))
	{
		extern IPlugin *g_pMenuPlugin;
		if (g_pMenuPlugin) g_pMenuPlugin->menu(MNU_MAIN);
		renderNow(NULL, true);

		// Delay to prevent the menu from immediately reopening.
		Sleep(75);
		return;
	}

	// Runtime keys.
	std::vector<short>::const_iterator i = g_mainFile.runTimeKeys.begin();
	for (; i != g_mainFile.runTimeKeys.end(); ++i)
	{
		if (SCAN_KEY_DOWN(*i))
		{
			STRING prg = g_mainFile.runTimePrg[i - g_mainFile.runTimeKeys.begin()];
			prg = g_projectPath + PRG_PATH + prg;
			CProgram(prg).run();
		}
	}

	if (SCAN_KEY_DOWN(DIK_RIGHT) && SCAN_KEY_DOWN(DIK_UP))
	{
		queue = MV_NE;			// Northeast.
	}
	else if (SCAN_KEY_DOWN(DIK_LEFT) && SCAN_KEY_DOWN(DIK_UP))
	{
		queue = MV_NW;			// Northwest.
	}
	else if (SCAN_KEY_DOWN(DIK_RIGHT) && SCAN_KEY_DOWN(DIK_DOWN))
	{
		queue = MV_SE;			// Southeast.
	}
	else if (SCAN_KEY_DOWN(DIK_LEFT) && SCAN_KEY_DOWN(DIK_DOWN))
	{
		queue = MV_SW;			// Southwest.
	}
	else if (SCAN_KEY_DOWN(DIK_UP))
	{
		queue = MV_N;			// North.
	}
	else if (SCAN_KEY_DOWN(DIK_DOWN))
	{
		queue = MV_S;			// South.
	}
	else if (SCAN_KEY_DOWN(DIK_RIGHT))
	{
		queue = MV_E;			// East.
	}
	else if (SCAN_KEY_DOWN(DIK_LEFT))
	{
		queue = MV_W;			// West.
	}

	if (queue != MV_IDLE)
	{
		// Queue up the movement, and clear any currently queued movements.
		g_pSelectedPlayer->setQueuedMovement(queue, true);
		g_gameState = GS_MOVEMENT;
		return;
	}

	// Process mouse-driven movement.
	// Use DI to get the status of the mousebuttons at this point.
	extern RECT g_screen;
	extern HWND g_hHostWnd;

	DIMOUSESTATE dims;
	memset(&dims, 0, sizeof(dims));
	if (FAILED(g_lpdiMouse->GetDeviceState(sizeof(dims), &dims))) return;

	if (dims.rgbButtons[0] & 0x80)
	{
		// Left button.
		// Use the API to get the location to avoid having to deal with
		// DI's relative co-ordinates.
		POINT p = {0, 0};
		if (GetCursorPos(&p))
		{
			ScreenToClient(g_hHostWnd, &p);
			PF_PATH pf = g_pSelectedPlayer->pathFind(p.x + g_screen.left, p.y + g_screen.top, PF_VECTOR);
			if (pf.size())
			{
				g_pSelectedPlayer->setQueuedPath(pf, true);
			}
		}
	}
}

/*
 * Host window event processor.
 *
 * hwnd (in) - handle of window
 * msg (in) - message being sent
 * wParam + lParam (in) - parameters of the message
 */
LRESULT CALLBACK eventProcessor(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam)
{
	extern CPlayer *g_pSelectedPlayer;
	extern RECT g_screen;

	// Switch on the message we're to process.
	switch (msg)
	{

		// Window needs painting.
		case WM_PAINT:
		{

			// Begin painting the window
			PAINTSTRUCT ps;
			BeginPaint(hwnd, &ps);

			// Force a render of the screen
			extern CDirectDraw *g_pDirectDraw;
			g_pDirectDraw->Refresh();

			// End of painting of the window
			EndPaint(hwnd, &ps);

		} break;

		//Window was closed.
		case WM_DESTROY:
		{
			PostQuitMessage(EXIT_SUCCESS);
		} break;

		// Key down.
		case WM_CHAR:
		{
			// Queue the key.
			const char key = char(wParam);
			g_keys.push_back(key);

			const STRING strKey = getName(key, true);
			informPluginEvent(key, -1, -1, -1, /*shift*/0, strKey, INPUT_KB);
		} break;

		// Mouse moved.
		case WM_MOUSEMOVE:
		{
			// Handle the mouse move event.
			g_mouse.move.x = LOWORD(lParam);
			g_mouse.move.y = HIWORD(lParam);

		} break;

		// Left mouse button clicked.
		case WM_LBUTTONDOWN:
		{
			g_mouse.click.x = LOWORD(lParam);
			g_mouse.click.y = HIWORD(lParam);

			informPluginEvent(-1, g_mouse.click.x, g_mouse.click.y, 1, /*shift*/0, _T(""), INPUT_MOUSEDOWN);
		} break;

		// Right mouse button clicked.
		case WM_RBUTTONDOWN:
		{
			const int x = LOWORD(lParam), y = HIWORD(lParam);
			informPluginEvent(-1, x, y, 2, /*shift*/0, _T(""), INPUT_MOUSEDOWN);
		} break;

		// Window activated/deactivated.
		case WM_ACTIVATE:
		{
			extern GAME_STATE g_gameState;
			if (wParam != WA_INACTIVE)
			{
				// Window is being activated,
				if (g_lpdiKeyboard) g_lpdiKeyboard->Acquire();
				if (g_lpdiMouse) g_lpdiMouse->Acquire();
				g_gameState = GS_IDLE;
			}
			else
			{
				// Window is being deactivated.
				g_gameState = GS_PAUSE;
			}
		} break;

		default:
		{
			return DefWindowProc(hwnd, msg, wParam, lParam);
		} break;

	}

	return 0;
}

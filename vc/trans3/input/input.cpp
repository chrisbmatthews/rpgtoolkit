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
#include "../common/board.h"
#include "../plugins/plugins.h"
#include "../plugins/constants.h"
#include "../movement/CSprite/CSprite.h"

/*
 * Globals.
 */
std::vector<char> g_keys;
IDirectInput8A *g_lpdi = NULL;
IDirectInputDevice8A *g_lpdiKeyboard = NULL;

/*
 * Process an event from the message queue.
 */
void processEvent(void)
{
	MSG message;
	if (PeekMessage(&message, NULL, 0, 0, PM_REMOVE))
	{
		// There was a message. Check if it's eventProcessor() asking to leave this loop.
		if (message.message == WM_QUIT)
		{
			// It was; quit.
			extern void closeSystems(void);
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
 * Transform a char to an std::string, converting
 * common characters to string representations.
 */
std::string getName(char chr)
{
	switch (chr)
	{
		case 13: return "ENTER";
		case 27: return "ESC";
		case 37: return "LEFT";
		case 39: return "RIGHT";
		case 38: return "UP";
		case 40: return "DOWN";
	}
	const char toRet[] = {chr, '\0'};
	return toRet;
}

/*
 * Wait for a key.
 *
 * return (out) - the key pressed
 */
std::string waitForKey()
{
	g_keys.clear();
	while (g_keys.size() == 0)
	{
		processEvent();
	}
	const char chr = g_keys.front();
	g_keys.erase(g_keys.begin());
	return getName(chr);
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
	DirectInput8Create(g_hInstance, DIRECTINPUT_VERSION, IID_IDirectInput8A, (void **)&g_lpdi, NULL);
	GUID kbGuid = GUID_SysKeyboard;
	g_lpdi->EnumDevices(DI8DEVTYPE_KEYBOARD, diEnumKeyboardProc, &kbGuid, DIEDFL_ATTACHEDONLY);
	g_lpdi->CreateDevice(kbGuid, &g_lpdiKeyboard, NULL);
	extern HWND g_hHostWnd;
	g_lpdiKeyboard->SetCooperativeLevel(g_hHostWnd, DISCL_NONEXCLUSIVE | DISCL_FOREGROUND);
	g_lpdiKeyboard->SetDataFormat(&c_dfDIKeyboard);
	g_lpdiKeyboard->Acquire();
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
	g_lpdi->Release();
	g_lpdi = NULL;
}

/*
 * Scan for keys.
 */
void scanKeys()
{
	extern GAME_STATE g_gameState;
	extern CSprite *g_pSelectedPlayer;

	BYTE keys[256];
	if (FAILED(g_lpdiKeyboard->GetDeviceState(256, keys))) return;
	#define SCAN_KEY_DOWN(x) (keys[DIK_##x] & 0x80)

	MV_ENUM queue = MV_IDLE;

	// Temporary - KeyDownEvent?
	if (SCAN_KEY_DOWN(SPACE))
	{
		g_pSelectedPlayer->programTest();
		return;
	}

	if (SCAN_KEY_DOWN(RETURN))
	{
		extern IPlugin *g_pMenuPlugin;
		g_pMenuPlugin->menu(MNU_MAIN);
		renderNow(NULL, true);
		return;
	}

	if (SCAN_KEY_DOWN(RIGHT) && SCAN_KEY_DOWN(UP))
	{
		queue = MV_NE;			// Northeast.
	}
	else if (SCAN_KEY_DOWN(LEFT) && SCAN_KEY_DOWN(UP))
	{
		queue = MV_NW;			// Northwest.
	}
	else if (SCAN_KEY_DOWN(RIGHT) && SCAN_KEY_DOWN(DOWN))
	{
		queue = MV_SE;			// Southeast.
	}
	else if (SCAN_KEY_DOWN(LEFT) && SCAN_KEY_DOWN(DOWN))
	{
		queue = MV_SW;			// Southwest.
	}
	else if (SCAN_KEY_DOWN(UP))
	{
		queue = MV_N;			// North.
	}
	else if (SCAN_KEY_DOWN(DOWN))
	{
		queue = MV_S;			// South.
	}
	else if (SCAN_KEY_DOWN(RIGHT))
	{
		queue = MV_E;			// East.
	}
	else if (SCAN_KEY_DOWN(LEFT))
	{
		queue = MV_W;			// West.
	}

	if (queue != MV_IDLE)
	{
		// Queue up the movement, and clear any currently queued movements.
		g_pSelectedPlayer->setQueuedMovement(queue, true);
		g_gameState = GS_MOVEMENT;
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
	extern CSprite *g_pSelectedPlayer;
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
		case WM_KEYDOWN:
		{
			// Queue the key.
			const char key = char(wParam);
			g_keys.push_back(key);

			const std::string strKey = getName(key);
			informPluginEvent(key, -1, -1, -1, /*shift*/0, strKey, INPUT_KB);
		} break;

		// Mouse moved.
		case WM_MOUSEMOVE:
		{
			// Handle the mouse move event.
			
		} break;

		// Left mouse button clicked.
		case WM_LBUTTONDOWN:
		{
			const int x = LOWORD(lParam), y = HIWORD(lParam);
			g_pSelectedPlayer->clearQueue();
			PF_PATH p = g_pSelectedPlayer->pathFind(x + g_screen.left, y + g_screen.top, PF_VECTOR);
			g_pSelectedPlayer->setQueuedPath(p);

			informPluginEvent(-1, x, y, 1, /*shift*/0, "", INPUT_MOUSEDOWN);
		} break;

		// Right mouse button clicked.
		case WM_RBUTTONDOWN:
		{
			const int x = LOWORD(lParam), y = HIWORD(lParam);
			informPluginEvent(-1, x, y, 2, /*shift*/0, "", INPUT_MOUSEDOWN);
		} break;

		// Window activated/deactivated.
		case WM_ACTIVATE:
		{
			if (wParam != WA_INACTIVE)
			{
				// Window is being activated,
				if (g_lpdiKeyboard) g_lpdiKeyboard->Acquire();
			}
			else
			{
				// Window is being deactivated.
			}
		} break;

		default:
		{
			return DefWindowProc(hwnd, msg, wParam, lParam);
		} break;

	}

	return TRUE;

}

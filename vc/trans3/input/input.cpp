/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

/*
 * Inclusions.
 */
#include <vector>
#define DIRECTINPUT_VERSION DIRECTINPUT_HEADER_VERSION
#include <dinput.h>
#include "input.h"
#include "../movement/movement.h"
#include "../movement/CPlayer/CPlayer.h"

/*
 * Globals.
 */
std::vector<char> g_keys;
static IDirectInput8A *g_lpdi = NULL;
static IDirectInputDevice8A *g_lpdiKeyboard = NULL;

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
 * Wait for a key.
 *
 * return (out) - the key pressed
 */
std::string waitForKey(void)
{
	g_keys.clear();
	while (g_keys.size() == 0)
	{
		processEvent();
	}
	const char chr = g_keys.front();
	g_keys.erase(g_keys.begin());
	switch (chr)
	{
		case 13: return "ENTER";
		case 38: return "UP";
		case 40: return "DOWN";
		case 37: return "RIGHT";
		case 39: return "LEFT";
	}
	const char toRet[] = {chr, '\0'};
	return toRet;
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
void initInput(void)
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
void freeInput(void)
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
void scanKeys(void)
{
	BYTE keys[256];
	if (FAILED(g_lpdiKeyboard->GetDeviceState(256, keys))) return;
	#define SCAN_KEY_DOWN(x) (keys[DIK_##x] & 0x80)

	int queue = MV_IDLE;
	extern std::vector<CPlayer *> g_players;
	extern int g_gameState, g_selectedPlayer;

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
		queue = MV_NORTH;		// North.
	}
	else if (SCAN_KEY_DOWN(DOWN))
	{
		queue = MV_SOUTH;		// South.
	}
	else if (SCAN_KEY_DOWN(RIGHT))
	{
		queue = MV_EAST;		// East.
	}
	else if (SCAN_KEY_DOWN(LEFT))
	{
		queue = MV_WEST;		// West.
	}

	if (queue)
	{
		// Queue up the movement, and clear any currently queued movements.
		g_players[g_selectedPlayer]->setQueuedMovements(queue, true);
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

	// Switch on the message we're to process
	switch (msg)
	{

		// Window needs painting
		case WM_PAINT:
		{

			// Begin painting the window
			PAINTSTRUCT ps;
			BeginPaint(hwnd, &ps);

			// Force a render of the screen
			/* ... */

			// End of painting of the window
			EndPaint(hwnd, &ps);

		} break;

		//Window was closed
		case WM_DESTROY:
		{
			PostQuitMessage(EXIT_SUCCESS);
		} break;

		// Key down
		case WM_KEYDOWN:
		{
			// Queue the key.
			g_keys.push_back(char(wParam));
		} break;

		// Mouse moved
		case WM_MOUSEMOVE:
		{
			// Handle the mouse move event
			
		} break;

		// Left mouse button clicked
		case WM_LBUTTONDOWN:
		{
			// Handle the event
			
		} break;

		// Window activated/deactivated
		case WM_ACTIVATE:
		{
			if (wParam != WA_INACTIVE)
			{
				// Window is being *activated*
				if (g_lpdiKeyboard) g_lpdiKeyboard->Acquire();
			}
			else
			{
				// Window is being *deactivated*
			}
		} break;

	}

	// Return success
	return DefWindowProc(hwnd, msg, wParam, lParam);

}

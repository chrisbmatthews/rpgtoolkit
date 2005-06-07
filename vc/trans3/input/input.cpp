/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

/*
 * Inclusions.
 */
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <vector>
#include <string>
#include "input.h"

/*
 * Globals.
 */
static std::vector<char> g_keys;

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

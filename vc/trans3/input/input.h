/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

#ifndef _INPUT_H_
#define _INPUT_H_

/*
 * Inclusions.
 */
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#define DIRECTINPUT_VERSION DIRECTINPUT_HEADER_VERSION
#include <dinput.h>
#include "../../tkCommon/strings.h"

/*
 * Transform a char to an STRING, converting
 * common characters to string representations.
 */
STRING getName(const char chr, const bool bCapital);

/*
 * Wait for a key.
 *
 * return (out) - the key pressed
 */
STRING waitForKey(const bool bCapital);

/*
 * Get last mouse click / wait for mouse.
 */
POINT getMouseClick(const bool bWait);

/*
 * Get last mouse move.
 */
POINT getMouseMove(void);

/*
 * Host window event processor.
 *
 * hwnd (in) - handle of window
 * msg (in) - message being sent
 * wParam + lParam (in) - parameters of the message
 */
LRESULT CALLBACK eventProcessor(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam);

/*
 * Scan for keys.
 */
void scanKeys();

/*
 * Process an event from the message queue.
 */
void processEvent();

#endif

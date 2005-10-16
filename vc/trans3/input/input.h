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
#include <string>

/*
 * Transform a char to an std::string, converting
 * common characters to string representations.
 */
std::string getName(char chr);

/*
 * Wait for a key.
 *
 * return (out) - the key pressed
 */
std::string waitForKey();

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

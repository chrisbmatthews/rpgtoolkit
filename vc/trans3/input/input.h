/*
 ********************************************************************
 * The RPG Toolkit, Version 3
 * This file copyright (C) 2007 Colin James Fitzpatrick & Jonathan D. Hughes
 ********************************************************************
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
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

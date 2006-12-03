/*
 ********************************************************************
 * The RPG Toolkit, Version 3
 * This file copyright (C) 2006  Christopher Matthews & contributors
 *
 * Contributors:
 *    - Colin James Fitzpatrick
 *    - Jonathan D. Hughes
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

#ifndef _MISC_H_
#define _MISC_H_

/*
 * Inclusions.
 */
#include "../../tkCommon/strings.h"
#include "../movement/movement.h"
#include <vector>

/*
 * Defines
 */

/*
 * Record of current session and total game runtime (reset on state load).
 * Storing as seconds rather than milliseconds for ease of interface.
 */
typedef struct tagGameTime
{
	void reset(const int gameTime) { startTime = (GetTickCount() / MILLISECONDS); runTime = gameTime; }
	int gameTime(void) const { return (runTime + (GetTickCount() / MILLISECONDS) - startTime); }

	int startTime;			// Seconds at start of session.
	int runTime;				// Total seconds of this game or save file prior to this session.

} GAME_TIME;

/*
 * Split a string.
 */
void split(const STRING str, const STRING delim, std::vector<STRING> &parts);

/*
 * Replace text in a string.
 */
STRING &replace(STRING &str, const STRING find, const STRING replace);

/*
 * Replace within a string.
 *
 * str (in) - string in question
 * find (in) - find this
 * replace (in) - replace with this
 * return (out) - result
 */
STRING replace(const STRING str, const char find, const char replace);

/*
 * Save a setting.
 *
 * strKey (in) - name of key to save to
 * dblValue (in) - value to save
 */
void saveSetting(const STRING strKey, const double dblValue);

/*
 * Get a setting.
 *
 * strKey (in) - name of key to get
 * dblValue (out) - result
 */
void getSetting(const STRING strKey, double &dblValue);

#endif

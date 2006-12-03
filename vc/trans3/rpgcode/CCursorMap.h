/*
 ********************************************************************
 * The RPG Toolkit, Version 3
 * This file copyright (C) 2006  Colin James Fitzpatrick
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

#ifndef _CCURSOR_MAP_H_
#define _CCURSOR_MAP_H_

#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <vector>

// A cursor map.
//////////////////////////////////////////////
class CCursorMap
{
public:
	void add(const int x, const int y);
	int run();
private:
	std::vector<POINT> m_points;
};

#endif

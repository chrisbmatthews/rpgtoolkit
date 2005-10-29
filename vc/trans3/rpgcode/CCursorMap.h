/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
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

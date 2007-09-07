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
 *
 * Creating a game EXE using the Make EXE feature creates a 
 * derivative version of trans3 that includes the game's files. 
 * Therefore the EXE must be licensed under the GPL. However, as a 
 * special exception, you are permitted to license EXEs made with 
 * this feature under whatever terms you like, so long as 
 * Corresponding Source, as defined in the GPL, of the version 
 * of trans3 used to make the EXE is available separately under 
 * terms compatible with the Licence of this software and that you 
 * do not charge, aside from any price of the game EXE, to obtain 
 * these components.
 * 
 * If you publish a modified version of this Program, you may delete
 * these exceptions from its distribution terms, or you may choose
 * to propagate them.
 */

#include "CCursorMap.h"
#include "../../tkCommon/tkDirectX/platform.h"
#include "../input/input.h"

/*
 * Add a point to the cursor map.
 */
void CCursorMap::add(const int x, const int y)
{
	POINT pt = {x, y};
	m_points.push_back(pt);
}

/*
 * Run the cursor map and return the chose option,
 * with zero as the first index.
 */
int CCursorMap::run()
{
	extern int g_resX, g_resY;
	extern CDirectDraw *g_pDirectDraw;
	extern CCanvas *g_cnvCursor;
	extern void closeSystems();

	CCanvas cnv;
	cnv.CreateBlank(NULL, g_resX, g_resY, TRUE);
	g_pDirectDraw->CopyScreenToCanvas(&cnv);
	int toRet = 0, pos = -1;
	MSG message;

	while (true)
	{
		const DWORD time = GetTickCount();
		while ((GetTickCount() - time) < 100)
		{
			if (PeekMessage(&message, NULL, 0, 0, PM_REMOVE))
			{
				if (message.message == WM_QUIT)
				{
					closeSystems();
					exit(message.wParam);
				}
				else
				{
					TranslateMessage(&message);
					DispatchMessage(&message);
				}
			}
		}
		BYTE keys[256];
		extern IDirectInputDevice8A *g_lpdiKeyboard;
		if (FAILED(g_lpdiKeyboard->GetDeviceState(256, keys)))
		{
			continue;
		}
		if ((keys[DIK_UP] & 0x80) || (keys[DIK_LEFT] & 0x80))
		{
			if (toRet) --toRet;
			else toRet = m_points.size() - 1;
		}
		else if ((keys[DIK_DOWN] & 0x80) || (keys[DIK_RIGHT] & 0x80))
		{
			if (toRet != (m_points.size() - 1)) ++toRet;
			else toRet = 0;
		}
		else if ((keys[DIK_RETURN] & 0x80) || (keys[DIK_SPACE] & 0x80))
		{
			break;
		}
		if (toRet != pos)
		{
			g_pDirectDraw->DrawCanvas(&cnv, 0, 0);
			g_pDirectDraw->DrawCanvasTransparent(g_cnvCursor, m_points[toRet].x - 40, m_points[toRet].y - 10, RGB(255, 0, 0));
			g_pDirectDraw->Refresh();
		}
		pos = toRet;
	}
	g_pDirectDraw->DrawCanvas(&cnv, 0, 0);
	g_pDirectDraw->Refresh();
	return toRet;
}

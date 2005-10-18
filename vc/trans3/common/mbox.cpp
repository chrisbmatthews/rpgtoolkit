/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

#include "mbox.h"
#include "../input/input.h"
#include "../../tkCommon/tkDirectX/platform.h"

/*
 * Show a message box.
 */
void messageBox(const STRING str)
{
	extern int g_resX, g_resY;
	extern CDirectDraw *g_pDirectDraw;

	if (!g_pDirectDraw)
	{
		MessageBox(NULL, str.c_str(), _T("RPGToolkit 3 Translator"), 0);
		return;
	}

	CCanvas backup;
	backup.CreateBlank(NULL, g_resX, g_resY, TRUE);
	g_pDirectDraw->CopyScreenToCanvas(&backup);

	HDC hdc = backup.OpenDC();

	RECT r;
	r.left = 0;
	r.top = 0;
	r.right = g_resX * 0.7;
	r.bottom = g_resY / 2;
	DrawText(hdc, str.c_str(), str.length(), &r, DT_CALCRECT | DT_WORDBREAK);

	backup.CloseDC(hdc);

	CCanvas box;
	box.CreateBlank(NULL, r.right + 20, r.bottom + 20, TRUE);
	box.ClearScreen(0);
	box.DrawRect(0, 0, box.GetWidth() - 1, box.GetHeight() - 1, RGB(255, 255, 255));

	r.left = 10;
	r.right += 10;
	r.top = 10;
	r.bottom += 10;

	hdc = box.OpenDC();
	SetBkMode(hdc, TRANSPARENT);
	SetTextColor(hdc, RGB(255, 255, 255));
	DrawText(hdc, str.c_str(), str.length(), &r, DT_WORDBREAK);
	box.CloseDC(hdc);

	g_pDirectDraw->DrawCanvasTranslucent(&box, (g_resX - r.right) / 2, (g_resY - r.bottom) / 2 - 10, 0.45, RGB(255, 255, 255), -1);
	g_pDirectDraw->Refresh();

	while (true)
	{
		const STRING key = waitForKey();
		if ((key != _T("LEFT")) && (key != _T("RIGHT")) && (key != _T("UP")) && (key != _T("DOWN"))) break;
	}
	g_pDirectDraw->DrawCanvas(&backup, 0, 0);
	g_pDirectDraw->Refresh();
}

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
		const STRING key = waitForKey(true);
		if ((key != _T("LEFT")) && (key != _T("RIGHT")) && (key != _T("UP")) && (key != _T("DOWN"))) break;
	}
	g_pDirectDraw->DrawCanvas(&backup, 0, 0);
	g_pDirectDraw->Refresh();
}

/*
 * Prompt for a response.
 */
STRING prompt(const STRING str)
{
	extern int g_resX, g_resY;
	extern CDirectDraw *g_pDirectDraw;

	CCanvas backup;
	backup.CreateBlank(NULL, g_resX, g_resY, TRUE);
	g_pDirectDraw->CopyScreenToCanvas(&backup);

	HDC hdc = backup.OpenDC();

	RECT r;
	r.left = 0;
	r.top = 0;
	r.right = g_resX * 0.8;
	r.bottom = g_resY / 2;
	DrawText(hdc, str.c_str(), str.length(), &r, DT_CALCRECT | DT_WORDBREAK);

	backup.CloseDC(hdc);

	const int minRight = g_resX * 0.6;
	if (r.right < minRight) r.right = minRight;

	CCanvas box;
	box.CreateBlank(NULL, r.right + 20, r.bottom + 60, TRUE);
	box.ClearScreen(0);
	box.DrawRect(0, 0, box.GetWidth() - 1, box.GetHeight() - 1, RGB(255, 255, 255));

	r.left = 10;
	r.right += 10;
	r.top = 10;
	r.bottom += 10;

	box.DrawRect(r.left, r.bottom + 12, r.right, box.GetHeight() - r.top - 5, RGB(255, 255, 255));

	hdc = box.OpenDC();
	SetBkMode(hdc, TRANSPARENT);
	SetTextColor(hdc, RGB(255, 255, 255));
	DrawText(hdc, str.c_str(), str.length(), &r, DT_WORDBREAK);
	box.CloseDC(hdc);

	const int x = (g_resX - r.right) / 2,
			  y = (g_resY - r.bottom) / 2 - 10;

	// Destination on screen.
	const int dx = x + r.left, dy = y + r.bottom + 12;

	RECT r2;
	r2.left = x + 14;
	r2.top = y + r.bottom + 16;

	g_pDirectDraw->DrawCanvasTranslucent(&box, x, y, 0.45, RGB(255, 255, 255), -1);

	CCanvas *pBuffer = g_pDirectDraw->getBackBuffer();

	CCanvas text;
	text.CreateBlank(NULL, r.right - r.left + 1, box.GetHeight() - r.top - r.bottom - 16, TRUE);
	pBuffer->BltPart(&text, 0, 0, dx, dy, text.GetWidth(), text.GetHeight());

	g_pDirectDraw->Refresh();

	STRING response;

	while (true)
	{
		const STRING key = waitForKey(false);
		if ((key == _T("LEFT")) || (key == _T("RIGHT")) || (key == _T("UP")) || (key == _T("DOWN"))) continue;
		if (key == _T("ENTER")) break;

		if (key[0] == 8)
		{
			response = response.substr(0, response.length() - 1);
		}
		else
		{
			response += key;
		}

		// Write the text.
		text.Blt(pBuffer, dx, dy);
		hdc = pBuffer->OpenDC();
		SetBkMode(hdc, TRANSPARENT);
		SetTextColor(hdc, RGB(255, 255, 255));

		SIZE sz;
		GetTextExtentPoint32(hdc, response.c_str(), response.length(), &sz);
		if (sz.cx >= (text.GetWidth() - 2))
		{
			response = response.substr(0, response.length() - 1);
		}

		DrawText(hdc, response.c_str(), response.length(), &r2, 0);
		pBuffer->CloseDC(hdc);
		g_pDirectDraw->Refresh();
	}

	g_pDirectDraw->DrawCanvas(&backup, 0, 0);
	g_pDirectDraw->Refresh();

	return response;
}

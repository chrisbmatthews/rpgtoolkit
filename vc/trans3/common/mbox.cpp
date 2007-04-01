/*
 ********************************************************************
 * The RPG Toolkit, Version 3
 * This file copyright (C) 2006  Colin Fitzpatrick & Jonathan Hughes
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

#include "mbox.h"
#include "paths.h"
#include "animation.h"
#include "../input/input.h"
#include "../rpgcode/CCursorMap.h"
#include "../../tkCommon/tkDirectX/platform.h"
#include <set>

const double mboxTranslucency = 0.5;

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

	g_pDirectDraw->DrawCanvasTranslucent(&box, (g_resX - r.right) / 2, (g_resY - r.bottom) / 2 - 10, mboxTranslucency, RGB(255, 255, 255), -1);
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

	g_pDirectDraw->DrawCanvasTranslucent(&box, x, y, mboxTranslucency, RGB(255, 255, 255), -1);

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

/*
 * Rpgcode message box (MsgBox()).
 */
int rpgcodeMsgBox(STRING text, int buttons, const long textColor, const long backColor, const STRING image)
{
	extern int g_resX, g_resY;
	extern CDirectDraw *g_pDirectDraw;
	extern STRING g_projectPath;

	if (!g_pDirectDraw)
	{
		MessageBox(NULL, text.c_str(), _T("RPGToolkit 3 Translator"), 0);
		return 1;
	}

	buttons = buttons < 1 ? 1 : (buttons > 2 ? 2 : buttons);

	CCursorMap map;

	// Copy the screen to revert to on finishing.
	CCanvas backup;
	backup.CreateBlank(NULL, g_resX, g_resY, TRUE);
	g_pDirectDraw->CopyScreenToCanvas(&backup);

	// Determine the size of the rect required to hold the text
	// by setting the DT_CALCRECT flag. r.bottom is extended to
	// hold the text in the given width. Text is not drawn when
	// this flag is set.

	HDC hdc = backup.OpenDC();
	RECT r = {0, 0, g_resX * 0.5, g_resY * 0.5};
	DrawText(hdc, text.c_str(), text.length(), &r, DT_CALCRECT | DT_WORDBREAK);
	backup.CloseDC(hdc);

	// Button dimensions, padding.
	const int buWidth = 80, buHeight = 28, pad = 12;

	// Ensure the box is big enough for the buttons.
	int minimumWidth = buttons * (buWidth + pad) + pad, width = r.right + 2 * pad;
	if (width < minimumWidth) width = minimumWidth;

	// Draw a bounding box on a new canvas, with space for buttons.
	CCanvas box;
	box.CreateBlank(NULL, width, r.bottom + buHeight + 2 * pad, TRUE);
	box.ClearScreen(backColor);

	if (image.empty())
	{
		box.DrawRect(0, 0, box.GetWidth() - 1, box.GetHeight() - 1, textColor);
	}
	else
	{
		// Stretch the image to fit.
		drawImage(g_projectPath + BMP_PATH + image, &box, 0, 0, box.GetWidth(), box.GetHeight());
	}

	// Offset the rect to the drawing position.
	OffsetRect(&r, pad, pad / 2);

	// Draw bounding boxes for the buttons.
	RECT rbu = { 0, box.GetHeight() - buHeight - pad / 2, 0, box.GetHeight() - pad / 2 };
	
	if (buttons == 1)
	{
		// Single button.
		rbu.left = (box.GetWidth() - buWidth) / 2;
		rbu.right = rbu.left + buWidth;
		box.DrawRect(rbu.left, rbu.top, rbu.right, rbu.bottom, textColor);
	}
	else
	{
		rbu.left = (box.GetWidth() - 2 * buWidth) / 3;
		rbu.right = rbu.left + buWidth;
		box.DrawRect(rbu.left, rbu.top, rbu.right, rbu.bottom, textColor);
		box.DrawRect(2 * rbu.left + buWidth, rbu.top, 2 * rbu.right, rbu.bottom, textColor);
	}

	// Draw the text, bounding it inside the rect.
	hdc = box.OpenDC();
	SetBkMode(hdc, TRANSPARENT);
	SetTextColor(hdc, textColor);
	DrawText(hdc, text.c_str(), text.length(), &r, DT_WORDBREAK);

	// Screen destination.
	const int x = (g_resX - box.GetWidth()) / 2, y = (g_resY - box.GetHeight()) / 2;

	// Centre in the rect previously used to draw the buttons.
	// Set the points of the cursor map to handle input.
	if (buttons == 1)
	{
		text = _T("OK");
		DrawText(hdc, text.c_str(), text.length(), &rbu, DT_CENTER | DT_SINGLELINE | DT_VCENTER);
		map.add(x + rbu.left, y + (rbu.top + rbu.bottom) / 2);
	}
	else
	{
		text = _T("Yes");
		DrawText(hdc, text.c_str(), text.length(), &rbu, DT_CENTER | DT_SINGLELINE | DT_VCENTER);
		map.add(x + rbu.left, y + (rbu.top + rbu.bottom) / 2);

		text = _T("No");
		rbu.left = 2 * rbu.left + buWidth;
		rbu.right = rbu.left + buWidth;
		DrawText(hdc, text.c_str(), text.length(), &rbu, DT_CENTER | DT_SINGLELINE | DT_VCENTER);
		map.add(x + rbu.left, y + (rbu.top + rbu.bottom) / 2);
	}

	box.CloseDC(hdc);

	// Draw translucently with the text drawn solidly.
	g_pDirectDraw->DrawCanvasTranslucent(&box, x, y, mboxTranslucency, textColor, TRANSP_COLOR);
	g_pDirectDraw->Refresh();

	// Return 1 for OK, 6 for Yes, 7 for No (vbMsgBoxResult constants).
	const int result = map.run() + (buttons == 2 ? 6 : 1);

	g_pDirectDraw->DrawCanvas(&backup, 0, 0);
	g_pDirectDraw->Refresh();

	return result;
}

STRING fileDialog(
	const STRING path,
	const STRING filter,		// e.g. "*.sav", or empty.
	const STRING title,
	const bool allowNewFile,
	const long textColor,
	const long backColor,
	const STRING image)
{
	extern int g_resX, g_resY;
	extern STRING g_projectPath;
	extern CDirectDraw *g_pDirectDraw;

	// Get the save directory contents.
	WIN32_FIND_DATA wfd;
	HANDLE hFind = INVALID_HANDLE_VALUE;
	std::set<STRING> files;

	// Find the first file in the directory.
	hFind = FindFirstFile((path + filter).c_str(), &wfd);

	if (hFind != INVALID_HANDLE_VALUE) 
	{
		// List all the other files in the directory.
		do 
		{
			if (wfd.dwFileAttributes & ~FILE_ATTRIBUTE_DIRECTORY)
				files.insert(wfd.cFileName);
		}
		while (FindNextFile(hFind, &wfd) != 0);
		
		FindClose(hFind);
	}

	// Add the new file option.
	const STRING newFile = _T("<New File>");
	if (allowNewFile) files.insert(newFile);

	// List dimensions.
	int width = 320, height = 200, pad = 12;

	// Copy the screen to revert to on finishing.
	CCanvas backup;
	backup.CreateBlank(NULL, g_resX, g_resY, TRUE);
	g_pDirectDraw->CopyScreenToCanvas(&backup);

	// Get the line height.
	SIZE sz;
	HDC hdc = backup.OpenDC();
	GetTextExtentPoint32(hdc, newFile.c_str(), newFile.length(), &sz);
	backup.CloseDC(hdc);

	unsigned int firstLine = 0, selectedLine = 0;
	const int lineHeight = sz.cy, lines = height / lineHeight;
	const int titleHeight = lineHeight + pad;
	height = lineHeight * lines;
	STRING result;

	CCanvas box, bitmap;
	box.CreateBlank(NULL, width + pad, height + titleHeight + pad, TRUE);

	if (!image.empty())
	{
		bitmap.CreateBlank(NULL, box.GetWidth(), box.GetHeight(), TRUE);
		drawImage(g_projectPath + BMP_PATH + image, &bitmap, 0, 0, bitmap.GetWidth(), bitmap.GetHeight());
	}

	while (true)
	{
		box.ClearScreen(backColor);
		
		if (image.empty())
		{
			box.DrawRect(0, 0, box.GetWidth() - 1, box.GetHeight() - 1, textColor);
			box.DrawRect(0, 0, box.GetWidth() - 1, titleHeight - 1, textColor);
		}
		else
		{
			bitmap.Blt(&box, 0, 0, SRCCOPY);
		}

		hdc = box.OpenDC();
		SetBkMode(hdc, TRANSPARENT);
		SetTextColor(hdc, textColor);

		// Draw the title.
		RECT r = {0, 0, width, titleHeight};
		DrawText(hdc, title.c_str(), title.length(), &r, DT_CENTER | DT_END_ELLIPSIS | DT_SINGLELINE | DT_VCENTER);
	
		std::set<STRING>::const_iterator i = files.begin();
		if (!files.empty())
		{
			// Advance the iterator to the first visible entry.
			for (int j = 0; j < firstLine && i != files.end(); ++j) ++i;
			
			// Draw each visible entry.
			for (j = 0; j < lines && i != files.end(); ++i, ++j)
			{
				RECT r = {0, lineHeight * j, width, height};
				OffsetRect(&r, pad / 2, titleHeight + pad / 2);
				DrawText(hdc, i->c_str(), i->length(), &r, DT_END_ELLIPSIS | DT_SINGLELINE);
			}

			// Draw the selected item inverted.
			SetBkMode(hdc, OPAQUE);
			SetTextColor(hdc, backColor);
			SetBkColor(hdc, textColor);
			
			RECT rs = {0, lineHeight * (selectedLine - firstLine), width, height};
			OffsetRect(&rs, pad / 2, titleHeight + pad / 2);
			
			for (i = files.begin(), j = 0; j != selectedLine; ++j) ++i;
			DrawText(hdc, i->c_str(), i->length(), &rs, DT_END_ELLIPSIS | DT_SINGLELINE);
		}

		box.CloseDC(hdc);

		// Screen destination.
		const int x = (g_resX - box.GetWidth()) / 2, y = (g_resY - box.GetHeight()) / 2;

		// Draw translucently with the text drawn solidly.
		g_pDirectDraw->DrawCanvasPartial(&backup, x, y, x, y, box.GetWidth(), box.GetHeight(), SRCCOPY);
		g_pDirectDraw->DrawCanvasTranslucent(&box, x, y, mboxTranslucency, textColor, TRANSP_COLOR);
		g_pDirectDraw->Refresh();

		const STRING key = waitForKey(true);

		// Exit if no files to select.
		if (files.empty()) break;

		if (key == _T("DOWN") && selectedLine != files.size() - 1)
		{
			// Scroll down.
			if (++selectedLine >= lines + firstLine) ++firstLine;
		}
		else if (key == _T("UP") && selectedLine != 0)
		{
			// Scroll up.
			if (--selectedLine < firstLine) --firstLine;
		}
		else if (key == _T("ENTER") || key == _T(" "))
		{
			// Prompt for filename if new file selected.
			// i still points at the selected file.
			result = *i;
			if (*i == newFile)
			{
				result = removePath(prompt(_T("Enter a new filename")));
				if (!getExtension(filter).empty())
				{
					result = addExtension(result, getExtension(filter));
				}
				if (files.find(result) != files.end())
				{
					if (rpgcodeMsgBox(
						result + " already exists. Overwrite file?", 
						2, 
						textColor, 
						backColor,
						STRING()) == 7
					)
					{
						result.erase();
						// Continue so that the user can select another file.
						continue;
					}
				}
			}
			break;
		}
		else if (key == _T("ESC")) break;
	}
	return result;
}
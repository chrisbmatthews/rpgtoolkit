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

/*
 * Inclusions.
 */
#include "animation.h"
#include "paths.h"
#include "CFile.h"
#include "../rpgcode/parser/parser.h"
#include "../movement/movement.h"
#include "../../tkCommon/images/FreeImage.h"
#include "mbox.h"
#include <mmsystem.h>

/*
 * Open an animation.
 *
 * fileName (in) - file to open
 * bool (out) - open success
 */
bool tagAnimation::open(const STRING fileName)
{
	CFile file(fileName);
	if (!file.isOpen())
	{
		messageBox(_T("Animation file not found. ") + fileName);
		return false;
	}

	STRING fileHeader;
	file >> fileHeader;
	if (fileHeader == _T("RPGTLKIT ANIM"))
	{
		short majorVer, minorVer;
		file >> majorVer;
		file >> minorVer;
		if (minorVer == 3)
		{
			file >> pxWidth;
			file >> pxHeight;
			file >> frameCount;
			frameFiles.clear();
			transpColors.clear();
			sounds.clear();
			for (unsigned int i = 0; i <= frameCount; ++i)
			{
				STRING strA, strB;
				int num;
				file >> strA;
				file >> num;
				file >> strB;
				if (!strA.empty())
				{
					// Add frame if frame contains image.
					frameFiles.push_back(strA);
					transpColors.push_back(num);
					sounds.push_back(strB);
				}
			}
			file >> delay;
		}
		else
		{
			messageBox(_T("This is not a valid animaton file. ") + fileName);
			return false;
		}
 	}
	else
	{
		file.seek(0);
		if (_tcsicmp(file.line().c_str(), _T("RPGTLKIT ANIM")) != 0)
		{
			messageBox(_T("This is not a valid animaton file. ") + fileName);
			return false;
		}
		file.line();
		file.line();
		pxWidth = _ttoi(file.line().c_str());
		pxHeight = _ttoi(file.line().c_str());
		frameCount = _ttoi(file.line().c_str());
		frameFiles.clear();
		transpColors.clear();
		sounds.clear();
		for (unsigned int i = 0; i <= frameCount; ++i)
		{
			frameFiles.push_back(file.line());
			transpColors.push_back(_ttoi(file.line().c_str()));
			sounds.push_back(file.line());
		}
		delay = atof(getAsciiString(file.line()).c_str());
	}

	frameCount = frameFiles.size();
	filename = removePath(fileName, MISC_PATH);
	return true;
}

/*
 * Save an animation.
 *
 * fileName (in) - file to save to
 */
void tagAnimation::save(const STRING fileName) const
{

	CFile file(fileName, OF_CREATE | OF_WRITE);

	file << _T("RPGTLKIT ANIM");
	file << short(2);
	file << short(3);
	file << pxWidth;
	file << pxHeight;

	const int frames = frameFiles.size() - 1;
	file << frames;
	for (unsigned int i = 0; i <= frames; i++)
	{
		file << frameFiles[i];
		file << transpColors[i];
		file << sounds[i];
	}

	file << delay;

}

/*
 * Load an animated gif into an ANIMATION.
 */
void tagAnimation::loadFromGif(const STRING file)
{
	extern STRING g_projectPath;

	// Do not open in GIF_PLAYBACK mode - FIMD_ANIMATION will not be available.
	FIMULTIBITMAP *mbmp = FreeImage_OpenMultiBitmap(
		// FreeImage_GetFileType(getAsciiString(file).c_str(), 16),
		FIF_GIF,
		getAsciiString(file).c_str(), 
		FALSE, TRUE, TRUE, GIF_DEFAULT
	);
	if (!mbmp) return;

	frameCount = FreeImage_GetPageCount(mbmp);
	if (frameCount)
	{
		FITAG *tag = NULL;
		FIBITMAP *bmp = FreeImage_LockPage(mbmp, 0);

		pxWidth = FreeImage_GetWidth(bmp); 
		pxHeight = FreeImage_GetHeight(bmp);

		// Extract the FrameTime tag. See FIMD_ANIMATION specification.
		if (FreeImage_GetMetadata(FIMD_ANIMATION, bmp, getAsciiString(STRING("FrameTime")).c_str(), &tag))
		{
			// Frame time stored in milliseconds in tag (centiseconds in gif).
			// ANIMATION has provision for only one frame time - use first frame's delay.
			CONST LPLONG pFrameTime = LPLONG(FreeImage_GetTagValue(tag));
			delay = double(*pFrameTime) / MILLISECONDS;
		}

		// Get the transparent color.
		LONG color = TRANSP_COLOR;
		if (FreeImage_IsTransparent(bmp) && FreeImage_HasBackgroundColor(bmp))
		{
			RGBQUAD bkg = {0, 0, 0, 0};
			FreeImage_GetBackgroundColor(bmp, &bkg); 
			color = RGB(bkg.rgbRed, bkg.rgbGreen, bkg.rgbBlue);
		}
		transpColors.clear();
		transpColors.resize(frameCount, color);

		/* Palettized transparency.
		CONST LPRGBQUAD palette = FreeImage_GetPalette(bmp);
		if (palette)
		{ 
			CONST BYTE *table = FreeImage_GetTransparencyTable(bmp); 
			CONST RGBQUAD quad = palette[table[0]];
			CONST LONG color = RGB(quad.rgbRed, quad.rgbGreen, quad.rgbBlue);
			transpColors.resize(m_data.frameCount, color);
		}*/
		
		FreeImage_UnlockPage(mbmp, bmp, FALSE);

		// Pad vectors.
		frameFiles.resize(frameCount);
		sounds.resize(frameCount);
	}
	FreeImage_CloseMultiBitmap(mbmp, 0);
}


/*
 * Draw a picture.
 */
void drawImage(const STRING strFile, const HDC hdc, const int x, const int y, const int width, const int height)
{
	if (_strcmpi(getExtension(strFile).c_str(), _T("TBM")) == 0)
	{
		TILE_BITMAP tbm;
		if (!tbm.open(strFile)) return;
		CCanvas cnvInt, cnvMask;
		const int fullWidth = tbm.width * 32, fullHeight = tbm.height * 32;
		cnvInt.CreateBlank(NULL, fullWidth, fullHeight, TRUE);
		cnvMask.CreateBlank(NULL, fullWidth, fullHeight, TRUE);
		tbm.draw(&cnvInt, &cnvMask, 0, 0);
		const HDC hdcMask = cnvMask.OpenDC();
		const HDC hdcSource = cnvInt.OpenDC();
		StretchBlt(hdc, x, y, width, height, hdcMask, 0, 0, fullWidth, fullHeight, SRCAND);
		StretchBlt(hdc, x, y, width, height, hdcSource, 0, 0, fullWidth, fullHeight, SRCPAINT);
		cnvInt.CloseDC(hdcSource);
		cnvMask.CloseDC(hdcMask);
		return;
	}

	STRING prFile = getAsciiString(resolve(strFile)).c_str();
	FIBITMAP *bmp = FreeImage_Load(FreeImage_GetFileType(prFile.c_str(), 16), prFile.c_str());
	StretchDIBits(hdc, x, y, (width != -1) ? width : FreeImage_GetWidth(bmp), (height != -1) ? height : FreeImage_GetHeight(bmp), 0, 0, FreeImage_GetWidth(bmp), FreeImage_GetHeight(bmp), FreeImage_GetBits(bmp), FreeImage_GetInfo(bmp), DIB_RGB_COLORS, SRCCOPY);
	FreeImage_Unload(bmp);
}

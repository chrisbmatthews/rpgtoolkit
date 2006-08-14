/*
 * All contents copyright 2003, 2004, 2005 Christopher Matthews or Contributors.
 * Various port optimizations copyright by Colin James Fitzpatrick, 2005.
 * All rights reserved. You may not remove this notice
 * Read license.txt for licensing details.
 */

/*
 * Inclusions.
 */
#include "animation.h"
#include "paths.h"
#include "CFile.h"
#include "../rpgcode/parser/parser.h"
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

	STRING fileHeader;
	file >> fileHeader;
	if (fileHeader == _T("RPGTLKIT ANIM"))
	{
		short majorVer, minorVer;
		file >> majorVer;
		file >> minorVer;
		if (minorVer == 3)
		{
			file >> animSizeX;
			file >> animSizeY;
			file >> animFrames;
			animFrame.clear();
			animTransp.clear();
			animSound.clear();
			for (unsigned int i = 0; i <= animFrames; i++)
			{
				STRING strA, strB;
				int num;
				file >> strA;
				file >> num;
				file >> strB;
				if (!strA.empty())
				{
					// Add frame if frame contains image.
					animFrame.push_back(strA);
					animTransp.push_back(num);
					animSound.push_back(strB);
				}
			}
			// Effective "UBound".
			animFrames = animFrame.size() - 1;
			file >> animPause;
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
		animSizeX = _ttoi(file.line().c_str());
		animSizeY = _ttoi(file.line().c_str());
		animFrames = _ttoi(file.line().c_str());
		animFrame.clear();
		animTransp.clear();
		animSound.clear();
		for (unsigned int i = 0; i <= animFrames; i++)
		{
			animFrame.push_back(file.line());
			animTransp.push_back(_ttoi(file.line().c_str()));
			animSound.push_back(file.line());
		}
		animPause = atof(getAsciiString(file.line()).c_str());
	}

	animFile = removePath(fileName);
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
	file << animSizeX;
	file << animSizeY;

	const int frames = animFrame.size() - 1;
	file << frames;
	for (unsigned int i = 0; i <= frames; i++)
	{
		file << animFrame[i];
		file << animTransp[i];
		file << animSound[i];
	}

	file << animPause;

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

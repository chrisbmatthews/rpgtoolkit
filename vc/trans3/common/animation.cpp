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

/*
 * Globals
 */
std::vector<ANIMATION_FRAME> g_anmCache;	// Animation cache.

/*
 * Open an animation.
 *
 * fileName (in) - file to open
 * bool (out) - open success
 */
bool tagAnimation::open(const std::string fileName)
{

	CFile file(fileName);

	std::string fileHeader;
	file >> fileHeader;
	if (fileHeader == "RPGTLKIT ANIM")
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
				std::string strA, strB;
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
			MessageBox(NULL, ("This is not a valid animaton file. " + fileName).c_str(), NULL, 0);
			return false;
		}
 	}
	else
	{
		file.seek(0);
		if (file.line() != "RPGTLKIT ANIM")
		{
			MessageBox(NULL, ("This is not a valid animaton file. " + fileName).c_str(), NULL, 0);
			return false;
		}
		file.line();
		file.line();
		animSizeX = atoi(file.line().c_str());
		animSizeY = atoi(file.line().c_str());
		animFrames = atoi(file.line().c_str());
		animFrame.clear();
		animTransp.clear();
		animSound.clear();
		for (unsigned int i = 0; i <= animFrames; i++)
		{
			animFrame.push_back(file.line());
			animTransp.push_back(atoi(file.line().c_str()));
			animSound.push_back(file.line());
		}
		animPause = atof(file.line().c_str());
	}

	animFile = removePath(fileName);
	return true;
}

/*
 * Clear the animation cache.
 */
void clearAnmCache(void)
{
	for (std::vector<ANIMATION_FRAME>::iterator i = g_anmCache.begin(); i != g_anmCache.end(); ++i)
	{
		delete i->cnv;
	}
	g_anmCache.clear();
}

/*
 * Save an animation.
 *
 * fileName (in) - file to save to
 */
void tagAnimation::save(const std::string fileName) const
{

	CFile file(fileName, OF_CREATE | OF_WRITE);

	file << "RPGTLKIT ANIM";
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
 * Render "frame" of animation "file" at location "x,y" at canvas "cnv".
 * Checks through the animation cache for previous renderings of this frame,
 * if not found, it is rendered here and copied to the animation cache.
 */
bool renderAnimationFrame(CGDICanvas *cnv,
						  std::string file,
						  int frame,
						  const int x,
						  const int y)
{
	extern std::string g_projectPath;

    // Whatever the case, clear the canvas in case the character has no graphics,
    // or the animation can't be loaded.
    cnv->ClearScreen(TRANSP_COLOR);

    if (file.empty()) return false;

    // Get canvas width and height.
    const int w = cnv->GetWidth(), h = cnv->GetHeight();
    
    // Capitalize the file.
	file = parser::uppercase(file);

    // First check sprite cache.
    std::vector<ANIMATION_FRAME>::iterator i = g_anmCache.begin();
    for (; i != g_anmCache.end(); i++)
	{
        if (file.compare(i->file) == 0) 
		{
			// All files in cache are capitalised.

            frame %= (i->maxFrames + 1);

            if (i->frame == frame)
			{
                // Resize target canvas, if required.
                const int cacheFrameWidth = i->cnv->GetWidth();
                const int cacheFrameHeight = i->cnv->GetHeight();
                
                if (w != cacheFrameWidth || h != cacheFrameHeight)
				{
                    cnv->Resize(NULL, cacheFrameWidth, cacheFrameHeight);
                }

                // Blt contents over.
				i->cnv->Blt(cnv, x, y, SRCCOPY);

                // Play the frame's sound.
				sndPlaySound((g_projectPath + MEDIA_PATH + i->strSound).c_str(), SND_ASYNC | SND_NODEFAULT);

                // All done!
                return true;
			}
		} // if (i->file == file)
	} // for (; i = g_anmCache.end(); i++)

	/*
	 * Else, we need to draw from scratch.
	 */

	ANIMATION anm;
	if (!anm.open(g_projectPath + MISC_PATH + file)) return false;

    frame %= (anm.animFrames + 1);

	const std::string frameFile = anm.animFrame[frame];

    if (frameFile.empty()) return false;

	// We can draw the frame!

    // Get the ambient level here. Must be done before opening the DC,
    // otherwise trans3 *will* crash on Win9x.
//        Call getAmbientLevel(addOnR, addOnB, addOnG)

    // Resize the canvas if needed.
    if (w != anm.animSizeX || h != anm.animSizeY)
	{
		cnv->Resize(NULL, anm.animSizeX, anm.animSizeY);
	}

    cnv->ClearScreen(TRANSP_COLOR);

	const std::string ext = parser::uppercase(getExtension(frameFile));
    if (ext == "TBM" || ext.substr(0, 3) == "TST" || ext == "GPH")
	{
        // You *must* load a tile bitmap before opening an hdc
        // because it'll lock up on windows 98 if you don't.

		TILE_BITMAP tbm;

		if (ext == "TBM")
		{
			if (!tbm.open(g_projectPath + BMP_PATH + frameFile)) return false;
		}
		else
		{
			// Set up a 1x1 tile bitmap.
			tbm.resize(1, 1);
			tbm.tiles[0][0] = frameFile;
		}

        // Draw the tilebitmap and mask to new canvases.
		CGDICanvas *cnvTbm = new CGDICanvas();
		CGDICanvas *cnvMaskTbm = new CGDICanvas();
		cnvTbm->CreateBlank(NULL, tbm.width * 32, tbm.height * 32, true);
		cnvMaskTbm->CreateBlank(NULL, tbm.width * 32, tbm.height * 32, true);

		if (tbm.draw(cnvTbm, cnvMaskTbm, 0, 0))
		{
			//Stretch the tbm canvas to the required size and draw it to the canvas.
			canvasMaskBltStretchTransparent(cnvTbm,
											cnvMaskTbm,
											0, 0,
											anm.animSizeX,
											anm.animSizeY,
											cnv,
											anm.animTransp[frame]);
		}

		// Clean up.
        delete cnvTbm;
        delete cnvMaskTbm;
	}
	else
	{
		// Image file.
        CGDICanvas *c2 = new CGDICanvas();
		c2->CreateBlank(NULL, anm.animSizeX, anm.animSizeY, true);
//			Call canvasLoadSizedPicture(c2, projectPath & bmpPath & frameFile)
		cnv->BltTransparent(c2, x, y, anm.animTransp[frame]);
		delete c2;

    } // if (ext == TBM)

    // Play the frame's sound.
	sndPlaySound((g_projectPath + MEDIA_PATH + anm.animSound[frame]).c_str(), SND_ASYNC | SND_NODEFAULT);

    // Now place this frame in the sprite cache.
	ANIMATION_FRAME anmFr;
    anmFr.file = file;
    anmFr.frame = frame;
    anmFr.maxFrames = anm.animFrames;
    anmFr.strSound = g_projectPath + MEDIA_PATH + anm.animSound[frame];

	anmFr.cnv = new CGDICanvas();
    anmFr.cnv->CreateBlank(NULL, anm.animSizeX, anm.animSizeY, TRUE);
	anmFr.cnv->ClearScreen(TRANSP_COLOR);
    cnv->Blt(anmFr.cnv, 0, 0, SRCCOPY);

	g_anmCache.push_back(anmFr);
}

/*
 * CommonCanvas canvasMaskBltStretchTransparent
 * *** This function is looking for a home! ***
 * Colin: CCanvas?
 */
bool canvasMaskBltStretchTransparent(const CGDICanvas *cnvSource,
									  const CGDICanvas *cnvMask,
									  const int destX,
									  const int destY,
									  const int newWidth,
									  const int newHeight, 
									  const CGDICanvas *cnvTarget,
									  const int crTranspColor)
{
	
	const int w = cnvSource->GetWidth(), h = cnvSource->GetHeight();

	// Create an intermediate canvas
	CGDICanvas *cnvInt = new CGDICanvas();
	cnvInt->CreateBlank(NULL, newWidth, newHeight, true);
	cnvInt->ClearScreen(crTranspColor);

	if (true)
	{
		// Use GDI BitBlt and StretchBlt.
		// Stretch the image onto the intermediate canvas.

        const HDC hdcInt = cnvInt->OpenDC();
	    const HDC hdcSource = cnvSource->OpenDC();
        const HDC hdcMask = cnvMask->OpenDC();

		if (w == newWidth && h == newHeight)
		{
			// Image is not stretched - no need to use StretchBlt.
            BitBlt(hdcInt, 0, 0, w, h, hdcMask, 0, 0, SRCAND);
            BitBlt(hdcInt, 0, 0, w, h, hdcSource, 0, 0, SRCPAINT);
		}
        else
		{
			// Need to use StretchBlt.
            StretchBlt(hdcInt, 
					   0, 0, newWidth, newHeight,
					   hdcMask, 
					   0, 0, w, h, 
					   SRCAND);
            StretchBlt(hdcInt, 
					   0, 0, newWidth, newHeight,
					   hdcSource,
                       0, 0, w, h, 
					   SRCPAINT);

        } // if (requires stretching).

        cnvSource->CloseDC(hdcSource);
		cnvMask->CloseDC(hdcMask);
        cnvInt->CloseDC(hdcInt);
	}
	else
	{
		// Use Dx.
		// CNVBltStretchCanvas.
		cnvMask->BltStretch(cnvInt, 0, 0, 0, 0, w, h, newWidth, newHeight, SRCAND);
		cnvSource->BltStretch(cnvInt, 0, 0, 0, 0, w, h, newWidth, newHeight, SRCPAINT);
	}

	// Blt the intermediate canvas to the target canvas.
	cnvInt->BltTransparent(cnvTarget, destX, destY, crTranspColor);

	// Destroy the intermediate canvas.
	delete cnvInt;

	return true;
}


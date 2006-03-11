/*
 * All contents copyright 2005 Jonathan D. Hughes
 * All rights reserved. You may not remove this notice
 * Read license.txt for licensing details.
 */

/*
 * CAnimation - Animations and threaded animations.
 */
#include "CAnimation.h"
#include "CFile.h"
#include "../../tkCommon/images/FreeImage.h"
#include "../movement/movement.h"
#include "../rpgcode/parser/parser.h"
#include "../../tkCommon/tkCanvas/GDICanvas.h"

/*
 * Defines
 */
std::set<CThreadAnimation *> CThreadAnimation::m_threads;
std::set<CSharedAnimation *> CSharedAnimation::m_anms;
SHARED_ANIMATIONS CSharedAnimation::m_shared;

/*
 * Constructor.
 */
CAnimation::CAnimation(const STRING file):
m_users(1) 
{
	extern STRING g_projectPath;

	freeCanvases();
	if (!file.empty()) m_data.open(g_projectPath + MISC_PATH + file);

	for (unsigned int i = 0; i <= m_data.animFrames; ++i)
	{
		m_canvases.push_back(NULL);
	}
}

/* 
 * Render all frames - optional on loading, but can be rendered on the fly.
 */
void CAnimation::render(void)
{
	std::vector<CCanvas *>::iterator i = m_canvases.begin(), start = i;
	{
		delete *i;
		*i = new CCanvas();
		(*i)->CreateBlank(NULL, m_data.animSizeX, m_data.animSizeY, TRUE);
		
		// Render regardless of success. If rendering
		// fails cnv will just be transparent.
		renderFrame(*i, i - start);
	}
}

/*
 * Animate to the rpgcode screen (for RPGCode functions).
 */
void CAnimation::animate(const int x, const int y)
{
	extern CCanvas *g_cnvRpgCode;
	extern STRING g_projectPath;
	extern void processEvent();

	// Copy the screen.
	const CCanvas cnvScr = *g_cnvRpgCode;

	std::vector<CCanvas *>::iterator i = m_canvases.begin(), start = i;
	for (; i != m_canvases.end(); ++i)
	{
		if (!*i)
		{
			*i = new CCanvas();
			(*i)->CreateBlank(NULL, m_data.animSizeX, m_data.animSizeY, TRUE);
			if (!renderFrame(*i, i - start)) continue;
		}

		// Place on g_cnvRpgCode.
		(*i)->BltTransparent(g_cnvRpgCode, x, y, TRANSP_COLOR);

		// Refresh the screen.
		processEvent();
		renderRpgCodeScreen();

		// Play the frame's sound.
		playFrameSound(i - start);

		Sleep(DWORD(m_data.animPause * MILLISECONDS));

		// Replace g_cnvRpgCode with the original.
		cnvScr.BltPart(g_cnvRpgCode, 
			x, y, 
			x, y, 
			m_data.animSizeX, m_data.animSizeY,
			SRCCOPY);
	}
}

/*
 * Get a pointer to the required frame.
 */
CCanvas *CAnimation::getFrame(unsigned int frame)
{
	// Wrap around.
	frame %= (m_data.animFrames + 1);

	if (!m_canvases[frame])
	{
		m_canvases[frame] = new CCanvas();
		m_canvases[frame]->CreateBlank(NULL, m_data.animSizeX, m_data.animSizeY, TRUE);

		// Render and use regardless of success. If rendering
		// fails cnv will just be transparent.
		renderFrame(m_canvases[frame], frame);
	}
	return m_canvases[frame];
}

/*
 * Render a particular frame to a canvas.
 */
bool CAnimation::renderFrame(CCanvas *cnv, unsigned int frame)
{
	extern STRING g_projectPath;

    cnv->ClearScreen(TRANSP_COLOR);

	// Wrap around.
    frame %= (m_data.animFrames + 1);

	const STRING frameFile = m_data.animFrame[frame];

    if (frameFile.empty()) return false;

    // Get the ambient level here. Must be done before opening the DC,
    // otherwise trans3 *will* crash on Win9x.
//TBD:	Call getAmbientLevel(addOnR, addOnB, addOnG)

	const STRING ext = parser::uppercase(getExtension(frameFile));
    if (ext == _T("TBM") || ext.substr(0, 3) == _T("TST") || ext == _T("GPH"))
	{
        // You *must* load a tile bitmap before opening an hdc
        // because it'll lock up on windows 98 if you don't.

		TILE_BITMAP tbm;

		if (ext == _T("TBM"))
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
		const int w = tbm.width * 32, h = tbm.height * 32;
		CCanvas cnvTbm, cnvMaskTbm;
		cnvTbm.CreateBlank(NULL, w, h, TRUE);
		cnvMaskTbm.CreateBlank(NULL, w, h, TRUE);

		if (tbm.draw(&cnvTbm, &cnvMaskTbm, 0, 0))
		{
			// Stretch the canvas and mask to an intermediate canvas.
			CCanvas cnvInt;
			cnvInt.CreateBlank(NULL, w, h, TRUE);
			cnvInt.ClearScreen(m_data.animTransp[frame]);

			cnvTbm.BltStretchMask(
				&cnvMaskTbm,
				&cnvInt,
				0, 0, 
				0, 0,
				w, h, 
				m_data.animSizeX, m_data.animSizeY
			);
			// Blt to the target canvas.
			cnvInt.BltTransparent(cnv, 0, 0, m_data.animTransp[frame]);
		}
	}
	else
	{
		// Image file.
		const STRING strFile = g_projectPath + BMP_PATH + frameFile;
		FIBITMAP *bmp = FreeImage_Load(
			FreeImage_GetFileType(getAsciiString(strFile).c_str(), 16), 
			getAsciiString(strFile).c_str()
		);

        CCanvas cnvImg;
		cnvImg.CreateBlank(NULL, m_data.animSizeX, m_data.animSizeY, TRUE);
		
		CONST HDC hdc = cnvImg.OpenDC();
		StretchDIBits(
			hdc, 
			0, 0, 
			m_data.animSizeX, m_data.animSizeY, 
			0, 0, 
			FreeImage_GetWidth(bmp), 
			FreeImage_GetHeight(bmp), 
			FreeImage_GetBits(bmp), 
			FreeImage_GetInfo(bmp), 
			DIB_RGB_COLORS, 
			SRCCOPY
		);
		FreeImage_Unload(bmp);
		cnvImg.CloseDC(hdc);
		cnvImg.BltTransparent(cnv, 0, 0, m_data.animTransp[frame]);

    } // if (ext == TBM)
	return true;
}

/*
 * Internal constructor
 */
CThreadAnimation::CThreadAnimation(const STRING file, const int x, const int y, const bool bPersist): 
CSharedAnimation(file),
m_persist(bPersist),
m_timer(0),
m_x(x),
m_y(y) { m_frame = 0; }

/*
 * External constructor
 */
CThreadAnimation *CThreadAnimation::create(const STRING file, const int x, const int y, const int width, const int height, const bool bPersist)
{
	if (!file.empty() && !running(file, x, y))
	{
		CThreadAnimation *p = new CThreadAnimation(file, x, y, bPersist);
		p->m_pAnm->resize(width, height);
		m_threads.insert(p);
		return p;
	}
}

/*
 * External deconstructor
 */
void CThreadAnimation::destroy(CThreadAnimation *p)
{
	std::set<CThreadAnimation *>::iterator i = m_threads.find(p);
	if (i != m_threads.end())
	{
		m_threads.erase(i);
		delete p;
	}
}

/*
 * Check that an animation is threading.
 */
bool CThreadAnimation::running(const STRING file, const int x, const int y)
{
	std::set<CThreadAnimation *>::iterator i = m_threads.begin();
	for(; i != m_threads.end(); ++i)
	{
		if (_ftcsicmp(file.c_str(), (*i)->m_pAnm->filename().c_str()) == 0) 
		{
			if ((x == (*i)->m_x) && (y == (*i)->m_y)) return true;
		}
	}
	return false;
}

/*
 * Render the current frames of all animations to a canvas.
 */
void CThreadAnimation::renderAll(CCanvas *cnv)
{
	std::set<CThreadAnimation *>::iterator i = m_threads.begin();
	for(; i != m_threads.end(); ++i)
	{
		// Render frame.
		if (!(*i)->renderFrame(cnv))
		{
			// Animation finished.
			delete *i;
			m_threads.erase(i);
		}
	}
}

/*
 * Get the current frame, increment if necessary.
 * Return false if the thread is finished and pass back the pointer.
 */
bool CThreadAnimation::renderFrame(CCanvas *cnv)
{
	// Increment frame.
	const LPANIMATION p = m_pAnm->data();
	if (GetTickCount() - m_timer > p->animPause)
	{
		m_timer = 0;
		++m_frame;

		if (!m_persist && m_frame > p->animFrames)
		{
			// End the animation.
			return false;
		}
		// Play sounnd on transition.
		m_pAnm->playFrameSound(m_frame);
	}
	m_pAnm->getFrame(m_frame)->BltTransparent(cnv, m_x, m_y, TRANSP_COLOR);
	return true;
}

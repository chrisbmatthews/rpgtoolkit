/*
 ********************************************************************
 * The RPG Toolkit, Version 3
 * This file copyright (C) 2006  Jonathan D. Hughes
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

/*
 * CAnimation - Animations and threaded animations.
 */
#include "CAnimation.h"
#include "CFile.h"
#include "FreeImage.h"
#include "../movement/movement.h"
#include "../rpgcode/parser/parser.h"
#include "../../tkCommon/tkCanvas/GDICanvas.h"
#include <mmsystem.h>

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

	renderFrame = &CAnimation::renderAnmFrame;

	if (!file.empty())
	{
		const STRING ext = getExtension(file);
	    
		if (_ftcsicmp(ext.c_str(), _T("anm")) == 0)
		{
			m_data.open(g_projectPath + MISC_PATH + file);
		}
		else if (_ftcsicmp(ext.c_str(), _T("gif")) == 0)
		{
			m_data.loadFromGif(resolve(g_projectPath + MISC_PATH + file));
			renderFrame = &CAnimation::renderFileFrame;
			m_data.filename = file;
		}
	}

	freeCanvases();
	m_canvases.resize(m_data.frameCount, NULL);
}

/* 
 * Render all frames - optional on loading, but can be rendered on the fly.
 */
void CAnimation::render(void)
{
	std::vector<CCanvas *>::iterator i = m_canvases.begin(), start = i;
	for (; i != m_canvases.end(); ++i)
	{
		delete *i;
		*i = new CCanvas();
		(*i)->CreateBlank(NULL, m_data.pxWidth, m_data.pxHeight, TRUE);
		
		// Render regardless of success. If rendering
		// fails cnv will just be transparent.
		(this->*renderFrame)(*i, i - start);
	}
}

/*
 * Animate to the rpgcode screen (for RPGCode functions).
 */
void CAnimation::animate(const int x, const int y)
{
	extern CCanvas *g_cnvRpgCode;
	extern void processEvent();

	// Copy the screen.
	const CCanvas cnvScr = *g_cnvRpgCode;

	std::vector<CCanvas *>::iterator i = m_canvases.begin(), start = i;
	for (; i != m_canvases.end(); ++i)
	{
		if (!*i)
		{
			*i = new CCanvas();
			(*i)->CreateBlank(NULL, m_data.pxWidth, m_data.pxHeight, TRUE);
			if (!(this->*renderFrame)(*i, i - start)) continue;
		}

		// Place on g_cnvRpgCode.
		(*i)->BltTransparent(g_cnvRpgCode, x, y, TRANSP_COLOR);

		// Refresh the screen.
		processEvent();
		renderRpgCodeScreen();

		// Play the frame's sound.
		playFrameSound(i - start);

		Sleep(DWORD(m_data.delay * MILLISECONDS));

		// Replace g_cnvRpgCode with the original.
		cnvScr.BltPart(
			g_cnvRpgCode, 
			x, y, 
			x, y, 
			m_data.pxWidth, m_data.pxHeight,
			SRCCOPY
		);
	}
}

/*
 * Get a pointer to the required frame.
 */
CCanvas *CAnimation::getFrame(unsigned int frame)
{
	// Wrap around.
	frame %= m_data.frameCount;

	if (!m_canvases[frame])
	{
		m_canvases[frame] = new CCanvas();
		m_canvases[frame]->CreateBlank(NULL, m_data.pxWidth, m_data.pxHeight, TRUE);

		// Render and use regardless of success. If rendering
		// fails cnv will just be transparent.
		(this->*renderFrame)(m_canvases[frame], frame);
	}
	return m_canvases[frame];
}

/*
 * Render a particular frame to a canvas.
 */
bool CAnimation::renderAnmFrame(CCanvas *cnv, unsigned int frame)
{
	extern STRING g_projectPath;

    cnv->ClearScreen(TRANSP_COLOR);

	// Wrap around.
    frame %= m_data.frameCount;

	const STRING frameFile = m_data.frameFiles[frame];

    if (frameFile.empty()) return false;

	const STRING ext = parser::uppercase(getExtension(frameFile));
    if (ext == _T("TBM") || ext.substr(0, 3) == _T("TST") || ext == _T("GPH"))
	{
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
			cnvInt.ClearScreen(m_data.transpColors[frame]);

			cnvTbm.BltStretchMask(
				&cnvMaskTbm,
				&cnvInt,
				0, 0, 
				0, 0,
				w, h, 
				m_data.pxWidth, m_data.pxHeight
			);
			// Blt to the target canvas.
			cnvInt.BltTransparent(cnv, 0, 0, m_data.transpColors[frame]);
		}
	}
	else
	{
		// Image file.
		const STRING strFile = resolve(g_projectPath + BMP_PATH + frameFile);
		FIBITMAP *bmp = FreeImage_Load(
			FreeImage_GetFileType(getAsciiString(strFile).c_str(), 16), 
			getAsciiString(strFile).c_str()
		);

        CCanvas cnvImg;
		cnvImg.CreateBlank(NULL, m_data.pxWidth, m_data.pxHeight, TRUE);
		
		CONST HDC hdc = cnvImg.OpenDC();
		StretchDIBits(
			hdc, 
			0, 0, 
			m_data.pxWidth, m_data.pxHeight, 
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

		// Apply ambient level.
		extern AMBIENT_LEVEL g_ambientLevel;
		if (g_ambientLevel.color)
		{
			CCanvas cnvAl;
			cnvAl.CreateBlank(NULL, m_data.pxWidth, m_data.pxHeight, TRUE);
			cnvAl.ClearScreen(g_ambientLevel.color);
			cnvAl.BltAdditivePart(cnvImg.GetDXSurface(), 0, 0, 0, 0, m_data.pxWidth, m_data.pxHeight, g_ambientLevel.sgn, -1, m_data.transpColors[frame]);
		}

		cnvImg.BltTransparent(cnv, 0, 0, m_data.transpColors[frame]);

    } // if (ext == TBM)
	return true;
}

/*
 * Play the sound associated with a frame.
 */
void CAnimation::playFrameSound(unsigned int frame) const
{
	frame %= m_data.frameCount;
	extern STRING g_projectPath;
	sndPlaySound(
		(g_projectPath + MEDIA_PATH + m_data.sounds[frame]).c_str(), 
		SND_ASYNC | SND_NODEFAULT
	);
}

/*
 * Internal constructor.
 */
CSharedAnimation::CSharedAnimation(const STRING file): 
	m_frame(-1), 
	m_tick(0), 
	m_pAnm(NULL) 
{
	SHARED_ANIMATIONS::iterator i = m_shared.find(file);
	if (i != m_shared.end())
	{
		// Add a user to the current animation.
		i->second->addUser();
		m_pAnm = i->second;
	}
	else
	{
		// Create a new entry.
		CAnimation *p = new CAnimation(file);
		if (p->filename().empty()) 
		{
			// Filename not assigned during ANIMATION loading: failed to load animation.
			delete p;
			return;
		}
		m_shared[file] = m_pAnm = p;
	}
}

/*
 * Internal destructor.
 */
CSharedAnimation::~CSharedAnimation()	
{ 
	// Remove a user from the CAnimation.
	if (m_pAnm)
	{
		// m_pAnm = NULL if animation not inserted into m_anms.
		if (m_pAnm->removeUser() == 0)
		{
			SHARED_ANIMATIONS::iterator j = m_shared.find(m_pAnm->filename());
			delete m_pAnm;
			if (j != m_shared.end()) m_shared.erase(j);
		}
	}
}
	
/* 
 * Share an animation if it exists or create a new instance.
 */
CSharedAnimation *CSharedAnimation::insert(const STRING file)
{
	if (file.empty()) return NULL;

	// Add the CShared to the individual users list.
	CSharedAnimation *p = new CSharedAnimation(file);
	if (!p->m_pAnm)
	{
		// Failed to create animation.
		delete p;
		return NULL;
	}
	m_anms.insert(p);
	return p;
}

/*
 * Free all shared animations.
 */
void CSharedAnimation::freeAll(void)
{
	// These may not be empty in an unexpected shutdown.

	std::set<CSharedAnimation *>::iterator j = m_anms.begin();
	for (; j != m_anms.end(); ++j) delete *j;

	SHARED_ANIMATIONS::iterator i = m_shared.begin();
	for (; i != m_shared.end(); ++i) delete i->second; 
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
	if (GetTickCount() - m_timer > p->delay)
	{
		m_timer = 0;
		++m_frame;

		if (!m_persist && m_frame >= p->frameCount)
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

/*
 * Two implementations: render a single frame or render all frames at once.
 * (1) Render all frames of an animation when a particular frame is requested.
 *	   requires only one opening of file.
 * (0) Render each frame as it is requested.
 *	   requires multiple openings of file - may be slow.
 */
#if(1)

/*
 * Render all frames of a file (not gif specific).
 */
bool CAnimation::renderFileFrame(CCanvas *, unsigned int)
{
	extern STRING g_projectPath;

    if (m_data.filename.empty()) return false;

	const STRING file = resolve(g_projectPath + MISC_PATH + m_data.filename);

	FIMULTIBITMAP *mbmp = FreeImage_OpenMultiBitmap(
		FreeImage_GetFileType(getAsciiString(file).c_str(), 16), 
		getAsciiString(file).c_str(), 
		FALSE, TRUE, TRUE
	);
	if (!mbmp) return false;

	// Create ambient level canvas.
	extern AMBIENT_LEVEL g_ambientLevel;
	CCanvas cnvAl;
	if (g_ambientLevel.color)
	{
		cnvAl.CreateBlank(NULL, m_data.pxWidth, m_data.pxHeight, TRUE);
		cnvAl.ClearScreen(g_ambientLevel.color);
	}

	// Intermediate canvas.
	CCanvas cnv;
	cnv.CreateBlank(NULL, m_data.pxWidth, m_data.pxHeight, TRUE);

	freeCanvases();
	m_canvases.clear();
	for (int i = 0; i != m_data.frameCount; ++i)
	{
		CONST HDC hdc = cnv.OpenDC();
		FIBITMAP *bmp = FreeImage_LockPage(mbmp, i);

		SetDIBitsToDevice(
			hdc,
			0, 0,   
			m_data.pxWidth, m_data.pxHeight, 
			0, 0,
			0, FreeImage_GetHeight(bmp), 
			FreeImage_GetBits(bmp),   
			FreeImage_GetInfo(bmp), 
			DIB_RGB_COLORS
		); 

		/* No need to stretch gif.
		StretchDIBits(
			hdc, 
			0, 0, 
			0, 0, 
			FreeImage_GetWidth(bmp), 
			FreeImage_GetHeight(bmp),
			FreeImage_GetBits(bmp), 
			FreeImage_GetInfo(bmp), 
			DIB_RGB_COLORS, SRCCOPY
		);*/

		FreeImage_UnlockPage(mbmp, bmp, FALSE);
		cnv.CloseDC(hdc);

		// Apply ambient level.
		if (g_ambientLevel.color)
		{
			cnvAl.BltAdditivePart(cnv.GetDXSurface(), 0, 0, 0, 0, m_data.pxWidth, m_data.pxHeight, g_ambientLevel.sgn, -1, m_data.transpColors[i]);
		}

		// Blt to the member canvas.
		CCanvas *pCnv = new CCanvas();
		pCnv->CreateBlank(NULL, m_data.pxWidth, m_data.pxHeight, TRUE);
		pCnv->ClearScreen(TRANSP_COLOR);
		cnv.BltTransparent(pCnv, 0, 0, m_data.transpColors[i]);

		m_canvases.push_back(pCnv);
	}
	FreeImage_CloseMultiBitmap(mbmp, 0);
	return true;
}

#else

/*
 * Render a particular frame to a canvas (not gif specific).
 */
bool CAnimation::renderFileFrame(CCanvas *cnv, unsigned int frame)
{
	extern STRING g_projectPath;

    cnv->ClearScreen(TRANSP_COLOR);

	// Wrap around.
    frame %= m_data.frameCount;

    if (m_data.filename.empty()) return false;

	const STRING file = resolve(g_projectPath + MISC_PATH + m_data.filename);

	FIMULTIBITMAP *mbmp = FreeImage_OpenMultiBitmap(
		FreeImage_GetFileType(getAsciiString(file).c_str(), 16), 
		getAsciiString(file).c_str(), 
		FALSE, TRUE, TRUE
	);
	if (!mbmp) return false;

    CCanvas cnvImg;
	cnvImg.CreateBlank(NULL, m_data.pxWidth, m_data.pxHeight, TRUE);

	const int pageCount = FreeImage_GetPageCount(mbmp);
	if (frame < pageCount)
	{
		CONST HDC hdc = cnvImg.OpenDC();
		FIBITMAP *bmp = FreeImage_LockPage(mbmp, frame);

		SetDIBitsToDevice(
			hdc,
			0, 0,   
			m_data.pxWidth, m_data.pxHeight, 
			0, 0,
			0, FreeImage_GetHeight(bmp), 
			FreeImage_GetBits(bmp),   
			FreeImage_GetInfo(bmp), 
			DIB_RGB_COLORS
		); 

		/* No need to stretch gif.
		StretchDIBits(
			hdc, 
			0, 0, 
			m_data.pxWidth, m_data.pxHeight, 
			0, 0, 
			FreeImage_GetWidth(bmp), 
			FreeImage_GetHeight(bmp),
			FreeImage_GetBits(bmp), 
			FreeImage_GetInfo(bmp), 
			DIB_RGB_COLORS, SRCCOPY
		);*/

		FreeImage_UnlockPage(mbmp, bmp, FALSE);
		cnvImg.CloseDC(hdc);
	}
	FreeImage_CloseMultiBitmap(mbmp, 0);

	// Apply ambient level.
	extern AMBIENT_LEVEL g_ambientLevel;
	if (g_ambientLevel.color)
	{
		CCanvas cnvAl;
		cnvAl.CreateBlank(NULL, m_data.pxWidth, m_data.pxHeight, TRUE);
		cnvAl.ClearScreen(g_ambientLevel.color);
		cnvAl.BltAdditivePart(cnvImg.GetDXSurface(), 0, 0, 0, 0, m_data.pxWidth, m_data.pxHeight, g_ambientLevel.sgn, -1, m_data.transpColors[frame]);
	}

	cnvImg.BltTransparent(cnv, 0, 0, m_data.transpColors[frame]);

	return true;
}

#endif
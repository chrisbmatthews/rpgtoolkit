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

#include "CVideo.h"
#include "../stdafx.h"
#include "../rpgcode/CProgram.h"
#include "../input/input.h"
#include "../plugins/plugins.h"
#include "../common/paths.h"
#include <strmif.h>
#include <control.h>
#include <uuids.h>

// Constructor.
CVideo::CVideo()
{
	// Create a Filter Graph manager.
	HRESULT res = CoCreateInstance(
		CLSID_FilterGraph,
		NULL,
		CLSCTX_INPROC_SERVER,
		IID_IGraphBuilder,
		(void **)&m_pGraphBuilder
	);
	if (FAILED(res))
	{
		throw CError(_T("ActiveMovie is required to play movies."));
	}

	// Query for IMediaControl, IMediaEvent, and IVideoWindow.
	m_pGraphBuilder->QueryInterface(IID_IMediaControl, (void **)&m_pMediaControl);
	m_pGraphBuilder->QueryInterface(IID_IMediaPosition, (void **)&m_pMediaPosition);
	m_pGraphBuilder->QueryInterface(IID_IVideoWindow, (void **)&m_pVideoWindow);
}

// Render a file.
void CVideo::renderFile(const STRING file)
{
	BSTR bstr = getString(resolve(file));
	m_pMediaControl->RenderFile(bstr);
	SysFreeString(bstr);
}

// Set the window.
void CVideo::setWindow(const long hwnd)
{
	m_pVideoWindow->put_Owner(hwnd);
	m_pVideoWindow->HideCursor(TRUE);
	m_pVideoWindow->put_WindowStyle(WS_CHILD | WS_CLIPSIBLINGS | WS_CLIPCHILDREN);
}

// Get the video's width.
int CVideo::getWidth()
{
	long width = 0;
	m_pVideoWindow->get_Width(&width);
	return width;
}

// Get the video's height.
int CVideo::getHeight()
{
	long height = 0;
	m_pVideoWindow->get_Height(&height);
	return height;
}

// Set the position of the video.
void CVideo::setPosition(const int x, const int y, const int width, const int height)
{
	m_pVideoWindow->SetWindowPosition(x, y, width, height);
}

// Play the movie.
void CVideo::play()
{
	HRESULT hr = m_pMediaControl->Run();
	if (SUCCEEDED(hr))
	{
		while (true)
		{
			double pos = 0, dur = 0;
			m_pMediaPosition->get_CurrentPosition(&pos);
			m_pMediaPosition->get_Duration(&dur);
			if (pos >= dur) break;
			processEvent();
		}
	}
}

CVideo::~CVideo()
{
	m_pVideoWindow->Release();
	m_pMediaPosition->Release();
	m_pMediaControl->Release();
	m_pGraphBuilder->Release();
}

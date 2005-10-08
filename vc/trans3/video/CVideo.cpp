/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

#include "CVideo.h"
#include "../stdafx.h"
#include "../rpgcode/CProgram.h"
#include "../input/input.h"
#include "../plugins/plugins.h"
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
		throw CError("ActiveMovie is required to play movies.");
	}

	// Query for IMediaControl, IMediaEvent, and IVideoWindow.
	m_pGraphBuilder->QueryInterface(IID_IMediaControl, (void **)&m_pMediaControl);
	m_pGraphBuilder->QueryInterface(IID_IMediaPosition, (void **)&m_pMediaPosition);
	m_pGraphBuilder->QueryInterface(IID_IVideoWindow, (void **)&m_pVideoWindow);
}

// Render a file.
void CVideo::renderFile(const std::string file)
{
	BSTR bstr = getString(file);
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

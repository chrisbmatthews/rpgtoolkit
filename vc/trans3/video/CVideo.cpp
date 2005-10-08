/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

#include "CVideo.h"
#include "../rpgcode/CProgram.h"
#include "../input/input.h"

// Constructor.
CVideo::CVideo()
{
	// Create a FilgraphManager object.
	IDispatch *pDispatch = NULL;

	// TBD: This CLSID is wrong. Find the right one.
	CLSID clsid = {0xE436EBB3, 0x524F, 0x11CE, {0x9F, 0x53, 0x00, 0x20, 0xAF, 0x0BA, 0x77, 0x00}};
	HRESULT res = CoCreateInstance(clsid, NULL, CLSCTX_INPROC_SERVER, IID_IDispatch, (void **)&pDispatch);

	if (FAILED(res))
	{
		throw CError("ActiveMovie is required to play movies.");
	}

	m_video = pDispatch;
	pDispatch->Release();

	// Hide the cursor.
	CComVariant hide(TRUE); // 'TRUE' -- not 'true'!
	m_video.Invoke1(L"HideCursor", &hide);

	// Set window style.
	CComVariant style(WS_CHILD | WS_CLIPSIBLINGS | WS_CLIPCHILDREN);
	m_video.PutPropertyByName(L"WindowStyle", &style);
}

// Render a file.
void CVideo::renderFile(const std::string file)
{
	CComVariant bstrFile(file.c_str());
	m_video.Invoke1(L"RenderFile", &bstrFile, NULL);
}

// Set the window.
void CVideo::setWindow(const HWND hwnd)
{
	CComVariant window(hwnd);
	m_video.PutPropertyByName(L"Owner", &window);
}

// Get the video's width.
int CVideo::getWidth()
{
	CComVariant ret;
	m_video.GetPropertyByName(L"Width", &ret);
	return ret.intVal;
}

// Get the video's height.
int CVideo::getHeight()
{
	CComVariant ret;
	m_video.GetPropertyByName(L"Height", &ret);
	return ret.intVal;
}

// Set the position of the video.
void CVideo::setPosition(const int x, const int y, const int width, const int height)
{
	CComVariant params[] = {x, y, width, height};
	m_video.InvokeN(L"SetWindowPosition", params, 4, NULL);
}

// Play the movie.
void CVideo::play()
{
	m_video.Invoke0(L"Run", NULL);
	while (true)
	{
		CComVariant pos, dur;
		m_video.GetPropertyByName(L"CurrentPosition", &pos);
		m_video.GetPropertyByName(L"Duration", &dur);
		if (pos.dblVal >= dur.dblVal)
		{
			// Movie has finished.
			break;
		}
		processEvent();
	}
	m_video.Invoke0(L"Stop", NULL);
}

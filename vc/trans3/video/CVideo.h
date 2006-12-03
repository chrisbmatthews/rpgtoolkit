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
 */

#ifndef _CVIDEO_H_
#define _CVIDEO_H_

#include "../../tkCommon/strings.h"

struct IGraphBuilder;
struct IMediaControl;
struct IMediaPosition;
struct IVideoWindow;

// A video.
class CVideo
{
public:
	CVideo();
	~CVideo();

	void renderFile(const STRING file);
	void play();
	int getWidth();
	int getHeight();
	void setWindow(const long hwnd);
	void setPosition(const int x, const int y, const int width, const int height);

private:
	CVideo(CVideo &);
	CVideo &operator=(CVideo);

	IGraphBuilder *m_pGraphBuilder;
	IMediaControl *m_pMediaControl;
	IMediaPosition *m_pMediaPosition;
	IVideoWindow *m_pVideoWindow;
};

#endif

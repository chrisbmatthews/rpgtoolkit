/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

#ifndef _CVIDEO_H_
#define _CVIDEO_H_

#include <string>
#include "../stdafx.h"

// A video.
class CVideo
{
public:
	CVideo();
	void renderFile(const std::string file);
	void play();
	int getWidth();
	int getHeight();
	void setWindow(const HWND hwnd);
	void setPosition(const int x, const int y, const int width, const int height);

private:
	CComDispatchDriver m_video;
};

#endif

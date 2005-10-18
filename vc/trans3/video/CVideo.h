/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

#ifndef _CVIDEO_H_
#define _CVIDEO_H_

#include "../../tkCommon/strings.h"

class IGraphBuilder;
class IMediaControl;
class IMediaPosition;
class IVideoWindow;

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

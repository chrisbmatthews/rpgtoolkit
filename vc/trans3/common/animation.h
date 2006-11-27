/*
 * All contents copyright 2003, 2004, 2005 Christopher Matthews or Contributors.
 * Various port optimizations copyright by Colin James Fitzpatrick, 2005.
 * All rights reserved. You may not remove this notice
 * Read license.txt for licensing details.
 */

#ifndef _ANIMATION_H_
#define _ANIMATION_H_

/*
 * Inclusions.
 */
#include "../../tkCommon/strings.h"
#include "../render/render.h"
#include "tilebitmap.h"
#include <string>
#include <vector>

/*
 * An animation.
 */
typedef struct tagAnimation
{
	STRING filename;					// Filename (no path).
	int pxWidth;						// Width.
	int pxHeight;						// Height.
	int frameCount;						// Total number of frames.
	std::vector<STRING> frameFiles;		// Filenames of each image in animation.
	std::vector<int> transpColors;		// Transparent color for frame.
	std::vector<STRING> sounds;			// Sounds for each frame.
	double delay;						// Pause length (sec) between each frame.

	bool open(const STRING fileName);
	void save(const STRING fileName) const;
	void loadFromGif(const STRING file);
	tagAnimation(): frameCount(0), pxWidth(1), pxHeight(1), delay(0) {}

} ANIMATION, *LPANIMATION;

/*
 * One frame of an animation.
 */
typedef struct tagAnimationFrame
{
	tagAnimationFrame(void): cnv(NULL) { }
	CCanvas *cnv;					// Canvas of frame.
	STRING file;					// Animation filename.
	int frame;							// Frame number.
	int maxFrames;						// Max frames in this anim.
	STRING strSound;				// Sound played on this frame.
} ANIMATION_FRAME;


void drawImage(const STRING strFile, const HDC hdc, const int x, const int y, const int width, const int height);

inline void drawImage(const STRING strFile, CCanvas *const cnv, const int x, const int y, const int width, const int height)
{
	const HDC hdc = cnv->OpenDC();
	drawImage(strFile, hdc, x, y, width, height);
	cnv->CloseDC(hdc);
}

#endif

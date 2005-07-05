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
#include "../render/render.h"
#include "tilebitmap.h"
#include <string>
#include <vector>

/*
 * An animation.
 */
typedef struct tagAnimation
{
	int animSizeX;						// Width.
	int animSizeY;						// Height.
	int animFrames;						// Total number of frames.
	std::vector<std::string> animFrame;	// Filenames of each image in animation.
	std::vector<int> animTransp;		// Transparent color for frame.
	std::vector<std::string> animSound;	// Sounds for each frame.
	double animPause;					// Pause length (sec) between each frame.
	short animGetTransp;				// Currently getting transparent color?
	int timerFrame;						// This number will be 0 to 29 to indicate how many times the timer has clicked.
	int currentAnmFrame;				// Currently animating frame.
	std::string animFile;				// Filename (no path).
	bool open(const std::string fileName);
	void save(const std::string fileName) const;
} ANIMATION, *LPANIMATION;

/*
 * One frame of an animation.
 */
typedef struct tagAnimationFrame
{
	tagAnimationFrame(void): cnv(NULL) { }
	CGDICanvas *cnv;					// Canvas of frame.
	std::string file;					// Animation filename.
	int frame;							// Frame number.
	int maxFrames;						// Max frames in this anim.
	std::string strSound;				// Sound played on this frame.
} ANIMATION_FRAME;

/*
 * Render "frame" of animation "file" at location "x,y" at canvas "cnv".
 * Checks through the animation cache for previous renderings of this frame,
 * if not found, it is rendered here and copied to the animation cache.
 */
bool renderAnimationFrame(CGDICanvas* cnv,
						  std::string file, 
						  int frame, 
						  const int x, 
						  const int y);

/*
 * Clear the animation cache.
 */
void clearAnmCache(void);

bool canvasMaskBltStretchTransparent(const CGDICanvas *cnvSource,
									  const CGDICanvas *cnvMask,
									  const int destX,
									  const int destY,
									  const int newWidth,
									  const int newHeight, 
									  const CGDICanvas *cnvTarget,
									  const int crTranspColor);

void drawImage(const std::string strFile, CGDICanvas *const cnv, const int x, const int y, const int width, const int height);

#endif

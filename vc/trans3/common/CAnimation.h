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

#ifndef _CANIMATION_H_
#define _CANIMATION_H_

/*
 * Includes
 */
#include "animation.h"
#include "paths.h"
#include <vector>
#include <set>
#include <map>

class CCanvas;

/*
 * Standalone animations.
 */
class CAnimation
{
public:
	CAnimation(const STRING file);
	~CAnimation() { freeCanvases(); }

	void animate(const int x, const int y);
	LPANIMATION data(void) { return &m_data; }
	CCanvas *getFrame(unsigned int frame);
	void playFrameSound(unsigned int frame) const;
	void render(void);
	void resize(const int width, const int height) 
	{ 
		if (width) m_data.pxWidth = abs(width);
		if (height) m_data.pxHeight = abs(height);
	}
	STRING filename(void) const { return m_data.filename; }

	friend class CSharedAnimation;

private:
	CAnimation(CAnimation &rhs);
	CAnimation &operator= (CAnimation &rhs);

	void addUser(void) { ++m_users; }
	int removeUser(void) { return --m_users; }
	void freeCanvases(void)
	{
		std::vector<CCanvas *>::iterator i = m_canvases.begin();
		for (; i != m_canvases.end(); ++i) { delete *i; *i = NULL; }
	}
	bool renderAnmFrame(CCanvas *cnv, unsigned int frame);
	bool renderFileFrame(CCanvas *cnv, unsigned int frame);
	bool (CAnimation::*renderFrame) (CCanvas *cnv, unsigned int frame);

	ANIMATION m_data;
	int m_users;

	std::vector<CCanvas *> m_canvases;

};

/*
 * Shared animation container.
 */
typedef std::map<STRING, CAnimation *> SHARED_ANIMATIONS;

class CSharedAnimation
{
public:
	CAnimation *m_pAnm;
	int m_frame;				// Callback counters, init -1 = hack.
	int m_tick;

		
	// Share an animation if it exists or create a new instance.
	static CSharedAnimation *insert(const STRING file);

	// Free a single user of an animation.
	static void free(CSharedAnimation *p)
	{
		std::set<CSharedAnimation *>::iterator i = m_anms.find(p);
		if (i != m_anms.end()) 
		{
			delete p;
			m_anms.erase(p);
		}
	}

	// Free all shared animations.
	static void freeAll(void);

	// Cast a pointer.
	static CSharedAnimation *cast(const int num)
	{
		CSharedAnimation *p = (CSharedAnimation *)num;
		std::set<CSharedAnimation *>::iterator i = m_anms.find(p);
		return (i != m_anms.end() ? p : NULL);
	}

	// Clear all shared animation canvases.
	static void freeAllCanvases(void)
	{
		SHARED_ANIMATIONS::iterator i = m_shared.begin();
		for (; i != m_shared.end(); ++i) i->second->freeCanvases(); 
	}

protected:
	CSharedAnimation(const STRING file);
	~CSharedAnimation();
	CSharedAnimation(CSharedAnimation &rhs);
	CSharedAnimation &operator= (CSharedAnimation &rhs);

	// Single, shared instances of CAnimations.
	static SHARED_ANIMATIONS m_shared;
	// Set of individual users of all CAnimations with frame counters (for Callbacks).
	static std::set<CSharedAnimation *> m_anms;
};

/*
 * Multitasking animation.
 */
class CThreadAnimation: private CSharedAnimation
{
public:
	CThreadAnimation(const STRING file, const int x, const int y, const bool bPersist); 
	~CThreadAnimation() { }

	static CThreadAnimation *create(const STRING file, const int x, const int y, const int width, const int height, const bool bPersist);
	static bool running(const STRING file, const int x, const int y);
	static void renderAll(CCanvas *cnv);
	static void destroy(CThreadAnimation *p);
	static void destroyAll(void)
	{
		std::set<CThreadAnimation *>::iterator i = m_threads.begin();
		for(; i != m_threads.end(); ++i) delete(*i);
	}

private:
	CThreadAnimation(CThreadAnimation &rhs);
	CThreadAnimation &operator= (CThreadAnimation &rhs);
	bool renderFrame(CCanvas *cnv);

	const int m_x, m_y;
	const bool m_persist;
	DWORD m_timer;

	static std::set<CThreadAnimation *> m_threads;
};

#endif

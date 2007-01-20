/*
 ********************************************************************
 * The RPG Toolkit, Version 3
 * This file copyright (C) 2007 Colin James Fitzpatrick
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

//--------------------------------------------------------------------------
// Animated tile routines
//--------------------------------------------------------------------------

//--------------------------------------------------------------------------
// Protect the header
//--------------------------------------------------------------------------
#ifndef _CTILEANIM_H_
#define _CTILEANIM_H_
#pragma once

//--------------------------------------------------------------------------
// Inclusions
//--------------------------------------------------------------------------
#define WIN32_MEAN_AND_LEAN			// Obtain lean version of windows
#include <windows.h>				// Windows headers
#include <string>					// String class

//--------------------------------------------------------------------------
// Definitions
//--------------------------------------------------------------------------
#if !defined(INLINE) && !defined(FAST_CALL)
#	if defined(_MSC_VER)
#		define INLINE __inline		// VC++ prefers the __inline keyword
#		define FAST_CALL __fastcall
#	else
#		define INLINE inline
#		define FAST_CALL			// Register (fast) calls are specific to VC++
#	endif
#endif
#if !defined(CNV_HANDLE)
typedef INT CNV_HANDLE;
#endif

//--------------------------------------------------------------------------
// Definition of an animated tile
//--------------------------------------------------------------------------
class CTileAnim
{

//
// Public visibility
//
public:

	// Construct an animated tile
	CTileAnim(
		CONST std::string strFileName
	);

	// Get the filename of a frame
	std::string frame(
		CONST UINT theFrame
			) CONST
	{
		// Return the frame
		return (m_frames && theFrame <= m_frameCount)
				? m_frames[theFrame - 1]
				: "";
	}

	// Deconstruct an animated tile
	~CTileAnim(
		VOID
	);

//
// Private visibility
//
private:

	UINT m_frameCount;		// Count of frames
	std::string *m_frames;	// Filenames of frames
	INT m_fps;				// FPS of animation

};

//--------------------------------------------------------------------------
// End of the header
//--------------------------------------------------------------------------
#endif

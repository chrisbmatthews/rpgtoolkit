//--------------------------------------------------------------------------
// All contents copyright 2004, Colin James Fitzpatrick
// All rights reserved. YOU MAY NOT REMOVE THIS NOTICE.
// Read LICENSE.txt for licensing info
//--------------------------------------------------------------------------

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

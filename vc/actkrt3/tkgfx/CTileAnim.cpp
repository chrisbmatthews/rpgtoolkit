//--------------------------------------------------------------------------
// All contents copyright 2004, Colin James Fitzpatrick
// All rights reserved. YOU MAY NOT REMOVE THIS NOTICE.
// Read LICENSE.txt for licensing info
//--------------------------------------------------------------------------

//--------------------------------------------------------------------------
// Animated tile routines
//--------------------------------------------------------------------------

//--------------------------------------------------------------------------
// Inclusions
//--------------------------------------------------------------------------
#include "CTileAnim.h"					// Stuff for this file
#include "../../tkCommon/tkGfx/CUtil.h"						// Utility functions

//--------------------------------------------------------------------------
// Definitions
//--------------------------------------------------------------------------
#if !defined(STATIC)
#	define STATIC static
#endif

//--------------------------------------------------------------------------
// Construct an animated tile
//--------------------------------------------------------------------------
CTileAnim::CTileAnim(
	CONST std::string strFileName
		)
{

	// Initialize members
	m_frameCount = 0;
	m_frames = NULL;
	m_fps = 0;

	// Open the file
	OFSTRUCT ofs;
	CONST HFILE hFile = OpenFile(strFileName.c_str(), &ofs, OF_READ);
	if (!hFile) return;

	// Read the header
	OVERLAPPED ptr = {0, 0, 0, 0, NULL};
	CONST std::string strHeader = util::binReadString(hFile, &ptr);

	// If the file is valid
	if (strHeader.compare("RPGTLKIT TILEANIM") == 0)
	{

		// Skip the versions (they're unused)
		DWORD read;
		ptr.Offset += 4;

		// Read the fps
		ReadFile(HANDLE(hFile), &m_fps, sizeof(m_fps), &read, &ptr);
		ptr.Offset += 4;

		// Read the quantity of frames
		ReadFile(HANDLE(hFile), &m_frameCount, sizeof(m_frameCount), &read, &ptr);
		ptr.Offset += 4;

		if (m_frameCount)
		{

			// Allocate memory
			m_frames = new std::string[m_frameCount];

			// Read the frames
			for (INT i = 0; i < m_frameCount; i++)
			{
				// Save the frame
				m_frames[i] = util::binReadString(hFile, &ptr);
			}

		}

	}

	// Close the file
	CloseHandle(HANDLE(hFile));

}

//--------------------------------------------------------------------------
// Deconstruct an animated tile
//--------------------------------------------------------------------------
CTileAnim::~CTileAnim(VOID)
{

	// If we have frames saved
	if (m_frames)
	{

		// Free the frames
		delete [] m_frames;

	}

}

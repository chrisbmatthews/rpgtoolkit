/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

#ifndef _CAUDIO_SEGMENT_H_
#define _CAUDIO_SEGMENT_H_

#define WIN32_LEAN_AND_MEAN
#include <windows.h>
typedef DWORD *DWORD_PTR;
#include <dmusici.h>
#include <string>
#include "audiere.h"

class CAudioSegment
{
public:
	static void initLoader(void);
	static void freeLoader(void);
	CAudioSegment(void) { init(); }
	CAudioSegment(const std::string file);
	~CAudioSegment(void);
	bool open(const std::string file);
	void play(const bool repeat);
	void stop(void);

private:
	CAudioSegment(const CAudioSegment &rhs);			// No implementation.
	CAudioSegment &operator=(const CAudioSegment &rhs); // No implementation.
	void init(void);

	static IDirectMusicLoader8 *m_pLoader;
	IDirectMusicPerformance8 *m_pPerformance;
	IDirectMusicSegment8 *m_pSegment;
	audiere::AudioDevicePtr m_device;
	audiere::OutputStreamPtr m_outputStream;
	bool m_audiere;
	std::string m_file;
	bool m_playing;
};

#endif

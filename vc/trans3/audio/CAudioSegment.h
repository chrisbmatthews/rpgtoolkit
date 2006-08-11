/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

#ifndef _CAUDIO_SEGMENT_H_
#define _CAUDIO_SEGMENT_H_

#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <dmusici.h>
#include <set>
#include "audiere.h"
#include "../../tkCommon/strings.h"

class CAudioSegment
{
public:
	static void initLoader();
	static void freeLoader();
	CAudioSegment() { init(); }
	CAudioSegment(const STRING file);
	~CAudioSegment();
	bool open(const STRING file);
	void play(const bool repeat);
	static void playSoundEffect(const STRING file, const bool waitToFinish);
	static void stopSoundEffect();
	static void setMasterVolume(int percent);
	void stop();

	STRING getPlayingFile() const { return m_file; }

protected:
	CAudioSegment(const CAudioSegment &rhs);			// No implementation.
	CAudioSegment &operator=(const CAudioSegment &rhs); // No implementation.
	void init();
	bool isPlaying();
	void setVolume(const int percent);
	static DWORD WINAPI eventManager(LPVOID lpv);

	static IDirectMusicLoader8 *m_pLoader;
	static HANDLE m_notify;
	IDirectMusicPerformance8 *m_pPerformance;
	IDirectMusicSegment8 *m_pSegment;
	audiere::AudioDevicePtr m_device;
	audiere::OutputStreamPtr m_outputStream;
	bool m_audiere;
	STRING m_file;
};

#endif

/*
 ********************************************************************
 * The RPG Toolkit, Version 3
 * This file copyright (C) 2006  Colin James Fitzpatrick
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

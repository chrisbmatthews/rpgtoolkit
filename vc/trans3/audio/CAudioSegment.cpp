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

#include "CAudioSegment.h"
#include "../common/paths.h"
#include "../rpgcode/parser/parser.h"
#include "../common/mbox.h"

static CAudioSegment *g_pSoundEffect = NULL;

/*
 * Construct and load a file.
 */
CAudioSegment::CAudioSegment(const STRING file)
{
	init();
	open(file);
}

/*
 * Open a file.
 */
bool CAudioSegment::open(const STRING file)
{
	extern STRING g_projectPath;

	if (_strcmpi(file.c_str(), m_file.c_str()) == 0)
	{
		// Already playing this file.
		return false;
	}
	stop();
	
	// Load the audio file stream.
	extern STRING g_projectPath;

	std::string path = getAsciiString(resolve(g_projectPath + MEDIA_PATH + file));
	std::string ext = parser::uppercase(getExtension(file));
	if(path.compare(ext)) {
		if(m_midiDevice) 
		{
			if(m_midiStream = m_midiDevice->openStream(path.c_str())) 
			{
				m_file = file;
				return true;
			}
			return false;
		}
	}
	else if (m_outputStream = audiere::OpenSound(m_device, path.c_str(), true))
	{
		m_file = file;
		return true;
	}
	m_file = _T("");
	return false;
}

/*
 * Play this segment.
 */
void CAudioSegment::play(const bool repeat)
{
	if (isPlaying()) return;
	if (m_outputStream)
	{
		m_outputStream->setRepeat(repeat);
		m_outputStream->play();
	}
	else if (m_midiStream) 
	{
		m_midiStream->setRepeat(repeat);
		m_midiStream->play();
	}
}

/*
 * Stop this segment.
 */
void CAudioSegment::stop()
{
	if (m_outputStream)
	{
		m_outputStream->stop();
		m_outputStream->reset();
	}
	else if (m_midiStream)
	{
		m_midiStream->stop();
		m_midiStream->setPosition(0);
	}
}

/*
 * Determine whether the segment is currently playing.
 */
bool CAudioSegment::isPlaying()
{
	if(m_outputStream) {
		return m_outputStream->isPlaying();
	} else if(m_midiStream) {
		return m_midiStream->isPlaying();
	}
	return false;
}

/*
 * Initialize this audio segment.
 */
void CAudioSegment::init()
{
	// Set up Audiere.
	m_device = audiere::OpenDevice();
	m_midiDevice = audiere::OpenMIDIDevice(NULL);
}

/*
 * Play a sound effect, optionally idling until it is finished.
 */
void CAudioSegment::playSoundEffect(const STRING file, const bool waitToFinish)
{
	// Crappy -- but anything better will take a while
	// to implement, and I'd like to have some form
	// of sound effects done.

	// Try to avoid an infinite loop if the effect isn't loaded,
	// but allow the same effect to be played repeatedly.
	if (!g_pSoundEffect->open(file) && _strcmpi(file.c_str(), g_pSoundEffect->m_file.c_str()) != 0) return;
	g_pSoundEffect->play(false);

}

/*
 * Stop a sound effect.
 */
void CAudioSegment::stopSoundEffect()
{	
	g_pSoundEffect->stop(); 
}

/*
 * Set the volumes of all performances.
 */
void CAudioSegment::setMasterVolume(int percent)
{
	extern CAudioSegment *g_bkgMusic;
	percent = percent < 0 ? 0 : (percent > 100 ? 100 : percent);
	g_bkgMusic->setVolume(percent);
	g_pSoundEffect->setVolume(percent);
}

/*
 * Set the volume of a performance.
 * Cannot set volume of MIDI performances.
 */
void CAudioSegment::setVolume(const int percent)
{
	// Volume is a float between 0.0 and 1.0.
	if (m_outputStream) m_outputStream->setVolume(percent / 100.0);
	
}

/*
 * Initialize the DirectMusic loader.
 */
void CAudioSegment::initLoader()
{
	extern STRING g_projectPath;

	// Initialise after CoCreateInstance().
	g_pSoundEffect = new CAudioSegment();
}

/*
 * Free the DirectMusic loader.
 */
void CAudioSegment::freeLoader()
{
	delete g_pSoundEffect;
}

/*
 * Deconstructor.
 */
CAudioSegment::~CAudioSegment()
{
	stop();
}

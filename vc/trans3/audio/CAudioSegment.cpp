/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

#include "CAudioSegment.h"
#include "../common/paths.h"
#include "../rpgcode/parser/parser.h"

IDirectMusicLoader8 *CAudioSegment::m_pLoader = NULL;

/*
 * Construct and load a file.
 */
CAudioSegment::CAudioSegment(const std::string file)
{
	init();
	open(file);
}

/*
 * Open a file.
 */
bool CAudioSegment::open(const std::string file)
{
	if (_strcmpi(file.c_str(), m_file.c_str()) == 0)
	{
		// Already playing this file.
		return false;
	}
	stop();
	const std::string ext = parser::uppercase(getExtension(file));
	if (ext == "MID" || ext == "MIDI" || ext == "RMI" || ext == "MPL" || ext == "WAV")
	{
		if (m_pSegment)
		{
			m_pSegment->Unload(m_pPerformance);
			m_pSegment->Release();
		}
		m_audiere = false;
		WCHAR wstrFile[MAX_PATH + 1];
		MultiByteToWideChar(CP_ACP, 0, file.c_str(), -1, wstrFile, MAX_PATH);
		if (SUCCEEDED(m_pLoader->LoadObjectFromFile(CLSID_DirectMusicSegment, IID_IDirectMusicSegment8, wstrFile, (void **)&m_pSegment)))
		{
			m_pSegment->Download(m_pPerformance);
			m_file = file;
			return true;
		}
		m_pSegment = NULL;
		m_file = "";
		return false;
	}
	m_audiere = true;
	extern std::string g_projectPath;
	if (m_outputStream = audiere::OpenSound(m_device, (g_projectPath + MEDIA_PATH + file).c_str(), true))
	{
		m_file = file;
		return true;
	}
	m_file = "";
	return false;
}

/*
 * Play this segment.
 */
void CAudioSegment::play(const bool repeat)
{
	if (m_playing) return;
	if (m_audiere)
	{
		if (m_outputStream)
		{
			m_outputStream->setRepeat(repeat);
			m_outputStream->play();
			m_playing = true;
		}
	}
	else
	{
		if (m_pSegment)
		{
			m_pSegment->SetRepeats(repeat ? DMUS_SEG_REPEAT_INFINITE : 0);
			m_pPerformance->PlaySegmentEx(m_pSegment, NULL, NULL, 0, 0, NULL /* (segment state) */, NULL, NULL);
			m_playing = true;
		}
	}
}

/*
 * Stop this segment.
 */
void CAudioSegment::stop()
{
	if (m_audiere)
	{
		if (m_outputStream)
		{
			m_outputStream->stop();
			m_outputStream->reset();
		}
	}
	else
	{
		m_pPerformance->Stop(NULL, NULL, 0, 0);
	}
	m_playing = false;
}

/*
 * Initialize this audio segment.
 */
void CAudioSegment::init()
{
	// Set up DirectMusic.
	CoCreateInstance(CLSID_DirectMusicPerformance, NULL, CLSCTX_INPROC, IID_IDirectMusicPerformance8, (void **)&m_pPerformance);
	extern HWND g_hHostWnd;
	m_pPerformance->InitAudio(NULL, NULL, g_hHostWnd, DMUS_APATH_SHARED_STEREOPLUSREVERB, 64, DMUS_AUDIOF_ALL, NULL);
	m_pSegment = NULL;
	m_audiere = false;
	m_playing = false;
	// Set up Audiere.
	m_device = audiere::OpenDevice();
}

/*
 * Initialize the DirectMusic loader.
 */
void CAudioSegment::initLoader()
{
	if (m_pLoader) return;
	CoCreateInstance(CLSID_DirectMusicLoader, NULL, CLSCTX_INPROC, IID_IDirectMusicLoader8, (void **)&m_pLoader);
	WCHAR searchPath[MAX_PATH + 1];
	extern std::string g_projectPath;
	MultiByteToWideChar(CP_ACP, 0, (g_projectPath + MEDIA_PATH).c_str(), -1, searchPath, MAX_PATH);
	m_pLoader->SetSearchDirectory(GUID_DirectMusicAllTypes, searchPath, FALSE);
}

/*
 * Free the DirectMusic loader.
 */
void CAudioSegment::freeLoader()
{
	if (!m_pLoader) return;
	m_pLoader->Release();
	m_pLoader = NULL;
}

/*
 * Deconstructor.
 */
CAudioSegment::~CAudioSegment()
{
	stop();
	if (m_pSegment) m_pSegment->Unload(m_pPerformance);
	m_pPerformance->Release();
	if (m_pSegment) m_pSegment->Release();
}

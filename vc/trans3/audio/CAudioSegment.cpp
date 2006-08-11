/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

#include "CAudioSegment.h"
#include "../common/paths.h"
#include "../rpgcode/parser/parser.h"

IDirectMusicLoader8 *CAudioSegment::m_pLoader = NULL;
HANDLE CAudioSegment::m_notify = NULL;
static CAudioSegment *g_pSoundEffect = NULL;
static bool g_bDirectMusic = false;

/*
 * Construct and load a file.
 */
CAudioSegment::CAudioSegment(const STRING file)
{
	init();
	open(file);
}

#include "../common/mbox.h"

/*
 * Open a file.
 */
bool CAudioSegment::open(const STRING file)
{
	if (_strcmpi(file.c_str(), m_file.c_str()) == 0)
	{
		// Already playing this file.
		return false;
	}
	stop();
	const STRING ext = parser::uppercase(getExtension(file));
	if (g_bDirectMusic &&
			(ext == _T("MID")) || (ext == _T("MIDI")) || (ext == _T("RMI")) || (ext == _T("MPL")) || (ext == _T("WAV")))
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
		m_file = _T("");
		return false;
	}
	m_audiere = true;
	extern STRING g_projectPath;
	if (m_outputStream = audiere::OpenSound(m_device, getAsciiString(resolve(g_projectPath + MEDIA_PATH + file)).c_str(), true))
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
	if (m_audiere)
	{
		if (m_outputStream)
		{
			m_outputStream->setRepeat(repeat);
			m_outputStream->play();
		}
	}
	else
	{
		if (m_pSegment)
		{
			m_pSegment->SetRepeats(repeat ? DMUS_SEG_REPEAT_INFINITE : 0);
			m_pPerformance->PlaySegmentEx(m_pSegment, NULL, NULL, 0, 0, NULL /* (segment state) */, NULL, NULL);
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
		if (m_pPerformance) m_pPerformance->Stop(NULL, NULL, 0, 0);
	}
}

/*
 * Determine whether the segment is currently playing.
 */
bool CAudioSegment::isPlaying()
{
	if (m_audiere)
	{
		if (m_outputStream) return m_outputStream->isPlaying();
	}
	else
	{
		if (m_pPerformance) return (m_pPerformance->IsPlaying(m_pSegment, NULL) == S_OK);
	}
}

/*
 * Initialize this audio segment.
 */
void CAudioSegment::init()
{
	// Set up DirectMusic.
	if (g_bDirectMusic)
	{
		CoCreateInstance(CLSID_DirectMusicPerformance, NULL, CLSCTX_INPROC, IID_IDirectMusicPerformance8, (void **)&m_pPerformance);
		extern HWND g_hHostWnd;
		m_pPerformance->InitAudio(NULL, NULL, g_hHostWnd, DMUS_APATH_SHARED_STEREOPLUSREVERB, 64, DMUS_AUDIOF_ALL, NULL);
	}
	else
	{
		m_pPerformance = NULL;
	}

	m_pSegment = NULL;
	m_audiere = false;
	// Set up Audiere.
	m_device = audiere::OpenDevice();
}

/*
 * Event manager.
 * Used only for sound effects.
 */
DWORD WINAPI CAudioSegment::eventManager(LPVOID lpv)
{
	CAudioSegment *pAudioSegment = (CAudioSegment *)lpv;
	IDirectMusicPerformance8 *pPerf = pAudioSegment->m_pPerformance;
	DMUS_NOTIFICATION_PMSG *pMsg = NULL;

	while (m_notify)
	{
		WaitForSingleObject(m_notify, 100);
		while (pPerf->GetNotificationPMsg(&pMsg) == S_OK)
		{
			if (pMsg->guidNotificationType == GUID_NOTIFICATION_SEGMENT)
			{
				// Segment notification.
				// Check if it's a sound effect finishing playback.
				if (pMsg->dwNotificationOption == DMUS_NOTIFICATION_SEGEND)
				{
					// Delete the sound effect.
					pPerf->FreePMsg((DMUS_PMSG *)pMsg);
					delete pAudioSegment;
					return S_OK;
				}
			}
			pPerf->FreePMsg((DMUS_PMSG *)pMsg);
		}
	}

	return S_OK;
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

#if 0
	CAudioSegment *pSeg = new CAudioSegment();
	if (!pSeg->open(file))
	{
		delete pSeg;
		return;
	}

	if (pSeg->m_pPerformance)
	{
		pSeg->m_pPerformance->SetNotificationHandle(m_notify, 0);
		pSeg->m_pPerformance->AddNotificationType(GUID_NOTIFICATION_SEGMENT);
		DWORD id = 0;
		HANDLE hThread = CreateThread(NULL, 0, eventManager, pSeg, 0, &id);
		CloseHandle(hThread);
	}
	else
	{
		// Audiere events?
		// Delete for now.
		delete pSeg;
		return; // Temp!
	}

	pSeg->play(false);
#endif

	if (waitToFinish)
	{
		extern void processEvent();
		// Idle until the sound effect's event comes up.
		while (!g_pSoundEffect->isPlaying()) processEvent();
		// Idle until the sound effect ends.
		while (g_pSoundEffect->isPlaying()) processEvent();
	}

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
 */
void CAudioSegment::setVolume(const int percent)
{
	if (m_audiere)
	{
		// Volume is a float between 0.0 and 1.0.
		if (m_outputStream) m_outputStream->setVolume(percent / 100.0);
	}
	else
	{
		// MasterVolume is a value in 1/100ths of a decibel ranging
		// between -100dB and +10dB (-30dB is quiet enough, though).
		// Note this is not really a linear relationship!
		long db = (percent - 100) * 30;
		if (m_pPerformance) m_pPerformance->SetGlobalParam(GUID_PerfMasterVolume, (void *)&db, sizeof(db));
	}
}

/*
 * Initialize the DirectMusic loader.
 */
void CAudioSegment::initLoader()
{
	extern STRING g_projectPath;

	// Not loader related, but I don't feel like making another function.
	m_notify = CreateEvent(NULL, FALSE, FALSE, NULL);

	// Loader related stuff starts now.
	if (m_pLoader) return;
	CoCreateInstance(CLSID_DirectMusicLoader, NULL, CLSCTX_INPROC, IID_IDirectMusicLoader8, (void **)&m_pLoader);

	if (!m_pLoader)
	{
		messageBox(_T("We were unable to initialise the DirectMusic 8 music loader.\n\nThe game will attempt to run without DirectMusic 8, but it may not be able to play all music and sound effects successfully. Please make sure that you have the latest version of DirectX and then try again."));
		return;
	}

	g_bDirectMusic = true;

#ifndef _UNICODE
	WCHAR searchPath[MAX_PATH + 1];
	MultiByteToWideChar(CP_ACP, 0, resolve(g_projectPath + MEDIA_PATH).c_str(), -1, searchPath, MAX_PATH);
	m_pLoader->SetSearchDirectory(GUID_DirectMusicAllTypes, searchPath, FALSE);
#else
	m_pLoader->SetSearchDirectory(GUID_DirectMusicAllTypes, resolve(g_projectPath + MEDIA_PATH).c_str(), FALSE);
#endif

	// Initialise after CoCreateInstance().
	g_pSoundEffect = new CAudioSegment();
}

/*
 * Free the DirectMusic loader.
 */
void CAudioSegment::freeLoader()
{
	if (m_pLoader)
	{
		m_pLoader->Release();
		m_pLoader = NULL;
	}
	delete g_pSoundEffect;
}

/*
 * Deconstructor.
 */
CAudioSegment::~CAudioSegment()
{
	stop();
	if (m_pSegment) m_pSegment->Unload(m_pPerformance);
	if (m_pPerformance) m_pPerformance->Release();
	if (m_pSegment) m_pSegment->Release();
}

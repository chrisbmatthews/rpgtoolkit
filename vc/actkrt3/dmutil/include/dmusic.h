/*
Module : dmusic.h
Purpose: Defines the header implementation for the CMidiMusic class
Created: CJP / 17-02-2001
History: CJP / 21-10-2001 
	
	1. Fixed problems related to midi files and others formats

	2. Fixed bugs with MIDI port selection

	3. Fixed many problems discovered with the demo aplication

Copyright (c) 2001 by C. Jiménez de Parga  
All rights reserved.
*/

#ifndef DMUSIC_H
#define DMUSIC_H

// Some required DX headers
#include <dmusicc.h>
#include <dmusici.h>
#include <dmksctrl.h>

// Macro definition for COM object releases
#define SAFE_RELEASE(p)      {if(p) {(p)->Release(); (p)=NULL;}}

// Some useful constants
#define MIN_VOLUME_RANGE DMUS_VOLUME_MIN
#define MAX_VOLUME_RANGE DMUS_VOLUME_MAX
#define MIN_MASTER_TEMPO DMUS_MASTERTEMPO_MIN
#define MAX_MASTER_TEMPO DMUS_MASTERTEMPO_MAX
#define DEFAULT_MASTER_TEMPO 1
#define SET_REVERB 0x1
#define SET_CHORUS 0x2

// Infoport structure
typedef struct INFOPORT {
   char szPortDescription[DMUS_MAX_DESCRIPTION*2];
   DWORD dwFlags;
   DWORD dwClass;
   DWORD dwType;
   DWORD dwMaxAudioChannels;
   DWORD dwMaxVoices;
   DWORD dwMaxChannelGroups ;
   DWORD dwEffectFlags;
   GUID guidSynthGUID;
} *LPINFOPORT;



// The definition of the class

class CMidiMusic
{
private:
	BOOL					   m_b3DPosition;			//Indicates when we are using 3D mode
protected:
	IDirectMusic*			   m_pMusic;				//Main DirectMusic COM interfaces
	IDirectMusic8*			   m_pMusic8;
	IDirectMusicLoader8*       m_pLoader;
	IDirectMusicPerformance8*  m_pPerformance;
	IDirectMusicSegment8*      m_pSegment;
	IDirectMusicPort8*		   m_pMusicPort;		
	IDirectMusicSegmentState*  m_pSegmentState;
	IDirectMusicSegmentState8* m_pSegmentState8;
	IDirectMusicAudioPath8*    m_p3DAudioPath;
	IDirectSound3DBuffer8*	   m_pDSB;
public:
    CMidiMusic();										// The constructor and the destructor of the class
    ~CMidiMusic();
    
	HRESULT Initialize(BOOL b3DPosition);				// Public member functions
	HRESULT PortEnumeration(DWORD dwIndex,LPINFOPORT lpInfoPort);
	HRESULT SelectPort(LPINFOPORT InfoPort);
	HRESULT LoadMidiFromFile(LPCSTR szMidi,BOOL bMidiFile);
    HRESULT LoadMidiFromResource(TCHAR *strResource,TCHAR *strResourceType,BOOL bMidiFile);
	HRESULT Play(); 
	HRESULT Pause();
	HRESULT Resume();
    HRESULT IsPlaying();
    HRESULT SetRepeat(BOOL bRepeat);
	HRESULT Stop();
	HRESULT GetLength(MUSIC_TIME *mtMusicTime); 
	HRESULT GetSeek(MUSIC_TIME *mtMusicTime);
	HRESULT Seek(MUSIC_TIME mtMusicTime);
	HRESULT GetTicks(MUSIC_TIME *mtMusicTime);
	HRESULT GetReferenceTime(REFERENCE_TIME *rtReferenceTime);
    HRESULT SetPosition(D3DVALUE x,D3DVALUE y,D3DVALUE z);
	HRESULT GetPosition(D3DVALUE *x,D3DVALUE *y,D3DVALUE *z);
	HRESULT SetVelocity(D3DVALUE x,D3DVALUE y,D3DVALUE z);
	HRESULT SetMode(DWORD dwMode);
	HRESULT SetMaxDistance(D3DVALUE flMaxDistance);
	HRESULT SetMinDistance(D3DVALUE flMinDistance);
	HRESULT SetConeOrientation(D3DVALUE x,D3DVALUE y,D3DVALUE z);
	HRESULT GetConeOrientation(D3DVALUE *x,D3DVALUE *y,D3DVALUE *z);
	HRESULT SetConeAngles(DWORD dwInsideConeAngle,DWORD dwOutsideConeAngle);
	HRESULT GetConeAngles(LPDWORD dwInsideConeAngle,LPDWORD dwOutsideConeAngle);
	HRESULT SetConeOutsideVolume(LONG lConeOutsideVolume);
	HRESULT GetConeOutsideVolume(LPLONG plConeOutsideVolume);
	HRESULT SetMasterVolume(long nVolume);
	HRESULT SetMasterTempo(float fTempo);
	HRESULT SetEffect(BOOL bActivate,int nEffect);
};


#endif												// End of class definition
//All contents copyright 2003, Christopher Matthews
//All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
//Read LICENSE.txt for licensing info

//RPG Toolkit Audiere interface
//Christopher Matthews, Nov 2003

#ifndef TKAUDIERE_H
#define TKAUDIERE_H

#include <string>
#include <list>
#include "audiere.h"
#include <windows.h>
using namespace audiere;

#define AUDIERE_HANDLE long

typedef struct _tagAudiereSound
{
	AudioDevicePtr device;
	OutputStreamPtr stream;
} AUDIERE_SOUND;

void APIENTRY TKAudiereInit();

void APIENTRY TKAudiereKill();

int APIENTRY TKAudierePlay( AUDIERE_HANDLE handle, char* p_strFile, int nStream, int nAutoRepeat );

int APIENTRY TKAudiereIsPlaying( AUDIERE_HANDLE handle );

void APIENTRY TKAudiereStop( AUDIERE_HANDLE handle );

void APIENTRY TKAudiereRestart( AUDIERE_HANDLE handle );

void APIENTRY TKAudiereDestroyHandle( AUDIERE_HANDLE handle );

AUDIERE_HANDLE APIENTRY TKAudiereCreateHandle();

int APIENTRY TKAudiereGetPosition( AUDIERE_HANDLE handle );

void APIENTRY TKAudiereSetPosition( AUDIERE_HANDLE handle, int nPosition );



#endif
/*
 ********************************************************************
 * The RPG Toolkit, Version 3
 * This file copyright (C) 2007 Christopher Matthews & contributors
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
//All contents copyright 2003, Christopher Matthews
//All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
//Read LICENSE.txt for licensing info

//RPG Toolkit Audiere interface
//Christopher Matthews, Nov 2003

#include "TKAudiere.h"


std::list<AUDIERE_SOUND*> g_AudioDevices;


////////////////////////////
// Init music engine
void APIENTRY TKAudiereInit()
{
	g_AudioDevices.clear();
}



////////////////////////////
// Kill music engine
void APIENTRY TKAudiereKill()
{
	std::list<AUDIERE_SOUND*>::iterator itr = g_AudioDevices.begin();
	for (; itr != g_AudioDevices.end(); itr++)
	{
		AUDIERE_SOUND* sound = ( AUDIERE_SOUND* ) ( *itr );
		sound->stream->stop();
		sound->stream = 0;
		sound->device = 0;
	}

	g_AudioDevices.clear();
}


////////////////////////////
// Play a sound
// strFile - Filename ot play
// nStream - If 1, this loads it as a stream ( bkg music )
// nAutoRepeat - If 1, the sound will repeat automatically
// returns 1 on success, 0 otherwise
int APIENTRY TKAudierePlay( AUDIERE_HANDLE handle, char* p_strFile, int nStream, int nAutoRepeat )
{
	int nRet = 0;

	if ( handle != 0 )
	{
		AUDIERE_SOUND* sound = ( AUDIERE_SOUND* ) handle;

		if ( sound->device )
		{
			//attempt to stop any playing sounds...
			TKAudiereStop( handle );

			OutputStreamPtr stream( OpenSound( sound->device, p_strFile, ( bool ) nStream ) );
			if ( stream )
			{
				sound->stream = stream;
				stream->setRepeat( ( bool ) nAutoRepeat );
				stream->play();
				nRet = 1;
			}
		}
	}

	return nRet;
}


////////////////////////////
// Determine if a sound is playing
// hanlde - The hanlde of the sound
int APIENTRY TKAudiereIsPlaying( AUDIERE_HANDLE handle )
{
	int nRet = 0;

	if ( handle != 0 )
	{
		AUDIERE_SOUND* sound = ( AUDIERE_SOUND* ) handle;

		if ( sound->stream )
		{
			if ( sound->stream->isPlaying() )
			{
				nRet = 1;
			}
		}
	}

	return nRet;
}


////////////////////////////
// Stop a sound
// handle - The handle of the sound
void APIENTRY TKAudiereStop( AUDIERE_HANDLE handle )
{
	if ( handle != 0 )
	{
		AUDIERE_SOUND* sound = ( AUDIERE_SOUND* ) handle;

		if ( sound->stream )
		{
			sound->stream->stop();
			sound->stream->reset();
		}
	}
}


////////////////////////////
// Re-start a sound
// handle - The handle of the sound
void APIENTRY TKAudiereRestart( AUDIERE_HANDLE handle )
{
	if ( handle != 0 )
	{
		AUDIERE_SOUND* sound = ( AUDIERE_SOUND* ) handle;

		if ( sound->stream )
		{
			sound->stream->stop();
			sound->stream->reset();
			sound->stream->play();
		}
	}
}


////////////////////////////
// Destory a handle
// handle - The handle of the sound
void APIENTRY TKAudiereDestroyHandle( AUDIERE_HANDLE handle )
{
	if ( handle != 0 )
	{
		AUDIERE_SOUND* sound = ( AUDIERE_SOUND* ) handle;

		if ( sound->stream )
		{
			sound->stream->stop();
			sound->stream->reset();
			sound->stream->play();
		}

		sound->stream = 0;
		sound->device = 0;

		g_AudioDevices.remove( sound );
	}
}


////////////////////////////
// Destory a handle
// handle - The handle of the sound
AUDIERE_HANDLE APIENTRY TKAudiereCreateHandle()
{
	AUDIERE_SOUND* sound = new AUDIERE_SOUND;

	//get audio device...
	AudioDevicePtr device( OpenDevice() );

	if ( !device )
	{
		return 0;
	}

	sound->device = device;
	sound->stream = 0;

	//save in list...
	g_AudioDevices.push_back( sound );
	return ( AUDIERE_HANDLE ) sound;
}


////////////////////////////
// Get position of a handle
// handle - The handle of the sound
// Returns a vlue between 0 and 100
int APIENTRY TKAudiereGetPosition( AUDIERE_HANDLE handle )
{
	if ( handle != 0 )
	{
		AUDIERE_SOUND* sound = ( AUDIERE_SOUND* ) handle;

		if ( sound->stream )
		{
			if ( sound->stream->isSeekable() )
			{
				return ( int ) ( 100.0 * sound->stream->getPosition() / sound->stream->getLength() );
			}
		}
	}

	return 0;
}


////////////////////////////
// Get position of a handle
// handle - The handle of the sound
void APIENTRY TKAudiereSetPosition( AUDIERE_HANDLE handle, int nPosition )
{
	if ( handle != 0 )
	{
		AUDIERE_SOUND* sound = ( AUDIERE_SOUND* ) handle;

		if ( sound->stream )
		{
			if ( sound->stream->isSeekable() )
			{
				int nPos = ( int ) ( nPosition * sound->stream->getLength() / 100.0 );
				sound->stream->setPosition( nPos );
			}
		}
	}
}
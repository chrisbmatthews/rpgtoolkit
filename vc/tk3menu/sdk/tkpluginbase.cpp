/*
 ********************************************************************
 * The RPG Toolkit Version 3 Plugin Libraries
 * This file copyright (C) 2003-2007  Christopher B. Matthews
 ********************************************************************
 *
 * This file is released under the AC Open License v 1.0
 * See "AC Open License.txt" for details
 */

/*
 * To ensure the plugin works, do not modify this file.
 */

//////////////////////////////////////////
// INCLUDES
//#include "resource.h"					// main symbols
#include "stdafx.h"

#include <string>
#include <vector>
#include <queue>

#include "tkplugcallbacks.h"	//callback functions
#include "tkplugin.h"

extern std::string g_strDescription;
extern long lPluginCaps;

//////////////////////////////////////////
// GLOBALS
std::vector<long> g_lCallbacks;		//vector of visual basic function addresses (callbacks)
int g_nNumCallbacks;			//number of elements in the above array.

std::queue<FIGHT_EVENT> g_qEvents;	//queue of fight events...
std::queue<INPUT_EVENT> g_qInputEvents;	//queue of input events...

bool g_bAcceptKBEvents = false;	//does this plugin accept keyboard events?
bool g_bAcceptMouseEvents = false;	//does this plugin accept mouse events?

//////////////////////////////////////////
// EXPORTED SYSTEM FUNCTIONS

///////////////////////////////////////////////////////
//
// Function: TKPlugVersion
//
// Parameters: none
//
// Action: return version number of the plugin SDK used
//				to create this plugin
//
// Returns: long number (30 = version 3.0, 31 = version 3.1, etc)
//
///////////////////////////////////////////////////////
long APIENTRY TKPlugVersion()
{
	//this plugin was created using version 3.0 of the SDK
	return PLUGVERSION;
}


///////////////////////////////////////////////////////
//
// Function: TKPlugDescription
//
// Parameters: pstrReturnBuffer - pointer to a string buffer to hold
//							the description
//						 nBufferSize - size of the return buffer
//
// Action: returns length of the description, in bytes.
//				Fills buffer with a description of this plugin
//
// Returns: length of ddescriptionm in bytes
//
///////////////////////////////////////////////////////
int APIENTRY TKPlugDescription(char* pstrReturnBuffer, int nBufferSize)
{
	std::string strDescription = g_strDescription;
	if (strDescription.length() > nBufferSize)
	{
		strDescription = strDescription.substr(0, nBufferSize-1);
	}
	strcpy(pstrReturnBuffer, strDescription.c_str());
	return strDescription.length();
}


///////////////////////////////////////////////////////
//
// Function: TKPlugType
//
// Parameters: nRequestedFeature - requested plugin type
//
// Action: called by the Toolkit to determine the capabilities
//				of this plugin.
//
// Returns: 1 - feature supported in this plugin
//					0 - feature unsupported in this plugin
//
///////////////////////////////////////////////////////
int APIENTRY TKPlugType(int nRequestedFeature)
{
	//if different features are supported or not.
	int nRet = 0;
	
	if (nRequestedFeature == PT_RPGCODE)
	{
		if (lPluginCaps & PT_RPGCODE)
			nRet = 1;
	}

	if (nRequestedFeature == PT_MENU)
	{
		if (lPluginCaps & PT_MENU)
			nRet = 1;
	}

	if (nRequestedFeature == PT_FIGHT)
	{
		if (lPluginCaps & PT_FIGHT)
			nRet = 1;
	}

	return nRet;
}



///////////////////////////////////////////////////////
//
// Function: TKPlugInit
//
// Parameters: pCBArray- pointer to array of callbacks
//											(addresses of those callbacks)
//						 nCallbacks- no of callbacks in array.
//
// Action: init plugin
//
// Returns: 1 (TRUE)
//
///////////////////////////////////////////////////////
int APIENTRY TKPlugInit(long *pCBArray, int nCallbacks)
{
	//copy callback array into our global callback array.
	g_lCallbacks.clear();
	g_nNumCallbacks = nCallbacks;
	for (int i=0; i< nCallbacks; i++)
	{
		g_lCallbacks.push_back(pCBArray[i]);
	}
	return 1;
}


///////////////////////////////////////////////////////
//
// Function: TKPlugFightInform
//
// Parameters: nSourcePartyIndex - party the source is in
//						 nSourceFighterIndex - fighter that was the source
//						 nTargetPartyIndex - party the target is in
//						 nTargetFighterIndex - fighter that was targeted
//						 nSourceHP - HP lost by source
//						 nSourceSMP - SMP lost by source
//						 nTargetHP - HP lost by target
//						 nTargetSMP - SMP lost by target
//						 pstrMessage - option string message sent
//						 nCode - indicates what this is informing us of (from INFORM_* defines)
//
// Action: This function is called to inform the plugin that am action has occurred.
//			You shouldn't adjust the stats of the target -- when this function has been
//			called, the Toolkit has already done it for you.  This function
//			is intended to allow *you* to display the results of the stat modification
//			(for instance, showing a player getting hit).
//
// Returns: 1 all's well
//
///////////////////////////////////////////////////////
int APIENTRY TKPlugFightInform(int nSourcePartyIndex, int nSourceFighterIndex, int nTargetPartyIndex, int nTargetFighterIndex, int nSourceHP, int nSourceSMP, int nTargetHP, int nTargetSMP, char* pstrMessage, int nCode)
{
	//add the event to the list of events...
	FIGHT_EVENT fe;
	fe.source.nPartyIdx = nSourcePartyIndex;
	fe.source.nFighterIdx = nSourceFighterIndex;
	fe.target.nPartyIdx = nTargetPartyIndex;
	fe.target.nFighterIdx = nTargetFighterIndex;
	fe.nSourceHP = nSourceHP;
	fe.nSourceSMP = nSourceSMP;
	fe.nTargetHP = nTargetHP;
	fe.nTargetSMP = nTargetSMP;
	fe.strMessage = pstrMessage;
	fe.nCode = nCode;
	g_qEvents.push( fe );
	return 1;
}

///////////////////////////////////////////////////////
//
// Function: TKPlugEventInform
//
// Parameters: nKeyCode - keyboard code pressed
//						 nX, nY - x and y coords of mouse
//						 nButton - mouse button pressed
//						 nShift - shift - tells you if a control key was held down when the event occurred
//						 pstrKey - key that was pressed represented as a string
//						 nCode - indicates what this is informing us of (from INPUT_* defines)
//
// Action: This function is called to inform the plugin that an action has occurred.
//
// Returns: 1 all's well
//
///////////////////////////////////////////////////////
int APIENTRY TKPlugEventInform(int nKeyCode, int nX, int nY, int nButton, int nShift, char* pstrKey, int nCode)
{
	//add the event to the list of events...
	INPUT_EVENT ie;
	ie.nButton = nButton;
	ie.nCode = nCode;
	ie.nKeyCode = nKeyCode;
	ie.nShift = nShift;
	ie.nX = nX;
	ie.nY = nY;
	ie.strKey = pstrKey;
	g_qInputEvents.push( ie );
	return 1;
}


///////////////////////////////////////////////////////
//
// Function: TKPlugInputRequested
//
// Parameters: nCode - indicates what this is informing us of (from INPUT_* defines)
//
// Action: This function is called to determine if the plugin has requested
//				a specific type of input event
//
// Returns: 1 - yes, 0 - no
//
///////////////////////////////////////////////////////
int APIENTRY TKPlugInputRequested( int nCode )
{
	int nRet = 0;
	if ( nCode == INPUT_KB && g_bAcceptKBEvents )
		nRet = 1;
	if ( nCode == INPUT_MOUSEDOWN && g_bAcceptMouseEvents )
		nRet = 1;
	return nRet;
}

///////////////////////////////////////////////////////
//
// Function: GetNextFightEvent
//
// Parameters: event - a pointer to the fight event that will be 
//									modified.
//
// Action: Call this function to get the next fight event from the queue
//			(for managed mode battles).
//
// Returns: true - a new event was found
//					false - no new events found.
//
///////////////////////////////////////////////////////
bool GetNextFightEvent(FIGHT_EVENT* event)
{
	if ( g_qEvents.size() > 0 ) 
	{
		*event = g_qEvents.front();
		//now remove the event at the head of the list...
		g_qEvents.pop();
		return true;
	}
	else 
	{
		return false;
	}
}

///////////////////////////////////////////////////////
//
// Function: FlushFightEvents
//
// Parameters: 
//
// Action: Clear the event queue
//
// Returns: void
//
///////////////////////////////////////////////////////
void FlushFightEvents()
{
	while ( g_qEvents.size() > 0 ) 
	{
		g_qEvents.pop();
	}
}

///////////////////////////////////////////////////////
//
// Function: RequestInputNotification
//
// Parameters: nCode - the input event code you want to receive (INPUT_KB, etc)
//
// Action: Tells trans3 that you would like to receive notification
//				of keyboard or mouse events.
//
// Returns: void
//
///////////////////////////////////////////////////////
void RequestInputNotification(int nCode)
{
	if ( nCode == INPUT_KB )
		g_bAcceptKBEvents = true;
	if ( nCode == INPUT_MOUSEDOWN )
		g_bAcceptMouseEvents = true;
}

///////////////////////////////////////////////////////
//
// Function: CancelInputNotification
//
// Parameters: nCode - the input event code you want to cancel (INPUT_KB, etc)
//
// Action: Tells trans3 that you don't want to receive notification
//				of keyboard or mouse events.
//
// Returns: void
//
///////////////////////////////////////////////////////
void CancelInputNotification(int nCode)
{
	if ( nCode == INPUT_KB )
		g_bAcceptKBEvents = false;
	if ( nCode == INPUT_MOUSEDOWN )
		g_bAcceptMouseEvents = false;
}

///////////////////////////////////////////////////////
//
// Function: GetNextInputEvent
//
// Parameters: event - a pointer to the input event that will be 
//									modified.
//
// Action: Call this function to get the next input event from the queue
//
// Returns: true - a new event was found
//					false - no new events found.
//
///////////////////////////////////////////////////////
bool GetNextInputEvent(INPUT_EVENT* event)
{
	if ( g_qInputEvents.size() > 0 ) 
	{
		*event = g_qInputEvents.front();
		//now remove the event at the head of the list...
		g_qInputEvents.pop();
		return true;
	}
	else 
	{
		return false;
	}
}

///////////////////////////////////////////////////////
//
// Function: FlushInputEvents
//
// Parameters: 
//
// Action: Clear the event queue
//
// Returns: void
//
///////////////////////////////////////////////////////
void FlushInputEvents()
{
	while ( g_qInputEvents.size() > 0 ) 
	{
		g_qInputEvents.pop();
	}
}

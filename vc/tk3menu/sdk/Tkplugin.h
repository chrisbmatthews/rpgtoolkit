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
#include "tkplugcallbacks.h"

//////////////////////////////////////////
// DEFINES
#define PLUGVERSION	30		//version of plugin SDK

#define PT_RPGCODE	1			//plugin type rpgcode
#define PT_MENU			2			//plugin type menu
#define PT_FIGHT		4			//plugin type battle system

#define MNU_MAIN		1			//main menu requested
#define MNU_INVENTORY	2		//inventory menu requested
#define MNU_EQUIP		4			//equip menu requested
#define MNU_ABILITIES	8		//abilities menu requested

//////////////////////////////////////////
// DESCRIPTION
#define PLUGIN_DESCRIPTION std::string g_strDescription 
#define PLUGIN_TYPE long lPluginCaps

#ifndef TKPLUGIN_H
#define TKPLUGIN_H

/******FIGHT INFORM CODES*******/
//For use with GetNextFightEvent
#define INFORM_REMOVE_HP			0		//HP was removed
#define INFORM_REMOVE_SMP			1		//SMP was removed
#define INFORM_SOURCE_ATTACK	2		//Source fighter attacks
#define INFORM_SOURCE_SMP			3		//Source fighter performs special move
#define INFORM_SOURCE_ITEM		4		//Source fighter uses item
#define INFORM_SOURCE_CHARGED	5		//Source fighter has reached their charge time
#define INFORM_SOURCE_DEAD		6		//Source fighter has died
#define INFORM_SOURCE_PARTY_DEFEATED	7		//Source party is all dead

//Fight event -- returned from GetNextFightEvent
//nCode is the event code (INFORM_****) as defined above
typedef struct _tagFighter
{
	int nPartyIdx;	//party fighter belongs to
	int nFighterIdx;	//index of fighter
} FIGHTER;

typedef struct _tagFightEvent
{
	int nCode;
	FIGHTER source;	//source fighter
	FIGHTER target;	//target fighter
	int nSourceHP;	//source HP lost
	int nSourceSMP;	//source SMP lost
	int nTargetHP;	//target HP lost
	int nTargetSMP;	//target SMP lost
	std::string strMessage;	//a message (usually a filename)
} FIGHT_EVENT;


/******INPUT INFORM CODES*******/
//For use with GetNextInputEvent
#define INPUT_KB				0		//Keyboard pressed event
#define INPUT_MOUSEDOWN	1		//Mouse pressed event

//Input event -- returned from GetNextInputEvent
//nCode is the event code as defined above
typedef struct _tagInputEvent
{
	int nCode;
	int nKeyCode;	//keyboard code pressed
	int nX, nY;		//x and y coords of mouse
	int nButton;	//mouse button pressed
	int nShift;		//shift - tells you if a control key was held down when the event occurrent
	std::string strKey;	//key that was pressed represented as a string
} INPUT_EVENT;

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
long APIENTRY TKPlugVersion();

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
int APIENTRY TKPlugDescription(char* pstrReturnBuffer, int nBufferSize);

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
int APIENTRY TKPlugType(int nRequestedFeature);


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
int APIENTRY TKPlugInit(long *pCBArray, int nCallbacks);

///////////////////////////////////////////////////////
//
// Function: TKPlugFightInform
//
// Parameters: nSourcePartyIndex - party the source is in
//						 nSourceFighterIndex - fighter that was the source
//						 nTargetPartyIndex - party the target is in
//						 nTargetFighterIndex - fighter that was targeted
//						 nAmount - amount to remove (if negatice, then it's to be added)
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
int APIENTRY TKPlugFightInform(int nSourcePartyIndex, int nSourceFighterIndex, int nTargetPartyIndex, int nTargetFighterIndex, int nAmount, int nCode);

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
bool GetNextFightEvent(FIGHT_EVENT* event);

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
void FlushFightEvents();

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
void RequestInputNotification(int nCode);

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
void CancelInputNotification(int nCode);

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
bool GetNextInputEvent(INPUT_EVENT* event);

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
void FlushInputEvents();

#endif
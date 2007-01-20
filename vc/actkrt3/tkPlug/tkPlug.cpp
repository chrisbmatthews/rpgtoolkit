/*
 ********************************************************************
 * The RPG Toolkit, Version 3
 * This file copyright (C) 2007  Christopher Matthews & contributors
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

/*
 * Includes
 */

#include "..\stdafx.h"

#include "plugDLL.h"

#include <vector>

//global-- plugin array...
std::vector<PlugDLL*> g_vPluginList;	//list of all loaded plugins
std::vector<long> g_vCallbacks;	//vector of visual basic function addresses (callbacks)


//Get a pointer to a plugin.
//load as required.
PlugDLL* GetPlugin(std::string strFilename)
{
	PlugDLL* pThePlugin = NULL;

	std::vector<PlugDLL*>::iterator itr = g_vPluginList.begin();	
	for(; itr != g_vPluginList.end(); itr++)
	{
		PlugDLL* p = (*itr);
		if (p->GetFilename().compare(strFilename) == 0)
		{
			//found it!
			pThePlugin = p;
			break;
		}
	}
	if (!pThePlugin)
	{
		//plugin must be loaded...
		pThePlugin = new PlugDLL(strFilename);
		g_vPluginList.push_back(pThePlugin);
	}

	return pThePlugin;
}

//////////////////////////////////////////
// EXPORTED SYSTEM FUNCTIONS

///////////////////////////////////////////////////////
//
// Function: PLUGInitSystem
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
int APIENTRY PLUGInitSystem(long *pCBArray, int nCallbacks)
{
	//copy callback array into our global callback array.
	g_vCallbacks.clear();
	for (int i=0; i< nCallbacks; i++)
	{
		g_vCallbacks.push_back(pCBArray[i]);
	}
	return 1;
}


//shutdown plugin system
//unload loaded plugins...
int APIENTRY PLUGShutdownSystem()
{
	std::vector<PlugDLL*>::iterator itr = g_vPluginList.begin();	
	for(; itr != g_vPluginList.end(); itr++)
	{
		PlugDLL* p = (*itr);
		delete p;

		(*itr)=NULL;
	}	
	g_vPluginList.clear();
	return 1;
}


///////////////////////////////////////////////////////
//
// Function: PLUGBegin
//
// Parameters: pstrFilename - plugin to begin
//
// Action: called to begin a plugin
//
// Returns: 
//
///////////////////////////////////////////////////////
void APIENTRY PLUGBegin(char* pstrFilename)
{
	//check if plugin is already loaded...
	PlugDLL* pThePlugin = GetPlugin(pstrFilename);

	if (pThePlugin)
	{
		long* plCB = new long[g_vCallbacks.size()];
		if (plCB)
		{
			int idx = 0;
			std::vector<long>::iterator itr = g_vCallbacks.begin();	
			for(; itr != g_vCallbacks.end(); itr++)
			{
				plCB[idx] = (*itr);
				idx++;
			}

			if (pThePlugin->DllTKPlugVersion() == 20)
			{
				pThePlugin->DllTKPlugInit(plCB, 45);
			}
			else
			{
				pThePlugin->DllTKPlugInit(plCB, idx);
			}
			pThePlugin->DllTKPlugBegin();
			
			delete [] plCB;
		}
	}
}


///////////////////////////////////////////////////////
//
// Function: PLUGQuery
//
// Parameters: pstrFilename - plugin pstrQuery - string passed in.
//
// Action: passes in an rpgcode command name.
//				this function is supposed to indicate
//				if it does or does not support this command
//				NOTE: passed in command will include the
//				'#' at the beginning!
//
// Returns: 1 (if we can support the command)
//					0 (if we cannot support the command)
//
///////////////////////////////////////////////////////
int APIENTRY PLUGQuery(char* pstrFilename, char* pstrQuery)
{
	PlugDLL* pThePlugin = GetPlugin(pstrFilename);

	return pThePlugin->DllTKPlugQuery(pstrQuery);
}


///////////////////////////////////////////////////////
//
// Function: PLUGExecute
//
// Parameters: pstrFilename - plugin pstrCommand - command to execute
//
// Action: passes in an rpgcode command.
//				it is up to the plugin to execute
//				this command.
//
// Returns: 1 (command executed OK)
//					0 (error executing command)
//
///////////////////////////////////////////////////////
int APIENTRY PLUGExecute(char* pstrFilename, char* pstrCommand)
{
	PlugDLL* pThePlugin = GetPlugin(pstrFilename);

	return pThePlugin->DllTKPlugExecute(pstrCommand);
}


///////////////////////////////////////////////////////
//
// Function: PLUGEnd
//
// Parameters: pstrFilename - plugin
//
// Action: called when the Toolkit unloads
//				the plugin.  Allows you to
//				perform deallocations
//
// Returns: 
//
///////////////////////////////////////////////////////
void APIENTRY PLUGEnd(char* pstrFilename)
{
	PlugDLL* pThePlugin = GetPlugin(pstrFilename);
	pThePlugin->DllTKPlugEnd();
}


///////////////////////////////////////////////////////
//
// Function: PLUGVersion
//
// Parameters: pstrFilename - plugin
//
// Action: obtain version number of plugin api
//
// Returns: version number 20=2.0, 30=3.0
//
///////////////////////////////////////////////////////
long APIENTRY PLUGVersion(char* pstrFilename)
{
	PlugDLL* pThePlugin = GetPlugin(pstrFilename);
	return pThePlugin->DllTKPlugVersion();
}


///////////////////////////////////////////////////////
//
// Function: PLUGDescription
//
// Parameters: pstrFilename - the plugin
//						 pstrReturnBuffer - pointer to a string buffer to hold
//							the description
//						 nBufferSize - size of the return buffer
//
// Action: returns length of the description, in bytes.
//				Fills buffer with a description of this plugin
//
// Returns: length of ddescription in bytes
//
///////////////////////////////////////////////////////
int APIENTRY PLUGDescription(char* pstrFilename, char* pstrReturnBuffer, int nBufferSize)
{
	PlugDLL* pThePlugin = GetPlugin(pstrFilename);
	if (pThePlugin)
	{
		std::string strDescription = pThePlugin->DllTKPlugDescription();
		if (strDescription.length() > nBufferSize)
		{
			strDescription = strDescription.substr(0, nBufferSize-1);
		}
		strcpy(pstrReturnBuffer, strDescription.c_str());
		return strDescription.length();
	}
	return 0;
}


///////////////////////////////////////////////////////
//
// Function: PLUGType
//
// Parameters: pstrFilename - the plugin
//						 pstrRequestedFeature
//
// Action: returns capabilities of plugin
//
// Returns: 1 - feature supported, 0 - not supported
//
///////////////////////////////////////////////////////
int APIENTRY PLUGType(char* pstrFilename, int nRequestedFeature)
{
	PlugDLL* pThePlugin = GetPlugin(pstrFilename);
	return pThePlugin->DllTKPlugType(nRequestedFeature);
}


///////////////////////////////////////////////////////
//
// Function: PLUGMenu
//
// Parameters: pstrFilename - the plugin
//						 nRequestedMenu - menu requested
//
// Action: returns capabilities of plugin
//
// Returns: 1 - feature supported, 0 - not supported
//
///////////////////////////////////////////////////////
int APIENTRY PLUGMenu(char* pstrFilename, int nRequestedMenu)
{
	PlugDLL* pThePlugin = GetPlugin(pstrFilename);
	return pThePlugin->DllTKPlugMenu(nRequestedMenu);
}


///////////////////////////////////////////////////////
//
// Function: PLUGFight
//
// Parameters: pstrFilename - the plugin
//
// Action: launch fight
//
// Returns: 1 - players won, 0 - game over
//
///////////////////////////////////////////////////////
int APIENTRY PLUGFight(char* pstrFilename, int nEnemyCount, int nSkillLevel, char* pstrBackground, int nCanRun)
{
	PlugDLL* pThePlugin = GetPlugin(pstrFilename);
	return pThePlugin->DllTKPlugFight(nEnemyCount, nSkillLevel, pstrBackground, nCanRun);
}


///////////////////////////////////////////////////////
//
// Function: PLUGFightInformAttack
//
// Parameters: pstrFilename - the plugin
//
// Action: inform fight plugin of an attack
//
// Returns: 1 - all clear
//
///////////////////////////////////////////////////////
int APIENTRY PLUGFightInform(char* pstrFilename, int nSourcePartyIndex, int nSourceFighterIndex, int nTargetPartyIndex, int nTargetFighterIndex, int nSourceHP, int nSourceSMP, int nTargetHP, int nTargetSMP, char* pstrMessage, int nCode)
{
	PlugDLL* pThePlugin = GetPlugin(pstrFilename);
	return pThePlugin->DllTKPlugFightInform(nSourcePartyIndex, nSourceFighterIndex, nTargetPartyIndex, nTargetFighterIndex, nSourceHP, nSourceSMP, nTargetHP, nTargetSMP, pstrMessage, nCode);
}


///////////////////////////////////////////////////////
//
// Function: PLUGInputRequested
//
// Parameters: pstrFilename - the plugin
//						nCode - the input code we're asking about
//
// Action: determine if the plugin is requesting
//			any input (mouse or keyboard)
//
// Returns: 0 - no, 1- yes
//
///////////////////////////////////////////////////////
int APIENTRY PLUGInputRequested( char* pstrFilename, int nCode )
{
	PlugDLL* pThePlugin = GetPlugin(pstrFilename);
	return pThePlugin->DllTKPlugInputRequested(nCode);
}

///////////////////////////////////////////////////////
//
// Function: PLUGEventInform
//
// Parameters: pstrFilename - the plugin
//						 nKeyCode - keyboard code pressed
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
int APIENTRY PLUGEventInform(char* pstrFilename, int nKeyCode, int nX, int nY, int nButton, int nShift, char* pstrKey, int nCode)
{
	PlugDLL* pThePlugin = GetPlugin(pstrFilename);
	return pThePlugin->DllTKPlugEventInform(nKeyCode, nX, nY, nButton, nShift, pstrKey, nCode);
}
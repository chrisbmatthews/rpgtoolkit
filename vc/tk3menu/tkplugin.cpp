////////////////////////////////////////////////////////////////
//
// YOU SHOULD MODIFY THIS FILE!!!!
//
////////////////////////////////////////////////////////////////
//
// RPG Toolkit Development System, Version 3
// Plugin Libraries
// Developed by Christopher B. Matthews (Copyright 2003)
//
// This file is released under the AC Open License v 1.0
// See "AC Open License.txt"
//
////////////////////////////////////////////////////////////////
//
// File:					tkplugin.cpp
// Includes:			tkplugin.h
//								stdafx.h
// Description:		This file defines a few required exported 
//								functions.  You should edit these functions
//								to cause your plugin to actually do something
//								useful.
//
////////////////////////////////////////////////////////////////

/*
 * Includes
 */

#include "stdafx.h"
#include "sdk\tkplugin.h"
#include <string>

#include "menu.h"

//you can provide a one-line description of this plugin here:
PLUGIN_DESCRIPTION = "Full featured menu system for TK3";
//here is where you declare the capabilities of the plugin.
PLUGIN_TYPE = PT_MENU;


/*********************************************************************/
///////////////////////////////////////////////////////
// GENERAL INTERFACE
//
// For *all* plugins, you must modify:
// TKPlugBegin
// TKPlugEnd
///////////////////////////////////////////////////////

///////////////////////////////////////////////////////
//
// Function: TKPlugBegin
//
// Parameters: 
//
// Action: called when the Toolkit first
//				sets up the plugin.  Allows you to
//				perform initialisations
//
// Returns: 
//
///////////////////////////////////////////////////////
void APIENTRY TKPlugBegin()
{
	//TBD: Add startup code here.
	BeginMenu();
}



///////////////////////////////////////////////////////
//
// Function: TKPlugEnd
//
// Parameters: 
//
// Action: called when the Toolkit unloads
//				the plugin.  Allows you to
//				perform deallocations
//
// Returns: 
//
///////////////////////////////////////////////////////
void APIENTRY TKPlugEnd()
{
	//TBD: Add finishing code here.
	EndMenu();
}
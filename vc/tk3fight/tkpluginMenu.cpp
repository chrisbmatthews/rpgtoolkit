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
// File:					tkpluginMenu.cpp
// Includes:			tkplugin.h
//								stdafx.h
// Description:		This file defines a few required exported 
//								functions if the plugin will define a new Menu.
//								You should edit these functions
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



/*********************************************************************/
///////////////////////////////////////////////////////
// MENU SYSTEM INTERFACE
//
// If this is a Menu plugin, you must modify
// TKPlugMenu
///////////////////////////////////////////////////////

///////////////////////////////////////////////////////
//
// Function: TKPlugMenu
//
// Parameters: nRequestedMenu - the menu requested
//
// Action: This function is called when a menu request
//				is generated.  This function should display
//				and run the appropriate menu
//
// Returns: 1 (success)
//					0 (failure - requested menu not supported)
//
///////////////////////////////////////////////////////
int APIENTRY TKPlugMenu(int nRequestedMenu)
{
	//TBD: Add menu code here.
	
	switch(nRequestedMenu)
	{
		case MNU_MAIN:
			break;

		case MNU_INVENTORY:
			break;

		case MNU_EQUIP:
			break;

		case MNU_ABILITIES:
			break;
	}

	return 0;
}


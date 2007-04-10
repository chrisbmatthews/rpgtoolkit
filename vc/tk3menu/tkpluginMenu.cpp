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
 * Includes
 */

#include "stdafx.h"
#include "sdk\tkplugin.h"
#include <string>

#include "menu.h"

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
	//declare that I want keyboard input...
	RequestInputNotification( INPUT_KB );
	FlushInputEvents();
	
	int nPlayerID;
	switch(nRequestedMenu)
	{
		case MNU_MAIN:
			MainMenu();
			CancelInputNotification( INPUT_KB );
			return 1;
			break;

		case MNU_INVENTORY:
			ItemMenu();
			CancelInputNotification( INPUT_KB );
			return 1;
			break;

		case MNU_EQUIP:
			nPlayerID = SelectPlayer(true);
			EquipMenu(nPlayerID);
			CancelInputNotification( INPUT_KB );
			return 1;
			break;

		case MNU_ABILITIES:
			nPlayerID = SelectPlayer(true);
			AbilitiesMenu(nPlayerID);
			CancelInputNotification( INPUT_KB );
			return 1;
			break;
	}

	CancelInputNotification( INPUT_KB );
	return 0;
}


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


/*********************************************************************/
///////////////////////////////////////////////////////
// RPGCODE INTERFACE
//
// If this is an RPGCode plugin, you must modify
// TKPlugQuery
// TKPlugExecute
///////////////////////////////////////////////////////

///////////////////////////////////////////////////////
//
// Function: TKPlugQuery
//
// Parameters: pstrQuery - string passed in.
//
// Action: passes in an rpgcode command name.
//				this function is supposed to indicate
//				if it does or does not support this command
//
// Returns: 1 (if we can support the command)
//					0 (if we cannot support the command)
//
///////////////////////////////////////////////////////
int APIENTRY TKPlugQuery(char* pstrQuery)
{
	//TBD: Add query code here.
	return 0;
}


///////////////////////////////////////////////////////
//
// Function: TKPlugExecute
//
// Parameters: pstrCommand - command to execute
//
// Action: passes in an rpgcode command.
//				it is up to the plugin to execute
//				this command.
//
// Returns: 1 (command executed OK)
//					0 (error executing command)
//
///////////////////////////////////////////////////////
int APIENTRY TKPlugExecute(char* pstrCommand)
{
	//TBD: Add execution code here.
	return 1;
}



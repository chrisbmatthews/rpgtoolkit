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
//								functions if the plugin will define a new battle system.
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
// FIGHT SYSTEM INTERFACE
//
// If this is a battle system plugin, you must modify
// TKPlugFight
///////////////////////////////////////////////////////

///////////////////////////////////////////////////////
//
// Function: TKPlugFight
//
// Parameters: nEnemyCount - number of enemies to fight
//						 nSkillLevel - skill level of fight
//						 pstrBackground - background file to fight on
//						 nCanRun - can the players run from this fight? ( 0 = no )
//
// Action: This function is caled to begin a fight.
//				It assumes that the Toolkit has already loaded
//				the required enemies (you can access enemy info
//				using the CBGetEnemy* functions).
//				 If the fight was launched based upon 'skill', then
//				nSkillLevel reports the skill level (if negative, then
//				you can assume the fight was lauched without considering
//				skill levels).
//				 The plugin is reposible for rewarding the players at the end
//				of the fight (giving experience and level ups).
//
// Returns: One of the FIGHT_* defines as found in tkplugdefines.h
//
///////////////////////////////////////////////////////
int APIENTRY TKPlugFight(int nEnemyCount, int nSkillLevel, char* pstrBackground, int nCanRun)
{
	//TBD: Add battle system code here.
	return 1;	//players won!
}


////////////////////////////////////////////////////////////////
//
// RPG Toolkit Development System, Version 3
// Fight System
// Developed by Christopher B. Matthews (Copyright 2003)
//
// This file is released under the AC Open License Derivative v 1.0
// See "AC Open License Derivative.txt"
//
////////////////////////////////////////////////////////////////
//////////////////////////////
// Fight.cpp - fighting system

#include "stdafx.h"
#include "fight.h"

#include <queue>
#include <time.h>

CNVID g_cnvBkg = 0;		//canvas the background image is on
CNVID g_cnvMenu = 0;	//canvas the menu and stats are on
CNVID g_cnvPlayerProfiles[5];	//player profile canvases
int g_nSizeX, g_nSizeY;		//size of canvas
long g_crTranspColor = 0;	//transparent color
long g_crTextColor = rgb(255, 240, 230);	//text color to use

int g_nEnemyCount = 0;	//number of enemies
bool g_bCanRun;		//can run from enemy?

SPRITE g_PlayerSprite[5];	//player sprites
SPRITE g_EnemySprite[4];	//enemy sprites

std::queue<FIGHTER> g_qCharged;	//queue of fighters who are charged...

//info for the current player who is doing their move...
bool g_bPlayerMoving = false;	//is any player currently showing a menu?

LAST_MENU g_LastMenu;		//last menu drawn
int g_nMenu = MENU_MAIN;		//current menu
int g_nMenuPos = 0;	//current menu position
int g_nTopMenu = 0;	//top index of menu
int g_nItemsPerList;	//max entries per list in menu
bool g_bHideMenu = false;	//should menu be hidden?

int g_nSpecialMoveCount;	//count of special moves in list
std::string g_abilitiesList[500];	//list of special moves


FIGHTER g_CurrentFighter;	//the current fighter moving...
int g_nPartyWon = -1;			//which party has won

//init fighting system
void BeginSystem()
{
	srand( (unsigned)time( NULL ) );

	//get transparent color...
	g_crTranspColor = CBGetGeneralNum(GEN_TRANSPARENTCOLOR, 0, 0);

	//get screen size...
	g_nSizeX = CBGetGeneralNum( GEN_RESX, 0, 0 );
	g_nSizeY = CBGetGeneralNum( GEN_RESY, 0, 0 );
	g_cnvBkg = CBCreateCanvas( g_nSizeX, g_nSizeY );

	g_cnvMenu = CBCreateCanvas( 170, 180 );

	for ( int i = 0; i < 5; i++ ) 
	{
		g_cnvPlayerProfiles[i] = CBCreateCanvas(75, 75);
	}
}


//shutdown fighting system
void EndSystem()
{
	if ( g_cnvBkg )
	{
		CBDestroyCanvas( g_cnvBkg );
		g_cnvBkg = 0;
	}
	if ( g_cnvMenu )
	{
		CBDestroyCanvas( g_cnvMenu );
		g_cnvMenu = 0;
	}

	for ( int i = 0; i < 5; i++ ) 
	{
		if ( g_cnvPlayerProfiles[i] ) 
		{
			CBDestroyCanvas( g_cnvPlayerProfiles[i] );
			g_cnvPlayerProfiles[i] = 0;
		}
	}
}


//begin fighting...
int BeginFight( int nEnemyCount, int nSkillLevel, std::string strBackground, bool bCanRun )
{
	int nRet = FIGHT_WON_AUTO;
	g_nPartyWon = -1;

	//declare that I want keyboard input...
	RequestInputNotification( INPUT_KB );

	g_nEnemyCount = nEnemyCount;
	g_bCanRun = bCanRun;

	//clear old fight events
	FlushFightEvents();
	g_nMenu = MENU_MAIN;		//current menu
	g_nMenuPos = 0;	//current menu position
	g_bPlayerMoving = false;
	g_bHideMenu = false;

	for ( int i = 0; i < 5; i++ ) 
	{
		std::string strProfile = CBGetPlayerString(PLAYER_PROFILE, 0, i);
		CBCanvasFill(g_cnvPlayerProfiles[i], g_crTranspColor);
		CBCanvasLoadSizedImage(g_cnvPlayerProfiles[i], strProfile);
	}

	//load fight background...
	CBCanvasDrawBackground( g_cnvBkg, strBackground, 0, 0, g_nSizeX, g_nSizeY );

	//load animations...
	CreateSprites();

	//show scene...
	bool bDone = false;
	while( !bDone )
	{
		renderNow();
		CBFightTick();
		if ( !g_bPlayerMoving ) 
		{
			//no one is doing any moves...
			//so let's see if another player is charged...
			if ( NextFighter( &g_CurrentFighter ) ) 
			{
				g_bPlayerMoving = true;
				FlushInputEvents();
			}
		}
		int nResult = ScanKeys();
		if ( nResult == 1 )
		{
			//players ran...
			nRet = FIGHT_RUN_AUTO;
			bDone = true;

		}
		//check for end of fight...
		if ( g_nPartyWon == PLAYER_PARTY )
		{
			nRet = FIGHT_WON_AUTO;
			bDone = true;
		}
		if ( g_nPartyWon == ENEMY_PARTY )
		{
			nRet = FIGHT_LOST;
			bDone = true;
		}

		if (CBCheckKey("Q"))
		{
			bDone = true;
		}
	}

	//destroy the sprites...
	DestroySprites();

	CancelInputNotification( INPUT_KB );

	return nRet;	//players won
}


//scan kets for main menu...
int MainMenuScanKeys()
{
	INPUT_EVENT ie;
	ie.strKey = "";
	GetNextInputEvent( &ie );

	if ( ie.strKey.compare("UP") == 0 || CBCheckKey("JOYUP") )
	{
		g_nMenuPos--;
		if ( g_nMenuPos < 0 )
		{
			if ( CBGetPlayerNum( PLAYER_DOES_SM, 0, g_CurrentFighter.nFighterIdx ) && g_bCanRun ) 
			{
				g_nMenuPos = 3;
			}
			else if ( !CBGetPlayerNum( PLAYER_DOES_SM, 0, g_CurrentFighter.nFighterIdx ) && g_bCanRun ) 
			{
				g_nMenuPos = 1;
			} 
			else
			{
				g_nMenuPos = 1;
			}
		}
		CBPlaySound(CBGetGeneralString(GEN_CURSOR_MOVESOUND, 0, 0));
		Sleep(90);
	}
	else if ( ie.strKey.compare("DOWN") == 0 || CBCheckKey("JOYDOWN") )
	{
		g_nMenuPos++;
		if ( CBGetPlayerNum( PLAYER_DOES_SM, 0, g_CurrentFighter.nFighterIdx ) && g_bCanRun ) 
		{
			if ( g_nMenuPos > 3 ) 
			{
				g_nMenuPos = 0;
			}
		}
		else if ( !CBGetPlayerNum( PLAYER_DOES_SM, 0, g_CurrentFighter.nFighterIdx ) && g_bCanRun )
		{
			if ( g_nMenuPos > 2 ) 
			{
				g_nMenuPos = 0;
			}
		}
		else
		{
			if ( g_nMenuPos > 1 ) 
			{
				g_nMenuPos = 0;
			}
		}
		CBPlaySound(CBGetGeneralString(GEN_CURSOR_MOVESOUND, 0, 0));
		Sleep(90);
	}
	else if ( ie.strKey.compare("ENTER") == 0 || CBCheckKey("ENTER") || CBCheckKey("BUTTON1") ) 
	{
		CBPlaySound(CBGetGeneralString(GEN_CURSOR_SELSOUND, 0, 0));
		FIGHTER f;
		f.nPartyIdx = f.nFighterIdx = -1;
		switch( g_nMenuPos )
		{
			case 0:
				//fight
				//allow player to select an enemy or ally...
				f = SelectFighter( false );
				//now do the attack!
				CBFightDoAttack( g_CurrentFighter.nPartyIdx, g_CurrentFighter.nFighterIdx,
												 f.nPartyIdx, f.nFighterIdx,
												 CBGetFighterFP( g_CurrentFighter.nPartyIdx, g_CurrentFighter.nFighterIdx ),
												 false );
				CBReleaseFighterCharge( g_CurrentFighter.nPartyIdx, g_CurrentFighter.nFighterIdx );
				g_nMenu = MENU_MAIN;
				g_nMenuPos = 0;
				g_nTopMenu = 0;
				g_bPlayerMoving = false;
				break;
			case 1:
				//item
				//switch to item menu...
				g_nMenu = MENU_ITEM;
				g_nMenuPos = 0;
				g_nTopMenu = 0;
				break;
			case 2:
				//run/spc
				if ( CBGetPlayerNum( PLAYER_DOES_SM, 0, g_CurrentFighter.nFighterIdx ) ) 
				{
					//spc
					g_nMenu = MENU_SPC;
					g_nMenuPos = 0;
					g_nTopMenu = 0;
					//generate special move list...
					std::string strName = CBGetPlayerString( PLAYER_NAME, 0, g_CurrentFighter.nFighterIdx );
					g_nSpecialMoveCount = CBDetermineSpecialMoves(strName);
					for (int i = 0; i < g_nSpecialMoveCount; i++)
					{
						std::string strFile = CBGetSpecialMoveListEntry(i);
						if (strFile.compare("") != 0)
						{
							//ok, we have a special move... load it...
							CBLoadSpecialMove(strFile);
							g_abilitiesList[i] = CBGetSpecialMoveString(SPC_NAME) + ": " + Int2String(CBGetSpecialMoveNum(SPC_SMP));
						}
					}
				}
				else
				{
					//run
					//2 in 3 chance of running...
					int nChance = (int)( ( rand() / RAND_MAX ) * 3 );
					if ( nChance != 2 ) 
					{
						//ran!
						g_nMenu = MENU_MAIN;
						g_nMenuPos = 0;
						g_nTopMenu = 0;
						g_bPlayerMoving = false;
						return 1;
					}
					else
					{
						//CBPlaySound(CBGetGeneralString(GEN_CURSOR_SELSOUND, 0, 0));
						g_nMenu = MENU_MAIN;
						g_nMenuPos = 0;
						g_nTopMenu = 0;
						g_bPlayerMoving = false;
						return 0;
					}
				}
				break;
			case 3:
				//run
				//2 in 3 chance of running...
				int nChance = (int)( ( rand() / RAND_MAX ) * 3 );
				if ( nChance != 2 ) 
				{
					//ran!
					g_nMenu = MENU_MAIN;
					g_nMenuPos = 0;
					g_nTopMenu = 0;
					g_bPlayerMoving = false;
					return 1;
				}
				else
				{
					//CBPlaySound(CBGetGeneralString(GEN_CURSOR_SELSOUND, 0, 0));
					g_nMenu = MENU_MAIN;
					g_nMenuPos = 0;
					g_nTopMenu = 0;
					g_bPlayerMoving = false;
					return 0;
				}
				break;
		}
	}
	return 0;
}

//scan keys for item menu...
int ItemMenuScanKeys()
{
	INPUT_EVENT ie;
	ie.strKey = "";
	GetNextInputEvent( &ie );

	if ( ie.strKey.compare("UP") == 0 || CBCheckKey("JOYUP") )
	{
		g_nMenuPos--;
		if ( g_nMenuPos < 0 )
		{
			g_nMenuPos = 0;
			g_nTopMenu--;
			if ( g_nTopMenu < 0 )
				g_nTopMenu = 0;
		}
		CBPlaySound(CBGetGeneralString(GEN_CURSOR_MOVESOUND, 0, 0));
		//Sleep(90);
	}
	else if ( ie.strKey.compare("DOWN") == 0 || CBCheckKey("JOYDOWN") )
	{
		g_nMenuPos++;
		if ( g_nMenuPos >= g_nItemsPerList )
		{
			g_nMenuPos--;
			g_nTopMenu++;
		}
		CBPlaySound(CBGetGeneralString(GEN_CURSOR_MOVESOUND, 0, 0));
		//Sleep(90);
	}
	else if ( ie.strKey.compare( "ESC" ) == 0 || CBCheckKey("BUTTON2") )
	{
		g_nMenuPos = 1;
		g_nMenu = MENU_MAIN;
	}
	else if ( ie.strKey.compare( "ENTER" ) == 0 || CBCheckKey("BUTTON1") ) 
	{
		CBPlaySound(CBGetGeneralString(GEN_CURSOR_SELSOUND, 0, 0));
		//determine which item this is...
		int nItemID = ItemIndex( g_nMenuPos + g_nTopMenu );
		if (nItemID != -1)
		{
			//check if we can use this item from the fight...
			std::string strFile = CBGetGeneralString(GEN_INVENTORY_FILES, nItemID, 0);
			if (strFile.compare("") != 0)
			{
				//load this item (by convention, item 11 is a 'free' slot...
				CBLoadItem(strFile, 11);
				if (CBGetItemNum(ITM_FIGHT_YN, 0, 11) == 1)
				{
					//can use the item from the fight...
					//can this player use it?
					bool bUse = false;
					if ( CBGetItemNum(ITM_USEDBY, 0, 11) == 0 )
					{
						bUse = true;
					}
					else
					{
						//this item can only be used by specific characters...
						std::string strHandle = CBGetPlayerString( PLAYER_NAME, 0, g_CurrentFighter.nFighterIdx );
						for (int i = 0; i < 50; i++ )
						{
							std::string strCanUse = CBGetItemString( ITM_CHARACTERS, i, 11 );
							if ( strCanUse.compare( strHandle ) == 0 )
							{
								bUse = true;
								break;
							}
						}
					}
					if ( bUse )
					{
						//select fighter to use it on...
						FIGHTER f;
						f.nPartyIdx = f.nFighterIdx = -1;
						//determine if item is curative...
						bool bCurative = CBGetItemNum( ITM_FIGHT_HPUP, 0, 11 ) > 0;
						f = SelectFighter( bCurative );
						//now use the item!
						CBFightUseItem( g_CurrentFighter.nPartyIdx, g_CurrentFighter.nFighterIdx,
														f.nPartyIdx, f.nFighterIdx,
														strFile );
						CBReleaseFighterCharge( g_CurrentFighter.nPartyIdx, g_CurrentFighter.nFighterIdx );
						g_nMenu = MENU_MAIN;
						g_nMenuPos = 0;
						g_nTopMenu = 0;
						g_bPlayerMoving = false;
					}
					else
					{
						//player cannot use this item...
						CBMessageWindow(CBLoadString(823, "This player cannot use this item!"), RGB(255, 255, 255), 0, "", MW_OK);
					}
				}
				else
				{
					//cannot use the item from the fight...
					CBMessageWindow(CBLoadString(825, "You cannot use this item during a fight!"), RGB(255, 255, 255), 0, "", MW_OK);
				}
			}
		}
	}
	return 0;
}

//special move menu scan keys
int SPCMenuScanKeys()
{
	INPUT_EVENT ie;
	ie.strKey = "";
	GetNextInputEvent( &ie );

	if ( ie.strKey.compare( "UP" ) == 0 || CBCheckKey("JOYUP") )
	{
		g_nMenuPos--;
		if ( g_nMenuPos < 0 )
		{
			g_nMenuPos = 0;
			g_nTopMenu--;
			if ( g_nTopMenu < 0 )
				g_nTopMenu = 0;
		}
		CBPlaySound(CBGetGeneralString(GEN_CURSOR_MOVESOUND, 0, 0));
	}
	else if ( ie.strKey.compare( "DOWN" ) == 0 || CBCheckKey("JOYDOWN") )
	{
		g_nMenuPos++;
		if ( g_nMenuPos >= g_nItemsPerList )
		{
			g_nMenuPos--;
			g_nTopMenu++;
		}
		CBPlaySound(CBGetGeneralString(GEN_CURSOR_MOVESOUND, 0, 0));
		//Sleep(90);
	}
	else if ( ie.strKey.compare( "ESC" ) == 0 || CBCheckKey("BUTTON2") )
	{
		g_nMenuPos = 2;
		g_nMenu = MENU_MAIN;
	}
	else if ( ie.strKey.compare( "ENTER" ) == 0 || CBCheckKey("BUTTON1") ) 
	{
		CBPlaySound(CBGetGeneralString(GEN_CURSOR_SELSOUND, 0, 0));
		std::string strFile = CBGetSpecialMoveListEntry(g_nMenuPos + g_nTopMenu);
		if (strFile.compare("") != 0)
		{
			//ok, we have a special move... load it...
			CBLoadSpecialMove(strFile);
			//can this move be used from the fight?
			if (CBGetSpecialMoveNum( SPC_BATTLEDRIVEN ) == 0)
			{
				//we can use this move...
				//check if there is enough special move power...
				int nRequiredSMP = CBGetSpecialMoveNum( SPC_SMP );
				if ( nRequiredSMP > CBGetFighterSMP( g_CurrentFighter.nPartyIdx, g_CurrentFighter.nFighterIdx ) )
				{
					CBMessageWindow(CBLoadString(826, "You don't have enough SMP to do that move!"), RGB(255, 255, 255), 0, "", MW_OK);
				} 
				else
				{
					//do the move!
					//select fighter to use it on...
					FIGHTER f;
					f.nPartyIdx = f.nFighterIdx = -1;
					//determine if item is curative...
					bool bCurative = CBGetSpecialMoveNum( SPC_FP ) < 0;
					f = SelectFighter( bCurative );
					//now use the item!
					CBFightUseSpecialMove( g_CurrentFighter.nPartyIdx, g_CurrentFighter.nFighterIdx,
																 f.nPartyIdx, f.nFighterIdx,
																 strFile );
					CBReleaseFighterCharge( g_CurrentFighter.nPartyIdx, g_CurrentFighter.nFighterIdx );
					g_nMenu = MENU_MAIN;
					g_nMenuPos = 0;
					g_nTopMenu = 0;
					g_bPlayerMoving = false;
				}
			}
			else
			{
				//can't be used from battle...
				CBMessageWindow(CBLoadString(2074, "You cannot use this move during a fight!"), RGB(255, 255, 255), 0, "", MW_OK);
			}
		}
	}
	return 0;
}


//scan keys for input...
int ScanKeys()
{
	if ( g_bPlayerMoving ) 
	{
		switch( g_nMenu ) 
		{
			case MENU_MAIN:
				return MainMenuScanKeys();
				break;	//MENU_MAIN

			case MENU_ITEM:
				return ItemMenuScanKeys();
				break;	//MENU_ITEM

			case MENU_SPC:
				return SPCMenuScanKeys();
				break;	//MENU_SPC
		}//switch
	}//g_bPlayerMoving
	return 0;
}

//determine the item index form the screen index
int ItemIndex( int nScreenIndex )
{
	int nRet = -1;
	//nScreenIndex indicates the index of the object as if it were mapped directly to te screen list.
	//let's match this up with the item list array...
	//get item handles from trans3...
	std::string strItems[501];
	int i;
	for (i = 0; i < 500; i++)
	{
		strItems[i] = CBGetGeneralString(GEN_INVENTORY_HANDLES, i, 0);
	}

	int c = 0;
	//find that item...
	for (i = 0; i < 500; i++)
	{
		if (strItems[i].compare("") != 0)
		{
			if (c == nScreenIndex)
			{
				break;
			}
			else
			{
				c++;
			}
		}
	}
	nRet = i;
	return nRet;
}

//find the lowest fighter idx of a living
//fighter in a party
//return -1 if not found
int aliveLowerIdx( int nPartyIdx )
{
	//find the first fighters whose HP > 0...
	int nRet = -1;
	int i = 0;
	int j = CBGetPartySize( nPartyIdx );
	for ( i = 0; i < j; i++ )
	{
		if ( CBGetFighterHP( nPartyIdx, i ) > 0 || nPartyIdx == PLAYER_PARTY )
		{
			nRet = i;
			break;
		}
	}

	return nRet;
}

//find the highest fighter idx of a living
//fighter in a party
//return -1 if not found
int aliveUpperIdx( int nPartyIdx )
{
	//find the last fighters whose HP > 0...
	int nRet = -1;
	int i = 0;
	int j = CBGetPartySize( nPartyIdx );
	for ( i = 0; i < j; i++ )
	{
		if ( CBGetFighterHP( nPartyIdx, i ) > 0 || nPartyIdx == PLAYER_PARTY  )
		{
			nRet = i;
		}
	}

	return nRet;
}


//allow the user to select a fighter form the screen
FIGHTER SelectFighter( bool bStartOnPlayers )
{
	//first select the first fighter to start on...
	FIGHTER f;
	f.nFighterIdx = -1;
	if ( bStartOnPlayers )
	{
		f.nPartyIdx = PLAYER_PARTY;
		f.nFighterIdx = aliveLowerIdx( PLAYER_PARTY );
	}
	if ( !bStartOnPlayers || f.nFighterIdx == -1 )
	{
		f.nPartyIdx = ENEMY_PARTY;
		f.nFighterIdx = aliveLowerIdx( ENEMY_PARTY );
	}

	//ok, the first fighter is now in f...
	//now let's draw our cursor...
	g_bHideMenu = true;

	bool bDone = false;
	while ( !bDone ) 
	{
		CBDoEvents();

		INPUT_EVENT ie;
		ie.strKey = "";
		GetNextInputEvent( &ie );

		renderNow( false );
		//draw the cursor...
		if ( f.nPartyIdx == PLAYER_PARTY ) 
		{
			//ok, we're selecting a player...
			CBDrawHand( g_PlayerSprite[ f.nFighterIdx ].x + 20, g_PlayerSprite[ f.nFighterIdx ].y + 10);
			CBDrawTextAbsolute( CBGetFighterName( f.nPartyIdx, f.nFighterIdx ), "Arial", 14,
													g_PlayerSprite[ f.nFighterIdx ].x + 20, g_PlayerSprite[ f.nFighterIdx ].y + 10, 
													g_crTextColor, false, false, false, false, false );
			CBRefreshScreen();
		}
		if ( f.nPartyIdx == ENEMY_PARTY )
		{
			CBDrawHand( g_EnemySprite[ f.nFighterIdx ].x + 20, g_EnemySprite[ f.nFighterIdx ].y + 10);
			CBDrawTextAbsolute( CBGetFighterName( f.nPartyIdx, f.nFighterIdx ), "Arial", 14,
													g_EnemySprite[ f.nFighterIdx ].x + 20, g_EnemySprite[ f.nFighterIdx ].y + 10, 
													g_crTextColor, false, false, false, false, false );
			CBRefreshScreen();
		}
		//now scan the keys...
		if ( ie.strKey.compare( "UP" ) == 0 || CBCheckKey( "JOYUP" ) ) 
		{
			if ( f.nPartyIdx == PLAYER_PARTY ) 
			{
				f.nFighterIdx--;
				if ( f.nFighterIdx < aliveLowerIdx( PLAYER_PARTY ) )
					f.nFighterIdx = aliveUpperIdx( PLAYER_PARTY );
				if ( f.nFighterIdx == -1 ) {
					f.nFighterIdx = aliveLowerIdx( ENEMY_PARTY );
					f.nPartyIdx = ENEMY_PARTY;
				}
				CBPlaySound(CBGetGeneralString(GEN_CURSOR_MOVESOUND, 0, 0));
				Sleep(90);
				continue;
			}
			if ( f.nPartyIdx == ENEMY_PARTY ) 
			{
				switch( f.nFighterIdx )
				{
					case 0:
						if ( CBGetFighterHP( f.nPartyIdx, 2 ) > 0 )
							f.nFighterIdx = 2;
						else if ( CBGetFighterHP( f.nPartyIdx, 3 ) > 0 )
							f.nFighterIdx = 3;
						break;
					case 1:
						if ( CBGetFighterHP( f.nPartyIdx, 3 ) > 0 )
							f.nFighterIdx = 3;
						else if ( CBGetFighterHP( f.nPartyIdx, 2 ) > 0 )
							f.nFighterIdx = 2;
						break;
					case 2:
						if ( CBGetFighterHP( f.nPartyIdx, 0 ) > 0 )
							f.nFighterIdx = 0;
						else if ( CBGetFighterHP( f.nPartyIdx, 1 ) > 0 )
							f.nFighterIdx = 1;
						break;
					case 3:
						if ( CBGetFighterHP( f.nPartyIdx, 1 ) > 0 )
							f.nFighterIdx = 1;
						else if ( CBGetFighterHP( f.nPartyIdx, 0 ) > 0 )
							f.nFighterIdx = 0;
						break;
				}
				CBPlaySound(CBGetGeneralString(GEN_CURSOR_MOVESOUND, 0, 0));
				Sleep(90);
				continue;
			}
		}
		if ( ie.strKey.compare( "DOWN" ) == 0 || CBCheckKey( "JOYDOWN" ) ) 
		{
			if ( f.nPartyIdx == PLAYER_PARTY ) 
			{
				f.nFighterIdx++;
				if ( f.nFighterIdx > aliveUpperIdx( PLAYER_PARTY ) )
					f.nFighterIdx = aliveLowerIdx( PLAYER_PARTY );
				if ( f.nFighterIdx == -1 ) {
					f.nFighterIdx = aliveLowerIdx( ENEMY_PARTY );
					f.nPartyIdx = ENEMY_PARTY;
				}
				CBPlaySound(CBGetGeneralString(GEN_CURSOR_MOVESOUND, 0, 0));
				Sleep(90);
				continue;
			}
			if ( f.nPartyIdx == ENEMY_PARTY ) 
			{
				switch( f.nFighterIdx )
				{
					case 0:
						if ( CBGetFighterHP( f.nPartyIdx, 2 ) > 0 )
							f.nFighterIdx = 2;
						else if ( CBGetFighterHP( f.nPartyIdx, 3 ) > 0 )
							f.nFighterIdx = 3;
						break;
					case 1:
						if ( CBGetFighterHP( f.nPartyIdx, 3 ) > 0 )
							f.nFighterIdx = 3;
						else if ( CBGetFighterHP( f.nPartyIdx, 2 ) > 0 )
							f.nFighterIdx = 2;
						break;
					case 2:
						if ( CBGetFighterHP( f.nPartyIdx, 0 ) > 0 )
							f.nFighterIdx = 0;
						else if ( CBGetFighterHP( f.nPartyIdx, 1 ) > 0 )
							f.nFighterIdx = 1;
						break;
					case 3:
						if ( CBGetFighterHP( f.nPartyIdx, 1 ) > 0 )
							f.nFighterIdx = 1;
						else if ( CBGetFighterHP( f.nPartyIdx, 0 ) > 0 )
							f.nFighterIdx = 0;
						break;
				}
				CBPlaySound(CBGetGeneralString(GEN_CURSOR_MOVESOUND, 0, 0));
				Sleep(90);
				continue;
			}
		}
		if ( ie.strKey.compare( "LEFT" ) == 0 || CBCheckKey( "JOYLEFT" ) ) 
		{
			if ( f.nPartyIdx == PLAYER_PARTY ) 
			{
				f.nPartyIdx = ENEMY_PARTY;
				f.nFighterIdx = aliveLowerIdx( f.nPartyIdx );
				CBPlaySound(CBGetGeneralString(GEN_CURSOR_MOVESOUND, 0, 0));
				Sleep(90);
				continue;
			}
			if ( f.nPartyIdx == ENEMY_PARTY ) 
			{
				switch( f.nFighterIdx )
				{
					case 0:
						f.nPartyIdx = PLAYER_PARTY;
						f.nFighterIdx = aliveLowerIdx( f.nPartyIdx );
						break;
					case 1:
						if ( CBGetFighterHP( f.nPartyIdx, 0 ) > 0 )
							f.nFighterIdx = 0;
						else {
							f.nPartyIdx = PLAYER_PARTY;
							f.nFighterIdx = aliveLowerIdx( f.nPartyIdx );
						}
						break;
					case 2:
						f.nPartyIdx = PLAYER_PARTY;
						f.nFighterIdx = aliveUpperIdx( f.nPartyIdx );
						break;
					case 3:
						if ( CBGetFighterHP( f.nPartyIdx, 2 ) > 0 )
							f.nFighterIdx = 2;
						else {
							f.nPartyIdx = PLAYER_PARTY;
							f.nFighterIdx = aliveUpperIdx( f.nPartyIdx );
						}
						break;
				}
				CBPlaySound(CBGetGeneralString(GEN_CURSOR_MOVESOUND, 0, 0));
				Sleep(90);
				continue;
			}
		}
		if ( ie.strKey.compare( "RIGHT" ) == 0 || CBCheckKey( "JOYRIGHT" ) ) 
		{
			if ( f.nPartyIdx == PLAYER_PARTY ) 
			{
				f.nPartyIdx = ENEMY_PARTY;
				f.nFighterIdx = aliveLowerIdx( f.nPartyIdx );
				CBPlaySound(CBGetGeneralString(GEN_CURSOR_MOVESOUND, 0, 0));
				Sleep(90);
				continue;
			}
			if ( f.nPartyIdx == ENEMY_PARTY ) 
			{
				switch( f.nFighterIdx )
				{
					case 0:
						if ( CBGetFighterHP( f.nPartyIdx, 1 ) > 0 )
							f.nFighterIdx = 1;
						else {
							f.nPartyIdx = PLAYER_PARTY;
							f.nFighterIdx = aliveLowerIdx( f.nPartyIdx );
						}
						break;
					case 1:
						f.nPartyIdx = PLAYER_PARTY;
						f.nFighterIdx = aliveLowerIdx( f.nPartyIdx );
						break;
					case 2:
						if ( CBGetFighterHP( f.nPartyIdx, 3 ) > 0 )
							f.nFighterIdx = 3;
						else {
							f.nPartyIdx = PLAYER_PARTY;
							f.nFighterIdx = aliveUpperIdx( f.nPartyIdx );
						}
						break;
					case 3:
						f.nPartyIdx = PLAYER_PARTY;
						f.nFighterIdx = aliveUpperIdx( f.nPartyIdx );
						break;
				}
				CBPlaySound(CBGetGeneralString(GEN_CURSOR_MOVESOUND, 0, 0));
				Sleep(90);
				continue;
			}
		}
		if ( ie.strKey.compare( "ENTER" ) == 0 || CBCheckKey("BUTTON1") )
		{
			CBPlaySound(CBGetGeneralString(GEN_CURSOR_SELSOUND, 0, 0));
			Sleep(90);
			bDone = true;
		}
	}

	g_bHideMenu = false;
	return f;
}

//create the sprites
void CreateSprites()
{
	int i = 0;
	int j = CBGetPartySize( PLAYER_PARTY );
	for ( i = 0; i < j; i++ )
	{
		g_PlayerSprite[i].anm = CBCreateAnimation( CBGetFighterAnimation( PLAYER_PARTY, i, "REST" ) );
		//g_PlayerSprite[i].anm = CBCreateAnimation( "explode.anm" );
		g_PlayerSprite[i].cnv = CBCreateCanvas( CBAnimationSizeX( g_PlayerSprite[i].anm ),
																						CBAnimationSizeY( g_PlayerSprite[i].anm ) );
		g_PlayerSprite[i].x = g_nSizeX - CBAnimationSizeX( g_PlayerSprite[i].anm ) - 30;
		g_PlayerSprite[i].y = 30 + ( CBAnimationSizeY( g_PlayerSprite[i].anm ) + 30 ) * i;
		g_PlayerSprite[i].bDead = false;
	}

	j = CBGetPartySize( ENEMY_PARTY );
	for ( i = 0; i < j; i++ )
	{
		g_EnemySprite[i].anm = CBCreateAnimation( CBGetFighterAnimation( ENEMY_PARTY, i, "REST" ) );
		//g_EnemySprite[i].anm = CBCreateAnimation( "explode.anm" );
		g_EnemySprite[i].cnv = CBCreateCanvas( CBAnimationSizeX( g_EnemySprite[i].anm ),
																					 CBAnimationSizeY( g_EnemySprite[i].anm ) );
		g_EnemySprite[i].bDead = false;
		//if ( j <= 4 )
		{
			//two by two...
			switch( i ) {
				case 0:
					g_EnemySprite[i].x = 30;
					g_EnemySprite[i].y = 30;
					break;
				case 1:
					g_EnemySprite[i].x = 30 + ( CBAnimationSizeX( g_EnemySprite[i-1].anm ) + 30 );
					g_EnemySprite[i].y = 30;
					break;
				case 2:
					g_EnemySprite[i].x = 30;
					g_EnemySprite[i].y = 30 + ( CBAnimationSizeY( g_EnemySprite[i-2].anm ) + 30 );
					break;
				case 3:
					g_EnemySprite[i].x = 30 + ( CBAnimationSizeX( g_EnemySprite[i-1].anm ) + 30 );
					g_EnemySprite[i].y = 30 + ( CBAnimationSizeY( g_EnemySprite[i-2].anm ) + 30 );
					break;
			}
			CBSetGeneralNum( GEN_ENEX, 0, i, g_EnemySprite[i].x / 32 );
			CBSetGeneralNum( GEN_ENEY, 0, i, g_EnemySprite[i].y / 32 );
		}
	}
}

//destory sprites
void DestroySprites() 
{
	int i;
	for ( i = 0; i < CBGetPartySize( PLAYER_PARTY ); i++ )
	{
		CBDestroyAnimation( g_PlayerSprite[i].anm );
		CBDestroyCanvas( g_PlayerSprite[i].cnv );
	}

	for ( i = 0; i < CBGetPartySize( ENEMY_PARTY ); i++ )
	{
		CBDestroyAnimation( g_EnemySprite[i].anm );
		CBDestroyCanvas( g_EnemySprite[i].cnv );
	}
}

//Add a fighter to the crage queue.
//this ia s list of fighters who are chargd up
//and who can now do moves...
void QueueFighter( FIGHTER fighter )
{
	g_qCharged.push( fighter );
}


//pop the next fighter from the front of the queue
bool NextFighter( FIGHTER* p_fighter ) 
{
	if ( g_qCharged.size() > 0 ) 
	{
		*p_fighter = g_qCharged.front();
		//now remove the event at the head of the list...
		g_qCharged.pop();
		return true;
	}
	else 
	{
		return false;
	}	
}


void RenderSprite( SPRITE sprite ) 
{
	CBCanvasDrawAnimation( sprite.cnv, sprite.anm, 0, 0, false, true );
	CBDrawCanvasTransparent( sprite.cnv, 
													 sprite.x, 
													 sprite.y,
													 g_crTranspColor );
}

//render the last frame of the sprite animation
void RenderLastFrame( SPRITE sprite )
{
	CBCanvasDrawAnimationFrame( sprite.cnv, sprite.anm, CBAnimationMaxFrames( sprite.anm ), 0, 0, true );
	CBDrawCanvasTransparent( sprite.cnv, 
													 sprite.x, 
													 sprite.y,
													 g_crTranspColor );
}

//draw the enemies onto the scene
//if nExcludeIndex != -1, then exclude one of the fighters
void RenderEnemies( int nExcludeIndex, int nIgnoreHP ) 
{
	int i = 0;
	int j = CBGetPartySize( ENEMY_PARTY );
	for ( i = 0; i < j; i++ )
	{
		if ( nExcludeIndex != i ) {
			if ( CBGetFighterHP( ENEMY_PARTY, i ) > 0 || nIgnoreHP == i )
				RenderSprite( g_EnemySprite[i] );
		}
	}
}

//draw the players onto the scene
//if nExcludeIndex != -1, then exclude one of the fighters
void RenderPlayers( int nExcludeIndex ) 
{
	int i = 0;
	int j = CBGetPartySize( PLAYER_PARTY );
	for ( i = 0; i < j; i++ )
	{
		if ( nExcludeIndex != i ) 
		{
			//check if the player is dead...
			if ( CBGetFighterHP( PLAYER_PARTY, i ) <= 0 ) 
			{
				//the player is dead...
				//just draw the final frame of his death animation...
				if ( !g_PlayerSprite[i].bDead )
				{
					//the player has not yet been marked as dead.
					//mark him now...
					g_PlayerSprite[i].bDead = true;

					//use the new animation...
					CBDestroyAnimation( g_PlayerSprite[i].anm );
					g_PlayerSprite[i].anm = CBCreateAnimation( CBGetFighterAnimation( PLAYER_PARTY, i, "DIE" ) );

					//resize the canvas
					CBCanvasResize( g_PlayerSprite[i].cnv, 
													CBAnimationSizeX( g_PlayerSprite[i].anm ),
													CBAnimationSizeY( g_PlayerSprite[i].anm ) );
				}

				//now draw that final frame of death...
				RenderLastFrame( g_PlayerSprite[i] );
			}
			else
			{
				RenderSprite( g_PlayerSprite[i] );
			}
		}
	}
}

//render an event onscreen...
void RenderEvent( FIGHT_EVENT event ) 
{
	//determine the type of the event...
	long crColorTargetHP = rgb( 255, 255, 255 );
	long crColorTargetSMP = rgb( 0, 0, 255 );
	
	long crColorSourceHP = rgb( 255, 255, 255 );
	long crColorSourceSMP = rgb( 0, 0, 255 );

	if ( event.nSourceHP < 0 )
		crColorSourceHP = rgb( 0, 255, 0 );

	if ( event.nSourceSMP < 0 )
		crColorSourceSMP = rgb( 0, 255, 255 );

	if ( event.nTargetHP < 0 )
		crColorTargetHP = rgb( 0, 255, 0 );

	if ( event.nTargetSMP < 0 )
		crColorTargetSMP = rgb( 0, 255, 255 );

	std::string strRPGCode = "";
	std::string strAnimation = "";
	std::string strEffect = "";

	switch( event.nCode ) 
	{
		case INFORM_SOURCE_ATTACK:
			AnimateFighter( event.source, "ATTACK", event.target );
			if (event.nTargetHP > 0 || event.nTargetSMP > 0)
			{
				AnimateFighter( event.target, "DEFEND", event.target );
			}
			if ( CBGetFighterHP( event.target.nPartyIdx, event.target.nFighterIdx ) <= 0 )
			{
				AnimateFighter( event.target, "DIE", event.target );		
			}
			//show the hp removed/added
			RenderText( event.target, Int2String( abs( event.nTargetHP ) ), 20, crColorTargetHP );
			//pause...
			Sleep( 950 );
			break;

		case INFORM_SOURCE_ITEM:
			AnimateFighter( event.source, "SPECIAL MOVE", event.target );
			if (event.nTargetHP > 0 || event.nTargetSMP > 0)
			{
				AnimateFighter( event.target, "DEFEND", event.target );
			}
			if ( CBGetFighterHP( event.target.nPartyIdx, event.target.nFighterIdx ) <= 0 )
			{
				AnimateFighter( event.target, "DIE", event.target );		
			}
			
			//run the associated rpgcode program...
			CBLoadItem( event.strMessage, 11 );

			//Run the asociated animation...
			strAnimation = CBGetItemString(ITM_ANIMATION, 0, 11);
			if ( strAnimation.compare("") != 0 ) 
			{
				if ( event.target.nPartyIdx == PLAYER_PARTY ) 
				{
					int x, y;
					x = g_PlayerSprite[ event.target.nFighterIdx ].x + CBCanvasWidth( g_PlayerSprite[ event.target.nFighterIdx ].cnv ) / 2;
					y = g_PlayerSprite[ event.target.nFighterIdx ].y + CBCanvasHeight( g_PlayerSprite[ event.target.nFighterIdx ].cnv ) / 2;
					CBRpgCode("#Animation(\"" + strAnimation + "\", " + Int2String(x) + ", " + Int2String(y) + ")");
				} 
				else {
					int x, y;
					x = g_EnemySprite[ event.target.nFighterIdx ].x + CBCanvasWidth( g_EnemySprite[ event.target.nFighterIdx ].cnv ) / 2;
					y = g_EnemySprite[ event.target.nFighterIdx ].y + CBCanvasHeight( g_EnemySprite[ event.target.nFighterIdx ].cnv ) / 2;
					CBRpgCode("#Animation(\"" + strAnimation + "\", " + Int2String(x) + ", " + Int2String(y) + ")");
				}
			}

			strRPGCode = "";
			strRPGCode = CBGetItemString(ITM_MENU_PRG, 0, 11);
			if (strRPGCode.compare("") != 0)
			{
				//assume source and target were set by trans3
				CBRunProgram(strRPGCode);
			}

			//show the smp removed/added
			RenderText( event.target, Int2String( abs( event.nTargetHP ) ), 20, crColorTargetHP );
			//pause...
			Sleep( 950 );
			break;

		case INFORM_SOURCE_SMP:
			//source has used a special move
			AnimateFighter( event.source, "SPECIAL MOVE", event.target );
			if (event.nTargetHP > 0 || event.nTargetSMP > 0)
			{
				AnimateFighter( event.target, "DEFEND", event.target );
			}
			if ( CBGetFighterHP( event.target.nPartyIdx, event.target.nFighterIdx ) <= 0 )
			{
				AnimateFighter( event.target, "DIE", event.target );		
			}
		
			//run the associated rpgcode program...
			CBLoadSpecialMove( event.strMessage );

			//Run the asociated animation...
			strAnimation = CBGetSpecialMoveString( SPC_ANIMATION );
			if ( strAnimation.compare("") != 0 ) 
			{
				if ( event.target.nPartyIdx == PLAYER_PARTY ) 
				{
					int x, y;
					x = g_PlayerSprite[ event.target.nFighterIdx ].x - CBCanvasWidth( g_PlayerSprite[ event.target.nFighterIdx ].cnv ) / 2;
					y = g_PlayerSprite[ event.target.nFighterIdx ].y - CBCanvasHeight( g_PlayerSprite[ event.target.nFighterIdx ].cnv ) / 2;
					CBRpgCode("#Animation(\"" + strAnimation + "\", " + Int2String(x) + ", " + Int2String(y) + ")");
				} 
				else {
					int x, y;
					x = g_EnemySprite[ event.target.nFighterIdx ].x - CBCanvasWidth( g_EnemySprite[ event.target.nFighterIdx ].cnv ) / 2;
					y = g_EnemySprite[ event.target.nFighterIdx ].y - CBCanvasHeight( g_EnemySprite[ event.target.nFighterIdx ].cnv ) / 2;
					CBRpgCode("#Animation(\"" + strAnimation + "\", " + Int2String(x) + ", " + Int2String(y) + ")");
				}
			}

			strRPGCode = "";
			strRPGCode = CBGetSpecialMoveString( SPC_PRG_FILE );
			if (strRPGCode.compare("") != 0)
			{
				//assume source and target were set by trans3
				CBRunProgram(strRPGCode);
			}

			//apply associated status effect...
			strEffect = "";
			strEffect = CBGetSpecialMoveString( SPC_STATUSFX );
			if ( strEffect.compare("") != 0 )
			{
				CBFighterAddStatusEffect( event.target.nPartyIdx, event.target.nFighterIdx, strEffect );
			}

			//show the smp removed/added
			RenderText( event.target, Int2String( abs( event.nTargetHP ) ), 20, crColorTargetHP );
			RenderText( event.source, Int2String( abs( event.nSourceSMP ) ), 20, crColorTargetSMP );
			//pause...
			Sleep( 950 );
			break;

		case INFORM_SOURCE_CHARGED:
			//someone is charged up
			//if it's a player, we'll have to let the player do their move...
			if ( event.source.nPartyIdx == PLAYER_PARTY ) 
			{
				QueueFighter( event.source );
			}
			break;
			
		case INFORM_SOURCE_PARTY_DEFEATED:
			//a party has been defeated	
			if ( event.source.nPartyIdx == PLAYER_PARTY )
				g_nPartyWon = ENEMY_PARTY;
			else
				g_nPartyWon = PLAYER_PARTY;
	}
}


//Render text by the fighter
void RenderText( FIGHTER fighter, std::string strText, int nSize, long crColor )
{
	int nPartyIndex, nFighterIndex;
	nPartyIndex = fighter.nPartyIdx;
	nFighterIndex = fighter.nFighterIdx;

	int x, y;
	x = y = 0;
	if ( nPartyIndex == PLAYER_PARTY )
	{
		//draw by a player
		x = g_PlayerSprite[ nFighterIndex ].x;
		y = g_PlayerSprite[ nFighterIndex ].y;
		y += CBAnimationSizeY( g_PlayerSprite[ nFighterIndex ].anm ) - nSize;
		x -= ( nSize / 2 );
	}
	else if ( nPartyIndex == ENEMY_PARTY )
	{
		//draw by an enemy
		x = g_EnemySprite[ nFighterIndex ].x;
		y = g_EnemySprite[ nFighterIndex ].y;
		y += CBAnimationSizeY( g_EnemySprite[ nFighterIndex ].anm ) - nSize;
		x += CBAnimationSizeX( g_EnemySprite[ nFighterIndex ].anm );
	}
	CBDrawTextAbsolute( strText, "Arial", nSize, x, y, crColor, true, false, false, false);
	CBRefreshScreen();
}

//do the animation for a fighter
void AnimateFighter( FIGHTER fighter, std::string strAnimation, FIGHTER target )
{
	int nPartyIndex = fighter.nPartyIdx;
	int nFighterIndex = fighter.nFighterIdx;
	if ( nPartyIndex < 0 || nFighterIndex < 0 )
		return;

	//create the sprite...
	SPRITE sprite;
	int nMax = 0;
	std::string strFile = CBGetFighterAnimation( nPartyIndex, nFighterIndex, strAnimation );
	if ( strFile.compare( "" ) != 0 ) 
	{
		sprite.anm = CBCreateAnimation( strFile );
		sprite.cnv = CBCreateCanvas( CBAnimationSizeX( sprite.anm ), CBAnimationSizeY( sprite.anm ) );
		nMax = CBAnimationMaxFrames( sprite.anm );

		if ( nPartyIndex == PLAYER_PARTY )
		{
			//animate a player
			sprite.x = g_PlayerSprite[ nFighterIndex ].x;
			sprite.y = g_PlayerSprite[ nFighterIndex ].y;

			bool bDone = false;
			bool bNext = false;
			while ( !bDone )
			{
				CBDrawCanvas( g_cnvBkg, 0, 0 );
				RenderEnemies( -1, target.nFighterIdx );
				//draw all the players except this one...
				RenderPlayers( nFighterIndex );
				//draw the player pose...
				if ( strFile.compare( "" ) != 0 )
					RenderSprite( sprite );

				RenderMenu();
				
				CBRefreshScreen();
				
				int nFrame = CBAnimationCurrentFrame( sprite.anm );
				if ( bNext && nFrame != nMax )
					bDone = true;

				if ( nFrame == nMax )
					bNext = true;
			}
		}
		else if ( nPartyIndex == ENEMY_PARTY )
		{
			//animate an enemy
			sprite.x = g_EnemySprite[ nFighterIndex ].x;
			sprite.y = g_EnemySprite[ nFighterIndex ].y;

			bool bDone = false;
			bool bNext = false;
			while ( !bDone )
			{
				CBDrawCanvas( g_cnvBkg, 0, 0 );
				//draw all the enemies except this one...
				RenderEnemies( nFighterIndex, nFighterIndex );
				RenderPlayers();
				RenderMenu();

				//draw the enemy pose...
				if ( strFile.compare( "" ) != 0 )
					RenderSprite( sprite );

				CBRefreshScreen();

				int nFrame = CBAnimationCurrentFrame( sprite.anm );
				if ( bNext && nFrame != nMax )
					bDone = true;

				if ( nFrame == nMax )
					bNext = true;
			} 
		}

		//destroy the sprite...
		CBDestroyAnimation( sprite.anm );
		CBDestroyCanvas( sprite.cnv );
	}
	else 
	{
		//animation file does not exist -- just flash the sprite.
		if ( nPartyIndex == PLAYER_PARTY )
		{
			//animate a player
			for ( int i = 0; i < 2; i++ )
			{
				CBDrawCanvas( g_cnvBkg, 0, 0 );
				RenderEnemies( -1, target.nFighterIdx );
				//draw all the players except this one...
				RenderPlayers( nFighterIndex );
				RenderMenu();
				CBRefreshScreen();
				Sleep( 150 );
				
				CBDrawCanvas( g_cnvBkg, 0, 0 );
				RenderEnemies();
				RenderPlayers();
				RenderMenu();
				CBRefreshScreen();
				Sleep( 150 );
			}
		}
		else if ( nPartyIndex == ENEMY_PARTY )
		{
			//animate an enemy
			for ( int i = 0; i < 2; i++ )
			{
				CBDrawCanvas( g_cnvBkg, 0, 0 );
				//draw all the enemies except this one...
				RenderEnemies( nFighterIndex, nFighterIndex );
				RenderPlayers();
				RenderMenu();
				CBRefreshScreen();
				Sleep( 150 );


				CBDrawCanvas( g_cnvBkg, 0, 0 );
				RenderEnemies( -1, nFighterIndex);
				RenderPlayers();
				RenderMenu();
				CBRefreshScreen();
				Sleep( 150 );
			} 
		}
	}
}

//draw a charging meter
void DrawMeter( CNVID cnv, int x1, int y1, int x2, int y2, int nPercent, long crColor )
{
	CBCanvasFillRect( cnv, x1, y1, x2, y2, 0 ); 
	int x22;
	x22 = x1 + ( ( nPercent / 100.0 ) * ( x2 - x1 ) ) - 1;
	CBCanvasFillRect( cnv, x1+1, y1+1, x22, y2-1, crColor );
}

//Draw the current menu into a canvas
void DrawMenu( CNVID cnv ) 
{
	if ( g_LastMenu.fighter.nFighterIdx == g_CurrentFighter.nFighterIdx &&
			 g_LastMenu.fighter.nPartyIdx == g_CurrentFighter.nPartyIdx &&
			 g_LastMenu.nMenu == g_nMenu &&
			 g_LastMenu.nTop == g_nTopMenu )
	{
		//this menu is already drawn...
		return;
	}

	g_LastMenu.fighter = g_CurrentFighter;
	g_LastMenu.nMenu = g_nMenu;
	g_LastMenu.nTop = g_nTopMenu;

	CBCanvasLoadSizedImage( cnv, CBGetGeneralString(GEN_FIGHTMENUGRAPHIC, 0, 0) );

	if ( g_nMenu == MENU_MAIN ) 
	{
		//main menu
		CBCanvasDrawText( cnv, CBLoadString(902, "Fight"), "Arial", 24, 1.1, 1, g_crTextColor, true, false, false, false, false );
		CBCanvasDrawText( cnv, CBLoadString(903, "Item"), "Arial", 24, 1.1, 2, g_crTextColor, true, false, false, false, false );
		if ( CBGetPlayerNum( PLAYER_DOES_SM, 0, g_CurrentFighter.nFighterIdx ) ) 
		{
			CBCanvasDrawText( cnv, CBGetPlayerString( PLAYER_SM_NAME, 0, g_CurrentFighter.nFighterIdx ), "Arial", 24, 1, 3, g_crTextColor, true, false, false, false, false );
			if ( g_bCanRun )
				CBCanvasDrawText( cnv, CBLoadString(904, "Run"), "Arial", 24, 1.1, 4, g_crTextColor, true, false, false, false, false );
		}
		else
		{
			if ( g_bCanRun )
				CBCanvasDrawText( cnv, CBLoadString(904, "Run"), "Arial", 24, 1.1, 3, g_crTextColor, true, false, false, false, false );
		}
	} else if ( g_nMenu == MENU_ITEM ) {
		RenderItemSublist( g_nTopMenu, cnv );
	} else if ( g_nMenu == MENU_SPC ) {
		RenderSPCSublist( g_nTopMenu, cnv );
	}
}

//render SPC sublist...
//7 items per sublist...
void RenderSPCSublist(int nTopMenu, CNVID cnv)
{
	//first item in the list...
	g_nItemsPerList = CBCanvasHeight(cnv) / 24;
	int nItemsPerList = g_nItemsPerList;

	int nFirstItem = nTopMenu;
	
	//get item handles from trans3...

	//first item is in index 'c'...
	int y = 0;
	int idx = nFirstItem;
	while(true)
	{
		//found one...
		std::string strText = g_abilitiesList[ idx ];
		CBCanvasDrawText(cnv, strText, "Arial", 24, 1.1, y+1, g_crTextColor, 1, 0, 0, false, false);

		y++;
		if (y>=nItemsPerList)
			break;
		idx++;
		if (idx > 500)
			break;
	}
}

//render item sublist...
//7 items per sublist...
void RenderItemSublist(int nTopMenu, CNVID cnv)
{
	//first item in the list...
	g_nItemsPerList = CBCanvasHeight(cnv) / 24;
	int nItemsPerList = g_nItemsPerList;

	int nFirstItem = nTopMenu;
	
	//get item handles from trans3...
	std::string strItems[501];
	int i;
	for (i = 0; i < 500; i++)
	{
		strItems[i] = CBGetGeneralString(GEN_INVENTORY_HANDLES, i, 0);
	}

	int c = 0;
	//find that first item...
	for (i = 0; i < 500; i++)
	{
		if (strItems[i].compare("") != 0)
		{
			if (c == nFirstItem)
			{
				break;
			}
			else
			{
				c++;
			}
		}
	}

	//first item is in index 'c'...
	int y = 0;
	int idx = i;
	while(true)
	{
		if (strItems[idx].compare("") != 0)
		{
			//found one...
			std::string strText = Int2String(CBGetGeneralNum(GEN_INVENTORY_NUM, idx, 0)) + " " + strItems[idx];
			CBCanvasDrawText(cnv, strText, "Arial", 24, 1.1, y+1, g_crTextColor, 1, 0, 0, false, false);

			y++;
			if (y>=nItemsPerList)
				break;
		}
		idx++;
		if (idx > 500)
			break;
	}
}


//render the hand cursor to the screen where the menu is
//pass in coords of menu.
void DrawCursor( int nMenuX, int nMenuY )
{
	//this is based on the current cursor position...
	int y = g_nMenuPos * 24 + 12 + nMenuY;
	int x = nMenuX + 4;

	//+10 added by KSNiloc
	CBDrawHand( x+10, y );
}

//render fight menu
void RenderMenu()
{
	RenderStats();

	//now render the menu if any player is doing a move...
	if ( g_bPlayerMoving && !g_bHideMenu ) 
	{
		//render the fight menu...
		DrawMenu( g_cnvMenu );

		int x, y;
		x = 35;
		y = g_nSizeY - CBCanvasHeight( g_cnvMenu ) - 130;

		//CBDrawCanvas( g_cnvMenu, x, y );
		CBDrawCanvasTranslucent( g_cnvMenu, x, y, 0.5, g_crTextColor, -1 );
		DrawCursor( x, y );
	}
}



//Put player info into a canvas...
void DrawPlayerStats(FIGHTER fighter, CNVID cnv)
{
	int nParty = fighter.nPartyIdx;
	int nFighter = fighter.nFighterIdx;

	//Get stats...
	std::string strLine[7];
	ObtainFighterInfo(strLine, nParty, nFighter);

	//load profile image...
	CBCanvas2CanvasBlt(g_cnvPlayerProfiles[nFighter], cnv, 0, 0);

	//Print name...
	CBCanvasDrawText(cnv, strLine[0], "Arial", 24, 1, 1, g_crTextColor, 1, 0, 0, false, true);

	int nHP = CBGetFighterHP( nParty, nFighter );
	int nMaxHP = CBGetFighterMaxHP( nParty, nFighter );
	int nSMP = CBGetFighterSMP( nParty, nFighter );
	int nMaxSMP = CBGetFighterMaxSMP( nParty, nFighter );
	int nCharge = CBGetFighterChargePercent( nParty, nFighter );

	int nHPPerc = nHP / (double)nMaxHP * 100;
	int nSMPPerc = nSMP / (double)nMaxSMP * 100;

	CBCanvasDrawText(cnv, strLine[1], "Arial", 12, 6, 2, g_crTextColor, 1, 0, 0, false, false);
	DrawMeter( cnv, 60, 25, 120, 30, nHPPerc, rgb(0, 255, 0) );
	
	CBCanvasDrawText(cnv, strLine[2], "Arial", 12, 6, 3.6, g_crTextColor, 1, 0, 0, false, false);
	DrawMeter( cnv, 60, 44, 120, 49, nSMPPerc, rgb(0, 0, 255) );
	
	DrawMeter( cnv, 60, 62, 120, 67, nCharge, rgb(255, 0, 0) );

}


//Obtain player info.
//assumes pstrArray is already initialized.
void ObtainFighterInfo(std::string* pstrArray, int nParty, int nFighter)
{
	//Name...
	std::string strName = CBGetFighterName(nParty, nFighter);
	pstrArray[0] = strName;

	//HP...
	std::string strHP = Int2String((int)CBGetFighterHP(nParty, nFighter));
	std::string strMaxHP = Int2String((int)CBGetFighterMaxHP(nParty, nFighter));
	std::string strText = CBLoadString(887, "HP:") + " " + strHP + "/" + strMaxHP;
	pstrArray[1] = strText;

	//SMP
	std::string strSMP = Int2String((int)CBGetFighterSMP(nParty, nFighter));
	std::string strMaxSMP = Int2String((int)CBGetFighterMaxSMP(nParty, nFighter));
	strText = CBLoadString(888, "SMP:") + " " + strSMP + "/" + strMaxSMP;
	pstrArray[2] = strText;

}


//render player stats
void RenderStats()
{
	CNVID cnvPlayer = CBCreateCanvas(128, 75);
	int y;
	y = g_nSizeY - CBCanvasHeight( cnvPlayer ) - 30;

	int nX = 10;
	//Render stats for each player...
	int i = 0;
	int j = CBGetPartySize( PLAYER_PARTY );
	for ( i = 0; i < j; i++ )
	{
		//check if the player is valid...
		if ( CBGetFighterName( PLAYER_PARTY, i ).compare( "" ) != 0 ) 
		{
			CBCanvasFill( cnvPlayer, g_crTranspColor );
			//the player is valid...
			FIGHTER f;
			f.nPartyIdx = PLAYER_PARTY;
			f.nFighterIdx = i;
			DrawPlayerStats( f, cnvPlayer );
			int yy = i * 30;
			//CBCanvas2CanvasBlt( cnv, g_cnvMenu, 0, yy );
			//CBCanvas2CanvasBltTransparent( cnv, g_cnvMenu, 0, yy, g_crTranspColor );
			CBDrawCanvasTransparent(cnvPlayer, nX, y, g_crTranspColor);
			nX += 130;
		}
	}
	CBDestroyCanvas(cnvPlayer);
}


//render the scene...
//if bRefreshNow is true, then flip the scene forward
void renderNow( bool bRefreshNow )
{
	//draw the background...
	CBDrawCanvas( g_cnvBkg, 0, 0 );

	FIGHT_EVENT event;
	while ( GetNextFightEvent( &event ) ) 
	{
		RenderEvent( event );
	}

	RenderEnemies();
	RenderPlayers();

	RenderMenu();

	if (bRefreshNow)
		CBRefreshScreen();
}
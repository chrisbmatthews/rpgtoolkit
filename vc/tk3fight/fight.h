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
////////////////////////////////////////////////////
// fight.h -- header file for main fight entries

#include "sdk\tkplugin.h"

#ifndef FIGHT_H
#define FIGHT_H

//menus
#define MENU_MAIN 0
#define MENU_ITEM 1
#define MENU_SPC 2


typedef struct _tagSprite
{
	ANMID anm;	//animation
	std::string strAnimation;	//the animation stance
	CNVID cnv;	//canvas for the sprite
	int x, y;	//location of the sprite on the screen (top-left corner)
	bool bDead;	//is the player dead?
} SPRITE;

typedef struct _tagLastMenu
{
	FIGHTER fighter;	//last fighter
	int nMenu;		//menu drawn
	int nTop;			//top of menu
} LAST_MENU;

void BeginSystem();
void EndSystem();

int BeginFight( int nEnemyCount, int nSkillLevel, std::string strBackground, bool bCanRun );

int ScanKeys();
int MainMenuScanKeys();
int ItemMenuScanKeys();
int SPCMenuScanKeys();

int ItemIndex( int nScreenIndex );
int aliveLowerIdx( int nPartyIdx );
int aliveUpperIdx( int nPartyIdx );
FIGHTER SelectFighter( bool bStartOnPlayers );

void CreateSprites();
void DestroySprites(); 

void QueueFighter( FIGHTER fighter );
bool NextFighter( FIGHTER* p_fighter );

void AnimateFighter( FIGHTER fighter, std::string strAnimation, FIGHTER target );
void DrawMeter( CNVID cnv, int x1, int y1, int x2, int y2, int nPercent, long crColor );

void renderNow( bool bRefreshNow = true );
void DrawMenu( CNVID cnv );
void RenderItemSublist(int nTopMenu, CNVID cnv);
void RenderSPCSublist(int nTopMenu, CNVID cnv);

void DrawCursor( int nMenuX, int nMenuY );
void RenderMenu();
void RenderStats();
void ObtainFighterInfo(std::string* pstrArray, int nParty, int nFighter);
void DrawPlayerStats(FIGHTER fighter, CNVID cnv);

void RenderSprite( SPRITE sprite );
void RenderLastFrame( SPRITE sprite );
void RenderEnemies( int nExcludeIndex = -1, int nIgnoreHP = -1 );
void RenderPlayers( int nExcludeIndex = -1 );
void RenderEvent( FIGHT_EVENT event );
void RenderText( FIGHTER fighter, std::string strText, int nSize, long crColor );

#endif
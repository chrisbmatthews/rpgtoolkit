//All contents copyright 2003, Christopher Matthews
//All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
//Read LICENSE.txt for licensing info

///////////////////////////////////////////////////////
//
// MODULE: tkgfx.h
//
// PURPOSE: dll for toolkit graphics engine (header)
//
// Copyright 2000 by Christopher B. Matthews
//
///////////////////////////////////////////////////////

//=====================================================
// Alterations by Delano for 3.0.4 
// New isometric tile system.
//
// Function prototype: createIsometricMask.
//=====================================================

/*
 * Includes
 */

#include "resource.h"		// main symbols
#include "stdafx.h"
#include <set>
#include <string>
#include "CTile.h"

#define CNV_HANDLE long

#ifndef TKGFX_H
#define TKGFX_H

/*
 * Structures...
 */

//////////////////////////////////////////
// GLOBALS
long g_lCallbacks[60];		//array of visual basic function addresses (callbacks)
int g_nNumCallbacks;			//number of elements in the above array.
//board...
	char board[50][50][9][255];
	char boardback[255],borderback[255];
	long boardcolor,bordercolor;
	int ambienteffect;
	int ambientred[50][50][9], ambientgreen[50][50][9], ambientblue[50][50][9];
//tile...
	long tile[33][33];
	int detail;
//
	//std::set<std::string> gsetTransparentTiles;		//set listing what tiles are transparent
//256 color palette
	//int color256;		//256 color palette loaded? 0-no, 1-yes
	//long rgbpal[256];	//the palette in question
//tileset...
	tilesetHeader tileset;

//enemy
	int sizeX, sizeY;	//enemy size.
//general
	double ddx,ddy;		//coord conversion
	int addonr,addong,addonb;	//addon colors
	int tilesX, tilesY;	//screen size, in tiles
	int g_topX, g_topY;	//top x, y of board

///////////////////////////////////////////////
//Exported functions...
long APIENTRY GFXFunctionPtr(long functionAddr);

int APIENTRY GFXInit(long *pCBArray, int nCallbacks);

int APIENTRY GFXInitScreen( int screenX,
														int screenY );

int APIENTRY GFXAbout		( );

int APIENTRY GFXdrawpixel	( long hdc, 
													long x, 
													long y, 
													long col );

int APIENTRY GFXdrawboard ( int hdc,
														int maskhdc,
														int layer,
														int topx, 
														int topy,
														int tilesX,
														int tilesY,
														int nBsizex,
														int nBsizey,
														int nBsizel,
														int ar, 
														int ag, 
														int ab,
														int nIsometric = 0,
														int nIsoEvenOdd = 0 );

int APIENTRY GFXdrawtile		( const char* fname, 
													double x, 
													double y, 
													int rred, 
													int ggreen, 
													int bblue, 
													long hdc,
													int nIsometric = 0,
													int nIsoEvenOdd = 0 );

int APIENTRY GFXdrawtilemask( char fname[], 
									 double x, 
									 double y, 
									 int rred, 
									 int ggreen, 
									 int bblue, 
									 long hdc,
									 int nDirectBlt = 1,
									 int nIsometric = 0,
									 int nIsoEvenOdd = 0 ) ;

int APIENTRY GFXdrawTstWindow ( char fname[],
														 int hdc,
														 int start,
														 int tilesx, int tilesy,
														 int nIsometric = 0 );


int APIENTRY GFXdrawEnemy	( char fname[],
													int x, 
												  int y,
													int r,
													int g,
													int b, 
												  long hdc );

int APIENTRY GFXBitBltTransparent ( long hdcDest,
																 long xDest,
																 long yDest,
																 long width,
																 long height,
																 long hdcSrc,
																 long xSrc,
																 long ySrc,
																 int transRed,
																 int transGreen,
																 int transBlue );

int APIENTRY GFXBitBltTranslucent ( long hdcDest,
																		long xDest,
																		long yDest,
																		long width,
																		long height,
																		long hdcSrc,
																		long xSrc,
																		long ySrc );

int APIENTRY GFXBitBltAdditive ( long hdcDest,
																 long xDest,
																 long yDest,
																 long width,
																 long height,
																 long hdcSrc,
																 long xSrc,
																 long ySrc,
																 long nPercent );

int APIENTRY GFXClearTileCache();

long APIENTRY GFXGetDOSColor( int nColorIdx );

int APIENTRY GFXDrawTileCNV ( const char* fname, 
									 				 double x, 
													 double y, 
													 int rred, 
													 int ggreen, 
													 int bblue, 
													 CNV_HANDLE cnv,
													 int nIsometric,
													 int nIsoEvenOdd );

int APIENTRY GFXDrawTileMaskCNV ( char fname[], 
									 double x, 
									 double y, 
									 int rred, 
									 int ggreen, 
									 int bblue, 
									 CNV_HANDLE cnv,
									 int nDirectBlt,
									 int nIsometric,
									 int nIsoEvenOdd );

///////////////////////////////////////////////
//Local functions...
void initboard					( );

void openboard					( char fname[],
													int topx,
													int topy,
													int tilesX,
													int tilesY );

void openWinTile				( char fname[] );

void opentile						( char fname[] );

void increasedetail			( );

void increasecolors			( );

void drawBoardTile ( int x, 
										 int y, 
										 int layer,
										 int ar, 
										 int ag, 
										 int ab,
										 int tilesX,
										 int tilesY, 
										 long hdc,
										 long maskhdc,
										 int nIsometric = 0,
										 int nIsoEvenOdd = 0 );

void copyimg						( long x1, 
													long y1, 
													long x2, 
													long y2, 
													long xdest, 
													long ydest, 
													long hdc );

int checkmatch					( int x, 
													int y, 
													int layer,
													int tilesX,
													int tilesY, 
													int *xmatch, 
													int *ymatch );

void resolveName				( char fname[] );

//void open256pal					( );

long rgb								( int red, 
													int green, 
													int blue );

int red									( long rgb );

int green								( long rgb );

int blue								( long rgb );

void extention					( char fname[], 
													char toReturn[] );

int getTileNum					( char fname[] );

void openFromTileSet		( char fname[], 
													int number );

int tilesetInfo					( char fname[] );

long calcInsertionPoint ( int d, int number );

void tilesetFilename ( char fname[], char toReturn[] );

void openEnemy ( char fname[] );

// Added for 3.0.4 by Delano
void createIsometricMask ();

#endif
/* end of file */

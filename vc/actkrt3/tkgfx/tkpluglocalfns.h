//All contents copyright 2003, Christopher Matthews
//All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
//Read LICENSE.txt for licensing info

////////////////////////////////////////////////////////////////
//
// If you want your plugin to work, DO NOT MODIFY THIS FILE!
//
////////////////////////////////////////////////////////////////
//
// RPG Toolkit Development System, Version 2
// Plugin Libraries
// Developed by Christopher B. Matthews (Copyright 2000)
//
// You may use these libraries freely.  You may even modify 
// them, but doing so may cause your plugin to stop working.
//
////////////////////////////////////////////////////////////////
//
// File:					tkpluglocalfns.h
// Includes:			
// Description:		Local Functions-- these functions are 
//								provided as helper functions for your
//								plugin.  Some are *required* by the
//								plugin manager to be here.
//
////////////////////////////////////////////////////////////////

//==============================================================
// Alterations by Delano for 3.0.4 
// For new isometric tile system
//
// drawIsoTile
// opentile		- called by openWinTile only.
// openFromTileSet
// openWinTile	- is this actually called by anything?
//				  possibly depreciated by the CTile class?
// tilesetInfo
// calcInsertionPoint
//
// New: createIsometricMask

// Variables added:
long isoMaskGfx[65][33];	 // Note the CTile arrays run from 0 to 31!
bool bGfxCreateIsoMaskOnce = false;

// New: constants:

#define TSTTYPE   0
#define ISOTYPE   2
#define ISODETAIL 150		//Arbitrary, but same as toolkit3, commonTileset!

//
// Will the sdk need updating?!
//==============================================================


#include "callbacks.h"
#include <stdlib.h>


///////////////////////////////////////////////////////
//
// Function: rgb
//
// Parameters: red, green, blue- color
//
// Action: converts color compnents to an rgb color
//
// Returns: rgb color
//
///////////////////////////////////////////////////////
long rgb ( int red, 
					 int green, 
					 int blue ) 
{
	if (red>255) red=255;
	if (red<0) red=0;
	if (green>255) green=255;
	if (green<0) green=0;
	if (blue>255) blue=255;
	if (blue<0) blue=0;
	return RGB(red,green,blue);
}


///////////////////////////////////////////////////////
// INTERNAL FUNCTIONS

///////////////////////////////////////////////////////
//
// Function: initboard
//
// Parameters: 
//
// Action: Init s the board
//
// Returns: 
//
///////////////////////////////////////////////////////
void initboard() 
{
	//init board globals
	for ( int x=0; x<=50; x++ )
	{
		for ( int y=0; y<=50; y++ )
		{
			for ( int lay=0; lay<=8; lay++ ) 
			{
				strcpy(board[x][y][lay],"");
				ambientred[x][y][lay]=0;
				ambientgreen[x][y][lay]=0;
				ambientblue[x][y][lay]=0;
			}
		}
	}
	strcpy(boardback,"");
	strcpy(borderback,"");
	boardcolor=0;
	bordercolor=0;
	ambienteffect=0;
}


///////////////////////////////////////////////////////
//
// Function: openboard
//
// Parameters: fname- the filename to open
//						 topx- the topx to load to
//						 topy- the topy to load to
//						 tilesX, tilesY- x, y size to draw
//
// Action: opens a board
//
// Returns: 
//
///////////////////////////////////////////////////////
void openboard( char fname[],
							  int topx,
								int topy,
								int tilesX,
								int tilesY ) 
{
	//opens the board file.

	//char inputboard[51][51][9][255];		//temp array

	int x, y, lay, BsizeX, BsizeY;
	char fileheader[255],dummy[255];

	FILE *infile=fopen(fname,"rt");

	if(!infile) {
		return;
	}

	fgets(fileheader,255,infile);
	if (strcmpi(fileheader,"RPGTLKIT BOARD")) {
		//version 2.0 board
		fgets(dummy,255,infile);	//majorver
		fgets(dummy,255,infile);	//minorver
		int minor=atoi(dummy);
		fgets(dummy,255,infile);	//isregistered?
		fgets(dummy,255,infile);	//reg code

		//now, play with the sizes...
		if (minor==1) 
		{
			//it's a version 2.1 board
			//(ie. it is muti-sized)
			//now find out how big...
			fgets(dummy,255,infile);	//sizex
            BsizeX=atoi(dummy);
			fgets(dummy,255,infile);	//sizey
			BsizeY=atoi(dummy);
		}

		if (minor==0) 
		{
			BsizeX=19;
			BsizeY=11;
    }
		
		//board data:
		for ( x=1; x<=BsizeX; x++ ) 
		{
			for ( y=1; y<=BsizeY; y++ ) 
			{
				for ( lay=1; lay<=8; lay++ ) 
				{
					char tilename[255];
					char ar[255];
					char ag[255];
					char ab[255];
					fgets(tilename,255,infile);
					fgets(ar,255,infile);
					fgets(ag,255,infile);
					fgets(ab,255,infile);
					fgets(dummy,255,infile);

					int arX = x-topx;
					int arY = y-topy;
					if (arX >= 1 && arY >= 1 &&
						  arX <= tilesX+topx && arY <= tilesY+topy)
					{
						strcpy(board[arX][arY][lay],tilename);
						ambientred[arX][arY][lay] = atoi(ar);
						ambientgreen[arX][arY][lay] = atoi(ag);
						ambientblue[arX][arY][lay] = atoi(ab);
					}

					//if (x>=topx && x<=topx+tilesX &&
					//		y>=topy && y<=topy+tilesY)
					/*if (arX >= topx && arY >= topy &&
						  arX <= topx+tilesX && arY <= topy+tilesY)
					{
						fgets(board[arX][arY][lay],20,infile);

						fgets(dummy,255,infile);
						ambientred[arX][arY][lay]=atoi(dummy);

						fgets(dummy,255,infile);
						ambientgreen[arX][arY][lay]=atoi(dummy);

						fgets(dummy,255,infile);
						ambientblue[arX][arY][lay]=atoi(dummy);

						fgets(dummy,255,infile);		//tiletype
					}
					else
					{
						//dummy-- just get it.
						fgets(dummy,255,infile);
						fgets(dummy,255,infile);
						fgets(dummy,255,infile);
						fgets(dummy,255,infile);
						fgets(dummy,255,infile);
					}*/
				}
			}
		}
		fgets(boardback,255,infile);
		fgets(borderback,255,infile);

		fgets(dummy,255,infile);
		boardcolor=atol(dummy);

		fgets(dummy,255,infile);
		bordercolor=atol(dummy);

		fgets(dummy,255,infile);
		ambienteffect=atoi(dummy);

	}
	else 
	{
    //version 1.4 board
		fclose(infile);
		infile=fopen(fname,"rt");
		
		for ( y=1; y<=tilesY; y++ ) 
		{
			for ( x=1; x<=tilesX; x++ ) 
			{
				fgets(dummy,255,infile);	//tiletypes
			}
		}
		fgets(dummy,255,infile);	//dummy
		for ( y=1; y<=tilesY; y++ ) 
		{
			for ( x=1; x<=tilesX; x++ ) 
			{
				fgets(board[x][y][1],20,infile);
				if(strcmpi(board[x][y][1],"void")) 
				{
					strcpy(board[x][y][1],"");
				}
			}
		}
		for ( x=1; x<=8; x++ ) 
		{
			fgets(dummy,255,infile);	//ignored
		}
		fgets(dummy,255,infile);		//board color
		boardcolor=atoi(dummy);
	}
	fclose(infile);
}

///////////////////////////////////////////////////////
//
// Function: openWinTile
//
// Parameters: fname- filename to open
//
// Action: opens a tile and preps it to 32x32x24 bit
//
// Returns: 
//
///////////////////////////////////////////////////////

// Delano - is this actually used by anything?

void openWinTile ( char fname[] ) 
{
	opentile(fname);
	//size up to 32x32
	if (detail==2 || detail==4 || detail==6)
	{
		increasedetail();
	}
	//increase colors to 16.7 million...
	if (detail==3 || detail==5)
	{
		increasecolors();
	}
}


///////////////////////////////////////////////////////
//
// Function: opentile
//
// Parameters: fname- filename to open
//
// Action: opens a tile
//
// Returns: 
//
// Called by: openWinTile only.
//
///////////////////////////////////////////////////////

//   Delano - if openWinTile isn't being used then neither is this...
//			  Note: tiles placed on the board use the CTile class.
//			  The GFXDrawTstWindow loads directly via openFromTileset

void opentile( char fname[] ) 
{
	int x,y;
	char dummy[255];
	int comp;

	char ext[255];

	extention(fname, ext);

	if(strcmpi(ext,"TST")==0) 
	{
		int number=getTileNum(fname);
		char fn[255];
		tilesetFilename(fname, fn);
		openFromTileSet(fn,number);
		return;
	}

	bool bTransparentParts = false;

	FILE* infile=fopen(fname,"rt");
	if(!infile) {
		return;
	}

	fgets(dummy,255,infile);
	if (strcmpi(dummy,"RPGTLKIT TILE\n")==0) {
		//Version 2
		fgets(dummy,255,infile);	//majorver
		fgets(dummy,255,infile);	//minorver

		fgets(dummy,255,infile);	//detail
		detail=atoi(dummy);

		fgets(dummy,255,infile);	//compression used? 1-yes, 0-no
		comp=atoi(dummy);
		if (comp==0) 
		{
			//No compression!
			if (detail==1 || detail==3 || detail==5) 
			{
				for (x=1;x<=32;x++) 
				{
					for (y=1;y<=32;y++) 
					{
 						fgets(dummy,255,infile);
						tile[x][y]=atol(dummy);
						if (tile[x][y] == -1)
						{
							bTransparentParts = true;
						}
					}
				}
			}
			if (detail==2 || detail==4 || detail==6) 
			{
				for (x=1;x<=16;x++) 
				{
					for (y=1;y<=16;y++) 
					{
						fgets(dummy,255,infile);
						tile[x][y]=atol(dummy);
						if (tile[x][y] == -1)
						{
							bTransparentParts = true;
						}
					}
				}
			}
		}
		if (comp==1) 
		{
			//Compression used!!!
			int xx,yy,times;
			long clr;
			if (detail==1 || detail==3 || detail==5) 
			{
				xx=1;yy=1;
				while(xx<33) 
				{
					fgets(dummy,255,infile);
					times=atoi(dummy);

					fgets(dummy,255,infile);
					clr=atol(dummy);

					if (clr == -1)
					{
						bTransparentParts = true;
					}

					for (int loopit=1;loopit<=times;loopit++) 
					{
						tile[xx][yy]=clr;
						yy++;
						if (yy>32) 
						{
							yy=1;
							xx++;
						}
					}
				}
			}
			if (detail==2 || detail==4 || detail==6) {
				xx=1;yy=1;
				while(xx<17) 
				{
					fgets(dummy,255,infile);
					times=atoi(dummy);

					fgets(dummy,255,infile);
					clr=atol(dummy);

					if (clr == -1)
					{
						bTransparentParts = true;
					}

					for (int loopit=1;loopit<=times;loopit++) 
					{
						tile[xx][yy]=clr;
						yy++;
						if (yy>16) 
						{
							yy=1;
							xx++;
						}
					}
				}
			}
		}
	}
	else {
		//Version 1
		char part;
		int thevalue=0;
		
		fclose(infile);
		FILE* infile=fopen(fname,"rt");
		
		if(!infile) {
			return;
		}
		detail=4;
		for (int y=1;y<=16;y++) 
		{
			fgets(dummy,255,infile);
			for (int x=1;x<=16;x++) 
			{
				part=dummy[x-1];
				thevalue=(int)part-33;
				tile[x][y]=thevalue;
			}
		}
	}
	fclose(infile);

	if (bTransparentParts)
	{
		//gsetTransparentTiles.insert(fname);
	}
}


///////////////////////////////////////////////////////
//
// Function: increasedetail
//
// Parameters: 
//
// Action: increases the detail of the tile in memory
//
// Returns: 
//
///////////////////////////////////////////////////////
void increasedetail() 
{
	long int btile[17][17];
	int x,y;

	if (detail==2) detail=1;
	if (detail==4) detail=3;
	if (detail==6) detail=5;

	//backup old tile
	for (x=1;x<=16;x++) 
	{
		for (y=1;y<=16;y++) 
		{
			btile[x][y]=tile[x][y];
			tile[x][y]=-1;
		}	
	}
	//increase detail
	int xx=1, yy=1;
	for (x=1;x<=16;x++) 
	{
		for (y=1;y<=16;y++) 
		{
			tile[xx  ][yy  ] =btile[x][y];
			tile[xx  ][yy+1] =btile[x][y];
			tile[xx+1][yy  ] =btile[x][y];
			tile[xx+1][yy+1] =btile[x][y];
			yy=yy+2;
		}
		xx=xx+2;
		yy=1;
	}
}


///////////////////////////////////////////////////////
//
// Function: increasecolors
//
// Parameters: 
//
// Action: increases the color depth of the tile in 
//				memory
//
// Returns: 
//
///////////////////////////////////////////////////////
void increasecolors() 
{
	/*if ( color256==0 ) 
	{
		color256=1;
		open256pal();
	}*/
	for (int x=1;x<=32;x++) 
	{
		for (int y=1;y<=32;y++) 
		{
			if(tile[x][y]!=-1) 
			{
				//tile[x][y]=rgbpal[tile[x][y]];
				tile[x][y]=GFXGetDOSColor(tile[x][y]);
			}
		}
	}
}


///////////////////////////////////////////////////////
//
// Function: drawBoardTile
//
// Parameters: x- the x coord to draw to
//						 y- the y coord to draw to
//						 layer- the layer we are drawing to
//						 ar, ag, ab- the shade (rgb)
//						 hdc- device to draw to
//						 maskhdc- hdc of mask device
//								false- no, just draw the tile
//								true - yes.  black where pixels, 
//											white where transp.
//						 nIsometric - 0= draw 2d regular tile
//													1=draw isometric tile
//						 nIsoEvenOdd - 0-Draw at iso coords as if the top tile is odd
//													 1-Draw at iso coords as if the top tile is even
//
// Action: Draws a tile, copies it if it has
//				 already been drawn.
//
// Returns: 
//
///////////////////////////////////////////////////////
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
										 int nIsometric,
										 int nIsoEvenOdd  ) 
{
	char theTile[256];
	BoardTile(x, y, layer, 256, theTile);
	if (strcmpi(theTile,"")==10) 
	{
		return;	//nothing
	}
	if (strcmpi(theTile,"")==0) 
	{
		return;	//nothing
	}
	switch(ambienteffect) 
	{
		case 0:
			ar+=0;
			ag+=0;
			ab+=0;
			break;

		case 1:
			ar+=75;
			ag+=75;
			ab+=75;
			break;

		case 2:
			ar+=-75;
			ag+=-75;
			ab+=-75;
			break;

		case 3:
			ar+=0;
			ag+=0;
			ab+=75;
			break;

		//default:
	}
	if (hdc != -1)
	{
		GFXdrawtile( theTile,
							x,
							y,
							BoardRed(x, y, layer)+ar,
							BoardGreen(x, y, layer)+ag,
							BoardBlue(x, y, layer)+ab,
							hdc,
							nIsometric,
							nIsoEvenOdd );
	}
	if (maskhdc != -1)
	{
		GFXdrawtilemask( theTile,
							x,
							y,
							BoardRed(x, y, layer)+ar,
							BoardGreen(x, y, layer)+ag,
							BoardBlue(x, y, layer)+ab,
							maskhdc, 0,
							nIsometric,
							nIsoEvenOdd );
	}
}


///////////////////////////////////////////////////////
//
// Function: drawBoardTile
//
// Parameters: x- the x coord to draw to
//						 y- the y coord to draw to
//						 layer- the layer we are drawing to
//						 ar, ag, ab- the shade (rgb)
//						 cnv- canvas to draw to
//						 maskcnv- canvas of mask device
//								false- no, just draw the tile
//								true - yes.  black where pixels, 
//											white where transp.
//						 nIsometric - 0= draw 2d regular tile
//													1=draw isometric tile
//						 nIsoEvenOdd - 0-Draw at iso coords as if the top tile is odd
//													 1-Draw at iso coords as if the top tile is even
//
// Action: Draws a tile, copies it if it has
//				 already been drawn.
//
// Returns: 
//
///////////////////////////////////////////////////////
void drawBoardTileCNV ( int x, 
										 int y, 
										 int layer,
										 int ar, 
										 int ag, 
										 int ab,
										 int tilesX,
										 int tilesY, 
										 CNV_HANDLE cnv,
										 CNV_HANDLE maskcnv,
										 int nIsometric,
										 int nIsoEvenOdd  ) 
{
	char theTile[256];
	BoardTile(x, y, layer, 256, theTile);
	if (strcmpi(theTile,"")==10) 
	{
		return;	//nothing
	}
	if (strcmpi(theTile,"")==0) 
	{
		return;	//nothing
	}
	switch(ambienteffect) 
	{
		case 0:
			ar+=0;
			ag+=0;
			ab+=0;
			break;

		case 1:
			ar+=75;
			ag+=75;
			ab+=75;
			break;

		case 2:
			ar+=-75;
			ag+=-75;
			ab+=-75;
			break;

		case 3:
			ar+=0;
			ag+=0;
			ab+=75;
			break;

		//default:
	}
	if (cnv != -1)
	{
		GFXDrawTileCNV( theTile,
							x,
							y,
							BoardRed(x, y, layer)+ar,
							BoardGreen(x, y, layer)+ag,
							BoardBlue(x, y, layer)+ab,
							cnv,
							nIsometric,
							nIsoEvenOdd );
	}
	if (maskcnv != -1)
	{
		GFXDrawTileMaskCNV( theTile,
							x,
							y,
							BoardRed(x, y, layer)+ar,
							BoardGreen(x, y, layer)+ag,
							BoardBlue(x, y, layer)+ab,
							maskcnv, 0,
							nIsometric,
							nIsoEvenOdd );
	}
}




///////////////////////////////////////////////////////
//
// Function: copyimg
//
// Parameters: x1, y1, x2, y2- coords of source
//						 xdest, ydest- location to draw to
//						 hdc- device to draw to
//
// Action: bitblts
//
// Returns: 
//
///////////////////////////////////////////////////////
void copyimg ( long x1, 
							 long y1, 
							 long x2, 
							 long y2, 
							 long xdest, 
							 long ydest, 
							 long hdc ) 
{
	int xd=xdest;
	int yd=ydest;
	BitBlt( (HDC)hdc, 
					(long)(xd * ddx), 
					(long)(yd * ddy),
					(long)((x2 - x1) * ddx), 
					(long)((y2 - y1) * ddy),
					(HDC)hdc, 
					(long)(x1 * ddx), 
					(long)(y1 * ddy), 
					SRCCOPY );
}


///////////////////////////////////////////////////////
//
// Function: checkmatch
//
// Parameters: x, y- coords of tile to draw to
//						 layer- layer of tile
//						 xmatch, ymatch- mem locations we will
//													place the answers in
//
// Action: checks if a tile has already been drawn
//
// Returns: 1- success, -1 failure
//
///////////////////////////////////////////////////////
int checkmatch ( int x, 
								 int y, 
								 int layer,
								 int tilesX,
								 int tilesY, 
								 int *xmatch, 
								 int *ymatch )
{
	*xmatch=0;
	*ymatch=0;
	int amatch,goahead;
	amatch=goahead=0;
	
	char theTile[256];
	char testTile[256];

	BoardTile(x, y, layer, 256, theTile);
	int re = BoardRed(x, y, layer);
	int gr = BoardGreen(x, y, layer);
	int bl = BoardBlue(x, y, layer);

	//check if the tile has transparency
	//if it does, then we will say that it needs to
	//be redrawn...
	/*if (gsetTransparentTiles.find(theTile) != gsetTransparentTiles.end())
	{
		//it was in the set...
		return -1;
	}*/

	std::string tileWithPath = "tiles\\";
	tileWithPath += theTile;
	/*if (gsetTransparentTiles.find(tileWithPath) != gsetTransparentTiles.end())
	{
		//it was in the set...
		if (layer > 1)
		{
			return -1;
		}
	}*/

	if (strcmp(theTile, "") == 0)
	{
		if (layer > 1)
		{
			return -1;
		}
	}

	for (int ytest=1;ytest<=y;ytest++) 
	{
		for (int xtest=1;xtest<=tilesX;xtest++) 
		{
			if (amatch!=1) 
			{
				BoardTile(xtest, ytest, layer, 256, testTile);
				if (strcmpi(testTile, theTile)==0) 
				{
					//char stuff[255];
					//might have found a match
					goahead=1;
					if (ytest==y) 
					{
						if (x>xtest) goahead=1;
						if (x<=xtest) goahead=0;
					}
					//ok.  if goahead=1, we are in bounds...
					if (goahead==1) 
					{
						if(BoardRed(xtest, ytest, layer) == re &&
						   BoardGreen(xtest, ytest, layer) == gr &&
						   BoardBlue(xtest, ytest, layer) == bl)
							 {
							//a match!
							*xmatch=xtest;
							*ymatch=ytest;
							return 0;
						}
					}
				}
			}
		}
	}
	return -1;
}


///////////////////////////////////////////////////////
//
// Function: resolveName
//
// Parameters: fname- file name to resolve
//
// Action: removes stupid chars from a filename
//
// Returns: 
//
///////////////////////////////////////////////////////
void resolveName ( char fname[] ) 
{
	char filename[255];
	for (int x=0;x<=255;x++)
	{
		if (fname[x]=='\n' || fname[x]=='\0') 
		{
			filename[x]='\0';
			strcpy(fname,filename);
			return;
		}
		//if (fname[x]!=' ') 
		//{
			filename[x]=fname[x];
		//}
	}
}


///////////////////////////////////////////////////////
//
// Function: open256pal
//
// Parameters: 
//
// Action: opens the 256 color palette
//
// Returns: 
//
///////////////////////////////////////////////////////
/*void open256pal() 
{
	char dummy[255];
	FILE* infile=fopen("256rgb.pal","rt");
	if(!infile) {
		return;
	}

	for (int col=0;col<=255;col++) 
	{
		fgets(dummy,255,infile);
		rgbpal[col]=atol(dummy);
	}
	fclose (infile);
}*/


///////////////////////////////////////////////////////
//
// Function: red, green and blue
//
// Parameters: rgb- a long color
//
// Action: converts color to compnents
//
// Returns: component
//
///////////////////////////////////////////////////////
int red ( long rgb ) 
{
	//returns red component of rgb value.
	int bluecomp=(int)(rgb/65536);
	long takeaway=bluecomp*65536;
	rgb-=takeaway;

	int greencomp=(int)(rgb/256);
	takeaway=greencomp*256;

	int redcomp=rgb-takeaway;
	return redcomp;
}
int green ( long rgb ) 
{
	//returns green component of rgb value.
	int bluecomp=(int)(rgb/65536);
	long takeaway=bluecomp*65536;
	rgb-=takeaway;

	int greencomp=(int)(rgb/256);
	return greencomp;
}
int blue ( long rgb ) 
{
	//returns blue component of rgb value.
	int bluecomp=(int)(rgb/65536);
	return bluecomp;
}


///////////////////////////////////////////////////////
//
// Function: extention
//
// Parameters: fname- filename
//
// Action: get extention of the filename
//
// Returns: 
//
///////////////////////////////////////////////////////
void extention ( char fname[], char toReturn[] ) 
{
	//finds extention of a file.
	//returns it.
	//example call:
	//char *ba;
	//*ba=extention("la.bmp");

	int col=0, yes=0;
	int length=strlen(fname);
	char part;

	toReturn[0] = '\0';

	while(col<length) 
	{
		part=fname[col];
		col++;
		if(part=='.') yes=1;
	}

	part='t';
	col=0;
	
	if (yes==1) 
	{
		char ret[255];
		while(part!='.') 
		{
			part=fname[col];
			col++;
		}
		for (int extget=1;extget<=3;extget++) 
		{
			part=fname[col];
			col++;
			ret[extget-1]=part;
			ret[extget]='\0';
		}
		strcpy(toReturn,ret);
		//return toReturn;
	}
	//return "";
}


///////////////////////////////////////////////////////
//
// Function: getTileNum
//
// Parameters: fname- the filename
//
// Action: gets the tile number from a tileset filename
//
// Returns: the number
//
///////////////////////////////////////////////////////
int getTileNum ( char fname[] ) 
{
	//determine tile number from tst filename
	//ie. tileset.tst48 returns 48
	//return -1 on failure.
	char part;

	int length=strlen(fname);
	for (int t=0;t<length;t++) 
	{
		part=fname[t];
		if (part=='.') 
		{
			char num[255];
			int cnt=0;
			for (int x=t+4;x<length;x++) 
			{
				num[cnt]=fname[x];
				num[cnt+1]='\0';
				cnt++;
			}
			int toReturn=atoi(num);
			return toReturn;
		}
	}
	return -1;
}


///////////////////////////////////////////////////////
//
// Function: drawIsoTile
//
// Parameters: hdc - canvas to draw to.
//			   xLoc, yLoc - location to draw at.
//
// Action: draw tile in tilemem isometrically at xLoc, yLoc
//
// Returns: 
//
// Called by: GFXDrawTstWindow
//
//=====================================================
// Edited: for 3.0.4 by Delano
//		   Added support for new isometric tilesets.
//
//		   Receives new parameter from GFXDrawTstWindow:
//		   nSetType is passed in from tk3 = 2 for .iso, 0 else.
//
//		   Transparent pixels are now drawn as the 
//		   background colour (127,127,127) - changed to
//		   stop flickering during scrolling.
//=====================================================
///////////////////////////////////////////////////////

void drawIsoTile(int hdc, int xLoc, int yLoc, int nSetType)
{

	long backColor = rgb(127,127,127);

	//======================================
	// Added for new tile type.
	// New type uses standard tile[][].

	// Setup the count for tile.
	int xCount = 1, yCount = 1;

	// This passed from GFXDrawTstWindow for new iso tiles.
	if (nSetType == ISOTYPE)
	{

		// Loop over every pixel in the *mask* and set pixels from the tile
		// for black (transparent) pixels in the mask.
		// Note: these arrays run from 1 to 32, whereas the CTile arrays run from
		// 0 to 31.
		for (int xxx = 1; xxx <= 64; xxx++)
		{
			for (int yyy = 1; yyy <= 32; yyy++)
			{
				if (isoMaskGfx[xxx][yyy] == 0) //If black (transparent).
				{
					if (tile[xCount][yCount] == -1)
					{
						//Draw transparent = background.
						//Added to stop scrolling tilesets flickering.
						GFXdrawpixel(hdc,xxx+xLoc,yyy+yLoc,backColor);
					} 
					else 
					{
						// Set the *next* pixel in the tile.
						GFXdrawpixel(hdc,xxx+xLoc,yyy+yLoc,tile[xCount][yCount]);
					}

					//Increment the tile entry.
					yCount++;
					if (yCount > 32) 
					{
						xCount++;
						yCount = 1;
					}
				}
			}
		}
		return;
	} // Close if(nSetType == ISOTYPE)

	// End new isometrics. Further changes below!
	//===========================================


	//do isometric tile...
	int nQuality = 3;
	int isotile[128][64];
	int x, y;
	for (x = 0; x < 128; x++)
	{
		for (y = 0; y < 64; y++)
		{
			isotile[x][y] = -1;
		}
	}
  
	int tx, ty;

	for (tx = 0; tx < 32; tx++)
	{
		for (ty = 0; ty < 32; ty++)
		{
			if (tile[tx][ty] == -1)
			{
			}
			else
			{
				x = 62 + tx * 2 - ty * 2;
				y = tx + ty;
				int crColor = tile[tx][ty];
				int crColor2 = tile[tx+1][ty];
				if ((tile[tx][ty] != -1) && (tile[tx+1][ty] != -1) && (nQuality == 1 || nQuality == 2))
				{
					int r1 = util::red(crColor);
					int g1 = util::green(crColor);
					int b1 = util::blue(crColor);

					int r2 = util::red(crColor2);
					int g2 = util::green(crColor2);
					int b2 = util::blue(crColor2);

					int ra = (r2 - r1) / 4;
					int ga = (g2 - g1) / 4;
					int ba = (b2 - b1) / 4;

					for (int tempX = x; tempX < x + 4; tempX++)
					{
						int col = util::rgb(r1, g1, b1);
						isotile[tempX][y] = col;

						r1 += ra;
						g1 += ga;
						b1 += ba;
					}
				}
				else
				{
					for (int tempX = x; tempX < x + 4; tempX++)
					{
						isotile[tempX][y] = crColor;
					}
				}
			}
		}
	}
  
  //now shrink the iso tile...
	int smalltile[64][32];
	if (nQuality == 3)
	{
    //first shrink on x...
    int medTile[64][64];
    int xx = 0;
		int yy = 0;
    for(x = 0; x < 128; x+=2)
		{
			for (y=0; y<64; y++)
			{
				int c1 = isotile[x][y];
				int c2 = isotile[x+1][y];

				if (c1 != -1 && c2 != -1)
				{
					int r1 = util::red(c1);
					int g1 = util::green(c1);
					int b1 = util::blue(c1);

					int r2 = util::red(c2);
					int g2 = util::green(c2);
					int b2 = util::blue(c2);

					int rr = (r1 + r2) / 2;
					int gg = (g1 + g2) / 2;
					int bb = (b1 + b2) / 2;
					medTile[xx][yy] = util::rgb(rr, gg, bb);
				}
				else
				{
					medTile[xx][yy] = c1;
				}
				yy++;
			}
			xx++;
			yy=0;
    }
    
    //now shrink on y...
    xx = yy = 0;
    for(x = 0; x<64; x++)
		{
      for(y = 0; y < 64; y+= 2)
			{
        int c1 = medTile[x][y];
        int c2 = medTile[x][y + 1];
        
        if(c1 != -1 && c2 != -1)
				{
					int r1 = util::red(c1);
					int g1 = util::green(c1);
					int b1 = util::blue(c1);

					int r2 = util::red(c2);
					int g2 = util::green(c2);
					int b2 = util::blue(c2);

					int rr = (r1 + r2) / 2;
					int gg = (g1 + g2) / 2;
					int bb = (b1 + b2) / 2;
					smalltile[xx][yy] = util::rgb(rr, gg, bb);
				}
				else
				{
          smalltile[xx][yy] = c1;
				}
        yy++;
      }
      xx++;
      yy = 0;
    }
	}
	else
	{
		int xx = 0;
		int yy = 0;
		for (x= 0; x < 128; x+=2)
		{
			for (y=0; y<64; y+=2)
			{
				int c1 = isotile[x][y];
				int c2 = isotile[x+1][y];
				if (c1 != -1 && c2 != -1 && nQuality == 2)
				{
					int r1 = util::red(c1);
					int g1 = util::green(c1);
					int b1 = util::blue(c1);

					int r2 = util::red(c2);
					int g2 = util::green(c2);
					int b2 = util::blue(c2);

					int rr = (r1 + r2) / 2;
					int gg = (g1 + g2) / 2;
					int bb = (b1 + b2) / 2;
					smalltile[xx][yy] = util::rgb(rr, gg, bb);
				}
				else
				{
					smalltile[xx][yy] = c1;
				}
				yy++;
			}
			xx++;
			yy=0;
		}
	}

	//now draw...
	for (int xx = 0; xx<64; xx++)
	{
		for (int yy = 0; yy<32; yy++)
		{
			if (smalltile[xx][yy] == -1)
			{
				//Draw transparent = background colour.
				//Added to stop scrolling tilesets flickering.
				GFXdrawpixel(hdc,xx+xLoc,yy+yLoc,backColor);
			} 
			else 
			{
				GFXdrawpixel(hdc,xx+xLoc,yy+yLoc,smalltile[xx][yy]);
			}
		}
	}
}

///////////////////////////////////////////////////////
//
// Function: openFromTileSet
//
// Parameters: fname  - the filename to open
//			   number - the number to open
//
// Action: opens a tile from a tileset
//
// Returns: 
//
// Called by: GFXDrawTstWindow, opentile
//
// Note: The same function exists as a member of
//		 the CTile class!!
//
//=====================================================
// Edited: Delano 15/06/04 for 3.0.4
//		   Added support for new isometric tilesets.
//
//  Added code for opening the new .iso format. The file
//  consists of:
//	  Header:			tileset (6 bytes as .tst)
//	  Isometric tiles:	32x32x3	(3072 bytes) (as .tst)
//
//		Header:	tileset.version = 30
//				tileset.tilesInSet
//				tileset.detail = ISODETAIL  - Arbitrary constant.
//=====================================================
///////////////////////////////////////////////////////
void openFromTileSet ( char fname[], int number ) 
{
	//opens tile #number from a tileset
	//going by the name of fname
	int xx,yy;
	unsigned char rrr,ggg,bbb;

	int a=tilesetInfo(fname);

	if (number<1 || number>tileset.tilesInSet) return;
	
	bool bTransparentParts = false;

	//===============================================
	// Isometric tilesets start here...
	//
	// The tileset information is loaded into tileset
	// for all formats. Different values for .iso.

	// A mask is needed for .iso tiles - this only needs
	// creating once.

	if (!bGfxCreateIsoMaskOnce)
	{
		createIsometricMask();
		bGfxCreateIsoMaskOnce = true;
	}

	// The high detail case for tsts are used for reading
	// the isometric data - tile sizes are the same!

	//Added constants.
	if ((a == TSTTYPE) || (a == ISOTYPE))
	{

		// Set up the file for reading. If unable to open, exit.
		FILE* infile=fopen(fname,"rb");
		if(!infile) 
		{
			return;
		}

		// Track to the byte position we're after
		// .iso case in calcInsertionPoint added (same as detail = 1)
		long insertPoint = calcInsertionPoint(tileset.detail,number);
		fseek(infile, insertPoint, 0);

		detail=tileset.detail;
		switch(detail) 
		{
			case ISODETAIL:				
				//Isometric case. Fall through! No more additions needed.
			case 1:
				//32x32x16.7 million;
				for (xx=1;xx<=32;xx++) 
				{
					for (yy=1;yy<=32;yy++) 
					{
						fread(&rrr,1,1,infile);
						fread(&ggg,1,1,infile);
						fread(&bbb,1,1,infile);
						if ((int)rrr==0 && (int)ggg==1&& (int)bbb==2) 
						{
							tile[xx][yy]=-1;
							bTransparentParts = true;
						}
						else 
						{
							//tile[xx][yy]=rgb((int)bbb,(int)rrr,(int)ggg);
							tile[xx][yy]=rgb((int)rrr,(int)ggg,(int)bbb);
						}
					}
				}
				break;

			case 2:
				//16x16x16.7 million;
				for (xx=1;xx<=16;xx++) 
				{
					for (yy=1;yy<=16;yy++) 
					{
						fread(&rrr,1,1,infile);
						fread(&ggg,1,1,infile);
						fread(&bbb,1,1,infile);
						if ((int)rrr==0 && (int)ggg==1&& (int)bbb==2) 
						{
							tile[xx][yy]=-1;
							bTransparentParts = true;
						}
						else 
						{
							tile[xx][yy]=rgb((int)rrr,(int)ggg,(int)bbb);
						}
					}
				}
				break;

			case 3:
			case 5:
				//32x32x256 (or 16)
				for (xx=1;xx<=32;xx++) 
				{
					for (yy=1;yy<=32;yy++) 
					{
						fread(&rrr,1,1,infile);
						if ((int)rrr==255) 
						{
							tile[xx][yy]=-1;
							bTransparentParts = true;
						}
						else 
						{
							tile[xx][yy]=(int)rrr;
						}
					}
				}
				break;

			case 4:
			case 6:
				//16x16x256 (or 16)
				for (xx=1;xx<=16;xx++) 
				{
					for (yy=1;yy<=16;yy++) 
					{
						fread(&rrr,1,1,infile);
						if ((int)rrr==255) 
						{
							tile[xx][yy]=-1;
							bTransparentParts = true;
						}
						else 
						{
							tile[xx][yy]=(int)rrr;
						}
					}
				}
				break;
		}
		fclose(infile);
	}

	if (bTransparentParts)
	{
		std::string strFile = fname;
		char temp[255];
		itoa(number, temp, 10);
		strFile += temp;
		//gsetTransparentTiles.insert(strFile);
	}
}


///////////////////////////////////////////////////////
//
// Function: tilesetInfo
//
// Parameters: fname- the filename
//
// Action: get info about a tileset
//
// Returns: 
//
// Called by: GFXDrawTstWindow, openFromTileset
//
//=====================================================
// Edited: for 3.0.4 by Delano
//		   Added support for new isometric tilesets.
//         Added set type constants.
//=====================================================
///////////////////////////////////////////////////////
int tilesetInfo( char fname[] ) 
{
	//gets tileset header for filename.
	//returns 0-success, 1 failure.
	FILE* infile=fopen(fname,"rb");
	if(!infile) 
	{
		return 1;
	}

	fread(&tileset,6,1,infile);
	fclose(infile);

	char ex[255];
	extention(fname, ex);



	// Added for new iso tiles.
	if ((tileset.version == 30) && (tileset.detail == ISODETAIL) && (strcmpi(ex,"ISO") == 0))
	{
		// New isometric tileset. Different return for .iso
		return ISOTYPE;

	}
	else if ((tileset.version == 20) && (strcmpi(ex,"TST") == 0))
	{
		// Standard TST.
		return TSTTYPE;		
	}
	return 1;
}


///////////////////////////////////////////////////////
//
// Function: calcInsertionPoint
//
// Parameters: d- detail level
//						 number- tile num
//
// Action: calc insertion point of a tile in a tst
//
// Returns: offset
//
// Called by: openFromTileset only.
//
//=====================================================
// Edited: for 3.0.4 by Delano
//		   Added support for new isometric tilesets.
//		   Added extra case for .iso stacked onto case 1
//=====================================================
///////////////////////////////////////////////////////

long calcInsertionPoint ( int d, int number ) 
{
	long num=(long)number;
	switch(d) 
	{
		case ISODETAIL:
			//Same as for case 1 - fall through!

		case 1:
			//32x32, 16.7 million colors. (32x32x3 bytes each)
			return ((3072 * (num - 1)) + 6);

		case 2:
			//16x16, 16.7 million colors (16x16x3 bytes)
			return ((768 * (num - 1)) + 6);

		case 3:
			//32x32, 256 colors (32x32x1 bytes)
			return ((1024 * (num - 1)) + 6);
		
		case 4:
			//16x16, 256 colors (16x16x1 bytes)
			return ((256 * (num - 1)) + 6);
		
		case 5:
			//32x32, 16 colors (32x32x1 byte)
			return ((1024 * (num - 1)) + 6);

		case 6:
			//16x16, 16 colors (16x16,1 bytes)
			return ((256 * (num - 1)) + 6);

	}
	return 0;
}


///////////////////////////////////////////////////////
//
// Function: tilesetFilename
//
// Parameters: fname- the filename
//
// Action: extract filename from a tst filename
//
// Returns: 
//
// Called by: opentile only.
//
///////////////////////////////////////////////////////

// Delano - this is called by a function which isn't used, 
//          so I haven't modified it but it would need to be.

void tilesetFilename( char fname[], char toReturn[] ) 
{
	//returns filename w/out the number after ext
	char part;
	char ret[255];

	toReturn[0] = '\0';

	int length=strlen(fname);
	for (int t=0;t<length;t++) 
	{
		part=fname[t];
		if (part=='.') 
		{
			strcat(ret,".tst");
			strcpy(toReturn,ret);
			return;
		}
		ret[t]=part;
		ret[t+1]='\0';
	}
	return;
}


//==============================================
//
// New function: Added by Delano for 3.0.4
//
// Creates isometric mask for .iso tiles.
// Uses a shortened version of the rotation code
//
//==============================================

void createIsometricMask ( )
{

	int isotile[128][64];
	int x, y;
	
	//Take a black tile and pass it through the rotation routine.

	int blackTile[32][32];

	for (x = 0; x < 32; x++)
	{
		for (y = 0; y < 32; y++) blackTile[x][y] = 0;
	}
	
	//Initialize the mask.
	for (x = 0; x < 64; x++)
	{
		for (y = 0; y < 32; y++) isoMaskGfx[x+1][y+1] = -1;
	}

	for (x = 0; x < 128; x++)
	{
		for (y = 0; y < 64; y++) isotile[x][y] = -1;
	}
  
	int tx, ty;

	for (tx = 0; tx < 32; tx++)
	{
		for (ty = 0; ty < 32; ty++)
		{

				x = 62 + tx * 2 - ty * 2;
				y = tx + ty;
				int crColor = blackTile[tx][ty];

				for (int tempX = x; tempX < x + 4; tempX++)
				{
					isotile[tempX][y] = crColor;
				}


		}
	} // next tx
  
	//now shrink the iso tile...
	int smalltile[64][32];

	//first shrink on x...
	int medTile[64][64];
	int xx = 0, yy = 0;
	for(x = 0; x < 128; x+=2)
	{
		for (y=0; y<64; y++)
		{
			int c1 = isotile[x][y];

			medTile[xx][yy] = c1;

			yy++;
		}
		xx++;
		yy=0;
	} // next x

	//now shrink on y...
	xx = yy = 0;
	for(x = 0; x<64; x++)
	{
		for(y = 0; y < 64; y+= 2)
		{
			int c1 = medTile[x][y];
    
			smalltile[xx][yy] = c1;

			yy++;
		}
		xx++;
		yy = 0;
	} // next x



	// We now have our isometric mask! Now, load it into the Gfx mask.


	for (x = 0; x < 64; x++)
	{
		for (y = 0; y < 32; y++)
		{
			isoMaskGfx[x+1][y+1] = smalltile[x][y];
		}
	}

	return;
}



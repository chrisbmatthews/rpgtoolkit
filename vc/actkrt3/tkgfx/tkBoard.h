
/////////////////////
// Board class

#include <iostream>
#include <vector>
#include <string>

using namespace std;


class CBoard
{
	public:
		void resize(int nX, int nY, int nL);
		void openboard( string fname,	int topx, int topy, int tilesX, int tilesY );
		int vectPos(int nX, int nY, int nL);
		int setTile(string fileName, int nX, int nY, int nL);

	private:
		vector<string> m_vTileIndex;
		vector<short> m_vTiles;
		vector<short> m_vRed;
		vector<short> m_vGreen;
		vector<short> m_vBlue;

		int m_nSizex, m_nSizey, m_nSizel;
};


///////////////////////////////////////////////////////
//
// Function: vectPos
//
// Parameters: nX, nY, nL - coords
//
// Action: calculate vector position of a board
//			coord. Counts from 1!
//
// Returns: vector position.
//
///////////////////////////////////////////////////////
int CBoard::vectPos(int nX, int nY, int nL)
{
	return ((nL-1) * (m_nSizex * m_nSizey)) + ((nY-1) * m_nSizex) + (nX-1);
}


///////////////////////////////////////////////////////
//
// Function: resize
//
// Parameters: nX, nY, nL - new board dimensions
//
// Action: resizes board.
//
// Returns: 
//
///////////////////////////////////////////////////////
void CBoard::resize(int nX, int nY, int nL)
{
	m_nSizex = nX;
	m_nSizey = nY;
	m_nSizel = nL;
	m_vTiles.resize(m_nSizex * m_nSizey * m_nSizel);
	m_vRed.resize(m_nSizex * m_nSizey * m_nSizel);
	m_vGreen.resize(m_nSizex * m_nSizey * m_nSizel);
	m_vBlue.resize(m_nSizex * m_nSizey * m_nSizel);
}


///////////////////////////////////////////////////////
//
// Function: setTile
//
// Parameters: fileName - file to set 
//		  			 nX, nY, nL - board coord
//
// Action: set tile at specified position.
//
// Returns: 
//
///////////////////////////////////////////////////////
int setTile(string fileName, int nX, int nY, int nL)
{
	return 0;
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
void CBoard::openboard( string fname,	int topx, int topy, int tilesX, int tilesY )
{
	//opens the board file.

	int x, y, lay;
	char fileheader[255],dummy[255];

	FILE *infile=fopen(fname.c_str(),"rt");

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
		m_nSizel = 8;
		if (minor==1) 
		{
			//it's a version 2.1 board
			//(ie. it is muti-sized)
			//now find out how big...
			fgets(dummy,255,infile);	//sizex
            m_nSizex = atoi(dummy);
			fgets(dummy,255,infile);	//sizey
			m_nSizey = atoi(dummy);
		}

		if (minor==0) 
		{
			m_nSizex = 19;
			m_nSizey = 11;
			m_nSizel = 8;
    }

		//size the board...
		this->resize(m_nSizex, m_nSizey, m_nSizel);
		
		//board data:
		for ( x=1; x <= m_nSizex; x++ ) 
		{
			for ( y=1; y <= m_nSizey; y++ ) 
			{
				for ( lay=1; lay <= m_nSizel; lay++ ) 
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
		infile=fopen(fname.c_str(),"rt");
		
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

//All contents copyright 2003, Christopher Matthews
//All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
//Read LICENSE.txt for licensing info

///////////////////////////////////////////////////////
// CALLBACKS

#include <wtypes.h>

//this is a global string-- the host app will
//call GFXSetCurrentTileSTring when we ask for 
//a board tile, and this string will end up with the answer.
char g_pstrCurTile[1024];

///////////////////////////////////////////////////////
//
// Function: BSTRLen
//
// Parameters: x- a BSTR string
//
// Action: determine length of BSTR string
//
// Returns: length of string
//
///////////////////////////////////////////////////////
int BSTRLen(BSTR x)
{
	int len = 0;
	int pos = 0;
	bool done = false;
	
	if (x == NULL) return 0;

	while (!done)
	{
		unsigned int part = x[pos];
		if (part == 0)
		{
			return len;
		}
		else
		{
			len++;
		}
		pos++;
	}
	return 0;
}


///////////////////////////////////////////////////////
//
// Function: BSTRToChar
//
// Parameters: x- a BSTR string
//
// Action: converts a BSTR string to a char string
//
// Returns: int- length of the converted string.
//
///////////////////////////////////////////////////////
int BSTRtoChar(BSTR x, int nBufferLen, char* pstrBuffer)
{
	int len = BSTRLen(x);
	char* pstrRet = pstrBuffer;
	strcpy(pstrRet, "");
	if (len > nBufferLen)
		len = nBufferLen;
	for (int i=0; i<len; i++)
	{
		unsigned int part = x[i];
		pstrRet[i] = part;
		pstrRet[i+1] = '\0';
	}
	return len;
}


///////////////////////////////////////////////////////
//
// Function: CharToBSTR
//
// Parameters: x- a char* string
//
// Action: converts a ascii string to a BSTR string
//
// Returns: BSTR- the converted string.
//
///////////////////////////////////////////////////////
BSTR CharToBSTR(char* x)
{
	int len = strlen(x);
	unsigned short* bstrRet = new unsigned short[len+1];
	for (int i=0; i<len; i++)
	{
		char part = x[i];
		bstrRet[i] = part;
		bstrRet[i+1] = '\0';
	}
	return bstrRet;
}


///////////////////////////////////////////////////////
//
// Function: BoardString
//
// Callback no: 0
//
// Parameters: cbnum - callback num (0=tile)
//						 nArrayPos1- first array position to obtain (only some)
//						 nArrayPos2- second array position to obtain (only some)
//						 nArrayPos3- third array position to obtain (only some)
//						 nBufferLen - length of the allocated buffer
//						 pstrBuffer - pointer to the character buffer to store string to
//
// Action: get board string info
//
// Returns: void, but toolkit.exe calls into GFXSetCurrentTileString
//				and the string we want will appear in g_pstrCurTile
//
///////////////////////////////////////////////////////
void BoardString(int cbnum, int nArrayPos1, int nArrayPos2, int nArrayPos3)
{
	//call into vb callback 0

	//declare the function pointer
	typedef int (__stdcall *FUNCPTR)(int ap1, int ap2, int ap3);
	FUNCPTR vbFunc;

	//point the function pointer at the passed-in address...
	vbFunc = (FUNCPTR)g_lCallbacks[cbnum];

	//call the function thru the function pointer
	vbFunc(nArrayPos1, nArrayPos2, nArrayPos3);

}

///////////////////////////////////////////////////////
//
// Function: BoardRed
//
// Callback no: 1, 2, 3
//
// Parameters: cbnum - callback num (1=red, 2=green, 3=blue)
//						 nArrayPos1- first array position to obtain (only some)
//						 nArrayPos2- second array position to obtain (only some)
//						 nArrayPos3- third array position to obtain (only some)
//
// Action: get board num info.
//
// Returns: int
//
///////////////////////////////////////////////////////
int BoardNum(int cbnum, int nArrayPos1, int nArrayPos2, int nArrayPos3)
{
	//call into vb callback 1

	//declare the function pointer
	typedef int (__stdcall *FUNCPTR)(int ap1, int ap2, int ap3);
	FUNCPTR vbFunc;

	//point the function pointer at the passed-in address...
	vbFunc = (FUNCPTR)g_lCallbacks[cbnum];

	//call the function thru the function pointer
	return vbFunc(nArrayPos1, nArrayPos2, nArrayPos3);
}


//This function is called by toolkit.exe when we ask for
//the board tile.  It sets the global string, g_pstrCurTile
int APIENTRY GFXSetCurrentTileString(char* pstrToSet)
{
	if (pstrToSet)
		strcpy(g_pstrCurTile, pstrToSet);
	else
		strcpy(g_pstrCurTile, "");
	return 1;
}

/////////////////////////////////////////////////
// Board accessor functions-- call into callbacks
int BoardTile(int nX, int nY, int nL, int nBufferLen, char* pstrBuffer)
{
	BoardString(0,nX+g_topX, nY+g_topY, nL); 

	//the answer is now in g_pstrCurTile, cos GFXSetCurrentTileString was
	//set by the host app.
	strcpy(pstrBuffer, g_pstrCurTile);

	return strlen(pstrBuffer);
}
int BoardRed(int nX, int nY, int nL)
{
	return BoardNum(1, nX+g_topX, nY+g_topY, nL);
}
int BoardGreen(int nX, int nY, int nL)
{
	return BoardNum(2, nX+g_topX, nY+g_topY, nL);
}
int BoardBlue(int nX, int nY, int nL)
{
	return BoardNum(3, nX+g_topX, nY+g_topY, nL);
}

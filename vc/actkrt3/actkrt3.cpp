//All contents copyright 2003, Christopher Matthews
//All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
//Read LICENSE.txt for licensing info

///////////////////////////////////////////
// actkrt3.dll
// 
// RPG Toolkit 3 runtime library
// Copyright 2003 by Christopher B. Matthews
//

#include "stdafx.h"

#include <stdlib.h>
#include <windows.h>

#include "actkrt3.h"

int main(int argc, char* argv[])
{
	return 0;
}
												

///////////////////////////////////
// DLL Entry point...
int APIENTRY TKInit()
{
	return 1;
}


///////////////////////////////////
// Shutdown freeimage system
int APIENTRY TKClose()
{
	return 1;
}

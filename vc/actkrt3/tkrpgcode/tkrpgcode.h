//-------------------------------------------------------------------------
// All contents copyright 2003, 2004 Christopher Matthews or Constributors
// All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
// Read LICENSE.txt for licensing info
//-------------------------------------------------------------------------

//-------------------------------------------------------------------------
// Inclusions
//-------------------------------------------------------------------------
#include "..\stdafx.h"	// Precompiled header
#include <map>			// Maps
#include <string>		// Strings

//-------------------------------------------------------------------------
// A literal variable
//-------------------------------------------------------------------------
struct RPGCODE_LIT_VAR
{
	CComBSTR theBstr;	// The actual string
	int theByteLen;		// The string's actual byte length
};

//-------------------------------------------------------------------------
// Types
//-------------------------------------------------------------------------

// Handle to a heap
typedef int HEAP_HANDLE;

// Numerical heap
typedef std::map<std::string, double> NUM_VARS;

// Literal heap
typedef std::map<std::string, RPGCODE_LIT_VAR> LIT_VARS ;

// Redirect map
typedef std::map<std::string, std::string> REDIRECTS;

//-------------------------------------------------------------------------
// An RPGCode variable heap
//-------------------------------------------------------------------------
struct RPGCODE_HEAP
{
	NUM_VARS numVars;
	LIT_VARS litVars;
};

//-------------------------------------------------------------------------
// Obtain a RPGCODE_HEAP* from a HEAP_HANDLE
//-------------------------------------------------------------------------
#define heapHandleToPtr(x) ((RPGCODE_HEAP*)x)

//-------------------------------------------------------------------------
// Prototypes
//-------------------------------------------------------------------------
int APIENTRY RPGCInit();
int APIENTRY RPGCShutdown();
HEAP_HANDLE APIENTRY RPGCCreateHeap();
int APIENTRY RPGCDestroryHeap(HEAP_HANDLE heap);
int APIENTRY RPGCSetNumVar(char *pstrVarName, double dValue, HEAP_HANDLE heap);
int APIENTRY RPGCSetLitVar(const char *pstrVarName, BSTR pstrValue, HEAP_HANDLE heap, const int byteLen);
double APIENTRY RPGCGetNumVar(char *pstrVarName, HEAP_HANDLE heap);
BSTR APIENTRY RPGCGetLitVar(const char *pstrVarName, HEAP_HANDLE heap);
int APIENTRY RPGCGetLitVarLen(char *pstrVarName, HEAP_HANDLE heap);
int APIENTRY RPGCCountNum(HEAP_HANDLE heap);
int APIENTRY RPGCCountLit(HEAP_HANDLE heap);
int APIENTRY RPGCGetNumName(int nItrOffset, char *pstrToVal, HEAP_HANDLE heap);
int APIENTRY RPGCGetLitName(int nItrOffset, char *pstrToVal, HEAP_HANDLE heap);
int APIENTRY RPGCClearAll(HEAP_HANDLE heap);
int APIENTRY RPGCKillNum(char *pstrVarName, HEAP_HANDLE heap);
int APIENTRY RPGCKillLit(char *pstrVarName, HEAP_HANDLE heap);
int APIENTRY RPGCNumExists(char *pstrVarName, HEAP_HANDLE heap);
int APIENTRY RPGCLitExists(char *pstrVarName, HEAP_HANDLE heap);
int APIENTRY RPGCSetRedirect(char *pstrVarName, char *pstrValue);
int APIENTRY RPGCRedirectExists(char *pstrVarName);
int APIENTRY RPGCGetRedirect(char *pstrVarName, char *pstrToVal);
int APIENTRY RPGCKillRedirect(char *pstrVarName);
int APIENTRY RPGCGetRedirectName(int nItrOffset, char *pstrToVal);
int APIENTRY RPGCClearRedirects();
int APIENTRY RPGCCountRedirects();
int APIENTRY RPGCGetLitVarByteLen(const char *pStrVarName, const HEAP_HANDLE heap);
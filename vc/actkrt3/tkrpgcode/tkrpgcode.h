//All contents copyright 2003, Christopher Matthews
//All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
//Read LICENSE.txt for licensing info

#include "..\stdafx.h"

#include <map>
#include <string>


#define HEAP_HANDLE long

typedef std::map<std::string, double> NUM_VARS;
typedef std::map<std::string, std::string> LIT_VARS ;
typedef std::map<std::string, std::string> REDIRECTS;

typedef struct _rpgHeap
{
	NUM_VARS numVars;
	LIT_VARS litVars;
} RPGCODE_HEAP;

RPGCODE_HEAP* heapHandleToPtr(HEAP_HANDLE heap)
{
	return (RPGCODE_HEAP*)heap;
}


int APIENTRY RPGCInit();

int APIENTRY RPGCShutdown();

HEAP_HANDLE APIENTRY RPGCCreateHeap();

int APIENTRY RPGCDestroryHeap(HEAP_HANDLE heap);

int APIENTRY RPGCSetNumVar(char* pstrVarName, double dValue, HEAP_HANDLE heap);

int APIENTRY RPGCSetLitVar(char* pstrVarName, char* pstrValue, HEAP_HANDLE heap);

double APIENTRY RPGCGetNumVar(char* pstrVarName, HEAP_HANDLE heap);

int APIENTRY RPGCGetLitVar(char* pstrVarName, char* pstrToVal, HEAP_HANDLE heap);

int APIENTRY RPGCGetLitVarLen(char* pstrVarName, HEAP_HANDLE heap);

int APIENTRY RPGCCountNum(HEAP_HANDLE heap);

int APIENTRY RPGCCountLit(HEAP_HANDLE heap);

int APIENTRY RPGCGetNumName(int nItrOffset, char* pstrToVal, HEAP_HANDLE heap);

int APIENTRY RPGCGetLitName(int nItrOffset, char* pstrToVal, HEAP_HANDLE heap);

int APIENTRY RPGCClearAll(HEAP_HANDLE heap);

int APIENTRY RPGCKillNum(char* pstrVarName, HEAP_HANDLE heap);

int APIENTRY RPGCKillLit(char* pstrVarName, HEAP_HANDLE heap);

int APIENTRY RPGCNumExists(char* pstrVarName, HEAP_HANDLE heap);

int APIENTRY RPGCLitExists(char* pstrVarName, HEAP_HANDLE heap);

int APIENTRY RPGCSetRedirect(char* pstrVarName, char* pstrValue);

int APIENTRY RPGCRedirectExists(char* pstrVarName);

int APIENTRY RPGCGetRedirect(char* pstrVarName, char* pstrToVal);

int APIENTRY RPGCKillRedirect(char* pstrVarName);

int APIENTRY RPGCGetRedirectName(int nItrOffset, char* pstrToVal);

int APIENTRY RPGCClearRedirects();

int APIENTRY RPGCCountRedirects();

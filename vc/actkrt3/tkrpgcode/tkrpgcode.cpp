//All contents copyright 2003, Christopher Matthews
//All rights reserved.  YOU MAY NOT REMOVE THIS NOTICE.
//Read LICENSE.txt for licensing info

// tkrpgc.dll : Variable access system for rpgcode.
//

#include "..\stdafx.h"
//#include <stdlib.h>
#include <windows.h>
#include <string.h>
#include <list>

#include <wtypes.h>
#include <oleauto.h>
#include <atlbase.h>

#include "tkrpgcode.h"

//////////////////////////
// GLOBALS

REDIRECTS gRedirectMap;
std::list<RPGCODE_HEAP*> g_HeapList;


///////////////////////////////////
// DLL Entry point...
int APIENTRY RPGCInit()
{
	return 1;
}


//kill heap system
int APIENTRY RPGCShutdown()
{
	std::list<RPGCODE_HEAP*>::iterator itr = g_HeapList.begin();
	for (; itr != g_HeapList.end(); itr++)
	{
		delete (*itr);
	}

	g_HeapList.clear();
	return 0;
}


///////////////////////////////////
// Create a new RPGCode heap
// return an index we can use to refer to that heap
HEAP_HANDLE APIENTRY RPGCCreateHeap()
{
	RPGCODE_HEAP *const pHeap = new RPGCODE_HEAP;
	g_HeapList.push_back(pHeap);
	return (HEAP_HANDLE)pHeap;
}


//destroy a heap
int APIENTRY RPGCDestroryHeap(HEAP_HANDLE heap)
{
	RPGCODE_HEAP *const p = heapHandleToPtr(heap);
	if (p)
	{
		g_HeapList.remove(p);
		delete p;
	}
	return 1;
}


///////////////////////////////////
// Set numerical var
// pstrVarName - name of variable
// dValue - value of var
int APIENTRY RPGCSetNumVar(char* pstrVarName, double dValue, HEAP_HANDLE heap)
{
	RPGCODE_HEAP *const p = heapHandleToPtr(heap);
	if (pstrVarName == NULL || p == NULL) 
		return 0;

	std::string strVarName = pstrVarName;
	p->numVars[strVarName] = dValue;
	return 1;
}


///////////////////////////////////
// Set literal var
// pstrVarName - name of variable
// pstrValue - value of var
int APIENTRY RPGCSetLitVar(const char *pstrVarName, BSTR pstrValue, HEAP_HANDLE heap, const int byteLen)
{

	RPGCODE_HEAP *const p = heapHandleToPtr(heap);

	if (pstrVarName == NULL || p == NULL) 
		return 0;

	p->litVars[pstrVarName].theBstr = pstrValue;
	p->litVars[pstrVarName].theByteLen = byteLen;

	return 1;

}


int APIENTRY RPGCGetLitVarByteLen(const char *pStrVarName, const HEAP_HANDLE heap)
{

	RPGCODE_HEAP *const p = heapHandleToPtr(heap);

	if (pStrVarName == NULL || p == NULL) 
		return 0;

	return p->litVars[pStrVarName].theByteLen;

}

///////////////////////////////////
// Get numerical var
// pstrVarName - name of variable
double APIENTRY RPGCGetNumVar(char* pstrVarName, HEAP_HANDLE heap)
{
	RPGCODE_HEAP *const p = heapHandleToPtr(heap);
	if (pstrVarName == NULL || p == NULL) 
		return 0;

	std::string strVarName = pstrVarName;
	if (p->numVars.count(strVarName) > 0)
	{
		return p->numVars[strVarName];
	}
	else
	{
		return 0;
	}
}



///////////////////////////////////
// Get literal var
// pstrVarName - name of variable
BSTR APIENTRY RPGCGetLitVar(const char *pstrVarName, HEAP_HANDLE heap)
{

	RPGCODE_HEAP *const p = heapHandleToPtr(heap);
	if (pstrVarName == NULL || p == NULL) 
		return 0;

	std::string strVarName = pstrVarName;

	if (p->litVars.count(strVarName) > 0)
		return p->litVars[strVarName].theBstr.Copy();

	else
		return NULL;

}


///////////////////////////////////
// Get length of lit var
// pstrVarName - name of variable
int APIENTRY RPGCGetLitVarLen(const char *pstrVarName, HEAP_HANDLE heap)
{
	RPGCODE_HEAP *const p = heapHandleToPtr(heap);
	if (pstrVarName == NULL || p == NULL) 
		return 0;

	std::string strVarName = pstrVarName;
	if (p->litVars.count(strVarName) > 0)
	{
		return p->litVars[strVarName].theBstr.Length();
	}
	else
	{
		return 0;
	}
}


///////////////////////////////////
// Get number of elements in 
// numerical var set
int APIENTRY RPGCCountNum(HEAP_HANDLE heap)
{
	RPGCODE_HEAP *const p = heapHandleToPtr(heap);
	if (p == NULL) 
		return 0;
	return p->numVars.size();
}


///////////////////////////////////
// Get number of elements in 
// literal var set
int APIENTRY RPGCCountLit(HEAP_HANDLE heap)
{
	RPGCODE_HEAP *const p = heapHandleToPtr(heap);
	if (p == NULL) 
		return 0;
	return p->litVars.size();
}


///////////////////////////////////
// Get the i-th numerical var name
int APIENTRY RPGCGetNumName(int nItrOffset, char* pstrToVal, HEAP_HANDLE heap)
{
	RPGCODE_HEAP *const p = heapHandleToPtr(heap);
	if (p == NULL) 
		return 0;

	NUM_VARS::iterator itr = p->numVars.begin();	
	for (int i=0; i<nItrOffset; i++)
	{
		itr++;
	}
	strcpy(pstrToVal, itr->first.c_str());
	return strlen(pstrToVal);
}


///////////////////////////////////
// Get the i-th numerical var name
int APIENTRY RPGCGetLitName(int nItrOffset, char* pstrToVal, HEAP_HANDLE heap)
{
	RPGCODE_HEAP *const p = heapHandleToPtr(heap);
	if (p == NULL) 
		return 0;

	LIT_VARS::iterator itr = p->litVars.begin();	
	for (int i=0; i<nItrOffset; i++)
	{
		itr++;
	}
	strcpy(pstrToVal, itr->first.c_str());
	return strlen(pstrToVal);
}


///////////////////////////////////
// Clear all vars
int APIENTRY RPGCClearAll(HEAP_HANDLE heap)
{
	RPGCODE_HEAP *const p = heapHandleToPtr(heap);
	if (p == NULL) 
		return 0;

	p->litVars.clear();
	p->numVars.clear();
	return 1;
}


///////////////////////////////////
// Kill a num var
int APIENTRY RPGCKillNum(char* pstrVarName, HEAP_HANDLE heap)
{
	RPGCODE_HEAP *const p = heapHandleToPtr(heap);
	if (pstrVarName == NULL || p == NULL) 
		return 0;

	std::string strVarName = pstrVarName;
	p->numVars.erase(strVarName);
	return 1;
}


///////////////////////////////////
// Kill a lit var
int APIENTRY RPGCKillLit(char* pstrVarName, HEAP_HANDLE heap)
{
	RPGCODE_HEAP *const p = heapHandleToPtr(heap);
	if (pstrVarName == NULL || p == NULL) 
		return 0;

	std::string strVarName = pstrVarName;
	p->litVars.erase(strVarName);
	return 1;
}


///////////////////////////////////
// Determine if a var exists
int APIENTRY RPGCNumExists(char* pstrVarName, HEAP_HANDLE heap)
{
	RPGCODE_HEAP *const p = heapHandleToPtr(heap);
	if (pstrVarName == NULL || p == NULL) 
		return 0;

	std::string strVarName = pstrVarName;
	return p->numVars.count(strVarName);
}


///////////////////////////////////
// Determine if a var exists
int APIENTRY RPGCLitExists(char* pstrVarName, HEAP_HANDLE heap)
{
	RPGCODE_HEAP *const p = heapHandleToPtr(heap);
	if (pstrVarName == NULL || p == NULL) 
		return 0;

	std::string strVarName = pstrVarName;
	return p->litVars.count(strVarName);
}


///////////
// Redirect list...

///////////////////////////////////
// Set redirect
// pstrVarName - name of original method
// pstrValue - name of redirected method
int APIENTRY RPGCSetRedirect(char* pstrVarName, char* pstrValue)
{
	if (pstrVarName == NULL) 
		return 0;
	std::string strVarName = pstrVarName;
	std::string strValue;
	if (pstrValue == NULL)
		strValue = "";
	else
		strValue = pstrValue;
	gRedirectMap[strVarName] = strValue;
	return 1;
}


///////////////////////////////////
// Determine if a redirect exists
int APIENTRY RPGCRedirectExists(char* pstrVarName)
{
	if (pstrVarName == NULL) 
		return 0;
	std::string strVarName = pstrVarName;
	return gRedirectMap.count(strVarName);
}


///////////////////////////////////
// Get redirect value
// pstrVarName - name of redirect
int APIENTRY RPGCGetRedirect(char* pstrVarName, char* pstrToVal)
{
	if (pstrVarName == NULL) 
		return 0;
	std::string strVarName = pstrVarName;
	if (gRedirectMap.count(strVarName) > 0)
	{
		strcpy(pstrToVal, gRedirectMap[strVarName].c_str());
		return strlen(pstrToVal);
	}
	else
	{
		strcpy(pstrToVal, "");
		return 0;
	}
}


///////////////////////////////////
// Kill a redirect
int APIENTRY RPGCKillRedirect(char* pstrVarName)
{
	if (pstrVarName == NULL) 
		return 0;
	std::string strVarName = pstrVarName;
	gRedirectMap.erase(strVarName);
	return 1;
}


///////////////////////////////////
// Get the i-th redirect name
int APIENTRY RPGCGetRedirectName(int nItrOffset, char* pstrToVal)
{
	REDIRECTS::iterator itr = gRedirectMap.begin();	
	for (int i=0; i<nItrOffset; i++)
	{
		itr++;
	}
	strcpy(pstrToVal, itr->first.c_str());
	return strlen(pstrToVal);
}


///////////////////////////////////
// Clear all redirects
int APIENTRY RPGCClearRedirects()
{
	gRedirectMap.clear();
	return 1;
}

///////////////////////////////////
// Get number of elements in 
// redirect map
int APIENTRY RPGCCountRedirects()
{
	return gRedirectMap.size();
}
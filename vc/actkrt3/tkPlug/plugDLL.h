/*
 ********************************************************************
 * The RPG Toolkit, Version 3
 * This file copyright (C) 2007  Christopher Matthews & contributors
 ********************************************************************
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 */

//required plugin functions...
//
//long APIENTRY FunctionPtr(long functionAddr)
//int APIENTRY TKPlugInit(long *pCBArray, int nCallbacks)
//void APIENTRY TKPlugBegin()
//int APIENTRY TKPlugQuery(char* pstrQuery)
//int APIENTRY TKPlugExecute(char* pstrCommand)
//void APIENTRY TKPlugEnd()

#ifndef PLUGDLL_H
#define PLUGDLL_H

#include <string>

#define PT_RPGCODE	1			//plugin type rpgcode
#define PT_MENU			2			//plugin type menu
#define PT_FIGHT		4			//plugin type battle system

#define MNU_MAIN		1			//main menu requested
#define MNU_INVENTORY	2		//inventory menu requested
#define MNU_EQUIP		4			//equip menu requested
#define MNU_ABILITIES	8		//abilities menu requested

//define dll function types...
typedef long (__stdcall *VersionProc)();
typedef long (__stdcall *DescriptionProc)(char* pstrReturnBuffer, int nBufferSize);
typedef int (__stdcall *InitProc)(long *pCBArray, int nCallbacks);
typedef void (__stdcall *BeginProc)();
typedef int (__stdcall *QueryProc)(char *pstrQuery);
typedef int (__stdcall *ExecuteProc)(char* pstrCommand);
typedef void (__stdcall *EndProc)();
typedef int (__stdcall *TypeProc)(int nRequestedFeature);
typedef int (__stdcall *MenuProc)(int nRequestedMenu);
typedef int (__stdcall *FightProc)(int nEnemyCount, int nSkillLevel, char* pstrBackground, int nCanRun);
typedef int (__stdcall *FightInformProc)(int nSourcePartyIndex, int nSourceFighterIndex, int nTargetPartyIndex, int nTargetFighterIndex, int nSourceHP, int nSourceSMP, int nTargetHP, int nTargetSMP, char* pstrMessage, int nCode);
typedef int (__stdcall *InputRequestedProc)( int nCode );
typedef int (__stdcall *EventInformProc)( int nKeyCode, int nX, int nY, int nButton, int nShift, char* pstrKey, int nCode );

class PlugDLL
{
public:
	PlugDLL(std::string strFilename);
	~PlugDLL();
	int DllTKPlugInit(long *pCBArray, int nCallbacks);
	void DllTKPlugBegin();
	int DllTKPlugQuery(std::string strQuery);
	int DllTKPlugExecute(std::string strCommand);
	void DllTKPlugEnd();
	int DllTKPlugVersion();
	std::string DllTKPlugDescription();
	int DllTKPlugType(int nRequestedFeature);
	int DllTKPlugMenu(int nRequestedMenu);
	int DllTKPlugFight(int nEnemyCount, int nSkillLevel, std::string strBackground, int nCanRun);
	int DllTKPlugFightInform(int nSourcePartyIndex, int nSourceFighterIndex, int nTargetPartyIndex, int nTargetFighterIndex, int nSourceHP, int nSourceSMP, int nTargetHP, int nTargetSMP, char* pstrMessage, int nCode);
	int DllTKPlugInputRequested(int nCode);
	int DllTKPlugEventInform(int nKeyCode, int nX, int nY, int nButton, int nShift, std::string strKey, int nCode);

	bool IsLoaded() { return m_bLoaded; }
	std::string GetFilename() { return m_strFilename; }

private:
	std::string m_strFilename;		//filename of dll...
	HINSTANCE m_hInstance;	//hinstance of loaded dll
	bool m_bLoaded;					//is lib loaded?
	bool m_bBeginCalled;		//was being called?  if so, you cannot call it more than once
	bool m_bEndCalled;		//was end called?  if so, you cannot call it more than once
	//functions in the dll...
	InitProc			m_TKPlugInit;
	BeginProc			m_TKPlugBegin;
	QueryProc			m_TKPlugQuery;
	ExecuteProc		m_TKPlugExecute;
	EndProc				m_TKPlugEnd;
	VersionProc		m_TKPlugVersion;
	DescriptionProc m_TKPlugDescription;
	TypeProc			m_TKPlugType;
	MenuProc			m_TKPlugMenu;
	FightProc			m_TKPlugFight;
	FightInformProc m_TKPlugFightInform;
	InputRequestedProc m_TKPlugInputRequested;
	EventInformProc m_TKPlugEventInform;
};


////////////////////////////////
// Constructor
PlugDLL::PlugDLL(std::string strFilename)
{
	m_strFilename = strFilename;

	m_TKPlugInit = NULL;
	m_TKPlugBegin = NULL;
	m_TKPlugQuery = NULL;
	m_TKPlugExecute = NULL;
	m_TKPlugEnd = NULL;
	m_TKPlugVersion = NULL;
	m_TKPlugDescription = NULL;
	m_TKPlugType = NULL;
	m_TKPlugMenu = NULL;
	m_TKPlugFight = NULL;
	m_TKPlugFightInform = NULL;
	m_TKPlugInputRequested = NULL;
	m_TKPlugEventInform = NULL;

	m_bBeginCalled = false;
	m_bEndCalled = false;

	//now load the plugin...
	m_hInstance = LoadLibrary(m_strFilename.c_str());
	if (m_hInstance)
	{
		m_bLoaded = true;
		m_TKPlugInit = (InitProc)GetProcAddress(m_hInstance, "TKPlugInit");
		m_TKPlugBegin = (BeginProc)GetProcAddress(m_hInstance, "TKPlugBegin");
		m_TKPlugQuery = (QueryProc)GetProcAddress(m_hInstance, "TKPlugQuery");
		m_TKPlugExecute = (ExecuteProc)GetProcAddress(m_hInstance, "TKPlugExecute");
		m_TKPlugEnd = (EndProc)GetProcAddress(m_hInstance, "TKPlugEnd");
		m_TKPlugVersion = (VersionProc)GetProcAddress(m_hInstance, "TKPlugVersion");
		m_TKPlugDescription = (DescriptionProc)GetProcAddress(m_hInstance, "TKPlugDescription");
		m_TKPlugType = (TypeProc)GetProcAddress(m_hInstance, "TKPlugType");
		m_TKPlugMenu = (MenuProc)GetProcAddress(m_hInstance, "TKPlugMenu");
		m_TKPlugFight = (FightProc)GetProcAddress(m_hInstance, "TKPlugFight");
		m_TKPlugFightInform = (FightInformProc)GetProcAddress(m_hInstance, "TKPlugFightInform");
		m_TKPlugInputRequested = (InputRequestedProc)GetProcAddress(m_hInstance, "TKPlugInputRequested");
		m_TKPlugEventInform = (EventInformProc)GetProcAddress(m_hInstance, "TKPlugEventInform");
	}
	else
	{
		m_bLoaded = false;
	}
}


////////////////////////////////
// Destructor
PlugDLL::~PlugDLL()
{
	if (m_hInstance)
	{
		FreeLibrary(m_hInstance);
	}
}


///////////////////////////////////
// Routines for calling plugin
// routines...

int PlugDLL::DllTKPlugInit(long *pCBArray, int nCallbacks)
{
	if (m_TKPlugInit)
	{
		return m_TKPlugInit(pCBArray, nCallbacks);
	}
	return 0;
}

void PlugDLL::DllTKPlugBegin()
{
	if (!m_bBeginCalled)
	{
		if (m_TKPlugBegin)
		{
			m_TKPlugBegin();
		}
		m_bBeginCalled = true;
	}
}

int PlugDLL::DllTKPlugQuery(std::string strQuery)
{
	if (m_TKPlugQuery)
	{
		return m_TKPlugQuery((char*)strQuery.c_str());
	}
	return 0;
}

int PlugDLL::DllTKPlugExecute(std::string strCommand)
{
	if (m_TKPlugExecute)
	{
		return m_TKPlugExecute((char*)strCommand.c_str());
	}
	return 0;
}

void PlugDLL::DllTKPlugEnd()
{
	if (!m_bEndCalled)
	{
		if (m_TKPlugEnd)
		{
			m_TKPlugEnd();
		}
		m_bEndCalled = true;
	}
}


int PlugDLL::DllTKPlugVersion()
{
	if (m_TKPlugVersion)
	{
		return m_TKPlugVersion();
	}
	else
	{
		//function was not defined, so it muct be a version
		//2 plugin
		return 20;
	}
}

std::string PlugDLL::DllTKPlugDescription()
{
	std::string strRet = "";
	if (m_TKPlugVersion)
	{
		char strGet[1024];
		int len = m_TKPlugDescription(strGet, 1024);
		strRet = strGet;
	}
	else
	{
		//function was not defined, so give a standard description
		if (DllTKPlugVersion() == 20)
		{
			strRet = "Version 2 plugin";
		}
		else
		{
			strRet = "No description";
		}
	}
	return strRet;
}

int PlugDLL::DllTKPlugType(int nRequestedFeature)
{
	if (m_TKPlugType)
	{
		return m_TKPlugType(nRequestedFeature);
	}
	else
	{
		//function was not defined, so give a standard description
		if (DllTKPlugVersion() == 20)
		{
			//version 2 plugin-- only rpgcode supported
			if (nRequestedFeature == PT_RPGCODE)
			{
				return 1;
			}
			else
			{
				return 0;
			}
		}
		else
		{
			//feature not supported
			return 0;
		}
	}
}

int PlugDLL::DllTKPlugMenu(int nRequestedMenu)
{
	if (m_TKPlugMenu)
	{
		return m_TKPlugMenu(nRequestedMenu);
	}
	else
	{
		//menus not supported
		return 0;
	}
}

int PlugDLL::DllTKPlugFight(int nEnemyCount, int nSkillLevel, std::string strBackground, int nCanRun)
{
	if (m_TKPlugFight)
	{
		return m_TKPlugFight(nEnemyCount, nSkillLevel, (char*)strBackground.c_str(), nCanRun);
	}
	else
	{
		//fights not supported
		return 1;	//assume playesr won
	}
}


int PlugDLL::DllTKPlugFightInform(int nSourcePartyIndex, int nSourceFighterIndex, int nTargetPartyIndex, int nTargetFighterIndex, int nSourceHP, int nSourceSMP, int nTargetHP, int nTargetSMP, char* pstrMessage, int nCode)
{
	if (m_TKPlugFightInform)
	{
		return m_TKPlugFightInform(nSourcePartyIndex, nSourceFighterIndex, nTargetPartyIndex, nTargetFighterIndex, nSourceHP, nSourceSMP, nTargetHP, nTargetSMP, pstrMessage, nCode);
	}
	else
	{
		//fights not supported
		return 1;	//assume it worked
	}
}


int PlugDLL::DllTKPlugInputRequested(int nCode)
{
	if (m_TKPlugInputRequested)
	{
		return m_TKPlugInputRequested(nCode);
	}
	else
	{
		return 0;	//not requested
	}
}


int PlugDLL::DllTKPlugEventInform(int nKeyCode, int nX, int nY, int nButton, int nShift, std::string strKey, int nCode)
{
	if (m_TKPlugEventInform)
	{
		return m_TKPlugEventInform(nKeyCode, nX, nY, nButton, nShift, (char*)strKey.c_str(), nCode);
	}
	else
	{
		return 1;	//all's well
	}
}

#endif
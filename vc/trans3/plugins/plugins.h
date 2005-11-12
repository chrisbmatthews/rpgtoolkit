/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

#ifndef _PLUGINS_H_
#define _PLUGINS_H_

#include "../../tkCommon/strings.h"

#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <objbase.h>
#include <oleauto.h>
#include <string>

// Plugin types.
#define PT_RPGCODE 1		// RPGCode plugin
#define PT_MENU 2			// Menu plugin
#define PT_FIGHT 4			// Fight plugin

// Input types.
#define INPUT_KB 0			// Keyboard input
#define INPUT_MOUSEDOWN 1	// Mouse down

// Initialize the plugin system.
void initPluginSystem();

// Shut down the plugin system.
void freePluginSystem();

// Any plugin.
class IPlugin
{
public:
	virtual void initialize() = 0;
	virtual void terminate() = 0;
	virtual bool query(const STRING function) = 0;
	virtual bool execute(const STRING line, int &retValDt, STRING &retValLit, double &retValNum, const short usingReturn) = 0;
	virtual int fight(const int enemyCount, const int skillLevel, const STRING background, const bool canRun) = 0;
	virtual int fightInform(const int sourcePartyIndex, const int sourceFighterIndex, const int targetPartyIndex, const int targetFighterIndex, const int sourceHpLost, const int sourceSmpLost, const int targetHpLost, const int targetSmpLost, const STRING strMessage, const int attackCode) = 0;
	virtual int menu(const int request) = 0;
	virtual bool plugType(const int request) = 0;
	virtual ~IPlugin() { }
};

// A plugin that accepts input using the special methods.
interface IPluginInput
{
	virtual bool inputRequested(const int type) = 0;
	virtual bool eventInform(const int keyCode, const int x, const int y, const int button, const int shift, const STRING key, const int type) = 0;
};

// Number of members in a COM-based plugin's interface.
#define MEMBER_COUNT 11

// A COM based plugin.
class CComPlugin : public IPlugin
{
public:
	CComPlugin();
	CComPlugin(ITypeInfo *pTypeInfo);
	~CComPlugin() { unload(); }
	bool load(ITypeInfo *pTypeInfo);
	void unload();

	void initialize();
	void terminate();
	bool query(const STRING function);
	bool execute(const STRING line, int &retValDt, STRING &retValLit, double &retValNum, const short usingReturn);
	int fight(const int enemyCount, const int skillLevel, const STRING background, const bool canRun);
	int fightInform(const int sourcePartyIndex, const int sourceFighterIndex, const int targetPartyIndex, const int targetFighterIndex, const int sourceHpLost, const int sourceSmpLost, const int targetHpLost, const int targetSmpLost, const STRING strMessage, const int attackCode);
	int menu(const int request);
	bool plugType(const int request);

private:
	CComPlugin(const CComPlugin &rhs);
	CComPlugin &operator=(const CComPlugin &rhs);
	IDispatch *m_plugin;
	MEMBERID m_members[MEMBER_COUNT];
};

// Typedefs for old plugins.
typedef long (__stdcall *VERSION_PROC)();
typedef int (__stdcall *INIT_PROC)(int *pCbArray, int nCallbacks);
typedef void (__stdcall *BEGIN_PROC)();
typedef int (__stdcall *QUERY_PROC)(char *pstrQuery);
typedef int (__stdcall *EXECUTE_PROC)(char *pstrCommand);
typedef void (__stdcall *END_PROC)();
typedef int (__stdcall *TYPE_PROC)(int nRequestedFeature);
typedef int (__stdcall *MENU_PROC)(int nRequestedMenu);
typedef int (__stdcall *FIGHT_PROC)(int nEnemyCount, int nSkillLevel, char *pstrBackground, int nCanRun);
typedef int (__stdcall *FIGHT_INFORM_PROC)(int nSourcePartyIndex, int nSourceFighterIndex, int nTargetPartyIndex, int nTargetFighterIndex, int nSourceHp, int nSourceSmp, int nTargetHp, int nTargetSmp, char *pstrMessage, int nCode);
typedef int (__stdcall *INPUT_REQUESTED_PROC)(int nCode);
typedef int (__stdcall *EVENT_INFORM_PROC)(int nKeyCode, int nX, int nY, int nButton, int nShift, char *pstrKey, int nCode);

// An old plugin.
class COldPlugin : public IPlugin, public IPluginInput
{
public:
	COldPlugin();
	COldPlugin(const STRING file);
	~COldPlugin() { unload(); }
	bool load(const STRING file);
	void unload();

	void initialize();
	void terminate();
	bool query(const STRING function);
	bool execute(const STRING line, int &retValDt, STRING &retValLit, double &retValNum, const short usingReturn);
	int fight(const int enemyCount, const int skillLevel, const STRING background, const bool canRun);
	int fightInform(const int sourcePartyIndex, const int sourceFighterIndex, const int targetPartyIndex, const int targetFighterIndex, const int sourceHpLost, const int sourceSmpLost, const int targetHpLost, const int targetSmpLost, const STRING strMessage, const int attackCode);
	int menu(const int request);
	bool plugType(const int request);
	bool inputRequested(const int type);
	bool eventInform(const int keyCode, const int x, const int y, const int button, const int shift, const STRING key, const int type);

private:
	COldPlugin(const COldPlugin &rhs);
	COldPlugin &operator=(const COldPlugin &rhs);
	HMODULE m_hModule;
	BEGIN_PROC m_plugBegin;
	QUERY_PROC m_plugQuery;
	EXECUTE_PROC m_plugExecute;
	END_PROC m_plugEnd;
	TYPE_PROC m_plugType;
	MENU_PROC m_plugMenu;
	FIGHT_PROC m_plugFight;
	FIGHT_INFORM_PROC m_plugFightInform;
	INPUT_REQUESTED_PROC m_plugInputRequested;
	EVENT_INFORM_PROC m_plugEventInform;
};

// Load a plugin.
IPlugin *loadPlugin(const STRING file);

// Inform applicable plugins of an event.
void informPluginEvent(const int keyCode, const int x, const int y, const int button, const int shift, const STRING key, const int type);

inline STRING getString(const BSTR bstr)
{
#ifndef _UNICODE
	const int length = SysStringLen(bstr) + 1;
	char *const str = new char[length];
	WideCharToMultiByte(CP_ACP, 0, bstr, -1, str, length, NULL, NULL);
	const STRING toRet = str;
	delete [] str;
	return toRet;
#else
	return (wchar_t *)bstr;
#endif
}

inline BSTR getString(const STRING rhs)
{
#ifndef _UNICODE
	wchar_t *str = new wchar_t[rhs.length() + 1];
	MultiByteToWideChar(CP_ACP, 0, rhs.c_str(), -1, str, rhs.length() + 1);
	const BSTR toRet = SysAllocString(str);
	delete [] str;
	return toRet;
#else
	return SysAllocString(rhs.c_str());
#endif
}

#endif

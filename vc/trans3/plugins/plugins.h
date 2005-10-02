/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

#ifndef _PLUGINS_H_
#define _PLUGINS_H_

#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <objbase.h>
#include <oleauto.h>
#include <string>

// Plugin types.
#define PT_RPGCODE 1	// RPGCode plugin
#define PT_MENU 2		// Menu plugin
#define PT_FIGHT 4		// Fight plugin

// Initialize the plugin system.
void initPluginSystem(void);

// Shut down the plugin system.
void freePluginSystem(void);

// Any plugin.
class IPlugin
{
public:
	virtual void initialize(void) = 0;
	virtual void terminate(void) = 0;
	virtual bool query(const std::string function) = 0;
	virtual bool execute(const std::string line, int &retValDt, std::string &retValLit, double &retValNum, const short usingReturn) = 0;
	virtual int fight(const int enemyCount, const int skillLevel, const std::string background, const bool canRun) = 0;
	virtual int fightInform(const int sourcePartyIndex, const int sourceFighterIndex, const int targetPartyIndex, const int targetFighterIndex, const int sourceHpLost, const int sourceSmpLost, const int targetHpLost, const int targetSmpLost, const std::string strMessage, const int attackCode) = 0;
	virtual int menu(const int request) = 0;
	virtual bool plugType(const int request) = 0;
	virtual ~IPlugin(void) { }
};

// Interface of a COM plugin.
interface __declspec(novtable) IComPlugin : public IDispatch
{
	virtual HRESULT STDMETHODCALLTYPE initialize(void) = 0;
	virtual HRESULT STDMETHODCALLTYPE terminate(void) = 0;
	virtual HRESULT STDMETHODCALLTYPE version(BSTR __RPC_FAR *) = 0;
	virtual HRESULT STDMETHODCALLTYPE description(BSTR __RPC_FAR *) = 0;
	virtual HRESULT STDMETHODCALLTYPE type(int, VARIANT_BOOL __RPC_FAR *) = 0;
	virtual HRESULT STDMETHODCALLTYPE query(BSTR, VARIANT_BOOL __RPC_FAR *) = 0;    
	virtual HRESULT STDMETHODCALLTYPE execute(BSTR, int __RPC_FAR *, BSTR __RPC_FAR *, double __RPC_FAR *, int, VARIANT_BOOL __RPC_FAR *) = 0;
	virtual HRESULT STDMETHODCALLTYPE menu(int, int __RPC_FAR *) = 0;
	virtual HRESULT STDMETHODCALLTYPE fight(int, int, BSTR, int, int __RPC_FAR *) = 0;
	virtual HRESULT STDMETHODCALLTYPE fightInform(int, int, int, int, int, int, int, int, BSTR, int, int __RPC_FAR *) = 0;
	virtual HRESULT STDMETHODCALLTYPE put_setCallbacks(IDispatch __RPC_FAR *) = 0;
};

// A COM based plugin.
class CComPlugin : public IPlugin
{
public:
	CComPlugin(void);
	CComPlugin(const std::wstring cls);
	~CComPlugin(void) { unload(); }
	bool load(const std::wstring cls);
	void unload(void);

	void initialize(void);
	void terminate(void);
	bool query(const std::string function);
	bool execute(const std::string line, int &retValDt, std::string &retValLit, double &retValNum, const short usingReturn);
	int fight(const int enemyCount, const int skillLevel, const std::string background, const bool canRun);
	int fightInform(const int sourcePartyIndex, const int sourceFighterIndex, const int targetPartyIndex, const int targetFighterIndex, const int sourceHpLost, const int sourceSmpLost, const int targetHpLost, const int targetSmpLost, const std::string strMessage, const int attackCode);
	int menu(const int request);
	bool plugType(const int request);

private:
	CComPlugin(const CComPlugin &rhs);
	CComPlugin &operator=(const CComPlugin &rhs);
	IComPlugin *m_plugin;
};

// Typedefs for old plugins.
typedef long (__stdcall *VERSION_PROC)(void);
typedef int (__stdcall *INIT_PROC)(int *pCbArray, int nCallbacks);
typedef void (__stdcall *BEGIN_PROC)(void);
typedef int (__stdcall *QUERY_PROC)(char *pstrQuery);
typedef int (__stdcall *EXECUTE_PROC)(char *pstrCommand);
typedef void (__stdcall *END_PROC)(void);
typedef int (__stdcall *TYPE_PROC)(int nRequestedFeature);
typedef int (__stdcall *MENU_PROC)(int nRequestedMenu);
typedef int (__stdcall *FIGHT_PROC)(int nEnemyCount, int nSkillLevel, char *pstrBackground, int nCanRun);
typedef int (__stdcall *FIGHT_INFORM_PROC)(int nSourcePartyIndex, int nSourceFighterIndex, int nTargetPartyIndex, int nTargetFighterIndex, int nSourceHp, int nSourceSmp, int nTargetHp, int nTargetSmp, char *pstrMessage, int nCode);
typedef int (__stdcall *INPUT_REQUESTED_PROC)(int nCode);
typedef int (__stdcall *EVENT_INFORM_PROC)(int nKeyCode, int nX, int nY, int nButton, int nShift, char *pstrKey, int nCode);

// An old plugin.
class COldPlugin : public IPlugin
{
public:
	COldPlugin(void);
	COldPlugin(const std::string file);
	~COldPlugin(void) { unload(); }
	bool load(const std::string file);
	void unload(void);

	void initialize(void);
	void terminate(void);
	bool query(const std::string function);
	bool execute(const std::string line, int &retValDt, std::string &retValLit, double &retValNum, const short usingReturn);
	int fight(const int enemyCount, const int skillLevel, const std::string background, const bool canRun);
	int fightInform(const int sourcePartyIndex, const int sourceFighterIndex, const int targetPartyIndex, const int targetFighterIndex, const int sourceHpLost, const int sourceSmpLost, const int targetHpLost, const int targetSmpLost, const std::string strMessage, const int attackCode);
	int menu(const int request);
	bool plugType(const int request);

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
IPlugin *loadPlugin(const std::string file);

inline std::string getString(const BSTR bstr)
{
	const int length = SysStringLen(bstr) + 1;
	char *const str = new char[length];
	WideCharToMultiByte(CP_ACP, 0, bstr, -1, str, length, NULL, NULL);
	const std::string toRet = str;
	delete [] str;
	return toRet;
}

inline BSTR getString(const std::string rhs)
{
	wchar_t *str = new wchar_t[rhs.length() + 1];
	MultiByteToWideChar(CP_ACP, 0, rhs.c_str(), -1, str, rhs.length() + 1);
	const BSTR toRet = SysAllocString(str);
	delete [] str;
	return toRet;
}

#endif

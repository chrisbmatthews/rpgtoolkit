/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

#include "../trans3.h"
static ICallbacks *g_pCallbacks = NULL;

#include "plugins.h"
#include "oldCallbacks.h"
#include <atlbase.h>
#include <vector>
#include "../common/mbox.h"

static std::vector<int> g_oldCallbacks;

/*
 * Load a plugin.
 */
IPlugin *loadPlugin(const std::string file)
{
	const int backslash = file.find_last_of('\\') + 1;
	const std::string name = file.substr(backslash, file.length() - (4 + backslash));
	if (name.empty()) return NULL;

	HMODULE mod = LoadLibrary(file.c_str());
	if (!mod)
	{
		messageBox("The file " + file + " is not a valid dynamically linkable library.");
		return NULL;
	}

	FARPROC pReg = GetProcAddress(mod, "DllRegisterServer");
	if (!pReg)
	{
		FreeLibrary(mod);
		COldPlugin *p = new COldPlugin();
		if (p->load(file))
		{
			p->initialize();
			return p;
		}
		messageBox("The file " + file + " is not a valid plugin.");
		delete p;
		return NULL;
	}

	if (FAILED(((HRESULT (__stdcall *)(void))pReg)()))
	{
		messageBox("An error occurred while registering " + file + ".");
		FreeLibrary(mod);
		return NULL;
	}

	FreeLibrary(mod);

	CComPlugin *p = new CComPlugin();

	wchar_t *str = new wchar_t[name.length() + 1];
	MultiByteToWideChar(CP_ACP, 0, name.c_str(), -1, str, name.length() + 1);
	const bool bLoaded = p->load(str + std::wstring(L".cls") + str);
	delete [] str;

	if (!bLoaded)
	{
		messageBox("A remotable class was not found in " + file + ".");
		delete p;
		return NULL;
	}

	p->initialize();
	return p;

}

/*
 * Initialize the plugin system.
 */
void initPluginSystem(void)
{
	if (g_pCallbacks) return;
	CoCreateInstance(CLSID_Callbacks, NULL, CLSCTX_INPROC_SERVER, IID_ICallbacks, (void **)&g_pCallbacks);
	// For backward compatibility.
	g_oldCallbacks.push_back(int(CBRpgCode));
	g_oldCallbacks.push_back(int(CBGetString));
	g_oldCallbacks.push_back(int(CBGetNumerical));
	g_oldCallbacks.push_back(int(CBSetString));
	g_oldCallbacks.push_back(int(CBSetNumerical));
	g_oldCallbacks.push_back(int(CBGetScreenDC));
	g_oldCallbacks.push_back(int(CBGetScratch1DC));
	g_oldCallbacks.push_back(int(CBGetScratch2DC));
	g_oldCallbacks.push_back(int(CBGetMwinDC));
	g_oldCallbacks.push_back(int(CBPopupMwin));
	g_oldCallbacks.push_back(int(CBHideMwin));
	g_oldCallbacks.push_back(int(CBLoadEnemy));
	g_oldCallbacks.push_back(int(CBGetEnemyNum));
	g_oldCallbacks.push_back(int(CBGetEnemyString));
	g_oldCallbacks.push_back(int(CBSetEnemyNum));
	g_oldCallbacks.push_back(int(CBSetEnemyString));
	g_oldCallbacks.push_back(int(CBGetPlayerNum));
	g_oldCallbacks.push_back(int(CBGetPlayerString));
	g_oldCallbacks.push_back(int(CBSetPlayerNum));
	g_oldCallbacks.push_back(int(CBSetPlayerString));
	g_oldCallbacks.push_back(int(CBGetGeneralString));
	g_oldCallbacks.push_back(int(CBGetGeneralNum));
	g_oldCallbacks.push_back(int(CBSetGeneralString));
	g_oldCallbacks.push_back(int(CBSetGeneralNum));
	g_oldCallbacks.push_back(int(CBGetCommandName));
	g_oldCallbacks.push_back(int(CBGetBrackets));
	g_oldCallbacks.push_back(int(CBCountBracketElements));
	g_oldCallbacks.push_back(int(CBGetBracketElement));
	g_oldCallbacks.push_back(int(CBGetStringElementValue));
	g_oldCallbacks.push_back(int(CBGetNumElementValue));
	g_oldCallbacks.push_back(int(CBGetElementType));
	g_oldCallbacks.push_back(int(CBDebugMessage));
	g_oldCallbacks.push_back(int(CBGetPathString));
	g_oldCallbacks.push_back(int(CBLoadSpecialMove));
	g_oldCallbacks.push_back(int(CBGetSpecialMoveString));
	g_oldCallbacks.push_back(int(CBGetSpecialMoveNum));
	g_oldCallbacks.push_back(int(CBLoadItem));
	g_oldCallbacks.push_back(int(CBGetItemString));
	g_oldCallbacks.push_back(int(CBGetItemNum));
	g_oldCallbacks.push_back(int(CBGetBoardNum));
	g_oldCallbacks.push_back(int(CBGetBoardString));
	g_oldCallbacks.push_back(int(CBSetBoardNum));
	g_oldCallbacks.push_back(int(CBSetBoardString));
	g_oldCallbacks.push_back(int(CBGetHwnd));
	g_oldCallbacks.push_back(int(CBRefreshScreen));
	g_oldCallbacks.push_back(int(CBCreateCanvas));
	g_oldCallbacks.push_back(int(CBDestroyCanvas));
	g_oldCallbacks.push_back(int(CBDrawCanvas));
	g_oldCallbacks.push_back(int(CBDrawCanvasPartial));
	g_oldCallbacks.push_back(int(CBDrawCanvasTransparent));
	g_oldCallbacks.push_back(int(CBDrawCanvasTransparentPartial));
	g_oldCallbacks.push_back(int(CBDrawCanvasTranslucent));
	g_oldCallbacks.push_back(int(CBCanvasLoadImage));
	g_oldCallbacks.push_back(int(CBCanvasLoadSizedImage));
	g_oldCallbacks.push_back(int(CBCanvasFill));
	g_oldCallbacks.push_back(int(CBCanvasResize));
	g_oldCallbacks.push_back(int(CBCanvas2CanvasBlt));
	g_oldCallbacks.push_back(int(CBCanvas2CanvasBltPartial));
	g_oldCallbacks.push_back(int(CBCanvas2CanvasBltTransparent));
	g_oldCallbacks.push_back(int(CBCanvas2CanvasBltTransparentPartial));
	g_oldCallbacks.push_back(int(CBCanvas2CanvasBltTranslucent));
	g_oldCallbacks.push_back(int(CBCanvasGetScreen));
	g_oldCallbacks.push_back(int(CBLoadString));
	g_oldCallbacks.push_back(int(CBCanvasDrawText));
	g_oldCallbacks.push_back(int(CBCanvasPopup));
	g_oldCallbacks.push_back(int(CBCanvasWidth));
	g_oldCallbacks.push_back(int(CBCanvasHeight));
	g_oldCallbacks.push_back(int(CBCanvasDrawLine));
	g_oldCallbacks.push_back(int(CBCanvasDrawRect));
	g_oldCallbacks.push_back(int(CBCanvasFillRect));
	g_oldCallbacks.push_back(int(CBCanvasDrawHand));
	g_oldCallbacks.push_back(int(CBDrawHand));
	g_oldCallbacks.push_back(int(CBCheckKey));
	g_oldCallbacks.push_back(int(CBPlaySound));
	g_oldCallbacks.push_back(int(CBMessageWindow));
	g_oldCallbacks.push_back(int(CBFileDialog));
	g_oldCallbacks.push_back(int(CBDetermineSpecialMoves));
	g_oldCallbacks.push_back(int(CBGetSpecialMoveListEntry));
	g_oldCallbacks.push_back(int(CBRunProgram));
	g_oldCallbacks.push_back(int(CBSetTarget));
	g_oldCallbacks.push_back(int(CBSetSource));
	g_oldCallbacks.push_back(int(CBGetPlayerHP));
	g_oldCallbacks.push_back(int(CBGetPlayerMaxHP));
	g_oldCallbacks.push_back(int(CBGetPlayerSMP));
	g_oldCallbacks.push_back(int(CBGetPlayerMaxSMP));
	g_oldCallbacks.push_back(int(CBGetPlayerFP));
	g_oldCallbacks.push_back(int(CBGetPlayerDP));
	g_oldCallbacks.push_back(int(CBGetPlayerName));
	g_oldCallbacks.push_back(int(CBAddPlayerHP));
	g_oldCallbacks.push_back(int(CBAddPlayerSMP));
	g_oldCallbacks.push_back(int(CBSetPlayerHP));
	g_oldCallbacks.push_back(int(CBSetPlayerSMP));
	g_oldCallbacks.push_back(int(CBSetPlayerFP));
	g_oldCallbacks.push_back(int(CBSetPlayerDP));
	g_oldCallbacks.push_back(int(CBGetEnemyHP));
	g_oldCallbacks.push_back(int(CBGetEnemyMaxHP));
	g_oldCallbacks.push_back(int(CBGetEnemySMP));
	g_oldCallbacks.push_back(int(CBGetEnemyMaxSMP));
	g_oldCallbacks.push_back(int(CBGetEnemyFP));
	g_oldCallbacks.push_back(int(CBGetEnemyDP));
	g_oldCallbacks.push_back(int(CBAddEnemyHP));
	g_oldCallbacks.push_back(int(CBAddEnemySMP));
	g_oldCallbacks.push_back(int(CBSetEnemyHP));
	g_oldCallbacks.push_back(int(CBSetEnemySMP));
	g_oldCallbacks.push_back(int(CBCanvasDrawBackground));
	g_oldCallbacks.push_back(int(CBCreateAnimation));
	g_oldCallbacks.push_back(int(CBDestroyAnimation));
	g_oldCallbacks.push_back(int(CBCanvasDrawAnimation));
	g_oldCallbacks.push_back(int(CBCanvasDrawAnimationFrame));
	g_oldCallbacks.push_back(int(CBAnimationCurrentFrame));
	g_oldCallbacks.push_back(int(CBAnimationMaxFrames));
	g_oldCallbacks.push_back(int(CBAnimationSizeX));
	g_oldCallbacks.push_back(int(CBAnimationSizeY));
	g_oldCallbacks.push_back(int(CBAnimationFrameImage));
	g_oldCallbacks.push_back(int(CBGetPartySize));
	g_oldCallbacks.push_back(int(CBGetFighterHP));
	g_oldCallbacks.push_back(int(CBGetFighterMaxHP));
	g_oldCallbacks.push_back(int(CBGetFighterSMP));
	g_oldCallbacks.push_back(int(CBGetFighterMaxSMP));
	g_oldCallbacks.push_back(int(CBGetFighterFP));
	g_oldCallbacks.push_back(int(CBGetFighterDP));
	g_oldCallbacks.push_back(int(CBGetFighterName));
	g_oldCallbacks.push_back(int(CBGetFighterAnimation));
	g_oldCallbacks.push_back(int(CBGetFighterChargePercent));
	g_oldCallbacks.push_back(int(CBFightTick));
	g_oldCallbacks.push_back(int(CBDrawTextAbsolute));
	g_oldCallbacks.push_back(int(CBReleaseFighterCharge));
	g_oldCallbacks.push_back(int(CBFightDoAttack));
	g_oldCallbacks.push_back(int(CBFightUseItem));
	g_oldCallbacks.push_back(int(CBFightUseSpecialMove));
	g_oldCallbacks.push_back(int(CBDoEvents));
	g_oldCallbacks.push_back(int(CBFighterAddStatusEffect));
	g_oldCallbacks.push_back(int(CBFighterRemoveStatusEffect));
}

/*
 * Shut down the plugin system.
 */
void freePluginSystem(void)
{
	if (!g_pCallbacks) return;
	g_pCallbacks->Release();
	g_pCallbacks = NULL;
	g_oldCallbacks.clear();
}

/*
 * Default constructor.
 */
CComPlugin::CComPlugin(void)
{
	m_plugin = NULL;
}

COldPlugin::COldPlugin(void)
{
	m_hModule = NULL;
}

/*
 * Work constructor.
 *
 * cls (in) - class ID to construct
 */
CComPlugin::CComPlugin(const std::wstring cls)
{
	m_plugin = NULL;
	load(cls);
}

COldPlugin::COldPlugin(const std::string file)
{
	m_hModule = NULL;
	load(file);
}

/*
 * Load a plugin.
 *
 * cls (in) - class ID to construct
 */
bool CComPlugin::load(const std::wstring cls)
{
	if (m_plugin || !g_pCallbacks) return false;
	CLSID id;
	if (FAILED(CLSIDFromProgID(cls.c_str(), &id))) return false;
	if (FAILED(CoCreateInstance(id, NULL, CLSCTX_INPROC_SERVER, IID_IDispatch, (LPVOID *)&m_plugin)))
	{
		return false;
	}
	DISPID disp;
	{
		const wchar_t *const str = L"setCallbacks";
		if (FAILED(m_plugin->GetIDsOfNames(IID_NULL, (LPOLESTR *)&str, 1, LOCALE_USER_DEFAULT, &disp)))
		{
			unload();
			return false;
		}
	}
	DISPPARAMS params = {NULL, NULL, 1, 1};
	VARIANT var;
	var.vt = VT_DISPATCH;
	var.pdispVal = g_pCallbacks;
	params.rgvarg = &var;
	DISPID put = DISPID_PROPERTYPUT;
	params.rgdispidNamedArgs = &put;
	if (FAILED(m_plugin->Invoke(disp, IID_NULL, LOCALE_USER_DEFAULT, DISPATCH_PROPERTYPUTREF, &params, NULL, NULL, NULL)))
	{
		// No property set; try for property let.
		if (FAILED(m_plugin->Invoke(disp, IID_NULL, LOCALE_USER_DEFAULT, DISPATCH_PROPERTYPUT, &params, NULL, NULL, NULL)))
		{
			unload();
			return false;
		}
	}
	return true;
}

bool COldPlugin::load(const std::string file)
{
	if (m_hModule || !g_pCallbacks) return false;
	m_hModule = LoadLibrary(file.c_str());
	if (!m_hModule) return false;
	INIT_PROC pInit = INIT_PROC(GetProcAddress(m_hModule, TEXT("TKPlugInit")));
	VERSION_PROC pVersion = VERSION_PROC(GetProcAddress(m_hModule, TEXT("TKPlugVersion")));
	if (pInit)
	{
		pInit(&g_oldCallbacks[0], (!pVersion) ? 45 : g_oldCallbacks.size());
	}
	else
	{
		FreeLibrary(m_hModule);
		return false;
	}
	m_plugBegin = BEGIN_PROC(GetProcAddress(m_hModule, TEXT("TKPlugBegin")));
	m_plugQuery = QUERY_PROC(GetProcAddress(m_hModule, TEXT("TKPlugQuery")));
	m_plugExecute = EXECUTE_PROC(GetProcAddress(m_hModule, TEXT("TKPlugExecute")));
	m_plugEnd = END_PROC(GetProcAddress(m_hModule, TEXT("TKPlugEnd")));
	m_plugType = TYPE_PROC(GetProcAddress(m_hModule, TEXT("TKPlugType")));
	m_plugMenu = MENU_PROC(GetProcAddress(m_hModule, TEXT("TKPlugMenu")));
	m_plugFight = FIGHT_PROC(GetProcAddress(m_hModule, TEXT("TKPlugFight")));
	m_plugFightInform = FIGHT_INFORM_PROC(GetProcAddress(m_hModule, TEXT("TKPlugFightInform")));
	m_plugInputRequested = INPUT_REQUESTED_PROC(GetProcAddress(m_hModule, TEXT("TKPlugInputRequested")));
	m_plugEventInform = EVENT_INFORM_PROC(GetProcAddress(m_hModule, TEXT("TKPlugEventInform")));
	return true;
}

/*
 * Initialize the plugin.
 */
void CComPlugin::initialize(void)
{
	if (!m_plugin) return;
	m_plugin->initialize();
}

void COldPlugin::initialize(void)
{
	if (!m_hModule) return;
	m_plugBegin();
}

/*
 * Terminate the plugin.
 */
void CComPlugin::terminate(void)
{
	if (!m_plugin) return;
	m_plugin->terminate();
}

void COldPlugin::terminate(void)
{
	if (!m_hModule) return;
	m_plugEnd();
}

/*
 * Query to check whether we support a function.
 */
bool CComPlugin::query(const std::string function)
{
	if (!m_plugin) return false;
	BSTR bstr = getString(function);
	VARIANT_BOOL toRet = VARIANT_FALSE;
	m_plugin->query(bstr, &toRet);
	SysFreeString(bstr);
	return (toRet == VARIANT_TRUE);
}

bool COldPlugin::query(const std::string function)
{
	if (!m_hModule) return false;
#pragma warning (disable : 4800) // forcing value to bool 'true' or 'false' (performance warning)
	return m_plugQuery((char *)function.c_str());
#pragma warning (default : 4800) // forcing value to bool 'true' or 'false' (performance warning)
}

/*
 * Execute an RPGCode function.
 */
bool CComPlugin::execute(const std::string line, int &retValDt, std::string &retValLit, double &retValNum, const short usingReturn)
{
	if (!m_plugin) return false;
	BSTR bstrLine = getString(line);
	BSTR retLit = SysAllocString(L"");
	VARIANT_BOOL toRet = VARIANT_FALSE;
	m_plugin->execute(bstrLine, &retValDt, &retLit, &retValNum, usingReturn, &toRet);
	retValLit = getString(retLit);
	SysFreeString(retLit);
	SysFreeString(bstrLine);
	return (toRet == VARIANT_TRUE);
}

bool COldPlugin::execute(const std::string line, int &retValDt, std::string &retValLit, double &retValNum, const short usingReturn)
{
	if (!m_hModule) return false;
	retValDt = 0;
	retValNum = 0.0;
#pragma warning (disable : 4800) // forcing value to bool 'true' or 'false' (performance warning)
	return m_plugExecute((char *)line.c_str());
#pragma warning (default : 4800) // forcing value to bool 'true' or 'false' (performance warning)
}

/*
 * Start a fight.
 */
int CComPlugin::fight(const int enemyCount, const int skillLevel, const std::string background, const bool canRun)
{
	if (!m_plugin) return 0;
	int toRet = 0;
	BSTR bstr = getString(background);
	m_plugin->fight(enemyCount, skillLevel, bstr, canRun, &toRet);
	SysFreeString(bstr);
	return toRet;
}

int COldPlugin::fight(const int enemyCount, const int skillLevel, const std::string background, const bool canRun)
{
	if (!m_hModule) return 0;
	return m_plugFight(enemyCount, skillLevel, (char *)background.c_str(), canRun);
}

/*
 * Send a fight message.
 */
int CComPlugin::fightInform(const int sourcePartyIndex, const int sourceFighterIndex, const int targetPartyIndex, const int targetFighterIndex, const int sourceHpLost, const int sourceSmpLost, const int targetHpLost, const int targetSmpLost, const std::string strMessage, const int attackCode)
{
	if (!m_plugin) return 0;
	int toRet = 0;
	BSTR bstr = getString(strMessage);
	m_plugin->fightInform(sourcePartyIndex, sourceFighterIndex, targetPartyIndex, targetFighterIndex, sourceHpLost, sourceSmpLost, targetHpLost, targetSmpLost, bstr, attackCode, &toRet);
	SysFreeString(bstr);
	return toRet;
}

int COldPlugin::fightInform(const int sourcePartyIndex, const int sourceFighterIndex, const int targetPartyIndex, const int targetFighterIndex, const int sourceHpLost, const int sourceSmpLost, const int targetHpLost, const int targetSmpLost, const std::string strMessage, const int attackCode)
{
	if (!m_hModule) return 0;
	return m_plugFightInform(sourcePartyIndex, sourceFighterIndex, targetPartyIndex, targetFighterIndex, sourceHpLost, sourceSmpLost, targetHpLost, targetSmpLost, (char *)strMessage.c_str(), attackCode);
}

/*
 * Open a menu.
 */
int CComPlugin::menu(const int request)
{
	if (!m_plugin) return 0;
	int toRet = 0;
	m_plugin->menu(request, &toRet);
	return toRet;
}

int COldPlugin::menu(const int request)
{
	if (!m_hModule) return 0;
	return m_plugMenu(request);
}

/*
 * Check whether we are a certain type of plugin.
 */
bool CComPlugin::plugType(const int request)
{
	if (!m_plugin) return 0;
	VARIANT_BOOL toRet = VARIANT_FALSE;
	m_plugin->type(request, &toRet);
	return (toRet == VARIANT_TRUE);
}

bool COldPlugin::plugType(const int request)
{
	if (!m_hModule) return false;
#pragma warning (disable : 4800) // forcing value to bool 'true' or 'false' (performance warning)
	return (m_plugType ? m_plugType(request) : (request == PT_RPGCODE));
#pragma warning (default : 4800) // forcing value to bool 'true' or 'false' (performance warning)
}

/*
 * Unload a plugin.
 */
void CComPlugin::unload(void)
{
	if (m_plugin)
	{
		m_plugin->Release();
		m_plugin = NULL;
	}
}

void COldPlugin::unload(void)
{
	if (m_hModule)
	{
		FreeLibrary(m_hModule);
		m_hModule = NULL;
	}
}

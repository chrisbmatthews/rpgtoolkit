/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

/*
 * Implementation of CPlugin
 */

#include "../trans3.h"
#include "CPlugin.h"
#include <atlbase.h>

/*
 * Default constructor.
 */
CPlugin::CPlugin(void)
{
	CoInitialize(NULL);
	m_plugin = NULL;
}

/*
 * Work constructor.
 *
 * cls (in) - class ID to construct
 */
CPlugin::CPlugin(const std::wstring cls)
{
	CoInitialize(NULL);
	m_plugin = NULL;
	load(cls);
}

/*
 * Copy constructor.
 *
 * rhs (in) - object from which to construct
 */
CPlugin::CPlugin(const CPlugin &rhs)
{
	CoInitialize(NULL);
	if (m_plugin = rhs.m_plugin)
	{
		m_plugin->AddRef();
	}
}

/*
 * Assignment operator.
 *
 * rhs (in) - object from which to assign
 */
CPlugin &CPlugin::operator=(const CPlugin &rhs)
{
	if (this != &rhs)
	{
		if (m_plugin) m_plugin->Release();
		if (m_plugin = rhs.m_plugin)
		{
			m_plugin->AddRef();
		}
	}
	return *this;
}

/*
 * Deconstructor.
 */
CPlugin::~CPlugin(void)
{
	unload();
	CoUninitialize();
}

/*
 * Load a plugin.
 *
 * cls (in) - class ID to construct
 */
bool CPlugin::load(const std::wstring cls)
{
	if (m_plugin) return false;
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
	CoCreateInstance(CLSID_Callbacks, NULL, CLSCTX_INPROC_SERVER, IID_IDispatch, (LPVOID *)&var.pdispVal);
	params.rgvarg = &var;
	DISPID put = DISPID_PROPERTYPUT;
	params.rgdispidNamedArgs = &put;
	if (FAILED(m_plugin->Invoke(disp, IID_NULL, LOCALE_USER_DEFAULT, DISPATCH_PROPERTYPUTREF, &params, NULL, NULL, NULL)))
	{
		// No property set; try for property let.
		if (FAILED(m_plugin->Invoke(disp, IID_NULL, LOCALE_USER_DEFAULT, DISPATCH_PROPERTYPUT, &params, NULL, NULL, NULL)))
		{
			unload();
			var.pdispVal->Release();
			return false;
		}
	}
	var.pdispVal->Release();
	return true;
}

/*
 * Invoke a method.
 *
 * name (in) - method to invoke
 * params (in) - parameters to pass
 * paramCount (in) - number of parameters to pass
 * ret (out) - value returned
 * return (out) - whether there was an error
 */
HRESULT CPlugin::invoke(const std::wstring name, LPVARIANT params, const int paramCount, LPVARIANT ret)
{
	DISPID disp;
	const wchar_t *const str = name.c_str();
	if (FAILED(m_plugin->GetIDsOfNames(IID_NULL, (LPOLESTR *)&str, 1, LOCALE_USER_DEFAULT, &disp)))
	{
		return S_FALSE;
	}
	DISPPARAMS dispParams = {params, NULL, paramCount, 0};
	return m_plugin->Invoke(disp, IID_NULL, LOCALE_USER_DEFAULT, DISPATCH_METHOD, &dispParams, ret, NULL, NULL);
}

/*
 * Initialize the plugin.
 */
void CPlugin::initialize(void)
{
	if (!m_plugin) return;
	invoke(L"Plugin_Initialize", NULL, 0, NULL);
}

/*
 * Terminate the plugin.
 */
void CPlugin::terminate(void)
{
	if (!m_plugin) return;
	invoke(L"Plugin_Terminate", NULL, 0, NULL);
}

/*
 * Query to check whether we support a function.
 */
bool CPlugin::query(const std::wstring function)
{
	if (!m_plugin) return false;
	CComVariant var = function.c_str(), ret;
	invoke(L"RPGCode_Query", &var, 1, &ret);
	return (ret.boolVal == VARIANT_TRUE);
}

/*
 * Execute an RPGCode function.
 */
bool CPlugin::execute(const std::wstring line, int &retValDt, std::wstring &retValLit, double &retValNum, const short usingReturn)
{
	if (!m_plugin) return false;
	VARIANT params[5];
	CComVariant(line.c_str()).Detach(&params[0]);
	params[1].vt = VT_INT | VT_BYREF;
	params[2].vt = VT_BSTR | VT_BYREF;
	params[2].bstrVal = SysAllocString(L"");
	params[3].vt = VT_R8 | VT_BYREF;
	CComVariant(usingReturn).Detach(&params[4]);
	CComVariant ret;
	invoke(L"RPGCode_Execute", params, 5, &ret);
	retValDt = params[1].intVal;
	retValLit = params[2].bstrVal;
	retValNum = params[3].dblVal;
	SysFreeString(params[2].bstrVal);
	return (ret.boolVal == VARIANT_TRUE);
}

/*
 * Start a fight.
 */
int CPlugin::fight(const int enemyCount, const int skillLevel, const std::wstring background, const bool canRun)
{
	if (!m_plugin) return 0;
	CComVariant params[] = {enemyCount, skillLevel, background.c_str(), canRun}, ret;
	invoke(L"fight", params, 4, &ret);
	return ret.intVal;
}

/*
 * Send a fight message.
 */
int CPlugin::fightInform(const int sourcePartyIndex, const int sourceFighterIndex, const int targetPartyIndex, const int targetFighterIndex, const int sourceHpLost, const int sourceSmpLost, const int targetHpLost, const int targetSmpLost, const std::wstring strMessage, const int attackCode)
{
	if (!m_plugin) return 0;
	CComVariant params[] = {sourcePartyIndex, sourceFighterIndex, targetPartyIndex, targetFighterIndex, sourceHpLost, sourceSmpLost, targetHpLost, targetSmpLost, strMessage.c_str(), attackCode}, ret;
	invoke(L"FightInform", params, 10, &ret);
	return ret.intVal;
}

/*
 * Open a menu.
 */
int CPlugin::menu(const int request)
{
	if (!m_plugin) return 0;
	CComVariant var = request, ret;
	invoke(L"menu", &var, 1, &ret);
	return ret.intVal;
}

/*
 * Check whether we are a certain type of plugin.
 */
bool CPlugin::plugType(const int request)
{
	if (!m_plugin) return 0;
	CComVariant var = request, ret;
	invoke(L"plugType", &var, 1, &ret);
	return (ret.boolVal == VARIANT_TRUE);
}

/*
 * Unload a plugin.
 */
void CPlugin::unload(void)
{
	if (m_plugin)
	{
		m_plugin->Release();
		m_plugin = NULL;
	}
}

/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

/*
 * Definition of CPlugin
 */

#ifndef _CPLUGIN_H_
#define _CPLUGIN_H_

#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <objbase.h>
#include <string>

class CCallbackInterface;

class CPlugin
{
public:
	CPlugin(void);
	CPlugin(const std::wstring cls);
	CPlugin(const CPlugin &rhs);
	CPlugin &operator=(const CPlugin &rhs);
	~CPlugin(void);
	bool load(const std::wstring cls);
	void unload(void);
	static void initCallbacks(void);
	static void freeCallbacks(void);

	void initialize(void);
	void terminate(void);
	bool query(const std::wstring function);
	bool execute(const std::wstring line, int &retValDt, std::wstring &retValLit, double &retValNum, const short usingReturn);
	int fight(const int enemyCount, const int skillLevel, const std::wstring background, const bool canRun);
	int fightInform(const int sourcePartyIndex, const int sourceFighterIndex, const int targetPartyIndex, const int targetFighterIndex, const int sourceHpLost, const int sourceSmpLost, const int targetHpLost, const int targetSmpLost, const std::wstring strMessage, const int attackCode);
	int menu(const int request);
	bool plugType(const int request);

private:
	HRESULT invoke(const std::wstring name, LPVARIANT params, const int paramCount, LPVARIANT ret);
	IDispatch *m_plugin;
};

/*
 * Cast from ASCII -> UNICODE.
 */
inline std::wstring stringCast(const std::string rhs)
{
	wchar_t *str = new wchar_t[rhs.length() + 1];
	MultiByteToWideChar(CP_ACP, 0, rhs.c_str(), -1, str, rhs.length() + 1);
	const std::wstring toRet = str;
	delete [] str;
	return toRet;
}

/*
 * Cast from UNICODE -> ASCII.
 */
inline std::string stringCast(const std::wstring rhs)
{
	char *str = new char[rhs.length() + 1];
	WideCharToMultiByte(CP_ACP, 0, rhs.c_str(), -1, str, rhs.length() + 1, NULL, NULL);
	const std::string toRet = str;
	delete [] str;
	return toRet;
}

#endif

/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

#ifndef _RPGCODE_GLOBALS_H_
#define _RPGCODE_GLOBALS_H_

#include <string>
#include "CProgram/CProgram.h"
#define WIN32_LEAN_AND_MEAN
#include <windows.h>

class CGameTimeVar : public CVariant::CObject
{
public:
	CGameTimeVar(void) { m_dwStart = GetTickCount(); }
	CVariant::DATA_TYPE getType(void) { return CVariant::DT_NUM; }
	double getNum(void) { return (GetTickCount() - m_dwStart) / 1000.0; }
	static void createVar(void)
	{
		CGameTimeVar *const p = new CGameTimeVar();
		CProgram::setGlobal("gameTime", p);
		CProgram::setGlobal("gameTime!", p);
		p->setCopyObject(false);
	}
private:
	DWORD m_dwStart;
};

inline void createRpgCodeGlobals(void)
{
	CGameTimeVar::createVar();
}

template <class T>
class CAddressMapNum : public CVariant::CObject
{
public:
	CAddressMapNum(T *const pVar): m_p(pVar) { }
	CVariant::DATA_TYPE getType(void) { return CVariant::DT_NUM; }
	double getNum(void) { return (double)*m_p; }
	bool canSet(void) { return true; }
	void set(const double num) { *m_p = (T)num; }
private:
	T *const m_p;
};

template <class T>
inline void createNumGlobal(const std::string name, T &rVar)
{
	if (name.empty()) return;
	CAddressMapNum<T> *const p = new CAddressMapNum<T>(&rVar);
	CProgram::setGlobal(name, p);
	if (name[name.length() - 1] == '!')
	{
		CProgram::setGlobal(name.substr(0, name.length() - 1), p);
	}
	else
	{
		CProgram::setGlobal(name + '!', p);
	}
	p->setCopyObject(false);
}

class CAddressMapLit : public CVariant::CObject
{
public:
	CAddressMapLit(std::string *const pVar): m_p(pVar) { }
	CVariant::DATA_TYPE getType(void) { return CVariant::DT_LIT; }
	std::string getLit(void) { return *m_p; }
	bool canSet(void) { return true; }
	void set(const std::string str) { *m_p = str; }
private:
	std::string *const m_p;
};

inline void createLitGlobal(const std::string name, std::string &rVar)
{
	if (name.empty()) return;
	CAddressMapLit *const p = new CAddressMapLit(&rVar);
	CProgram::setGlobal(name, p);
	if (name[name.length() - 1] == '$')
	{
		CProgram::setGlobal(name.substr(0, name.length() - 1), p);
	}
	else
	{
		CProgram::setGlobal(name + '$', p);
	}
	p->setCopyObject(false);
}

#endif

/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

#include "globals.h"
#include "CProgram/CProgram.h"
#define WIN32_LEAN_AND_MEAN
#include <windows.h>

/*
 * The gameTime[!] RPGCode global returns the number
 * of seconds the game has been running for.
 */
class CGameTimeVar: public CVariant::CObject
{
public:
	CGameTimeVar(void) { m_dwStart = GetTickCount(); }
	CVariant::DATA_TYPE getType(void) { return CVariant::DT_NUM; }
	double getNum(void) { return (GetTickCount() - m_dwStart) / 1000.0; }
	// Create the gameTime RPGCode global.
	static void createVar(void)
	{
		CGameTimeVar *p = new CGameTimeVar();
		CProgram::setGlobal("gameTime", p);
		CProgram::setGlobal("gameTime!", p);
		p->setCopyObject(false);
	}
private:
	DWORD m_dwStart;
};

/*
 * Create all globals.
 */
void createRpgCodeGlobals(void)
{
	CGameTimeVar::createVar();
}

/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

#include "status.h"
#include "CFile.h"
#include "mbox.h"

void tagStatusEffect::open(const STRING strFile)
{
	CFile file(strFile);

	file.seek(16);
	char c;
	file >> c;
	file.seek(0);
	if (!c)
	{
		STRING header;
		file >> header;
		if (header != _T("RPGTLKIT STATUSE"))
		{
			messageBox(_T("This is not a valid status effect file! ") + strFile);
			return;
		}
		short majorVer, minorVer;
		file >> majorVer >> minorVer;

		file >> name;
		file >> rounds;
		file >> speed;
		file >> slow;
		file >> disable;
		file >> hp;
		file >> hpAmount;
		file >> smp;
		file >> smpAmount;
		file >> code;
		file >> prg;

		return;
	}
	if (file.line() != _T("RPGTLKIT STATUSE"))
	{
		messageBox(_T("This is not a valid status effect file! ") + strFile);
		return;
	}
	file.line(); // majorVer
	file.line(); // minorVer
	name = file.line();
	rounds = _ttoi(file.line().c_str());
	speed = _ttoi(file.line().c_str());
	slow = _ttoi(file.line().c_str());
	disable = _ttoi(file.line().c_str());
	hp = _ttoi(file.line().c_str());
	hpAmount = _ttoi(file.line().c_str());
	smp = _ttoi(file.line().c_str());
	smpAmount = _ttoi(file.line().c_str());
	code = _ttoi(file.line().c_str());
	prg = file.line();
}

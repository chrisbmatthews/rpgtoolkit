/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

#include "status.h"
#include "CFile.h"

void tagStatusEffect::open(const std::string strFile)
{
	CFile file(strFile);

	file.seek(16);
	char c;
	file >> c;
	file.seek(0);
	if (!c)
	{
		std::string header;
		file >> header;
		if (header != "RPGTLKIT STATUSE")
		{
			MessageBox(NULL, ("This is not a valid status effect file! " + strFile).c_str(), NULL, 0);
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
	if (file.line() != "RPGTLKIT STATUSE")
	{
		MessageBox(NULL, ("This is not a valid status effect file! " + strFile).c_str(), NULL, 0);
		return;
	}
	file.line(); // majorVer
	file.line(); // minorVer
	name = file.line();
	rounds = atoi(file.line().c_str());
	speed = atoi(file.line().c_str());
	slow = atoi(file.line().c_str());
	disable = atoi(file.line().c_str());
	hp = atoi(file.line().c_str());
	hpAmount = atoi(file.line().c_str());
	smp = atoi(file.line().c_str());
	smpAmount = atoi(file.line().c_str());
	code = atoi(file.line().c_str());
	prg = file.line();
}

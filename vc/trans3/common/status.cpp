/*
 ********************************************************************
 * The RPG Toolkit, Version 3
 * This file copyright (C) 2006  Christopher Matthews & contributors
 *
 * Contributors:
 *    - Colin James Fitzpatrick
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

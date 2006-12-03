/*
 ********************************************************************
 * The RPG Toolkit, Version 3
 * This file copyright (C) 2006  Colin James Fitzpatrick
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

#ifndef _COPTIMISER_H_
#define _COPTIMISER_H_

#include "CProgram.h"

typedef std::pair<POS, POS> CALL_PARAM;

class COptimiser
{
public:
	COptimiser(CProgram &prg): m_prg(prg) { }

	bool inlineExpand();
	void propagateConstants();

private:
	COptimiser(COptimiser &);
	COptimiser &operator=(COptimiser &);

	void getCallSite(int required, POS &i, POS begin, std::deque<CALL_PARAM> &params) const;

	CProgram &m_prg;
};

#endif

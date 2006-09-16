/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

#ifndef _COPTIMISER_H_
#define _COPTIMISER_H_

#include "CProgram.h"

typedef std::pair<POS, POS> CALL_PARAM;

class COptimiser
{
public:
	COptimiser(CProgram &prg): m_prg(prg) { }

	void inlineExpand();

private:
	COptimiser(COptimiser &);
	COptimiser &operator=(COptimiser &);

	void getCallSite(int required, POS &i, POS begin, std::deque<CALL_PARAM> &params) const;

	CProgram &m_prg;
};

#endif

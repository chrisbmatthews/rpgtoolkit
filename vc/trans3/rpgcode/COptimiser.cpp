/*
 * All contents copyright 2006, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

#include "COptimiser.h"

/*
 * Obtain some details of a given call site.
 */
void COptimiser::getCallSite(int required, POS &i, POS begin, std::deque<CALL_PARAM> &params) const
{
	do
	{
		if (i->udt & UDT_LINE)
		{
			++i;
			break;
		}
		else
		{
			POS j = i;
			if ((i->udt & UDT_FUNC) && i->params)
			{
				// Another function!
				std::deque<CALL_PARAM> reparams;
				getCallSite(i->params, --j, begin, reparams);
			}
			params.push_front(std::pair<POS, POS>(j, i));
			i = j;
			if (!--required) break;
		}

	} while (i-- != begin);
}

/*
 * Inline expand a program's functions.
 * Note that this actually slows down calls considerably unless
 * constant propagation is also applied!
 */
void COptimiser::inlineExpand()
{
	std::map<LPNAMED_METHOD, MACHINE_UNITS> methods;

	// Make copies of all the program's methods.
	{
		std::vector<tagNamedMethod>::iterator i = m_prg.m_methods.begin();
		for (; i != m_prg.m_methods.end(); ++i)
		{
			MACHINE_UNITS &method = methods[i];
			POS j = m_prg.m_units.begin() + i->i;
			int depth = 0;
			do
			{
				method.push_back(*j);

				if (j->udt & UDT_OPEN) ++depth;
				else if ((j->udt & UDT_CLOSE) && !--depth) break;
			} while (++j != m_prg.m_units.end());

			method.pop_front();
			method.pop_back();

			//m_prg.m_units.erase(m_prg.m_units.begin() + i->i + 1, j - 1 /*+ 1*/);
		}
	}

	// Locate method calls.
	TCHAR chr = 0;
	POS i = m_prg.m_units.begin();
	for (; i != m_prg.m_units.end(); ++i)
	{
		if (!((i->udt & UDT_FUNC) && (i->func == CProgram::methodCall))) continue;
		POS unit = i - 1;
		if (unit->udt & UDT_OBJ) continue;
		LPNAMED_METHOD p = NAMED_METHOD::locate(unit->lit, i->params - 1, false, m_prg);
		if (!p) continue;

		LPMACHINE_UNITS pUnits = &methods.find(p)->second;

		// Back peddle to find where this call site begins.

		MACHINE_UNITS paramUnits;

		POS j = i;

		{
			std::deque<CALL_PARAM> params;
			getCallSite(i->params, --j, m_prg.m_units.begin(), params);

			MACHINE_UNIT assign;
			assign.udt = UNIT_DATA_TYPE(UDT_FUNC | UDT_LINE);
			assign.params = 2;
			assign.func = operators::assign;

			std::deque<CALL_PARAM>::iterator k = params.begin();
			for (; k != (params.end() - 1); ++k)
			{
				MACHINE_UNIT lhs;
				lhs.udt = UDT_ID;
				TCHAR pos = p->params - (k - params.begin());

				lhs.lit = STRING(_T(" ")) + pos;

				paramUnits.push_back(lhs);
				paramUnits.insert(paramUnits.end(), k->first, k->second + 1);

				paramUnits.push_back(assign);
			}
		}

		paramUnits.insert(paramUnits.end(), pUnits->begin(), pUnits->end());

		MACHINE_UNIT mu;
		mu.udt = UDT_ID;
		mu.lit = STRING(_T(" ret")) + ++chr;

		// Fix up return values.
		for (POS k = paramUnits.begin(); k != paramUnits.end(); ++k)
		{
			if (!((k->udt & UDT_FUNC) && (k->func == CProgram::returnVal))) continue;
			k->func = operators::assign;
			k->params = 2;

			std::deque<CALL_PARAM> rparams;
			getCallSite(1, --k, paramUnits.begin(), rparams);
			k = paramUnits.insert(k, mu) + 1;
		}

		k = m_prg.m_units.erase(j, i + 1);
		k = m_prg.m_units.insert(k, mu);

		while (--k != m_prg.m_units.begin())
		{
			if (k->udt & UDT_LINE) break;
		}

		// Now we insert the function's body!
		m_prg.m_units.insert(k + 1, paramUnits.begin(), paramUnits.end());
		i = m_prg.m_units.begin(); // (Heh...)
	}

	/**{
		POS i = m_prg.m_units.begin();
		for (; i != m_prg.m_units.end(); ++i)
		{
			i->show();
		}
	}**/
}

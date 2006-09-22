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
 * This also performs some rudimentary constant propagation
 * but a better constant propagator should be written at some
 * latter date!
 */
bool COptimiser::inlineExpand()
{
	std::map<LPNAMED_METHOD, MACHINE_UNITS> methods;

	// Make copies of all the program's methods.
	{
		std::vector<tagNamedMethod>::iterator i = m_prg.m_methods.begin();
		for (; i != m_prg.m_methods.end(); ++i)
		{
			if (!i->bInline) continue;

			MACHINE_UNITS &method = methods[&*i];
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

			// m_prg.m_units.erase(m_prg.m_units.begin() + i->i - 1, j + 1);
		}
	}

	if (!methods.size()) return false;

	// Locate method calls.
	TCHAR chr = 0;
	POS i = m_prg.m_units.begin();
	for (; i != m_prg.m_units.end(); ++i)
	{
		if (!((i->udt & UDT_FUNC) && (i->func == CProgram::methodCall))) continue;
		POS unit = i - 1;
		if (unit->udt & UDT_OBJ) continue;
		LPNAMED_METHOD p = NAMED_METHOD::locate(unit->lit, i->params - 1, false, m_prg);
		if (!(p && p->bInline)) continue;

		LPMACHINE_UNITS pUnits = &methods.find(p)->second;

		// Back peddle to find where this call site begins.

		MACHINE_UNITS paramUnits;

		POS j = i;

		std::map<STRING, MACHINE_UNIT> subst;

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
				TCHAR pos = p->params - (k - params.begin());
				STRING var = STRING(_T(" ")) + pos;

				if ((k->first != k->second) || (k->first->udt & UDT_FUNC))
				{
					MACHINE_UNIT lhs;
					lhs.udt = UDT_ID;
					lhs.lit = var;

					paramUnits.push_back(lhs);
					paramUnits.insert(paramUnits.end(), k->first, k->second + 1);

					paramUnits.push_back(assign);
				}
				else
				{
					// The parameter is just a simple constant value so
					// we can plug it to the function directly later.
					subst.insert(std::pair<STRING, MACHINE_UNIT>(
						var, *k->first
					));
				}
			}
		}

		paramUnits.insert(paramUnits.end(), pUnits->begin(), pUnits->end());

		MACHINE_UNIT mu;
		mu.udt = UDT_ID;
		mu.lit = STRING(_T(" ret")) + ++chr;

		MACHINE_UNITS retVal;

		// Fix up return values.
		for (POS k = paramUnits.begin(); k != paramUnits.end(); ++k)
		{
			if (k->udt & UDT_ID)
			{
				std::map<STRING, MACHINE_UNIT>::iterator i = subst.find(k->lit);
				if (i != subst.end())
				{
					*k = i->second;
				}
				continue;
			}
			if (!((k->udt & UDT_FUNC) && (k->func == CProgram::returnVal))) continue;

			if (k == (paramUnits.end() - 1))
			{
				// This return statement is the last statement in the function
				// so we can just replace the function call by its argument
				// rather than setting up the return properly.
				std::deque<CALL_PARAM> params;
				POS j = k - 1;
				getCallSite(1, j, paramUnits.begin(), params);
				retVal.insert(retVal.begin(), j, k);
				paramUnits.erase(j, k + 1);
				break;
			}
			else
			{
				k->func = operators::assign;
				k->params = 2;

				std::deque<CALL_PARAM> rparams;
				getCallSite(1, --k, paramUnits.begin(), rparams);
				k = paramUnits.insert(k, mu) + 1;
			}
		}

		k = m_prg.m_units.erase(j, i + 1);

		if (retVal.size())
		{
			const int kpos = k - m_prg.m_units.begin();
			m_prg.m_units.insert(k, retVal.begin(), retVal.end());
			k = m_prg.m_units.begin() + kpos;
		}
		else
		{
			k = m_prg.m_units.insert(k, mu);
		}

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

	return true;
}

#if 0

/*
 * Propagate constant values by replacing variable references
 * with their values where those values are constants or other
 * variables.
 */
void COptimiser::propagateConstants()
{
	// Beware: terrible algorithm here!
	//
	// When if/while/for/branch are encountered, and when if/while/for
	// end, the constant pool is reset even if conditional code does
	// does affect certain constants! This is to avoid trick situations
	// but it is far over-reaching. In general it is safe to maintain
	// the pool of constants for an if...else construct (using the same
	// pool that existed before the construct for both parts of it) but
	// this is too much work for now. (Branch will proabably break this
	// algorithm!)
	//
	// The technique here is to look for assignment instructions with
	// constant right hand sides and maintain a map (the "pool") of
	// {var : constant} that is updated with each new assignment. Then
	// when a reference to a var is found, it is replaced by the constant
	// in the pool. This is good enough to mitigate the ineffectuality of
	// the redundant assignment instructions generated by inlineExpand(),
	// but not good enough to do anything else!
	//
	// This algorithm also makes the assumption that all function calls
	// have no side effects. It is not safe (!) for general use because
	// of this!

	std::map<STRING, MACHINE_UNIT> pool;

	POS i = m_prg.m_units.begin();
	for (; i != m_prg.m_units.end(); ++i)
	{
		if (i->udt & UDT_FUNC)
		{
			if (i->func == operators::assign)
			{
				POS j = i - 1;
				std::deque<CALL_PARAM> params;
				getCallSite(2, j, m_prg.m_units.begin(), params);

				CALL_PARAM lhs = params.front();
				CALL_PARAM rhs = params.back();

				// Don't store values if the left hand side is something
				// esoteric like a function or another assignment.
				if (lhs.first != lhs.second) continue;

				if ((rhs.first != rhs.second) || (rhs.first->udt & UDT_FUNC))
				{
					// If this value is already in the constant pool, we need
					// to purge it.
					pool.erase(lhs.first->lit);
					continue;
				}

				// Add an entry to the pool.
				pool.insert(std::pair<STRING, MACHINE_UNIT>(
					lhs.first->lit, *rhs.first
				));
			}
			else if ((i->func == CProgram::conditional)
					| (i->func == CProgram::elseIf)
					| (i->func == CProgram::whileLoop)
					| (i->func == CProgram::untilLoop)
					| (i->func == CProgram::forLoop)
					| (i->func == CProgram::skipMethod))
			{
				// Clear the pool (!)
				pool.clear();
			}
		}
		else if (i->udt & UDT_ID)
		{
			// Look ahead to make sure this isn't the left-hand-side
			// of an assignment.

			bool bFailed = false;
			for (POS j = i; j != m_prg.m_units.end(); ++j)
			{
				if ((j->udt & UDT_FUNC) && (j->func == operators::assign))
				{
					POS k = j - 1;
					std::deque<CALL_PARAM> params;
					getCallSite(2, k, m_prg.m_units.begin(), params);

					if (params[0].first == i)
					{
						bFailed = true;
						break;
					}
				}
				else if (j->udt & UDT_LINE) break;
			}

			if (bFailed) continue;

			// This is a referece to a constant - but is this constant in the pool?
			std::map<STRING, MACHINE_UNIT>::iterator k = pool.find(i->lit);
			if (k != pool.end())
			{
				*i = k->second;
			}
		}
	}
}

#endif

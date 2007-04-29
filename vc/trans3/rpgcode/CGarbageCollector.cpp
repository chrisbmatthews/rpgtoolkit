/*
 ********************************************************************
 * The RPG Toolkit, Version 3
 * This file copyright (C) 2007  Colin James Fitzpatrick
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

/**
 * A naive garbage collector.
 */

#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <process.h>
#include "CGarbageCollector.h"
#include "CProgram.h"

/**
 * Singleton instance of the garbage collector.
 */
CGarbageCollector CGarbageCollector::m_instance;

/**
 * Stub for threads.
 */
DWORD WINAPI threadStub(void *p)
{
	CGarbageCollector *const pCollector = (CGarbageCollector *)p;
	const LPCRITICAL_SECTION mutex = &pCollector->m_mutex;

	while (true)
	{
		// Sleep between each collection of garbage.
		DWORD t = GetTickCount();
		while ((GetTickCount() - t) < GARBAGE_CYCLE)
		{
			if (!pCollector->m_bRunning)
			{
				ExitThread(0);
				return 0;
			}
		}

		EnterCriticalSection(mutex);

		//t = GetTickCount();

		/**
		 * Collect garbage whilst everything else is paused - this
		 * must be fast or it will be an obvious delay!
		 */
		pCollector->collectGarbage();

		/**t = GetTickCount() - t;
		char str[255];
		itoa(t, str, 10);
		MessageBox(NULL, str, NULL, 0);**/

		LeaveCriticalSection(mutex);
	}

	return 0;
}

/**
 * Collect garbage.
 */
void CGarbageCollector::collectGarbage()
{
	if (CProgram::m_objects.size() == 0)
	{
		// No objects exist!
		return;
	}
	const unsigned int count = (--CProgram::m_objects.end())->first;
	std::vector<bool> objects;

	/**
	 * This will cause the vector to have potentially many unused
	 * elements, but this is the only way of doing this that is not
	 * ridiculously slow.
	 */
	objects.resize(count + 1, true);

	// Loop over all globals.
	{
		HEAP_ENUM::ITR i = CProgram::m_heap.begin();
		for (; i != CProgram::m_heap.end(); ++i)
		{
			const CPtrData<tagStackFrame> &var = i->second;
			if (var->udt & UDT_OBJ)
			{
				objects[(unsigned int)var->num] = false;
			}
		}
	}

	// Loop over all locals.
	{
		// For each program.
		std::set<CProgram *>::iterator i = m_programs.begin();
		for (; i != m_programs.end(); ++i)
		{
			// Loop over the stack.
			{
				STACK_ITR j = (*i)->m_stack.begin();
				for (; j != (*i)->m_stack.end(); ++j)
				{
					// Loop over this frame of the stack.
					std::deque<STACK_FRAME>::const_iterator k = j->begin();
					for (; k != j->end(); ++k)
					{
						const STACK_FRAME &var = *k;
						if (var.udt & UDT_OBJ)
						{
							objects[(unsigned int)var.num] = false;
						}
					}
				}
			}

			// Loop over the locals
			{
				std::list<std::map<STRING, STACK_FRAME> >::iterator j = (*i)->m_locals.begin();
				for (; j != (*i)->m_locals.end(); ++j)
				{
					// For each variable in the stack.
					std::map<STRING, STACK_FRAME>::const_iterator k = j->begin();
					for (; k != j->end(); ++k)
					{
						const STACK_FRAME &var = k->second;
						if (var.udt & UDT_OBJ)
						{
							objects[(unsigned int)var.num] = false;
						}
					}
				}
			}
		}
	}

	/**
	 * Free any objects that we've proved to be unreachable.
	 *
	 * Because of how object data is stored, we have to look through
	 * the whole heap for variables of the form x:var where x is
	 * the identifier of the object to be freed.
	 */
	std::map<STRING, CPtrData<STACK_FRAME> >::iterator i = CProgram::m_heap.begin();
	for (; i != CProgram::m_heap.end(); ++i)
	{
		const STRING &name = i->first;
		int pos = name.find(_T(':'));
		if (pos == -1) continue;

		const unsigned int obj = atoi(name.substr(0, pos + 1).c_str());
		if (objects[obj])
		{
			i = CProgram::m_heap.erase(i);
		}
	}

}

/**
 * Initialise the garbage collector.
 */
CGarbageCollector::CGarbageCollector()
{
	m_bRunning = true;
	InitializeCriticalSection(&m_mutex);
	DWORD id;
	if (!(m_garbageThread = CreateThread(NULL, 0, threadStub, this, 0, &id)))
	{
		MessageBox(NULL, _T("Could not create a thread for the garbage collector."), NULL, 0);
	}
}

/**
 * Shut down the garbage collector.
 */
CGarbageCollector::~CGarbageCollector()
{
	// End the garbage collector's thread.
	m_bRunning = false;

	EnterCriticalSection(&m_mutex);
	LeaveCriticalSection(&m_mutex);

	DWORD code;
	do
	{
		if (!GetExitCodeThread(m_garbageThread, &code)) break;
	} while (code == STILL_ACTIVE);

	CloseHandle(m_garbageThread);
	DeleteCriticalSection(&m_mutex);
}

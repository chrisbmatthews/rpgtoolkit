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
 *
 * Creating a game EXE using the Make EXE feature creates a 
 * derivative version of trans3 that includes the game's files. 
 * Therefore the EXE must be licensed under the GPL. However, as a 
 * special exception, you are permitted to license EXEs made with 
 * this feature under whatever terms you like, so long as 
 * Corresponding Source, as defined in the GPL, of the version 
 * of trans3 used to make the EXE is available separately under 
 * terms compatible with the Licence of this software and that you 
 * do not charge, aside from any price of the game EXE, to obtain 
 * these components.
 * 
 * If you publish a modified version of this Program, you may delete
 * these exceptions from its distribution terms, or you may choose
 * to propagate them.
 */

/*
 * RPGCode garbage collector.
 *
 * This is a just a naive implementation of a garbage collector that
 * runs in its own thread. At regular intervals, it suspends the main
 * program thread (there is assumed to be only one) and checks if there
 * are any objects that are not referenced by any variable. If there are,
 * they are freed. Their deconstructors are not called, though, since
 * there is no easy way to tell where that code even is. So, if a class's
 * deconstructor actually needs to be run, it should be run manually.
 */

#ifndef _GARBAGE_COLLECTOR_H_
#define _GARBAGE_COLLECTOR_H_

#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <set>

/**
 * Number of milliseconds between each garbage collection cycle.
 * This is really quite fast (30-100 milliseconds), so I've got it
 * at ten minutes for now. If this drops the FPS, post about it
 * and we will change it (maybe tied to FPS). It is important, though
 * that is run even when programs are not running, or else programs
 * might all be short enough to fit between cycles.
 */
#define GARBAGE_CYCLE	600000

class CProgram;

/**
 * The garbage collector is implemented as a singleton. To obtain the
 * instance, call CGarbageCollector::getInstance().
 */
class CGarbageCollector
{
public:

	/**
	 * Initialise the garbage collector.
	 */
	CGarbageCollector();

	/**
	 * Shut down the garbage collector.
	 */
	~CGarbageCollector();

	/**
	 * Return the unique instance of the garbage collector.
	 */
	static CGarbageCollector &getInstance() { return m_instance; }

	/**
	 * Cause garbage to be collected right now.
	 */
	void collectGarbage();

	/**
	 * Add a program to the set.
	 */
	void addProgram(CProgram *p) { m_programs.insert(p); }

	/**
	 * Remove a program from the set.
	 */
	void removeProgram(CProgram *p) { m_programs.erase(p); }

	/**
	 * Get the mutex used for garbage collection.
	 */
	LPCRITICAL_SECTION getMutex() { return &m_mutex; }

private:

	/**
	 * The location where execution of threads begins.
	 */
	friend DWORD WINAPI threadStub(void *p);

	/**
	 * The set of programs that this instance is responsible for.
	 */
	std::set<CProgram *> m_programs;

	/**
	 * The handle of the thread the garbage collector is running in.
	 */
	HANDLE m_garbageThread;

	/**
	 * The critical section for garbage collection.
	 */
	CRITICAL_SECTION m_mutex;

	/**
	 * A flag indicating whether the garbage thread is running.
	 */
	volatile bool m_bRunning;

	/**
	 * The unique instance of the garbage collector.
	 */
	static CGarbageCollector m_instance;
};

#endif



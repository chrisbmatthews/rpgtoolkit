/*
 * All contents copyright 2003, 2004, 2005 Christopher Matthews or Contributors.
 * Various port optimizations copyright by Colin James Fitzpatrick, 2005.
 * All rights reserved. You may not remove this notice
 * Read license.txt for licensing details.
 */

#ifndef _SPCMOVE_H_
#define _SPCMOVE_H_

#include "../../tkCommon/strings.h"

// A special move.
typedef struct tagSpcMove
{
	STRING name;
	int fp;
	int smp;
	STRING prg;
	int targSmp;
	char battle, menu;
	STRING status;
	STRING animation;
	STRING description;

	bool open(const STRING strFile);
} SPCMOVE, *LPSPCMOVE;

#endif

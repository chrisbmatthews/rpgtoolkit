/*
 ********************************************************************
 * The RPG Toolkit, Version 3
 * This file copyright (C) 2006  Christopher Matthews & contributors
 *
 * Contributors:
 *    - Colin James Fitzpatrick
 *    - Jonathan D. Hughes
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

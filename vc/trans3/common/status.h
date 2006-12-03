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

#ifndef _STATUS_EFFECT_H_
#define _STATUS_EFFECT_H_

#include "../../tkCommon/strings.h"

// Amount fast and slow statuses alter speed.
#define SPEED_MODIFIER 2

typedef struct tagStatusEffect
{
	STRING name;
	short rounds;
	short speed;
	short slow;
	short disable;
	short hp, hpAmount;
	short smp, smpAmount;
	short code;
	STRING prg;
	void open(const STRING strFile);
} STATUS_EFFECT, *LPSTATUS_EFFECT;

#endif

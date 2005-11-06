/*
 * All contents copyright 2003, 2004, 2005 Christopher Matthews or Contributors.
 * Various port optimizations copyright by Colin James Fitzpatrick, 2005.
 * All rights reserved. You may not remove this notice
 * Read license.txt for licensing details.
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

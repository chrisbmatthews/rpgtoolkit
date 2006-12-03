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

#ifndef _IFIGHTER_H_
#define _IFIGHTER_H_

#include "../../tkCommon/strings.h"

// An entity capable of fighting.
/////////////////////////////////////////////////
class IFighter
{
public:
	virtual void health(const int val) = 0;
	virtual int health() const = 0;

	virtual void maxHealth(const int val) = 0;
	virtual int maxHealth() const = 0;

	virtual void defence(const int val) = 0;
	virtual int defence() const = 0;

	virtual void fight(const int val) = 0;
	virtual int fight() const = 0;

	virtual void smp(const int val) = 0;
	virtual int smp() const = 0;

	virtual void maxSmp(const int val) = 0;
	virtual int maxSmp() const = 0;

	virtual void name(const STRING str) = 0;
	virtual STRING name() const = 0;

	virtual STRING getStanceAnimation(const STRING anim) = 0;
};

#endif

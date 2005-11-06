/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
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

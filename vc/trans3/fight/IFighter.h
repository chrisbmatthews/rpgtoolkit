/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

#ifndef _IFIGHTER_H_
#define _IFIGHTER_H_

#include <string>

// An entity capable of fighting.
/////////////////////////////////////////////////
class IFighter
{
public:
	virtual void health(const int val) = 0;
	virtual int health(void) = 0;
	//
	virtual void maxHealth(const int val) = 0;
	virtual int maxHealth(void) = 0;
	//
	virtual void defence(const int val) = 0;
	virtual int defence(void) = 0;
	//
	virtual void fight(const int val) = 0;
	virtual int fight(void) = 0;
	//
	virtual void smp(const int val) = 0;
	virtual int smp(void) = 0;
	//
	virtual void maxSmp(const int val) = 0;
	virtual int maxSmp(void) = 0;
	//
	virtual void name(const std::string str) = 0;
	virtual std::string name(void) = 0;
	//
	virtual std::string getStanceAnimation(const std::string anim) = 0;
};

#endif

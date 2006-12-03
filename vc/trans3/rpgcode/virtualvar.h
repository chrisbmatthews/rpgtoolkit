/*
 ********************************************************************
 * The RPG Toolkit, Version 3
 * This file copyright (C) 2006  Colin Fitzpatrick
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

#ifndef _VIRTUAL_VAR_H_
#define _VIRTUAL_VAR_H_

#include "../../tkCommon/strings.h"

/*
 * Create a virtual numerical variable.
 */
void setVirtualNum(const STRING name, double *pNum);

/*
 * Create a virtual literal variable.
 */
void setVirtualLit(const STRING name, STRING *pNum);

/*
 * Create the initial virtual variables.
 */
void initVirtualVars();

#endif

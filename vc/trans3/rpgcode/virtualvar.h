/*
 * All contents copyright 2006, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
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

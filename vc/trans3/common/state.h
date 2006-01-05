/*
 * All contents copyright 2003, 2004, 2005 Christopher Matthews or Contributors.
 * Various port optimizations copyright by Colin James Fitzpatrick, 2005.
 * All rights reserved. You may not remove this notice
 * Read license.txt for licensing details.
 */

#ifndef _SAVE_STATE_H_
#define _SAVE_STATE_H_

#include "../../tkCommon/strings.h"

void loadSaveState(const STRING file);
void saveSaveState(const STRING file);

#endif

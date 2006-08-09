/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

#ifndef _MESSAGE_BOX_H_
#define _MESSAGE_BOX_H_

#include "../../tkCommon/strings.h"

// Show a message box.
void messageBox(const STRING str);

// Prompt for a response.
STRING prompt(const STRING question);

// Rpgcode message box.
int rpgcodeMsgBox(STRING text, int buttons, const long textColor, const long backColor, const STRING image);

// Custom file dialog.
STRING fileDialog(
	const STRING path, 
	const STRING filter,
	const STRING title,
	const bool allowNewFile,
	const long textColor,
	const long backColor,
	const STRING image
);

#endif

/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

#include "stdafx.h"
#include "../trans3.h"
#include "Callbacks.h"

STDMETHODIMP CCallbacks::test(void)
{
	MessageBox(NULL, "test", NULL, 0);
	return S_OK;
}

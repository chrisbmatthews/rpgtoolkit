/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

/*
 * Inclusions.
 */
#include "paths.h"
#include "CFile.h"
#include "../../tkzip/tkzip.h"

/*
 * Globals.
 */
STRING g_projectPath;
STRING g_savePath = _T("Saved\\");	// May be altered for pack files.
STRING g_pakTempPath;				// Temp path for the pak file.
STRING g_pakFile;					// The file name of the pak file.

// Resolve a file name
STRING resolvePakFile(const STRING path)
{
	const STRING file = g_pakTempPath + path;
	if (!CFile::fileExists(file))
	{
		// Extract the file from the pak file or this executable.
		// (Assume the zip is open!)

		ZIPExtract(const_cast<char *>(path.c_str()), const_cast<char *>(file.c_str()));
	}
	return file;
}

// Don't resolve a file name.
STRING resolveNonPakFile(const STRING path)
{
	return path;
}

STRING (*resolve)(const STRING path) = NULL;

void setResolve(const bool bPak)
{
	resolve = bPak ? resolvePakFile : resolveNonPakFile;
}

/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

#ifndef _CFILE_H_
#define _CFILE_H_

/*
 * Inclusions.
 */
#include <string>
#define WIN32_LEAN_AND_MEAN
#include <windows.h>

class CFile
{

public:
	CFile(CONST std::string fileName, CONST UINT mode = OF_READ);
	//
	// Write.
	//
	CFile &operator<<(CONST CHAR data);
	CFile &operator<<(CONST SHORT data);
	CFile &operator<<(CONST INT data);
	CFile &operator<<(CONST double data);
	CFile &operator<<(CONST std::string data);
	//
	// Read.
	//
	CFile &operator>>(CHAR &data);
	CFile &operator>>(SHORT &data);
	CFile &operator>>(INT &data);
	CFile &operator>>(double &data);
	CFile &operator>>(std::string &data);
	std::string line(VOID);
	//
	// Misc.
	//
	VOID seek(CONST INT pos) { m_ptr.Offset = pos; }
	BOOL isEof(VOID) CONST { return m_bEof; }
	BOOL isOpen(VOID) CONST { return (m_hFile != HFILE_ERROR); }
	static BOOL fileExists(CONST std::string file) { return CFile(file).isOpen(); }
	~CFile(VOID);

private:
	HFILE m_hFile;
	OVERLAPPED m_ptr;
	BOOL m_bEof;

};

#endif

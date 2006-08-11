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
#include "../../tkCommon/strings.h"
#define WIN32_LEAN_AND_MEAN
#include <windows.h>

class CFile
{

public:
	CFile(): m_hFile(HFILE_ERROR) { }
	void open(const STRING fileName, CONST UINT mode = OF_READ);
	CFile(CONST STRING fileName, CONST UINT mode = OF_READ);
	//
	// Write.
	//
	CFile &operator<<(CONST BYTE data);
	CFile &operator<<(CONST CHAR data);
	CFile &operator<<(CONST SHORT data);
	CFile &operator<<(CONST INT data);
	CFile &operator<<(CONST UINT data);
	CFile &operator<<(CONST double data);
	CFile &operator<<(CONST STRING data);
	//
	// Read.
	//
	CFile &operator>>(BYTE &data);
	CFile &operator>>(CHAR &data);
	CFile &operator>>(SHORT &data);
	CFile &operator>>(INT &data);
	CFile &operator>>(UINT &data);
	CFile &operator>>(double &data);
	CFile &operator>>(STRING &data);
	STRING line(VOID);
	//
	// Misc.
	//
	VOID seek(CONST INT pos) { m_ptr.Offset = pos; }
	BOOL isEof(VOID) CONST { return m_bEof; }
	BOOL isOpen(VOID) CONST { return (m_hFile != HFILE_ERROR); }
	DWORD size(VOID) CONST { return GetFileSize(HANDLE(m_hFile), NULL); }
	static BOOL fileExists(CONST STRING file) { return CFile(file).isOpen(); }
	~CFile(VOID);

private:
	HFILE m_hFile;
	OVERLAPPED m_ptr;
	BOOL m_bEof;

};

#endif

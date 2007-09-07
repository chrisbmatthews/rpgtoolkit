/*
 ********************************************************************
 * The RPG Toolkit, Version 3
 * This file copyright (C) 2006  Colin James Fitzpatrick
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
 *
 * Creating a game EXE using the Make EXE feature creates a 
 * derivative version of trans3 that includes the game's files. 
 * Therefore the EXE must be licensed under the GPL. However, as a 
 * special exception, you are permitted to license EXEs made with 
 * this feature under whatever terms you like, so long as 
 * Corresponding Source, as defined in the GPL, of the version 
 * of trans3 used to make the EXE is available separately under 
 * terms compatible with the Licence of this software and that you 
 * do not charge, aside from any price of the game EXE, to obtain 
 * these components.
 * 
 * If you publish a modified version of this Program, you may delete
 * these exceptions from its distribution terms, or you may choose
 * to propagate them.
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
	BOOL isEof(VOID) CONST { return m_ptr.Offset >= size(); }
	BOOL isOpen(VOID) CONST { return (m_hFile != HFILE_ERROR); }
	DWORD size(VOID) CONST { return GetFileSize(HANDLE(m_hFile), NULL); }
	static BOOL fileExists(CONST STRING file) { return CFile(file).isOpen(); }
	~CFile(VOID);

private:
	HFILE m_hFile;
	OVERLAPPED m_ptr;

};

#endif

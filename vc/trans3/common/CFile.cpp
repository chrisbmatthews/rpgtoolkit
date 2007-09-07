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

/*
 * Inclusions.
 */
#include "CFile.h"
#include "paths.h"

/*
 * Constructor.
 *
 * fileName (in) - file to open
 */
CFile::CFile(CONST STRING fileName, CONST UINT mode)
{
	OFSTRUCT ofs;
	m_hFile = OpenFile(resolve(fileName.c_str()).c_str(), &ofs, mode);
	memset(&m_ptr, 0, sizeof(m_ptr));
}

void CFile::open(const STRING fileName, CONST UINT mode)
{
	if (m_hFile != HFILE_ERROR)
	{
		CloseHandle(HANDLE(m_hFile));
	}
	OFSTRUCT ofs;
	m_hFile = OpenFile(resolve(fileName.c_str()).c_str(), &ofs, mode);
	memset(&m_ptr, 0, sizeof(m_ptr));
}

/*
 * Stream read operator.
 *
 * data (in) - source
 */
CFile &CFile::operator<<(CONST BYTE data)
{
	DWORD write = 0;
	WriteFile(HANDLE(m_hFile), &data, sizeof(data), &write, &m_ptr);
	m_ptr.Offset += sizeof(data);
	return *this;
}
CFile &CFile::operator<<(CONST CHAR data)
{
	DWORD write = 0;
	WriteFile(HANDLE(m_hFile), &data, sizeof(data), &write, &m_ptr);
	m_ptr.Offset += sizeof(data);
	return *this;
}
CFile &CFile::operator<<(CONST SHORT data)
{
	DWORD write = 0;
	WriteFile(HANDLE(m_hFile), &data, sizeof(data), &write, &m_ptr);
	m_ptr.Offset += sizeof(data);
	return *this;
}
CFile &CFile::operator<<(CONST INT data)
{
	DWORD write = 0;
	WriteFile(HANDLE(m_hFile), &data, sizeof(data), &write, &m_ptr);
	m_ptr.Offset += sizeof(data);
	return *this;
}
CFile &CFile::operator<<(CONST UINT data)
{
	DWORD write = 0;
	WriteFile(HANDLE(m_hFile), &data, sizeof(data), &write, &m_ptr);
	m_ptr.Offset += sizeof(data);
	return *this;
}
CFile &CFile::operator<<(CONST double data)
{
	DWORD write = 0;
	WriteFile(HANDLE(m_hFile), &data, sizeof(data), &write, &m_ptr);
	m_ptr.Offset += sizeof(data);
	return *this;
}
CFile &CFile::operator<<(CONST STRING data)
{
	DWORD write = 0;
	CONST INT len = data.length() + 1;
	WriteFile(HANDLE(m_hFile), getAsciiString(data).c_str(), len, &write, &m_ptr);
	m_ptr.Offset += len;
	return *this;
}

/*
 * Stream write operator.
 *
 * data (out) - destination
 */
CFile &CFile::operator>>(BYTE &data)
{
	DWORD read = 0;
	!ReadFile(HANDLE(m_hFile), &data, sizeof(data), &read, &m_ptr);
	m_ptr.Offset += sizeof(data);
	return *this;
}
CFile &CFile::operator>>(CHAR &data)
{
	DWORD read = 0;
	!ReadFile(HANDLE(m_hFile), &data, sizeof(data), &read, &m_ptr);
	m_ptr.Offset += sizeof(data);
	return *this;
}
CFile &CFile::operator>>(SHORT &data)
{
	DWORD read = 0;
	!ReadFile(HANDLE(m_hFile), &data, sizeof(data), &read, &m_ptr);
	m_ptr.Offset += sizeof(data);
	return *this;
}
CFile &CFile::operator>>(INT &data)
{
	DWORD read = 0;
	!ReadFile(HANDLE(m_hFile), &data, sizeof(data), &read, &m_ptr);
	m_ptr.Offset += sizeof(data);
	return *this;
}
CFile &CFile::operator>>(UINT &data)
{
	DWORD read = 0;
	!ReadFile(HANDLE(m_hFile), &data, sizeof(data), &read, &m_ptr);
	m_ptr.Offset += sizeof(data);
	return *this;
}
CFile &CFile::operator>>(double &data)
{
	DWORD read = 0;
	!ReadFile(HANDLE(m_hFile), &data, sizeof(data), &read, &m_ptr);
	m_ptr.Offset += sizeof(data);
	return *this;
}
CFile &CFile::operator>>(STRING &data)
{
	std::string toRet;
	while (TRUE)
	{
		CHAR chr;
		DWORD read;
		if (!ReadFile(HANDLE(m_hFile), &chr, sizeof(chr), &read, &m_ptr))
		{
			toRet = "";
			break;
		}
		m_ptr.Offset++;
		if (chr == '\0')
		{
			break;
		}
		else
		{
			toRet += chr;
		}
	}
#ifdef _UNICODE
	data = getUnicodeString(toRet);
#else
	data = toRet;
#endif
	return *this;
}

/*
 * Read a line.
 *
 * return (out) - the line
 */
STRING CFile::line()
{
	std::string toRet;
	while (TRUE)
	{
		char chr;
		DWORD read;
		if (!ReadFile(HANDLE(m_hFile), &chr, sizeof(chr), &read, &m_ptr))
		{
			break;
		}
		m_ptr.Offset++;
		if (chr == '\n')
		{
			break;
		}
		else
		{
			toRet += chr;
		}
	}
	CONST UINT len = toRet.length() - 1;
	if (toRet[len] == '\r') toRet[len] = '\0';
#ifndef _UNICODE
	return toRet;
#else
	return getUnicodeString(toRet);
#endif
}

/*
 * Deconstructor.
 */
CFile::~CFile()
{
	CloseHandle(HANDLE(m_hFile));
}

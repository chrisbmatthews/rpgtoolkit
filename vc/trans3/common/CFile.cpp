/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

/*
 * Inclusions.
 */
#include "CFile.h"

/*
 * Constructor.
 *
 * fileName (in) - file to open
 */
CFile::CFile(CONST STRING fileName, CONST UINT mode)
{
	OFSTRUCT ofs;
	m_hFile = OpenFile(fileName.c_str(), &ofs, mode);
	memset(&m_ptr, 0, sizeof(m_ptr));
	m_bEof = FALSE;
}

void CFile::open(const STRING fileName, CONST UINT mode)
{
	if (m_hFile != HFILE_ERROR)
	{
		CloseHandle(HANDLE(m_hFile));
	}
	OFSTRUCT ofs;
	m_hFile = OpenFile(fileName.c_str(), &ofs, mode);
	memset(&m_ptr, 0, sizeof(m_ptr));
	m_bEof = FALSE;
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
	m_bEof = ReadFile(HANDLE(m_hFile), &data, sizeof(data), &read, &m_ptr);
	m_ptr.Offset += sizeof(data);
	return *this;
}
CFile &CFile::operator>>(CHAR &data)
{
	DWORD read = 0;
	m_bEof = ReadFile(HANDLE(m_hFile), &data, sizeof(data), &read, &m_ptr);
	m_ptr.Offset += sizeof(data);
	return *this;
}
CFile &CFile::operator>>(SHORT &data)
{
	DWORD read = 0;
	m_bEof = ReadFile(HANDLE(m_hFile), &data, sizeof(data), &read, &m_ptr);
	m_ptr.Offset += sizeof(data);
	return *this;
}
CFile &CFile::operator>>(INT &data)
{
	DWORD read = 0;
	m_bEof = ReadFile(HANDLE(m_hFile), &data, sizeof(data), &read, &m_ptr);
	m_ptr.Offset += sizeof(data);
	return *this;
}
CFile &CFile::operator>>(double &data)
{
	DWORD read = 0;
	m_bEof = ReadFile(HANDLE(m_hFile), &data, sizeof(data), &read, &m_ptr);
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
		if (!(m_bEof = ReadFile(HANDLE(m_hFile), &chr, sizeof(chr), &read, &m_ptr)))
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
		if (!(m_bEof = ReadFile(HANDLE(m_hFile), &chr, sizeof(chr), &read, &m_ptr)))
		{
			return "";
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

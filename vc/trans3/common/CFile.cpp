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
CFile::CFile(CONST std::string fileName, CONST UINT mode)
{
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
CFile &CFile::operator<<(CONST std::string data)
{
	DWORD write = 0;
	CONST INT len = data.length() + 1;
	WriteFile(HANDLE(m_hFile), data.c_str(), len, &write, &m_ptr);
	m_ptr.Offset += len;
	return *this;
}

/*
 * Stream write operator.
 *
 * data (out) - destination
 */
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
CFile &CFile::operator>>(std::string &data)
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
	data = toRet;
	return *this;
}

/*
 * Read a line.
 *
 * return (out) - the line
 */
std::string CFile::line(void)
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
	return toRet;
}

/*
 * Deconstructor.
 */
CFile::~CFile(VOID)
{
	CloseHandle(HANDLE(m_hFile));
}

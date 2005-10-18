/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

/*
 * Protect the header.
 */
#ifndef _CVARIANT_H_
#define _CVARIANT_H_

/*
 * Inclusions.
 */
#include "../../tkCommon/strings.h"

/*
 * A value of varying type.
 */
class CVariant
{
public:
	/*
	 * The data type of a value.
	 */
	typedef enum tagDataType
	{
		DT_NULL,	// Unset
		DT_NUM,		// Numerical (including floating points)
		DT_LIT		// Literal (i.e., a string)
	} DATA_TYPE;
	/*
	 * Default construct--initialize the object.
	 */
	CVariant()
	{
		m_pData = NULL;
		m_type = DT_NULL;
	}
	/*
	 * Construct this object from another variant
	 * value--performs a deep copy.
	 */
	CVariant(const CVariant &rhs)
	{
		m_pData = NULL;
		m_type = DT_NULL;
		*this = rhs;
	}
	/*
	 * Construct with initial values.
	 */
	CVariant(const double rhs)
	{
		m_pData = new double(rhs);
		m_type = DT_NUM;
	}
	CVariant(const STRING rhs)
	{
		m_pData = new STRING(rhs);
		m_type = DT_LIT;
	}
	/*
	 * Assignment operator.
	 */
	CVariant &operator=(const CVariant &rhs)
	{
			freeData();
			m_type = rhs.m_type;
		switch (m_type)
		{
			case DT_NUM:
				m_pData = new double(*(double *)rhs.m_pData);
				break;
			case DT_LIT:
				m_pData = new STRING(*(STRING *)rhs.m_pData);
				break;
		}
		return *this;
	}
	CVariant &operator=(const double rhs)
	{
		freeData();
		m_pData = new double(rhs);
		m_type = DT_NUM;
		return *this;
	}
	CVariant &operator=(const STRING rhs)
	{
		freeData();
		m_pData = new STRING(rhs);
		m_type = DT_LIT;
		return *this;
	}
	/*
	 * Logical addition.
	 */
	CVariant operator+(const double rhs) const
	{
		switch (m_type)
		{
			case DT_NUM:
				return ((*(double *)m_pData) + rhs);
			case DT_LIT:
				STRINGSTREAM ss;
				ss << rhs;
				return ((*(STRING *)m_pData) + ss.str());
		}
		return CVariant();
	}
	CVariant operator+(const STRING rhs) const
	{
		switch (m_type)
		{
			case DT_NUM:
			{
				char conv[255];
				gcvt(*(double *)m_pData, 255, conv);
#ifndef _UNICODE
				return (conv + rhs);
#else
				return (getUnicodeString(std::string(conv)) + rhs);
#endif
			}
			case DT_LIT:
				return ((*(STRING *)m_pData) + rhs);
		}
		return CVariant();
	}
	/*
	 * Getters.
	 */
	double getNum() const
	{
		if (m_type == DT_NUM)
		{
			return *(double *)m_pData;
		}
		else if (m_type == DT_LIT)
		{
			return atof(getAsciiString(*(STRING *)m_pData).c_str());
		}
		return 0.0;
	}
	STRING getLit() const
	{
		if (m_type == DT_LIT)
		{
			return *(STRING *)m_pData;
		}
		else if (m_type == DT_NUM)
		{
			char conv[255];
			gcvt(*(double *)m_pData, 255, conv);
			char &chr = conv[strlen(conv) - 1];
			if (chr == _T('.'))
			{
				chr = _T('\0');
			}
#ifndef _UNICODE
			return conv;
#else
			return getUnicodeString(std::string(conv));
#endif
		}
		return _T("");
	}
	DATA_TYPE getType() const
	{
		return m_type;
	}
	/*
	 * Deconstructor.
	 */
	~CVariant()
	{
		freeData();
	}
	/*
	 * Free the current data.
	 */
	void freeData()
	{
		if (m_type == DT_NUM) delete ((double *)m_pData);
		else if (m_type == DT_LIT) delete ((STRING *)m_pData);
		m_pData = NULL;
	}
private:
	/*
	 * The actual data is referenced by a void
	 * void pointer. Cast this pointer to the
	 * type indicated by the _T('m_type') member to
	 * use it.
	 */
	void *m_pData;
	/*
	 * The type of the data.
	 */
	DATA_TYPE m_type;
};

#endif

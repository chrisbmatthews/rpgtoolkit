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
#include <string>
#include <sstream>

/*
 * A value of varying type.
 */
class CVariant
{
public:
	/*
	 * An object that can be stored as DT_OBJ.
	 */
	class CObject
	{
	public:
		virtual double getNum(void) = 0;
		virtual std::string getLit(void) = 0;
	};
	/*
	 * The data type of a value.
	 */
	enum DATA_TYPE
	{
		DT_NULL,	// Unset
		DT_NUM,		// Numerical (including floating points)
		DT_LIT,		// Literal (i.e., a string)
		DT_OBJ		// Object (instance of a class)
	};
	/*
	 * Default construct--initialize the object.
	 */
	CVariant(void)
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
	CVariant(const std::string rhs)
	{
		m_pData = new std::string(rhs);
		m_type = DT_LIT;
	}
	CVariant(CObject *rhs)
	{
		m_pData = new CObject*(rhs);
		m_type = DT_OBJ;
	}
	/*
	 * Assignment operator.
	 */
	CVariant &operator=(const CVariant &rhs)
	{
		freeData();
		switch (m_type = rhs.m_type)
		{
			case DT_NUM:
				m_pData = new double(*(double *)rhs.m_pData);
				break;
			case DT_LIT:
				m_pData = new std::string(*(std::string *)rhs.m_pData);
				break;
			case DT_OBJ:
				m_pData = rhs.m_pData;
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
	CVariant &operator=(const std::string rhs)
	{
		freeData();
		m_pData = new std::string(rhs);
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
				std::stringstream ss;
				ss << rhs;
				return ((*(std::string *)m_pData) + ss.str());
		}
		return CVariant();
	}
	CVariant operator+(const std::string rhs) const
	{
		switch (m_type)
		{
			case DT_NUM:
			{
				std::stringstream ss;
				ss << *(double *)m_pData;
				return (ss.str() + rhs);
			}
			case DT_LIT:
				return ((*(std::string *)m_pData) + rhs);
		}
		return CVariant();
	}
	/*
	 * Getters.
	 */
	double getNum(void) const
	{
		if (m_type == DT_NUM)
		{
			return *(double *)m_pData;
		}
		else if (m_type == DT_LIT)
		{
			return atof((*(std::string *)m_pData).c_str());
		}
		else if (m_type == DT_OBJ)
		{
			// if (m_pData) return (*(CObject **)m_pData)->getNum();
		}
		return 0.0;
	}
	std::string getLit(void) const
	{
		if (m_type == DT_LIT)
		{
			return *(std::string *)m_pData;
		}
		else if (m_type == DT_NUM)
		{
			std::stringstream ss;
			ss << *(double *)m_pData;
			return ss.str();
		}
		else if (m_type == DT_OBJ)
		{
			// if (m_pData) return (*(CObject **)m_pData)->getLit();
		}
		return "";
	}
	const CObject *getObject(void) const
	{
		if (m_type == DT_OBJ)
		{
			if (m_pData) return (*(CObject **)m_pData);
		}
		return NULL;
	}
	DATA_TYPE getType(void) const { return m_type; }
	/*
	 * Deconstructor.
	 */
	~CVariant(void)
	{
		freeData();
	}
	/*
	 * Free the current data.
	 */
	void freeData(void)
	{
		if (m_type == DT_NUM) delete ((double *)m_pData);
		else if (m_type == DT_LIT) delete ((std::string *)m_pData);
		else if (m_type == DT_OBJ) delete ((CObject **)m_pData);
		m_pData = NULL;
	}
private:
	/*
	 * The actual data is referenced by a void
	 * void pointer. Cast this pointer to the
	 * type indicated by the 'm_type' member to
	 * use it.
	 */
	void *m_pData;
	/*
	 * The type of the data.
	 */
	DATA_TYPE m_type;
};

#endif

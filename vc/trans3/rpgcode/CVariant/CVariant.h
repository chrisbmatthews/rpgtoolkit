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
	 * The data type of a value.
	 */
	typedef enum tagDataType
	{
		DT_NULL,	// Unset
		DT_NUM,		// Numerical (including floating points)
		DT_LIT,		// Literal (i.e., a string)
		DT_OBJ		// Object
	} DATA_TYPE;
	/*
	 * An object that can be stored as DT_OBJ.
	 */
	class CObject
	{
	public:
		CObject(void)
		{
			m_refs = 0;
			m_bCopyObject = true;
		}
		void addRef(void) { m_refs++; }
		unsigned long release(void)
		{
			if (--m_refs == 0)
			{
				delete this;
				return 0;
			}
			return m_refs;
		}
		virtual double getNum(void)
		{
			return atof(getLit().c_str());
		}
		virtual std::string getLit(void)
		{
			std::stringstream ss;
			ss << getNum();
			return ss.str();
		}
		virtual DATA_TYPE getType(void) = 0;
		virtual ~CObject(void) { }
		virtual bool canSet(void) { return false; }
		virtual void set(const std::string str) { }
		virtual void set(const double num) { }
		void setCopyObject(const bool val) { m_bCopyObject = val; }
	private:
		unsigned long m_refs;
		bool m_bCopyObject;
		friend class CVariant;
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
		rhs->addRef();
		m_pData = rhs;
		m_type = DT_OBJ;
	}
	/*
	 * Assignment operator.
	 */
	CVariant &operator=(const CVariant &rhs)
	{
		if ((m_type == DT_OBJ) && ((CObject *)m_pData)->canSet())
		{
			if (rhs.m_type == DT_NUM) ((CObject *)m_pData)->set(rhs.getNum());
			else if (rhs.m_type == DT_LIT) ((CObject *)m_pData)->set(rhs.getLit());
		}
		else
		{
			freeData();
			m_type = rhs.m_type;
			if (m_type == DT_OBJ && !((CObject *)rhs.m_pData)->m_bCopyObject)
			{
				if ((m_type = ((CObject *)rhs.m_pData)->getType()) == DT_NUM)
				{
					m_pData = new double(((CObject *)rhs.m_pData)->getNum());
				}
				else
				{
					m_pData = new std::string(((CObject *)rhs.m_pData)->getLit());
				}
				// No objects returning objects...
			}
			else
			{
				switch (m_type)
				{
					case DT_NUM:
						m_pData = new double(*(double *)rhs.m_pData);
						break;
					case DT_LIT:
						m_pData = new std::string(*(std::string *)rhs.m_pData);
						break;
					case DT_OBJ:
						m_pData = rhs.m_pData;
						((CObject *)m_pData)->addRef();
						break;
				}
			}
		}
		return *this;
	}
	CVariant &operator=(const double rhs)
	{
		if ((m_type == DT_OBJ) && ((CObject *)m_pData)->canSet())
		{
			((CObject *)m_pData)->set(rhs);
		}
		else
		{
			freeData();
			m_pData = new double(rhs);
			m_type = DT_NUM;
		}
		return *this;
	}
	CVariant &operator=(const std::string rhs)
	{
		if ((m_type == DT_OBJ) && ((CObject *)m_pData)->canSet())
		{
			((CObject *)m_pData)->set(rhs);
		}
		else
		{
			freeData();
			m_pData = new std::string(rhs);
			m_type = DT_LIT;
		}
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
			if (m_pData) return ((CObject *)m_pData)->getNum();
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
			if (m_pData) return ((CObject *)m_pData)->getLit();
		}
		return "";
	}
	CObject *const getObject(void) const
	{
		if (m_type == DT_OBJ)
		{
			return (CObject *)m_pData;
		}
		return NULL;
	}
	DATA_TYPE getType(void) const
	{
		return ((m_type != DT_OBJ) ? m_type : ((CObject *)m_pData)->getType());
	}
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
		else if (m_type == DT_OBJ) ((CObject *)m_pData)->release();
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

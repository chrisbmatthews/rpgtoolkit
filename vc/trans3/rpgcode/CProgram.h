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
 */

/*
 * RPGCode parser and interpreter.
 */

#ifndef _CPROGRAM_H_
#define _CPROGRAM_H_

// Inclusions.
#include <map>
#include <set>
#include <list>
#include <deque>
#include <string>
#include <vector>
#include <tchar.h>
#include <iostream>

#ifndef STRING_DEFINED
typedef std::basic_string<TCHAR> STRING;
#define STRING_DEFINED
#endif

// Data types.
typedef enum tagUnitDataType
{
	UDT_UNSET = 1,		// Unset.
	UDT_NUM = 2,		// Number.
	UDT_LIT = 4,		// String literal.
	UDT_ID = 8,			// Identifier.
	UDT_FUNC = 16,		// Function call (including syntactic sugar).
	UDT_OPEN = 32,		// Opening brace.
	UDT_CLOSE = 64,		// Closing brace.
	UDT_LINE = 128,		// Final unit of a statement.
	UDT_OBJ = 256,		// An object.
	UDT_LABEL = 512,	// A label.
	UDT_PLUGIN = 1024	// A plugin call.
} UNIT_DATA_TYPE;

class CProgram;

// A frame on the stack.
typedef struct tagStackFrame
{
	double num;
	STRING lit;
	UNIT_DATA_TYPE udt;
	CProgram *prg;
	void *tag;

	bool getBool() const;
	tagStackFrame getValue() const;

	// Can be overridden for dynamic ("virtual") variables.
	virtual double getNum() const;
	virtual STRING getLit() const;
	virtual UNIT_DATA_TYPE getType() const;

	tagStackFrame():
		num(0.0),
		udt(UNIT_DATA_TYPE(UDT_NUM | UDT_UNSET)) { }
	tagStackFrame(CProgram *prg):
		prg(prg),
		num(0.0),
		udt(UNIT_DATA_TYPE(UDT_NUM | UDT_UNSET)) { }
} STACK_FRAME, *LPSTACK_FRAME;

// Data passed to a called function.
typedef struct tagCallData
{
	int params;
	LPSTACK_FRAME p;
	CProgram *prg;

	STACK_FRAME &operator[](const int i) { return *(p + i); }
	STACK_FRAME &ret() { return *(p + params); }
} CALL_DATA, *LPCALL_DATA;

// A map of references.
typedef std::pair<unsigned int, STRING> REFERENCE_DESC;
typedef std::pair<LPSTACK_FRAME, REFERENCE_DESC> REFERENCE;
typedef std::map<unsigned int, REFERENCE> REFERENCE_MAP;

// A call.
typedef struct tagCallFrame
{
	unsigned int i;				// Unit to which to return.
	unsigned int j;				// Closing brace of the method.
	STACK_FRAME *p;				// Return value.
	bool bReturn;				// Whether we should return a value.
	unsigned int obj;			// This pointer.
	REFERENCE_MAP refs;			// Parameters that have been passed ByRef.
	STRING errorHandler;		// Label to jump to in case of error.
	unsigned int errorReturn;	// Unit to return to after an error.
} CALL_FRAME;

// A callable function.
typedef void (*MACHINE_FUNC) (CALL_DATA &);

// A machine instruction unit.
typedef struct tagMachineUnit
{
	double num;
	STRING lit;
	UNIT_DATA_TYPE udt;
	MACHINE_FUNC func;
	int params;

	void show() const;
	void execute(CProgram *prg) const;
} MACHINE_UNIT, *LPMACHINE_UNIT;

// RPGCode operators.
namespace operators
{
	void add(CALL_DATA &call);
	void sub(CALL_DATA &call);
	void mul(CALL_DATA &call);
	void bor(CALL_DATA &call);
	void bxor(CALL_DATA &call);
	void band(CALL_DATA &call);
	void lor(CALL_DATA &call);
	void land(CALL_DATA &call);
	void ieq(CALL_DATA &call);
	void eq(CALL_DATA &call);
	void gte(CALL_DATA &call);
	void lte(CALL_DATA &call);
	void gt(CALL_DATA &call);
	void lt(CALL_DATA &call);
	void rs(CALL_DATA &call);
	void ls(CALL_DATA &call);
	void mod(CALL_DATA &call);
	void div(CALL_DATA &call);
	void pow(CALL_DATA &call);
	void assign(CALL_DATA &call);
	void xor_assign(CALL_DATA &call);
	void or_assign(CALL_DATA &call);
	void and_assign(CALL_DATA &call);
	void rs_assign(CALL_DATA &call);
	void ls_assign(CALL_DATA &call);
	void sub_assign(CALL_DATA &call);
	void add_assign(CALL_DATA &call);
	void mod_assign(CALL_DATA &call);
	void div_assign(CALL_DATA &call);
	void mul_assign(CALL_DATA &call);
	void pow_assign(CALL_DATA &call);
	void lor_assign(CALL_DATA &call);
	void land_assign(CALL_DATA &call);
	void prefixIncrement(CALL_DATA &call);
	void postfixIncrement(CALL_DATA &call);
	void prefixDecrement(CALL_DATA &call);
	void postfixDecrement(CALL_DATA &call);
	void unaryNegation(CALL_DATA &call);
	void lnot(CALL_DATA &call);
	void bnot(CALL_DATA &call);
	void tertiary(CALL_DATA &call);
	void member(CALL_DATA &call);
	void array(CALL_DATA &call);
}

// For loading methods.
typedef struct tagNamedMethod
{
	STRING name;
	int params;		// For overloaded methods.
	unsigned int i;
	bool bInline;	// Expand this method inline?
	unsigned int byref;		// Bit array: pass each parameter byref or byval?
							// Note that this sets a maximum number of parameters (32)!

	static std::vector<tagNamedMethod> m_methods;
	static tagNamedMethod *locate(const STRING name, const int params, const bool bMethod);
	static tagNamedMethod *locate(const STRING name, const int params, const bool bMethod, CProgram &prg);
} NAMED_METHOD, *LPNAMED_METHOD;

// Class visibilities.
typedef enum tagClassVisibility
{
	CV_PRIVATE,
	CV_PUBLIC
} CLASS_VISIBILITY;

// A class.
typedef struct tagClass
{
	std::deque<STRING> inherits;
	std::deque<std::pair<STRING, CLASS_VISIBILITY> > members;
	std::deque<std::pair<NAMED_METHOD, CLASS_VISIBILITY> > methods;

	tagNamedMethod *locate(const STRING name, const int params, const CLASS_VISIBILITY vis);
	bool memberExists(const STRING name, const CLASS_VISIBILITY vis) const;
	void inherit(const tagClass &cls);
} CLASS, *LPCLASS;

typedef std::deque<MACHINE_UNIT> MACHINE_UNITS, *LPMACHINE_UNITS;
typedef MACHINE_UNITS::const_iterator CONST_POS;
typedef MACHINE_UNITS::iterator POS;

typedef std::deque<std::deque<STACK_FRAME> >::const_iterator STACK_ITR;

// Get a lowercase string.
inline STRING lcase(const STRING str)
{
	TCHAR *const pstr = _tcslwr(_tcsdup(str.c_str()));
	const STRING ret = pstr;
	free(pstr);
	return ret;
}

// A pointer held in place.
template <class T>
class CPtrData
{
public:
	CPtrData(T data = T()) { m_pData = new T(data); }
	CPtrData(T *pData) { m_pData = new T(*pData); }
	CPtrData(const CPtrData &rhs) { m_pData = new T(*rhs.m_pData); }
	CPtrData &operator=(CPtrData &rhs) { *m_pData = *rhs.m_pData; return *this; }
	CPtrData &operator=(T &rhs) { *m_pData = rhs; return *this; }
	CPtrData &operator=(T *rhs) { delete m_pData; m_pData = rhs; return *this; }
	operator T*() { return m_pData; }
	T *operator->() { return m_pData; }
	const T *operator->() const { return m_pData; }
	~CPtrData() { delete m_pData; }
private:
	T *m_pData;
};

// A class for enumeration.
template <class T>
class CEnumeration
{
public:
	typedef T::const_iterator ITR;
	typedef T::value_type ITEM;
	CEnumeration(T &enu): m_enum(enu) { }
	ITR begin() const { return m_enum.begin(); }
	ITR end() const { return m_enum.end(); }
	int size() const { return m_enum.size(); }
private:
	T &m_enum;
};

// Types of exceptions.
typedef enum tagExceptionType
{
	E_DISABLED,		// All exception messages disabled.
	E_ERROR,
	E_WARNING
} EXCEPTION_TYPE;

// Broad scope categories.
typedef enum tagVariableScope
{
	VS_LOCAL,	// Scope within a function.
	VS_GLOBAL
} VAR_SCOPE;

// Forward declarations.
class CThread;				// A thread.
class IPlugin;				// A plugin.
class CFile;				// A file stream.
class CProgramChild;		// A child program;
class COptimiser;			// An optimisation engine.
class CGarbageCollector;	// A memory manager.
class CException;			// An exception.
struct tagBoardProgram;		// A board program;

// Some types of enumerations.
typedef CEnumeration<std::map<STRING, CPtrData<STACK_FRAME> > > HEAP_ENUM;
typedef CEnumeration<std::map<STRING, STRING> > REDIRECT_ENUM;
typedef CEnumeration<std::set<CThread *> > THREAD_ENUM;
typedef CEnumeration<std::map<unsigned int, STRING> > OBJECT_ENUM;

// A program.
class CProgram
{
public:
	CProgram(tagBoardProgram *pBrdProgram = NULL);
	CProgram(const STRING file, tagBoardProgram *pBrdProgram = NULL);
	virtual ~CProgram();

	bool open(const STRING fileName);
	bool loadFromString(const STRING str);
	void save(const STRING fileName) const;
	STACK_FRAME run();
	unsigned int getLine(CONST_POS i) const;
	void freeObject(unsigned int obj);
	void freeVar(const STRING var);
	void end() { m_i = m_units.end() - 1; }
	bool jump(const STRING label);
	void setErrorHandler(const STRING handler);
	void resumeFromErrorHandler();
	void setDefaultScope(const VAR_SCOPE s)
		{ m_pResolveFunc = ((s == VS_GLOBAL) ? resolveVarGlobal : resolveVarLocal); }

	CONST_POS getPos() const { return m_i; }
	CONST_POS getEnd() const { return m_units.end(); }
	LPSTACK_FRAME getLocal(const STRING var) { return &m_locals.back()[var]; }
	tagBoardProgram *getBoardLocation() const { return m_pBoardPrg; }

	virtual LPSTACK_FRAME getVar(const STRING name, unsigned int *pFrame = NULL, STRING *pName = NULL);
	virtual bool isThread() const { return false; }

	// Serialisation. This feature allows for the program's state
	// to be written to a stream and then reconstructed later.
	void serialiseState(CFile &stream) const;
	void reconstructState(CFile &stream);

	// Global program set up.
	static void initialize();
	static void addFunction(const STRING name, const MACHINE_FUNC func);
	static void addConstant(const STRING name, const STACK_FRAME value) { m_constants[lcase(name)] = value; }
	static STRING getFunctionName(const MACHINE_FUNC func);
	static int getRunningProgramCount() { return m_runningPrograms; }

	// Redirections.
	static void addRedirect(const STRING oldFunc, const STRING newFunc) { m_redirects[oldFunc] = newFunc; }
	static void removeRedirect(const STRING oldFunc);
	static void clearRedirects() { m_redirects.clear(); }
	static REDIRECT_ENUM enumerateRedirects() { return m_redirects; }

	// Debugger.
	static void debugger(const STRING str);
	static void setDebugLevel(const EXCEPTION_TYPE et) { m_debugLevel = et; }
	static EXCEPTION_TYPE getDebugLevel() { return m_debugLevel; }

	// Global rpgcode variables.
	static CPtrData<STACK_FRAME> &getGlobal(const STRING var) { return m_heap[lcase(var)]; }
	static void freeGlobal(const STRING var) { m_heap.erase(lcase(var)); }
	static void freeGlobals() { m_heap.clear(); m_objects.clear(); }
	static HEAP_ENUM enumerateGlobals() { return m_heap; }
	static OBJECT_ENUM enumerateObjects() { return m_objects; }
	static void setObject(unsigned int num, const STRING cls) { m_objects[num] = lcase(cls); }

	// Plugins
	static void addPlugin(IPlugin *const p) { m_plugins.push_back(p); }
	static void freePlugins();

	// Copy constructor and assignment operator.
	CProgram(const CProgram &rhs);
	CProgram &operator=(const CProgram &rhs);

private:
	std::list<std::map<STRING, STACK_FRAME> > m_locals;
	std::deque<std::deque<STACK_FRAME> > m_stack;
	std::deque<STACK_FRAME> *m_pStack;
	std::vector<CALL_FRAME> m_calls;
	std::map<STRING, CLASS> m_classes;
	std::vector<unsigned int> m_lines;
	tagBoardProgram *m_pBoardPrg;
	std::vector<tagNamedMethod> m_methods;
	std::vector<STRING> m_inclusions;

	// Yacc globals.
	static LPMACHINE_UNITS m_pyyUnits;
	static std::deque<std::deque<MACHINE_UNIT> > m_yyFors;
	static std::map<STRING, CLASS> *m_pClasses;
	static std::deque<int> m_params;
	static std::vector<unsigned int> *m_pLines;
	static std::vector<STRING> *m_pInclusions;
	static std::map<STRING, STACK_FRAME> m_constants;	// Map of compile-time constants.
	static std::map<STRING, STRING> m_redirects;		// Map of redirects.
	static STRING m_parsing;

	// Other globals.
	static std::map<unsigned int, STRING> m_objects;
	static std::map<STRING, MACHINE_FUNC> m_functions;
	static std::map<STRING, CPtrData<STACK_FRAME> > m_heap;
	static std::vector<IPlugin *> m_plugins;
	static unsigned long m_runningPrograms;
	static EXCEPTION_TYPE m_debugLevel;

	// Special constructs.
	static void conditional(CALL_DATA &);
	static void elseIf(CALL_DATA &call) { conditional(call); }
	static void skipElse(CALL_DATA &);
	static void skipMethod(CALL_DATA &);
	static void skipClass(CALL_DATA &);
	static void whileLoop(CALL_DATA &);
	static void untilLoop(CALL_DATA &);
	static void forLoop(CALL_DATA &);
	static void methodCall(CALL_DATA &);
	static void pluginCall(CALL_DATA &);
	static void returnVal(CALL_DATA &);
	static void returnReference(CALL_DATA &);
	static void classFactory(CALL_DATA &);
	static void runtimeInclusion(CALL_DATA &);
	static void verifyType(CALL_DATA &);

	friend void operators::member(CALL_DATA &call);
	friend void operators::array(CALL_DATA &call);
	friend void tagMachineUnit::execute(CProgram *prg) const;
	friend int yylex();
	friend int yyparse();
	friend int yyerror(const char *);
	friend void addInclusion(const STRING file);
	friend tagNamedMethod *tagNamedMethod::locate(const STRING name, const int params, const bool bMethod, CProgram &prg);
	friend bool checkOverloadedOperator(const STRING opr, CALL_DATA &call);
	friend CProgramChild;
	friend COptimiser;
	friend CGarbageCollector;

	void parseFile(FILE *pFile);
	unsigned int matchBrace(POS i);
	void include(const CProgram prg);
	void prime();
	static bool resolvePluginCall(LPMACHINE_UNIT pUnit);
	virtual std::list<std::map<STRING, STACK_FRAME> > *getLocals() { return &m_locals; }
	std::pair<bool, STRING> getInstanceVar(const STRING var) const;
	void returnFromMethod(STACK_FRAME value);
	void handleError(CException *);

	// Update curly brace pairs and method locations. Should be called
	// after new code is injected into the program to prevent errors.
	// Call this before resolveFunctions().
	unsigned int updateLocations(POS first);

	// Resolve functions. Can be called to explicitly attempt to
	// resolve functions that have so far resisted resolution.
	void resolveFunctions();

protected:
	LPSTACK_FRAME resolveVarGlobal(const STRING name, unsigned int *);
	LPSTACK_FRAME resolveVarLocal(const STRING name, unsigned int *);

	STRING m_fileName;
	MACHINE_UNITS m_units;
	CONST_POS m_i;
	LPSTACK_FRAME (CProgram::*m_pResolveFunc) (const STRING name, unsigned int *);
};

// A child of a program. Used for parsing lines at runtime.
class CProgramChild : public CProgram
{
public:
	CProgramChild(CProgram &prg): m_prg(prg) { }
	LPSTACK_FRAME getVar(const STRING name) { return m_prg.getVar(name); }
	CProgram &getParent() { return m_prg; }

private:
	CProgram &m_prg;
	std::list<std::map<STRING, STACK_FRAME> > *getLocals() { return m_prg.getLocals(); }
};

// An RPGCode thread.
class CThread : public CProgram
{
public:
	static CThread *create(const STRING str);
	static void destroy(CThread *p);
	static void multitask(const unsigned int units);
	static bool isThread(CThread *p) { return (m_threads.find(p) != m_threads.end()); }
	static void destroyAll();
	static THREAD_ENUM enumerateThreads() { return m_threads; }

	bool isThread() const { return true; }
	void sleep(const unsigned long milliseconds);
	bool isSleeping() const;
	unsigned long sleepRemaining() const;
	void wakeUp() { m_bSleeping = false; }
	STRING getFileName() const { return m_fileName; }

	virtual bool execute(const unsigned int units);

private:
	mutable bool m_bSleeping;
	unsigned long m_sleepBegin, m_sleepDuration;

protected:
	static void *operator new(size_t size) { return malloc(size); }
	static void operator delete(void *p) { free(p); }
	CThread(const STRING str);
	static std::set<CThread *> m_threads;
};

// An exception.
class CException
{
public:
	STRING getMessage() const { return m_str; }
	EXCEPTION_TYPE getType() const { return m_type; }
private:
	STRING m_str;
	EXCEPTION_TYPE m_type;
protected:
	CException(const STRING str, const EXCEPTION_TYPE type):
		m_str(str), m_type(type) { }
};

class CError : public CException
{
public:
	CError(const STRING str): CException(str, E_ERROR) { }
};

class CWarning : public CException
{
public:
	CWarning(const STRING str): CException(str, E_WARNING) { }
};

#endif

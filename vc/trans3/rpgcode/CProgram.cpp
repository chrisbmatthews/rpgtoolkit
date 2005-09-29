/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

/*
 * RPGCode parser and interpreter.
 */

#include "CProgram.h"
#include "CVariant.h"
#include "../plugins/plugins.h"
#include "../common/mbox.h"
#include "../common/paths.h"
#include "../input/input.h"
#include <malloc.h>
#include <math.h>

// Static member initialization.
std::vector<NAMED_METHOD> tagNamedMethod::m_methods;
std::map<std::string, MACHINE_FUNC> CProgram::m_functions;
LPMACHINE_UNITS CProgram::m_pyyUnits = NULL;
std::deque<MACHINE_UNITS> CProgram::m_yyFors;
std::map<std::string, STACK_FRAME> CProgram::m_heap;
std::deque<int> CProgram::m_params;
std::map<std::string, CLASS> *CProgram::m_pClasses = NULL;
std::map<unsigned int, std::string> CProgram::m_objects;
std::vector<unsigned int> *CProgram::m_pLines = NULL;
std::vector<std::string> CProgram::m_inclusions;
std::vector<IPlugin *> CProgram::m_plugins;
std::set<CThread *> CThread::m_threads;
std::string CProgram::m_parsing;
unsigned long CProgram::m_runningPrograms = 0;

// Create a thread.
CThread *CThread::create(const std::string str)
{
	CThread *p = new CThread(str);
	m_threads.insert(p);
	return p;
}

// Destroy a thread.
void CThread::destroy(CThread *p)
{
	std::set<CThread *>::iterator i = m_threads.find(p);
	if (i != m_threads.end())
	{
		m_threads.erase(i);
		delete p;
	}
}

// Destroy all threads.
void CThread::destroyAll()
{
	std::set<CThread *>::iterator i = m_threads.begin();
	for (; i != m_threads.end(); ++i)
	{
		delete *i;
	}
	m_threads.clear();
}

// Multitask now.
void CThread::multitask()
{
	std::set<CThread *>::iterator i = m_threads.begin();
	for (; i != m_threads.end(); ++i)
	{
		if (!(*i)->isSleeping())
		{
			(*i)->execute();
		}
	}
}

// Put a thread to sleep.
void CThread::sleep(const unsigned long milliseconds)
{
	m_bSleeping = true;
	m_sleepDuration = milliseconds;
	m_sleepBegin = GetTickCount();
}

// Is a thread sleeping?
bool CThread::isSleeping() const
{
	if (!m_bSleeping) return false;

	if ((GetTickCount() - m_sleepBegin) >= m_sleepDuration)
	{
		m_bSleeping = false;
		return false;
	}
	return true;
}

// Check how much sleep is remaining.
unsigned long CThread::sleepRemaining() const
{
	if (!isSleeping()) return 0;
	return (m_sleepDuration - (GetTickCount() - m_sleepBegin));
}

// Show the debugger.
void CProgram::debugger(const std::string str)
{
	messageBox("RPGCode Error\n\n" + str);
}

// Free loaded plugins.
void CProgram::freePlugins()
{
	std::vector<IPlugin *>::iterator i = m_plugins.begin();
	for (; i != m_plugins.end(); ++i)
	{
		(*i)->terminate();
		delete *i;
	}
	m_plugins.clear();
}

// Parsing error handler.
int yyerror(const char *error)
{
	extern unsigned int g_lines;
	char str[255];
	itoa(g_lines + 1, str, 10);
	std::string strError = error;
	strError[0] = toupper(strError[0]);
	CProgram::debugger(CProgram::m_parsing + "\r\nLine " + str + ": " + strError + ".");
	return 0;
}

// Estimate the line a unit is part of. Doesn't work at all for
// compiled code, but this is okay because compiled code is
// presumably free of compile-time errors. Has unavoidable
// errors with for loops. but an error in the third section
// of a for loop is so rare that this shouldn't be a big issue.
// Finally, included files with loose code will not work.
unsigned int CProgram::getLine(CONST_POS pos) const
{
	unsigned int i = pos - m_units.begin();
	std::vector<unsigned int>::const_iterator j = m_lines.begin();
	for (; j != m_lines.end(); ++j)
	{
		if (*j > i) return (j - m_lines.begin() + 1);
	}
	return m_lines.size();
}

// Get a variable.
LPSTACK_FRAME CProgram::getVar(const std::string name)
{
	if (name[0] == ':')
	{
		return &m_heap[name.substr(1)];
	}
	if (m_calls.size())
	{
		unsigned int obj = m_calls.back().obj;
		if (obj)
		{
			std::map<std::string, tagClass>::const_iterator i = m_classes.find(m_objects[obj]);
			if ((i != m_classes.end()) && i->second.memberExists(name, CV_PRIVATE))
			{
				char str[255];
				itoa(obj, str, 10);
				return &m_heap[std::string(str) + "::" + name];
			}
		}
	}
	if (m_locals.back().count(name))
	{
		return &m_locals.back().find(name)->second;
	}
	return &m_heap[name];
}

// Locate a named method.
tagNamedMethod *tagNamedMethod::locate(const std::string name, const int params, const bool bMethod)
{
	std::vector<NAMED_METHOD>::iterator i = m_methods.begin();
	for (; i != m_methods.end(); ++i)
	{
		if ((i->name == name) && (i->params == params) && (bMethod || (i->i != 0xffffff)))
		{
			return &*i;
		}
	}
	return NULL;
}

tagNamedMethod *tagClass::locate(const std::string name, const int params, const CLASS_VISIBILITY vis)
{
	std::deque<std::pair<NAMED_METHOD, CLASS_VISIBILITY> >::iterator i = methods.begin();
	for (; i != methods.end(); ++i)
	{
		if ((i->second >= vis) && (i->first.name == name) && (i->first.params == params))
		{
			return &i->first;
		}
	}
	return NULL;
}

// Check whether the class has a member.
bool tagClass::memberExists(const std::string name, const CLASS_VISIBILITY vis) const
{
	std::deque<std::pair<std::string, CLASS_VISIBILITY> >::const_iterator i = members.begin();
	for (; i != members.end(); ++i)
	{
		if ((i->second >= vis) && (i->first == name)) return true;
	}
	return false;
}

// Inherit a class.
void tagClass::inherit(const tagClass &cls)
{
	std::deque<std::pair<std::string, CLASS_VISIBILITY> >::const_iterator i = cls.members.begin();
	for (; i != cls.members.end(); ++i)
	{
		if (!memberExists(i->first, CV_PRIVATE))
		{
			members.push_back(*i);
		}
	}

	std::deque<std::pair<NAMED_METHOD, CLASS_VISIBILITY> >::const_iterator j = cls.methods.begin();
	for (; j != cls.methods.end(); ++j)
	{
		if (!locate(j->first.name, j->first.params, CV_PRIVATE))
		{
			methods.push_back(*j);
		}
	}
}

// Get a function's name.
std::string CProgram::getFunctionName(const MACHINE_FUNC func)
{
	std::map<std::string, MACHINE_FUNC>::const_iterator i = m_functions.begin();
	for (; i != m_functions.end(); ++i)
	{
		if (i->second == func) break;
	}
	return ((i != m_functions.end()) ? i->first : "");
}

// Show the contents of the instruction unit.
inline void tagMachineUnit::show() const
{
	std::cout	<< "Lit: " << lit
				<< "\nNum: " << num
				<< "\nType: " << udt
				<< "\nFunc: " << CProgram::getFunctionName(func)
				<< "\nParams: " << params
				<< "\n\n";
}

// Add a function to the global namespace.
void CProgram::addFunction(const std::string name, const MACHINE_FUNC func)
{
	char *const str = _strlwr(_strdup(name.c_str()));
	m_functions.insert(std::map<std::string, MACHINE_FUNC>::value_type(str, func));
	free(str);
}

// Free a variable.
void CProgram::freeVar(const std::string var)
{
	if (m_locals.back().count(var))
	{
		m_locals.back().erase(var);
		return;
	}
	m_heap.erase(var);
}

// Free an object.
void CProgram::freeObject(unsigned int obj)
{
	const std::string type = m_objects[obj];
	std::map<std::string, tagClass>::iterator i = m_classes.find(type);
	if (i == m_classes.end())
	{
		throw CError("Could not find class " + type + ".");
	}

	char str[255];
	itoa(obj, str, 10);

	std::deque<std::pair<std::string, CLASS_VISIBILITY> >::const_iterator j = i->second.members.begin();
	for (; j != i->second.members.end(); ++j)
	{
		freeVar(std::string(str) + "::" + j->first);
	}

	m_objects.erase(obj);
}

// Handle a method call.
void CProgram::methodCall(CALL_DATA &call)
{
	std::map<std::string, STACK_FRAME> local;

	CALL_FRAME fr;
	fr.obj = 0;

	STACK_FRAME &fra = call[call.params - 1];

	bool bNoRet = false;

	for (unsigned int i = 0, j = 0; i < (call.params - 1); ++i)
	{
		if (call[i].getType() & UDT_OBJ)
		{
			unsigned int obj = (unsigned int)call[i].getNum();
			{
				const std::string type = CProgram::m_objects[obj];
				std::map<std::string, tagClass>::iterator k = call.prg->m_classes.find(type);
				if (k == call.prg->m_classes.end())
				{
					throw CError("Could not find class " + type + ".");
				}

				bool bRelease = false;
				if (fra.lit == "release")
				{
					bRelease = true;
					fra.lit = "~" + k->first;
				}

				const CLASS_VISIBILITY cv = (call.prg->m_calls.size() && (CProgram::m_objects[call.prg->m_calls.back().obj] == type)) ? CV_PRIVATE : CV_PUBLIC;
				LPNAMED_METHOD p = k->second.locate(fra.lit, call.params - 2, cv);
				if (!p)
				{
					if (!bRelease)
					{
						char str[255];
						itoa(call.params - 2, str, 10);
						throw CError("Class " + k->first + " has no accessible " + fra.lit + " method with a parameter count of " + str + ".");
					}
					else
					{
						call.prg->freeObject(obj);
						return;
					}
				}

				if (type == fra.lit)
				{
					call.prg->m_pStack->back() = call[i].getValue();
					bNoRet = true;
				}

				fra.num = p->i;
			}

			STACK_FRAME &lvar = local["this"];
			lvar.udt = UNIT_DATA_TYPE(UDT_OBJ | UDT_NUM);
			lvar.num = fr.obj = obj;
		}
		else
		{
			local[std::string(" ") + char(++j)] = call[i].getValue();
		}
	}

	if (!fr.obj && call.prg->m_calls.size())
	{
		const unsigned int obj = call.prg->m_calls.back().obj;
		if (obj)
		{
			std::map<std::string, tagClass>::iterator i = call.prg->m_classes.find(CProgram::m_objects[obj]);
			if (i != call.prg->m_classes.end())
			{
				LPNAMED_METHOD p = i->second.locate(fra.lit, call.params - 1, CV_PRIVATE);
				if (p)
				{
					fra.num = p->i;
					STACK_FRAME &lvar = local["this"];
					lvar.udt = UNIT_DATA_TYPE(UDT_OBJ | UDT_NUM);
					lvar.num = fr.obj = obj;
				}
			}
		}
	}

	call.prg->m_locals.push_back(local);

	call.prg->m_stack.push_back(call.prg->m_stack.back());

	fr.i = call.prg->m_i - call.prg->m_units.begin();

	if (bNoRet)
	{
		fr.bReturn = true;
	}
	else if (call.prg->m_i->udt & UDT_LINE)
	{
		fr.bReturn = false;
		fr.p = NULL;
	}
	else
	{
		fr.bReturn = true;
		fr.p = &call.prg->m_pStack->back();
		fr.p->udt = UDT_NUM;
		fr.p->num = 0.0;
	}

	call.prg->m_pStack->erase(call.prg->m_pStack->end() - call.params - 1, call.prg->m_pStack->end() - 1);

	call.prg->m_pStack = &call.prg->m_stack.back();
	call.prg->m_i = call.prg->m_units.begin() + (unsigned int)call[call.params - 1].num;

	fr.j = (unsigned int)call.prg->m_i->num;

	call.prg->m_calls.push_back(fr);
}

void CProgram::returnVal(CALL_DATA &call)
{
	if (!call.prg->m_calls.size()) return;
	if (call.prg->m_calls.back().p)
	{
		*call.prg->m_calls.back().p = call[0].getValue();
	}
	call.prg->m_i = call.prg->m_units.begin() + call.prg->m_calls.back().j - 1;
}

#define YYSTACKSIZE 50000
#define YYSTYPE CVariant
#include "y.tab.c"	// Yacc parser.

// Read a string.
inline std::string freadString(FILE *file)
{
	std::string ret;
	char c = '\0';
	while (fread(&c, sizeof(char), 1, file) != 0)
	{
		if (c == '\0') break;
		ret += c;
	}
	return ret;
}

// Open an RPGCode program.
bool CProgram::open(const std::string fileName)
{
	FILE *file = fopen(fileName.c_str(), "rb");
	if (!file) return false;
	char c = '\0';
	if (fread(&c, sizeof(char), 1, file) == 0)
	{
		fclose(file);
		return false;
	}

	if (c == '\0')
	{
		// File is machine code.

		// First is a list of functions used.
		std::vector<MACHINE_FUNC> funcs;
		while (true)
		{
			const std::string func = freadString(file);
			if (func.empty()) break;
			funcs.push_back(m_functions[func]);
		}

		// Classes.
		m_classes.clear();
		while (true)
		{
			const std::string name = freadString(file);
			if (name.empty()) break;
			tagClass cls;
			while (true)
			{
				const std::string base = freadString(file);
				if (base.empty()) break;
				cls.inherits.push_back(base);
			}
			while (true)
			{
				const std::string member = freadString(file);
				if (member.empty()) break;
				CLASS_VISIBILITY vis;
				fread(&vis, sizeof(int), 1, file);
				cls.members.push_back(std::pair<std::string, CLASS_VISIBILITY>(member, vis));
			}
			while (true)
			{
				NAMED_METHOD method;
				if ((method.name = freadString(file)).empty()) break;
				CLASS_VISIBILITY vis;
				fread(&method.params, sizeof(int), 1, file);
				fread(&method.i, sizeof(unsigned int), 1, file);
				fread(&vis, sizeof(CLASS_VISIBILITY), 1, file);
				cls.methods.push_back(std::pair<NAMED_METHOD, CLASS_VISIBILITY>(method, vis));
			}
			m_classes[name] = cls;
		}

		// Now the machine instruction units.
		m_units.clear();
		while (true)
		{
			MACHINE_UNIT mu;
			if (fread(&mu.udt, sizeof(UNIT_DATA_TYPE), 1, file) == 0)
			{
				break;
			}
			if ((mu.udt & UDT_NUM) || (mu.udt & UDT_OPEN) || (mu.udt & UDT_CLOSE))
			{
				fread(&mu.num, sizeof(double), 1, file);
			}
			else if ((mu.udt & UDT_LIT) || (mu.udt & UDT_ID) || (mu.udt & UDT_LABEL))
			{
				mu.lit = freadString(file);
			}
			else if (mu.udt & UDT_FUNC)
			{
				int funcId = 0;
				fread(&funcId, sizeof(int), 1, file);
				mu.func = funcs[funcId];
				fread(&mu.params, sizeof(int), 1, file);
			}
			m_units.push_back(mu);
		}
	}
	else
	{
		const std::string parsing = m_parsing;
		m_parsing = fileName;
		fseek(file, 0, SEEK_SET);
		parseFile(file);
		m_parsing = parsing;
	}

	fclose(file);

	prime();
	return true;
}

// Prime the program.
void CProgram::prime()
{
	m_stack.clear();
	m_stack.push_back(std::deque<STACK_FRAME>());
	m_pStack = &m_stack.back();
	m_calls.clear();
	m_locals.clear();
	m_locals.push_back(std::map<std::string, STACK_FRAME>());
	m_i = m_units.begin();
}

// Load the program from a string.
bool CProgram::loadFromString(const std::string str)
{
	FILE *p = tmpfile();
	if (!p) return false;

	fputs(str.c_str(), p);
	fseek(p, 0, SEEK_SET);
	parseFile(p);
	fclose(p);

	prime();
	return true;
}

// Parse a file.
void CProgram::parseFile(FILE *pFile)
{
	// Pass I:
	//   - Run the file though the YACC generated parser,
	//     producing machine units. See yacc.txt.
	m_inclusions.clear();
	m_units.clear();
	NAMED_METHOD::m_methods.clear();
	m_classes.clear();
	m_pClasses = &m_classes;
	m_pyyUnits = &m_units;
	yyin = pFile;
	g_lines = 0;
	m_lines.clear();
	m_pLines = &m_lines;
	yyparse();
	m_yyFors.clear();

	// Pass II:
	//   - Include requested files.
	{
		std::vector<std::string> inclusions = m_inclusions;
		std::vector<std::string>::const_iterator i = inclusions.begin();
		extern std::string g_projectPath;
		for (; i != inclusions.end(); ++i)
		{
			include(g_projectPath + PRG_PATH + *i);
		}
		m_inclusions.clear();
	}

	// Pass III:
	//   - Handle member references within class methods.
	//   - Record class members.
	//   - Detect class factory references.
	//   - Backward compatibility: "end" => "end()"
	//	 - Transform switch...case structures to if...elseif...else.

	tagClass **classes = (tagClass **)_alloca(sizeof(tagClass *) * m_classes.size());
	std::map<std::string, tagClass>::iterator j = m_classes.begin();
	for (unsigned int k = 0; j != m_classes.end(); ++j, ++k)
	{
		std::deque<std::string>::iterator l = j->second.inherits.begin();
		for (; l != j->second.inherits.end(); ++l)
		{
			if (!m_classes.count(*l))
			{
				debugger("Could not find " + j->first + "'s base class " + *l + ".");
				if ((l = j->second.inherits.erase(l)) == j->second.inherits.end()) break;
				--l;
			}
			else
			{
				j->second.inherit(m_classes[*l]);
			}
		}
		classes[k] = &j->second;
	}

	LPCLASS pClass = NULL;

	CLASS_VISIBILITY vis = CV_PRIVATE;

	unsigned int depth = 0, nestled = 0, cls = 0;

	POS i = m_units.begin();
	for (; i != m_units.end(); ++i)
	{
		if (i->udt & UDT_OPEN)
		{
			++nestled;
			if (depth)
			{
				++depth;
			}
			else if (((i - 1)->udt & UDT_FUNC) && ((i - 1)->func == skipClass))
			{
				depth = 1;
				pClass = classes[cls++];
				vis = CLASS_VISIBILITY(int((i - 1)->num));
			}
		}
		else if (i->udt & UDT_CLOSE)
		{
			--nestled;
			if (depth && !--depth) pClass = NULL;
		}

		if ((i->udt & UDT_ID) && (i->lit[0] == ':') && ((i == m_units.end()) || !(((i + 1)->udt & UDT_LINE))))
		{
			i->udt = UDT_LABEL;
		}

		if ((i->udt & UDT_ID) && (i->udt & UDT_LINE) && ((i == m_units.begin()) || ((i - 1)->udt & UDT_LINE)) && ((i == m_units.end()) || ((i + 1)->udt & UDT_LINE)))
		{
			if (depth == 1)
			{
				if (i->udt & UDT_NUM)
				{
					// Visibility specifier.
					vis = CLASS_VISIBILITY(int(i->num));
				}
				else
				{
					// Historical member declaration.
					pClass->members.push_back(std::pair<std::string, CLASS_VISIBILITY>(i->lit, vis));
				}
				i = m_units.erase(i) - 1;
			}
			else
			{
				// Convert such lines as "end" to "end()". This could
				// potentially do unwanted things, but it is required
				// for backward compatibility.
				if (m_functions.count(i->lit))
				{
					i->params = 0;
					i->func = m_functions[i->lit];
				}
				else
				{
					MACHINE_UNIT mu;
					mu.udt = UDT_ID;
					mu.lit = i->lit;
					i->params = 1;
					i->func = methodCall;
					i = m_units.insert(i, mu) + 1;
				}
				i->udt = UNIT_DATA_TYPE(UDT_FUNC | UDT_LINE);
			}
		}

		if ((i->udt & UDT_FUNC) && (i->func == methodCall))
		{
			POS unit = i - 1;
			if (unit->udt & UDT_OBJ) continue;
			if (unit->lit == "switch")
			{
				POS j = unit; unsigned int dec = 1;
				for (; j != m_units.begin(); --j, ++dec)
				{
					if (j->udt & UDT_LINE) break;
				}
				if (j != m_units.begin())
				{
					++j; --dec;
				}
				MACHINE_UNIT mu;
				mu.udt = UDT_ID;
				char str[255]; itoa(nestled + 1, str, 10);
				mu.lit = std::string(" switch[") + str + "]";
				i = m_units.insert(j, mu) + 1 + dec;
				i = m_units.erase(unit);
				i->func = operators::assign;
			}
			else if (unit->lit == "case")
			{
				if (((unit - 1)->udt & UDT_ID) && ((unit - 1)->lit == "else"))
				{
					unit->udt = UNIT_DATA_TYPE(UDT_FUNC | UDT_LINE);
					unit->func = skipElse;
					unit->params = 0;
					i = m_units.erase(i) - 1;
					i = m_units.erase(i - 1);
				}
				else
				{
					POS j = unit;
					for (; j != m_units.begin(); --j)
					{
						if (j->udt & UDT_LINE) break;
					}
					if (j != m_units.begin()) --j;
					MACHINE_FUNC func = ((j->udt & UDT_FUNC) && (j->func == operators::assign)) ? conditional : elseIf;
					unit->udt = UDT_ID;
					char str[255]; itoa(nestled, str, 10);
					unit->lit = std::string(" switch[") + str + "]";
					i->udt = UDT_FUNC;
					i->func = operators::eq;
					i->params = 2;
					MACHINE_UNIT mu;
					mu.udt = UNIT_DATA_TYPE(UDT_FUNC | UDT_LINE);
					mu.func = func;
					mu.params = 1;
					i = m_units.insert(i + 1, mu) - 1;
				}
			}
			else if (unit->lit == "default")
			{
				unit->udt = UNIT_DATA_TYPE(UDT_FUNC | UDT_LINE);
				unit->func = skipElse;
				unit->params = 0;
				i = m_units.erase(i) - 1;
			}
			else if (m_classes.count(unit->lit))
			{
				LPCLASS pCls = &m_classes[unit->lit];
				LPNAMED_METHOD pCtor = pCls->locate(unit->lit, i->params - 1, (pCls == pClass) ? CV_PRIVATE : CV_PUBLIC);
				if ((i->params == 1) || pCtor)
				{
					i->func = classFactory;
					if (pCtor)
					{
						{
							MACHINE_UNIT mu;
							mu.udt = UNIT_DATA_TYPE(UDT_ID | UDT_OBJ);
							mu.lit = unit->lit;
							i = m_units.insert(i + 1, mu) - 1;
						}
						{
							MACHINE_UNIT mu;
							mu.udt = UDT_FUNC;
							mu.func = methodCall;
							mu.params = i->params + 1;
							i = m_units.insert(i + 2, mu) - 2;
						}
						i->params = 1;
					}
				}
				else
				{
					char str[255]; itoa(i->params - 1, str, 10);
					char line[255]; itoa(getLine(i), line, 10);
					debugger(std::string("Near line ") + line + ": No accessible constructor for " + unit->lit + " has a parameter count of " + str + ".");
				}
			}
		}
	}

	// Pass IV:
	//   - Update curly brace pairing and method locations.
	depth = 0;
	for (i = m_units.begin(); i != m_units.end(); ++i)
	{
		if ((i->udt & UDT_FUNC) && (i->func == skipMethod))
		{
			LPNAMED_METHOD p = NAMED_METHOD::locate(i->lit, (unsigned int)i->num, false);
			if (p)
			{
				p->i = i - m_units.begin() + 1;
			}
			const std::string::size_type pos = i->lit.find("::");
			if (pos != std::string::npos)
			{
				LPCLASS pCls = &m_classes[i->lit.substr(0, pos)];
				if (pCls)
				{
					LPNAMED_METHOD p = pCls->locate(i->lit.substr(pos + 2), (unsigned int)i->num, CV_PRIVATE);
					if (p)
					{
						p->i = i - m_units.begin() + 1;
					}
				}
			}
		}
		else if (i->udt & UDT_OPEN)
		{
			++depth;
		}
		else if (i->udt & UDT_CLOSE)
		{
			--depth;
			matchBrace(i);
		}
	}

	// Report any unmatched braces.
	if (depth)
	{
		MACHINE_UNIT mu;
		mu.udt = UNIT_DATA_TYPE(UDT_CLOSE | UDT_LINE);
		for (unsigned int i = 0; i < depth; ++i)
		{
			char str[255];
			itoa(getLine(m_units.begin() + matchBrace(m_units.insert(m_units.end(), mu))) + 1, str, 10);
			debugger(std::string("Near line ") + str + ": Unmatched curly brace.");
		}
	}

	// Pass V:
	//   - Resolve function calls.
	for (i = m_units.begin(); i != m_units.end(); ++i)
	{
		if ((i->udt & UDT_FUNC) && (i->func == methodCall))
		{
			POS unit = i - 1;
			if (unit->udt & UDT_OBJ) continue;
			LPNAMED_METHOD p = NAMED_METHOD::locate(unit->lit, i->params - 1, false);
			if (p)
			{
				unit->udt = UDT_NUM;
				unit->num = p->i;
			}
			else
			{
				// Check plugins.
			}
		}
	}
}

// Match a curly brace pair.
unsigned int CProgram::matchBrace(POS i)
{
	POS cur = i;
	int depth = 0;
	for (; i != m_units.begin(); --i)
	{
		if ((i->udt & UDT_OPEN) && (++depth == 0))
		{
			i->num = cur - m_units.begin();
			unsigned long *const pLines = (unsigned long *)&cur->num;
			pLines[0] = i - m_units.begin();
			for (; i != m_units.begin(); --i)
			{
				if ((i->udt & UDT_LINE) && (++depth == 3)) break;
			}
			pLines[1] = i - m_units.begin() + 1;
			if (i == m_units.begin()) --pLines[1];
			return pLines[0];
		}
		else if (i->udt & UDT_CLOSE) --depth;
	}
	return 0;
}

// Include a file.
void CProgram::include(const std::string file)
{
	std::vector<NAMED_METHOD> methods = NAMED_METHOD::m_methods;

	CProgram prg(file);

	{
		std::map<std::string, tagClass>::const_iterator i = prg.m_classes.begin();
		for (; i != prg.m_classes.end(); ++i)
		{
			m_classes.insert(*i);
		}
	}

	std::vector<NAMED_METHOD>::const_iterator i = NAMED_METHOD::m_methods.begin();
	for (; i != NAMED_METHOD::m_methods.end(); ++i)
	{
		methods.push_back(*i);
		int depth = 0;
		CONST_POS j = prg.m_units.begin() + i->i - 1;
		do
		{
			m_units.push_back(*j);
			if (j->udt & UDT_OPEN) ++depth;
			else if ((j->udt & UDT_CLOSE) && !--depth) break;
		} while (++j != prg.m_units.end());
	}

	NAMED_METHOD::m_methods = methods;
}

// Save an RPGCode program.
void CProgram::save(const std::string fileName) const
{
	FILE *file = fopen(fileName.c_str(), "wb");

	// First character in file is NULL.
	const char c = '\0';
	fwrite(&c, sizeof(char), 1, file);

	// Build a list of used functions.
	int count = 0;
	std::map<MACHINE_FUNC, int> funcs;
	CONST_POS i = m_units.begin();
	for (; i != m_units.end(); ++i)
	{
		if (i->udt & UDT_FUNC)
		{
			if (funcs.count(i->func) != 0) continue;
			std::map<std::string, MACHINE_FUNC>::iterator j = m_functions.begin();
			for (; j != m_functions.end(); ++j)
			{
				if (i->func == j->second) break;
			}

			fwrite(j->first.c_str(), sizeof(char), j->first.length() + 1, file);
			funcs[j->second] = count++;
		}
	}

	fwrite(&c, sizeof(char), 1, file);

	// Classes.
	std::map<std::string, tagClass>::const_iterator j = m_classes.begin();
	for (; j != m_classes.end(); ++j)
	{
		fwrite(j->first.c_str(), sizeof(char), j->first.length() + 1, file);
		std::deque<std::string>::const_iterator k = j->second.inherits.begin();
		for (; k != j->second.inherits.end(); ++k)
		{
			fwrite(k->c_str(), sizeof(char), k->length() + 1, file);
		}
		fwrite(&c, sizeof(char), 1, file);
		std::deque<std::pair<std::string, CLASS_VISIBILITY> >::const_iterator l = j->second.members.begin();
		for (; l != j->second.members.end(); ++l)
		{
			fwrite(l->first.c_str(), sizeof(char), l->first.length() + 1, file);
			fwrite(&l->second, sizeof(CLASS_VISIBILITY), 1, file);
		}
		fwrite(&c, sizeof(char), 1, file);
		std::deque<std::pair<NAMED_METHOD, CLASS_VISIBILITY> >::const_iterator m = j->second.methods.begin();
		for (; m != j->second.methods.end(); ++m)
		{
			fwrite(m->first.name.c_str(), sizeof(char), m->first.name.length() + 1, file);
			fwrite(&m->first.params, sizeof(int), 1, file);
			fwrite(&m->first.i, sizeof(unsigned int), 1, file);
			fwrite(&m->second, sizeof(CLASS_VISIBILITY), 1, file);
		}
		fwrite(&c, sizeof(char), 1, file);
	}

	fwrite(&c, sizeof(char), 1, file);

	// Write the instruction units.
	for (i = m_units.begin(); i != m_units.end(); ++i)
	{
		fwrite(&i->udt, sizeof(UNIT_DATA_TYPE), 1, file);
		if ((i->udt & UDT_NUM) || (i->udt & UDT_OPEN) || (i->udt & UDT_CLOSE))
		{
			fwrite(&i->num, sizeof(double), 1, file);
		}
		else if ((i->udt & UDT_LIT) || (i->udt & UDT_ID) || (i->udt & UDT_LABEL))
		{
			fwrite(i->lit.c_str(), sizeof(char), i->lit.length() + 1, file);
		}
		else if (i->udt & UDT_FUNC)
		{
			const int funcId = funcs[i->func];
			fwrite(&funcId, sizeof(int), 1, file);
			fwrite(&i->params, sizeof(int), 1, file);
		}
	}

	fclose(file);
}

// Run an RPGCode program.
void CProgram::run()
{
	extern void programInit(), programFinish();

	++CProgram::m_runningPrograms;
	programInit();
	for (m_i = m_units.begin(); m_i != m_units.end(); ++m_i)
	{
		m_i->execute(this);
		processEvent();
	}
	programFinish();
	--CProgram::m_runningPrograms;
}

// Execute one unit from a program.
bool CThread::execute()
{
	if (m_i != m_units.end())
	{
		m_i->execute(this);
		++m_i;
		return true;
	}
	return false;
}

// Jump to a label.
void CProgram::jump(const std::string label)
{
	CONST_POS i = m_units.begin();
	for (; i != m_units.end(); ++i)
	{
		if ((i->udt & UDT_LABEL) && (_strcmpi(i->lit.c_str(), label.c_str()) == 0))
		{
			m_i = i;
			return;
		}
	}
}

// Execute an instruction unit.
void tagMachineUnit::execute(CProgram *prg) const
{
	if (udt & UDT_FUNC)
	{
		prg->m_pStack->push_back(prg);
		try
		{
			CALL_DATA call = {params, &prg->m_pStack->back() - params, prg};
			func(call);
		}
		catch (CException exp)
		{
			char str[255]; itoa(prg->getLine(prg->m_i), str, 10);
			CProgram::debugger(std::string("Near line ") + str + ": " + exp.getMessage());
		}
		catch (...)
		{
			char str[255]; itoa(prg->getLine(prg->m_i), str, 10);
			CProgram::debugger(std::string("Near line ") + str + ": Unexpected error.");
		}
		prg->m_pStack->erase(prg->m_pStack->end() - params - 1, prg->m_pStack->end() - 1);
	}
	else if (udt & UDT_CLOSE)
	{
		// Hacky code here. The num member is actually storing
		// two longs in the double. The first long is the unit
		// which holds the opening brace, and the second long
		// is the unit which holds the beginning of the first
		// statement before the opening brace.
		const unsigned long *const pLines = (unsigned long *)&num;
		CONST_POS open = prg->m_units.begin() + pLines[0];
		if ((open != prg->m_units.end()) && ((open - 1)->udt & UDT_FUNC))
		{
			const MACHINE_FUNC &func = (open - 1)->func;
			if ((func == CProgram::whileLoop) || (func == CProgram::forLoop))
			{
				prg->m_i = prg->m_units.begin() + pLines[1] - 1;
			}
			else if (func == CProgram::skipMethod)
			{
				const bool bReturn = prg->m_calls.back().bReturn;
				prg->m_i = prg->m_units.begin() + prg->m_calls.back().i;
				prg->m_calls.pop_back();
				prg->m_stack.pop_back();
				prg->m_pStack = &prg->m_stack.back();
				prg->m_locals.pop_back();
				if (bReturn) return;
			}
			else if (((func == CProgram::conditional) || (func == CProgram::elseIf)) && (prg->m_i != prg->m_units.end()))
			{
				CONST_POS i = prg->m_i;
				while (++i != prg->m_units.end())
				{
					if ((i->udt & UDT_FUNC) && (i->udt & UDT_LINE)) break;
				}
				if ((i != prg->m_units.end()) && (i->func == CProgram::elseIf))
				{
					prg->m_i = prg->m_units.begin() + int((i + 1)->num) - 1;
				}
			}
		}
	}
	else if (!(udt & UDT_OPEN))
	{
		STACK_FRAME fr(prg);
		fr.lit = lit;
		fr.num = num;
		fr.udt = udt;
		prg->m_pStack->push_back(fr);
	}
	if (udt & UDT_LINE)
	{
		prg->m_pStack->clear();
	}
}

// Get the numerical value from a stack frame.
double tagStackFrame::getNum() const
{
	if (udt & UDT_ID)
	{
		return prg->getVar(lit)->getNum();
	}
	else if (udt & UDT_LIT)
	{
		return atof(lit.c_str());
	}
	return num;
}

// Get the boolean value from a stack frame.
bool tagStackFrame::getBool() const
{
	if (getType() & UDT_LIT)
	{
		return (getLit() != "off");
	}
	return (getNum() != 0.0);
}

// Get the literal value from a stack frame.
std::string tagStackFrame::getLit() const
{
	if (udt & UDT_ID)
	{
		return prg->getVar(lit)->getLit();
#if !defined(_DEBUG) && defined(_MSC_VER)
		// Without the following line, VC++ will crash
		// in release mode. I'll be damned if I know why.
		const std::string str;
#endif
	}
	else if (udt & UDT_NUM)
	{
		char str[255];
		gcvt(num, 255, str);
		char &c = str[strlen(str) - 1];
		if (c == '.') c = '\0';
		return str;
	}
	return lit;
}

// Get the type of data in a stack frame.
UNIT_DATA_TYPE tagStackFrame::getType() const
{
	if (udt & UDT_ID)
	{
		return prg->getVar(lit)->getType();
	}
	return udt;
}

// Get the value in a stack frame.
tagStackFrame tagStackFrame::getValue() const
{
	if (udt & UDT_ID)
	{
		return prg->getVar(lit)->getValue();
	}
	return *this;
}

void operators::add(CALL_DATA &call)
{
	if ((call[0].getType() & UDT_NUM) && (call[1].getType() & UDT_NUM))
	{
		call.ret().udt = UDT_NUM;
		call.ret().num = call[0].getNum() + call[1].getNum();
	}
	else
	{
		call.ret().udt = UDT_LIT;
		call.ret().lit = call[0].getLit() + call[1].getLit();
	}
}

void operators::sub(CALL_DATA &call)
{
	call.ret().udt = UDT_NUM;
	call.ret().num = call[0].getNum() - call[1].getNum();
}

void operators::mul(CALL_DATA &call)
{
	call.ret().udt = UDT_NUM;
	call.ret().num = call[0].getNum() * call[1].getNum();
}

void operators::bor(CALL_DATA &call)
{
	call.ret().udt = UDT_NUM;
	call.ret().num = int(call[0].getNum()) | int(call[1].getNum());
}

void operators::bxor(CALL_DATA &call)
{
	call.ret().udt = UDT_NUM;
	call.ret().num = int(call[0].getNum()) ^ int(call[1].getNum());
}

void operators::band(CALL_DATA &call)
{
	call.ret().udt = UDT_NUM;
	call.ret().num = int(call[0].getNum()) & int(call[1].getNum());
}

void operators::lor(CALL_DATA &call)
{
	call.ret().udt = UDT_NUM;
	call.ret().num = call[0].getNum() || call[1].getNum();
}

void operators::land(CALL_DATA &call)
{
	call.ret().udt = UDT_NUM;
	call.ret().num = call[0].getNum() && call[1].getNum();
}

void operators::ieq(CALL_DATA &call)
{
	call.ret().udt = UDT_NUM;
	call.ret().num = call[0].getLit() != call[1].getLit();
}

void operators::eq(CALL_DATA &call)
{
	call.ret().udt = UDT_NUM;
	call.ret().num = call[0].getLit() == call[1].getLit();
}

void operators::gte(CALL_DATA &call)
{
	call.ret().udt = UDT_NUM;
	call.ret().num = call[0].getNum() >= call[1].getNum();
}

void operators::lte(CALL_DATA &call)
{
	call.ret().udt = UDT_NUM;
	call.ret().num = call[0].getNum() <= call[1].getNum();
}

void operators::gt(CALL_DATA &call)
{
	call.ret().udt = UDT_NUM;
	call.ret().num = call[0].getNum() > call[1].getNum();
}

void operators::lt(CALL_DATA &call)
{
	call.ret().udt = UDT_NUM;
	call.ret().num = call[0].getNum() < call[1].getNum();
}

void operators::rs(CALL_DATA &call)
{
	call.ret().udt = UDT_NUM;
	call.ret().num = int(call[0].getNum()) >> int(call[1].getNum());
}

void operators::ls(CALL_DATA &call)
{
	call.ret().udt = UDT_NUM;
	call.ret().num = int(call[0].getNum()) << int(call[1].getNum());
}

void operators::mod(CALL_DATA &call)
{
	call.ret().udt = UDT_NUM;
	call.ret().num = int(call[0].getNum()) % int(call[1].getNum());
}

void operators::div(CALL_DATA &call)
{
	call.ret().udt = UDT_NUM;
	call.ret().num = call[0].getNum() / call[1].getNum();
}

void operators::pow(CALL_DATA &call)
{
	call.ret().udt = UDT_NUM;
	call.ret().num = ::pow(call[0].getNum(), call[1].getNum());
}

void operators::assign(CALL_DATA &call)
{
	call.ret().udt = UDT_ID;
	call.ret().lit = call[0].lit;
	*call.prg->getVar(call.ret().lit) = call[1].getValue();
}

void operators::xor_assign(CALL_DATA &call)
{
	call.ret().udt = UDT_ID;
	call.ret().lit = call[0].lit;
	STACK_FRAME &var = *call.prg->getVar(call.ret().lit);
	var.udt = UDT_NUM;
	var.num = int(call[0].getNum()) ^ int(call[1].getNum());
}

void operators::or_assign(CALL_DATA &call)
{
	call.ret().udt = UDT_ID;
	call.ret().lit = call[0].lit;
	STACK_FRAME &var = *call.prg->getVar(call.ret().lit);
	var.udt = UDT_NUM;
	var.num = int(call[0].getNum()) | int(call[1].getNum());
}

void operators::and_assign(CALL_DATA &call)
{
	call.ret().udt = UDT_ID;
	call.ret().lit = call[0].lit;
	STACK_FRAME &var = *call.prg->getVar(call.ret().lit);
	var.udt = UDT_NUM;
	var.num = int(call[0].getNum()) & int(call[1].getNum());
}

void operators::rs_assign(CALL_DATA &call)
{
	call.ret().udt = UDT_ID;
	call.ret().lit = call[0].lit;
	STACK_FRAME &var = *call.prg->getVar(call.ret().lit);
	var.udt = UDT_NUM;
	var.num = int(call[0].getNum()) >> int(call[1].getNum());
}

void operators::ls_assign(CALL_DATA &call)
{
	call.ret().udt = UDT_ID;
	call.ret().lit = call[0].lit;
	STACK_FRAME &var = *call.prg->getVar(call.ret().lit);
	var.udt = UDT_NUM;
	var.num = int(call[0].getNum()) << int(call[1].getNum());
}

void operators::sub_assign(CALL_DATA &call)
{
	call.ret().udt = UDT_ID;
	call.ret().lit = call[0].lit;
	STACK_FRAME &var = *call.prg->getVar(call.ret().lit);
	var.udt = UDT_NUM;
	var.num = call[0].getNum() - call[1].getNum();
}

void operators::add_assign(CALL_DATA &call)
{
	call.ret().udt = UDT_ID;
	call.ret().lit = call[0].lit;
	STACK_FRAME &var = *call.prg->getVar(call.ret().lit);
	if ((call[0].getType() & UDT_NUM) && (call[1].getType() & UDT_NUM))
	{
		var.udt = UDT_NUM;
		var.num = call[0].getNum() + call[1].getNum();
	}
	else
	{
		var.udt = UDT_LIT;
		var.lit = call[0].getLit() + call[1].getLit();
	}
}

void operators::mod_assign(CALL_DATA &call)
{
	call.ret().udt = UDT_ID;
	call.ret().lit = call[0].lit;
	STACK_FRAME &var = *call.prg->getVar(call.ret().lit);
	var.udt = UDT_NUM;
	var.num = int(call[0].getNum()) % int(call[1].getNum());
}

void operators::div_assign(CALL_DATA &call)
{
	call.ret().udt = UDT_ID;
	call.ret().lit = call[0].lit;
	STACK_FRAME &var = *call.prg->getVar(call.ret().lit);
	var.udt = UDT_NUM;
	var.num = call[0].getNum() / call[1].getNum();
}

void operators::mul_assign(CALL_DATA &call)
{
	call.ret().udt = UDT_ID;
	call.ret().lit = call[0].lit;
	STACK_FRAME &var = *call.prg->getVar(call.ret().lit);
	var.udt = UDT_NUM;
	var.num = call[0].getNum() * call[1].getNum();
}

void operators::pow_assign(CALL_DATA &call)
{
	call.ret().udt = UDT_ID;
	call.ret().lit = call[0].lit;
	STACK_FRAME &var = *call.prg->getVar(call.ret().lit);
	var.udt = UDT_NUM;
	var.num = ::pow(call[0].getNum(), call[1].getNum());
}

void operators::lor_assign(CALL_DATA &call)
{
	call.ret().udt = UDT_ID;
	call.ret().lit = call[0].lit;
	STACK_FRAME &var = *call.prg->getVar(call.ret().lit);
	var.udt = UDT_NUM;
	var.num = call[0].getNum() || call[1].getNum();
}

void operators::land_assign(CALL_DATA &call)
{
	call.ret().udt = UDT_ID;
	call.ret().lit = call[0].lit;
	STACK_FRAME &var = *call.prg->getVar(call.ret().lit);
	var.udt = UDT_NUM;
	var.num = call[0].getNum() && call[1].getNum();
}

void operators::prefixIncrement(CALL_DATA &call)
{
	call.ret().udt = UDT_ID;
	call.ret().lit = call[0].lit;
	STACK_FRAME &var = *call.prg->getVar(call.ret().lit);
	var.udt = UDT_NUM;
	var.num = call[0].getNum() + 1;
}

void operators::postfixIncrement(CALL_DATA &call)
{
	call.ret().udt = UDT_NUM;
	call.ret().num = call[0].getNum();

	STACK_FRAME &var = *call.prg->getVar(call[0].lit);
	var.udt = UDT_NUM;
	var.num = call[0].getNum() + 1;
}

void operators::prefixDecrement(CALL_DATA &call)
{
	call.ret().udt = UDT_ID;
	call.ret().lit = call[0].lit;
	STACK_FRAME &var = *call.prg->getVar(call.ret().lit);
	var.udt = UDT_NUM;
	var.num = call[0].getNum() - 1;
}

void operators::postfixDecrement(CALL_DATA &call)
{
	call.ret().udt = UDT_NUM;
	call.ret().num = call[0].getNum();

	STACK_FRAME &var = *call.prg->getVar(call[0].lit);
	var.udt = UDT_NUM;
	var.num = call[0].getNum() - 1;
}

void operators::unaryNegation(CALL_DATA &call)
{
	call.ret().udt = UDT_NUM;
	call.ret().num = -call[0].getNum();
}

void operators::lnot(CALL_DATA &call)
{
	call.ret().udt = UDT_NUM;
	call.ret().num = !call[0].getNum();
}

void operators::tertiary(CALL_DATA &call)
{
	call.ret() = call[0].getNum() ? call[1].getValue() : call[2].getValue();
}

void operators::member(CALL_DATA &call)
{
	if (!(call[0].getType() & UDT_OBJ))
	{
		throw CError("Invalid object.");
	}

	unsigned int obj = (unsigned int)call[0].getNum();
	const std::string type = CProgram::m_objects[obj];
	std::map<std::string, tagClass>::const_iterator i = call.prg->m_classes.find(type);
	if (i == call.prg->m_classes.end())
	{
		throw CError("Could not find class " + type + ".");
	}

	const CLASS_VISIBILITY cv = (call.prg->m_calls.size() && (CProgram::m_objects[call.prg->m_calls.back().obj] == type)) ? CV_PRIVATE : CV_PUBLIC;
	const std::string mem = call[1].lit;
	if (i->second.memberExists(mem, cv))
	{
		char str[255];
		itoa(obj, str, 10);
		call.ret().udt = UDT_ID;
		call.ret().lit = std::string(str) + "::" + mem;
	}
	else
	{
		throw CError("Class " + type + " has no accessible " + mem + " member.");
	}
}

void operators::array(CALL_DATA &call)
{
	call.ret().udt = UDT_ID;
	call.ret().lit = call[0].lit + '[';
	if (call[1].getType() == UDT_NUM)
	{
		call.ret().lit += call[1].getLit();
	}
	else
	{
		call.ret().lit += '"' + call[1].getLit() + '"';
	}
	call.ret().lit += ']';
}

// If...else control structure.
void CProgram::conditional(CALL_DATA &call)
{
	if (call[0].getNum()) return;
	CONST_POS close = call.prg->m_units.begin() + (int)(call.prg->m_i + 1)->num;
	if ((close != call.prg->m_units.end()) && ((close + 1)->udt & UDT_FUNC) && ((close + 1)->func == skipElse))
	{
		// Set the current unit to the else so that it is not
		// executed in CProgram::run(). Execution would cause
		// the else clause to be skipped.
		call.prg->m_i = close + 1;
	}
	else
	{
		call.prg->m_i = close;
	}
}

// Skip an else block.
void CProgram::skipElse(CALL_DATA &call)
{
	call.prg->m_i = call.prg->m_units.begin() + (int)(call.prg->m_i + 1)->num;
}

// Skip a method block.
void CProgram::skipMethod(CALL_DATA &call)
{
	call.prg->m_i = call.prg->m_units.begin() + (int)(call.prg->m_i + 1)->num;
}

// Skip a class block.
void CProgram::skipClass(CALL_DATA &call)
{
	call.prg->m_i = call.prg->m_units.begin() + (int)(call.prg->m_i + 1)->num;
}

// While loop.
void CProgram::whileLoop(CALL_DATA &call)
{
	if (call[0].getNum()) return;
	call.prg->m_i = call.prg->m_units.begin() + (int)(call.prg->m_i + 1)->num;
}

// Until loop.
void CProgram::untilLoop(CALL_DATA &call)
{
	if (!call[0].getNum()) return;
	call.prg->m_i = call.prg->m_units.begin() + (int)(call.prg->m_i + 1)->num;
}

// For loop.
void CProgram::forLoop(CALL_DATA &call)
{
	if (call[0].getNum()) return;
	call.prg->m_i = call.prg->m_units.begin() + (int)(call.prg->m_i + 1)->num;
}

// Create an object.
void CProgram::classFactory(CALL_DATA &call)
{
	const std::string cls = call[0].lit;
	const LPCLASS pClass = &call.prg->m_classes[cls];

	unsigned int obj = m_objects.size() + 1;
	while (m_objects.count(obj)) ++obj;
	m_objects.insert(std::map<unsigned int, std::string>::value_type(obj, cls));

	call.ret().udt = UNIT_DATA_TYPE(UDT_OBJ | UDT_NUM);
	call.ret().num = obj;
}

void CProgram::initialize()
{
	// Operators.
	addFunction("+", operators::add);
	addFunction("-", operators::sub);
	addFunction("*", operators::mul);
	addFunction("|", operators::bor);
	addFunction("`", operators::bxor);
	addFunction("&", operators::band);
	addFunction("||", operators::lor);
	addFunction("&&", operators::land);
	addFunction("!=", operators::ieq);
	addFunction("==", operators::eq);
	addFunction(">=", operators::gte);
	addFunction("<=", operators::lte);
	addFunction(">", operators::gt);
	addFunction("<", operators::lt);
	addFunction(">>", operators::rs);
	addFunction("<<", operators::ls);
	addFunction("%", operators::mod);
	addFunction("/", operators::div);
	addFunction("^", operators::pow);
	addFunction("=", operators::assign);
	addFunction("`=", operators::xor_assign);
	addFunction("|=", operators::or_assign);
	addFunction("&=", operators::and_assign);
	addFunction(">>=", operators::rs_assign);
	addFunction("<<=", operators::ls_assign);
	addFunction("-=", operators::sub_assign);
	addFunction("+=", operators::add_assign);
	addFunction("%=", operators::mod_assign);
	addFunction("/=", operators::div_assign);
	addFunction("*=", operators::mul_assign);
	addFunction("^=", operators::pow_assign);
	addFunction("||=", operators::lor_assign);
	addFunction("&&=", operators::land_assign);
	addFunction("[]", operators::array);
	addFunction("++i", operators::prefixIncrement);
	addFunction("i++", operators::postfixIncrement);
	addFunction("--i", operators::prefixDecrement);
	addFunction("i--", operators::postfixDecrement);
	addFunction("-i", operators::unaryNegation);
	addFunction("!", operators::lnot);
	addFunction("?:", operators::tertiary);
	addFunction("->", operators::member);

	// Reserved.
	addFunction("method a", skipMethod);
	addFunction("method b", methodCall);
	addFunction("class a", skipClass);
	addFunction("class b", classFactory);
	addFunction("if", conditional);
	addFunction("else", skipElse);
	addFunction("elseif", elseIf);
	addFunction("while", whileLoop);
	addFunction("until", untilLoop);
	addFunction("for", forLoop);
	addFunction("return", returnVal);
}

/*
 * All contents copyright 2005, Colin James Fitzpatrick.
 * All rights reserved. You may not remove this notice.
 * Read license.txt for licensing details.
 */

/*
 * Implementation of a program.
 */

/*
 * Inclusions.
 */
#include "CProgram.h"
#include "../parser/parser.h"
#include <fstream>
#include <math.h>

/*
 * Definitions.
 */
#define STACK_RETURN "__return__value__"	// Position for return value on stack.

/*
 * Static member initialization.
 */
std::map<std::string, CProgram::INTERNAL_FUNCTION> CProgram::m_functions;
CProgram::STACK_FRAME CProgram::m_global;
CProgram *CProgram::m_currentProgram = NULL;
std::vector<CPlugin *> CProgram::m_plugins;
const int CProgram::tagClass::PUBLIC = 0;
const int CProgram::tagClass::PRIVATE = 1;

/*
 * Independently run a line.
 *
 * str (in) - line to run
 */
void CProgram::runLine(const std::string str)
{
	VECTOR_STR lines;
	bool bComment = false;
	breakString(str, bComment, lines);
	run(lines);
}

/*
 * Add a plugin.
 */
CPlugin *CProgram::addPlugin(const std::string file)
{
	const int backslash = file.find_last_of('\\') + 1;
	const std::string name = file.substr(backslash, file.length() - (4 + backslash));
	if (name.empty()) return NULL;

	HMODULE mod = LoadLibrary(file.c_str());
	if (!mod)
	{
		MessageBox(NULL, ("The file " + file + " is not a valid dynamically linkable library.").c_str(), "Plugin Error", 0);
		return NULL;
	}

	FARPROC pReg = GetProcAddress(mod, "DllRegisterServer");
	if (!pReg)
	{
		MessageBox(NULL, ("The plugin " + file + " has no registration function.").c_str(), "Plugin Error", 0);
		FreeLibrary(mod);
		return NULL;
	}

	if (FAILED(((HRESULT (__stdcall *)(void))pReg)()))
	{
		MessageBox(NULL, ("An error occurred while registering " + file + ".").c_str(), "Plugin Error", 0);
		FreeLibrary(mod);
		return NULL;
	}

	FreeLibrary(mod);

	CPlugin *p = new CPlugin();
	if (!p->load(stringCast(name + ".cls" + name)))
	{
		MessageBox(NULL, ("A remotable class was not found in " + file + ".").c_str(), "Plugin Error", 0);
		delete p;
		return NULL;
	}

	p->initialize();
	m_plugins.push_back(p);
	return p;

}

/*
 * Free plugins.
 */
void CProgram::freePlugins(void)
{
	std::vector<CPlugin *>::iterator i = m_plugins.begin();
	for (; i != m_plugins.end(); ++i)
	{
		(*i)->terminate();
		delete *i;
	}
	m_plugins.clear();
}

/*
 * Add an internal function.
 *
 * str (in) - name of function
 * func (in) - address of function
 */
void CProgram::addFunction(const std::string str, const INTERNAL_FUNCTION func)
{
	m_functions[parser::uppercase(str)] = func;
}

/*
 * Run the program.
 *
 * return (out) - program exit return
 */
CVariant CProgram::run(void)
{
	extern void programInit(void);
	programInit();
	m_stack.push_back(STACK_FRAME());
	run(m_lines);
	STACK_FRAME &frame = m_stack.back();
	const CVariant toRet = (frame.count(STACK_RETURN) ? frame[STACK_RETURN] : 0.0);
	m_stack.pop_back();
	extern void programFinish(void);
	programFinish();
	return toRet;
}

/*
 * Construct a variant of the correct type from a string.
 *
 * str (in) - string to construct from
 * bFromVar (out) - constructed from a variable?
 * return (out) - the variant
 */
CVariant CProgram::constructVariant(const std::string str, bool *bFromVar)
{
	/*
	 * Check if it's a number.
	 */
	if (str == "0") return 0.0;
	const double num = atof(str.c_str());
	if (num) return num;
	/*
	 * Strip off negative sign and pre/post decrement and increment operators.
	 */
	const int len = str.length();
	const char cUnary = str[0];
	const bool bNegate = (cUnary == '-');
	const bool bComplement = (cUnary == '~');
	const bool bInvert = (cUnary == '!');
	const bool bUnary = (bNegate || bComplement || bInvert);
	const std::string strPre = str.substr(bUnary ? 1 : 0, 2);
	const bool bPre = (strPre == "++" || strPre == "--");
	const int postStart = len - 2;
	const std::string strPost = (postStart > 0) ? str.substr(postStart, 2) : "";
	const bool bPost = (strPost == "++" || strPost == "--");
	const int start = (bUnary ? 1 : 0) + (bPre ? 2 : 0);
	const std::string var = parser::uppercase(str.substr(start, len - start - (bPost ? 2 : 0)));
	/*
	 * Check if it's a variable.
	 */
	STACK_FRAME &frame = m_stack.back();
	if (m_stack.size() && frame.count(var))
	{
		/*
		 * Return the variable's value.
		 */
		if (bPre)
		{
			if (strPre == "++") frame[var] = frame[var].getNum() + 1;
			else if (strPre == "--") frame[var] = frame[var].getNum() - 1;
		}
		const CVariant toRet = (bNegate ? -frame[var].getNum() : (bComplement ? ~int(frame[var].getNum()) : (bInvert ? !frame[var].getNum() : frame[var])));
		if (bPost)
		{
			if (strPost == "++") frame[var] = frame[var].getNum() + 1;
			else if (strPost == "--") frame[var] = frame[var].getNum() - 1;
		}
		if (bFromVar && !bUnary) *bFromVar = true;
		return toRet;
	}
	else if (m_global.count(var))
	{
		/*
		 * Found it in the global scope.
		 */
		if (bPre)
		{
			if (strPre == "++") m_global[var] = m_global[var].getNum() + 1;
			else if (strPre == "--") m_global[var] = m_global[var].getNum() - 1;
		}
		const CVariant toRet = (bNegate ? -m_global[var].getNum() : (bComplement ? ~int(m_global[var].getNum()) : (bInvert ? !m_global[var].getNum() : m_global[var])));
		if (bPost)
		{
			if (strPost == "++") m_global[var] = m_global[var].getNum() + 1;
			else if (strPost == "--") m_global[var] = m_global[var].getNum() - 1;
		}
		if (bFromVar && !bUnary) *bFromVar = true;
		return toRet;
	}
	/*
	 * It's a string.
	 */
	if (str[0] == '"')
	{
		return str.substr(1, len - 2);
	}
	return str;
}

/*
 * Parse an array.
 */
std::string CProgram::parseArray(const std::string str)
{
	const int pos = str.find('[');
	if (pos == std::string::npos) return str;
	std::string toRet = str.substr(0, pos);
	bool ignore = false;
	int open = 0, close = 0;
	for (unsigned int i = pos; i < str.length(); i++)
	{
		if (str[i] == '"') ignore = !ignore;
		else if (!ignore)
		{
			if (str[i] == '[')
			{
				open = i;
			}
			else if (str[i] == ']')
			{
				toRet += '[' + evaluate(str.substr(open + 1, i - open)).getLit().c_str() + ']';
				close = i;
			}
		}
	}
	if (close != str.length())
	{
		toRet += str.substr(close + 1);
	}
	return toRet;
}

/*
 * Break a string into multiple lines.
 *
 * if (x) { func(x); foo(x); }
 *
 * ...becomes:
 *
 * if (x)
 * {
 * func(x)
 * foo(x)
 * }
 *
 * str (in) - string to break
 * bComment (in + out) - whether the line is within a comment
 * lines (out) - resulting lines
 */
void CProgram::breakString(const std::string str, bool &bComment, VECTOR_STR &lines)
{
	/*
	 * Initialize.
	 */ 
	std::string push = parser::trim(str);
	if (push[0] == '*') return;
	else if (push[0] == '#') push = push.substr(1);
	const int len = push.length();
	bool bIgnore = false, bSingleLine = false;
	int bracketDepth = 0, lastPush = 0;
	const int chars = len - 1;
	/*
	 * Loop over the string.
	 */
	for (int i = 0; i < len; i++)
	{
		if (push[i] == '"' && !bComment) bIgnore = !bIgnore;
		else if (!bIgnore)
		{
			if (!bComment)
			{
				if (push[i] == '(') bracketDepth++;
				else if (push[i] == ')') bracketDepth--;
				else if (push[i] == ';')
				{
					if (bracketDepth != 0)
					{
						push[i] = ',';
					}
					else
					{
						if (!bSingleLine)
						{
							lines.push_back(parser::trim(push.substr(lastPush, i - lastPush)));
						}
						else bSingleLine = false;
						lastPush = i + 1;
					}
				}
				else if (push[i] == '{' || push[i] == '}')
				{
					if (!bSingleLine)
					{
						lines.push_back(parser::trim(push.substr(lastPush, i - lastPush)));
						const char str[] = {push[i], '\0'};
						lines.push_back(str);
					}
					else bSingleLine = false;
					lastPush = i + 1;
				}
				else if (push[i] == '/' && i != chars)
				{
					const char symbol = push[i + 1];
					if (symbol == '*')
					{
						bComment = true;
					}
					else if (symbol == '/')
					{
						bSingleLine = true;
					}
					if (bComment || bSingleLine)
					{
						lines.push_back(parser::trim(push.substr(lastPush, i - lastPush)));
						lastPush = i + 1;
					}
				}
			}
			else if (push[i] == '*' && i != chars && push[i + 1] == '/')
			{
				bComment = false;
				lastPush = i + 1;
			}
		}
	}
	if (!bComment && !bSingleLine && lastPush != len)
	{
		/*
		 * Push on anything that's left.
		 */
		lines.push_back(parser::trim(push.substr(lastPush)));
	}
}

/*
 * Open a program.
 *
 * file (in) - file to open
 */
void CProgram::open(const std::string file)
{
	m_lines.clear();
	m_methods.clear();
	std::fstream fs;
	fs.open(file.c_str(), std::ios_base::in);
	if (!fs.is_open()) return;
	VECTOR_STR *stream = &m_lines;
	std::map<std::string, METHOD> *methodStream = &m_methods;
	CLASS *cls = NULL;
	CLASS::SCOPE *clsScope = NULL;
	int depth = 0;
	bool bComment = false;
	while (!fs.eof())
	{
		char str[255];
		fs.getline(str, 255);
		VECTOR_STR parts;
		breakString(str, bComment, parts);
		const int size = parts.size();
		for (int i = 0; i < size; i++)
		{
			const std::string push = parts[i];
			const std::string ucase = parser::uppercase(push);
			if (ucase.compare(0, 6, "METHOD") == 0)
			{
				/*
				 * Save this method.
				 */
				const int bracket = push.find('(');
				const int pushLen = push.length();
				const std::string name = parser::uppercase(push.substr(7, ((bracket != std::string::npos) ? bracket : pushLen) - 7));
				(*methodStream)[name] = METHOD();
				METHOD &method = (*methodStream)[name];
				method.name = name;
				const std::string centerStr = push.substr(0, pushLen - 1);
				int pos = bracket + 1;
				const int centerLen = centerStr.length();
				do
				{
					const int start = pos;
					pos = centerStr.find(',', pos + 1);
					const std::string push = parser::uppercase(parser::trim(centerStr.substr(start, ((pos != std::string::npos) ? pos : centerLen) - start)));
					if ((method.params.size() == 0) && parser::trim(push).empty()) break;
					method.params.push_back(push);
				} while (pos++ != std::string::npos);
				stream = &method.lines;
			}
			else if (ucase.compare(0, 5, "CLASS") == 0)
			{
				const std::string chunk = push.substr(6);
				const int colon = chunk.find(':');
				const std::string name = parser::uppercase(parser::trim((colon != std::string::npos) ? chunk.substr(0, colon) : chunk));
				m_classes[name] = CLASS();
				cls = &m_classes[name];
				clsScope = &cls->scopes[CLASS::PRIVATE];
				methodStream = &clsScope->m_methods;
				stream = NULL;
				continue;
			}
			else if (!push.empty())
			{
				if (stream) stream->push_back(push);
			}
			else
			{
				continue;
			}
			if (push == "{")
			{
				depth++;
			}
			else if (push == "}")
			{
				depth--;
				if (cls)
				{
					if (depth == 1)
					{
						stream = NULL;
					}
					else if (depth == 0)
					{
						stream = &m_lines;
						methodStream = &m_methods;
						cls = NULL;
					}
				}
				else
				{
					if (depth == 0)
					{
						stream = &m_lines;
					}
				}
			}
			else if (push == "public:")
			{
				clsScope = &cls->scopes[CLASS::PUBLIC];
				methodStream = &clsScope->m_methods;
			}
			else if (push == "private:")
			{
				clsScope = &cls->scopes[CLASS::PRIVATE];
				methodStream = &clsScope->m_methods;
			}
			else if (!stream)
			{
				/*
				 * Member variable here.
				 */
				clsScope->m_members[push] = CVariant();
			}
		}
	}
	fs.close();
}

/*
 * Determine whether a 'function' is really a construct.
 *
 * str (in) - string to check
 * return (out) - result
 */
static inline bool isConstruct(const std::string &str)
{
	const std::string ucase = parser::uppercase(str);
	return (ucase == "FOR" || ucase == "WHILE" || ucase == "UNTIL");
}

/*
 * Run a block of code.
 *
 * bRun (in) - run?
 */
void CProgram::runBlock(const bool bRun)
{
	const VECTOR_STR &lines = *m_process;
	const int len = lines.size() - 1;
	int depth = 0;
	while (m_currentLine++ != len)
	{
		const std::string &str = lines[m_currentLine];
		if (str == "{")
		{
			depth++;
		}
		else if (str == "}")
		{
			if (--depth == 0)
			{
				break;
			}
		}
		else if (bRun)
		{
			processEvent();
			evaluate(str);
		}
	}
}

/*
 * Call a function from a METHOD object.
 *
 * method (in) - method to call
 * params (in) - parameters to pass
 * return (out) - return value
 */
CVariant CProgram::callFunction(const METHOD &method, PARAMETERS params)
{
	if (method.func)
	{
		/*
		 * Call this internal function.
		 */
		return method.func(params, this);
	}
	/*
	 * Push the parameters onto the stack.
	 */
	const int len = method.params.size();
	if (len != params.size())
	{
		/*
		 * Incorrect number of paramters.
		 */
		debugger("Error: Function " + method.name + "() requires " + CVariant(len).getLit() + " parameters!");
		return CVariant();
	}
	m_this.push(NULL);
	m_stack.push_back(STACK_FRAME());
	STACK_FRAME &frame = m_stack.back();
	for (int i = 0; i < len; i++)
	{
		frame[method.params[i]] = params[i];
	}
	/*
	 * Call the method.
	 */
	run(method.lines);
	STACK_FRAME &back = m_stack.back();
	const CVariant toRet = (back.count(STACK_RETURN) ? back[STACK_RETURN] : 0.0);
	/*
	 * Clean up.
	 */
	m_stack.pop_back();
	m_this.pop();
	/*
	 * Return the result.
	 */
	return toRet;
}

/*
 * Call a function.
 *
 * funcName (in) - function to call
 * params (in) - vector of parameters to pass
 * return (out) - return value
 */
CVariant CProgram::callFunction(const std::string funcName, PARAMETERS params)
{
	const std::string ucase = parser::uppercase(funcName);
	/*
	 * If keyword.
	 */
	if (ucase == "IF")
	{
		runBlock(params[0].getNum() != 0);
	}
	/*
	 * While keyword.
	 */
	else if (ucase == "WHILE")
	{
		const int line = m_currentLine;
		const std::string &str = params[0].getLit();
		while (evaluate(str).getNum() != 0)
		{
			m_currentLine = line;
			runBlock(true);
		}
	}
	/*
	 * Until keyword.
	 */
	else if (ucase == "UNTIL")
	{
		const int line = m_currentLine;
		const std::string &str = params[0].getLit();
		while (evaluate(str).getNum() == 0)
		{
			m_currentLine = line;
			runBlock(true);
		}
	}
	/*
	 * For keyword.
	 */
	else if (ucase == "FOR")
	{
		/*
		 * Save paramters.
		 */
		const std::string &condition = params[1].getLit();
		const std::string &increment = params[2].getLit();
		/*
		 * Initial statement.
		 */
		evaluate(params[0].getLit());
		const int line = m_currentLine;
		/*
		 * Enter the loop.
		 */
		while (evaluate(condition).getNum() != 0)
		{
			m_currentLine = line;
			runBlock(true);
			/*
			 * And increment.
			 */
			evaluate(increment);
		}
	}
	/*
	 * Return a value.
	 */
	else if (ucase == "RETURN")
	{
		if (params.size() != 1)
		{
			debugger("Error: return() requires one parameter!");
			return CVariant();
		}
		m_stack.back()[STACK_RETURN] = params[0];
	}
	/*
	 * Check internal functions.
	 */
	else if (m_functions.count(ucase))
	{
		/*
		 * Call this function.
		 */
		m_currentProgram = this;
		return m_functions[ucase](params, this);
	}
	/*
	 * Check for a class.
	 */
	else if (m_classes.count(ucase))
	{
		CLASS *const p = new CLASS(m_classes[ucase]);
		m_objects.push_back(p);
		return p;
	}
	else
	{
		/*
		 * Call this method, if it exists.
		 */
		if (m_methods.count(ucase))
		{
			return callFunction(m_methods[ucase], params);
		}
		else
		{
			debugger("Error: Function " + funcName + "() not found!");
		}
	}
	return CVariant();
}

/*
 * Set a variable.
 */
void CProgram::setVariable(const std::string name, const CVariant value)
{
	const std::string ucase = parseArray(parser::uppercase(name));
	STACK_FRAME &frame = m_stack.back().count(ucase) ? m_stack.back() : m_global;
	frame[ucase] = value;
}

/*
 * Set a global.
 */
void CProgram::setGlobal(const std::string name, const CVariant value)
{
	m_global[CProgram().parseArray(parser::uppercase(name))] = value;
}

/*
 * Get a global.
 */
CVariant CProgram::getGlobal(const std::string name)
{
	const std::string ucase = CProgram().parseArray(parser::uppercase(name));
	return (m_global.count(ucase) ? m_global[ucase] : CVariant());
}

/*
 * Evaluate a string.
 *
 * str (in) - string to evaluate
 * return (out) - result of evaluation
 */
CVariant CProgram::evaluate(const std::string str)
{
	/*
	 * Tokenize the string.
	 */
	std::vector<std::string> tokens;
	std::string delimiterStr;
	std::vector<int> positions;
	parser::getTokenList(str, tokens, delimiterStr, positions);
	const int strLen = str.length();
	/*
	 * Look for the closing bracket of a function.
	 */
	const int len = delimiterStr.length();
	const int bracketPos = delimiterStr.find(')');
	if (bracketPos != std::string::npos)
	{
		/*
		 * Find the opening bracket.
		 */
		int depth = 0, opening = std::string::npos, openingIdx = std::string::npos;
		for (int i = bracketPos - 1; i >= 0; i--)
		{
			const char chr = delimiterStr[i];
			if (chr == ')') depth++;
			else if (chr == '(' && depth-- == 0)
			{
				/*
				 * This is it!
				 */
				opening = positions[openingIdx = i];
				break;
			}
		}
		/*
		 * Get the function's name.
		 */
		const int startPos = ((openingIdx != 0) ? (positions[openingIdx - 1] + 1) : 0);
		const int endPos = positions[openingIdx];
		const std::string funcName = parser::trim(str.substr(startPos, endPos - startPos));
		if (bracketPos == std::string::npos)
		{
			/*
			 * Syntax error.
			 */
			debugger("Syntax error!");
			return CVariant();
		}
		/*
		 * Handle the function.
		 */
		const bool bNegate = (funcName[0] == '-');
		const bool bFunction = (funcName != "");
		const int centerBegin = startPos + (bFunction ? 0 : 2) + (bNegate ? 1 : 0);
		const std::string centerStr = str.substr(centerBegin, positions[bracketPos] - centerBegin);
		CVariant var;
		if (bFunction)
		{
			/*
			 * Call this function.
			 */
			bool bPlugin = false;
			const bool bIsConstruct = isConstruct(funcName);
			const std::string sansNeg = bNegate ? funcName.substr(1) : funcName;
			if (!bIsConstruct)
			{
				// Before we do anything complex, see whether we can
				// find this function in a plugin.

				// Convert the function name to lowercase UNICODE.
				wchar_t *unicode = _wcslwr(_wcsdup(stringCast(sansNeg).c_str()));
				const std::wstring lcase = unicode;
				free(unicode);

				// Iterate over all the plugins.
				std::vector<CPlugin *>::iterator i = m_plugins.begin();
				for (; i != m_plugins.end(); ++i)
				{
					// Query this one.
					if ((*i)->query(lcase))
					{
						// Call it and break.
						int dt = -1; std::wstring lit; double num = 0.0;
						(*i)->execute(stringCast(centerStr), dt, lit, num, VARIANT_TRUE);
						if ((dt == PLUG_DT_LIT) || (dt == PLUG_DT_VOID))
						{
							var = '"' + stringCast(lit) + '"';
						}
						else
						{
							var = num;
						}
						bPlugin = true;
						break;
					}
				}
			}
			if (!bPlugin)
			{
				std::vector<CVariant> params;
				int pos = centerStr.find('(') + 1;
				const int centerLen = centerStr.length();
				do
				{
					const int start = pos;
					pos = centerStr.find(',', pos + 1);
					const std::string push = centerStr.substr(start, ((pos != std::string::npos) ? pos : centerLen) - start);
					if ((params.size() == 0) && parser::trim(push).empty()) break;
					if (bIsConstruct)
					{
						params.push_back(push);
					}
					else
					{
						params.push_back(evaluate(push));
					}
				} while (pos++ != std::string::npos);
				var = callFunction(sansNeg, params);
				const CVariant::DATA_TYPE dt = var.getType();
				if (dt == CVariant::DT_LIT || dt == CVariant::DT_NULL)
				{
					var = '"' + var.getLit() + '"';
				}
			}
		}
		else
		{
			/*
			 * Operations given precedence--recurse.
			 */
			var = evaluate(centerStr);
		}
		/*
		 * Recurse!
		 */
		std::string content = "";
		if (var.getType() == CVariant::DT_NUM)
		{
			char conv[255];
			gcvt(bNegate ? -var.getNum() : var.getNum(), 255, conv);
			char &chr = conv[strlen(conv) - 1];
			if (chr == '.') chr = '\0';
			content = conv;
		}
		else
		{
			content = var.getLit();
		}
		return evaluate(str.substr(0, startPos) + content + ((positions[bracketPos] != strLen) ? str.substr(positions[bracketPos] + 1) : ""));
	}
	/*
	 * Now there's just a simple expression with numbers
	 * and/or variables remaining of this line.
	 */
	const std::string operators[] = {
		"^",
		"*",
		"/",
		"%",
		"+",
		"-",
		"<<",
		">>",
		"<",
		">",
		"<=",
		">=",
		"==",
		"~=",
		"&",
		"`",
		"|",
		"&&",
		"||",
		"=",
		"^=",
		"*=",
		"/=",
		"%=",
		"+=",
		"~=",
		// "<<=",
		// ">>=",
		"&=",
		"|=",
		"`="
	};
	for (int j = 0; j < 28; j++)
	{
		const std::string &op = operators[j];
		const int opLen = op.length();
		const int pos = delimiterStr.find(op);
		if (pos != std::string::npos)
		{
			if ((pos != len) && (opLen == 1) && (str[positions[pos]] == str[positions[pos + 1]]))
			{
				// This is actually part of a larger operator.
				continue;
			}
			const std::string tokenA = parser::trim(tokens[pos]);
			const std::string tokenB = parser::trim(tokens[pos + opLen]);
			const CVariant right = constructVariant(parseArray(tokenB));
			std::string strVal = "";
			if ((op[opLen - 1] != '=') || (op == "=="))
			{
				bool bFromVar = false;
				const CVariant left = constructVariant(parseArray(tokenA), &bFromVar);
				if ((op != "+") || (left.getType() == CVariant::DT_NUM && right.getType() == CVariant::DT_NUM))
				{
					/*
					 * Both operands are numerical.
					 */
					double val = 0.0;
					if (op == "==")
					{
						val = left.getLit() == right.getLit();
					}
					else if (op == "!=" || op == "~=")
					{
						val = left.getLit() != right.getLit();
					}
					else
					{
						const double lhs = left.getNum();
						const double rhs = right.getNum();
						if (op == "^") val = (!bFromVar && lhs < 0) ? -pow(-lhs, rhs) : pow(lhs, rhs);
						else if (op == "*") val = lhs * rhs;
						else if (op == "/") val = lhs / rhs;
						else if (op == "%") val = int(lhs) % int(rhs);
						else if (op == "+") val = lhs + rhs;
						else if (op == "-") val = lhs - rhs;
						else if (op == "&") val = int(lhs) & int(rhs);
						else if (op == "|") val = int(lhs) | int(rhs);
						else if (op == "`") val = int(lhs) ^ int(rhs);
						else if (op == "<") val = lhs < rhs;
						else if (op == "<=") val = lhs <= rhs;
						else if (op == ">") val = lhs > rhs;
						else if (op == ">=") val = lhs >= rhs;
						else if (op == "&&") val = lhs && rhs;
						else if (op == "||") val = lhs || rhs;
						else if (op == "<<") val = int(lhs) << int(rhs);
						else if (op == ">>") val = int(lhs) >> int(rhs);
					}
					std::stringstream ss;
					ss << val;
					strVal = ss.str();
				}
				else
				{
					strVal = left.getLit() + right.getLit();
				}
			}
			else
			{
				const std::string ucase = parseArray(parser::uppercase(tokenA));
				STACK_FRAME &frame = (m_stack.size() && m_stack.back().count(ucase)) ? m_stack.back() : m_global;
				if (op == "=") frame[ucase] = right;
				else if (op == "+=")
				{
					const CVariant left = frame[ucase];
					if (left.getType() == CVariant::DT_NUM && right.getType() == CVariant::DT_NUM)
					{
						frame[ucase] = left.getNum() + right.getNum();
					}
					else
					{
						frame[ucase] = left.getLit() + right.getLit();
					}
				}
				else if (op == "-=") frame[ucase] = frame[ucase].getNum() - right.getNum();
				else if (op == "*=") frame[ucase] = frame[ucase].getNum() * right.getNum();
				else if (op == "/=") frame[ucase] = frame[ucase].getNum() / right.getNum();
				else if (op == "%=") frame[ucase] = int(frame[ucase].getNum()) % int(right.getNum());
				else if (op == "&=") frame[ucase] = int(frame[ucase].getNum()) & int(right.getNum());
				else if (op == "|=") frame[ucase] = int(frame[ucase].getNum()) | int(right.getNum());
				else if (op == "`=") frame[ucase] = int(frame[ucase].getNum()) ^ int(right.getNum());
				else if (op == "^=") frame[ucase] = pow(frame[ucase].getNum(), right.getNum());
				strVal = tokenA;
			}
			return evaluate(((pos != 0) ? (str.substr(0, positions[pos - 1] + 1)) : "") + strVal + str.substr((((pos + 1) != len) ? (positions[pos + 1] - 1) : strLen) + 1));
		}
	}
	return constructVariant(parseArray(parser::trim(str)));
}

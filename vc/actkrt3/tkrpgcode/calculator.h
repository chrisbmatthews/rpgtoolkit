
///////////////////////////////////////////////////////////
// Expression Calculator
// All Contents Copyright 2004, Simon Gomizelj
///////////////////////////////////////////////////////////
// Used under license
///////////////////////////////////////////////////////////

#ifndef EXPRESSION_CALCULATOR
#define EXPRESSION_CALCULATOR

#include <cstring>
#include <cmath>
#include <cstdlib>

const int MAX_SIZE = 80;        // Maximum equation length including '\0'
const int MAX_OP_SIZE = 9;      // Change to increase size of the operator
const double PI = 3.14159;
const double DEGTORAD = 57.295779;

class calculator
{
  private:
    
    void eat_spaces(char* str)
    {
      int i = 0, j = 0;
      while((*(str + i) = *(str + j++)) != '\0')   // Loop while not character
        if(*(str + i) != ' ') i++;
    }
    
    long double doOperation(char* op, long double value)
    {      
      if (!stricmp(op, "sin"))            return long double(sin(double(value)));
      else if (!stricmp(op, "sind"))      return long double(sin(double(value / DEGTORAD)));
      else if (!stricmp(op, "cos"))       return long double(cos(double(value)));
      else if (!stricmp(op, "cosd"))      return long double(cos(double(value / DEGTORAD)));
      else if (!stricmp(op, "tan"))       return long double(tan(double(value)));
      else if (!stricmp(op, "tand"))      return long double(tan(double(value / DEGTORAD)));
      else if (!stricmp(op, "sqrt"))      return long double(sqrt(double(value)));
      else if (!stricmp(op, "exp"))       return long double(exp(double(value)));
      else if (!stricmp(op, "log"))       return long double(log(double(value)));
      else if (!stricmp(op, "degtorad"))  return long double(double(value / DEGTORAD));
      else if (!stricmp(op, "radtodeg"))  return long double(double(value * DEGTORAD));
      else
      //cout << "Arrrgh!*#@! \'" << op << "\' is an unknown operation" << endl;
      
      return long double(0.0);
    }
    
    long double doConstant(char* op)
    {
		if (!stricmp(op, "pi")) return long double(PI);
		return long double(0.0);
    }  
    
    // Function to get the value of a term 
    long double term(char* str, int& index)
    {
      long double value = number(str, index);       // Somewhere to accumulate the result
      
      // Loop while there is a good operator
      while((*(str + index) == '*') || (*(str + index) == '/') || (*(str + index) == '^'))
      {
        if (*(str + index) == '*')        // Multiple value by the next number
          value *= number(str, ++index);
        else if (*(str + index) == '/')   // Divide value by the next number
          value /= number(str, ++index);
        else if (*(str + index) == '^')
          value = long double(pow((double)value, (double)number(str, ++index)));
      }
      return value;                       // Done so return what we have
    }
    
    // Function to recognized a number in a string
    long double number(char* str, int& index)
    {
      long double value = long double(0.0);                   // Store the numeric value
      
      char op[MAX_OP_SIZE] = {0};
      int ip = 0;
      while(isalpha(*(str + index)))
      op[ip++] = *(str + index++);
      op[ip] = '\0';
      	
      if(doConstant(op) != long double(0.0)) return doConstant(op);
      	
      if(*(str + index) == '(')           // Start of a parentheses
      {
        char* psubstr = extract(str, ++index);
        value = expr(psubstr);
        // If there is an operation saves
        if(op[0]) value = doOperation(op, value);
        
        delete [] psubstr;
        return value;
      }
      
      while(isdigit(*(str + index)))      // Loop accumulating leading digits
        value = 10 * value + (*(str + index++) - 48);
      	
      if(*(str + index) != '.')           // If not a decimal, return our number
      return value;
      	
      long double factor = long double(1.0);
      while(isdigit(*(str + (++index))))  // Loop as long as we have digits
      {
        factor *= long double(0.1);                 // Decrease the factor by a factor of 10
        value += (*(str + index) - 48) * factor;
      }
      
      return value;
    }
    
    // Function to extract a substring between parentheses
    char* extract(char* str, int& index)
    {
      char buffer[MAX_SIZE];              // Temporary soace for substring
      char* pstr = 0;                     // Pointer to new string for the return
      int numL = 0;                       // Count of left parentheses found
      int bufindex = index;               // Save starting value of index
      
      do
      {
        buffer[index - bufindex] = *(str + index);
        switch(buffer[index - bufindex])
        {
          case ')':
            if(numL == 0)
            {
              buffer[index - bufindex] = '\0';   // Replace ')' with '\0'
              ++index;
              pstr = new char[index - bufindex];
              if(!pstr)
              {
                //cout << "Memory allocation failed!" << flush;
                system("PAUSE");
                exit(1);
              }
              strcpy(pstr, buffer);   // Copy substring to new memory
              return pstr;            // Return the new memory
            }
            else
             	numL--;                 // Reduce the count of '(' to be matched
            break;
          case '(':
            numL++;                   // Increase the cout of '(' to be matched
          break;
        }  
      }while(*(str + index++) != '\0'); // Loop to prevent overrun at the end
	  return "";
    } 
    
    // Function to evaluate an arithmetic expression
    long double expr(char* str)
    {
      long double value = long double(0.0);                 // Store result here
      int index = 0;                    // Keep track of current character position
      
      value = long double(term(str, index));      // Get the first term
      
      for(;;)                           // Infinaite loop, all exits inside
      {
        switch(*(str + index++))        // Choose action based on current character
        {
          case '\0':                    // We're at the end of the string
            return value;               // Return what we got
            break;
          case '+':                     // + found so add in the next term
            value += term(str, index);
            break;
          case '-':                     // - found so subtract the next term
            value -= term(str, index);
            break;
          default:                      // ERROR: Unrecognized character!
            return value;
        }
      }
      return value;
    }
  		
  public:
	  long double calculator::solve(char* str) { eat_spaces(str); return expr(str); }
};

#endif
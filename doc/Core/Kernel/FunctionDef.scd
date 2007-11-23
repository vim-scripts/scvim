
FunctionDef

superclass: Object

FunctionDefs contain code which can be executed from a Function.

Accessing

Even though it is possible to change the values in the various arrays that define the FunctionDef,
you should not do it, unless you like to crash.

code

Get the byte code array.

prototypeFrame

Get the array of default values for argument and temporary variables.

context

Get the enclosing FunctionDef or Method.

argNames

Get the Array of Symbols of the argument names.

varNames

Get the Array of Symbols of the local variable names.

Utilities

dumpByteCodes

"Disassemble" and post the FunctionDef's byte code instructions to the text window.



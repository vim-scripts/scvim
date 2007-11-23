
Interpreter

superclass: Object

The interpreter defines a context in which interactive commands are compiled and executed.

In the interpreter, this refers to the interpreter itself, e.g.:

this.postln


Accessing

The interpreter defines instance variables 'a' through 'z' which are always available in the interpreter. By convention, the variable 's' is used to hold the default Server. Assigning another value to 's' may cause some of the examples in the documentation to fail.

clearAll

set the values of the variables 'a' through 'z' to nil.

(
x = 123;
x.postln;
this.clearAll;
x.postln;
)


Compile & Interpret

interpret(aString)

Compile and execute a String.

this.interpret("(123 + 4000).postln");

interpretPrint(aString)

Compile and execute a String, printing the result.

this.interpretPrint("123 + 4000");


compile(aString)

Compile a String and return a Function.

(
z = this.compile("(123 + 4000).postln");
z.postln;
z.value;
)

compileFile(pathName)

Reads the file at pathName, compiles it and returns a Function.
The file must contain a valid SuperCollider expression, naturally.
This will not compile class definitions, only expressions.

executeFile(pathName)

Reads the file at pathName, compiles it and executes it, returning the result.
The file must contain a valid SuperCollider expression, naturally.
This will not compile class definitions, only expressions.




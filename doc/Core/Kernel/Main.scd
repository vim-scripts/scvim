Process

superclass: Object

A Process is the runtime environment for the virtual machine and interpreter.
It has a subclass named Main which is where you should override the methods
of Process. There are two methods of interest. One is named 'startUp' and is 
called after the class library has been compiled. The other is named 'run' and
is called when the user chooses the Run menu command.

startUp

called after the class library has been compiled. Override this in class Main to do whatever you want.

run

called when the user chooses the Run menu command. Override this in class Main to do whatever you want.


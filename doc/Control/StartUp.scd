
StartUp			register functions to be evaluated after the startup is finished

Superclass: Object

StartUp allows you to register functions to perform an action after the library has been compiled, and after the startup file has run. This is used for creating SynthDef in the initClass function of class files in order to be able to make the synthdef directory customizable by the startup script.



Class Methods

*add(function)

Registers an function to be evaluated after startup is finished.

*remove(function)

Removes a function that was previously registered.

*run

runs the functions in order.




Examples

*initClass {
	StartUp.add {
		// something to do...
	}


}





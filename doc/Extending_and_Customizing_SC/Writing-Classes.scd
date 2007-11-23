
Writing SuperCollider Classes

For a basic tutorial on how standard object-orientated classes are composed, look elsewhere
http://www.google.com/search?q=oop+class+tutorial


Inheriting

	NewClass : SomeSuperclass {

	}


Without specifying a superclass, Object is assumed as the default superclass.

	NewClass { // : Object is implied

	}


Methods

class methods are specified with the asterix

	*classMethod { arg argument;
	
	}

	within the class method, the keyword
	
	this

	refers to the class. 

	A class in smalltalk is itself an object. It is an instance of Class.


instance methods are specified :

	instanceMethod { arg argument;
	
	}

	within the instance method, the keyword
	
	this

	refers to the instance.



to return from the method use ^ (caret)


	someMethod {
		^returnObject
	}


multiple exit points also possible :


	someMethod { arg aBoolean;
		if(aBoolean,{
			^someObject
		},{
			^someOtherObject
		})
	}


	if no ^ is specified, the method will return the instance.
	(and in the case of Class methods, will return the class)

	There is no such thing as returning void in Smalltalk.



New Instance creation

Object.new will return to you a new object.
when overiding the class method .new you must call the superclass, which in turn calls its superclass, up until Object.new is called and an object is actually created and its memory allocated.

	// this example adds no new functionality
	*new {
		^super.new
	}

	// this is a normal constructor method
	*new { arg arga,argb,argc;
		^super.new.init(arga,argb,argc)
	}
	init { arg arga,argb,argc;
	   // do initiation here
	}

In this case note that super.new called the method new on the superclass and returned a new object. subsequently we are calling the .init method on that object, which is an instance method.

Warning: if the superclass also happened to call super.new.init it will have expected to call the .init method defined in that class (the superclass), but instead the message .init will find the implementation of the class that the object actually is, which is our new subclass.  So you should use a unique methodname like myclassinit if this is likely to be a problem.


Over reliance on inheritance is usually a design flaw. Explore "object composition" rather than trying to obtain all your powers through inheritance. Is your "subclass" really some kind of "superclass" or are you just trying to swipe all of daddy's methods ? Do a websearch for Design Patterns.

Class variables are accessible within class methods and in any instance methods.

	classvar myClassvar;

	var myInstanceVar;


Overriding Methods (Overloading)

in order to change the behaviour of the superclass, often methods are overridden.
note that an object looks always for the method it has defined first and then looks in the superclass.
here NewClass.value(2) will return 6, not 4:

	Superclass {
	
		calculate { arg in; in * 2 }
		value { arg in; ^this.calculate(in) }
	}
	
	NewClass : Superclass {
	
		calculate { arg in; in * 3 }
	}



if the method of the superclass is needed, it can be called by super.

	Superclass {
		var x;
		
		init {
			 x = 5;
		}
	}
	
	NewClass : Superclass {
		var y;
		init {
			super.init;
			y = 6;
		}
	}




Getter Setter

Classic Smalltalk demands that variables are not accessible outside of the class or instance. A method must be added to explicitly give access:

	
	NewClass : Superclass {
	
		var myVariable;
	
		variable {
			^myVariable
		}
	
		variable_ { arg newValue;
			myVariable = newValue;
		}
	}

These are referred to as getter and setter methods.

SC allows these methods to be easily added by adding < or >

	var <getMe, >setMe, <>getMeOrSetMe;


you now have the methods:

	someObject.getMe;

	someObject.setMe_(value);
	
this also allows us to say:

	someObject.setMe = value;

	someObject.getMeOrSetMe_(5);
	someObject.getMeOrSetMe.postln;



a getter or setter method created in this fashion may be overriden in a subclass by manually writing the method
setter methods should take only one argument to support both ways of expression consistantly.
eg.	
	variable_ { arg newValue; 
		variable = newValue.clip(minval,maxval);
	}




External Method Files

Methods may be added to Classes in separate files. This is equivalent to Protocols in Objective-C. By convention, the file name starts with a lower case letter: the name of the method or feature that the methods are supporting.

Syntax:

	+ Class {
		newMethod {
		
		}
		*newClassMethod {
		
		}
	}




Tricks and Traps

"Superclass not found..."

In one given code file, you can only put classes that inherit from each Object, each other, and one external class.  In other words, you can't inherit from two separate classes that are defined in separate files.

If you should happen to declare a variable in a subclass and use the same name as a variable declared in a superclass, you will find that both variables exist, but only the one in the object's actual class is accessible. You should not do that. This will at some point become an error worthy of compilation failure.

-felix, jrh



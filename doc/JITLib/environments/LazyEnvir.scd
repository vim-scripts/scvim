LazyEnvirlazy environment

superclass: EnvironmentRedirect

Environment with deferred evaluation and default values.


put(key, val) sets the value of the reference at key
at(key) returns a reference to the object at key. 
 If none is present, the default value is returned (integer 1)


Consequently, calculations can be done with nonexisting objects which can then be assigned later.


// examples

l = LazyEnvir.push;

// default objects are created on access
~a; 
~a.value; // defaults to 1

// operations on placeholders
(
~c = ~a + ~b;

~c.value; // defaults to 2.
)


// variables can be assigned later
(
~a = 800;
~b = { 1.0.rand };

~c.value; 
)


// variables can be exchanged later
(
~b = { 1000.rand }; 
~c.value; 
)



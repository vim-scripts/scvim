Object

superclass: nil

Object is the root class of all other classes. All objects are indirect instances of class Object.

Class membership:

class

Answer the class of the object.

5.class.name.postln;

respondsTo(selector)

Answer a Boolean whether the receiver understands the message selector. 
Selector must be a Symbol.

5.respondsTo('+').postln;

isKindOf(aClass)

Answer a Boolean whether the receiver is a direct or indirect instance of aClass.
Use of this message in code must be questioned, because it often indicates a missed
opportunity to exploit object polymorphism.

5.isKindOf(Magnitude).postln;

isMemberOf(aClass)

Answer a Boolean whether the receiver is a direct instance of aClass.
Use of this message in code is almost always a design mistake.

5.isMemberOf(Integer).postln;


Accessing:

size

Different classes interpret this message differently. Object always returns 0.


Copying:

copy

Make a copy of the receiver. The implementation of this message depends on the object's class. In class Object, copy calls shallowCopy.

shallowCopy

Makes a copy of the object. The copy's named and indexed instance variables refer to the same objects as the receiver.

deepCopy

Recursively copies the object and all of the objects contained in the instance variables, and so on down the structure. This method works with cyclic graphs.


Equality, Identity:

== anotherObject

Answer whether the receiver equals anotherObject. The definition of equality depends on the class
of the receiver. The default implementation in Object is to answer if the two objects are identical (see below).

=== anotherObject

Answer whether the receiver is the exact same object as anotherObject.

!= anotherObject

Answer whether the receiver does not equal anotherObject.
The default implementation in Object is to answer if the two objects are not identical (see below).

!== anotherObject

Answer whether the receiver is not the exact same object as anotherObject.

hash

Answer a code used to index into a hash table. This is used by Dictionaries and Sets to implement fast object lookup. Objects which are equal == should have the same hash values. Whenever == is overridden in a class, hash should be overridden as well.

identityHash

Answer a code used to index into a hash table. This method is implemented by a primitive and is not overridden. Objects which are identical === should have the same hash values.


Testing:

isNil

Answer whether the receiver is nil.

notNil

Answer whether the receiver is not nil.

isNumber

Answer whether the receiver is an instance of Number.

isInteger

Answer whether the receiver is an instance of Integer.

isFloat

Answer whether the receiver is an instance of Float.

pointsTo(anObject)

Answer whether one of the receiver's instance variables refers to anObject.

? anObject

If the receiver is nil then answer anObject, otherwise answer the receiver.

?? aFunction

If the receiver is nil, value the function and return the result.

switch(cases)

Object implements a switch method which allows for conditional evaluation with multiple cases. These are implemented as pairs of test objects (tested using if this == test.value) and corresponding functions to be evaluated if true. In order for switch to be inlined (and thus be as efficient as nested if statements) the matching values must be literal Integers, Floats, Chars, Symbols and the functions must have no variables or arguments.

(
var x, z;
z = [0, 1, 1.1, 1.3, 1.5, 2];
switch (z.choose.postln,
 1, { \no },
 1.1, { \wrong },
 1.3, { \wrong },
 1.5, { \wrong },
 2, { \wrong },
 0, { \true }
).postln;
)

or:
 
(
var x, z;
z = [0, 1, 1.1, 1.3, 1.5, 2];
x = switch (z.choose)
 {1} { \no }
 {1.1} { \wrong }
 {1.3} { \wrong }
 {1.5} { \wrong }
 {2} { \wrong }
 {0} { \true };
x.postln;
)

Messaging:

perform(selector ... args)

The selector argument must be a Symbol.
Sends the method named by the selector with the given arguments to the receiver.

performList(selector, ...args..., listOrArray)

The selector argument must be a Symbol.
Sends the method named by the selector with the given arguments to the receiver. If the last
argument is a List or an Array, then its elements are unpacked and passed as arguments.

performMsg(listOrArray)

The argument must be a List or Array whose first element is a Symbol representing a method selector. 
The remaining elements are unpacked and passed as arguments to the method named by the selector


Printing:

post

Print a string representation of the receiver.

postln

Print a string representation of the receiver followed by a newline.

dump

Print a detailed low level representation of the receiver.


Dependancy:

addDependant(aDependant)

Add aDependant to the receiver's list of dependants.

removeDependant(aDependant)

Remove aDependant from the receiver's list of dependants.

dependants

Answer an IdentitySet of all dependants of the receiver.

changed(theChanger)

Notify the receiver's dependants that it has changed. The object making the change should be passed
as theChanger.

update(theChanged, theChanger)

An object upon which the receiver depends has changed. theChanged is the object that changed and
theChanger is the object that made the change.

release

Remove all dependants of the receiver. Any object that has had dependants added must be
released in order for it or its dependants to get garbage collected.

Routines

yield

Must be called from inside a Routine. Yields control to the calling thread. The receiver is the result
passed to the calling thread's method. The result of yield will be the value passed to the Routine's next
method the next time it is called.

yieldAndReset

Must be called from inside a Routine. Yields control to the calling thread. The receiver is the result
passed to the calling thread's method. The Routine is reset so that the next time it is called, it will
start from the beginning. yieldAndReset never returns within the Routine.

alwaysYield

Must be called from inside a Routine. Yields control to the calling thread. The receiver is the result
passed to the calling thread's method. The Routine, when called subsequently
will always yield the receiver until it is reset. alwaysYield never returns within the Routine.

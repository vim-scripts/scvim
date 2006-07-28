IdentitySet

Superclass: Set

An IdentitySet is collection of objects, no two of which are the same object (aka. "identical").
Most of its methods are inherited. Look in the Collection class for the most of the relevant methods.
The contents of an IdentitySet are unordered. 
You must not depend on the order of items in an IdentitySet.

IdentitySets are faster than Sets because testing for identity is much faster than testing for
equality. Different classes may implement equality in different ways, but identity can be determined
just by comparing the object addresses. This allows some methods of IdentitySet to be implemented
by fast primitives.

Adding and Removing:

add(anObject)

Add anObject to the IdentitySet. 
An object which is equal to an object already in the IdentitySet will not be added.

IdentitySet[1, 2, 3].add(4).postln;

IdentitySet[1, 2, 3].add(3).postln;

// the two strings are equal but not identical
IdentitySet["abc", "def", "ghi"].add("def").postln; 

// symbols are guaranteed to be identical if they are equal
IdentitySet['abc', 'def', 'ghi'].add('def').postln; 

IdentitySet['abc', 'def', 'ghi'].add('jkl').postln;

remove(anObject)

Remove anObject from the IdentitySet.

IdentitySet[1, 2, 3].remove(3).postln;


Iteration:

do(function)

Evaluates function for each item in the IdentitySet.
The function is passed two arguments, the item and an integer index.

IdentitySet[1, 2, 3, 300].do({ arg item, i; item.postln });




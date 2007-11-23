
IdentitySet

Superclass: Set

An IdentitySet is collection of objects, no two of which are the same object (aka. "identical").
Most of its methods are inherited. Look in the Collection class for the most of the relevant methods.
The contents of an IdentitySet are unordered. You must not depend on the order of items in an IdentitySet.

IdentitySets are faster than Sets because testing for identity is much faster than testing for
equality. Different classes may implement equality in different ways, but identity can be determined
just by comparing the object addresses. This allows some methods of IdentitySet to be implemented
by fast primitives.



Adding and Removing:

add(anObject)

	Add anObject to the IdentitySet.
	An object which is equal to an object already in the IdentitySet will not be added.


	IdentitySet[1, 2, 3].add(4);
	
	IdentitySet[1, 2, 3].add(3);
	
	// the two strings are equal but not identical
	IdentitySet["abc", "def", "ghi"].add("def"); 
	
	// symbols are guaranteed to be identical if they are equal
	IdentitySet['abc', 'def', 'ghi'].add('def'); 
	
	IdentitySet['abc', 'def', 'ghi'].add('jkl');



remove(anObject)

	Remove anObject from the IdentitySet.

	IdentitySet[1, 2, 3].remove(3);


Iteration:

do(function)

	Evaluates function for each item in the IdentitySet.
	The function is passed two arguments, the item and an integer index.

	IdentitySet[1, 2, 3, 300].do({ arg item, i; item.postln });


Finding an element:

scanFor(elem)
	
	Finds an element in the collection, otherwise returns nil.
	
	IdentitySet[1, 2, 3, 300].do({ arg item, i; item.postln });


This is fairly efficient. compare the following benchmarks:

// comparison of array indexing and identity set lookup
(
f = {|n=4|
	var x, y, i;
	x = (0..n);
	y = x.as(IdentitySet);
	i = x.choose;
	bench { 100.do { x[i] } };
	bench { 100.do { y.scanFor(i) } };
}
);

f.(4)
f.(8)
f.(100)
f.(10000)





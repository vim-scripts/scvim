Bag

Superclass: Collection

A Bag is an unordered collection of objects. In some languages it is referred to as a counted set. A Bag keeps track of the number of times objects are inserted and requires that objects be removed the same number of times. Thus, there is only one instance of an object in a Bag even if the object has been added to the Bag multiple times. 

Most of Bag's methods are inherited from Collection.
The contents of a Bag are unordered. You must not depend on the order of items in a set.

Adding and Removing:

add(anObject)

Add anObject to the Bag. A Bag may contain multiple entries of the same object.

Bag[1, 2, 3].add(4).postln;

Bag[1, 2, 3].add(3).postln;

Bag["abc", "def", "ghi"].add("jkl").postln;

Bag["abc", "def", "ghi"].add("def").postln;

remove(anObject)

Remove anObject from the Bag.

Bag[1, 2, 3].remove(3).postln;


Iteration:

do(function)

Evaluates function for each item in the Bag.
The function is passed two arguments, the item and an integer index.

Bag[1, 2, 3, 300].do({ arg item, i; item.postln });




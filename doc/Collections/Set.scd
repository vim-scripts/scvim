
Set

Superclass: Collection

A Set is collection of objects, no two of which are equal.
Most of its methods are inherited from Collection.
The contents of a Set are unordered. You must not depend on the order of items in a set.

Adding and Removing:

add(anObject)

Add anObject to the Set. An object which is equal to an object already in the Set will not be added.

Set[1, 2, 3].add(4).postln;

Set[1, 2, 3].add(3).postln;

Set["abc", "def", "ghi"].add("jkl").postln;

Set["abc", "def", "ghi"].add("def").postln;

remove(anObject)

Remove anObject from the Set.

Set[1, 2, 3].remove(3).postln;


Iteration:

do(function)

Evaluates function for each item in the Set.
The function is passed two arguments, the item and an integer index.

Set[1, 2, 3, 300].do({ arg item, i; item.postln });






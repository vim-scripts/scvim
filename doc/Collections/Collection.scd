Collection

superclass: Object

Collections are groups of objects. Collection is an abstract class. You do not create direct instances of Collection. There are many types of Collections including List, Array, Dictionary, Bag, Set, SortedList, etc. See the Collections overview for a complete listing of all subclasses.

Class Methods:

*fill(size, function)

Creates a Collection of the given size, the elements of which are determined by evaluation the given function. The function is passed the index as an argument.

Array.fill(4, {arg i; i * 2}).postln;

Accessing:

size

Answers the number of objects contained in the Collection.

List[1, 2, 3, 4].size.postln;

isEmpty

Answer whether the receiver contains no objects.

List[].isEmpty.postln;

Adding and Removing:

add(anObject)

Add anObject to the receiver.

List[1, 2].add(3).postln;

addAll(aCollection)

Add all items in aCollection to the receiver.

List[1, 2].addAll(List[3, 4]).postln;

remove(anObject)

Remove anObject from the receiver. Answers the removed object.

(
var a;
a = List[1, 2, 3, 4];
a.remove(3).postln;
a.postln;
)

removeAll(aCollection)

Remove all items in aCollection from the receiver.

List[1, 2, 3, 4].removeAll(List[2, 3]).postln;

removeAllSuchThat(function)

Remove all items in the receiver for which function answers true. The function is passed two arguments, the item and an integer index. Answers the objects which have been removed.

(
var a;
a = List[1, 2, 3, 4];
a.removeAllSuchThat({ arg item, i; item < 3 }).postln;
a.postln;
)


Testing:

includes(anObject)

Answer whether anObject is contained in the receiver.

List[1, 2, 3, 4].includes(3).postln;

includesAny(aCollection)

Answer whether any item in aCollection is contained in the receiver.

List[1, 2, 3, 4].includesAny(List[4, 5]).postln;

includesAll(aCollection)

Answer whether all items in aCollection are contained in the receiver.

List[1, 2, 3, 4].includesAll(List[4, 5]).postln;


Iteration:

do(function)

Evaluates function for each item in the collection. The function is passed two arguments, the item and an integer index.

List[1, 2, 3, 4].do({ arg item, i; item.postln });

collect(function)

Answer a new collection which consists of the results of function evaluated for each item in the collection. The function is passed two arguments, the item and an integer index.

List[1, 2, 3, 4].collect({ arg item, i; item + 10 }).postln;

select(function)

Answer a new collection which consists of all items in the receiver for which function answers true. The function is passed two arguments, the item and an integer index.

List[1, 2, 3, 4].select({ arg item, i; item.even }).postln;

reject(function)

Answer a new collection which consists of all items in the receiver for which function answers false. The function is passed two arguments, the item and an integer index.

List[1, 2, 3, 4].reject({ arg item, i; item.even }).postln;

detect(function)

Answer the first item in the receiver for which function answers true.
The function is passed two arguments, the item and an integer index.

List[1, 2, 3, 4].detect({ arg item, i; item.even }).postln;

inject(initialValue, function)

In functional programming, the operation known as a fold.
inject takes an initial value and a function and combines the elements of the collection by applying the function to the accumulated value and an element from the collection. The function takes two arguments and returns the new value. The accumulated value is initialzed to initialValue.

[1,2,3,4,5].inject(0, _+_);

15

[1,2,3,4,5].inject(1, _*_);

120

[1,2,3,4,5].inject([], {|a,b| a ++ b.squared }); // same as .collect(_.squared)

[ 1, 4, 9, 16, 25 ]

[1,2,3,4,5].inject([], {|a,b| [b] ++ a ++ [b]});

[ 5, 4, 3, 2, 1, 1, 2, 3, 4, 5 ]

[1,2,3,4,5].inject([], {|a,b| a ++ b ++ a});

[ 1, 2, 1, 3, 1, 2, 1, 4, 1, 2, 1, 3, 1, 2, 1, 5, 1, 2, 1, 3, 1, 2, 1, 4, 1, 2, 1, 3, 1, 2, 1 ]

[1,2,3,4,5].inject([], {|a,b| a ++ a ++ b});

[ 1, 1, 2, 1, 1, 2, 3, 1, 1, 2, 1, 1, 2, 3, 4, 1, 1, 2, 1, 1, 2, 3, 1, 1, 2, 1, 1, 2, 3, 4, 5 ]

any(function)

Answer whether function answers true for any item in the receiver.
The function is passed two arguments, the item and an integer index.

List[1, 2, 3, 4].any({ arg item, i; item.even }).postln;

every(function)

Answer whether function answers true for every item in the receiver.
The function is passed two arguments, the item and an integer index.

List[1, 2, 3, 4].every({ arg item, i; item.even }).postln;

count(function)

Answer the number of items for which function answers true.
The function is passed two arguments, the item and an integer index.

List[1, 2, 3, 4].count({ arg item, i; item.even }).postln;

occurencesOf(anObject)

Answer the number of items in the receiver which are equal to anObject.

List[1, 2, 3, 3, 4, 3, 4, 3].occurencesOf(3).postln;

sum(function)

Answer the sum of the results of function evaluated for each item in the receiver.
The function is passed two arguments, the item and an integer index.

List[1, 2, 3, 4].sum.postln;

(0..8).sum { |i| 1 / (2 ** i) };

maxItem(function)

Answer the maximum of the results of function evaluated for each item in the receiver.
The function is passed two arguments, the item and an integer index.
If function is nil, then answer the maximum of all items in the receiver.

List[1, 2, 3, 4].maxItem({ arg item, i; item + 10 }).postln;

minItem(function)

Answer the minimum of the results of function evaluated for each item in the receiver.
The function is passed two arguments, the item and an integer index.
If function is nil, then answer the minimum of all items in the receiver.

List[1, 2, 3, 4].minItem({ arg item, i; item + 10 }).postln;


Conversion:

asBag

Answer a Bag to which all items in the receiver have been added.

List[1, 2, 3, 4].asBag.postln;

asList

Answer a List to which all items in the receiver have been added.

List[1, 2, 3, 4].asList.postln;

asSet

Answer a Set to which all items in the receiver have been added.

List[1, 2, 3, 4].asList.postln;

asSortedList

Answer a SortedList to which all items in the receiver have been added.

List[2, 1, 4, 3].asSortedList.postln;

printOn(stream)

Print a representation of the collection to a stream.

storeOn(stream)

Write a compileable representation of the collection to a stream.

printItemsOn(stream)

Print a comma separated compileable representation of the items in the collection to a stream.

storeItemsOn(stream)

Write a comma separated compileable representation of the items in the collection to a stream.



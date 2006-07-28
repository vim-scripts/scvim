ArrayedCollection

Superclass: SequenceableCollection

ArrayedCollection is an abstract class, a subclass of SequenceableCollections whose elements are held in a vector of slots. Instances of ArrayedCollection have a fixed maximum size beyond which they may not grow.

Its principal subclasses are Array (for holding objects), and RawArray, from which Int8Array, FloatArray,Signal etc. inherit.



Class Methods

*with(... args)

Create a new ArrayedCollection whose slots are filled with the given arguments.

Array.with(7, 'eight', 9).postln;

*series(size, start, step)

Fill an ArrayedCollection with an arithmetic series.

Array.series(5, 10, 2).postln;

*geom(size, start, grow)

Fill an ArrayedCollection with a geometric series.

Array.geom(5, 1, 3).postln;


Instance Methods

at(index)

Return the item at index.
 
clipAt(index)

Same as at, but values for index greater than the size of the ArrayedCollection will be clipped to the last index.

y = [ 1, 2, 3 ];
y.clipAt(13).postln;

wrapAt(index)

Same as at, but values for index greater than the size of the ArrayedCollection will be wrapped around to 0.

y = [ 1, 2, 3 ];
y.wrapAt(3).postln; // this returns the value at index 0
y.wrapAt(4).postln; // this returns the value at index 1

foldAt(index)

Same as at, but values for index greater than the size of the ArrayedCollection will be folded back.

y = [ 1, 2, 3 ];
y.foldAt(3).postln; // this returns the value at index 1
y.foldAt(4).postln; // this returns the value at index 0
y.foldAt(5).postln; // this returns the value at index 1

swap(i, j)

Swap the values at indices i and j.

[ 1, 2, 3 ].swap(0, 2).postln;

put(index, item)

Put item at index, replacing what is there.

clipPut(index, item)

Same as put, but values for index greater than the size of the ArrayedCollection will be clipped to the last index.

wrapPut(index, item)

Same as put, but values for index greater than the size of the ArrayedCollection will be wrapped around to 0.

foldPut(index)

Same as put, but values for index greater than the size of the ArrayedCollection will be folded back.

removeAt(index)

Remove and return the element at index, shrinking the size of the ArrayedCollection.

y = [ 1, 2, 3 ]; 
y.removeAt(1); 
y.postln;

takeAt(index)

Same as removeAt, but reverses the order of the items following those that which was taken.

y = [ 1, 2, 3, 4 ]; 
y.takeAt(1); 
y.postln;

add(item)

Adds an item to an ArrayedCollection if there is space. If there is not any space left in the object then this method returns a new ArrayedCollection. For this reason, you should always assign the result of add to a variable - never depend on add changing the receiver.

(
// z and y are the same object
var y, z;
z = [1, 2, 3];
y = z.add(4);
z.postln;
y.postln;
)

(
// in this case a new object is returned
var y, z;
z = [1, 2, 3, 4];
y = z.add(5);
z.postln;
y.postln;
)

addAll(aCollection)

Adds all the elements of aCollection to the contents of the receiver, possibly returning a new collection.

(
// in this case a new object is returned
var y, z;
z = [1, 2, 3, 4];
y = z.addAll([7, 8, 9]);
z.postln;
y.postln;
)

fill(value)

Inserts the item into the contents of the receiver, possibly returning a new collection. Note the difference between this and Collection's *fill.

(
var z;
z = List[1, 2, 3, 4];
z.fill(4).postln;
z.fill([1,2,3,4]).postln;
)

insert(index, item)

Inserts the item into the contents of the receiver, possibly returning a new collection.

(
// in this case a new object is returned
var y, z;
z = [1, 2, 3, 4];
y = z.insert(1, 999);
z.postln;
y.postln;
)

addFirst(item)

Inserts the item before the contents of the receiver, possibly returning a new collection.

(
// in this case a new object is returned
var y, z;
z = [1, 2, 3, 4];
y = z.addFirst(999);
z.postln;
y.postln;
)

pop

Remove and return the last element of the ArrayedCollection.

(
var z;
z = [1, 2, 3, 4];
z.pop.postln;
z.postln;
)

grow(sizeIncrease)

Increase the size of the ArrayedCollection by sizeIncrease number of slots, possibly returning a new collection.

copyRange(start, end)

Return a new ArrayedCollection which is a copy of the indexed slots of the receiver from start to end.

(
var y, z;
z = [1, 2, 3, 4, 5];
y = z.copyRange(1,3);
z.postln;
y.postln;
)

copySeries(first, second, last)

Return a new ArrayedCollection consisting of the values starting at first, then every step of the distance between first and second, up until last.

(
var y, z;
z = [1, 2, 3, 4, 5, 6];
y = z.copySeries(0, 2, 5);
y.postln;
)

putSeries(first, second, last, value)

Put value at every index starting at first, then every step of the distance between first and second, up until last.

(
var y, z;
z = [1, 2, 3, 4, 5, 6];
y = z.putSeries(0, 2, 5, "foo");
y.postln;
)

++ aCollection

Concatenate the contents of the two collections into a new ArrayedCollection.

(
var y, z;
z = [1, 2, 3, 4];
y = z ++ [7, 8, 9];
z.postln;
y.postln;
)

reverse

Return a new ArrayedCollection whose elements are reversed.

(
var y, z;
z = [1, 2, 3, 4];
y = z.reverse;
z.postln;
y.postln;
)

do(function)

Iterate over the elements in order, calling the function for each element. The function is passed two arguments, the element and an index.

['a', 'b', 'c'].do({ arg item, i; [i, item].postln; });

reverseDo(function)

Iterate over the elements in reverse order, calling the function for each element. The function is passed two arguments, the element and an index.

['a', 'b', 'c'].reverseDo({ arg item, i; [i, item].postln; });

windex

Interprets the array as a list of probabilities which should sum to 1.0 and returns a random index value based on those probabilities.

(
Array.fill(10, {
 [0.1, 0.6, 0.3].windex;
}).postln;
)

normalizeSum

Returns the Array resulting from : 

(this / this.sum)

so that the array will sum to 1.0.

This is useful for using with windex or wchoose.

[1, 2, 3].normalizeSum.postln;


performInPlace(selector, from, to, argList)

performs a method in place, within a certain region [from..to], returning the same array.


a = (0..10);
a.performInPlace(\normalizeSum, 3, 6); 



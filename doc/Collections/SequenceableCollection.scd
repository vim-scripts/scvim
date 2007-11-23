
SequenceableCollection

Superclass: Collection

SequenceableCollection is a subclass of Collection whose elements can be indexed by an Integer. It has many useful subclasses; Array and List are amongst the most commonly used.

Class Methods

*series(size, start, step)

Fill a SequenceableCollection with an arithmetic series.

Array.series(5, 10, 2);

*geom(size, start, grow)

Fill a SequenceableCollection with a geometric series.

Array.geom(5, 1, 3);

*fib(size, a, b)

Fill a SequenceableCollection with a fibonacci series.
b is the starting value (default: 1), a is the starting step value (default: 0)

Array.fib(5);
Array.fib(5, 2, 32); // start from 32 with step 2.

*rand(size, minVal, maxVal)

Fill a SequenceableCollection with random values in the range minVal to maxVal.

Array.rand(8, 1, 100);

*rand2(size, val)

Fill a SequenceableCollection with random values in the range -val to +val.

Array.rand2(8, 100);

*linrand(size, minVal, maxVal)

Fill a SequenceableCollection with random values in the range minVal to maxVal with a linear
distribution.

Array.linrand(8, 1, 100);

*exprand(size, minVal, maxVal)

Fill a SequenceableCollection with random values in the range minVal to maxVal with exponential
distribution.

Array.exprand(8, 1, 100);



Instance Methods

first

Return the first element of the collection,

last

Return the first element of the collection,


indexOf(item)

	Return the index of an item in the collection, or nil if not found.
	
indexOfEqual(item)

	Return the index of something in the collection that equals the item, or nil if not found.

indexIn(val)
	
	returns the closest index of the value in the collection (collection must be sorted)
	
	[2, 3, 5, 6].indexIn(5.2)
	
indexInBetween(val)

	returns a linearly interpolated float index for the value (collection must be sorted)
	inverse operation is blendAt
	
	x = [2, 3, 5, 6].indexInBetween(5.2)
	[2, 3, 5, 6].blendAt(x)


blendAt(floatIndex)

	returns a linearly interpolated value between the two closest indices
	inverse operation is indexInBetween
	x = [2, 5, 6].blendAt(0.4)




copyRange(start, end)

Return a new SequenceableCollection which is a copy of the indexed slots of the receiver from start to end.
x.copyRange(a, b) can also be written as x[a..b]

(
var y, z;
z = [1, 2, 3, 4, 5];
y = z.copyRange(1,3);
z.postln;
y.postln;
)

copyToEnd(start)

Return a new SequenceableCollection which is a copy of the indexed slots of the receiver from start to the end of the collection. x.copyToEnd(a) can also be written as x[a..]

copyFromStart(end)

Return a new SequenceableCollection which is a copy of the indexed slots of the receiver from the start of the collection to end. x.copyFromStart(a) can also be written as x[..a]

remove(item)

Remove item from collection.

keep(n)

Keep the first n items of the array. If n is negative, keep the last n items.

a = [1, 2, 3, 4, 5];
a.keep(3);
a.keep(-3);

drop(n)

Drop the first n items of the array. If n is negative, drop the last n items.

a = [1, 2, 3, 4, 5];
a.drop(3);
a.drop(-3);

flat

Returns a collection from which all nesting has been flattened.

[[1, 2, 3],[[4, 5],[[6]]]].flat;

flatten(numLevels)

Returns a collection from which numLevels of nesting has been flattened.

[[1, 2, 3],[[4, 5],[[6]]]].flatten(1).postcs;

[[1, 2, 3],[[4, 5],[[6]]]].flatten(2).postcs;

flop

Invert rows and columns in a two dimensional collection.

[[1, 2, 3, 4],[5, 6, 7, 8],[9, 10, 11, 12]].flop.postcs;

choose

Choose an element from the collection at random.

[1, 2, 3, 4].choose;

wchoose

Choose an element from the collection at random using a list of probabilities or weights.
The weights must sum to 1.0.

[1, 2, 3, 4].wchoose([0.1, 0.2, 0.3, 0.4]);

sort(function)

Sort the contents of the collection using the comparison function argument.
The function should take two elements as arguments and return true if the first
argument should be sorted before the second argument.
If the function is nil, the following default function is used.

{ arg a, b; a < b }


[6, 2, 1, 7, 5].sort;

[6, 2, 1, 7, 5].sort({ arg a, b; a > b }); // reverse sort


swap(i, j)

Swap two elements in the collection at indices i and j.

doAdjacentPairs(function)

Calls function for every adjacent pair of elements in the SequentialCollection.
The function is passed the two adjacent elements and an index.

[1, 2, 3, 4, 5].doAdjacentPairs({ arg a, b; [a, b].postln; });

separate(function)

Separates the collection into sub-collections by calling the function for each adjacent pair of elements.
If the function returns true, then a separation is made between the elements.

[1, 2, 3, 5, 6, 8, 10].separate({ arg a, b; (b - a) > 1 }).postcs;

clump(groupSize)

Separates the collection into sub-collections by separating every groupSize elements.

[1, 2, 3, 4, 5, 6, 7, 8].clump(3).postcs;

clumps(groupSizeList)

Separates the collection into sub-collections by separating elements into groupings whose size
is given by integers in the groupSizeList.

[1, 2, 3, 4, 5, 6, 7, 8].clumps([1,2]).postcs;

curdle(probability)

Separates the collection into sub-collections by separating elements according to the
given probability.

[1, 2, 3, 4, 5, 6, 7, 8].curdle(0.3).postcs;

integrate

Returns a collection with the incremental sums of all elements

[3, 4, 1, 1].integrate;

differentiate

Returns a collection with the pairwise difference between all elements

[3, 4, 1, 1].differentiate;

convertDigits(base)

Returns an integer resulting from interpreting the elements as digits to a given base (default 10).
See also asDigits in Integer for the complementary method.

[1, 0, 0, 0].convertDigits;
[1, 0, 0, 0].convertDigits(2);
[1, 0, 0, 0].convertDigits(3);

hammingDistance(that)

Returns the count of array elements that are not equal in identical positions. http://en.wikipedia.org/wiki/Hamming_distance

The collections are not wrapped - if one array is shorter than the other, the difference in size should be included in the count.

[0, 0, 0, 1, 1, 1, 0, 1, 0, 0].hammingDistance([0, 0, 1, 1, 0, 0, 0, 0, 1, 1])
"SuperMan".hammingDistance("SuperCollider");

Math Support

Unary Messages:

All of the following messages send the message performUnaryOp to the receiver with the
unary message selector as an argument.

neg, reciprocal, bitNot, abs, asFloat, asInt, ceil, floor, frac, sign, squared, cubed, sqrt
exp, midicps, cpsmidi, midiratio, ratiomidi, ampdb, dbamp, octcps, cpsoct, log, log2,
log10, sin, cos, tan, asin, acos, atan, sinh, cosh, tanh, rand, rand2, linrand, bilinrand,
sum3rand, distort, softclip, nyqring, coin, even, odd, isPositive, isNegative,
isStrictlyPositive, real, imag, magnitude, magnitudeApx, phase, angle, rho, theta,
asFloat, asInteger

performUnaryOp(aSelector)

Creates a new collection of the results of applying the selector to all elements in the receiver.

[1, 2, 3, 4].neg;

[1, 2, 3, 4].reciprocal;

Binary Messages:

All of the following messages send the message performBinaryOp to the receiver with the
binary message selector and the second operand as arguments.

+, -, *, /, div, %, **, min, max, <, <=, >, >=, &, |, bitXor, lcm, gcd, round, trunc, atan2,
hypot, >>, +>>, fill, ring1, ring2, ring3, ring4, difsqr, sumsqr, sqrdif, absdif, amclip,
scaleneg, clip2, excess, <!, rrand, exprand

performBinaryOp(aSelector, theOperand)

Creates a new collection of the results of applying the selector with the operand to all elements
in the receiver.
If the operand is a collection then elements of that collection are paired with elements of
the receiver.

([1, 2, 3, 4] * 10);

([1, 2, 3, 4] * [4, 5, 6, 7]);





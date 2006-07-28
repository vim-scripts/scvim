Integer

superclass: SimpleNumber

A 32 bit integer. Integer inherits most of its behaviour from its superclass.

Iteration

do(function)

Executes function for all integers from zero to this minus one.
function - a Function which is passed two arguments, both of which are the same
integer from zero to this minus one. The reason two arguments are passed is for
symmetry with the implementations of do in Collection.

for(endval, function)

Executes function for all integers from this to endval, inclusive.
endval - an Integer.
function - a Function which is passed two arguments, the first which is an integer from this to
endval, and the second which is a number from zero to the number of iterations minus one.

forBy(endval, step, function)

Executes function for all integers from this to endval, inclusive, stepping each time by step.
endval - an Integer.
step - an Integer.
function - a Function which is passed two arguments, the first which is an integer from this to
endval, and the second which is a number from zero to the number of iterations minus one.

Conversion

asAscii

Answer a Char which has the ASCII value of the receiver.

asDigit

Answer a Char which represents the receiver as an ASCII digit. For example 
5.asDigit returns $5.


Random Numbers

xrand(exclude)

Answer a random value from zero to this, excluding the value exclude.
exclude - an Integer.

xrand2(exclude)

Answer a random value from this.neg to this, excluding the value exclude.
exclude - an Integer.

Powers Of Two

nextPowerOfTwo

Answer the next power of two greater than or equal to the receiver.

13.nextPowerOfTwo.postln;
64.nextPowerOfTwo.postln;

isPowerOfTwo

Answer the whether the receiver is a power of two.

13.isPowerOfTwo.postln;
64.isPowerOfTwo.postln;

Prime Numbers

nthPrime

Answer the nth prime number. The receiver must be from 0 to 6541.

[0,1,2,3,4,5].collect({ arg i; i.nthPrime; }).postln;

prevPrime

Answer the next prime less than or equal to the receiver up to 65521.

25.prevPrime.postln;

nextPrime

Answer the next prime less than or equal to the receiver up to 65521.

25.nextPrime.postln;

isPrime

Answer whether the receiver is prime.

25.isPrime.postln;
13.isPrime.postln;

Misc

getKeys

Returns the bits from the Macintosh GetKeys() Toolbox call. Receiver should be 0 to 3.

[0.getKeys, 1.getKeys, 2.getKeys, 3.getKeys].postln;

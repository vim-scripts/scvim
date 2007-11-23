
SimpleNumber

superclass: Number

Represents numbers which can be represented by a single one dimensional value.
Most of the Unary and Binary operations are also implemented by UnaryOpUGen
and BinaryOpUGen, so you can get more examples by looking at the help for those.

Unary Operations

neg

negation

bitNot

ones complement

abs

absolute value.

ceil

next larger integer.

floor

next smaller integer

frac

fractional part.

sign

Answer -1 if negative, +1 if positive or 0 if zero.

squared

The square of the number.

cubed

The cube of the number.

sqrt

The square root of the number.

exp

e to the power of the receiver.

reciprocal

1 / this

midicps

Convert MIDI note to cycles per second

cpsmidi

Convert cycles per second to MIDI note.

midiratio

Convert an interval in semitones to a ratio.

ratiomidi

Convert a ratio to an interval in semitones.

ampdb

Convert a linear amplitude to decibels.

dbamp

Convert a decibels to a linear amplitude.

octcps

Convert decimal octaves to cycles per second.

cpsoct

Convert cycles per second to decimal octaves.

log

Base e logarithm.

log2

Base 2 logarithm.

log10

Base 10 logarithm.

sin

Sine.

cos

Cosine.

tan

Tangent.

asin

Arcsine.

acos

Arccosine.

atan

Arctangent.

sinh

Hyperbolic sine.

cosh

Hyperbolic cosine.

tanh

Hyperbolic tangent.

rand

Random number from zero up to the receiver, exclusive.

rand2

Random number from -this to +this.

linrand

Linearly distributed random number from zero to this.

bilinrand

Bilateral linearly distributed random number from -this to +this.

sum3rand

A random number from -this to +this that is the result of summing three uniform random generators
to yield a bell-like distribution. This was suggested by Larry Polansky as a poor man's gaussian.

distort

a nonlinear distortion function.

softclip

Distortion with a perfectly linear region from -0.5 to +0.5

coin

Answers a Boolean which is the result of a random test whose probability of success in a range from
zero to one is this.

even

Answer if the number is even.

odd

Answer if the number is odd.

isPositive

Answer if the number is >= 0.

isNegative

Answer if the number is < 0.

isStrictlyPositive

Answer if the number is > 0.

Binary Operations

+ aNumber

Addition

- aNumber

Subtraction

* aNumber

Multiplication

/ aNumber

Division

% aNumber

Modulo

div(aNumber)

Integer Division

** aNumber

Exponentiation

min(aNumber)

Minimum

max(aNumber)

Maximum

& aNumber

Bitwise And

| aNumber

Bitwise Or

bitXor(aNumber)

Bitwise Exclusive Or

bitHammingDistance(aNumber)

Binary Hamming distance, or the count of bits that are not the same in the two numbers

bitTest(aNumber)

Returns true if bit at index aNumber is set.

lcm(aNumber)

Least common multiple

gcd(aNumber)

Greatest common divisor

round(aNumber)

Round to multiple of aNumber

trunc(aNumber)

Truncate to multiple of aNumber

atan2(aNumber)

Arctangent of (this/aNumber)

hypot(aNumber)

Square root of the sum of the squares.

<< aNumber

Binary shift left.

>> aNumber

Binary shift right.

+>> aNumber

Unsigned binary shift right.

fill(aNumber)

ring1(aNumber)

(a * b) + a

ring2(aNumber)

((a*b) + a + b)

ring3(aNumber)

(a*a *b)

ring4(aNumber)

((a*a *b) - (a*b*b))

difsqr(aNumber)

(a*a) - (b*b)

sumsqr(aNumber)

(a*a) + (b*b)

sqrdif(aNumber)

(a - b)**2

sqrsum(aNumber)

(a + b)**2

absdif(aNumber)

(a - b).abs

amclip(aNumber)

0 when b <= 0, a*b when b > 0

scaleneg(aNumber)

a*b when a < 0, otherwise a.

clip2(aNumber)

clips receiver to +/- aNumber

excess(aNumber)

Returns the difference of the receiver and its clipped form: (a - clip2(a,b)).

<! aNumber

Return the receiver. aNumber is ignored.

asFraction(denominator, fasterBetter)

Return an array of denominator and divisor of the nearest and smallest fraction

rrand(aNumber)

	Returns a random number in the interval [a, b). If both a and b are Integer then the result will be an Integer.

exprand(aNumber)

	Returns an exponentially distributed random number in the interval [a, b). Always returns a Float.


degreeToKey(scale, stepsPerOctave)

	the value is truncated to an integer and used as an index into an octave repeating table of note values.
	Indices wrap around the table and shift octaves as they do
	stepsPerOctave is 12 by default
	
	(
		l = [0, 1, 5, 9, 11]; // pentatonic scale
		(1, 2..15).collect { |i| i.degreeToKey(l, 12) }
	)


keyToDegree(scale, stepsPerOctave)

	inverse of degreeToKey.
	stepsPerOctave is 12 by default
	
	(
		l = [0, 1, 5, 9, 11]; // pentatonic scale
		(60, 61..75).collect { |i| i.keyToDegree(l, 12) }
	)
	(
		l = [0, 1, 5, 9, 11]; // pentatonic scale
		(60, 61..75).postln.collect { |i| i.keyToDegree(l, 12).degreeToKey(l) }
	)
	
nearestInList(list)

	returns the value in the collection closest to this
	
	(
		l = [0, 0.5, 0.9, 1];
		(0, 0.05..1).collect { |i| i.nearestInList(l) }
	)


nearestInScale(scale, stepsPerOctave)

	returns the value in the collection closest to this, assuming an octave repeating table of note values.
	stepsPerOctave is 12 by default
	
	(
		l = [0, 1, 5, 9, 11]; // pentatonic scale
		(60, 61..76).collect { |i| i.nearestInScale(l, 12) }
	)
	
asTimeString(precision)

	returns a string corresponding to the hours:minutes:seconds based on the receiver as number of seconds
	precision is 0.1 by default
	
	(
		var start;
		start = Main.elapsedTime;
		{ loop({(Main.elapsedTime - start).asTimeString.postln; 0.05.wait}) }.fork;
	)



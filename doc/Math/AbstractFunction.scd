AbstractFunction


An AbstractFunction is an object which responds to a set of messages that represent
mathematical functions. Subclasses override a smaller set of messages to respond
to the mathematical functions. The intent is to provide a mechanism for functions
that do not calculate values directly but instead compose structures for calculating.

Function, Pattern, Stream and UGen are subclasses of AbstractFunction.
For example, if you multiply two UGens together the receiver responds by answering a new
instance of class BinaryOpUGen which has the two operands as inputs.


Unary Messages:

All of the following messages send the message composeUnaryOp to the receiver with the
unary message selector as an argument.

neg, reciprocal, bitNot, abs, asFloat, asInt, ceil, floor, frac, sign, squared, cubed, sqrt
exp, midicps, cpsmidi, midiratio, ratiomidi, ampdb, dbamp, octcps, cpsoct, log, log2,
log10, sin, cos, tan, asin, acos, atan, sinh, cosh, tanh, rand, rand2, linrand, bilinrand,
sum3rand, distort, softclip, nyqring, coin, even, odd, isPositive, isNegative,
isStrictlyPositive



Binary Messages:

All of the following messages send the message composeBinaryOp to the receiver with the
binary message selector and the second operand as arguments.

+, -, *, /, div, %, **, min, max, <, <=, >, >=, &, |, bitXor, lcm, gcd, round, trunc, atan2, 
hypot, >>, +>>, fill, ring1, ring2, ring3, ring4, difsqr, sumsqr, sqrdif, absdif, amclip,
scaleneg, clip2, excess, <!, rrand, exprand



Messages with more arguments:

All of the following messages send the message composeNAryOp to the receiver with the
binary message selector and the other operands as arguments.

clip, wrap, fold, blend, linlin, linexp, explin, expexp




Function Composition:

when unary, binary or n-ary operators are appied to an abstract function, it returns an object that represents
this operation, without evaluating the function: UnaryOpFunction, BinaryOpFunction, NAryOpFunction.
Note that different subclasses like Pattern or UGen have their own composition scheme analogous to the one of AbstractFunction itself. More about functions, see [Function]


// examples

a = { 1.0.rand }?+ 8;
a.value;


y = { 8 }?+ { 1.0.rand };
y.value;

// arguments are passed into both functions

y = { |x=0| x } + {?1.0.rand };
y.value(10);


y = { |x=0| x * 3 } + {?|x=0| x + 1.0.rand };
y.value(10);

y.postcs;

y = { |x=0| x * 3 } + {?|x=0| x + 1.0.rand } * { |x=0| [50, 100].choose + x } + 1.0;
y.value(10);

// environments can be used as a lookup with valueEnvir:

(
Environment.use {
 ~y = 10;
 ~x = 2;
 ~z = { |x=8| x } + { |y=0| y + 1.0.rand };
 ~z.valueEnvir;
}
)

// n-ary operators:

a = blend({ 3.0.rand }, {?1000.rand }, { |frac| frac });
a.value(0.5);

a.value((0, 0.06..1)); // creates a range of values..











**				exponentiation

BinaryOperator

a ** b

When the signal is negative this function extends the usual definition of
exponentiation and returns neg(neg(a) ** b). This allows exponentiation of
negative signal values by noninteger exponents.

(
{
var a;
a = FSinOsc.ar(100);
[a, a**10]
}.play
)





Pif : Pattern

Pattern-based conditional expression.

*new(condition, iftrue, iffalse, default)

condition: A pattern or stream returning a Boolean value.
iftrue: This stream is evaluated if the Boolean is true.
iffalse: This stream is evaluated if the Boolean is false.
default: This value (not stream) is returned if "iftrue" or "iffalse" return nil at any time.

p = Pif(Pfunc({ 0.3.coin }), Pwhite(0, 9, inf), Pwhite(100, 109, inf)).asStream;
p.nextN(20);
[ 105, 107, 107, 8, 100, 3, 105, 5, 107, 106, 1, 104, 8, 102, 102, 4, 108, 8, 109, 101 ]

7 of the 20 values, or roughly 30%, are in the 0-9 range.



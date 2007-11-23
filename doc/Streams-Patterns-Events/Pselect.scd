
Pselect

superclass: FuncFilterPattern

Pselect(func, pattern)

returns values for which the function returns true. the value is passed to the function


(
var a, b;
a = Pselect({ arg item; item != 2 }, Pseq(#[1, 2, 3],inf));
x = a.asStream;
9.do({ x.next.postln; });
)

the message select returns a Pselect when passed to a pattern

(
var a, b;
a = Pseq(#[1, 2, 3],inf).select({ arg item; item != 2 });
a.postln;
x = a.asStream;
9.do({ x.next.postln; });
)



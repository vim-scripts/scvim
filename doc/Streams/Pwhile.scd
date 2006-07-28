Pwhile while a condition holds, repeatedly embed stream

superclass: FuncFilterPattern

Pwhile(func, pattern)



(
var a, b, z = true;
a = Pwhile({ z }, Pseq(#[1, 2, 3]));
x = a.asStream;
9.do({ x.next.postln; });
z = false;
x.next.postln;
)


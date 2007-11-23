
Pn

superclass: FilterPatterns

repeats the enclosed pattern a number of times

Pn(pattern, repeats)



(
var a, b;
a = Pn(Pseq(#[1, 2, 3], 1), 4);	// repeat pattern four times
b = a.asStream;
16.do({ b.next.postln; });
)




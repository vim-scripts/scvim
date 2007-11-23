
Pxrand


like Prand, returns one item from the list at random for each repeat, but Pxrand never
repeats the same element twice in a row.

(
var a, b;
a = Pxrand.new(#[1, 2, 3], 10);	// return 10 items
b = a.asStream;
11.do({ b.next.postln; });
)

Pxrand used as a sequence of pitches:


(
SynthDef("help-sinegrain",
	{ arg out=0, freq=440, sustain=0.05;
		var env;
		env = EnvGen.kr(Env.perc(0.01, sustain, 0.2), doneAction:2);
		Out.ar(out, SinOsc.ar(freq, 0, env))
	}).send(s);
)


(
a = Pxrand(#[60, 61, 63, 65, 72], inf).asStream;
Routine({
	loop({
	Synth("help-sinegrain", [\freq, a.next.midicps]);
	0.1.wait;
	})
}).play;
)




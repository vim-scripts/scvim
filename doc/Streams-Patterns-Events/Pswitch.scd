
Pswitch


Pswitch(list, which)

chooses elements from the list by a stream of indices (which).
the elements are embedded in the stream, so if an element is a
pattern, it will play until it is finished. if it is a simple number it will
just yield itself.
play then resumes embedding the next element in the list...

(
var a, b;
a = Pseq(#[1, 2, 3], 2);
b = Pseq(#[65, 76]);
c = Pswitch([a, b, 800], Pseq([2, 2, 0, 1], inf));
x = c.asStream;
24.do({ x.next.postln; });
)


Pswitch used as a sequence of pitches:


(
SynthDef("help-sinegrain",
	{ arg out=0, freq=440, sustain=0.05;
		var env;
		env = EnvGen.kr(Env.perc(0.01, sustain, 0.2), doneAction:2);
		Out.ar(out, SinOsc.ar(freq, 0, env))
	}).send(s);
)

(
a = Pseq(#[73, 71, 69], 2);
b = Pseq(#[0, 0, 0, 4, 0]+64);
c = Pswitch([a, b, 75], Pseq([2, 2, 0, 1], inf));
x = c.asStream;
Routine({
	loop({
	Synth("help-sinegrain", [\freq, x.next.midicps]);
	0.18.wait;
	})
}).play;
)





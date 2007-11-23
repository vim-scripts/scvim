
Pstutter

superclass: FilterPatterns

Pstutter(n, pattern)

repeat each element n times

n may be a pattern, so the number of times can vary each iteration


(
var a, b;
a = Pstutter(2, Pseq(#[1, 2, 3],inf));
x = a.asStream;
13.do({ x.next.postln; });
)


Pstutter used as a sequence of pitches


(
SynthDef("help-sinegrain",
	{ arg out=0, freq=440, sustain=0.05;
		var env;
		env = EnvGen.kr(Env.perc(0.01, sustain, 0.2), doneAction:2);
		Out.ar(out, SinOsc.ar(freq, 0, env))
	}).send(s);
)


(
c = Pstutter(3, Prand([1, 2, 3],inf)*4+65);
x = c.asStream;
Routine({
	loop({
			Synth("help-sinegrain", [\freq, x.next.midicps]);
			0.12.wait;
	})
}).play;
)




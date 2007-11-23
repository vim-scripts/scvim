
Pfin

superclass: FilterPattern

Pfin(count, pattern)

embeds count elements of the pattern into the stream

Note: Pfin is intended for event patterns. After the count elements are embedded, the stream is called with a nil input value so that Pmono, Pfx and others can release resources. Ordinary value patterns should not be called in this case, so for value patterns, you should use [Pfinval] instead.


(
var a, b;
a = Pfin(5, Pseq(#[1, 2, 3],inf));
x = a.asStream;
9.do({ x.next.postln; });
)


Pfin used as a sequence of pitches


(
SynthDef("help-sinegrain",
	{ arg out=0, freq=440, sustain=0.05;
		var env;
		env = EnvGen.kr(Env.perc(0.01, sustain, 0.2), doneAction:2);
		Out.ar(out, SinOsc.ar(freq, 0, env))
	}).send(s);
)

(
c = Pn(Pfin({ rrand(3, 5)}, Pseq([1, 2, 3, 4, 5, 6],inf)*4+65),inf);
x = c.asStream;
Routine({
	loop({
			Synth("help-sinegrain", [\freq, x.next.midicps]);
			0.12.wait;
	})
}).play;
)



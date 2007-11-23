
Pfindur

superclass: FilterPattern

Pfindur(dur, pattern, tolerance)

embeds elements of the pattern into the stream until the duration comes close enough to dur.


(
var a, b;
a = Pfindur(5, Pbind(\dur, Prand([1, 2, 0.5, 0.1], inf)));
x = a.asStream;
9.do({ x.next(Event.default).postln; });
)


Pfindur used as a sequence of pitches


(
SynthDef("help-sinegrain",
	{ arg out=0, freq=440, sustain=0.05;
		var env;
		env = EnvGen.kr(Env.perc(0.01, sustain, 0.2), doneAction:2);
		Out.ar(out, SinOsc.ar(freq, 0, env))
	}).store;
)



(
var c;
c = Pbind(
	\dur, Prand([1, 0.02, 0.2], inf),
	\instrument, 'help-sinegrain',
	\degree, Pseries(0, 1, inf),
	\octave, 6
);

Pn(
	Pfindur(1, c)
).play;
)








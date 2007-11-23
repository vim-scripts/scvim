
Pfset					create an environment to modify values in the incoming stream

superclass: FuncFilterPattern

Pfset(name, value, pattern)





(
var a, b;
a = Pfset({
	~legato = 0.3;
	~detune = rrand(0, 30);
}, Pbind(\dur, 0.5));
x = a.asStream;
9.do({ x.next(Event.new).postln; });
)

Pfset does not override incoming values:


(
var a, b;
a = Pfset({
	~dur = 0.3;
}, Pbind(\dur, 0.5));
x = a.asStream;
9.do({ x.next(Event.new).postln; });
)


sound example

(
SynthDef(\sinegrain,
	{ arg out=0, freq=440, sustain=0.02;
		var env;
		env = EnvGen.kr(Env.perc(0.001, sustain), 1, doneAction:2);
		Out.ar(out, SinOsc.ar(freq, 0, env * 0.1))
	}).store;
)


(
a = Pbind(\dur, 0.5, \instrument, \sinegrain, \x, Pfunc { rrand(500, 600) });
a = Pfset({ ~freq = { ~x.postln * 2 }; ~legato = 3; }, a);
a.play;
)





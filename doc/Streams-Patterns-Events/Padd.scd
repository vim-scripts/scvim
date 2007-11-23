
Padd					event pattern that adds to existing value of one key

superclass: Pset

Padd(name, value, pattern)



(
var a, b;
a = Padd(\freq, 801, Pbind(\freq, 100));
x = a.asStream;
9.do({ x.next(Event.new).postln; });
)


value can be a pattern or a stream. the resulting stream ends when that incoming stream ends

(
var a, b;
a = Padd(\freq, Pseq([401, 801], 2), Pbind(\freq, 100));
x = a.asStream;
9.do({ x.next(Event.new).postln; });
)


sound example

(
SynthDef(\sinegrain,
	{ arg out=0, freq=440, gate=1;
		var env;
		env = EnvGen.kr(Env.asr(0.001, 1, 0.2), gate, doneAction:2);
		Out.ar(out, SinOsc.ar(freq, 0, env * 0.1))
	}).store;
)

(
a = Pbind(\dur, 0.5, \instrument, \sinegrain, \freq, 440);
b = Padd(\freq, Pseq([10, 30, 100], inf), a);
b.play;
)





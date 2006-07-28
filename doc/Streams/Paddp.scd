Paddp event pattern that adds with existing value of one key

superclass: Psetp

Paddp(name, value, pattern)

multiplies a value in an event stream until it ends, repeats this with new values until
the value stream ends.

value can be a pattern, a stream or an array. the resulting stream ends when that incoming stream ends.


(
var a, b;
a = Paddp(\freq, Pseq([2, 3, pi],inf), Pbind(\freq, Pseq([100, 200, 300])));
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
a = Pbind(\freq, Pseq([500, 600, 700]), \instrument, \sinegrain);
a = Paddp(\freq, Pseq([30, 90, -100], inf), a);
a.play;
)





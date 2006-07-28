Pconst constrain the sum of a value pattern 

superclass: FilterPattern

Pconst(sum, pattern, tolerance)

embeds elements of the pattern into the stream until the sum comes close enough to sum.
similar to Pfindur, but works with the value directly.


(
var a, b;
a = Pconst(5, Prand([1, 2, 0.5, 0.1], inf));
x = a.asStream;
9.do({ x.next(Event.default).postln; });
)


Pconst used as a sequence of pitches


(
SynthDef("help-sinegrain", 
 { arg out=0, freq=440, sustain=0.05;
 var env;
 env = EnvGen.kr(Env.perc(0.01, sustain, 0.2), doneAction:2);
 Out.ar(out, SinOsc.ar(freq, 0, env))
 }).store;
)

(
Pn(
 Pbind(
 \dur, Pconst(1, Prand([1, 0.02, 0.2], inf)), 
 \instrument, \help_sinegrain, 
 \degree, Pseries(0, 1, inf),
 \octave, 6
 )
).play;
)







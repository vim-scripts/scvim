
Rand

Rand(lo, hi)

Generates a single random float value in uniform distribution from lo to hi.
It generates this when the SynthDef first starts playing, and remains fixed for the duration of the synth's existence.


(
SynthDef("help-Rand", { arg out=0;
 Out.ar(out, 
 FSinOsc.ar(
 Rand(200.0, 400.0), 
 0, Line.kr(0.2, 0, 1, doneAction:2))
 )
}).send(s);
)

(
Routine({
 8.do({
 Synth.new("help-Rand"); 1.0.wait;
 })
}).play;
)
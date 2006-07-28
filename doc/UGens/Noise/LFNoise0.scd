
LFNoise0 step noise

LFNoise0.ar(freq, mul, add)

Generates random values at a rate given by the nearest integer division
of the sample rate by the freq argument. 
freq - approximate rate at which to generate random values.


(
SynthDef("help-LFNoise0", { arg out=0;
 Out.ar(out, 
 LFNoise0.ar(1000, 0.25)
 )
}).play;
)

//modulate frequency
(
SynthDef("help-LFNoise0", { arg out=0;
 Out.ar(out, 
 LFNoise0.ar(XLine.kr(1000, 10000, 10), 0.25)
 )
}).play;
)

//use as frequency control
(
SynthDef("help-LFNoise0", { arg out=0;
 Out.ar(out, 
 SinOsc.ar(
 LFNoise0.ar(4, 400, 450),
 0, 0.2
 )
 )
}).play;
)

SinOsc interpolating sine wavetable oscillator

SinOsc.ar(freq, phase, mul, add)

This is the same as Osc except that the table is a sine table of 8192 entries.
freq - frequency in Hertz
phase - phase offset or modulator in radians


SynthDef("help-SinOsc",{ arg out=0;
 Out.ar(out,
 SinOsc.ar(200, 0, 0.5)
 )
}).play;


// modulate freq
SynthDef("help-SinOsc",{ arg out=0;
 Out.ar(out,
 SinOsc.ar(XLine.kr(2000,200), 0, 0.5) 
 )
}).play;

// modulate freq
SynthDef("help-SinOsc",{ arg out=0;
 Out.ar(out,
 SinOsc.ar(SinOsc.ar(XLine.kr(1,1000,9),0,200,800), 0, 0.25)
 )
}).play; 


// modulate phase
SynthDef("help-SinOsc",{ arg out=0;
 Out.ar(out, 
 SinOsc.ar(800, SinOsc.ar(XLine.kr(20,8000,10),0,2pi), 0.25) 
 )
}).play; 


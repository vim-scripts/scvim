

PinkNoise

PinkNoise.ar(mul, add)

Generates noise whose spectrum falls off in power by 3 dB per octave.
This gives equal power over the span of each octave.
This version gives 8 octaves of pink noise.

(
SynthDef("help-PinkNoise", { arg out=0;
	Out.ar(out,
		PinkNoise.ar(0.4)
	)
}).play;
)



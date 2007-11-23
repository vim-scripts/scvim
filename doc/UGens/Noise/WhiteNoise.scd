

WhiteNoise

WhiteNoise.ar(mul, add)

Generates noise whose spectrum has equal power at all frequencies.


(
SynthDef("help-WhiteNoise", { arg out=0;
	Out.ar(out,
		WhiteNoise.ar(0.25)
	)
}).play;
)



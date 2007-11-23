
ExpRand

ExpRand(lo, hi)

Generates a single random float value in an exponential distributions from lo to hi.

(
SynthDef("help-ExpRand", { arg out=0, n=0;
	Out.ar(out,
		FSinOsc.ar(
			ExpRand(100.0, 8000.0, n),
			0, Line.kr(0.2, 0, 0.01, doneAction:2))
	)
}).send(s);
)

(
Routine({
	inf.do({ arg i;
		Synth.new("help-ExpRand"); 0.05.wait;
	})
}).play;
)



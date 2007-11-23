
LinRand

LinRand(lo, hi, minmax)

Generates a single random float value in linear distribution from lo to hi,
skewed towards lo if minmax < 0, otherwise skewed towards hi.


(
SynthDef("help-LinRand", { arg out=0, minmax=1;
	Out.ar(out,
		FSinOsc.ar(
			LinRand(200.0, 10000.0, minmax),
			0, Line.kr(0.2, 0, 0.01, doneAction:2))
	)
}).send(s);
)

//towards hi
(
Routine({
	loop({
		Synth.new("help-LinRand"); 0.04.wait;
	})
}).play;
)

//towards lo (doesn't work like that yet)
(
Routine({
	loop({
		Synth.new("help-LinRand", [\minmax, -1]); 0.04.wait;
	})
}).play;
)





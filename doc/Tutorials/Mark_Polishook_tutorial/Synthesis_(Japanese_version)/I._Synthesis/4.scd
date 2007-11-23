
4.



SuperColliderugen.ar

SinOsc.kr

ugen.ar

SinOsc.ar




.arugen44,100

SinOsc.ar(440, 0, 1);

.ar

Control rate



.krugenugenugen641

SinOsc.kr(440, 0, 1);

.kr

ugen

////////////////////////////////////////////////////////////////////////////////////////////////////

1UGenUGen

(
SynthDef("anExample", {
	Out.ar(
		0,
		SinOsc.ar(
			[440, 443] + SinOsc.kr([7, 8], 0, 7), // CPU
			0,
			0.2
		)
	)
}).load(s);
)

Synth("anExample")

SinOscSinOsc.kr([7, 8], 0, 7)SinOsc

////////////////////////////////////////////////////////////////////////////////////////////////////

ugen



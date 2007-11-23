
7.

1SynthDef ... 2SynthDef

SynthDefSynthDef

////////////////////////////////////////////////////////////////////////////////////////////////////

.scope

SynthDefSynthDef

.play.scope.scope

The .scope message ONLY works with the internal server - which means that the internal server must be turned on to use it. This can be done manually, by pressing the boot button on the internal server, or through code, as in

.scopeboot

Server.internal.boot;

////////////////////////////////////////////////////////////////////////////////////////////////////



(
{
	SinOsc.ar([440.067, 441.013], 0, 1)
	*
	SinOsc.ar([111, 109], 0, 0.2)
}.scope;
)

////////////////////////////////////////////////////////////////////////////////////////////////////

SnythDefOut

(
SynthDef("ringMod", {
	Out.ar(
		0,
		SinOsc.ar([440.067, 441.013], 0, 1) * SinOsc.ar([111, 109], 0, 0.2)
	)
}).load(s);
)

Synth("ringMod")
	
////////////////////////////////////////////////////////////////////////////////////////////////////



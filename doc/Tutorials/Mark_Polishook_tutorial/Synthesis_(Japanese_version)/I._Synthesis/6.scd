
6.

SynthDef

(
SynthDescLib.global.read;
SynthDescLib.global.browse;
)



////////////////////////////////////////////////////////////////////////////////////////////////////



SynthDef1SynthDef

////////////////////////////////////////////////////////////////////////////////////////////////////

SynthDef

(
// 2
SynthDef("withControls", { arg freq = 440, mul = 0.22;
	Out.ar(
		0,
		SinOsc.ar([freq, freq+1], 0, mul)
	)
}).load(s);
)

Synth("withControls", [\freq, 440, \mul, 0.1]);

SynthDef

////////////////////////////////////////////////////////////////////////////////////////////////////



Synth("withControls", [\freq, 440, \mul, 0.1]);



Synth("withControls", ["freq", 440, "mul", 0.1]);



////////////////////////////////////////////////////////////////////////////////////////////////////



[ controlName, value, controlName, value].



////////////////////////////////////////////////////////////////////////////////////////////////////



Synth("withControls", [0, 440, 1, 0.1]);



[ controlIndex, value, controlIndex, value].



////////////////////////////////////////////////////////////////////////////////////////////////////





(
SynthDef("resetMyControls", { arg freq = 440, mul = 0.22;
	Out.ar(
		0,
		SinOsc.ar([freq, freq+1], 0, mul)
	)
}).load(s);
)

~aSynth = Synth("resetMyControls", [\freq, 440, \mul, 0.06]);
~aSynth.set(\freq, 600, \mul, 0.25);

aSynth~

var aSynth; // '~'

~aSynthcurrentEnvironmentSuperColliderEnvironment

////////////////////////////////////////////////////////////////////////////////////////////////////

SynthDefugenGraphFunc

(
SynthDef("controlsWithLags", { arg freq = 440, mul = 0.22;
	Out.ar(
		0,
		SinOsc.ar([freq, freq+1], 0, mul)
	)
}, [1, 1]).load(s);
)

~aSynth = Synth("controlsWithLags", [\freq, 550, \mul, 0.1]);
~aSynth.set(\freq, 600, \mul, 0.5);

////////////////////////////////////////////////////////////////////////////////////////////////////

SynthDefSynthDef

// SynthDef
SynthDef(
	"i am a synthdef",					// 
	{ .... i am a ugenGraphFunc ... }	// ugenGraphFunc
)

// SynthDef
// 'rates'
SynthDef(
	"i am a synthdef",					// 
	{ .... i am a ugenGraphFunc ... },	// ugenGraphFunc
	[ ... lagTimes ... ]				// rates
)

SynthDef

////////////////////////////////////////////////////////////////////////////////////////////////////



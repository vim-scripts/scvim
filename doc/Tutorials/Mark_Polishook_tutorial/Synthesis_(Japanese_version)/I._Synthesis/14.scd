
14.



1980DX7FMFM

FM

(
SynthDef("fm1", { arg bus = 0, freq = 440, carPartial = 1, modPartial = 1, index = 3, mul = 0.05;

	// 024
	// carPartial :: modPartial => car/mod ratio
	
	var mod;
	var car;
	
	mod = SinOsc.ar(
		freq * modPartial,
		0,
		freq * index * LFNoise1.kr(5.reciprocal).abs
	);
		
	car = SinOsc.ar(
		(freq * carPartial) + mod,
		0,
		mul
	);
	
	Out.ar(
		bus,
		car
	)
}).load(s);
)

(
Synth("fm1", [\bus, 0, \freq, 440, \carPartial, 1, \modPartial, 2.4]);
Synth("fm1", [\bus, 1, \freq, 442, \carPartial, 1, \modPartial, 2.401]);
)

////////////////////////////////////////////////////////////////////////////////////////////////////



// SC2"01 Why SuperCollider document"
(
SynthDef("preDelay", { arg inbus = 2;
	Out.ar(
		4,
		DelayN.ar(In.ar(inbus, 1), 0.048, 0.048)
	)
}).load(s);

SynthDef("combs", {
	Out.ar(
		6,
		Mix.arFill(7, { CombL.ar(In.ar(4, 1), 0.1, LFNoise1.kr(Rand(0, 0.1), 0.04, 0.05), 15) })
	)
}).load(s);

SynthDef("allpass", { arg gain = 0.2;
	var source;
	source = In.ar(6, 1);
	4.do({ source = AllpassN.ar(source, 0.050, [Rand(0, 0.05), Rand(0, 0.05)], 1) });
	Out.ar(
		8,
		source * gain
	)
}).load(s);

SynthDef("theMixer", { arg gain = 1;
	Out.ar(
		0,
		Mix.ar([In.ar(2, 1), In.ar(8, 2)]) * gain
	)
}).load(s);
)

(
Synth("fm1", [\bus, 2, \freq, 440, \carPartial, 1, \modPartial, 1.99, \mul, 0.071]);
Synth("fm1", [\bus, 2, \freq, 442, \carPartial, 1, \modPartial, 2.401, \mul, 0.071]);
Synth.tail(s, "preDelay");
Synth.tail(s, "combs");
Synth.tail(s, "allpass");
Synth.tail(s, "theMixer", [\gain, 0.64]);
)

////////////////////////////////////////////////////////////////////////////////////////////////////



"fm"SynthDef1SynthDef1SynthDef22

(
SynthDef("carrier", { arg inbus = 2, outbus = 0, freq = 440, carPartial = 1, index = 3, mul = 0.2;

	// 024
	// carPartial :: modPartial => car/mod ratio
	
	var mod;
	var car;
	
	mod = In.ar(inbus, 1);

	Out.ar(
		outbus,
		SinOsc.ar((freq * carPartial) + mod, 0, mul);
	)
}).load(s);

SynthDef("modulator", { arg outbus = 2, freq, modPartial = 1, index = 3;
	Out.ar(
		outbus,
		SinOsc.ar(freq * modPartial, 0, freq)
		*
		LFNoise1.kr(Rand(3, 6).reciprocal).abs
		*
		index
	)
}).load(s);
)

(
var freq = 440;
// 
Synth.head(s, "modulator", [\outbus, 2, \freq, freq, \modPartial, 0.649, \index, 2]);
Synth.head(s, "modulator", [\outbus, 2, \freq, freq, \modPartial, 1.683, \index, 2.31]);

// 
Synth.head(s, "modulator", [\outbus, 4, \freq, freq, \modPartial, 0.729, \index, 1.43]);
Synth.head(s, "modulator", [\outbus, 4, \freq, freq, \modPartial, 2.19, \index, 1.76]);

// 
Synth.tail(s, "carrier", [\inbus, 2, \outbus, 0, \freq, freq, \carPartial, 1]);
Synth.tail(s, "carrier", [\inbus, 4, \outbus, 1, \freq, freq, \carPartial, 0.97]);
)

////////////////////////////////////////////////////////////////////////////////////////////////////



SynthDef

(
var freq;
// 
freq = 330.0.rrand(500);

// 
Synth.head(s, "modulator", [\outbus, 60, \freq, freq, \modPartial, 0.649, \index, 2]);
Synth.head(s, "modulator", [\outbus, 60, \freq, freq, \modPartial, 1.683, \index, 2.31]);

// 
Synth.head(s, "modulator", [\outbus, 62, \freq, freq, \modPartial, 1.11, \index, 1.43]);
Synth.head(s, "modulator", [\outbus, 62, \freq, freq, \modPartial, 0.729, \index, 1.76]);

// 
Synth.tail(s, "carrier", [\inbus, 60, \outbus, 100, \freq, freq, \carPartial, 1]);
Synth.tail(s, "carrier", [\inbus, 62, \outbus, 100, \freq, freq+1, \carPartial, 2.91]);

Synth.tail(s, "preDelay", [\inbus, 100]);
Synth.tail(s, "combs");
Synth.tail(s, "allpass");
Synth.tail(s, "theMixer", [\gain, 0.2]);
)

////////////////////////////////////////////////////////////////////////////////////////////////////



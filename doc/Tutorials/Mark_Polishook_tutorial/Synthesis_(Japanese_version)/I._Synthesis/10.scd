
10.





////////////////////////////////////////////////////////////////////////////////////////////////////

.dumpClassSubtreeFilterSuperCollider 3

Filter.dumpClassSubtree;



Filter
[
 DetectSilence
 Formlet
 Ringz
 SOS
 FOS
 Slew
 Median
 LPZ2
  [ BRZ2 BPZ2 HPZ2 ]
 Slope
 LPZ1
  [ HPZ1 ]
 MidEQ
 BPF
  [ BRF ]
 LPF
  [ HPF ]
 RLPF
  [ RHPF ]
 LeakDC
 Lag
  [ Ramp Lag3 Lag2 ]
 Decay2
 Decay
 Integrator
 TwoPole
  [ APF TwoZero ]
 OnePole
  [ OneZero ]
 Resonz
]

SuperColliderHelp/UGens/Filters

////////////////////////////////////////////////////////////////////////////////////////////////////

Object.dumpClassSubtree

Object.dumpClassSubtree;

SuperCollider

////////////////////////////////////////////////////////////////////////////////////////////////////

LPF

(
SynthDef("subtractive", {
	Out.ar(
		0,
		LPF.ar(
			Pulse.ar(440, 0.5, 0.1),	// 
			Line.kr(8000, 660, 6)		// Line
		)
	)
}).load(s);
)

Synth("subtractive")
		
////////////////////////////////////////////////////////////////////////////////////////////////////

RLFP

(
SynthDef("passLowFreqs2", {
	Out.ar(
		0,
		RLPF.ar(
			Saw.ar([220, 221] + LFNoise0.kr(1, 100, 200), 0.2),
			[LFNoise0.kr(4, 600, 2400), LFNoise0.kr(3, 600, 2400)],
			0.1
		)
	)
}).load(s);
)

Synth("passLowFreqs2")

////////////////////////////////////////////////////////////////////////////////////////////////////

Rezonz



(
SynthDef("noiseToPitch", { arg out = 0, mul = 1;
	Out.ar(
		out,
		Resonz.ar(
			WhiteNoise.ar(mul),
			LFNoise0.kr(4, 110, 660),
			[0.005, 0.005]
		)
	)
}).load(s);
)

(
// 
Synth("noiseToPitch", [\out, 0\mul, 1]);
Synth("noiseToPitch", [\out, 1, \mul, 1]);
)

////////////////////////////////////////////////////////////////////////////////////////////////////




11.

SynthDef

SynthDef

SuperCollidergroup

////////////////////////////////////////////////////////////////////////////////////////////////////

Group

groupSuperCollider

SuperCollider".head"".tail"



////////////////////////////////////////////////////////////////////////////////////////////////////







  Group (RootNode, ID 0)
   /
  /
Synth (ID 1000)



(
SynthDef("ringModulation", {
	Out.ar(
		0,
		Mix.ar(
			SinOsc.ar([440.067, 441.013], 0, 1)
			*
			SinOsc.ar([111, 109], 0, 0.2)
		)
	)
}).load(s);
)

Synth("ringModulation");




////////////////////////////////////////////////////////////////////////////////////////////////////



  Group (RootNode, ID 0)
   /\
  / \
Synth  Synth
(ID 1000)  (ID 1001)



(
SynthDef("pitchFromNoise", { arg out = 0;
	Out.ar(
		out,
		Resonz.ar(
			WhiteNoise.ar(15),
			LFNoise0.kr(2, 110, 660),
			0.005
		)
	)
}).load(s);
)


(
Synth("ringModulation");
Synth("pitchFromNoise", [\out, 1]);
)




////////////////////////////////////////////////////////////////////////////////////////////////////



(
SynthDef("firstNode-source", {
	Out.ar(
		0,
		Saw.ar([200, 201], 0.05)
	)
}).load(s);

SynthDef("secondNode-filter", {
	ReplaceOut.ar(
		0,
		LPF.ar(
			In.ar(0, 2),
			Lag.kr(
				LFNoise0.kr([4, 4.001], 500, 1000),
				0.1
			)
		)
	)
}).load(s);
)

// "firstNode-source"
//  "secondNode-filter""firstNode-source"
(
Synth("firstNode-source");
Synth("secondNode-filter")
)

////////////////////////////////////////////////////////////////////////////////////////////////////



(
Synth.head(s, "firstNode-source");
Synth.tail(s, "secondNode-filter")
)

.head.tail"firstNode-source""secondNode-filter"

"firstNode-source"1"secondNode-filter"2

(
Synth.tail(s, "secondNode-filter");
Synth.head(s, "firstNode-source");
)

////////////////////////////////////////////////////////////////////////////////////////////////////



  Group (RootNode, ID 0)
   /\
  / \
Group  Group
 |    |
 |    |
Synth 	 Synth

(
~source = Group.head(s);	// 
~effect = Group.tail(s);	// 
)

(
// 
Synth.head(~effect, "secondNode-filter");
Synth.head(~source, "firstNode-source");
)



////////////////////////////////////////////////////////////////////////////////////////////////////



// SynthDefmul
(
// 3SynthDef
SynthDef("synthNumber1", { arg mul = 0.2;
	Out.ar(
		0,
		BrownNoise.ar(mul) * LFNoise0.kr([1, 1.01])
	)
	}, [0.1]).load(s);
SynthDef("synthNumber2", { arg mul = 0.2;
	Out.ar(
		0,
		WhiteNoise.ar(mul) * LFNoise1.kr([2.99, 3])
	)
	}, [0.1]).load(s);
SynthDef("synthNumber3", { arg mul = 0.2;
	Out.ar(
		0,
		PinkNoise.ar(mul) * LFNoise2.kr([0.79, 0.67])
	)
}, [0.1]).load(s);
)

(
// 
~myGroup = Group.new;
)

(
// 3
Synth.head(~myGroup, "synthNumber1");
Synth.head(~myGroup, "synthNumber2");
Synth.head(~myGroup, "synthNumber3");
)

// 3\mul
~myGroup.set(\mul, 0.05)

////////////////////////////////////////////////////////////////////////////////////////////////////



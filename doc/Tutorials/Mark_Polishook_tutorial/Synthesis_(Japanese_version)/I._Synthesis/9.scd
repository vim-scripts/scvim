
9.

2

1UGen2

2



	OBJECT OPERATOR OPERAND





	2 * 3

2

UGen2SuperColliderHelp/BinaryOps

////////////////////////////////////////////////////////////////////////////////////////////////////



2UGen

(
	// 2
	{
		Saw.ar(500, 0.05)				// 
		+							// 
		Saw.ar(600, 0.06)				// 
	}.scope;
)

1BinaryOpUGen

////////////////////////////////////////////////////////////////////////////////////////////////////

3UGen2UGen1BinarOpUGen1UGen1BinaryOpUGen

(
{
	// 2UGen1BinaryOpUGen
	Saw.ar(500, 0.05)
	+
	Saw.ar(600, 0.06)
	+
	// UGenBinaryOpUGen+
	Saw.ar(700, 0.07)
}.scope;
)

////////////////////////////////////////////////////////////////////////////////////////////////////

MixUGen

(
{
	// UGen
	Mix.ar(
		[
			Saw.ar(500, 0.05),
			Saw.ar(600, 0.06),
			Saw.ar(700, 0.06)
		]
	)
}.scope
)

////////////////////////////////////////////////////////////////////////////////////////////////////

Mix.arFilli1i0213

{ Mix.arFill(3, { arg i; Saw.ar(500 + ((i+1) * 100), 0.05) }) }.scope;

////////////////////////////////////////////////////////////////////////////////////////////////////



WhiteNoise1UGenUGen

{ WhiteNoise.ar(0.1) * SinOsc.kr(1, 1) }.scope;

2UgenBinaryOpUGenBinaryOpUGen

(
	// ... 
	{
		(WhiteNoise.ar(0.1) * SinOsc.kr(1, 1))
		+
		(BrownNoise.ar(0.1) * SinOsc.kr(2, 1))
	}.scope;
)

////////////////////////////////////////////////////////////////////////////////////////////////////



UGen

// 
{ SinOsc.ar(440, 0, 0.1) * EnvGen.kr(Env.sine(1), doneAction: 2) }.scope;

doneAction2SuperColliderSinOscEnvGen:



////////////////////////////////////////////////////////////////////////////////////////////////////

EnvGentimeScale

(
SynthDef("timeScale", { arg ts = 1;
	Out.ar(
		0,
		SinOsc.ar(440, 0, 0.4) * EnvGen.kr(Env.sine(1), doneAction: 2, timeScale: ts)
	)
}).load(s);
)

Synth("timeScale", [\ts, 0.1]); // timeScale

////////////////////////////////////////////////////////////////////////////////////////////////////

// ... 
(
r = Routine({
	loop({
		Synth("timeScale", [\ts, 0.01.rrand(0.3)]);
		0.5.wait;
	})
});
)
r.play

////////////////////////////////////////////////////////////////////////////////////////////////////





(
{	// 12
	var n = 12;
	Mix.arFill(
		n,
		{
			SinOsc.ar(
				[67.0.rrand(2000), 67.0.rrand(2000)],
				0,
				n.reciprocal * 0.75
			)
		}
	)
	*
	EnvGen.kr(Env.perc(11, 6), doneAction: 2)
}.scope
)

////////////////////////////////////////////////////////////////////////////////////////////////////









(
{	var n = 12;
	
	Mix.arFill(
			n,									// n
			{
			SinOsc.ar(							// low.rrand(high)
				[67.0.rrand(2000), 67.0.rrand(2000)],	// ... 
				0,
				n.reciprocal						// 
												// n
			)
			*
			EnvGen.kr(							// 
				Env.sine(2.0.rrand(17)),
				doneAction: 0 					// 
												// 
			)
		}
	)
	*											// 
	EnvGen.kr(
		Env.perc(11, 6),
		doneAction: 2,
		levelScale: 0.75
	)
												
}.scope
)

Klang ugen

////////////////////////////////////////////////////////////////////////////////////////////////////



2UGen

// LFO
{ SinOsc.ar(440, 0, 0.571) * SinOsc.kr(2.reciprocal) }.scope

// LFO
{ SinOsc.ar(440, 0, 0.571) * SinOsc.kr(880) }.scope

// lfo
(
	{
		SinOsc.ar(440, 0, 0.571)
		*
		(SinOsc.kr(880)					// lfo
		* 								// 
		SinOsc.kr([6.99, 8.01].reciprocal)
		)
	}.scope
)

////////////////////////////////////////////////////////////////////////////////////////////////////



2UGenCharles Dodge

UGen.abs

// lfo
{ SinOsc.ar(440, 0, 0.571) * SinOsc.kr(2.reciprocal).abs }.scope

// lfo
(
	{
		SinOsc.ar(440, 0, 0.571)
		*
		(SinOsc.kr(880).abs				// lfo
		* 								// 
		SinOsc.kr([6.99, 8.01].reciprocal)
		)
	}.scope
)

////////////////////////////////////////////////////////////////////////////////////////////////////



// lfo.abs
{ SinOsc.ar(440, 0, 0.571) * SinOsc.kr(880).abs }.scope

// .abs
// ... 
{ SinOsc.ar(440, 0, 0.571) * SinOsc.kr(880) }.scope

////////////////////////////////////////////////////////////////////////////////////////////////////



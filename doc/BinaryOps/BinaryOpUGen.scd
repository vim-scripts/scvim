
BinaryOpUGen

superclass: UGen

BinaryOpUGens are created as the result of a binary operator applied to a UGen.

(SinOsc.ar(200) * ClipNoise.ar).dump;
(SinOsc.ar(200).thresh(0.5)).dump;

The use of the binary operators * and thresh above each instantiate a BinaryOpUGen. Do not confuse the operators themselves (which are methods) with the resulting BinaryOpUGen, which is an object. When applied to other classes they may not return new objects, and can behave in a more straightforward manner. See for example SimpleNumber.

There are helpfiles for each the different operators, listed below.

The operators >, >=, <, and <= are particularly useful for triggering. They should not be confused with their use in conditionals. Compare

(1 > 0).if({"1 is greater than 0".postln}); // > returns a boolean

with

( // trigger an envelope
{
	var trig;
	trig = SinOsc.ar(1) > 0.1;
	Out.ar(0,
		EnvGen.kr(Env.perc, trig, doneAction: 0)
			* SinOsc.ar(440,0,0.1)
	)
}.play(s);) // > outputs 0 or 1

See the individual helpfiles for more detail.

The following operators have their own helpfiles:

+ - * / ** absdif amclip atan2 clip2 difsqr excess fold2 hypot hypotApx max min ring1 ring2 ring3 ring4 round scaleneg sqrdif sqrsum sumsqr thresh trunc wrap2



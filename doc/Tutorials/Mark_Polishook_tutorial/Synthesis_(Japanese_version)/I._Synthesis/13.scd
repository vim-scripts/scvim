
13.



DelayCombAlpassUGen

////////////////////////////////////////////////////////////////////////////////////////////////////

// 2SynthDef1SynthDef2SynthDef
// SynthDef
// SynthDef
(
SynthDef("someGrains", { arg centerFreq = 777, freqDev = 200, grainFreq = 2;
	var gate;
	gate = Impulse.kr(grainFreq);
	Out.ar(
		0,
		SinOsc.ar(
			LFNoise0.kr(4, freqDev, centerFreq),
			0,
			EnvGen.kr(Env.sine(0.1), gate, 0.1)
		)
	)
}).load(s);

SynthDef("aDelay", { arg delay = 0.25;
	Out.ar(
		1,
		DelayN.ar(
			In.ar(0, 1),
			delay,
			delay
		)
	)
}).load(s);
)

//  ... 
//  ... 
Synth("someGrains");


// 12
(
~source = Group.head(s);
~effects = Group.tail(s);
)

//  ... 
(
Synth.head(~source, "someGrains");
Synth.head(~effects, "aDelay");
)

////////////////////////////////////////////////////////////////////////////////////////////////////
	


CombAllpassUGenAllpassCombAllpassUGen

// 
// CombAllpass
(
{
	CombN.ar(
		SinOsc.ar(500.rrand(1000), 0, 0.2) * Line.kr(1, 0, 0.1),
		0.3,
		0.25,
		6
	)
}.scope;
)

// 
(
{
	AllpassN.ar(
		SinOsc.ar(500.rrand(1000), 0, 0.2) * Line.kr(1, 0, 0.1),
		0.3,
		0.25,
		6
	)
}.scope;
)

// CombAllpass
//  ... 0.1
(
{
	CombN.ar(
		SinOsc.ar(500.rrand(1000), 0, 0.2) * Line.kr(1, 0, 0.1),
		0.1,
		0.025,
		6
	)
}.scope;	
)

// allpasscomb
(
{
	AllpassN.ar(
		SinOsc.ar(500.rrand(1000), 0, 0.2) * Line.kr(1, 0, 0.1),
		0.1,
		0.025,
		6
	)
}.scope
)

////////////////////////////////////////////////////////////////////////////////////////////////////



James McCartney.play.scopeSuperCollider 201 Why SuperCollider

SchroederCombAllpass

(
{
var s, z, y;
	// 10
s = Mix.ar(Array.fill(10, { Resonz.ar(Dust.ar(0.2, 50), 200 + 3000.0.rand, 0.003)}) );
	// 
z = DelayN.ar(s, 0.048);
	// 7comb
y = Mix.ar(Array.fill(7,{ CombL.ar(z, 0.1, LFNoise1.kr(0.1.rand, 0.04, 0.05), 15) }));
	// 4allpass8
4.do({ y = AllpassN.ar(y, 0.050, [0.050.rand, 0.050.rand], 1) });
	// 
s+(0.2*y)
}.scope
)

////////////////////////////////////////////////////////////////////////////////////////////////////



01 Why SuperCollider"combs"SynthDef"allpass"SynthDef

SynthDef



(
SynthDef("filteredDust", {
	Out.ar(
		2,
		Mix.arFill(10, { Resonz.ar(Dust.ar(0.2, 50), Rand(200, 3200), 0.003) })
	)
}).load(s);

SynthDef("preDelay", {
	Out.ar(
		4,
		DelayN.ar(In.ar(2, 1), 0.048, 0.048)
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
		
// "filteredDust"
// "theMixer"
(
Synth.tail(s, "filteredDust");
Synth.tail(s, "preDelay");
Synth.tail(s, "combs");
Synth.tail(s, "allpass");
Synth.tail(s, "theMixer");
)

////////////////////////////////////////////////////////////////////////////////////////////////////



(
~source = Group.tail(s);
~proc1 = Group.tail(s);
~proc2 = Group.tail(s);
~proc3 = Group.tail(s);
~final = Group.tail(s);
)

// 
// 
(
Synth.head(~final, "theMixer");
Synth.head(~proc3, "allpass");
Synth.head(~proc2, "combs");
Synth.head(~proc1, "preDelay");
Synth.head(~source, "filteredDust");
)



////////////////////////////////////////////////////////////////////////////////////////////////////

SuperCollider 2James McCarthey01 Why SuperCollider

////////////////////////////////////////////////////////////////////////////////////////////////////

 	SuperCollider 2.0

Why SuperCollider 2.0 ?

SuperCollider version 2.0 is a new programming language. Why invent a new language
and not use an existing language? Computer music composition is a specification problem.
Both sound synthesis and the composition of sounds are complex problems and demand a
language which is highly expressive in order to deal with that complexity. Real time signal
processing is a problem demanding an efficient implementation with bounded time operations.
There was no language combining the features I wanted and needed for doing digital music
synthesis. The SuperCollider language is most like Smalltalk. Everything is an object. It has
class objects, methods, dynamic typing, full closures, default arguments, variable
length argument lists, multiple assignment, etc. The implementation provides fast,
constant time method lookup, real time garbage collection, and stack allocation of most
function contexts while maintaining full closure semantics.
The SuperCollider virtual machine is designed so that it can be run at interrupt level.
There was no other language readily available that was high level, real time and
capable of running at interrupt level.

SuperCollider version 1.0 was completely rewritten to make it both more expressive
and more efficient. This required rethinking the implementation in light of the experience
of the first version. It is my opinion that the new version has benefitted significantly
from this rethink. It is not simply version 1.0 with more features.

Why use a text based language rather than a graphical language?
There are at least two answers to this. Dynamism: Most graphical synthesis environments
use statically allocated unit generators. In SuperCollider, the user can create structures which
spawn events dynamically and in a nested fashion. Patches can be built dynamically and
parameterized not just by floating point numbers from a static score, but by other
graphs of unit generators as well. Or you can construct patches algorithmically on the fly.
This kind of fluidity is not possible in a language with statically allocated unit generators.
Brevity: In SuperCollider, symmetries in a patch can be exploited by either multichannel
expansion or programmatic patch building. For example, the following short program
generates a patch of 49 unit generators. In a graphical program this might require a significant
amount of time and space to wire up. Another advantage is that the size of the patch below can
be easily expanded or contracted just by changing a few constants.

(
{
	// 10 voices of a random sine percussion sound :
s = Mix.ar(Array.fill(10, { Resonz.ar(Dust.ar(0.2, 50), 200 + 3000.0.rand, 0.003)}) );
	// reverb predelay time :
z = DelayN.ar(s, 0.048);
	// 7 length modulated comb delays in parallel :
y = Mix.ar(Array.fill(7,{ CombL.ar(z, 0.1, LFNoise1.kr(0.1.rand, 0.04, 0.05), 15) }));
	// two parallel chains of 4 allpass delays (8 total) :
4.do({ y = AllpassN.ar(y, 0.050, [0.050.rand, 0.050.rand], 1) });
	// add original sound to reverb and play it :
s+(0.2*y)
}.play )

Graphical synthesis environments are becoming a dime a dozen. It seems like a new one
is announced every month. None of them have the dynamic flexibility of SuperCollider's
complete programming environment. Look through the SuperCollider help files and examples
and see for yourself.



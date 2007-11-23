
15.



SuperCollider







// .value
f = { "hello, world" };
f.value;

.yield

r = Routine({ "hello, world".yield.postln });



// .next
r.next;



r.next;

"yield"reset

r.reset;
r.next

////////////////////////////////////////////////////////////////////////////////////////////////////

.nextnextnext

(
r = Routine({
	"hello, world".yield;
	"what a world".yield;
	"i am a world".yield;
});
)

.nextnilnil

r.next;
r.next;
r.next;
r.next;

////////////////////////////////////////////////////////////////////////////////////////////////////

.doloop

(
r = Routine({

	var array;
	array = [ "hello, world", "what a world", "i am a world" ];

	3.do({ array.choose.yield })
	
});
)

do loop1nil

4.do({ r.next.postln });

////////////////////////////////////////////////////////////////////////////////////////////////////

.wait.wait

(
r = Routine({

	var array;
	array = [ "hello, world", "what a world", "i am a world" ];

	3.do({ 1.wait; array.choose.postln })
	
});
)

.reset

SuperCollider

SystemClock.play(r.reset);		// 
AppClock.play(r.reset);			// GUI
TempoClock.new.play(r.reset);	// 

////////////////////////////////////////////////////////////////////////////////////////////////////

TempoClock

r.reset.play

////////////////////////////////////////////////////////////////////////////////////////////////////



SynthDefdoneAction

(
SynthDef("fm2", {
	arg bus = 0, freq = 440, carPartial = 1, modPartial = 1, index = 3, mul = 0.2, ts = 1;

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
		car * EnvGen.kr(Env.sine(1), doneAction: 2, timeScale: ts)
	)
}).load(s);
)

(
r = Routine({

	12.do({
		Synth("fm2", [\freq, 400.0.rrand(1200), \carPartial, 0.5.rrand(2), \ts, 0.1.rrand(4)]);
		2.wait;
	})
});
)
r.reset.play;

////////////////////////////////////////////////////////////////////////////////////////////////////



(
SynthDef("echoplex", {
	ReplaceOut.ar(
		0,
		CombN.ar(
			In.ar(0, 1),
			0.35,
			[Rand(0.05, 0.3), Rand(0.05, 0.3)],
			// 
			7,
			0.5
		)
	)
}).load(s);

// ~source~effects
~source = Group.head(s);
~effect = Group.tail(s);

r = Routine({

	// inf.do
	loop({
		Synth.head(	// ~source
			~source,
			"fm2",
			[
				\outbus, 0, \freq, 400.0.rrand(1200), \modPartial, 0.3.rrand(2.0),
				\carPartial, 0.5.rrand(11), \ts, 0.1.rrand(0.2)]
		);
		2.wait;
	})
});
// 2echoplexes~effects
Synth.head(~effect, "echoplex");
Synth.head(~effect, "echoplex");
)
// 
r.reset.play;

////////////////////////////////////////////////////////////////////////////////////////////////////



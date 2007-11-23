
Pstep

superclass: Pattern
related: Pseg

Pstep(levelpattern, durpattern)

Levelpattern can return either individual values or arrays. The value returned by levelpattern is
returned for the duration returned by durpattern.

Pstep is good for representing chord progressions, scale progressions, accent patterns, etc.


s.boot;


// change degree independant of number of events that have been playing

(
Pbindf(
	Ppar([
		Pbind(
			\degree, Pbrown(0,12,1),
			\dur, Pstep( Pseq([0.1,0.2,0.4,0.8,1.6],inf),3.2)
		),	
		Pbind(
			\degree, Pbrown(0,20,1),
			\dur, Pstep( Pseq([0.1,0.2,0.4,0.8,1.6],inf),4.5)
		)
	]),
	\scale, Pstep(Pseq([ [0,2,4,5,7,9,11], [0,1,2,3,4,5,6]], inf), 5),
	\db,Pstep(Pseq([4,-4,0,-4],inf),0.25) + Pwhite(-20, -15)
).play;
)






// change one parameter
(
Pbind(
	\degree, Pstep(Pseq([1, 2, 3, 4, 5]), 1.0).trace,
	\dur, Pseries(0.1, 0.1, 15)
).play;
)


// change degree independant of number of events that have been playing

(
var a, b;
a = Pbind(
	\degree, Pstep(Pseq([0, 2b, 3],1), 1.0),
	\dur, Prand([0.2, 0.5, 1.1, 0.25, 0.15], inf)
);
b = Pbind(
	\degree, Pseq([0, 2b, 3], 1),
	\dur, 2,
	\ctranspose, -7
);
Pseq([Event.silent(1.25), Ppar([a, b])], inf).play;
)



// test tempo changes

(
var a, b;
a = Pbind(
	\degree, Pstep(Pseq([0, 2b, 3],1), 1.0),
	\dur, Prand([0.2, 0.5, 1.1, 0.25, 0.15], 9)
);
b = Pbind(
	\degree, Pseq([0, 2b, 3], 1),
	\dur, 2,
	\ctranspose, -7
);

Ppar([a, b], inf).play;
)


SystemClock.sched(0, { TempoClock.default.tempo = [1, 2, 3, 5].choose.postln; 2 });

TempoClock.default.tempo = 1.0;



// timing test:
// parallel streams


(

var times, levels;


SynthDef("pgrain",
	{ arg out = 0, freq=800, sustain=0.001, amp=0.5, pan = 0;
		var window;
		window = Env.sine(sustain, amp);
		Out.ar(out,
			Pan2.ar(
				SinOsc.ar(freq) * EnvGen.ar(window, doneAction:2),
				pan
			)
		)
	}
).store;


times = Pseq([3.4, 1, 0.2, 0.2, 0.2], inf);
levels = Pseq([0, 1, 2, 3, 4], inf);

a = Pstep(levels, times);
b = Pbind(\instrument, \pgrain, \octave, 7, \dur, 0.12, \degree, a);
x = times;

Ppar([b, Pset(\mtranspose, 2, b) ]).play;



b.play;
r {
	var z = x.asStream; // direct times
	loop {
		z.next.wait;
		s.makeBundle(0.2, {
			Synth(\pgrain, [\freq, 3000, \sustain, 0.01]); // signal tone
		})
		
	}
}.play(quant:1)
)







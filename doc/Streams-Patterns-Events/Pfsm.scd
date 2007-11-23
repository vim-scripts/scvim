
Pfsm

superclass: ListPatterns

finite state machine: every state links to possible next states (indices).
starting from one of the entry states one of these links is randomly
chosen used to get the next state. When an end state is reached, the stream ends.


Pfsm(list,repeats)

list:
	[
		 [ entry states ],
	 	item, [ next states ],
	 	item, [ next states ],
		 ...
	 	end item (or nil), nil
	 ]


next states: nil is terminal


(
SynthDef("help-sinegrain",
	{ arg out=0, freq=440, sustain=0.05;
		var env;
		env = EnvGen.kr(Env.perc(0.01, sustain, 0.2), doneAction:2);
		Out.ar(out, SinOsc.ar(freq, 0, env))
	}).store;
)


(
a = Pfsm([
		#[0,1],
		67, #[0, 0, 3],
		72, #[2],
		73, #[0, 2],
		Pseq([74, 75, 76, 77]), #[2, 3, 3],
		nil, nil
		], inf).asStream;
Routine({
	loop({
	Synth("help-sinegrain", [\freq, a.next.midicps]);
	0.1.wait;
	})
}).play;
)

(
Pfsm([
#[5, 6, 7], // entry states

//e1 (== state 0)
Pbind( \dur, Pseq([ 1/8, 3/8 ]), \midinote, Pseq([ 86, 75 ]) ),
//#[1], // as given in CMJ
// my de-boredom-ated version..
#[1, 1, 1, 1, 1, 1, 1, 8],
//e2 (== state 1)
Pbind( \dur, 1/2, \midinote, Pseq([ 69 ]) ),
#[0, 1],
//e3 (== state 2)
Pbind( \dur, 1/3, \midinote, Pseq([ 55, 60, 66 ]) ),
#[0, 1, 2, 2, 2, 2, 3, 3, 3, 3],
//e4 (== state 3)
Pbind( \dur, 1/4, \midinote, Pseq([ 81, 80, 77, 76 ]) ),
#[1, 4, 4, 4, 4],
//e5 (== state 4)
Pbind( \dur, Pseq([1, 2/3, 2/3, 2/3, 1]), \midinote, Pseq([ \, 70, 70, 70, \ ]) ),
#[2, 3],
//e6 (== state 5)
Pbind( \dur, 1/4, \midinote, Pseq([ 59, 61 ]) ),
#[0, 2, 4, 5, 5, 5, 5, 5, 5, 5],
//e7 (== state 6)
Pbind( \dur, 1/4, \midinote, Pseq([ 87, 88 ], 2) ),
#[4, 4, 4, 4, 6, 6, 6, 7, 7, 7],
//e8 (== state 7)
Pbind( \dur, 1, \midinote, Pseq([ 56 ]) ),
#[1, 3, 6, 6, 6],
// terminal state
nil, nil
]).play;
)



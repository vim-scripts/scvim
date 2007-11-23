
Pdfsm				deterministic finite state machine

by ccos

superclass: ListPattern




deterministic finite state machine with signal input.

list - 			a list consisting of the stream which gives input signals to determine state
			transitions, and then dictionary entries, one for each state, mapping the destinattion
			state and yield streams to those input signals.
startState -	 an integer index for the state to start with. defaults to 0.
repeats - 		an integer giving the number of times the pattern should cycle.
			a cycle ends when the signal stream ends or nil is given for the destination
			state to a signal value, see below. defaults to 1

more on the list -

	[
		signal stream - can be a stream of anything which can serve as a key for
					an associative collection. integers, symbols, etc...
					asStream is called on this for each repeat.
		states - 		states should be IdentityDictionaries or some other associative collection
	]

list syntax	-

	[	
		signal stream,	
		( // state 0,
		 	signal value : [destination state, return stream or pattern],
		 	signal value : [destination state, return stream or pattern]
		 ),
		 ... // state 1 ... N
	]
	
any number of states can be given, and are indexed by the order in which they are given.
if the fsm is in state x and it receives a signal value y it looks up y in the state dictionary
supplied for x, if there is no y entry, it looks for a \default entry and uses that.
the next state is then set to destination state, and the stream yielded is given by return stream or pattern.
that is unless the destination state is given as nil, or if a destination state is given for which you have not
supplied a dictionary - in both cases the current cycle ends and any remaining repeats are executed.
if there is no signal value given for a particular signal, and no \default is supplied then upi will get a runtime error.

(
	p = Pdfsm(
		[
			Pseq( [\foo,\bar], 2 ), // foobar signals	
			( // state 0
				\foo : [ 1, Pseq([ 0, 1 ], 2 ) ]
			),
			( // state 1
				\bar : [ 0, 3 ]
			)
		],
		0, 
		2
	).asStream;
	
	11.do({ p.next.postln });
)

(
SynthDef('Help-Pdfsm1',
	{ arg out=0, freq=440, sustain=0.05;
		var env;
		env = EnvGen.kr(Env.perc(0.01, sustain, 0.2), doneAction:2);
		Out.ar(out, SinOsc.ar([freq, freq + 0.1.rand2], 0, env))
	}).send(s);
)

(
var p;
p = Pdfsm(
	[
		Prand([0,1,2],inf), 	// signalStream
	
		IdentityDictionary[ 	// state 0
			0 -> [ 2, Pseq([67,68,69], 2) ],
			1 -> [ 0, 66 ],
			2 -> [ 1, 65 ]
		],
		IdentityDictionary[ 	// state 1
			1 -> [ 1, Pseq([69,68,67],2) ],
			\default -> [ 0, 70 ]
		],
		IdentityDictionary[
			0 -> [ 0, 71 ],
			1 -> [ 0, 72 ],
			2 -> [ nil ] // signalStream is infinitely long,
						// so the fsm only ends because of this nil
						// 2 -> [nil, nil] is also fine
		]
	],
	1, 					// startState
	1 					// repeats
).asStream;

Routine({
	var freq;
	while({ (freq = p.next.postln).notNil },{
		Synth('Help-Pdfsm1', [ \freq, freq.midicps ]);
		0.1.wait;
	})
}).play;
)

(
SynthDef('Help-Pdfsm2',
	{ arg freq, gate=1;
		var n=8, env, osc;
		env = Linen.kr( gate, 0.01, 1, 0.03, 2 );
		osc = {Mix.fill( n, { arg i;
			FSinOsc.ar(freq + Rand(-2.0,2.0), Rand(0, 0.05pi)) ring4:
			FSinOsc.ar(freq * (i+1));
		})}.dup * FSinOsc.kr(Rand(1.5,4.5),{Rand(-0.1pi,0.1pi)}.dup,0.6,env*0.4);
		Out.ar(0, env * osc / (n*4) )
	}).load(s);
	SynthDescLib.global.read; // needed for the Pbinds below
)

(
var n=3, base, penult;

base = [3,4,4,0];

for( 1, n, { arg i;
	penult = Pbind( \degree, Pshuf(base - (i*5), 2), \dur, Pseq([0.2],2) );
	Pset(
		\instrument, 'Help-Pdfsm2',
		Pdfsm(
			[
				Pseq([	// signalStream
					Pn(1,22 + i),
					Pn(0,4),
					Pn(1,8),
					Pseq([						
						Pn(0,3),
						Prand([0,1],8),
						Pn(1,8)
					], 3 ),
					Pn(2,2)
				], 1 ),
				(		// state 0
					0 : [ 0, Pbind( \degree, Pseq(base - i, 1), \dur, Pxrand([0.2,0.3],4) ) ],
					1 : [ 1, Pbind( \degree, Pseq(base.reverse - (i*2), 2), \dur, Pseq([0.2,0.21],1) ) ],
					2 :	[ 2, penult ]
				),
				(		// state 1
					0 : [ 0, Pbind( \degree, Pshuf(base * i.neg, 8), \dur, Pseq([0.08],8) ) ],
					1 : [ 0, Pbind( \degree, Pseq(base - (i*3),3+i), \dur, Pseq([0.11],3+i) ) ],
					2 : [ 2, penult ]
				),
				(		// state 2
					\default : [ 2, Pbind( \degree, Prand(base - (i*7), 5), \dur, Prand([0.6,0.8],5) ) ]
				)
			],
			i%2 		// startState
		)
	).play;
})
)



